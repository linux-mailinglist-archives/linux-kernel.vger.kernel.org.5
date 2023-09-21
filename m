Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55D7A9EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjIUUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIUUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:09:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE665A0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:56:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPmW-0000I3-Nv; Thu, 21 Sep 2023 21:56:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPmS-00803P-Vj; Thu, 21 Sep 2023 21:56:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjPmS-003iAF-Jd; Thu, 21 Sep 2023 21:56:08 +0200
Date:   Thu, 21 Sep 2023 21:56:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: use per-queue 64 bit
 statistics where necessary
Message-ID: <20230921195608.dlol2f6fifx6ahd6@pengutronix.de>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <11fce633-4699-470f-a2f3-94b99b3e6da6@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnzxc5jwo3r4gi2f"
Content-Disposition: inline
In-Reply-To: <11fce633-4699-470f-a2f3-94b99b3e6da6@roeck-us.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnzxc5jwo3r4gi2f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Thu, Sep 21, 2023 at 11:34:09AM -0700, Guenter Roeck wrote:
> On Tue, Jul 18, 2023 at 12:06:30AM +0800, Jisheng Zhang wrote:
> > Currently, there are two major issues with stmmac driver statistics
> > First of all, statistics in stmmac_extra_stats, stmmac_rxq_stats
> > and stmmac_txq_stats are 32 bit variables on 32 bit platforms. This
> > can cause some stats to overflow after several minutes of
> > high traffic, for example rx_pkt_n, tx_pkt_n and so on.
> >=20
> > Secondly, if HW supports multiqueues, there are frequent cacheline
> > ping pongs on some driver statistic vars, for example, normal_irq_n,
> > tx_pkt_n and so on. What's more, frequent cacheline ping pongs on
> > normal_irq_n happens in ISR, this makes the situation worse.
> >=20
> > To improve the driver, we convert those statistics to 64 bit, implement
> > ndo_get_stats64 and update .get_ethtool_stats implementation
> > accordingly. We also use per-queue statistics where necessary to remove
> > the cacheline ping pongs as much as possible to make multiqueue
> > operations faster. Those statistics which are not possible to overflow
> > and not frequently updated are kept as is.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>=20
> Your patch results in lockdep splats. This is with the orangepi-pc
> emulation in qemu.
>=20
> [   11.126950] dwmac-sun8i 1c30000.ethernet eth0: PHY [mdio_mux-0.1:01] d=
river [Generic PHY] (irq=3DPOLL)
> [   11.127912] dwmac-sun8i 1c30000.ethernet eth0: No Safety Features supp=
ort found
> [   11.128294] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Count=
ers available
> [   11.128511] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
> [   11.138990] dwmac-sun8i 1c30000.ethernet eth0: configuring for phy/mii=
 link mode
> [   11.144387] INFO: trying to register non-static key.
> [   11.144483] The code is fine but needs lockdep annotation, or maybe
> [   11.144568] you didn't initialize this object before use?
> [   11.144640] turning off the locking correctness validator.
> [   11.144845] CPU: 2 PID: 688 Comm: ip Tainted: G                 N 6.6.=
0-rc2 #1
> [   11.144956] Hardware name: Allwinner sun8i Family
> [   11.145137]  unwind_backtrace from show_stack+0x10/0x14
> [   11.145610]  show_stack from dump_stack_lvl+0x68/0x90
> [   11.145692]  dump_stack_lvl from register_lock_class+0x99c/0x9b0
> [   11.145779]  register_lock_class from __lock_acquire+0x6c/0x2244
> [   11.145861]  __lock_acquire from lock_acquire+0x11c/0x368
> [   11.145938]  lock_acquire from stmmac_get_stats64+0x350/0x374
> [   11.146021]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
> [   11.146101]  dev_get_stats from rtnl_fill_stats+0x30/0x118
> [   11.146179]  rtnl_fill_stats from rtnl_fill_ifinfo.constprop.0+0x82c/0=
x1770
> [   11.146273]  rtnl_fill_ifinfo.constprop.0 from rtmsg_ifinfo_build_skb+=
0xac/0x138
> [   11.146370]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x44/0x7c
> [   11.146452]  rtmsg_ifinfo from __dev_notify_flags+0xac/0xd8
> [   11.146531]  __dev_notify_flags from dev_change_flags+0x48/0x54
> [   11.146612]  dev_change_flags from do_setlink+0x244/0xe6c
> [   11.146689]  do_setlink from rtnl_newlink+0x514/0x838
> [   11.146761]  rtnl_newlink from rtnetlink_rcv_msg+0x170/0x5b0
> [   11.146841]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x10c
> [   11.146925]  netlink_rcv_skb from netlink_unicast+0x190/0x254
> [   11.147006]  netlink_unicast from netlink_sendmsg+0x1dc/0x460
> [   11.147086]  netlink_sendmsg from ____sys_sendmsg+0xa0/0x2a0
> [   11.147168]  ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
> [   11.147245]  ___sys_sendmsg from sys_sendmsg+0x4c/0x88
> [   11.147329]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
> [   11.147439] Exception stack(0xf23edfa8 to 0xf23edff0)
> [   11.147558] dfa0:                   00000000 00000000 00000003 bef9a8d=
8 00000000 00000000
> [   11.147668] dfc0: 00000000 00000000 ffffffff 00000128 00000001 0000000=
2 bef9af4a bef9af4d
> [   11.147769] dfe0: bef9a868 bef9a858 b6f9ddac b6f9d228
> [   11.150020] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 100Mbps/Fu=
ll - flow control rx/tx
>=20
> My apologies for the noise if this has already been reported.

This seems to be the issue I reported earlier. So you might want to test
the patch that fixed it for me:
https://lore.kernel.org/netdev/20230917165328.3403-1-jszhang@kernel.org/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pnzxc5jwo3r4gi2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMn9gACgkQj4D7WH0S
/k7rUgf8Do4jrDAFY1lWHDffdvpiTZaBLWA4KR4avRZTYWxyJfadl2V2mMRtjCm0
WQGg5FGLCVCtRGfQEkWaH8xUGxRbGoKBoE+b0LW6qT4QMCPnMBhuXjLdjcSUw2/U
pw2YIGBLIadA2FiT8XdVf5Fcw7zXe02Or+ay7Fm3ZZZhgPCch3dWNlfKgICGSvu/
QIitK/7a5CJN79vCBtDKtaHR8dd9K4DpbTSvrruFMfMaIlq65u6S/q5FhtAIA5gi
SPIz51s7sljwAp9s/0fsEhPOh/13DyJHsc1T4efsGT9ARv3mTAsTC8Nlo34Eb3EI
kcvjIOsje+QB67aM9ixc8dswHhCvQA==
=TTJ7
-----END PGP SIGNATURE-----

--pnzxc5jwo3r4gi2f--
