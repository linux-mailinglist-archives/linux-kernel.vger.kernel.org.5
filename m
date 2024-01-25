Return-Path: <linux-kernel+bounces-38576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599EE83C277
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076D8291428
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372745C1C;
	Thu, 25 Jan 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOh7T/QS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6A374F5;
	Thu, 25 Jan 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185600; cv=none; b=Xkfs7yBUq3cRrEMgOcvaqWURfs5RqcQwG9b7jrdVv6An3E7KUWGfx8bd+g66dEGkv8YFBJOVlFZwwzq5KgYK0+FrbxdxZdC3Mpk8j/kUkLnp2Dag4YkksqDmYRl2KHR5pA+1moVOlCg7Tta51yjKVwAiShYhZxcNzNInAuYkxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185600; c=relaxed/simple;
	bh=eg0BE0/bzHiVwjqaGGkO59lR5yhNlSyrwoDGQHAKiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1+3xn/sYtAGGSYqhVYsdyDthMHsIdQi6G+4JAgRfMDiQP4e12DcXSZmEmkDAPwEbdzuDlQjPFyE7MWBAgEM44cyXANYOBfd8XMiv/hUIrorsP7ao9tfJvFAygX32OhAkZojoi3EO59i1NYjt+XUzHCUQdCzmTCoACJ4BqhSAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOh7T/QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F2EC433F1;
	Thu, 25 Jan 2024 12:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185600;
	bh=eg0BE0/bzHiVwjqaGGkO59lR5yhNlSyrwoDGQHAKiCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOh7T/QSBw5sOWUjJsXbE8hWEIzW5nQwRQLSWteW1SCL9tJ1njr3CurQrWSfay0Rd
	 AK//QA4mV1OVfjb4kjeljj5l67Cdd8HDHCYCds0dbeflBjPgk2nZ3MRM4n2VkjWzQP
	 qH4wgEqb3R1mPDJOQLxT12C5L9xeN5cxzuptHjf3GAZt4qPBHl5kN4Vr6p3mWgIQN1
	 4Ov16tACzBjJsRAaj/GxMeIF5YaEndARx/7XXcr5WsJFKmerKLOcGmfLnn1kIgLFxc
	 QSFbvkHT9I+/SgJRRWndvHrOUOWUTq7szVFcS1clZbup5x7t36xu+0mlrOewUzYHCd
	 VKI7Bsetl6kig==
Date: Thu, 25 Jan 2024 12:26:34 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
Message-ID: <20240125122634.GE74950@google.com>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>

On Sun, 17 Dec 2023, Karel Balej wrote:

> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM880 and 8PM886 are two similar PMICs with mostly matching
> register mapping. They provide various functions such as onkey, battery,
> charger and regulators.
> 
> Add support for 88PM886 found for instance in the samsung,coreprimevelte
> smartphone with which this was tested. Support for 88PM880 is not
> implemented here but should be straightforward to add.
> 
> Implement only the most basic support omitting the currently unused
> registers and I2C subclients which should thus be added with the
> respective subdevices. However, add support for the onkey already.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  drivers/mfd/88pm88x.c       | 199 ++++++++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig         |  11 ++
>  drivers/mfd/Makefile        |   1 +
>  include/linux/mfd/88pm88x.h |  60 +++++++++++
>  4 files changed, 271 insertions(+)
>  create mode 100644 drivers/mfd/88pm88x.c
>  create mode 100644 include/linux/mfd/88pm88x.h
> 
> diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
> new file mode 100644
> index 000000000000..5db6c65b667d
> --- /dev/null
> +++ b/drivers/mfd/88pm88x.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>

Alphabetical

> +#include <linux/mfd/88pm88x.h>
> +
> +/* interrupt status registers */

Use correct grammar in comments, including capital letters.

 - Applies throughout

The comment is not required - we can see what they are from the
nomenclature.

> +#define PM88X_REG_INT_STATUS1			0x05
> +
> +#define PM88X_REG_INT_ENA_1			0x0a
> +#define PM88X_INT_ENA1_ONKEY			BIT(0)
> +
> +enum pm88x_irq_number {
> +	PM88X_IRQ_ONKEY,
> +
> +	PM88X_MAX_IRQ
> +};

An enum for a single IRQ?

> +static struct regmap_irq pm88x_regmap_irqs[] = {
> +	REGMAP_IRQ_REG(PM88X_IRQ_ONKEY, 0, PM88X_INT_ENA1_ONKEY),
> +};
> +
> +static struct regmap_irq_chip pm88x_regmap_irq_chip = {
> +	.name = "88pm88x",
> +	.irqs = pm88x_regmap_irqs,
> +	.num_irqs = ARRAY_SIZE(pm88x_regmap_irqs),
> +	.num_regs = 4,
> +	.status_base = PM88X_REG_INT_STATUS1,
> +	.ack_base = PM88X_REG_INT_STATUS1,
> +	.unmask_base = PM88X_REG_INT_ENA_1,
> +};
> +
> +static struct reg_sequence pm886_presets[] = {
> +	/* disable watchdog */
> +	REG_SEQ0(PM88X_REG_WDOG, 0x01),

Easier to read if you place spaces between them.

> +	/* GPIO1: DVC, GPIO0: input */
> +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),

Shouldn't you set these up using Pintrl?

> +	/* GPIO2: input */
> +	REG_SEQ0(PM88X_REG_GPIO_CTRL2, 0x00),
> +	/* DVC2, DVC1 */

Please unify all of the comments.

They all use a different structure.

> +	REG_SEQ0(PM88X_REG_GPIO_CTRL3, 0x44),
> +	/* GPIO5V_1:input, GPIO5V_2: input */
> +	REG_SEQ0(PM88X_REG_GPIO_CTRL4, 0x00),
> +	/* output 32 kHz from XO */
> +	REG_SEQ0(PM88X_REG_AON_CTRL2, 0x2a),
> +	/* OSC_FREERUN = 1, to lock FLL */
> +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL1, 0x0f),
> +	/* XO_LJ = 1, enable low jitter for 32 kHz */
> +	REG_SEQ0(PM88X_REG_LOWPOWER2, 0x20),
> +	/* OV_VSYS and UV_VSYS1 comparators on VSYS disabled, VSYS_OVER_TH : 5.6V */
> +	REG_SEQ0(PM88X_REG_LOWPOWER4, 0xc8),
> +	/* set the duty cycle of charger DC/DC to max */
> +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),

These all looks like they should be handled in their respective drivers?

"patch"ing these in seems like a hack.

> +};

Why this instead of 
> +static struct resource onkey_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
> +};
> +
> +static struct mfd_cell pm88x_devs[] = {
> +	{
> +		.name = "88pm88x-onkey",
> +		.num_resources = ARRAY_SIZE(onkey_resources),
> +		.resources = onkey_resources,
> +		.id = -1,
> +	},
> +};

It's not an MFD if it only supports a single device.

> +static struct pm88x_data pm886_a1_data = {
> +	.whoami = PM886_A1_WHOAMI,
> +	.presets = pm886_presets,
> +	.num_presets = ARRAY_SIZE(pm886_presets),
> +};

Just pass the device ID through DT's .data, then match on that instead
of passing pointer to random data structures.

> +static const struct regmap_config pm88x_i2c_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xfe,

Define this please.

> +};
> +
> +static int pm88x_power_off_handler(struct sys_off_data *data)

'data' is a terrible variable name.  Please change throughout.

> +{
> +	struct pm88x_chip *chip = data->cb_data;
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_MISC_CONFIG1,
> +			PM88X_SW_PDOWN, PM88X_SW_PDOWN);
> +	if (ret) {
> +		dev_err(&chip->client->dev, "Failed to power off the device: %d\n", ret);
> +		return NOTIFY_BAD;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static int pm88x_setup_irq(struct pm88x_chip *chip)
> +{
> +	int ret;
> +
> +	/* set interrupt clearing mode to clear on write */
> +	ret = regmap_update_bits(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_MISC_CONFIG2,
> +			PM88X_INT_INV | PM88X_INT_CLEAR | PM88X_INT_MASK_MODE,
> +			PM88X_INT_WC);
> +	if (ret) {
> +		dev_err(&chip->client->dev, "Failed to set interrupt clearing mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_regmap_add_irq_chip(&chip->client->dev, chip->regmaps[PM88X_REGMAP_BASE],
> +			chip->client->irq, IRQF_ONESHOT, -1, &pm88x_regmap_irq_chip,
> +			&chip->irq_data);
> +	if (ret) {
> +		dev_err(&chip->client->dev, "Failed to request IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pm88x_probe(struct i2c_client *client)
> +{
> +	struct pm88x_chip *chip;
> +	int ret = 0;
> +	unsigned int chip_id;
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	chip->data = device_get_match_data(&client->dev);

Now where is this being past to?

What is going to consume this?

> +	i2c_set_clientdata(client, chip);
> +
> +	device_init_wakeup(&client->dev, 1);
> +
> +	chip->regmaps[PM88X_REGMAP_BASE] = devm_regmap_init_i2c(client, &pm88x_i2c_regmap);
> +	if (IS_ERR(chip->regmaps[PM88X_REGMAP_BASE])) {

Just define different regmaps if you really need them.

I only see one being used anyway.

> +		ret = PTR_ERR(chip->regmaps[PM88X_REGMAP_BASE]);
> +		dev_err(&client->dev, "Failed to initialize regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_ID, &chip_id);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to read chip ID: %d\n", ret);
> +		return ret;
> +	}
> +	if (chip->data->whoami != chip_id) {
> +		dev_err(&client->dev, "Device reported wrong chip ID: %u\n", chip_id);

Use dev_err_probe() throughout.

> +		return -EINVAL;
> +	}
> +
> +	ret = pm88x_setup_irq(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mfd_add_devices(&client->dev, 0, pm88x_devs, ARRAY_SIZE(pm88x_devs),
> +			NULL, 0, regmap_irq_get_domain(chip->irq_data));
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to add devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_register_patch(chip->regmaps[PM88X_REGMAP_BASE], chip->data->presets,
> +			chip->data->num_presets);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register regmap patch: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_register_power_off_handler(&client->dev, pm88x_power_off_handler, chip);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register power off handler: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct of_device_id pm88x_of_match[] = {
> +	{ .compatible = "marvell,88pm886-a1", .data = &pm886_a1_data },
> +	{ },
> +};
> +
> +static struct i2c_driver pm88x_i2c_driver = {
> +	.driver = {
> +		.name = "88pm88x",
> +		.of_match_table = of_match_ptr(pm88x_of_match),
> +	},
> +	.probe = pm88x_probe,
> +};
> +module_i2c_driver(pm88x_i2c_driver);
> +
> +MODULE_DESCRIPTION("Marvell 88PM88X PMIC driver");
> +MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 90ce58fd629e..c593279fd766 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -794,6 +794,17 @@ config MFD_88PM860X
>  	  select individual components like voltage regulators, RTC and
>  	  battery-charger under the corresponding menus.
>  
> +config MFD_88PM88X

"MFD_88PM88X_PMIC"?

> +	bool "Marvell 88PM886"

"Marvell 88PM886 PMIC"?

> +	depends on I2C=y
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  This enables support for Marvell 88PM886 Power Management IC.
> +	  This includes the I2C driver and the core APIs _only_, you have to
> +	  select individual components like onkey under the corresponding menus.
> +
>  config MFD_MAX14577
>  	tristate "Maxim Semiconductor MAX14577/77836 MUIC + Charger Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c66f07edcd0e..14e42b045c92 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
>  obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
> +obj-$(CONFIG_MFD_88PM88X)	+= 88pm88x.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> new file mode 100644
> index 000000000000..a34c57447827
> --- /dev/null
> +++ b/include/linux/mfd/88pm88x.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __LINUX_MFD_88PM88X_H
> +#define __LINUX_MFD_88PM88X_H

Drop the LINUX part.

> +
> +#include <linux/mfd/core.h>
> +
> +#define PM886_A1_WHOAMI		0xa1

s/WHOAMI/CHIP_ID/

> +#define PM88X_REG_ID			0x00
> +
> +#define PM88X_REG_STATUS1		0x01
> +#define PM88X_ONKEY_STS1		BIT(0)
> +
> +#define PM88X_REG_MISC_CONFIG1		0x14
> +#define PM88X_SW_PDOWN			BIT(5)
> +
> +#define PM88X_REG_MISC_CONFIG2		0x15
> +#define PM88X_INT_INV			BIT(0)
> +#define PM88X_INT_CLEAR			BIT(1)
> +#define PM88X_INT_RC			0x00
> +#define PM88X_INT_WC			BIT(1)
> +#define PM88X_INT_MASK_MODE		BIT(2)
> +
> +#define PM88X_REG_WDOG			0x1d
> +
> +#define PM88X_REG_LOWPOWER2		0x21
> +#define PM88X_REG_LOWPOWER4		0x23
> +
> +#define PM88X_REG_GPIO_CTRL1		0x30

These don't really need to be spaced out, do they?

> +#define PM88X_REG_GPIO_CTRL2		0x31
> +
> +#define PM88X_REG_GPIO_CTRL3		0x32
> +
> +#define PM88X_REG_GPIO_CTRL4		0x33
> +
> +#define PM88X_REG_BK_OSC_CTRL1		0x50
> +#define PM88X_REG_BK_OSC_CTRL3		0x52
> +
> +#define PM88X_REG_AON_CTRL2		0xe2
> +
> +enum pm88x_regmap_index {
> +	PM88X_REGMAP_BASE,
> +
> +	PM88X_REGMAP_NR
> +};
> +
> +struct pm88x_data {
> +	unsigned int whoami;
> +	struct reg_sequence *presets;
> +	unsigned int num_presets;
> +};
> +
> +struct pm88x_chip {
> +	struct i2c_client *client;
> +	struct regmap_irq_chip_data *irq_data;

Group this with the other regmap related member(s).

What are you using this for?

> +	const struct pm88x_data *data;

Remove this.

> +	struct regmap *regmaps[PM88X_REGMAP_NR];
> +};
> +#endif /* __LINUX_MFD_88PM88X_H */
> -- 
> 2.43.0
> 

-- 
9)
4)
Lee Jones [李琼斯]

