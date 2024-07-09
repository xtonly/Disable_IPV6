    #!/bin/bash

    # 检查是否是以 root 身份执行脚本
    if [ "$(id -u)" -ne 0 ]; then
        echo "这个脚本需要以 root 权限执行，请使用 sudo 或以 root 用户执行此脚本。"
        exit 1
    fi

    # 备份现有的 sysctl.conf 文件
    cp /etc/sysctl.conf /etc/sysctl.conf.bak

    # 禁用 IPv6
    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

    # 应用新的 sysctl 配置
    sysctl -p

    # 验证禁用状态
    if [ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)" -eq 1 ] && [ "$(cat /proc/sys/net/ipv6/conf/default/disable_ipv6)" -eq 1 ]; then
        echo "IPv6 已成功禁用。"
    else
        echo "IPv6 禁用失败，请检查配置文件。"
    fi
