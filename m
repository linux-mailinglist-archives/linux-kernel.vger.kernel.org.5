Return-Path: <linux-kernel+bounces-81598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCD867800
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D0E1F2D7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202E129A7B;
	Mon, 26 Feb 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3VWTstb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013A1C6B9;
	Mon, 26 Feb 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956945; cv=none; b=HcY/NjMGhtOM65MrTRCqIX6yxkesjrqF7ZCVjp852X2uc6tKVffidbfXLBBHCDnoi0qNRINgkeV9D+u4SHmIvcn/BrxWFpqyMB4Jt18Z+7wMUsGtknZcUsAsi+rasg/9+k2giJR42zd8fiPFkKFPk+y6CdNXkvRQAgKkDtAW9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956945; c=relaxed/simple;
	bh=iqKxUW8vw4K5O4nubqAcfgPBbMUQaHd5GGqHmxDzISg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmkvIgegADX7P0uj8v9pKU4SsFLsKaieIbnkmG4RfiQxBlU+c8TChtPepTBkjXT8siAidjujsEINldLl3C8InHq8qo2NLu0OMPgnxfd8yiJ5CdRZv5jyxrt6aO4whsCTzmNvvKGTLyRMEdEwPnBqZ2wznlGHIpAC13JBaRVCo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3VWTstb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EDC433C7;
	Mon, 26 Feb 2024 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708956945;
	bh=iqKxUW8vw4K5O4nubqAcfgPBbMUQaHd5GGqHmxDzISg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3VWTstbv5SE2tnhmV3R6JAPgBJiWiqOGyORUY4mMWfiGNlrkTf+jJyJZqqMgtiUi
	 LWUgJP/G3sFXboNmHfoXnYA+rRLqilVtTRIcb4aP/S5D8WRgp4o7NSwQMzakEGHUDf
	 9fV4gQABQOmeFNDC1Wd88XG4zzThWvl6FDdD5mlHc4Piouh151cCBRRj0LxE6VJJzd
	 48xUQYH0SYuQvDgM5KfaalL8Au8F1QY4glfyh8FSpyKhrRAcKQJ4QzHCjqQdumpy+/
	 HDHiOb8q68NcvswOErwFJp2Xr3/jCaA/0HMjkM0vMa1Tm/2OiKr6hupDMirm05OWxs
	 ybtmnDsW6Vh8w==
Date: Mon, 26 Feb 2024 22:02:25 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v3 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <ZdyZ8SvqbpllDDeY@xhacker>
References: <20240223082014.109385-1-qiujingbao.dlmu@gmail.com>
 <20240223082632.109767-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223082632.109767-1-qiujingbao.dlmu@gmail.com>

On Fri, Feb 23, 2024 at 04:26:32PM +0800, Jingbao Qiu wrote:
> Implement the PWM driver for CV1800.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-cv1800.c | 259 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/pwm/pwm-cv1800.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..455f07af94f7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -186,6 +186,16 @@ config PWM_CROS_EC
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.
>  
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
> index c5ec9e168ee7..6c3c4a07a316 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
> +obj-$(CONFIG_PWM_CV1800)	+= pwm-cv1800.o
>  obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
>  obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> new file mode 100644
> index 000000000000..da1309dc0091
> --- /dev/null
> +++ b/drivers/pwm/pwm-cv1800.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * pwm-cv1800.c: PWM driver for Sophgo cv1800
> + *
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + *
> + * Limitations:
> + * - It output low when PWM channel disabled.
> + * - This pwm device supports dynamic loading of PWM parameters. When PWMSTART
> + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) will be
> + *   temporarily stored inside the PWM. If you want to dynamically change the
> + *   waveform during PWM output, after writing the new value to HLPERIODn and
> + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value effective.
> + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1).
> + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
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
> +#define PWM_CV1800_HLPERIOD_BASE 0x00
> +#define PWM_CV1800_PERIOD_BASE 0x04
> +#define PWM_CV1800_PWM_CV1800_POLARITY 0x40
> +#define PWM_CV1800_START 0x44
> +#define PWM_CV1800_DONE 0x48
> +#define PWM_CV1800_UPDATE 0x4c
> +#define PWM_CV1800_OE 0xd0
> +
> +#define PWM_CV1800_HLPERIOD(n) (PWM_CV1800_HLPERIOD_BASE + ((n) * 0x08))
> +#define PWM_CV1800_PERIOD(n) (PWM_CV1800_PERIOD_BASE + ((n) * 0x08))
> +
> +#define PWM_CV1800_UPDATE_MASK(n) (BIT(0) << (n))
> +#define PWM_CV1800_OE_MASK(n) (BIT(0) << (n))
> +#define PWM_CV1800_START_MASK(n) (BIT(0) << (n))
> +
> +#define PWM_CV1800_MAXPERIOD (BIT(30) - 1)
> +#define PWM_CV1800_MINPERIOD BIT(1)
> +#define PWM_CV1800_MINHLPERIOD BIT(0)
> +#define PWM_CV1800_PERIOD_RESET BIT(1)
> +#define PWM_CV1800_HLPERIOD_RESET BIT(0)
> +#define PWM_CV1800_REG_DISABLE 0x0U
> +#define PWM_CV1800_REG_ENABLE(n) (BIT(0) << (n))
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
> +static const struct regmap_config cv1800_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     bool enable)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 pwm_enable;
> +
> +	regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);

what's the reason of using regmap?

> +	pwm_enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
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
> +	} else if (!pwm_enable && enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_OE,

I believe this isn't correct.
TRM says setting OE as 1 means output enable, while 0 means input.
So I guess the controller may support pwm capture, but I didn't
get too much information about pwm capture of the controller from
the TRM, so can you please check and implement the .capture hook
if it's supported?

> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +	} else if (pwm_enable && !enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_OE,

ditto

> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_DISABLE);
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_DISABLE);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 period_val, hlperiod_val;
> +	u64 tem;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;

This is wrong. Per the TRM, The POLARITY(offset 0x040) reg can set the
polarity, so both PWM_POLARITY_NORMAL and PWM_POLARITY_INVERSED are supported.

> +
> +	/*
> +	 * This hardware use PERIOD and HLPERIOD registers to represent PWM waves.
> +	 *
> +	 * The meaning of PERIOD is how many clock cycles (from the clock source)
> +	 * are used to represent PWM waves.
> +	 * PERIOD = rate(MHz) / target(MHz)
> +	 * PERIOD = period(ns) * rate(Hz) / NSEC_PER_SEC
> +	 * The meaning of HLPERIOD is the number of low-level cycles in PERIOD.
> +	 * HLPERIOD = PERIOD - rate(MHz) / duty(MHz)
> +	 * HLPERIOD = PERIOD - (duty(ns) * rate(Hz) / NSEC_PER_SEC)
> +	 */
> +	tem = mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_PER_SEC);
> +	if (tem < PWM_CV1800_MINPERIOD)
> +		return -EINVAL;
> +
> +	if (tem > PWM_CV1800_MAXPERIOD)
> +		tem = PWM_CV1800_MAXPERIOD;
> +
> +	period_val = (u32)tem;
> +
> +	tem = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
> +				  NSEC_PER_SEC);
> +	if (tem > period_val)
> +		return -EINVAL;
> +	hlperiod_val = period_val - (u32)tem;
> +
> +	regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val);
> +	regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_val);
> +
> +	cv1800_pwm_enable(chip, pwm, state->enabled);
> +
> +	return 0;
> +}
> +
> +static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 period_val, hlperiod_val;
> +	u64 period_ns = 0;
> +	u64 duty_ns = 0;
> +	u32 enable = 0;
> +
> +	regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val);
> +	regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
> +
> +	if (period_val != PWM_CV1800_PERIOD_RESET ||
> +	    hlperiod_val != PWM_CV1800_HLPERIOD_RESET) {
> +		period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC, priv->clk_rate);
> +		duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * period_ns, period_val);
> +
> +		regmap_read(priv->map, PWM_CV1800_START, &enable);
> +
> +		enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
> +	}
> +
> +	state->period = period_ns;
> +	state->duty_cycle = duty_ns;
> +	state->enabled = enable;
> +	state->polarity = PWM_POLARITY_NORMAL;

This is not correct, see above.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops cv1800_pwm_ops = {
> +	.apply = cv1800_pwm_apply,
> +	.get_state = cv1800_pwm_get_state,
> +};
> +
> +static void devm_clk_rate_exclusive_put(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_rate_exclusive_put(clk);
> +}
> +
> +static int cv1800_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cv1800_pwm *priv;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));

it's better to replace magic "4" with proper macro.

> +	if (!chip)
> +		return PTR_ERR(chip);
> +
> +	priv = to_cv1800_pwm_dev(chip);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->map = devm_regmap_init_mmio(&pdev->dev, base,
> +					  &cv1800_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return PTR_ERR(priv->map);
> +
> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +				     "clk not found\n");
> +
> +	ret = clk_rate_exclusive_get(priv->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get exclusive rate\n");
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
> +				       priv->clk);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		return ret;
> +	}
> +
> +	priv->clk_rate = clk_get_rate(priv->clk);
> +	if (!priv->clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n",
> +				     priv->clk_rate);
> +
> +	chip->ops = &cv1800_pwm_ops;
> +
> +	return devm_pwmchip_add(dev, chip);
> +}
> +
> +static const struct of_device_id cv1800_pwm_dt_ids[] = {
> +	{ .compatible = "sophgo,cv1800-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
> +
> +static struct platform_driver cv1800_pwm_driver = {
> +	.driver = {
> +		.name = "cv1800-pwm",
> +		.of_match_table = cv1800_pwm_dt_ids,
> +	},
> +	.probe = cv1800_pwm_probe,
> +};
> +module_platform_driver(cv1800_pwm_driver);
> +
> +MODULE_AUTHOR("Jingbao Qiu");
> +MODULE_DESCRIPTION("Sophgo cv1800 PWM Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

