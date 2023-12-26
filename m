Return-Path: <linux-kernel+bounces-11405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895781E5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E83282E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F204C63C;
	Tue, 26 Dec 2023 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H4g+wpwB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E35F4C624
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbdaad42281so2471151276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703576479; x=1704181279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcN2trwxrRwThTluZ0EKmujYMNdtO9cPKjxhDXoH4uk=;
        b=H4g+wpwBa+JsY4TdzFRB6FapWp3NJHSrrJn9w1nsLha4aXx7cIShtJr/7lxbhL9qoh
         D4xtQifvUVaIeoasY+m03stWpF2xxJWNxtD4ff3HgzcD5RpmU6CEqnG7NdAzYxrC9IC0
         pVi2nBgY/FocPK/12GlSERDjQTH5c1c5PWbOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703576479; x=1704181279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcN2trwxrRwThTluZ0EKmujYMNdtO9cPKjxhDXoH4uk=;
        b=NHeoVHMWTyRuQCiAWJgW82DKRPFs/UqAB6vG0rhFTGQhTohJ4+fLZMfH7lo6Q/Gu7x
         rBvCHMoqJlB8IpOr1iNg4J6gSGXLpXLyELAJRwksek9QGcco3Bqw/NajhfepTW5z1vw4
         f2qEyOe+0SUC0eyJo6elxkpF2g/LJs9w3ytZ1TDD64AShTqEqj6yPlRm/xlAP3huZdH+
         /J/8Q44SuyWy5xFqKjUT3ISjiLML8R+PZjZxpxN17gWQad0qbS1GUXk5V8Ld8FhzBzjP
         L7VqKOknuxIKZ6LOZT6in1UPMV6bmtFbgAluMNbig85DRjABg4BmfMtxhNUYBBv0LUp1
         RxuA==
X-Gm-Message-State: AOJu0YwwZx8LebElCUaeneYX9OhQBHttTyFiJJ4eEFTe3CDxLClDx9yq
	wN84IdcLzDdJCMrX9Ow6hXlNUL8RZXpffV0Ehxl0ZQ1fQCSP3w==
X-Google-Smtp-Source: AGHT+IFtBUk35pT5i9/EpGz65EI1qJrJioiRYw7U4dCL10CAiZgnzwa/8aDWpvzSygVPmm9lha268CQHL7emgiPyIRY=
X-Received: by 2002:a25:db92:0:b0:dbd:d41b:b6ec with SMTP id
 g140-20020a25db92000000b00dbdd41bb6ecmr2583049ybf.37.1703576479573; Mon, 25
 Dec 2023 23:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
In-Reply-To: <20231222145100.sfcuux7ayxtxgogo@skbuf>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 26 Dec 2023 13:11:08 +0530
Message-ID: <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
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

On Fri, Dec 22, 2023 at 8:21=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Wed, Dec 20, 2023 at 12:49:30PM +0530, Jagan Teki wrote:
> > [ 1255.021656] Modules linked in: mdio_netlink(O) bnep tag_sja1105 sja1=
105 pcs_xpcs brcmfmac brcmutil imx_sdma coda_vpu v4l2_jpeg imx_vdoa evbug
> > [ 1255.034578] CPU: 0 PID: 374 Comm: ip Tainted: G           O       6.=
1.58 #1
>
> Can you please reproduce the issue with no out-of-tree modules used
> (here mdio_netlink)?

root@imx6solo:~# ip link set dev eth0 down
root@imx6solo:~# ip link set dev ethphy0 down
root@imx6solo:~# ip link set dev ethphy1 down
root@imx6solo:~# ip link set dev ethphy0 address 00:11:22:33:44:55
root@imx6solo:~# ip link set dev ethphy1 address 00:11:22:33:44:66
root@imx6solo:~# ip addr add dev ethphy0 192.168.1.1/16
root@imx6solo:~# ip addr add dev ethphy1 192.168.1.5/16
root@imx6solo:~# ip link set dev eth0 up
[  617.126753] dp83848_config_init: ret 0
[  617.130831] TI DP83849I 10/100 Mbps PHY 2188000.ethernet-1:00:
attached PHY driver (mii_bus:phy_addr=3D2188000.ethernet-1:00, irq=3DPOLL)
root@imx6solo:~# [  619.207519] fec 2188000.ethernet eth0: Link is Up
- 100Mbps/Full - flow control rx/tx
[  619.215698] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

root@imx6solo:~# ip link set dev ethphy0 up
[  634.114608] sja1105 spi1.0 ethphy0: configuring for phy/mii link mode
[  634.126617] ------------[ cut here ]------------
[  634.131463] WARNING: CPU: 0 PID: 330 at drivers/net/phy/phy.c:1157
phy_start+0x58/0xb4
[  634.139627] called from state RUNNING
[  634.143310] Modules linked in: bnep tag_sja1105 sja1105 pcs_xpcs
brcmfmac brcmutil imx_sdma coda_vpu v4l2_jpeg imx_vdoa evbug
[  634.154815] CPU: 0 PID: 330 Comm: ip Not tainted 6.1.58 #1
[  634.160321] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  634.166866]  unwind_backtrace from show_stack+0x10/0x14
[  634.172125]  show_stack from dump_stack_lvl+0x58/0x70
[  634.177205]  dump_stack_lvl from __warn+0x70/0x1a4
[  634.182023]  __warn from warn_slowpath_fmt+0x1bc/0x270
[  634.187181]  warn_slowpath_fmt from phy_start+0x58/0xb4
[  634.192427]  phy_start from dsa_port_enable_rt+0x54/0x9c
[  634.197765]  dsa_port_enable_rt from dsa_slave_open+0xb8/0x17c
[  634.203624]  dsa_slave_open from __dev_open+0xec/0x1ac
[  634.208788]  __dev_open from __dev_change_flags+0x18c/0x224
[  634.214377]  __dev_change_flags from dev_change_flags+0x14/0x44
[  634.220313]  dev_change_flags from do_setlink+0x254/0xe4c
[  634.225737]  do_setlink from rtnl_newlink+0x598/0x80c
[  634.230811]  rtnl_newlink from rtnetlink_rcv_msg+0x168/0x574
[  634.236485]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb8/0x11c
[  634.242337]  netlink_rcv_skb from netlink_unicast+0x1a8/0x2dc
[  634.248108]  netlink_unicast from netlink_sendmsg+0x1d8/0x450
[  634.253884]  netlink_sendmsg from ____sys_sendmsg+0x188/0x258
[  634.259656]  ____sys_sendmsg from ___sys_sendmsg+0x6c/0xa4
[  634.265164]  ___sys_sendmsg from sys_sendmsg+0x50/0x98
[  634.270324]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
[  634.275569] Exception stack(0xf1071fa8 to 0xf1071ff0)
[  634.280637] 1fa0:                   00000000 00000001 00000003
bef4d710 00000000 00000000
[  634.288828] 1fc0: 00000000 00000001 b6f415a0 00000128 626ad475
00000000 00531cc0 00531cc0
[  634.297016] 1fe0: 00000128 bef4d6b0 b6e3f6d3 b6db1ae6
[  634.302150] irq event stamp: 3327
[  634.305485] hardirqs last  enabled at (3335): [<c0195dbc>]
__up_console_sem+0x50/0x60
[  634.313404] hardirqs last disabled at (3344): [<c0195da8>]
__up_console_sem+0x3c/0x60
[  634.321318] softirqs last  enabled at (3230): [<c01017d0>]
__do_softirq+0x2c0/0x57c
[  634.329055] softirqs last disabled at (3187): [<c012f204>]
__irq_exit_rcu+0x138/0x17c
[  634.336971] ---[ end trace 0000000000000000 ]---
root@imx6solo:~# ip link set dev ethphy1 up
[  644.613564] sja1105 spi1.0 ethphy1: configuring for phy/mii link mode
root@imx6solo:~# [  646.727549] sja1105 spi1.0 ethphy1: Link is Up -
100Mbps/Full - flow control off
[  646.735033] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes ready

Thanks,
Jagan.

