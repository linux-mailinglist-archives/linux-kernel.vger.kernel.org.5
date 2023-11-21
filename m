Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA85D7F2786
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKUIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:32:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3708F95
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:32:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5MBb-00072e-2K; Tue, 21 Nov 2023 09:32:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5MBa-00AXR2-I0; Tue, 21 Nov 2023 09:32:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5MBa-004qyX-8j; Tue, 21 Nov 2023 09:32:46 +0100
Date:   Tue, 21 Nov 2023 09:32:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
        Amit Dhingra <mechanicalamit@gmail.com>
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
Message-ID: <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
 <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
 <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="li7yy6xvutejqnwg"
Content-Disposition: inline
In-Reply-To: <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--li7yy6xvutejqnwg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 09:19:13AM +0100, Markus Elfring wrote:
> >>>>> Static structs are initialized with zeros for unspecified fields.
> >>>>> So there is no advantage to explicitly initialize .remove with NULL
> >>>>> and the assignment can be dropped without side effects.
> =E2=80=A6
> > Removing =3D 0 assignments should be carefully reviewed. I skimmed the
> > changes to drivers/pwm and would oppose to both changes.
>=20
> How does this development view fit to information from the patch descript=
ion?

They are syntactically fine as they don't change the semantic of the
code. But assignments to NULL (and still more to 0) also serve the human
reader as documentation.

Look at the patch for drivers/pwm/pwm-samsung.c:

diff -u -p a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -478,21 +478,17 @@ static const struct samsung_pwm_variant
=20
 static const struct samsung_pwm_variant s3c64xx_variant =3D {
 	.bits		=3D 32,
-	.div_base	=3D 0,
 	.has_tint_cstat	=3D true,
 	.tclk_mask	=3D BIT(7) | BIT(6) | BIT(5),
 };
=20
 static const struct samsung_pwm_variant s5p64x0_variant =3D {
 	.bits		=3D 32,
-	.div_base	=3D 0,
 	.has_tint_cstat	=3D true,
-	.tclk_mask	=3D 0,
 };
=20
 static const struct samsung_pwm_variant s5pc100_variant =3D {
 	.bits		=3D 32,
-	.div_base	=3D 0,
 	.has_tint_cstat	=3D true,
 	.tclk_mask	=3D BIT(5),
 };

If I saw the resulting code, I'd wonder about the missing assignments
in these three structs. So IMHO the status quo is better even though it
is more verbose.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--li7yy6xvutejqnwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVcay0ACgkQj4D7WH0S
/k5Srgf/cqBerXOEHw4lusrfnwcRb3Ki/y6uRchce5a3eSyYZRHCfZjA+/obZrsu
4GCuRb2OoKKQzqE7kfjkMqZzdK4It65Dz14YNu5eBSvFEWftRJUY2bqIkDpAV1n7
qn87RS6i3CrWKoDTfmKVQOOOvdtoVVhCIzIoR7/3R9PKkYpdVzGNbl0bhuMoKrTJ
0boVxkij5vVGXz3m6xvpx8xJ3egVObmcj41DTBbe6ipVRklbGQmwWzs7YAW2t4cF
VceGcpIvpF37IMYWuSbp3PkAPSqeowjrMbUqrCE6+dBT4pMLHPMZZqplaBF93IwT
dZJcdeVjhSHdi/0RmtO5i0A5Njz3TA==
=pSIX
-----END PGP SIGNATURE-----

--li7yy6xvutejqnwg--
