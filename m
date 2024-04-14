Return-Path: <linux-kernel+bounces-144063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531EA8A4164
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B684F1F21C45
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7848225CE;
	Sun, 14 Apr 2024 09:05:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604418AEA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085552; cv=none; b=h/ATwhDmD+PFlGUhYiQfMUFJK3H1XTw9/W+OAM1AcYWZbI5GnUgklZ1U2f1W/q7QLjcKiSeqofIfzXY5qFkAHzJDxCYTV5c5q4NLN8Jou+O+BvzSSYzj9GkEl/5vXQuG2y2m8koZU+xCey61iWF1F0DhF0885pkNSDItZAd36Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085552; c=relaxed/simple;
	bh=eUQSUFsqzUC4ARHWh09c/+7xh9a4BPEUv4J3aTZ78E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wiiki1aATqEWUxVGXxAF0V/6d/apk8qyUguHGUJ3osf5/SYW6sxK8dhsPBczzKJOAlx5yyu7f+b2hJ/tNSAMt/oOFvf0vtuwFHb0xRK8XneJqA59V3O3BHUj6xE2d8FhQRfWH9eQkQO0sxORXHHPc0B28Y7t4JbdFK1Vs1AK10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvvnt-0000E5-DD; Sun, 14 Apr 2024 11:05:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvvnr-00CDYm-Sy; Sun, 14 Apr 2024 11:05:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvvnr-0015XN-2b;
	Sun, 14 Apr 2024 11:05:35 +0200
Date: Sun, 14 Apr 2024 11:05:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dlechner@baylibre.com
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: support version 2.00.a
Message-ID: <2by7rakflv22s6uk2e2jk5lw65erjljpwdxdxg3z73furlprj5@2qlacusapkgr>
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
 <20240314204722.1291993-3-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6obdirpcc2cza6oe"
Content-Disposition: inline
In-Reply-To: <20240314204722.1291993-3-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6obdirpcc2cza6oe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Thu, Mar 14, 2024 at 04:47:22PM -0400, Trevor Gamblin wrote:
> This adds support for the AXI PWMGEN v2 IP block. This version is
> nearly identical to v1 other than it supports up to 16 channels instead
> of 4 and a few of the memory mapped registers have moved.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  drivers/pwm/pwm-axi-pwmgen.c | 62 ++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 0c8f7f893a21..539625c404ac 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -32,16 +32,25 @@
>  #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
>  #define AXI_PWMGEN_REG_CONFIG		0x10
>  #define AXI_PWMGEN_REG_NPWM		0x14
> -#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
> -#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
> -#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step * =
(ch))
> +#define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step * (ch))
> +#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step * =
(ch))
>  #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification numbe=
r to test during setup */
>  #define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
>  #define AXI_PWMGEN_RESET		BIT(0)
> =20
> +struct axi_pwm_variant {
> +	u8 period_base;
> +	u8 duty_base;
> +	u8 offset_base;
> +	u8 major_version;
> +	u8 ch_step;
> +};
> +
>  struct axi_pwmgen_ddata {
>  	struct regmap *regmap;
>  	unsigned long clk_rate_hz;
> +	const struct axi_pwm_variant *variant;
>  };
> =20
>  static const struct regmap_config axi_pwmgen_regmap_config =3D {
> @@ -50,12 +59,30 @@ static const struct regmap_config axi_pwmgen_regmap_c=
onfig =3D {
>  	.val_bits =3D 32,
>  };
> =20
> +static const struct axi_pwm_variant pwmgen_1_00_variant =3D {
> +	.period_base =3D 0x40,
> +	.duty_base =3D 0x44,
> +	.offset_base =3D 0x48,
> +	.major_version =3D 1,
> +	.ch_step =3D 12,
> +};
> +
> +static const struct axi_pwm_variant pwmgen_2_00_variant =3D {
> +	.period_base =3D 0x40,
> +	.duty_base =3D 0x80,
> +	.offset_base =3D 0xC0,
> +	.major_version =3D 2,
> +	.ch_step =3D 4,
> +};

My first intuition to model the register differences would have been
something like:

	#define ..._PERIOD 0
	#define ..._DUTY 1
	#define ..._OFFSET 2

and then store a "register_step"(?) variable (which is 0x4 for v1 and
0x40 for v2) in the variant struct and then use:

#define AXI_PWMGEN_CHX_PERIOD(v, ch)	(0x40 + (v)->ch_step * (ch))
#define AXI_PWMGEN_CHX_DUTY(v, ch)	(0x40 + (v)->register_step + (v)->ch_ste=
p * (ch))
#define AXI_PWMGEN_CHX_OFFSET(v, ch)	(0x40 + 2 * (v)->register_step + (v)->=
ch_step * (ch))

This saves a tiny bit of memory, not entirely sure this is a good idea.
Pick it up if you like, or keep your approach, I don't care much.

> +
>  static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>  			    const struct pwm_state *state)
>  {
>  	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
>  	unsigned int ch =3D pwm->hwpwm;
>  	struct regmap *regmap =3D ddata->regmap;
> +	const struct axi_pwm_variant *variant =3D ddata->variant;
>  	u64 period_cnt, duty_cnt;
>  	int ret;
> =20
> @@ -70,7 +97,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  		if (period_cnt =3D=3D 0)
>  			return -EINVAL;
> =20
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), perio=
d_cnt);
>  		if (ret)
>  			return ret;
> =20
> @@ -78,15 +105,15 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		if (duty_cnt > UINT_MAX)
>  			duty_cnt =3D UINT_MAX;
> =20
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), duty_cn=
t);
>  		if (ret)
>  			return ret;
>  	} else {
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), 0);
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), 0);
>  		if (ret)
>  			return ret;
>  	}
> @@ -99,11 +126,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  {
>  	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
>  	struct regmap *regmap =3D ddata->regmap;
> +	const struct axi_pwm_variant *variant =3D ddata->variant;
>  	unsigned int ch =3D pwm->hwpwm;
>  	u32 cnt;
>  	int ret;
> =20
> -	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), &cnt);
>  	if (ret)
>  		return ret;
> =20
> @@ -111,7 +139,7 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
> =20
>  	state->period =3D DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_=
rate_hz);
> =20
> -	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), &cnt);
>  	if (ret)
>  		return ret;
> =20
> @@ -127,7 +155,8 @@ static const struct pwm_ops axi_pwmgen_pwm_ops =3D {
>  	.get_state =3D axi_pwmgen_get_state,
>  };
> =20
> -static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev,=
=20
> +			    const struct axi_pwm_variant *variant)
>  {
>  	int ret;
>  	u32 val;
> @@ -146,7 +175,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, st=
ruct device *dev)
>  	if (ret)
>  		return ret;
> =20
> -	if (ADI_AXI_PCORE_VER_MAJOR(val) !=3D 1) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(val) !=3D variant->major_version) {
>  		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.=
%u.%u\n",

Hmm, is it worth to also diagnose a mismatch here? That is if the dt
tells this was a version 2 device but the register says version 1? In
this case

	Unsupported peripheral version 1.x.y

might be misleading, because version 1 is supported and the problem is
maybe only a wrong dt?

>  			ADI_AXI_PCORE_VER_MAJOR(val),
>  			ADI_AXI_PCORE_VER_MINOR(val),
> @@ -178,9 +207,14 @@ static int axi_pwmgen_probe(struct platform_device *=
pdev)
>  	struct pwm_chip *chip;
>  	struct axi_pwmgen_ddata *ddata;
>  	struct clk *clk;
> +	const struct axi_pwm_variant *variant;
>  	void __iomem *io_base;
>  	int ret;
> =20
> +	variant =3D device_get_match_data(dev);
> +	if (!variant)
> +		return -EINVAL;
> +
>  	io_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(io_base))
>  		return PTR_ERR(io_base);
> @@ -190,7 +224,7 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "failed to init register map\n");
> =20
> -	ret =3D axi_pwmgen_setup(regmap, dev);
> +	ret =3D axi_pwmgen_setup(regmap, dev, variant);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -199,6 +233,7 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(chip);
>  	ddata =3D pwmchip_get_drvdata(chip);
>  	ddata->regmap =3D regmap;
> +	ddata->variant =3D variant;
> =20
>  	clk =3D devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -224,7 +259,8 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
>  }
> =20
>  static const struct of_device_id axi_pwmgen_ids[] =3D {
> -	{ .compatible =3D "adi,axi-pwmgen-1.00.a" },
> +	{ .compatible =3D "adi,axi-pwmgen-1.00.a", .data =3D &pwmgen_1_00_varia=
nt },
> +	{ .compatible =3D "adi,axi-pwmgen-2.00.a", .data =3D &pwmgen_2_00_varia=
nt },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);

Otherwise looks fine.

Can you please add the next iteration of this patch together with the
series adding support for v1?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6obdirpcc2cza6oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYbnF4ACgkQj4D7WH0S
/k67zggAlhPUv5GAzjNqwsx7wvCjkqBLFv2HvSf0OHAr67/6XkEAmcBSLcIIOyjR
wxqDsLpRXc/sUTejbz/YcW8uQDwdqSh6QDoaB9l9CFsras1uQuneIoEjX3x1R0oH
sz/6S42rMwGd2hNYQQke8ngWSg7FP3K5kdc7ItARHrsTb6YLzr/J6hzPzy51vcuU
xjF0ytB3oDcT//UOCXr/gRaeCXWYCjhZYYN2PWD3RjQIMzgPZW6Q1tPdeTv1myIO
mgkXEaGgmO2BEb0fvcAIiaVWRhsFnemCvnu18bO/pwOKvHzQHq0eBc96XpxBGNIn
MtJef4hUhD1WjGz2JtZ59XLahbWGvQ==
=O0X/
-----END PGP SIGNATURE-----

--6obdirpcc2cza6oe--

