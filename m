Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4116759275
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGSKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGSKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:13:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF11BF5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:13:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4Bu-0004Ck-SR; Wed, 19 Jul 2023 12:13:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4Bt-000Zxy-Ha; Wed, 19 Jul 2023 12:13:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4Bs-0064xt-Mq; Wed, 19 Jul 2023 12:13:52 +0200
Date:   Wed, 19 Jul 2023 12:13:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <20230719101352.qu7az5i5c5lrndwi@pengutronix.de>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
 <ZLaSqhsJr2qH5Y6E@orome>
 <20230718165716.77hllvxiwia542fu@pengutronix.de>
 <ZLeTZtQ_WVzuUqeM@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrbs3bhtrjfy2cxz"
Content-Disposition: inline
In-Reply-To: <ZLeTZtQ_WVzuUqeM@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrbs3bhtrjfy2cxz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 19, 2023 at 09:40:22AM +0200, Thierry Reding wrote:
> On Tue, Jul 18, 2023 at 06:57:16PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 18, 2023 at 03:24:58PM +0200, Thierry Reding wrote:
> > > Honestly, do we really need all of this complexity? I have specific
> > > configurations to test all of the PWM drivers to make sure they build.
> > > There's probably edge cases that don't get tested, but sooner or late=
r I
> > > expect some build bot will encounter those and then we can rectify
> > > things. But in many cases that I've seen COMPILE_TEST just happens to=
 do
> > > more harm than good.
> >=20
> > Without COMPILE_TEST you'd need to build at least for the following
> > archs to build all pwm drivers:
> >=20
> > 	armv4+5
> > 	armv7
> > 	armv7m
> > 	arm64
> > 	mips
> > 	riscv
> > 	shmobile
>=20
> This one is actually ARCH_RENESAS and is armv7.

Oh indeed. ARCH_RENESAS exists for both arm and shmobile. TIL

> > 	x86
>=20
> But yeah, those are the platforms that I build for. It's not terribly
> complicated to do since all of the above have publicly available cross-
> compilers that are easy to install. Also, most of the time I do
> incremental builds, so these are quite quick.
>=20
> > I personally like COMPILE_TEST as it reduces the number of needed test
> > builds to 1 (I think).
>=20
> Anyway, I wasn't arguing that we should get rid of COMPILE_TEST
> altogether, just that for cases like this it doesn't seem worth the
> extra complexity. RZ_MTU3 is an MFD and already || COMPILE_TEST, so
> we can easily always enable it.

Ah, I got that wrong then. I can life with this one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jrbs3bhtrjfy2cxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS3t18ACgkQj4D7WH0S
/k4xkQf+M9+uo2n/1QUJe2bX8esbDfAochDzkspw8gFeeigdfQvYAAmDORl4uk1J
Tiy7wfFWUnQrvt/KYhxBsOHPxpH5v/VmR5iNrj1DXYzRk6xu9rcJLB+9ye53Ur6P
mDcBfbAc+lnAhxMAMcWi/uwO8wo7nAuVWLHmvKtITYDm1l+sfhMTiWzL0W6fpirF
4074W68dScEllINje8QS9xnS4e5YjtYLq+83ETnqyQb/d/a9bKepU1JhvHxjmBUB
HZcb9MTxk8/wPhNhrzKWP6dM0KKcXUpnP3MN2wqSy1MEnZloR8OOBmT6yObwLnQG
qxfac0wSb7UzfGxI+1XyDXpoCnx+vA==
=2ziz
-----END PGP SIGNATURE-----

--jrbs3bhtrjfy2cxz--
