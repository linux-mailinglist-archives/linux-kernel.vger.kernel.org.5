Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBC7D4BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjJXJRB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJXJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:16:59 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA5C2;
        Tue, 24 Oct 2023 02:16:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2616380F8;
        Tue, 24 Oct 2023 17:16:51 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 24 Oct
 2023 17:16:51 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 24 Oct
 2023 17:16:50 +0800
Message-ID: <b2ef7299-5d5a-4ef7-89fd-04b6130cb227@starfivetech.com>
Date:   Tue, 24 Oct 2023 17:16:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/20 19:25, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 20, 2023 at 06:37:39PM +0800, William Qiu wrote:
>> Add Pulse Width Modulation driver support for OpenCores.
>> 
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  MAINTAINERS              |   7 ++
>>  drivers/pwm/Kconfig      |  11 ++
>>  drivers/pwm/Makefile     |   1 +
>>  drivers/pwm/pwm-ocores.c | 211 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 230 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-ocores.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6c4cce45a09d..321af8fa7aad 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16003,6 +16003,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>>  F:	drivers/i2c/busses/i2c-ocores.c
>>  F:	include/linux/platform_data/i2c-ocores.h
>> 
>> +OPENCORES PWM DRIVER
>> +M:	William Qiu <william.qiu@starfivetech.com>
>> +M:	Hal Feng <hal.feng@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
>> +F:	drivers/pwm/pwm-ocores.c
>> +
>>  OPENRISC ARCHITECTURE
>>  M:	Jonas Bonn <jonas@southpole.se>
>>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 8ebcddf91f7b..cbfbf227d957 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -434,6 +434,17 @@ config PWM_NTXEC
>>  	  controller found in certain e-book readers designed by the original
>>  	  design manufacturer Netronix.
>> 
>> +config PWM_OCORES
>> +	tristate "Opencores PWM support"
>> +	depends on HAS_IOMEM && OF
>> +	depends on COMMON_CLK && RESET_CONTROLLER
> 
> Would it make sense to add something like:
> 
> 	depends on ARCH_SOMETHING || COMPILE_TEST
> 
> here?
> 
But there is no mention of architectural limitations in the OpenCores's
specification.
>> +	help
>> +	  If you say yes to this option, support will be included for the
>> +	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-ocores.
>> +
>>  config PWM_OMAP_DMTIMER
>>  	tristate "OMAP Dual-Mode Timer PWM support"
>>  	depends on OF
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index c822389c2a24..542b98202153 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -39,6 +39,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
>>  obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
>>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>>  obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
>> +obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
>>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
>>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
>> new file mode 100644
>> index 000000000000..7a510de4e063
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ocores.c
>> @@ -0,0 +1,211 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * OpenCores PWM Driver
>> + *
>> + * https://opencores.org/projects/ptc
>> + *
>> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
>> + */
> 
> Please add a section here describing the hardware limitations. Please
> stick to the format used e.g. in drivers/pwm/pwm-sl28cpld.c to make this
> easy to grep for. It should mention for example that the hardware can
> only do inverted polarity.
> 
Will add.
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +#define REG_OCPWM_CNTR(base)	((base))
>> +#define REG_OCPWM_HRC(base)	((base) + 0x4)
>> +#define REG_OCPWM_LRC(base)	((base) + 0x8)
>> +#define REG_OCPWM_CTRL(base)	((base) + 0xC)
> 
> This is unusual, I would skip base here and do the addition explicitly
> in some static inline helpers like:
> 
> 	static inline ocores_writel(struct ocores_pwm_device *, unsigned int offset, u32 val);
> 
Will update.
>> +/* OCPWM_CTRL register bits*/
>> +#define OCPWM_EN      BIT(0)
>> +#define OCPWM_ECLK    BIT(1)
>> +#define OCPWM_NEC     BIT(2)
>> +#define OCPWM_OE      BIT(3)
>> +#define OCPWM_SIGNLE  BIT(4)
>> +#define OCPWM_INTE    BIT(5)
>> +#define OCPWM_INT     BIT(6)
>> +#define OCPWM_CNTRRST BIT(7)
>> +#define OCPWM_CAPTE   BIT(8)
> 
> I like register bit fields being named with the register as prefix, so I
> suggest:
> 
> 	#define	REG_OCPWM_CTRL_EN	BIT(0)
> 	...
> 
Will update.
>> +
>> +struct ocores_pwm_device {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	struct reset_control *rst;
>> +	const struct ocores_pwm_data *data;
>> +	void __iomem *regs;
>> +	u32 clk_rate; /* PWM APB clock frequency */
>> +};
>> +
>> +struct ocores_pwm_data {
>> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> 
> It might be worth to mark this with the function attribute const.
> 
Will update.
>> +};
>> +
>> +static inline struct ocores_pwm_device *
>> +chip_to_ocores(struct pwm_chip *chip)
> 
> These two lines can go in a single one.
> 
>> +
Will update.
> 
> please drop this empty line.
> 
Will drop.
>> +{
>> +	return container_of(chip, struct ocores_pwm_device, chip);
>> +}
>> +
>> +void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
>> +					  unsigned int channel)
>> +{
>> +	return base + (channel > 3 ? channel % 4 * 0x10 + (1 << 15) : channel * 0x10);
> 
> Maybe make this:
> 
> 	unsigned int offset =
> 		(channel > 3 ? 1 << 15 : 0) +
> 		(channel & 3) * 0x10
> 	...
> 
> or even:
> 
> 	unsigned int offset = (channel & 4) << 13 + (channel & 3) * 0x10;
> 
> The former is easier to read, the latter might be compiled to faster
> code.
> 
Will update.
> Alternatively: Is it easier/sensible to model the jh71x0 hardware as two
> PWM chips with 4 lines each?
> 
Maybe it's better to stick with the original.  
>> +}
>> +
>> +static int ocores_pwm_get_state(struct pwm_chip *chip,
>> +				struct pwm_device *dev,
>> +				struct pwm_state *state)
>> +{
>> +	struct ocores_pwm_device *pwm = chip_to_ocores(chip);
> 
> Please use "pwm" for variables of type struct pwm_device and pick
> something different for ocores_pwm_device variables. I suggest something
> like "ddata" or "opd".
> 
Will update.
>> +	void __iomem *base = pwm->data->get_ch_base ?
>> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
>> +	u32 period_data, duty_data, ctrl_data;
>> +
>> +	period_data = readl(REG_OCPWM_LRC(base));
>> +	duty_data = readl(REG_OCPWM_HRC(base));
>> +	ctrl_data = readl(REG_OCPWM_CTRL(base));
>> +
>> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
> 
> Please test your driver with PWM_DEBUG enabled. The rounding is wrong
> here.
> 
Will check
>> +	state->polarity = PWM_POLARITY_INVERSED;
>> +	state->enabled = (ctrl_data & OCPWM_EN) ? true : false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ocores_pwm_apply(struct pwm_chip *chip,
>> +			    struct pwm_device *dev,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct ocores_pwm_device *pwm = chip_to_ocores(chip);
>> +	void __iomem *base = pwm->data->get_ch_base ?
>> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
>> +	u32 period_data, duty_data, ctrl_data = 0;
>> +
>> +	if (state->polarity != PWM_POLARITY_INVERSED)
>> +		return -EINVAL;
>> +
>> +	period_data = DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,
> 
> this multiplication might overflow. And also wrong rounding. I didn't
> check, but maybe DIV_ROUND_CLOSEST_ULL might return a value > U32_MAX?
> 
Will check
>> +					    NSEC_PER_SEC);
>> +	duty_data = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
>> +					  NSEC_PER_SEC);
>> +
>> +	writel(period_data, REG_OCPWM_LRC(base));
>> +	writel(duty_data, REG_OCPWM_HRC(base));
>> +	writel(0,  REG_OCPWM_CNTR(base));
> 
> s/  / /
> 
> I assume this is "glitchy", i.e. after updating the REG_OCPWM_LRC and
> before updating REG_OCPWM_HRC the signal emitted might be a mixture
> between old and new state? This should be mentioned in the Limitations
> section I mentioned above. Also mention that the currently running
> period is not completed and how the output behave if the hardware is
> disabled.
> 
Will check
>> +
>> +	ctrl_data = readl(REG_OCPWM_CTRL(base));
>> +	if (state->enabled)
>> +		writel(ctrl_data | OCPWM_EN | OCPWM_OE, REG_OCPWM_CTRL(base));
>> +	else
>> +		writel(ctrl_data & ~(OCPWM_EN | OCPWM_OE), REG_OCPWM_CTRL(base));
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops ocores_pwm_ops = {
>> +	.get_state	= ocores_pwm_get_state,
>> +	.apply		= ocores_pwm_apply,
>> +	.owner		= THIS_MODULE,
> 
> The assignment to .owner should be dropped. (See commit
> 384461abcab6602abc06c2dfb8fb99beeeaa12b0)
> 
Will drop.
>> +};
>> +
>> +static const struct ocores_pwm_data jh71x0_pwm_data = {
>> +	.get_ch_base = starfive_jh71x0_get_ch_base,
>> +};
>> +
>> +static const struct of_device_id ocores_pwm_of_match[] = {
>> +	{ .compatible = "opencores,pwm-ocores" },
>> +	{ .compatible = "starfive,jh71x0-pwm", .data = &jh71x0_pwm_data},
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
>> +
>> +static int ocores_pwm_probe(struct platform_device *pdev)
>> +{
>> +	const struct of_device_id *id;
>> +	struct device *dev = &pdev->dev;
>> +	struct ocores_pwm_device *pwm;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	id = of_match_device(ocores_pwm_of_match, dev);
>> +	if (!id)
>> +		return -EINVAL;
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	pwm->data = id->data;
>> +	chip = &pwm->chip;
>> +	chip->dev = dev;
>> +	chip->ops = &ocores_pwm_ops;
>> +	chip->npwm = 8;
>> +	chip->of_pwm_n_cells = 3;
>> +
>> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pwm->regs))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
>> +				     "Unable to map IO resources\n");
>> +
>> +	pwm->clk = devm_clk_get_enabled(dev, NULL);
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +				     "Unable to get pwm's clock\n");
>> +
>> +	pwm->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
>> +	reset_control_deassert(pwm->rst);
>> +
>> +	pwm->clk_rate = clk_get_rate(pwm->clk);
>> +	if (pwm->clk_rate <= 0) {
>> +		dev_warn(dev, "Failed to get APB clock rate\n");
>> +		return -EINVAL;
> 
> dev_err_probe() here, too? Missing call to reset_control_assert().
> 
Will update
>> +	}
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot register PTC: %d\n", ret);
> 
> dev_err_probe()
> 
Will update
>> +		clk_disable_unprepare(pwm->clk);
> 
> This is wrong, devm_clk_get_enabled() cares for that.
> 
Will update
>> +		reset_control_assert(pwm->rst);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +
>> +	return 0;
> 
> If you call platform_set_drvdata() earlier you can just return ret here
> and drop the return in the error path above.
> 
Will drop.
>> +}
>> +
>> +static int ocores_pwm_remove(struct platform_device *dev)
>> +{
>> +	struct ocores_pwm_device *pwm = platform_get_drvdata(dev);
>> +
>> +	reset_control_assert(pwm->rst);
>> +	clk_disable_unprepare(pwm->clk);
> 
> Wrong in the same way as the call in .probe()'s error path.
> 
Will update.
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver ocores_pwm_driver = {
>> +	.probe = ocores_pwm_probe,
>> +	.remove = ocores_pwm_remove,
> 
> Please use .remove_new
> 
Will update.
>> +	.driver = {
>> +		.name = "ocores-pwm",
>> +		.of_match_table = ocores_pwm_of_match,
>> +	},
>> +};
>> +module_platform_driver(ocores_pwm_driver);
>> +
>> +MODULE_AUTHOR("Jieqin Chen");
> 
> Jieqin Chen != William Qiu ?
> 
This driver was originally written by Chen Jieqin, but she left, so I
just based on her driver to do upstream, so I think the author is
still her.


Thanks for taking time to review this patch series and give a lot of
useful suggestion,

Best regards,
William
>> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
>> +MODULE_DESCRIPTION("OpenCores PWM PTC driver");
>> +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe
> 
