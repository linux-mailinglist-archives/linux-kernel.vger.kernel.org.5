Return-Path: <linux-kernel+bounces-143818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F118A3DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9B8281D19
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9545941;
	Sat, 13 Apr 2024 17:01:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B93398A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027660; cv=none; b=m2gMY+PY9myrCnXLOhQRgHZP3+B27fKmdiAKvpsIPuDZCQFI6uuTZDtV2nLY3Ebm5UUVvWVH+OLd3wJkxMzs47kA9Hjtfubtg3FMubZDrfndqdaVw/zXgKB4oS9Bxrh07qvWTapCfsaMIhQ13inV8U/6+mXL1h3E0jLVkK35Cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027660; c=relaxed/simple;
	bh=TwoOoayG2/ST3HZsGLT4YyQTYNvAKfgjQ7zhiv7yKeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg9dwgQWnkSI3EzFln7rwBWbyEpzFxpnAnHpB0uu0D2kTtSagjfTCj747IxEaqkxVgX5BcO6OK0kRxEBlU2rr8yo6tFXOmXb7F/HCEyMahfmRMonFeOv3wcsgp2CQ4yEgJpQKD1hlJTSrdct1h2BJsA6Pl/oSgaI3LrEWTcb3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvgkI-0007j6-Vt; Sat, 13 Apr 2024 19:00:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvgkG-00C607-2H; Sat, 13 Apr 2024 19:00:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvgkF-000sD7-3B;
	Sat, 13 Apr 2024 19:00:51 +0200
Date: Sat, 13 Apr 2024 19:00:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v11] pwm: opencores: Add PWM driver support
Message-ID: <ys5z3v7rmrjlwttwymhjlxtx36gnuvrbj7q3hdcczdb4t6y2m2@lz2bniiaaxe4>
References: <20240223084332.100410-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ppsoyvbhlmx6qtx"
Content-Disposition: inline
In-Reply-To: <20240223084332.100410-1-william.qiu@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6ppsoyvbhlmx6qtx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

thanks for your patience to wait for my review.

On Fri, Feb 23, 2024 at 04:43:32PM +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 232 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed4d3868539..12ea5e86fc23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16414,6 +16414,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
> =20
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d87e1bb350ba 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
> =20
> +config PWM_OCORES
> +	tristate "OpenCores PWM support"

OpenCores PTC PWM support?

> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..517c4f643058 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-cor=
e.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)	+=3D pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..874bc630bf2d
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only do inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock freq=
uency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb cloc=
k frequency) ns.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* OCPWM_CTRL register bits*/
> +#define REG_OCPWM_EN      BIT(0)
> +#define REG_OCPWM_ECLK    BIT(1)
> +#define REG_OCPWM_NEC     BIT(2)
> +#define REG_OCPWM_OE      BIT(3)
> +#define REG_OCPWM_SIGNLE  BIT(4)
> +#define REG_OCPWM_INTE    BIT(5)
> +#define REG_OCPWM_INT     BIT(6)
> +#define REG_OCPWM_CNTRRST BIT(7)
> +#define REG_OCPWM_CAPTE   BIT(8)
> +
> +struct ocores_pwm_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	const struct ocores_pwm_data *data;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> +};
> +
> +static inline u32 ocores_readl(struct ocores_pwm_device *ddata,

ocores_pwm_readl is a tad longer (which is annoying), but IMHO the
advantage of the longer name (no clash with other ocores IP drivers,
being able to easily setup ftrace filtering for all functions in this
driver) outweighs the shorter name. Can you please update accordingly.
(There are a few more symbols that the same treatment.)

> +			       unsigned int channel,
> +			       unsigned int offset)
> +{
> +	void __iomem *base =3D ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	return readl(base + offset);
> +}
> [...]
> +static void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
> +						 unsigned int channel)
> +{
> +	unsigned int offset =3D (channel > 3 ? 1 << 15 : 0) + (channel & 3) * 0=
x10;

offset =3D (channel & 4) << 13 | (channel & 3) << 4

results in the same offsets and can be compiled to more efficient code.
(Well, at least on ARM, I suspect the same applies to riscv.)

> +	return base + offset;
> +}
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D chip_to_ocores(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data =3D ocores_readl(ddata, pwm->hwpwm, 0x8);
> +	duty_data =3D ocores_readl(ddata, pwm->hwpwm, 0x4);
> +	ctrl_data =3D ocores_readl(ddata, pwm->hwpwm, 0xC);

Can you please give symbolic names to these offsets?

> [...]
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D chip_to_ocores(chip);
> +	u32 ctrl_data =3D 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ctrl_data =3D ocores_readl(ddata, pwm->hwpwm, 0xC);
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
> +
> +	period_data =3D DIV_ROUND_DOWN_ULL(state->period * ddata->clk_rate, NSE=
C_PER_SEC);

The multiplication might overflow. Please use mul_u64_u32_div and in
=2Eprobe assert that ddata->clk_rate <=3D NSEC_PER_SEC.

> +	if (period_data <=3D U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
> +	else
> +		return -EINVAL;

Please make this:

	if (period_data <=3D U32_MAX)
		period_data =3D U32_MAX;

What happens if period_data =3D=3D 0? I guess this is a problem and you
should return -EINVAL in that case.

> +	duty_data =3D DIV_ROUND_DOWN_ULL(state->duty_cycle * ddata->clk_rate, N=
SEC_PER_SEC);
> +	if (duty_data <=3D U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x4, (u32)duty_data);
> +	else
> +		return -EINVAL;
> +
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);

What is the effect on this one? I guess it disables the output? Is this
necessary? Does updating the configuration complete the currently
running period?=20

Please document in the Limitations paragraph if there are possible
glitches (e.g. when the period register is written but the duty_cycle
register not yet) and if the current period is completed.

> [...]
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev =3D &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	id =3D of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->data =3D id->data;
> +	chip =3D &ddata->chip;

This needs updating with the changes that got into 6.9-rc1. See
ae8635e99c5cc752e204ab9ee8869ec54a9223f0 for a commit you might want to
take as a template for the change needed here.

> +	chip->dev =3D dev;
> +	chip->ops =3D &ocores_pwm_ops;
> +	chip->npwm =3D 8;
> +
> +	ddata->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	ddata->clk =3D devm_clk_get_enabled(dev, NULL);

This member is only used here in .probe(). So it doesn't need to be
stored in struct ocores_pwm_device.

> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ddata->rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);

Same as for clk, rst is only used here.

> +	if (IS_ERR(ddata->rst))
> +		return dev_err_probe(dev, PTR_ERR(ddata->rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	reset_control_deassert(ddata->rst);
> +
> +	ret =3D devm_add_action_or_reset(dev, ocores_reset_control_assert, ddat=
a->rst);
> +	if (ret)
> +		return ret;

Please add a call to devm_clk_rate_exclusive_get() before storing the
rate and relying on it not changing.

> +	ddata->clk_rate =3D clk_get_rate(ddata->clk);
> +	if (ddata->clk_rate <=3D 0)
> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	platform_set_drvdata(pdev, ddata);

This is unused.

> +	return ret;

Here ret is always 0, please use return 0 here.

> +}
> +
> +static struct platform_driver ocores_pwm_driver =3D {
> +	.probe =3D ocores_pwm_probe,
> +	.driver =3D {
> +		.name =3D "ocores-pwm",
> +		.of_match_table =3D ocores_pwm_of_match,
> +	},
> +};
> +module_platform_driver(ocores_pwm_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("OpenCores PWM PTC driver");

The hardware unit is called PTC (PWM/Timer/Counter), so
"OpenCores PTC PWM driver" would be more appropriate?!

> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6ppsoyvbhlmx6qtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaukAACgkQj4D7WH0S
/k4upAf/R/Lcbnh4PGsFvAixxLQEJneISth1z8CHVKscqrZHCDRxRZnerkRAC2Dp
efAo5PoEaxInDglOU/ftttZX7YaRUgocXG3wlkzIGyD+PLrpncwSdSWJR6zDW4fC
ivPXuXmXfG4/OCFBrVrSgGvLWFE0Np8b9idQngiRxETJhPQVHMT/XCJvRJkF2Hb7
glbbHRW3XqJDbXTnOqMjFYhtj5yAFcrVqC2B4/CXRQxUTrURT2si9sTxycbIswvV
KBY5gXoqalzO/C2l5eZGX+OT3LrT6ytnwb1/MulkaY59pm7NWoZfrXr1WkVN8Wa1
9SFw4map/UfZSbhe2g3XXUr6ABv7jw==
=Pn3J
-----END PGP SIGNATURE-----

--6ppsoyvbhlmx6qtx--

