Return-Path: <linux-kernel+bounces-140298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C369B8A1265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762032842C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DD1474B9;
	Thu, 11 Apr 2024 10:59:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89E145B13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833193; cv=none; b=Z/ozjal/bkoJcKUjoL6vYOgkmyfdsvpTvxT8xSYeAxyMvVEpbWVtkpK3HCvXS+TQReNkUecEltoBWN/iVN0CS6svL2Chw7odX4t0z16poySnOvp+qhaDZoryrHEyMPi09qr8dxSc2Rrn/kxcy9MdBjpn4G3J0oxQ5ad5LvkW3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833193; c=relaxed/simple;
	bh=Dg1L9vmqPxmSpwApJmOlITtQQ25Vf/TSPoL6T0MEZLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQle5IjM+jtCdPdVHxBv+/a8AYTZ73BKKuVyPUcdstZc3GX99cJw7dun3ha/BNzIEDtnWn7AOpovNPEboX412JXSAbonu3OtJY9s8xgoRXHUzvYpUfKAF62sl5AgMRkrLtedIv/z6pix4M18Y9Aoae4kiOFyLk38Oj7FEDuWFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rus9l-00053c-9Q; Thu, 11 Apr 2024 12:59:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rus9k-00BfaR-Aa; Thu, 11 Apr 2024 12:59:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rus9k-000VX9-0i;
	Thu, 11 Apr 2024 12:59:48 +0200
Date: Thu, 11 Apr 2024 12:59:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, Drew Fustini <dfustini@baylibre.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 2/2 v4] pwm: Add driver for AXI PWM generator
Message-ID: <zwer5e7jmrqfi3yeooandpfyhs663i3adcaxjeizmwgmfxltp3@gnpimhyoaqjf>
References: <20240301173343.1086332-1-tgamblin@baylibre.com>
 <20240301173343.1086332-3-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwyjs4i2pfvbdlht"
Content-Disposition: inline
In-Reply-To: <20240301173343.1086332-3-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--mwyjs4i2pfvbdlht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 01, 2024 at 12:33:42PM -0500, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>=20
> Add support for the Analog Devices AXI PWM Generator. This device is an
> FPGA-implemented peripheral used as PWM signal generator and can be
> interfaced with AXI4. The register map of this peripheral makes it
> possible to configure the period and duty cycle of the output signal.
>=20
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> v4 changes:=20
> * Address feedback for driver in v3:
>   * Update to use devm_pwmchip_alloc() function
>   * Simplify use of dev symbol in axi_pwmgen_probe
>   * Remove unnecessary axi_pwmgen_from_chip function and use
>     pwmchip_get_drvdata directly
>=20
> v3 changes:
> * Address feedback for driver in v2:
>   * Remove unnecessary blank line in axi_pwmgen_apply
>   * Use macros already defined in <linux/fpga/adi-axi-common.h> for
>     version checking
>=20
> v2 changes:
> * Address feedback for driver and device tree in v1:
>   * Use more reasonable Kconfig approach
>   * Use common prefixes for all functions
>   * Rename axi_pwmgen struct to axi_pwmgen_ddata
>   * Change use of "pwm" to "ddata"
>   * Set and check state->polarity
>   * Multiply safely with mul_u64_u64_div_u64()
>   * Improve handling of max and zero periods
>   * Error if clk_rate_hz > NSEC_PER_SEC
>   * Add "Limitations" section at top of pwm-axi-pwmgen.c
>   * Don't disable outputs by default
>   * Remove unnecessary macros for period, duty, offset
>   * Fix axi_pwmgen_ddata alignment
>   * Don't artificially limit npwm to four
>   * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
>   * Cache clk rate in axi_pwmgen_ddata
>   * Don't assign pwm->chip.base, do assign pwm->chip.atomic
> * Remove redundant calls to clk_get_rate
> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
>   arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
> * Remove redundant clk struct from axi_pwmgen_ddata
> * Add self as module author
> * Add major version check for IP core
> ---
>  MAINTAINERS                  |   1 +
>  drivers/pwm/Kconfig          |  13 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-axi-pwmgen.c | 244 +++++++++++++++++++++++++++++++++++
>  4 files changed, 259 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a4ed5545680..2baa7a0a1c8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +F:	drivers/pwm/pwm-axi-pwmgen.c
> =20
>  AXXIA I2C CONTROLLER
>  M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d44b0e86adee 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
> =20
> +config PWM_AXI_PWMGEN
> +	tristate "Analog Devices AXI PWM generator"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  This enables support for the Analog Devices AXI PWM generator.
> +
> +	  This is a configurable PWM generator with variable pulse width and
> +	  period.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called pwm-axi-pwmgen.
> +
>  config PWM_BCM_IPROC
>  	tristate "iProc PWM support"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..8322089954e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..0c8f7f893a21
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS
> + *
> + * Limitations:
> + * - The writes to registers for period and duty are shadowed until
> + *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
> + *   current period.

This implies that a currently running period is completed before the new
settings get active, right?

> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
> + *   enabled channels, which could cause glitching on other channels. It
> + *   is therefore expected that channels are assigned harmonic periods
> + *   and all have a single user coordinating this.

What does "re-synchronize" mean here? Are all counters reset to zero?
"harmonic" means that all channels should use the same period length?

> + * - Supports normal polarity. Does not support changing polarity.

Please add an item documenting how the HW behaves on disable. (Typical
behaviours are "freeze" or "inactive".)

> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/fpga/adi-axi-common.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00
> +#define AXI_PWMGEN_REG_ID		0x04
> +#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
> +#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
> +#define AXI_PWMGEN_REG_CONFIG		0x10
> +#define AXI_PWMGEN_REG_NPWM		0x14
> +#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))

Reading https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen I would
have expected:

	/* ch in { 0, ... 15 } */
	#define AXI_PWMGEN_REG_PULSE_X_PERIOD(ch)	(0x40 + 4 * (ch))
	#define AXI_PWMGEN_REG_PULSE_X_WIDTH(ch)	(0x80 + 4 * (ch))
	#define AXI_PWMGEN_REG_PULSE_X_OFFSET		(0xc0 + 4 * (ch))

> +#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification numbe=
r to test during setup */
> +#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
> +#define AXI_PWMGEN_RESET		BIT(0)

I'm a fan of including the register name in bitfield definitions. So
maybe:

	#define AXI_PWMGEN_REG_CONFIG_RESET	BIT(0)

> +struct axi_pwmgen_ddata {
> +	struct regmap *regmap;
> +	unsigned long clk_rate_hz;
> +};
> +
> +static const struct regmap_config axi_pwmgen_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +};
> +
> +static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	unsigned int ch =3D pwm->hwpwm;
> +	struct regmap *regmap =3D ddata->regmap;
> +	u64 period_cnt, duty_cnt;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->enabled) {
> +		period_cnt =3D mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, =
NSEC_PER_SEC);
> +		if (period_cnt > UINT_MAX)
> +			period_cnt =3D UINT_MAX;
> +
> +		if (period_cnt =3D=3D 0)
> +			return -EINVAL;
> +
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
> +		if (ret)
> +			return ret;
> +
> +		duty_cnt =3D mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz=
, NSEC_PER_SEC);
> +		if (duty_cnt > UINT_MAX)
> +			duty_cnt =3D UINT_MAX;
> +
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONF=
IG);
> +}
> +
> +static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	struct regmap *regmap =3D ddata->regmap;
> +	unsigned int ch =3D pwm->hwpwm;
> +	u32 cnt;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> +	if (ret)
> +		return ret;
> +
> +	state->enabled =3D cnt !=3D 0;
> +
> +	state->period =3D DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_=
rate_hz);
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
> +	if (ret)
> +		return ret;
> +
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->=
clk_rate_hz);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops axi_pwmgen_pwm_ops =3D {
> +	.apply =3D axi_pwmgen_apply,
> +	.get_state =3D axi_pwmgen_get_state,
> +};
> +
> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_REG_CORE_MAGIC, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val !=3D AXI_PWMGEN_REG_CORE_MAGIC_VAL)
> +		return dev_err_probe(dev, -ENODEV,
> +			"failed to read expected value from register: got %08x, expected %08x=
\n",
> +			val,
> +			AXI_PWMGEN_REG_CORE_MAGIC_VAL);
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (ADI_AXI_PCORE_VER_MAJOR(val) !=3D 1) {
> +		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.=
%u.%u\n",
> +			ADI_AXI_PCORE_VER_MAJOR(val),
> +			ADI_AXI_PCORE_VER_MINOR(val),
> +			ADI_AXI_PCORE_VER_PATCH(val));
> +	}
> +
> +	/* Enable the core */
> +	ret =3D regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RE=
SET, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Return the number of PWMs */
> +	return val;
> +}
> +
> +static void axi_pwmgen_clk_rate_exclusive_put(void *data)
> +{
> +	clk_rate_exclusive_put(data);
> +}
> +
> +static int axi_pwmgen_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct regmap *regmap;
> +	struct pwm_chip *chip;
> +	struct axi_pwmgen_ddata *ddata;
> +	struct clk *clk;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	regmap =3D devm_regmap_init_mmio(dev, io_base, &axi_pwmgen_regmap_confi=
g);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "failed to init register map\n");
> +
> +	ret =3D axi_pwmgen_setup(regmap, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata =3D pwmchip_get_drvdata(chip);
> +	ddata->regmap =3D regmap;
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	ret =3D clk_rate_exclusive_get(clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, axi_pwmgen_clk_rate_exclusive_put=
, clk);
> +	if (ret)
> +		return ret;

There is a devm variant of clk_rate_exclusive_get() in the meantime.

> +	ddata->clk_rate_hz =3D clk_get_rate(clk);
> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
> +
> +	chip->ops =3D &axi_pwmgen_pwm_ops;
> +	chip->atomic =3D true;
> +
> +	return devm_pwmchip_add(dev, chip);

Error message in case devm_pwmchip_add fails, please.

> +}

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mwyjs4i2pfvbdlht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYXwqMACgkQj4D7WH0S
/k5+uQgApajZcFLOX9MsS00OQVGjE+YcbyPjbW2MGINrYN7tYJwA3iTe272kmy0+
KZyU/ZgNH5kGMQzU6V5kxRJ1VveMyVsIwQrDkzlGp0lMNhh/nuxR+y+xKm4cNSs/
I4EMyoNY8vk140PP51AsNLwXyQmpAIb8yRTvQFjhHnirmwDmD4g6lnzCgXtf1SFE
1CLr7tQbF3h0ES3NK5zhS4ebaE6XJuPH7I8FXdsK/cbbzLcNX2lchuGUScxFDdmy
plew2K4x0FXN1EkYFV7Kmwp/hLS0xw7M5Wp6DFExO9b0vWRXYNyXuan9PvHK+ufY
33Iy+74g9SZIQXxEMgYwTJ39QkJPTQ==
=oKRp
-----END PGP SIGNATURE-----

--mwyjs4i2pfvbdlht--

