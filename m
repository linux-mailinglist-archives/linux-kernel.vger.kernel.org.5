Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026FF757754
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGRJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGRJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:03:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A995FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:03:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgc8-0007Bk-3E; Tue, 18 Jul 2023 11:03:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgc7-000Kzf-B4; Tue, 18 Jul 2023 11:03:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgc6-005oNj-L3; Tue, 18 Jul 2023 11:03:22 +0200
Date:   Tue, 18 Jul 2023 11:03:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Randy Dunlap <rd.dunlab@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <20230718090320.ns4d3aaqpmppt4gt@pengutronix.de>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plaf3xg2dccs477t"
Content-Disposition: inline
In-Reply-To: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
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


--plaf3xg2dccs477t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 11:41:06PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rd.dunlab@gmail.com>
>=20
> When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build erro=
rs:
>=20
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit_c=
h_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_w=
rite'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_w=
rite'
> ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bit_=
ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disabl=
e'
> ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit_c=
h_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabled'
> ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit_c=
h_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_r=
ead'
> ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_=
ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bit_=
ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_re=
ad'
>=20
> Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
> but also allow the latter not to be built.
>=20
> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org

I missed this v2 while I still looked at (implicit) v1. The things I
said there still apply for v2. I don't repeat my writings, but here is a
link to the archive with what I wrote:

	https://lore.kernel.org/linux-pwm/20230718090023.wo6m6ffzaifgctkj@pengutro=
nix.de/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--plaf3xg2dccs477t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS2VVcACgkQj4D7WH0S
/k4ecAgAkM/NEJ5PP0iofIu8pTnn0qGSaXoUQXdt7kT+QfXqTTAltVZvbmLqgVAm
VBREIjeJ7eLyXozsn1MPFk3RtBQxP3uz53fE//h3FNvK91Mr3B53T+7QPC+GvDV1
8ZHI3iH5eni8KXgu9k1s/ULbA4S9NKG0fJLG/5L8C93XMC7SaIVgKvCJDYxI8Mqw
PJ+FmqIJv+V2dbuYpCKlmAh0oZhrjeQiuKchZ0QRGHRhthkx9+wFN5JmKmJf6j7L
tHNjvGNRo6JnMYycfaII4iL0yS0j5JNQKgSEbQ/LDEk7Xm09uOSTEzCeBwzZ1hm8
s5gYq9bfwVP33sKclymBhvOAFACvbw==
=3D+z
-----END PGP SIGNATURE-----

--plaf3xg2dccs477t--
