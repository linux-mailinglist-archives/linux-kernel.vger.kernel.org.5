Return-Path: <linux-kernel+bounces-162497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127AB8B5C04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929D4288465
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AB82499;
	Mon, 29 Apr 2024 14:54:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631781748
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402475; cv=none; b=MI5am96cHEeZLhE8UjwD7Cqz+dpl6V5HCoEYjKa7BxGhULo+ah3+7/aUXxrtKex2lgi49UrUaffIoTnbcanj1zqqnsF6lPwrjtx5MvzZfppIUQnhAMayetfvorAI/9ta7IdhPlpl3VpgUPW1tAQOfVQYpcsHLx6uOCR2w0ORFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402475; c=relaxed/simple;
	bh=6uNyXtOcrJqPHC1VpRgnHflQwPT+wqYRlvEIeInSIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJulqz1V6gjdLTcE2YEToXARmxx7p67oC0zzVgEza9ZfsfkDL4/aSAJKLG/f3jzGL5k/BguVS3mzuYb5V0owGoVOQXhZodoM/+MK7nzvntA8SLWpxkKW1VwjREILpkH/vSKnDSvvGMRvCu06h4nDkL49rGxp0DXOrjXmW3B910I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1SOc-0006MX-Hj; Mon, 29 Apr 2024 16:54:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1SOa-00EzzG-No; Mon, 29 Apr 2024 16:54:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1SOa-00BVvC-23;
	Mon, 29 Apr 2024 16:54:20 +0200
Date: Mon, 29 Apr 2024 16:54:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, inochiama@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <njsvev4dxjln2guw3lr5zwvytzvvmj7qcuduo2v56dhvuxujs4@eqm4cmh6ddva>
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
 <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3waq76kjr6c2zmj"
Content-Disposition: inline
In-Reply-To: <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--o3waq76kjr6c2zmj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Apr 06, 2024 at 02:34:13PM +0800, Jingbao Qiu wrote:
> Implement the PWM driver for CV1800.
>=20
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-cv1800.c | 296 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/pwm/pwm-cv1800.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1dd7921194f5..3869ca022aeb 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -182,6 +182,16 @@ config PWM_CROS_EC
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.
> =20
> +config PWM_CV1800
> +	tristate "Sophgo CV1800 PWM driver"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for the Sophgo CV1800 series
> +	  SoCs.
> +
> +	  To compile this driver as a module, build the dependecies
> +	  as modules, this will be called pwm-cv1800.
> +
>  config PWM_DWC_CORE
>  	tristate
>  	depends on HAS_IOMEM
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 90913519f11a..6295e2259efc 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> +obj-$(CONFIG_PWM_CV1800)	+=3D pwm-cv1800.o
>  obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> new file mode 100644
> index 000000000000..37a6be3f63aa
> --- /dev/null
> +++ b/drivers/pwm/pwm-cv1800.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sophgo CV1800 PWM driver
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + *
> + * Limitations:
> + * - It output low when PWM channel disabled.

Just to be sure: the output is low independant of the POLARITY register?

> + * - This pwm device supports dynamic loading of PWM parameters. When PW=
MSTART
> + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) wil=
l be
> + *   temporarily stored inside the PWM. If you want to dynamically chang=
e the
> + *   waveform during PWM output, after writing the new value to HLPERIOD=
n and
> + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value e=
ffective.
> + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1).
> + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
> + * - This hardware could support inverted polarity. By default, the valu=
e of the
> + *   POLARITY register is 0x0. This means that HLPERIOD represents the n=
umber
> + *   of low level beats.
> + * - This hardware supports input mode and output mode, implemented thro=
ugh the
> + *   Output-Enable/OE register. However, this driver has not yet impleme=
nted
> + *   capture callback.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_CV1800_HLPERIOD_BASE    0x00
> +#define PWM_CV1800_PERIOD_BASE      0x04
> +#define PWM_CV1800_POLARITY         0x40
> +#define PWM_CV1800_START            0x44
> +#define PWM_CV1800_DONE             0x48
> +#define PWM_CV1800_UPDATE           0x4c
> +#define PWM_CV1800_OE               0xd0
> +
> +#define PWM_CV1800_HLPERIOD(n)      (PWM_CV1800_HLPERIOD_BASE + ((n)*0x0=
8))
> +#define PWM_CV1800_PERIOD(n)        (PWM_CV1800_PERIOD_BASE + ((n)*0x08))
> +
> +#define PWM_CV1800_UPDATE_MASK(n)   (BIT(0) << (n))
> +#define PWM_CV1800_OE_MASK(n)       (BIT(0) << (n))
> +#define PWM_CV1800_START_MASK(n)    (BIT(0) << (n))
> +#define PWM_CV1800_POLARITY_MASK(n) (BIT(0) << (n))
> +
> +#define PWM_CV1800_MAXPERIOD        0x3fffffff
> +#define PWM_CV1800_MINPERIOD        2
> +#define PWM_CV1800_CHANNELS         4
> +#define PWM_CV1800_PERIOD_RESET     BIT(1)
> +#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
> +#define PWM_CV1800_REG_DISABLE      0x00U
> +#define PWM_CV1800_REG_ENABLE(n)    (BIT(0) << (n))

BIT(n)?

> +
> +struct cv1800_pwm {
> +	struct regmap *map;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +};
> +
> +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +};
> +
> +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     bool enable)
> +{
> +	struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> +	u32 pwm_enable, state;
> +
> +	regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
> +	pwm_enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> +
> +	/*
> +	 * If the parameters are changed during runtime, Register needs
> +	 * to be updated to take effect.
> +	 */
> +	if (pwm_enable && enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_DISABLE);

I think using a plain 0 instead of PWM_CV1800_REG_DISABLE would be a tad
clearer.

> +	} else if (!pwm_enable && enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +	} else if (pwm_enable && !enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_DISABLE);
> +	}
> +
> +	/* check and set OE/Output-Enable mode */
> +	regmap_read(priv->map, PWM_CV1800_OE, &state);
> +	state &=3D PWM_CV1800_OE_MASK(pwm->hwpwm);
> +
> +	if (state =3D=3D PWM_CV1800_REG_DISABLE && enable)

Here I'd use:

	regmap_read(priv->map, PWM_CV1800_OE, &state);

	if ((state & BIT(pwm->hwpwm)) && enable)

> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> [...]
> +static int cv1800_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cv1800_pwm *priv;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, PWM_CV1800_CHANNELS, sizeof(*priv));
> +	if (!chip)
> +		return PTR_ERR(chip);
> +	priv =3D to_cv1800_pwm_dev(chip);
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->map =3D devm_regmap_init_mmio(&pdev->dev, base,
> +					  &cv1800_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return PTR_ERR(priv->map);

devm_regmap_init_mmio() doesnt' emit an error message on failure, so
please add one here.

> +	priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +				     "clk not found\n");
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o3waq76kjr6c2zmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvtJsACgkQj4D7WH0S
/k79DQf/cMJLclOhJGIDZpPbyfiK2QcRlhxg0kThVuJ+f0iZ4ovad4XOIcXSa1Op
Za2tlzkM4c9DIVDutETyQp2iggP0zYdLaUG1EbKbHKwZuLbwLMb15pHCBoX3o4kH
eDoCfQ630TgGSMfm79Z6t2riPYpmxMzQCpNgA/zncoq1FQZ91fUqGREwtUs8W/Op
6OF3SOqb66gyTJ96i9S0KzHNHZK03N4fwDvL4ZjFWdxT/LxVWnaFzwkrvBB+Cm5H
Ywwo6Qn7HZOLHasR21m3wXYV7wf62zaxsi0Q4MLCoPuCcgGknf+LlG2biakB4VXB
Jq5QSVU24wQ7GB+KKWLx7TfEXtsNeg==
=F8fu
-----END PGP SIGNATURE-----

--o3waq76kjr6c2zmj--

