Return-Path: <linux-kernel+bounces-13137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC8820031
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F222284706
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE402125B7;
	Fri, 29 Dec 2023 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXagI7CM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEA11CB9;
	Fri, 29 Dec 2023 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5aef534eso29281325e9.0;
        Fri, 29 Dec 2023 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703863522; x=1704468322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYKi1Ed87Lj2j5kXa6dfoEYMvP54594XyZW+zyxicNw=;
        b=RXagI7CMZ6elrvVIC+rfo74ZHPhoVJ1d4vx3aanJ86OlPd2h4/eeCMWYUSlcBpdRQO
         eHhTnTG3Ht3V7iYc+UEzvpibcHXTk1Aa88bAfwSHg5lbF1NkdnNyUsXuz67cjrYy8p80
         DG+/SQoBEcA68+fHQemknK3BtaPE1ZDVtrH6Flmyu+2N6+sTU+GDQojp145AobetN2Oo
         slF5kmD8mYlTrfKrORrIQVDhFFjTEmBS3nxrqV2cY5OL27NMSg2fl8wwLqjgSkF0YQiJ
         OKO2M+8grRsKXAtZFuscE8bvLjnenrjlQIDUveWFlZD6Y1v9migku91ooaPjse5oVEd2
         xQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703863522; x=1704468322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYKi1Ed87Lj2j5kXa6dfoEYMvP54594XyZW+zyxicNw=;
        b=C8ye6aFqIU2uw+F/wM3ZlG72P/F32i4bwSGWyucJEO9i6rbKMUiCHR37OFQdN8hFq0
         hr8doXI2pOG4LapLO6MqyvGHdQII3ZVTOUEhSyW6Ga3fsGOMJWeH6bfFo/pbT/0J6Ac6
         TNFfnmVmjETVWeCCqmINXnfxIlPJV5lgfclEvdDdEfyh+ChPS6s9VkymekguWLz+vbaG
         ZC2PQgHYIgK9n+bXqkEe2lLEHzivo+2y/KT1nPH0nchlLOCglTqpMlpnDI2TE1WIft4Z
         SHa70c4Is3Gc5CkWBb98odmBEaYd8StY5/FglzQ9WECB9u6GL4mVDufl/LqYDyPUpoMi
         c79A==
X-Gm-Message-State: AOJu0YxgX+aIN9S5GortrP/t9j7prFEhd2aWA1SEZlvbXfFzQNhOIK5x
	wBVqSXC+bBxjbNnR/9ylydw=
X-Google-Smtp-Source: AGHT+IF14/5SoXwRelolZluqulHNoHcSzmTGhalc2XL17YdaShFnZBQnTYxhF+q1E4p3JWCDyiHkZQ==
X-Received: by 2002:a05:600c:4450:b0:40c:6a85:e83a with SMTP id v16-20020a05600c445000b0040c6a85e83amr5823353wmn.51.1703863522316;
        Fri, 29 Dec 2023 07:25:22 -0800 (PST)
Received: from skbuf ([188.25.254.184])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0040c3953cda5sm39145597wmo.45.2023.12.29.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 07:25:22 -0800 (PST)
Date: Fri, 29 Dec 2023 17:25:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
Message-ID: <20231229152519.2jxrwaeltp4pxlms@skbuf>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
 <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
 <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
 <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
 <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>

On Fri, Dec 29, 2023 at 05:12:39PM +0530, Jagan Teki wrote:
> With fec0 fixed-link and 3 different switch port configurations, the
> result of the link seems to be up but the ping not working and even
> the packets are not transmitted via eth0.
> 
> DT Combinations:
> 
> - Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3 is
> disabled, Port4 is FEC
> - Port0 is disabled, Port1 is ethphy0, Port2 is ethphy1, Port3 is
> disabled, Port4 is FEC
> - Port0 is disabled, Port1 is disabled, Port2 is ethphy0, Port3 is
> ethphy1, Port4 as FEC

Why all these combinations? You don't know which switch port is which?

> DT: (with Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3
> is disabled, Port4 is FEC)
> 
> &ecspi2 {
>     cs-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_ecspi2>;
>     status = "okay";
> 
>     switch@0 {
>         compatible = "nxp,sja1105q";
>         reg = <0>;
>         spi-max-frequency = <4000000>;
>         spi-rx-delay-us = <1>;
>         spi-tx-delay-us = <1>;
>         spi-cpha;
> 
>        clocks = <&clk25m>;
> 
>        pinctrl-0 = <&pinctrl_sja1105_rst>;
>        pinctrl-names = "default";
>        reset-gpios = <&gpio6 5 GPIO_ACTIVE_LOW>;
> 
>        ports {
>               #address-cells = <1>;
>               #size-cells = <0>;
> 
>              port@0 {
>                   reg = <0>;
>                   label = "ethphy0";
>                   phy-handle = <&ethphy0>;
>                   phy-mode = "mii";
>             };
> 
>             port@1 {
>                  reg = <1>;
>                  label = "ethphy1";
>                  phy-handle = <&ethphy1>;
>                  phy-mode = "mii";
>            };
> 
>            port@2 {
>                 reg = <2>;
>                 status = "disabled";
>            };
> 
>             port@3 {
>                  reg = <3>;
>                  status = "disabled";
>            };
> 
>            port@4 {
>                 reg = <4>;
>                 label = "cpu";
>                 ethernet = <&fec>;
>                 phy-mode = "mii";
>                 rx-internal-delay-ps = <2000>;
>                 tx-internal-delay-ps = <2000>;

This looks suspicious. "rx-internal-delay-ps" and "tx-internal-delay-ps"
are only relevant for the RGMII modes, but you specify phy-mode = "mii".
Does the board schematic confirm that MII is the physical connection
being used from the switch to the FEC?

If you are truly using MII, then you should remove the RGMII delay
properties, and since you are using a 6.1 kernel - hence after kernel
commit 5d645df99ac6 ("net: dsa: sja1105: determine PHY/MAC role from PHY
interface type") - you should be using phy-mode = "rev-mii" to put this
port in MII PHY ("RevMII") mode - to interoperate with the FEC in MII
MAC mode.

> 
>                fixed-link {
>                    speed = <100>;
>                    full-duplex;
>                };
>             };
>           };
>      };
> };
> 
> &fec {
>        pinctrl-names = "default";
>        pinctrl-0 = <&pinctrl_enet>;
>        phy-mode = "mii";
>        status = "okay";
> 
>        fixed-link {
>           speed = <100>;
>           full-duplex;
>        };
> 
>        mdio {
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             ethphy0: ethernet-phy@0 {
>                     compatible = "ethernet-phy-ieee802.3-c22";
>                     reg = <0>;
>             };
> 
>            ethphy1: ethernet-phy@1 {
>                compatible = "ethernet-phy-ieee802.3-c22";
>                 reg = <1>;
>             };
>     };
> };
> 
> root@ltts-imx6solo:~# bash /usr/phynew.sh
> ======= MDIO: PHY0 ========
> [  162.426515] mdio_netlink: loading out-of-tree module taints kernel.

Still, please refrain from involving out-of-tree modules when asking for
help upstream. Thanks.

> root@ltts-imx6solo:~# [  165.208656] sja1105 spi1.0 ethphy0: Link is
> Up - 100Mbps/Full - flow control off
> [  165.225788] sja1105 spi1.0 ethphy1: Link is Up - 100Mbps/Full -
> flow control off
> [  165.235925] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy0: link becomes ready
> [  165.255777] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes ready
> 
> root@ltts-imx6solo:~# ifconfig
> eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
>         inet6 fe80::68fb:8ff:fedf:d377  prefixlen 64  scopeid 0x20<link>
>         ether 6a:fb:08:df:d3:77  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 0  bytes 0 (0.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> ethphy0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 169.254.178.1  netmask 255.255.0.0  broadcast 0.0.0.0
>         inet6 fe80::211:22ff:fe33:4455  prefixlen 64  scopeid 0x20<link>
>         ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 30  bytes 4071 (3.9 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> ethphy1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 169.253.178.2  netmask 255.255.0.0  broadcast 0.0.0.0
>         inet6 fe80::211:22ff:fe33:4466  prefixlen 64  scopeid 0x20<link>
>         ether 00:11:22:33:44:66  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 30  bytes 4071 (3.9 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
>         inet 127.0.0.1  netmask 255.0.0.0
>         inet6 ::1  prefixlen 128  scopeid 0x10<host>
>         loop  txqueuelen 1000  (Local Loopback)
>         RX packets 89  bytes 7675 (7.4 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 89  bytes 7675 (7.4 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ifconfig reports statistics counters from the /proc/net/dev interface,
which the sja1105 does not report very well (they don't come from hardware).
It's best to use "ethtool -S eth0 | grep -v ': 0'" for FEC and SJA1105
CPU port (named "p04_*") counters, and "ethtool -S ethphy0 | grep -v ': 0'"
to get hardware counters from the switch user ports.

You can also use the RX counters to determine which switch port is which
(but the phy-handle of each port to each PHY needs to be correct).

> mytsl02383@MYTSL02383:~$ ifconfig -a
> enp43s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 169.254.178.2  netmask 255.255.0.0  broadcast 169.254.255.255
>         inet6 fe80::d71b:4bdd:27bd:2a1a  prefixlen 64  scopeid 0x20<link>
>         ether 00:be:43:20:9a:26  txqueuelen 1000  (Ethernet)
>         RX packets 272356  bytes 27099064 (27.0 MB)
>         RX errors 0  dropped 19  overruns 0  frame 0
>         TX packets 862  bytes 300806 (300.8 KB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> mytsl02383@MYTSL02383:~$ ping 169.254.178.1
> PING 169.254.178.1 (169.254.178.1) 56(84) bytes of data.
> From 169.254.178.2 icmp_seq=1 Destination Host Unreachable
> 
> Let me know if you need any more details.

I'm not convinced packets are routed through ethphy0 or ethphy1, since
all interfaces have IPv4 link-local addresses only. You can use
"ip route get 169.254.178.1" to confirm what interface gets chosen.
This is not indicative of a device-level problem, just a setup one.
Please set up some IPv4 static addresses which are not link-local on the
DSA user ports and try to ping a link partner which has an IP address in
the same subnet.

