Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC969758362
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGRRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjGRRV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:21:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45345FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:21:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLo0m-00010G-OY; Tue, 18 Jul 2023 18:57:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLo0l-000PjC-M0; Tue, 18 Jul 2023 18:57:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLo0l-005tiu-0o; Tue, 18 Jul 2023 18:57:19 +0200
Date:   Tue, 18 Jul 2023 18:57:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <20230718165716.77hllvxiwia542fu@pengutronix.de>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
 <ZLaSqhsJr2qH5Y6E@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54k5bi5rqes63ekj"
Content-Disposition: inline
In-Reply-To: <ZLaSqhsJr2qH5Y6E@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--54k5bi5rqes63ekj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 03:24:58PM +0200, Thierry Reding wrote:
> On Tue, Jul 18, 2023 at 02:05:42PM +0200, Geert Uytterhoeven wrote:
> > Hi Randy,
> >=20
> > On Tue, Jul 18, 2023 at 8:44=E2=80=AFAM Randy Dunlap <rd.dunlab@gmail.c=
om> wrote:
> > > From: Randy Dunlap <rd.dunlab@gmail.com>
> > >
> > > When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build =
errors:
> > >
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disabl=
e'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8b=
it_ch_write'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_=
ch_write'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_c=
h_write'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_=
ch_write'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16=
bit_ch_write'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> > > drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_c=
h_write'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_di=
sable'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> > > drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_c=
h_write'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8b=
it_ch_write'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_en=
able'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> > > drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_ena=
bled'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8b=
it_ch_read'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> > > drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_=
ch_read'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16=
bit_ch_read'
> > > ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16=
bit_ch_read'
> > > ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> > > drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_c=
h_read'
> > >
> > > Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> > > still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
> > > but also allow the latter not to be built.
> > >
> > > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > > Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
> >=20
> > Thanks for your patch!
> >=20
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
> > >
> > >  config PWM_RZ_MTU3
> > >         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > -       depends on RZ_MTU3 || COMPILE_TEST
> > > +       depends on COMPILE_TEST
> >=20
> > This makes the driver always depend on COMPILE_TEST,
> > which is definitely not what we want.
>=20
> Honestly, do we really need all of this complexity? I have specific
> configurations to test all of the PWM drivers to make sure they build.
> There's probably edge cases that don't get tested, but sooner or later I
> expect some build bot will encounter those and then we can rectify
> things. But in many cases that I've seen COMPILE_TEST just happens to do
> more harm than good.

Without COMPILE_TEST you'd need to build at least for the following
archs to build all pwm drivers:

	armv4+5
	armv7
	armv7m
	arm64
	mips
	riscv
	shmobile
	x86

I personally like COMPILE_TEST as it reduces the number of needed test
builds to 1 (I think).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--54k5bi5rqes63ekj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS2xGsACgkQj4D7WH0S
/k6QfQf/cz/mg3s7MJLDt06TZRSQSOGXB3fuXFca4y1SOz5MRbyLXnNvW892Dp44
LG0v9KqKn9yvbSG0LDPpZvU30DBbaC0oToeT8kVWPi/Y0iu3PJPGgdfBMotUW4Ws
fCaSua0JGRKINb8c7Fdsx0EMWSg5xYjz+T8ztg9ISB5ax7W2HSHu6N/UvBq4SbPz
V7/mtbrlhJJDBA4oc4Sb2BhpIXiPtfVJWC73oYd7gzhu65SgLfD1NoTYSp7UqPJa
n4UYBuZJir9JMgG7dtrC8R+fkND99BMUl5VOY+YzyivAnHUav5c/7Z0TK3GIT+ew
0ZDNRbL6xZqcdbjM2AWSs9x2Z6zS5Q==
=zKgn
-----END PGP SIGNATURE-----

--54k5bi5rqes63ekj--
