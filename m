Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87D7BEA9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378344AbjJITaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbjJITar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:30:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B6AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:30:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpvxa-0004aW-PB; Mon, 09 Oct 2023 21:30:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpvxZ-000UJS-07; Mon, 09 Oct 2023 21:30:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpvxY-00CWYe-Mq; Mon, 09 Oct 2023 21:30:32 +0200
Date:   Mon, 9 Oct 2023 21:30:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] pwm: Use device_get_match_data()
Message-ID: <20231009193032.y7vn2bnluqhrfmmy@pengutronix.de>
References: <20231009172923.2457844-21-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4ssm2ues5etelul"
Content-Disposition: inline
In-Reply-To: <20231009172923.2457844-21-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4ssm2ues5etelul
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 12:29:16PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pwm/pwm-img.c      | 8 ++------
>  drivers/pwm/pwm-rockchip.c | 9 ++-------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 326af85888e7..e32b5e8c203d 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -13,9 +13,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -261,7 +261,6 @@ static int img_pwm_probe(struct platform_device *pdev)
>  	u64 val;
>  	unsigned long clk_rate;
>  	struct img_pwm_chip *imgchip;
> -	const struct of_device_id *of_dev_id;
> =20
>  	imgchip =3D devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
>  	if (!imgchip)
> @@ -273,10 +272,7 @@ static int img_pwm_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(imgchip->base))
>  		return PTR_ERR(imgchip->base);
> =20
> -	of_dev_id =3D of_match_device(img_pwm_of_match, &pdev->dev);
> -	if (!of_dev_id)
> -		return -ENODEV;
> -	imgchip->data =3D of_dev_id->data;
> +	imgchip->data =3D device_get_match_data(&pdev->dev);

Is this a semantical change? If there is a match, the code is
equivalent. Otherwise it was:

	return -ENODEV;

before and now it's

	imgchip->data =3D NULL;

isn't it?

>  	imgchip->periph_regs =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_n=
ode,
>  							       "img,cr-periph");
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 03ee18fb82d5..339165ef1f07 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -10,8 +10,8 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/time.h>
> =20
> @@ -297,16 +297,11 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
> =20
>  static int rockchip_pwm_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *id;
>  	struct rockchip_pwm_chip *pc;
>  	u32 enable_conf, ctrl;
>  	bool enabled;
>  	int ret, count;
> =20
> -	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> -	if (!id)
> -		return -EINVAL;
> -
>  	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
>  		return -ENOMEM;
> @@ -345,7 +340,7 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, pc);
> =20
> -	pc->data =3D id->data;
> +	pc->data =3D device_get_match_data(&pdev->dev);
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &rockchip_pwm_ops;
>  	pc->chip.npwm =3D 1;

This has the same semantical change.

If this change is ok, it IMHO needs a more verbose commit log.

Best regards
Uwe
=20
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b4ssm2ues5etelul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUkVNcACgkQj4D7WH0S
/k410wf/XHMt6hh90SKkqHpgUzDi2hphcdwAwpbBNl+kFGlxlCfE2Nei/c5UXFL7
+f1VaEeTwk5oP11cZekezkN15BFqlOb9ppgttRaQwYRpiSFlUaJ4JtHKLNEcTAKN
bvQWffqdmRY1D2rw4aa1tHWce95IEb2pxgIFqhJd3RN2l94+qurOD0aRQj7YH9Mz
KDRq0t26Rph5PvXn+SKcg68YAvkzn1imVTLumKggDRyWf2rL/xAbFq6byHk/GcJ7
DJQcTWLPI0zJc1Ck5T3EFvBvRoeRKUHi32Xm3eOOksgQTTEBBqQDW0rBWnj5OESY
pg/eTzQx5mWz+hP4OtRyd1iiIG1+vw==
=n1+d
-----END PGP SIGNATURE-----

--b4ssm2ues5etelul--
