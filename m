Return-Path: <linux-kernel+bounces-107848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614D880273
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893A91F24BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E00134CB;
	Tue, 19 Mar 2024 16:35:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D18489
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866158; cv=none; b=eZ2Utf4+wup24/zwGjAIN5X+YRdzgmkTATmvphvnMgrlufd+SF618mh9p+uvA9G42cKCZ6bAnGmhwg38sLTCXNROFc0ykHpf7x/bhti0xxzhtuwWK9pLGXboIBwjtNMOWFSENdscPt3cDICNz306oVCyLuzvtDa2/gE54bEArEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866158; c=relaxed/simple;
	bh=CVM/v7zQjD0DOiroiV/9Z0ItX6C4g5wpIOfTKxuUMbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw3qUd9w6ns3CqsHiaWSln+SP9uXc/WEz8vCtWlWwefzy8s0irsH4cxZALhxHkAedmTTEd6f9/ypcjCemc+QiYG/ni3Ux09OBnkRlkhHI7UHdhK3PzI4ltwYweD5j9HaBk5SQEXtnzcz9vW3SY32ZPuaVG25rYRI2y/laf5t1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmcRC-0002ah-61; Tue, 19 Mar 2024 17:35:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmcRB-007JGE-Ob; Tue, 19 Mar 2024 17:35:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmcRB-008Tfb-2B;
	Tue, 19 Mar 2024 17:35:41 +0100
Date: Tue, 19 Mar 2024 17:35:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <s256onwsfw2mfdlkeb42j5jucejogxinioumpkklrtd57icwrx@5uaqlj6z2i5h>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
 <20240301111124.29283-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gvarnm37z7b6y5e"
Content-Disposition: inline
In-Reply-To: <20240301111124.29283-3-dima.fedrau@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--3gvarnm37z7b6y5e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dimitri,

On Fri, Mar 01, 2024 at 12:11:23PM +0100, Dimitri Fedrau wrote:
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..35753039da6b
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + */

Please document the general behaviour of the device here. For that
please stick to the format used in other drivers such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

does the right thing for your driver.

> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#define MC33XS2410_GLB_CTRL		0x00
> +#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
> +#define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
> +#define MC33XS2410_OUT1_4_CTRL		0x02
> +#define MC33XS2410_PWM_CTRL1		0x05
> +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
> +#define MC33XS2410_PWM_CTRL3		0x07
> +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))

Maybe add the valid range for x here. Something like:

#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x)) /* x in {0 ... 3} */

> +#define MC33XS2410_PWM_CTRL3_EN_MASK	GENMASK(7, 4)

MC33XS2410_PWM_CTRL3_EN_MASK is unused.

> +#define MC33XS2410_PWM_FREQ1		0x08
> +#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x))

Huh, is it expected that MC33XS2410_PWM_FREQ(1) !=3D MC33XS2410_PWM_FREQ1?
I guess the hardware manual numbers these registers from 1 .. max but
you're passing hwpwm which starts at 0? Hmm.

I think I'd use:

#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x) - 1)

and pass hwpwm + 1.

> +#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
> +#define MC33XS2410_PWM_FREQ_MASK	GENMASK(5, 0)
> +#define MC33XS2410_PWM_DC1		0x0c
> +#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x))
> +#define MC33XS2410_WDT			0x14
> +
> +#define MC33XS2410_IN_OUT_STA		0x01
> +#define MC33XS2410_IN_OUT_STA_OUT_EN(x)	BIT(4 + (x))
> +
> +#define MC33XS2410_WR_FLAG		BIT(7)
> +#define MC33XS2410_RD_CTRL_FLAG		BIT(7)
> +#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
> +
> +#define MC33XS2410_PERIOD_MAX	0
> +#define MC33XS2410_PERIOD_MIN	1

This deserves a comment. (Or drop it after following my suggestion to
drop mc33xs2410_period[][].)


> +struct mc33xs2410_pwm {
> +	struct pwm_chip chip;
> +	struct spi_device *spi;
> +	struct mutex lock;
> +};
> +
> +enum mc33xs2410_freq_steps {
> +	STEP_05HZ,
> +	STEP_2HZ,
> +	STEP_8HZ,
> +	STEP_32HZ,
> +};
> +
> +/*
> + * When outputs are controlled by SPI, the device supports four frequenc=
y ranges
> + * with following steps:
> + * - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + * - 2 Hz steps from 2 Hz to 128 Hz
> + * - 8 Hz steps from 8 Hz to 512 Hz
> + * - 32 Hz steps from 32 Hz to 2048 Hz
> + * Below are the minimum and maximum frequencies converted to periods in=
 ns for
> + * each of the four frequency ranges.
> + */
> +static const u32 mc33xs2410_period[4][2] =3D {
> +	[STEP_05HZ] =3D { 2000000000, 31250000 },
> +	[STEP_2HZ] =3D { 500000000, 7812500 },
> +	[STEP_8HZ] =3D { 125000000, 1953125 },
> +	[STEP_32HZ] =3D { 31250000, 488281 },
> +};
> +
> +static struct mc33xs2410_pwm *mc33xs2410_pwm_from_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct mc33xs2410_pwm, chip);
> +}
> +
> +static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
> +{
> +	u8 tx[2];
> +
> +	tx[0] =3D reg | MC33XS2410_WR_FLAG;
> +	tx[1] =3D val;
> +
> +	return spi_write(spi, tx, 2);
> +}
> +
> +static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, bool ctrl)
> +{
> +	u8 tx[2], rx[2];
> +	int ret;
> +
> +	tx[0] =3D reg;
> +	tx[1] =3D ctrl ? MC33XS2410_RD_CTRL_FLAG : 0;
> +
> +	ret =3D spi_write(spi, tx, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D spi_read(spi, rx, 2);
> +	if (ret < 0)
> +		return ret;

This could benefit from using spi_write_then_read().

> +
> +	return FIELD_GET(MC33XS2410_RD_DATA_MASK, get_unaligned_be16(rx));
> +}
> +
> +static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg)
> +{
> +	return mc33xs2410_read_reg(spi, reg, true);
> +}
> +
> +static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask=
, u8 val)
> +{
> +	int ret;
> +
> +	ret =3D mc33xs2410_read_reg_ctrl(spi, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret &=3D ~mask;
> +	ret |=3D val & mask;
> +
> +	return mc33xs2410_write_reg(spi, reg, ret);
> +}
> +
> +static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg)
> +{
> +	return mc33xs2410_read_reg(spi, reg, false);
> +}
> +
> +static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
> +{
> +	u32 period, freq, max, min;
> +	int step;
> +	u8 ret;

When reading "ret" I'd expect this to be an integer representing an
error code. Maybe call it "freq" instead?

> +	period =3D state->period;
> +	/*
> +	 * Check if period is within the limits of each of the four frequency
> +	 * ranges, starting with the highest frequency(lowest period). Higher
> +	 * frequencies are represented with better resolution by the device.
> +	 */
> +	for (step =3D STEP_32HZ; step >=3D STEP_05HZ; step--) {
> +		min =3D mc33xs2410_period[step][MC33XS2410_PERIOD_MIN];
> +		max =3D mc33xs2410_period[step][MC33XS2410_PERIOD_MAX];
> +		if ((period <=3D max) && (period >=3D min))
> +			break;
> +	}

Given that mc33xs2410_period[step][0] is 2000000000 >> (2 * step) and
mc33xs2410_period[step][1] =3D 31250000 >> (2 * step), this can be
calculated without a loop.

Something like:

	step =3D (fls((31250000 - 1) / period) + 1) / 2

or given there are only four options this can also be done as follows:

	switch (period) {
		case 488281 .. 31250000:
			step =3D 3;
			break;
		case 31250001 .. 125000000:
			...
	}

which gives the compiler a real chance to implement it efficiently. Also
then you could drop mc33xs2410_period[][].

> +	freq =3D DIV_ROUND_CLOSEST(max, period) - 1;
> +	ret =3D FIELD_PREP(MC33XS2410_PWM_FREQ_MASK, freq);
> +	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));

Also using DIV_ROUND_CLOSEST smells wrong. Did you test with PWM_DEBUG
enabled?

> +}
> +
> +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 =3D mc33xs2410_pwm_from_chip(chip);
> +	struct spi_device *spi =3D mc33xs2410->spi;
> +	u8 mask, val;
> +	int ret;
> +
> +	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
> +		return -EINVAL;

Please make this:

	u64 period =3D min(state->period, mc33xs2410_period[STEP_05HZ][MC33XS2410_=
PERIOD_MAX]);

> +
> +	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
> +		return -EINVAL;
> +
> +	guard(mutex)(&mc33xs2410->lock);

Huh, didn't know this syntax for locking. Interesting. However with the
pending changes for the next merge window, calls to .apply() are
serialized per chip already by the core, so you don't need locking.

> +	mask =3D MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> +	val =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ? mask : 0;
> +	ret =3D mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL1, mask, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D mc33xs2410_write_reg(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm),
> +				   mc33xs2410_pwm_get_freq(state));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D mc33xs2410_write_reg(spi, MC33XS2410_PWM_DC(pwm->hwpwm),
> +				   pwm_get_relative_duty_cycle(state, 255));
> +	if (ret < 0)
> +		return ret;
> +
> +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> +	val =3D (state->enabled) ? mask : 0;
> +	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);

Is this procedure atomic? Or can it happen that the output pin does
something that is neither the old nor the new state in between?

Maybe it's worth the effort doing that in a single spi transfer, both to
make the procedure quicker and (maybe?) atomic.

> +}
> +
> +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 =3D mc33xs2410_pwm_from_chip(chip);
> +	struct spi_device *spi =3D mc33xs2410->spi;
> +	u32 freq, code, steps;
> +	int ret;
> +
> +	guard(mutex)(&mc33xs2410->lock);
> +	ret =3D mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_CTRL1);
> +	if (ret < 0)
> +		return ret;
> +
> +	state->polarity =3D (ret & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +
> +	ret =3D mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Lowest frequency steps are starting with 0.5Hz, scale them by two. */
> +	steps =3D (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, ret) * 2) << 1;

You're multiplying by 2 twice here. I fail to follow.

> +	code =3D FIELD_GET(MC33XS2410_PWM_FREQ_MASK, ret);
> +	/* Frequency =3D (code + 1) x steps */
> +	freq =3D (code + 1) * steps;
> +	/* Convert frequency to period in ns, considering scaled steps value. */
> +	state->period =3D 2000000000ULL / (freq);

Please make 2000000000ULL a define. This can then be used also in the
calculations that currently involve mc33xs2410_period[][].

Also you need to round up here.

> +	ret =3D mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_DC(pwm->hwpwm));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D pwm_set_relative_duty_cycle(state, ret, 255);
> +	if (ret)
> +		return ret;

Pretty sure this is also wrong and fails if you enable PWM_DEBUG.

> +	ret =3D mc33xs2410_read_reg_diag(spi, MC33XS2410_IN_OUT_STA);
> +	if (ret < 0)
> +		return ret;
> +
> +	state->enabled =3D !!(ret & MC33XS2410_IN_OUT_STA_OUT_EN(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops mc33xs2410_pwm_ops =3D {
> +	.apply =3D mc33xs2410_pwm_apply,
> +	.get_state =3D mc33xs2410_pwm_get_state,
> +};
> +
> +static int mc33xs2410_reset(struct device *dev)
> +{
> +	struct gpio_desc *reset_gpio;
> +
> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR_OR_NULL(reset_gpio))
> +		return PTR_ERR_OR_ZERO(reset_gpio);
> +
> +	fsleep(1000);
> +	gpiod_set_value_cansleep(reset_gpio, 0);
> +	/* Wake-up time */
> +	fsleep(10000);
> +
> +	return 0;
> +}
> +
> +static int mc33xs2410_probe(struct spi_device *spi)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410;
> +	struct device *dev =3D &spi->dev;
> +	int ret;
> +
> +	mc33xs2410 =3D devm_kzalloc(&spi->dev, sizeof(*mc33xs2410), GFP_KERNEL);

After struct device *dev =3D &spi->dev you could better use dev here
instead of &spi->dev.

> +	if (!mc33xs2410)
> +		return -ENOMEM;

Please use devm_pwmchip_alloc(). See
11ee0a124cb48bb837a1d90c3504a9c3376e96d1 for a simple example to copy
=66rom.

> +	mc33xs2410->chip.dev =3D dev;
> +	mc33xs2410->chip.ops =3D &mc33xs2410_pwm_ops;
> +	mc33xs2410->chip.npwm =3D 4;
> +	mc33xs2410->spi =3D spi;
> +	mutex_init(&mc33xs2410->lock);
> +
> +	ret =3D mc33xs2410_reset(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable watchdog */
> +	ret =3D mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
> +
> +	/* Transitition to normal mode */

s/Transitition/Transition/

> +	ret =3D mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> +				    MC33XS2410_GLB_CTRL_MODE_MASK,
> +				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to transition to normal mode\n");
> +
> +	ret =3D devm_pwmchip_add(dev, &mc33xs2410->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id mc33xs2410_spi_id[] =3D {
> +	{ "mc33xs2410", 0 },

driver_data is unused here, please drop it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);
> +
> +static const struct of_device_id mc33xs2410_of_match[] =3D {
> +	{ .compatible =3D "nxp,mc33xs2410" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mc33xs2410_of_match);
> +
> +static struct spi_driver mc33xs2410_driver =3D {
> +	.driver =3D {
> +		.name =3D "mc33xs2410-pwm",
> +		.of_match_table =3D mc33xs2410_of_match,
> +	},
> +	.probe =3D mc33xs2410_probe,
> +	.id_table =3D mc33xs2410_spi_id,
> +};
> +module_spi_driver(mc33xs2410_driver);
> +
> +MODULE_DESCRIPTION("NXP MC33XS2410 high-side switch driver");
> +MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3gvarnm37z7b6y5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX5vtwACgkQj4D7WH0S
/k6NZQf/WV+9XuFT6yIdb8dC7fyirlNdOieleGfkTJXHsN8qbjnq+4xEvP71Sloe
Myw+mMO9wgJXUYg70MSJuaFFF0wyMelFEvqWw3KTDLvg6OcBZtKJ2GYdhQlnysp3
TL0jK3lLXXoiRDmcWUnGDTfi00QXnDgAL/YDVynZY+QU8187onqN9reIEmrPYFHI
0FT6PBST/5WfTFeNsPDaZv1A/2yflCuCoGia6bL9b23ExjqZMiCNxAqqsr7s2K9J
UWLi9TDycASpC7Dk6/pf2cAbqj+zxB1sJhddWk1Ni9RmqP1EkzyOskaQ9BtEu5px
kO8evhYHArf4MD6scx6AgFUNNr7t5Q==
=HHBE
-----END PGP SIGNATURE-----

--3gvarnm37z7b6y5e--

