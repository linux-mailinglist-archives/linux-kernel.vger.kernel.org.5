Return-Path: <linux-kernel+bounces-13224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E178C82015D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FA6282B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B014010;
	Fri, 29 Dec 2023 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ej9A6HT4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64E13FF9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbc649c275so1431863b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 12:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703881130; x=1704485930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAm1Gv24m5eKtpM2VegsdBcgdCr09tg+CtjUEmyp3ww=;
        b=ej9A6HT4WCDD7vus6ghbxyCT5RDWwJpbHlWW/6Xu3OoEEn1aECCe8SxnD9PnZ4C17d
         iMzf4ET8heKXwuszEQOR60Tls9T59w9+07yhW1Zrz43OfnUdfspqg20XxK1dYgREyOBv
         RBum4rraOlZWkPEn4KHopvPpl/bQIgLgcRrME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703881130; x=1704485930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAm1Gv24m5eKtpM2VegsdBcgdCr09tg+CtjUEmyp3ww=;
        b=Oyt+xqx+X07gf+3CU3MJdH+V7FXTFpfdQAK1alq0teYATcgqBpeBiiVn84iHXdpnji
         MQ4uk0qTVbUmte1u8U5pQi04EEYAhRBaMq+uxWhHjpQDjO8V/8JSajYXYWR9p4EUyFTD
         yiblo6dX5DTFWqakE+mGSF24LIMNKKeIoASWMG0BU/63q9SgVLe9V2PsWbxA5Vaab9eD
         k0dVh6keduB1N22J/cARMYWno/N06kdAyL4NSvRbPrZXFF1RZ+gU1gY9JPUtLQ/v6FIW
         EbbkB9bV9XjDxU8ZK5J10tuBaAkkenkma22ogQFWWWf6JtJXcb0sXmzNcoRzEGcQG07u
         PmdQ==
X-Gm-Message-State: AOJu0YwgGtSpxHXb4ZdFHdi9lrRT72a8nNmUmgYLCdAXNmVxXcC/SWgb
	E32ZS6Fn9trq163Q7LLCf6bw2MFo6w0dAHMd1cBYes74TVYzfg==
X-Google-Smtp-Source: AGHT+IE7yV4SqDHk31PXqJmrlb8c3/AFFiG74agsF08XEHRYgF02/GXCsCVBJdY9jTtqV+xjFpgrHQT8Q+HV4D3V5XU=
X-Received: by 2002:a05:6808:1403:b0:3b6:a1f4:8066 with SMTP id
 w3-20020a056808140300b003b6a1f48066mr8540948oiv.37.1703881130651; Fri, 29 Dec
 2023 12:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf> <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf> <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
 <20231229152519.2jxrwaeltp4pxlms@skbuf>
In-Reply-To: <20231229152519.2jxrwaeltp4pxlms@skbuf>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sat, 30 Dec 2023 01:48:38 +0530
Message-ID: <CAMty3ZAOM5+EMw9sLVOq-=CH_sP=1TLAGEMF9LYOZ4aFbNUtsg@mail.gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Andrew F. Davis" <afd@ti.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, 
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 8:55=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Dec 29, 2023 at 05:12:39PM +0530, Jagan Teki wrote:
> > With fec0 fixed-link and 3 different switch port configurations, the
> > result of the link seems to be up but the ping not working and even
> > the packets are not transmitted via eth0.
> >
> > DT Combinations:
> >
> > - Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3 is
> > disabled, Port4 is FEC
> > - Port0 is disabled, Port1 is ethphy0, Port2 is ethphy1, Port3 is
> > disabled, Port4 is FEC
> > - Port0 is disabled, Port1 is disabled, Port2 is ethphy0, Port3 is
> > ethphy1, Port4 as FEC
>
> Why all these combinations? You don't know which switch port is which?

This is where I get confused in the first place. I didn't find proper
information on binding about how the physical pin-out is to be
configured in DT ports or maybe I didn't understand properly.

As per schematics.
Pin MII0_RXD0-D3/TXD0-D3 is connected to PROC_MII0_RXD0-D3/TXD0-D3
this would be fec0.
Pin MII1_RXD0-D3/TXD0-D3 is connected to PHY_MII1_RXD0-D3/TXD0-D3 this
would be ethphy0.
Pin MII2_RXD0-D3/TXD0-D3 is connected to PHY_MII2_RXD0-D3/TXD0-D3 this
would be ethphy1.
Pin MII3_RXD0-D3/TXD0-D3 is grounded
Pin MII4_RXD0-D3/TXD0-D3 is grounded

So, I did use the above 3 combinations and assumed fec0 is always a
port4 based on existing DTS in the tree. Please let me know which
configuration is proper as per schematic connections.

>
> > DT: (with Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3
> > is disabled, Port4 is FEC)
> >
> > &ecspi2 {
> >     cs-gpios =3D <&gpio2 27 GPIO_ACTIVE_HIGH>;
> >     pinctrl-names =3D "default";
> >     pinctrl-0 =3D <&pinctrl_ecspi2>;
> >     status =3D "okay";
> >
> >     switch@0 {
> >         compatible =3D "nxp,sja1105q";
> >         reg =3D <0>;
> >         spi-max-frequency =3D <4000000>;
> >         spi-rx-delay-us =3D <1>;
> >         spi-tx-delay-us =3D <1>;
> >         spi-cpha;
> >
> >        clocks =3D <&clk25m>;
> >
> >        pinctrl-0 =3D <&pinctrl_sja1105_rst>;
> >        pinctrl-names =3D "default";
> >        reset-gpios =3D <&gpio6 5 GPIO_ACTIVE_LOW>;
> >
> >        ports {
> >               #address-cells =3D <1>;
> >               #size-cells =3D <0>;
> >
> >              port@0 {
> >                   reg =3D <0>;
> >                   label =3D "ethphy0";
> >                   phy-handle =3D <&ethphy0>;
> >                   phy-mode =3D "mii";
> >             };
> >
> >             port@1 {
> >                  reg =3D <1>;
> >                  label =3D "ethphy1";
> >                  phy-handle =3D <&ethphy1>;
> >                  phy-mode =3D "mii";
> >            };
> >
> >            port@2 {
> >                 reg =3D <2>;
> >                 status =3D "disabled";
> >            };
> >
> >             port@3 {
> >                  reg =3D <3>;
> >                  status =3D "disabled";
> >            };
> >
> >            port@4 {
> >                 reg =3D <4>;
> >                 label =3D "cpu";
> >                 ethernet =3D <&fec>;
> >                 phy-mode =3D "mii";
> >                 rx-internal-delay-ps =3D <2000>;
> >                 tx-internal-delay-ps =3D <2000>;
>
> This looks suspicious. "rx-internal-delay-ps" and "tx-internal-delay-ps"
> are only relevant for the RGMII modes, but you specify phy-mode =3D "mii"=
.
> Does the board schematic confirm that MII is the physical connection
> being used from the switch to the FEC?

Yes, the design uses MII.

>
> If you are truly using MII, then you should remove the RGMII delay
> properties, and since you are using a 6.1 kernel - hence after kernel
> commit 5d645df99ac6 ("net: dsa: sja1105: determine PHY/MAC role from PHY
> interface type") - you should be using phy-mode =3D "rev-mii" to put this
> port in MII PHY ("RevMII") mode - to interoperate with the FEC in MII
> MAC mode.

Okay, I will remove RGMII delay. is phy-mode =3D "rev-mii" applicable to
all ports or only for fec port4?

>
> >
> >                fixed-link {
> >                    speed =3D <100>;
> >                    full-duplex;
> >                };
> >             };
> >           };
> >      };
> > };
> >
> > &fec {
> >        pinctrl-names =3D "default";
> >        pinctrl-0 =3D <&pinctrl_enet>;
> >        phy-mode =3D "mii";
> >        status =3D "okay";
> >
> >        fixed-link {
> >           speed =3D <100>;
> >           full-duplex;
> >        };
> >
> >        mdio {
> >             #address-cells =3D <1>;
> >             #size-cells =3D <0>;
> >
> >             ethphy0: ethernet-phy@0 {
> >                     compatible =3D "ethernet-phy-ieee802.3-c22";
> >                     reg =3D <0>;
> >             };
> >
> >            ethphy1: ethernet-phy@1 {
> >                compatible =3D "ethernet-phy-ieee802.3-c22";
> >                 reg =3D <1>;
> >             };
> >     };
> > };
> >
> > root@ltts-imx6solo:~# bash /usr/phynew.sh
> > =3D=3D=3D=3D=3D=3D=3D MDIO: PHY0 =3D=3D=3D=3D=3D=3D=3D=3D
> > [  162.426515] mdio_netlink: loading out-of-tree module taints kernel.
>
> Still, please refrain from involving out-of-tree modules when asking for
> help upstream. Thanks.

Sorry, I didn't remove it during this log, but I did remove this
module at runtime during my actual sanity tests.

>
> > root@ltts-imx6solo:~# [  165.208656] sja1105 spi1.0 ethphy0: Link is
> > Up - 100Mbps/Full - flow control off
> > [  165.225788] sja1105 spi1.0 ethphy1: Link is Up - 100Mbps/Full -
> > flow control off
> > [  165.235925] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy0: link becomes rea=
dy
> > [  165.255777] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes rea=
dy
> >
> > root@ltts-imx6solo:~# ifconfig
> > eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
> >         inet6 fe80::68fb:8ff:fedf:d377  prefixlen 64  scopeid 0x20<link=
>
> >         ether 6a:fb:08:df:d3:77  txqueuelen 1000  (Ethernet)
> >         RX packets 0  bytes 0 (0.0 B)
> >         RX errors 0  dropped 0  overruns 0  frame 0
> >         TX packets 0  bytes 0 (0.0 B)
> >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >
> > ethphy0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >         inet 169.254.178.1  netmask 255.255.0.0  broadcast 0.0.0.0
> >         inet6 fe80::211:22ff:fe33:4455  prefixlen 64  scopeid 0x20<link=
>
> >         ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
> >         RX packets 0  bytes 0 (0.0 B)
> >         RX errors 0  dropped 0  overruns 0  frame 0
> >         TX packets 30  bytes 4071 (3.9 KiB)
> >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >
> > ethphy1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >         inet 169.253.178.2  netmask 255.255.0.0  broadcast 0.0.0.0
> >         inet6 fe80::211:22ff:fe33:4466  prefixlen 64  scopeid 0x20<link=
>
> >         ether 00:11:22:33:44:66  txqueuelen 1000  (Ethernet)
> >         RX packets 0  bytes 0 (0.0 B)
> >         RX errors 0  dropped 0  overruns 0  frame 0
> >         TX packets 30  bytes 4071 (3.9 KiB)
> >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >
> > lo: flags=3D73<UP,LOOPBACK,RUNNING>  mtu 65536
> >         inet 127.0.0.1  netmask 255.0.0.0
> >         inet6 ::1  prefixlen 128  scopeid 0x10<host>
> >         loop  txqueuelen 1000  (Local Loopback)
> >         RX packets 89  bytes 7675 (7.4 KiB)
> >         RX errors 0  dropped 0  overruns 0  frame 0
> >         TX packets 89  bytes 7675 (7.4 KiB)
> >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> ifconfig reports statistics counters from the /proc/net/dev interface,
> which the sja1105 does not report very well (they don't come from hardwar=
e).
> It's best to use "ethtool -S eth0 | grep -v ': 0'" for FEC and SJA1105
> CPU port (named "p04_*") counters, and "ethtool -S ethphy0 | grep -v ': 0=
'"
> to get hardware counters from the switch user ports.

Okay.

>
> You can also use the RX counters to determine which switch port is which
> (but the phy-handle of each port to each PHY needs to be correct).

RX counters in ethtool you mean?

>
> > mytsl02383@MYTSL02383:~$ ifconfig -a
> > enp43s0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >         inet 169.254.178.2  netmask 255.255.0.0  broadcast 169.254.255.=
255
> >         inet6 fe80::d71b:4bdd:27bd:2a1a  prefixlen 64  scopeid 0x20<lin=
k>
> >         ether 00:be:43:20:9a:26  txqueuelen 1000  (Ethernet)
> >         RX packets 272356  bytes 27099064 (27.0 MB)
> >         RX errors 0  dropped 19  overruns 0  frame 0
> >         TX packets 862  bytes 300806 (300.8 KB)
> >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> > mytsl02383@MYTSL02383:~$ ping 169.254.178.1
> > PING 169.254.178.1 (169.254.178.1) 56(84) bytes of data.
> > From 169.254.178.2 icmp_seq=3D1 Destination Host Unreachable
> >
> > Let me know if you need any more details.
>
> I'm not convinced packets are routed through ethphy0 or ethphy1, since
> all interfaces have IPv4 link-local addresses only. You can use
> "ip route get 169.254.178.1" to confirm what interface gets chosen.
> This is not indicative of a device-level problem, just a setup one.
> Please set up some IPv4 static addresses which are not link-local on the
> DSA user ports and try to ping a link partner which has an IP address in
> the same subnet.

Okay. I will update this test along with DT changes.

Thanks,
Jagan.

