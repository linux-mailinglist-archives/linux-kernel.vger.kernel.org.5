Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75779D442
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjILPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjILPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:04:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A931115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:04:10 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90ECA3F66C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694531048;
        bh=I+FJ5qUcevTthg+RKBHlanDF25KRUOA3+bky9ouyoIE=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b7MyFVFKz61uBiHFgryralYRyHGRtbPCa2BiMKe6k6RPVxjCnep/n9hx3b9Io2A7z
         XYVrzbL3FzYh/xmqbD8saSnqyRRyvSjXn7L71eMFX04v8Tb3+iGAtxl/q7lKQ1L2Q/
         to6K5tSZnEn5A/Ay1gaZNLKXTPB9q9Tld+zRjbt98thAXqVCcQgoiJdQDx/Ed9fSr8
         vXFOAswVgkREmucJuGEINTbaatVC6lISXU9h366Q2VYaD7wFKTuZ9JyVihZ8sSu+/Y
         N/1yFjSnaeunIXZbq7tupSQBqnhdqf/UoFGJ7KIF5bk69eqzNAFFXkoBytv75VXjEx
         UhpL6I7WgdHPQ==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-411f95b1a31so59137521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531046; x=1695135846;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+FJ5qUcevTthg+RKBHlanDF25KRUOA3+bky9ouyoIE=;
        b=RRXjVRt99QlLCrqix4cjKigRxEPDeWHKq0pn2wX0YJuppMyu9If3lGr0PLbH3R8a48
         CXIsZgCnCESgkvTZGrNXMRZIUjANFN8CPPT+W1ayjOmWS/EHFtOQrNj4oPE8BoP2/o54
         D8npdQiD019GEn6eekNNehBXOIYS3DYgl9R28yVgJ69R0AClQqg0JjLL+UM8SIdN282F
         JcvW2fyHFHACe5HRzwmT5zSKkzAZWW5bAMEDAYqsCSjYvkzROPJ+baVWY2hi+U2muL0G
         JCFzTNtIAHsaCCI9mRVrsqijNdnmNvg60k8L0y9drzcT1tBij/ZsGAfae9bm/EM49g/k
         ZMSw==
X-Gm-Message-State: AOJu0YyttyPnyrGBxg7ItOtIko4uqT377Zta3uGT9CdxdkQXz4p4Io+D
        c4dzkhlV6zkiVP8MilUWcO3T7ovbaOW3cereqAm12ZGzNA3pYNdP/nLvKXPH4NedsTraKfeOrq5
        JMekmUv354/EaoMrGz1PFjeTJJ2nVzywylcbscoBxl3x2PBx4WE/0s2zvqw==
X-Received: by 2002:ac8:5792:0:b0:412:1e0a:772a with SMTP id v18-20020ac85792000000b004121e0a772amr14240875qta.17.1694531045059;
        Tue, 12 Sep 2023 08:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXJZ9tJtDyqupBORgZnQ2b1zZkE/hgUw5vXIjxSTB1REi9bq2ivOEvuFYhLwnb7XJ11MnS4Bh94PJQPVox+1s=
X-Received: by 2002:ac8:5792:0:b0:412:1e0a:772a with SMTP id
 v18-20020ac85792000000b004121e0a772amr14240794qta.17.1694531044274; Tue, 12
 Sep 2023 08:04:04 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 08:04:03 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230825081328.204442-3-william.qiu@starfivetech.com>
References: <20230825081328.204442-1-william.qiu@starfivetech.com> <20230825081328.204442-3-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 08:04:03 -0700
Message-ID: <CAJM55Z9RsV7qGr6LUckg2XOeS2xjFO8tki3F4LoJj4COQv8dJw@mail.gmail.com>
Subject: Re: [RFC v4 2/4] pwm: starfive: Add PWM driver support
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

William Qiu wrote:
> Add Pulse Width Modulation driver support for StarFive
> JH7100 and JH7110 SoC.
>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS                    |   7 ++
>  drivers/pwm/Kconfig            |   9 ++
>  drivers/pwm/Makefile           |   1 +
>  drivers/pwm/pwm-starfive-ptc.c | 192 +++++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+)
>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d590ce31aa72..0e47818c6f64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20299,6 +20299,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>
> +STARFIVE JH71X0 PWM DRIVERS
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/starfive,jh7100-pwm.yaml
> +F:	drivers/pwm/pwm-starfive-ptc.c
> +
>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6210babb0741..48800f33b5c1 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -569,6 +569,15 @@ config PWM_SPRD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sprd.
>
> +config PWM_STARFIVE_PTC
> +	tristate "StarFive PWM PTC support"
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for StarFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-starfive-ptc.

What is PTC short for? Are there other PWM peripherals on the JH7100 or JH7110
that are not PTCs?

If there are both PTC and non-PTC PWMs on these SoCs then the device tree
compatible strings should reflect that.

If not, maybe just call this driver pwm-starfive / PWM_STARFIVE, or maybe
pwm-starfive-jh7100 / PWM_STARFIVE_JH7110 if you already know the PWMs on the
JH81xx will be different.

> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c822389c2a24..d2b2a3aeea22 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
> +obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
> new file mode 100644
> index 000000000000..57b5736f6732
> --- /dev/null
> +++ b/drivers/pwm/pwm-starfive-ptc.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM driver for the StarFive JH71x0 SoC
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* Access PTC register (CNTR, HRC, LRC and CTRL) */
> +#define REG_PTC_BASE_ADDR_SUB(base, N)	\
> +((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))

Please indent the line above.

> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
> +
> +/* PTC_RPTC_CTRL register bits*/
> +#define PTC_EN      BIT(0)
> +#define PTC_ECLK    BIT(1)
> +#define PTC_NEC     BIT(2)
> +#define PTC_OE      BIT(3)
> +#define PTC_SIGNLE  BIT(4)
> +#define PTC_INTE    BIT(5)
> +#define PTC_INT     BIT(6)
> +#define PTC_CNTRRST BIT(7)
> +#define PTC_CAPTE   BIT(8)
> +
> +struct starfive_pwm_ptc_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +static inline
> +struct starfive_pwm_ptc_device *chip_to_starfive_ptc(struct pwm_chip *c)

This looks weird. Either just put it on a single line or split between the type
and function name. Also there was recently a patch to always name pwm_chip
variables "chip".  Eg.

static inline struct starfive_pwm_ptc_device *
chip_to_starfive_ptc(struct pwm_chip *chip)
{


> +{
> +	return container_of(c, struct starfive_pwm_ptc_device, chip);
> +}
> +
> +static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
> +				      struct pwm_device *dev,
> +				      struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data = readl(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
> +	duty_data = readl(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +
> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
> +	state->polarity = PWM_POLARITY_INVERSED;
> +	state->enabled = (ctrl_data & PTC_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
> +				  struct pwm_device *dev,
> +				  const struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
> +	u32 period_data, duty_data, ctrl_data = 0;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data = DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,
> +					    NSEC_PER_SEC);
> +	duty_data = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
> +					  NSEC_PER_SEC);
> +
> +	writel(period_data, REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
> +	writel(duty_data, REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
> +	writel(0,  REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm));
> +
> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +	if (state->enabled)
> +		writel(ctrl_data | PTC_EN | PTC_OE, REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +	else
> +		writel(ctrl_data & ~(PTC_EN | PTC_OE), REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops starfive_pwm_ptc_ops = {
> +	.get_state	= starfive_pwm_ptc_get_state,
> +	.apply		= starfive_pwm_ptc_apply,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct starfive_pwm_ptc_device *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip = &pwm->chip;
> +	chip->dev = dev;
> +	chip->ops = &starfive_pwm_ptc_ops;
> +	chip->npwm = 8;
> +	chip->of_pwm_n_cells = 3;
> +
> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->regs))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
> +				     "Unable to map IO resources\n");
> +
> +	pwm->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				     "Unable to get pwm's clock\n");

I think you can use devm_clk_get_enabled() here and drop the .clk field and
clk_prepare_enable() and clk_disable_unprepare() calls below.

> +
> +	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pwm->rst))
> +		return dev_err_probe(dev, PTR_ERR(pwm->rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	ret = clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to enable clock for pwm: %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset_control_deassert(pwm->rst);

This returns an int that you ignore. Please don't do that.

> +
> +	pwm->clk_rate = clk_get_rate(pwm->clk);
> +	if (pwm->clk_rate <= 0) {
> +		dev_warn(dev, "Failed to get APB clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot register PTC: %d\n", ret);
> +		clk_disable_unprepare(pwm->clk);
> +		reset_control_assert(pwm->rst);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
> +{
> +	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
> +
> +	reset_control_assert(pwm->rst);
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id starfive_pwm_ptc_of_match[] = {
> +	{ .compatible = "starfive,jh7100-pwm" },
> +	{ .compatible = "starfive,jh7110-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
> +
> +static struct platform_driver starfive_pwm_ptc_driver = {
> +	.probe = starfive_pwm_ptc_probe,
> +	.remove = starfive_pwm_ptc_remove,
> +	.driver = {
> +		.name = "pwm-starfive-ptc",
> +		.of_match_table = starfive_pwm_ptc_of_match,
> +	},
> +};
> +module_platform_driver(starfive_pwm_ptc_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive PWM PTC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
