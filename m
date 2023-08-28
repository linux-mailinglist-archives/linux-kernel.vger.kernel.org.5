Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019B78A925
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjH1JpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjH1Jod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:44:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3642103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:44:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaYmy-0006ra-8t; Mon, 28 Aug 2023 11:44:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaYmv-002BLV-LR; Mon, 28 Aug 2023 11:44:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaYmv-00GkIv-1x; Mon, 28 Aug 2023 11:44:01 +0200
Date:   Mon, 28 Aug 2023 11:43:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Carsten =?utf-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Message-ID: <20230828094357.tdlzntuycsehsmu6@pengutronix.de>
References: <cover.1692623638.git.mail@carsten-spiess.de>
 <d510d6f7f65c95d5cff1b8e8a4dcd5675bd100fd.1692623638.git.mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxh2tttbileuzupu"
Content-Disposition: inline
In-Reply-To: <d510d6f7f65c95d5cff1b8e8a4dcd5675bd100fd.1692623638.git.mail@carsten-spiess.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxh2tttbileuzupu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Carsten,

On Mon, Aug 21, 2023 at 06:40:03PM +0200, Carsten Spie=DF wrote:
> +static struct i2c_driver isl28022_driver =3D {
> +	.class		=3D I2C_CLASS_HWMON,
> +	.driver =3D {
> +		.name	=3D "isl28022",
> +	},
> +	.probe_new	=3D isl28022_probe,

Please use .probe instead of .probe_new. Apart from s/probe_new/probe/
here nothing further is needed.

My plan is to drop .probe_new in next soon after v6.6-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mxh2tttbileuzupu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTsbFwACgkQj4D7WH0S
/k7a7wf+MaXh0uwDFsbCNb8ohW72XaVnEiUzpn9onziOrbvabzMctWIStLwRBTl2
2qZ24HmPbzF9vzEakBb9fMZkFEb5bjnxLf59jR9Z/Gvwe9WHgm0qvezeUS6zEcs3
VAEslFSwAzgv+47YwNrNZkaxIyD5U9x8Nb4YbQaGxGnYb3mRjuNZXao+Gzbcn8wo
N50vH/s9vlrgPGx2lhdncP1sFlYGB9sc7rqfG0Gr/gbtiZYRPiX9pVaQ//HgIGQW
53xnUn+dw/AuFspgc6tG0VhWIj8Mra50/zseBrrigIRLk2vl0F5XahTQqR94JjTy
wnkzqfohOOmH3evW3Y5BOkuljakd6w==
=Ub8Z
-----END PGP SIGNATURE-----

--mxh2tttbileuzupu--
