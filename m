Return-Path: <linux-kernel+bounces-6462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BF819952
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC77287772
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBD168CF;
	Wed, 20 Dec 2023 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dVWzpKfl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F616434
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e784ce9bb8so3998417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703056782; x=1703661582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tceAuTrKgh4yz/cZd46EzsUJGc+SbSGvfh48i9ZOxvk=;
        b=dVWzpKflcS05EQM4uGwGoc67gyWIxchHtdg+PGyixoXKfzCZ2O3cpGrfyTDpWRS/wh
         1ZpGINyGUHzCTRThPI+3yd1GJHzYFbx34kLTolpRhZudTUAbRvLHeVWVUHofflYkEC5X
         uZoi1Txe44tCGN/WGFq75MtnCcmM/ZlAwP4cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056782; x=1703661582;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tceAuTrKgh4yz/cZd46EzsUJGc+SbSGvfh48i9ZOxvk=;
        b=V/gumTOQ8Kz6If/lv5sldLJLHfHlZlnVHPq+c4mICYj7wgLUotbB0FfNr6mUsFjTHa
         TwQaXJDW8fFS04lGckug6Sp4DkM3gpJxm8cn+++bnEy8C2mtjHpn9MUHtRXyljwQM8ng
         zlxJIJmWHFRbjpSWYAqRXecYsoSHmYy1b2ztun0qjtop5leL8RA7guhzcyRpoFwZef5+
         RrYOSnhEhdVdFGv2jU29ee3EBoJEKDibASpwiwng1K/PMQ7swrMhkbGbGbZEd1gPLIc7
         KMjbsOqniWfZdTfArQnaSurSkHx92062DFvOLbVka0wBpzbzV46IiHrP0ws0iuTqoJL5
         8bkA==
X-Gm-Message-State: AOJu0YzxIFQkftvotP1/kKtjlAVF+1iy3jxwepn23sOxtcYi5RStPEVe
	8DNaOhGTV9V44O7zNWHxm8Oq3bGdm5Sv8BOh2EkwVJ9qD1n7BQ==
X-Google-Smtp-Source: AGHT+IH8XtO4qyi3owfOxO4fQmySLxQIKA7DwT9c+ceUeP/ByuDVjoE/JP732P67tS5otdHgQDojE370pNK4JxbqcRI=
X-Received: by 2002:a0d:cb82:0:b0:5e7:9df1:218b with SMTP id
 n124-20020a0dcb82000000b005e79df1218bmr1587458ywd.16.1703056781717; Tue, 19
 Dec 2023 23:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 20 Dec 2023 12:49:30 +0530
Message-ID: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
Subject: PHY issue with SJA1105Q/DP84849I Design
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Andrew F. Davis" <afd@ti.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

We have encountered the PHY issue on 6.1 LTS with SJA1105Q Switch
connected to DP84849I PHY. DP84849I PHY supports dual ethernet ports
so we configure the DT to connect two ports from the switch to PHY and
one port to CPU (FEC in i.MX6DL).

&ecspi2 {
       cs-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
       pinctrl-names = "default";
       pinctrl-0 = <&pinctrl_ecspi2>;
       status = "okay";

      switch@0 {
          compatible = "nxp,sja1105q";
          reg = <0>;
          spi-max-frequency = <4000000>;
          spi-rx-delay-us = <1>;
          spi-tx-delay-us = <1>;
          spi-cpha;

          clocks = <&clk25m>;

          pinctrl-0 = <&pinctrl_sja1105_rst>;
          pinctrl-names = "default";
          reset-gpios = <&gpio6 5 GPIO_ACTIVE_LOW>;

          ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                        reg = <0>;
                        label = "ethphy0";
                        phy-handle = <&ethphy0>;
                        phy-mode = "mii";
                };

                port@1 {
                       reg = <1>;
                       label = "ethphy1";
                       phy-handle = <&ethphy1>;
                       phy-mode = "mii";
                };

                port@2 {
                      reg = <2>;
                      status = "disabled";
                };

                port@3 {
                      reg = <3>;
                      status = "disabled";
               };

               port@4 {
                      reg = <4>;
                      label = "cpu";
                      ethernet = <&fec>;
                      phy-mode = "mii";
                      rx-internal-delay-ps = <2000>;
                      tx-internal-delay-ps = <2000>;

                      fixed-link {
                          speed = <100>;
                          full-duplex;
                     };
              };
        };
     };
};

&fec {
          pinctrl-names = "default";
          pinctrl-0 = <&pinctrl_enet>;
          phy-mode = "mii";
          status = "okay";

          mdio {
             #address-cells = <1>;
             #size-cells = <0>;

            ethphy0: ethernet-phy@0 {
                      compatible = "ethernet-phy-ieee802.3-c22";
                      reg = <0>;
            };

            ethphy1: ethernet-phy@1 {
                    compatible = "ethernet-phy-ieee802.3-c22";
                    reg = <1>;
           };
        };
};

Since DP84849I shares the same register spec as DP83848, I have used
the DP83848 driver with the below PHY_ID change

diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index c38d33fd3706..c2c82ce5bb41 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>

+#define TI_DP83849I_PHY_ID             0x20005ca2
 #define TI_DP83848C_PHY_ID             0x20005ca0
 #define TI_DP83620_PHY_ID              0x20005ce0
 #define NS_DP83848C_PHY_ID             0x20005c90
@@ -173,6 +174,8 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
        }

 static struct phy_driver dp83848_driver[] = {
+       DP83848_PHY_DRIVER(TI_DP83849I_PHY_ID, "TI DP83849I 10/100 Mbps PHY",
+                          NULL),
        DP83848_PHY_DRIVER(TI_DP83848C_PHY_ID, "TI DP83848C 10/100 Mbps PHY",
                           NULL),
        DP83848_PHY_DRIVER(NS_DP83848C_PHY_ID, "NS DP83848C 10/100 Mbps PHY",

The Switch and dual-phy seem detecting as expected but when we try to
bring up the link the PHY0 says NOLINK as mentioned, below.

root@limx6solo:~# dmesg | grep sja
[   23.765086] sja1105 spi1.0: spi_imx_setup: mode 1, 8 bpw, 4000000 hz
[   23.765164] sja1105 spi1.0: setup mode 1, 8 bits/w, 4000000 Hz max --> 0
[   23.766160] sja1105 spi1.0: Probed switch chip: SJA1105Q
[   24.037103] sja1105 spi1.0: configuring for fixed/mii link mode
[   24.119891] sja1105 spi1.0 ethphy0 (uninitialized): PHY
[2188000.ethernet-1:00] driver [TI DP83849I 10/100 Mbps PHY]
(irq=POLL)
[   24.279129] sja1105 spi1.0 ethphy1 (uninitialized): PHY
[2188000.ethernet-1:01] driver [TI DP83849I 10/100 Mbps PHY]
(irq=POLL)
[   26.406998] sja1105 spi1.0: Link is Up - 100Mbps/Full - flow control off

root@imx6solo:~# cat /usr/phy.sh
#!/bin/sh

echo ======= MDIO: PHY0 ========
mdio 2188000.ethernet-1 phy 0 raw 0x0
mdio 2188000.ethernet-1 phy 0 raw 0x1
mdio 2188000.ethernet-1 phy 0 raw 0x2
mdio 2188000.ethernet-1 phy 0 raw 0x3
mdio 2188000.ethernet-1 phy 0 raw 0x4
mdio 2188000.ethernet-1 phy 0 raw 0x5
mdio 2188000.ethernet-1 phy 0 raw 0x6
mdio 2188000.ethernet-1 phy 0 raw 0x7
mdio 2188000.ethernet-1 phy 0 raw 0x10
mdio 2188000.ethernet-1 phy 0 raw 0x19

echo ======= MDIO: PHY1 ========
mdio 2188000.ethernet-1 phy 1 raw 0x0
mdio 2188000.ethernet-1 phy 1 raw 0x1
mdio 2188000.ethernet-1 phy 1 raw 0x2
mdio 2188000.ethernet-1 phy 1 raw 0x3
mdio 2188000.ethernet-1 phy 1 raw 0x4
mdio 2188000.ethernet-1 phy 1 raw 0x5
mdio 2188000.ethernet-1 phy 1 raw 0x6
mdio 2188000.ethernet-1 phy 1 raw 0x7
mdio 2188000.ethernet-1 phy 1 raw 0x10
mdio 2188000.ethernet-1 phy 1 raw 0x19

ip link set dev eth0 down
ip link set dev ethphy0 down
ip link set dev ethphy1 down

ip link set dev ethphy0 address 00:11:22:33:44:55
ip link set dev ethphy1 address 00:11:22:33:44:66

ip addr add dev ethphy0 169.254.178.1/16
ip addr add dev ethphy1 169.253.178.2/16

ip link set dev eth0 up
ip link set dev ethphy0 up
ip link set dev ethphy1 up

echo ########## MDIO: PHY0 ###########
mdio 2188000.ethernet-1 phy 0 raw 0x0
mdio 2188000.ethernet-1 phy 0 raw 0x1
mdio 2188000.ethernet-1 phy 0 raw 0x2
mdio 2188000.ethernet-1 phy 0 raw 0x3
mdio 2188000.ethernet-1 phy 0 raw 0x4
mdio 2188000.ethernet-1 phy 0 raw 0x5
mdio 2188000.ethernet-1 phy 0 raw 0x6
mdio 2188000.ethernet-1 phy 0 raw 0x7
mdio 2188000.ethernet-1 phy 0 raw 0x10
mdio 2188000.ethernet-1 phy 0 raw 0x19

echo ########## MDIO: PHY1 ###########
mdio 2188000.ethernet-1 phy 1 raw 0x0
mdio 2188000.ethernet-1 phy 1 raw 0x1
mdio 2188000.ethernet-1 phy 1 raw 0x2
mdio 2188000.ethernet-1 phy 1 raw 0x3
mdio 2188000.ethernet-1 phy 1 raw 0x4
mdio 2188000.ethernet-1 phy 1 raw 0x5
mdio 2188000.ethernet-1 phy 1 raw 0x6
mdio 2188000.ethernet-1 phy 1 raw 0x7
mdio 2188000.ethernet-1 phy 1 raw 0x10
mdio 2188000.ethernet-1 phy 1 raw 0x19


root@ltts-imx6solo:~# bash /usr/phy.sh
======= MDIO: PHY0 ========
0x0: 0x3900
0x1: 0x7849
0x2: 0x2000
0x3: 0x5ca2
0x4: 0x01e1
0x5: 0x45e1
0x6: 0x0006
0x7: 0x2001
0x10: 0x0000
0x19: 0x8020
======= MDIO: PHY1 ========
0x0: 0x3100
0x1: 0x786d
0x2: 0x2000
0x3: 0x5ca2
0x4: 0x01e1
0x5: 0x45e1
0x6: 0x0007
0x7: 0x2801
0x10: 0x0015
0x19: 0x8021

ip link set dev eth0 down
ip link set dev ethphy0 down
ip link set dev ethphy1 down

ip link set dev ethphy0 address 00:11:22:33:44:55
ip link set dev ethphy1 address 00:11:22:33:44:66
ip link set dev eth0 up
ip link set dev ethphy0 up
ip link set dev ethphy1 up
[ 1254.929229] TI DP83849I 10/100 Mbps PHY 2188000.ethernet-1:00:
attached PHY driver (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
[ 1254.993819] sja1105 spi1.0 ethphy0: configuring for phy/mii link mode
[ 1255.005027] ------------[ cut here ]------------
[ 1255.009962] WARNING: CPU: 0 PID: 374 at drivers/net/phy/phy.c:1157
phy_start+0x58/0xb4
[ 1255.018062] called from state NOLINK
[ 1255.021656] Modules linked in: mdio_netlink(O) bnep tag_sja1105
sja1105 pcs_xpcs brcmfmac brcmutil imx_sdma coda_vpu v4l2_jpeg
imx_vdoa evbug
[ 1255.034578] CPU: 0 PID: 374 Comm: ip Tainted: G           O       6.1.58 #1
[ 1255.041560] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[ 1255.048103]  unwind_backtrace from show_stack+0x10/0x14
[ 1255.053361]  show_stack from dump_stack_lvl+0x58/0x70
[ 1255.058441]  dump_stack_lvl from __warn+0x70/0x1a4
[ 1255.063258]  __warn from warn_slowpath_fmt+0x1bc/0x270
[ 1255.068416]  warn_slowpath_fmt from phy_start+0x58/0xb4
[ 1255.073662]  phy_start from dsa_port_enable_rt+0x54/0x9c
[ 1255.079000]  dsa_port_enable_rt from dsa_slave_open+0xb8/0x17c
[ 1255.084860]  dsa_slave_open from __dev_open+0xec/0x1ac
[ 1255.090024]  __dev_open from __dev_change_flags+0x18c/0x224
[ 1255.095613]  __dev_change_flags from dev_change_flags+0x14/0x44
[ 1255.101549]  dev_change_flags from do_setlink+0x254/0xe4c
[ 1255.106974]  do_setlink from rtnl_newlink+0x598/0x80c
[ 1255.112048]  rtnl_newlink from rtnetlink_rcv_msg+0x168/0x574
[ 1255.117722]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb8/0x11c
[ 1255.123572]  netlink_rcv_skb from netlink_unicast+0x1a8/0x2dc
[ 1255.129343]  netlink_unicast from netlink_sendmsg+0x1d8/0x450
[ 1255.135117]  netlink_sendmsg from ____sys_sendmsg+0x188/0x258
[ 1255.140891]  ____sys_sendmsg from ___sys_sendmsg+0x6c/0xa4
[ 1255.146397]  ___sys_sendmsg from sys_sendmsg+0x50/0x98
[ 1255.151556]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
[ 1255.156801] Exception stack(0xf10c9fa8 to 0xf10c9ff0)
[ 1255.161867] 9fa0:                   00000000 00000001 00000003
beef2730 00000000 00000000
[ 1255.170057] 9fc0: 00000000 00000001 b6f9e5a0 00000128 626adc51
00000000 004d1cc0 004d1cc0
[ 1255.178244] 9fe0: 00000128 beef26d0 b6e9f6d3 b6e11ae6
[ 1255.183469] irq event stamp: 3345
[ 1255.186852] hardirqs last  enabled at (3355): [<c0195dbc>]
__up_console_sem+0x50/0x60
[ 1255.194715] hardirqs last disabled at (3362): [<c0195da8>]
__up_console_sem+0x3c/0x60
[ 1255.202628] softirqs last  enabled at (3344): [<c01017d0>]
__do_softirq+0x2c0/0x57c
[ 1255.210365] softirqs last disabled at (3325): [<c012f204>]
__irq_exit_rcu+0x138/0x17c
[ 1255.218281] ---[ end trace 0000000000000000 ]---
[ 1255.293759] sja1105 spi1.0 ethphy1: configuring for phy/mii link mode

0x3100
0x7849
0x2000
0x5ca2
0x05e1
0x0000
0x0004
0x2001
0x0000
0x8020

0x3100
0x7849
0x2000
0x5ca2
0x0141
0x0000
0x0005
0x2801
0x0000
0x8021
root@ltts-imx6solo:~# [ 1257.045875] fec 2188000.ethernet eth0: Link
is Up - 100Mbps/Full - flow control rx/tx
[ 1257.054008] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[ 1257.365971] sja1105 spi1.0 ethphy1: Link is Up - 100Mbps/Full -
flow control off
[ 1257.373455] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes ready

root@ltts-imx6solo:~# ifconfig -a
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
        inet6 fe80::7c4c:1aff:fe5e:cbf0  prefixlen 64  scopeid 0x20<link>
        ether 7e:4c:1a:5e:cb:f0  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ethphy0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 169.254.178.1  netmask 255.255.0.0  broadcast 0.0.0.0
        ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ethphy1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.253.178.2  netmask 255.255.0.0  broadcast 0.0.0.0
        inet6 fe80::211:22ff:fe33:4466  prefixlen 64  scopeid 0x20<link>
        ether 00:11:22:33:44:66  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 32  bytes 4211 (4.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 91  bytes 7801 (7.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 91  bytes 7801 (7.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

sit0: flags=128<NOARP>  mtu 1480
        unspec 00-00-00-00-31-00-00-4A-00-00-00-00-00-00-00-00
txqueuelen 1000  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether c0:ee:40:82:2f:fc  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@ltts-imx6solo:~# mdio 2188000.ethernet-1
 DEV      PHY-ID  LINK
0x00  0x20005ca2  up
0x01  0x20005ca2  up

--
Jagan Teki,
Amarula Solutions India Pvt. Ltd.
Co-Founder & Embedded Linux Architect
405/E-Block, Sri Lakshmi Shubham Arcade, Chandanagar, Hyderabad - 500050, India
M. (+91) 910 009 0959
[`as] http://www.amarulasolutions.com

