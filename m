Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D778A9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjH1KPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjH1KPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:15:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E809C1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:15:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaZGv-0002t3-Ke; Mon, 28 Aug 2023 12:15:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaZGt-002BsM-T2; Mon, 28 Aug 2023 12:14:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qaZGt-00GlUB-02; Mon, 28 Aug 2023 12:14:59 +0200
Date:   Mon, 28 Aug 2023 12:14:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] USB: typec: Add TI TPS25750 USB Type-C controller
Message-ID: <20230828101456.3245zuhlqdjjxzqy@pengutronix.de>
References: <cover.1692559293.git.alkuor@gmail.com>
 <b7525b3501782c04172809cbe8b21bbb97fed863.1692559293.git.alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ldix2bjvvef5wne"
Content-Disposition: inline
In-Reply-To: <b7525b3501782c04172809cbe8b21bbb97fed863.1692559293.git.alkuor@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ldix2bjvvef5wne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Aug 20, 2023 at 03:32:27PM -0400, Abdel Alkuor wrote:
> +static struct i2c_driver tps25750_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "tps25750",
> +		.pm =3D pm_ptr(&tps25750_pm_ops),
> +		.of_match_table =3D tps25750_of_match,
> +	},
> +	.probe_new =3D tps25750_probe,
> +	.remove =3D tps25750_remove,
> +	.id_table =3D tps25750_id,
> +};

Please use .probe instead of .probe_new. Apart from just dropping "_new"
here, nothing is needed. .probe_new will go away soon.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ldix2bjvvef5wne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTsc58ACgkQj4D7WH0S
/k7o/Af+KKw3hKCLlbrEDlAeAh1Suk/4QvHSJqLu2du9hkk9iyRTNKovFvAiqZgL
50Pf1b5nO18x77tL9e26dd7jxe0HFVlYGwqvKYaUhogN4qPq1r4xqbublpJJplif
n85SKJcQSmq6F/j8mpD86Bl8VEnWDPQzwgBOq04N1VQYaIaoX5Ti/CYT6pK5djiC
ZG16vSjF6Ds6GJI8oRmwb9It7XUJxUXlR/gkXUlO80bjBkQHp3LsMIXHL5F+SdmT
YiezN92mmpMfvVlBPKm+Pn6R0w7L4xRW11W4OzB08+LRKLg8TbpQRif2GOAUh5kz
L+NxVgu9UHVNFaZfyV4E9rs2i7UcTA==
=lKsM
-----END PGP SIGNATURE-----

--4ldix2bjvvef5wne--
