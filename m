Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915637F26C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKUH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:57:25 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACEDC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:57:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5LdF-00087q-8G; Tue, 21 Nov 2023 08:57:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5LdE-00AWvb-Lf; Tue, 21 Nov 2023 08:57:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5LdE-004qWr-CN; Tue, 21 Nov 2023 08:57:16 +0100
Date:   Tue, 21 Nov 2023 08:57:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Amit Dhingra <mechanicalamit@gmail.com>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
        linux-spi@vger.kernel.org
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
Message-ID: <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6a3voyp4n6fauivi"
Content-Disposition: inline
In-Reply-To: <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
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


--6a3voyp4n6fauivi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 08:34:35AM +0100, Markus Elfring wrote:
> >>> Static structs are initialized with zeros for unspecified fields.
> >>> So there is no advantage to explicitly initialize .remove with NULL
> >>> and the assignment can be dropped without side effects.
> >>
> >> Would you become interested to delete redundant initialisation repetit=
ions
> >> at any more source code places?
> >>
> >> A corresponding script for the semantic patch language (Coccinelle sof=
tware)
> >> can point more remaining update candidates out for various components.
> >
> > Coccinelle shows 471 files.
>=20
> I got the impression that more source code places can be reconsidered acc=
ordingly.
>=20
> @deletion@
> identifier member, s, var;
> @@
>  static struct s var =3D
>  {
>  ...,
> -.member =3D \( 0 \| NULL \) ,
>  ...
>  };
>=20
>=20
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> rg '^-\s' =
=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/delete_NULL_assignment_in_s=
tatic_struct-20231117.diff | wc -l
> 6567

Removing =3D 0 assignments should be carefully reviewed. I skimmed the
changes to drivers/pwm and would oppose to both changes. Even for my
patch I wasn't sure if it's a good idea and talked to Mark before
sending it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6a3voyp4n6fauivi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVcYtsACgkQj4D7WH0S
/k7aOAgAmw6b08lNM0KVuD1mWeH8O0F945eBgGHR+dlXSFK4qBWH3gxL5hJNZ1K7
8A0o9C4Wr09PjuAxSH2v4NNLVVSZJ6DMDirGHL09v7m0Bo96/9OKXa7L29ImikZb
hX4hZjPcMwjgZIHfX3z68IiIWvh7ZLMnqnSgMejfBMqsgKxOGnT+rPQHAIlSd+Kv
Jzc1szjGNG18gbVbvx/E5Z4iMTnZHc0WlGIigUOJKWTJJh1FdmCXkeLD16ETO3ZT
iwQGGJ06o8gjicnzoGILvwFxvtpc6duv5YqlX44DjyZA6oX4UhntpGr1xDyk9GdV
4nTgL/4DyVbcQwyOASd7ELZPbr5lig==
=HrY5
-----END PGP SIGNATURE-----

--6a3voyp4n6fauivi--
