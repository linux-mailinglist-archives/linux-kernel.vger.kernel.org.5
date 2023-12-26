Return-Path: <linux-kernel+bounces-11548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18D81E808
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E831F1C20A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01824F210;
	Tue, 26 Dec 2023 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpe5o5Lt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A64F5E3;
	Tue, 26 Dec 2023 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so4694041a12.0;
        Tue, 26 Dec 2023 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703604659; x=1704209459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgmuVd4P8obINlchnrnXm6SfRjG8GH/yAXA2zbhaFQw=;
        b=Kpe5o5Ltn1lH8sQVykQbu6xTXnaaVZAyPSb+8Xo4L4A59efIs3W5uSHRnr+/m2qaVZ
         QzpvUqT3Ck+HDFLAa/lT4APV6uveLbKLEGXQtBARgv9n5TmFQQTqPg3I3ydj7e9M3PE0
         lgPy8219T/q9vj1SfzkBRvJvBkeEOh+APY8UrZrsPENXlWG95rvYdE7Ex7fWvDiWoXH4
         SJ7RnvuGWOInzRJQqlKibbNmCzhaZub9MgAQ3gdrtUq6AKS8k8E6lHQQmsvf34LyFACw
         rmaCLNNaNtH4cswjIwrnH54t0DXPDuPFk8dGbzFjDHOoKQwFfyXfCvD6sRovgXA2RYrb
         cmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703604659; x=1704209459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgmuVd4P8obINlchnrnXm6SfRjG8GH/yAXA2zbhaFQw=;
        b=lBvy8VhJfaSlJBesE93TQcTb8XB3k16tahYqfJaQbNldgXNcKYvg3/ElgqoignbfqD
         qmSyOtvY/1ajB60qClQTtjy5/cj3GJy/pvP3spVkjRp8scbK8uBZ8aoSpft8H/3pg9kV
         E5ItGs/DuVfBtZqUg/m13H3w5NOmOIj/JnPypRLW5w6TG+2vfqoqYWsjAffZ0W1Q1G5C
         Ag9piBt+/OViSKjZwgXtsTgTgKCMyPHjnDX7a5LYeSbxREDhQkwJko4jKN9Bbnfdks7t
         7Pq6nmcLvGM0FHpQLqlj/+z6uqywa4j7MEWuAouHqQnxvfrUIOMD0S/W5UM2WlfCFEgi
         nP3A==
X-Gm-Message-State: AOJu0YxFHwe7RW84uKCLf3PYyEszn1fFcUcAArZbEP3wbzS8bAlH89BL
	no1r1vzUkPWD6J5LY8xTz9M=
X-Google-Smtp-Source: AGHT+IGu/L/UfxUnPtkSCsPtbENyLMAbgoicSL82gwBaTuTez/iMoCol0L3BFLDjpj61X2Y3paDECw==
X-Received: by 2002:a17:906:1091:b0:a26:cab2:a5d3 with SMTP id u17-20020a170906109100b00a26cab2a5d3mr2517414eju.115.1703604658574;
        Tue, 26 Dec 2023 07:30:58 -0800 (PST)
Received: from skbuf ([188.25.255.53])
        by smtp.gmail.com with ESMTPSA id fi8-20020a1709073ac800b00a272de16f52sm362556ejc.112.2023.12.26.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 07:30:58 -0800 (PST)
Date: Tue, 26 Dec 2023 17:30:55 +0200
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
Message-ID: <20231226153055.4yihsmu6kiak6hkf@skbuf>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>

On Tue, Dec 26, 2023 at 01:11:08PM +0530, Jagan Teki wrote:
> &fec {
>           pinctrl-names = "default";
>           pinctrl-0 = <&pinctrl_enet>;
>           phy-mode = "mii";
>           status = "okay";

tl;dr: I think what is missing is:

		fixed-link {
			speed = <100>;
			full-duplex;
		};

> 
>           mdio {
>              #address-cells = <1>;
>              #size-cells = <0>;
> 
>             ethphy0: ethernet-phy@0 {
>                       compatible = "ethernet-phy-ieee802.3-c22";
>                       reg = <0>;
>             };
> 
>             ethphy1: ethernet-phy@1 {
>                     compatible = "ethernet-phy-ieee802.3-c22";
>                     reg = <1>;
>            };
>         };
> };
> 
> root@imx6solo:~# ip link set dev eth0 down
> root@imx6solo:~# ip link set dev ethphy0 down
> root@imx6solo:~# ip link set dev ethphy1 down
> root@imx6solo:~# ip link set dev ethphy0 address 00:11:22:33:44:55
> root@imx6solo:~# ip link set dev ethphy1 address 00:11:22:33:44:66
> root@imx6solo:~# ip addr add dev ethphy0 192.168.1.1/16
> root@imx6solo:~# ip addr add dev ethphy1 192.168.1.5/16
> root@imx6solo:~# ip link set dev eth0 up
> [  617.126753] dp83848_config_init: ret 0
> [  617.130831] TI DP83849I 10/100 Mbps PHY 2188000.ethernet-1:00: attached PHY driver (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
> root@imx6solo:~# [  619.207519] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> [  619.215698] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

eth0 is the FEC port, right?

> root@imx6solo:~# ip link set dev ethphy0 up
> [  634.114608] sja1105 spi1.0 ethphy0: configuring for phy/mii link mode
> [  634.126617] ------------[ cut here ]------------
> [  634.131463] WARNING: CPU: 0 PID: 330 at drivers/net/phy/phy.c:1157 phy_start+0x58/0xb4
> [  634.139627] called from state RUNNING
> [  634.143310] Modules linked in: bnep tag_sja1105 sja1105 pcs_xpcs brcmfmac brcmutil imx_sdma coda_vpu v4l2_jpeg imx_vdoa evbug
> [  634.154815] CPU: 0 PID: 330 Comm: ip Not tainted 6.1.58 #1
> [  634.160321] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  634.166866]  unwind_backtrace from show_stack+0x10/0x14
> [  634.172125]  show_stack from dump_stack_lvl+0x58/0x70
> [  634.177205]  dump_stack_lvl from __warn+0x70/0x1a4
> [  634.182023]  __warn from warn_slowpath_fmt+0x1bc/0x270
> [  634.187181]  warn_slowpath_fmt from phy_start+0x58/0xb4
> [  634.192427]  phy_start from dsa_port_enable_rt+0x54/0x9c
> [  634.197765]  dsa_port_enable_rt from dsa_slave_open+0xb8/0x17c
> [  634.203624]  dsa_slave_open from __dev_open+0xec/0x1ac
> [  634.208788]  __dev_open from __dev_change_flags+0x18c/0x224
> [  634.214377]  __dev_change_flags from dev_change_flags+0x14/0x44
> [  634.220313]  dev_change_flags from do_setlink+0x254/0xe4c
> [  634.225737]  do_setlink from rtnl_newlink+0x598/0x80c
> [  634.230811]  rtnl_newlink from rtnetlink_rcv_msg+0x168/0x574
> [  634.236485]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb8/0x11c
> [  634.242337]  netlink_rcv_skb from netlink_unicast+0x1a8/0x2dc
> [  634.248108]  netlink_unicast from netlink_sendmsg+0x1d8/0x450
> [  634.253884]  netlink_sendmsg from ____sys_sendmsg+0x188/0x258
> [  634.259656]  ____sys_sendmsg from ___sys_sendmsg+0x6c/0xa4
> [  634.265164]  ___sys_sendmsg from sys_sendmsg+0x50/0x98
> [  634.270324]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
> [  634.275569] Exception stack(0xf1071fa8 to 0xf1071ff0)
> [  634.280637] 1fa0:                   00000000 00000001 00000003 bef4d710 00000000 00000000
> [  634.288828] 1fc0: 00000000 00000001 b6f415a0 00000128 626ad475 00000000 00531cc0 00531cc0
> [  634.297016] 1fe0: 00000128 bef4d6b0 b6e3f6d3 b6db1ae6
> [  634.302150] irq event stamp: 3327
> [  634.305485] hardirqs last  enabled at (3335): [<c0195dbc>] __up_console_sem+0x50/0x60
> [  634.313404] hardirqs last disabled at (3344): [<c0195da8>] __up_console_sem+0x3c/0x60
> [  634.321318] softirqs last  enabled at (3230): [<c01017d0>] __do_softirq+0x2c0/0x57c
> [  634.329055] softirqs last disabled at (3187): [<c012f204>] __irq_exit_rcu+0x138/0x17c
> [  634.336971] ---[ end trace 0000000000000000 ]---
> root@imx6solo:~# ip link set dev ethphy1 up
> [  644.613564] sja1105 spi1.0 ethphy1: configuring for phy/mii link mode
> root@imx6solo:~# [  646.727549] sja1105 spi1.0 ethphy1: Link is Up -
> 100Mbps/Full - flow control off
> [  646.735033] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes ready

Ok. The WARN_ON() is saying that the DSA user port's phy_start() found
the attached PHY already in the RUNNING state. As if there was already
someone else driving it.

That "someone else" seems to be the FEC driver from the log above, which
for some reason has connected to the DP83849I by itself, and phylink/phylib
hasn't denied the second attempt to connect to the same PHY for some
reason.

If you look at fec_enet_mii_probe(), I see it has 2 code paths, one for
when fep->phy_node (defined as the "phy-handle" reference) is non-NULL,
and one for when it is NULL. What you're missing is a fixed-link
specifier in the device tree for FEC, otherwise it tries to call
phy_connect() to some random MDIO address on the bus and that breaks
things in some way which I don't understand.

The code which should have prevented this from happening is in
phy_attach_direct():

	if (phydev->attached_dev) {
		dev_err(&dev->dev, "PHY already attached\n");
		err = -EBUSY;
		goto error;
	}

