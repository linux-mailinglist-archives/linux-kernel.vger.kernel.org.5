Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14437862C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbjHWVws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjHWVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:52:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7800ACD1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:52:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id YvmCq4908OQiUYvmCqJyW4; Wed, 23 Aug 2023 23:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692827553;
        bh=j0Q6ZACXreioCuofyUwWPOK8JOBOw6RQa+dbcUkEeMs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eW1mjcd73bwJPRolyDkNkML9akmDe00jByLrudUfx+bXtuqE5AkqxWf+PLPlMlR74
         YI98ByZqybBI8D+G4KZQ1UV9soBFxtl4FsZQSd6LnG3awBJhuSD1JajitkXP1b/ZVM
         9fRXBqZr5BMedN7eP/XoUpeizZz+v/1bw5Qsbe6FG3Tz1739eDvvQW7Fletdj4YOQc
         x8M2zM3tdEDofFXKtKeHP50PtkZnIbGwDfmzpCOi1DbYb5heFfLpqNpGBOb4JCYq1G
         YMY7XsXk3Obx33fmwb0rR1u2rNztio98vQuOIn+/s6bYwxQIBiFZr9IfrXCM9K/i8E
         uYkB9bDagRklA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Aug 2023 23:52:33 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c0dc90d4-8ae1-8acd-8d4d-aca9515cebef@wanadoo.fr>
Date:   Wed, 23 Aug 2023 23:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] leds: max5970: Add support for max5970
Content-Language: fr
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230823212309.1463769-1-Naresh.Solanki@9elements.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230823212309.1463769-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/08/2023 à 23:23, Naresh Solanki a écrit :
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MAX5970 is hot swap controller and has 4 indication LED.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/leds/Kconfig        |  11 +++
>   drivers/leds/Makefile       |   1 +
>   drivers/leds/leds-max5970.c | 129 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 141 insertions(+)
>   create mode 100644 drivers/leds/leds-max5970.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b92208eccdea..03ef527cc545 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -637,6 +637,17 @@ config LEDS_ADP5520
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called leds-adp5520.
>   
> +config LEDS_MAX5970
> +	tristate "LED Support for Maxim 5970"
> +	depends on LEDS_CLASS
> +	depends on MFD_MAX5970
> +	help
> +	  This option enables support for the Maxim MAX5970 & MAX5978 smart
> +	  switch indication LEDs via the I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called leds-max5970.
> +
>   config LEDS_MC13783
>   	tristate "LED Support for MC13XXX PMIC"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d7348e8bc019..6eaee0a753c6 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>   obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>   obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>   obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
> +obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
>   obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>   obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>   obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
> diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> new file mode 100644
> index 000000000000..5be1b927f39e
> --- /dev/null
> +++ b/drivers/leds/leds-max5970.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for leds in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/leds.h>
> +#include <linux/mfd/max5970.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
> +
> +struct max5970_led {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct led_classdev cdev;
> +	unsigned int index;
> +};
> +
> +static int max5970_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max5970_led *ddata = ldev_to_maxled(cdev);
> +	int ret, val;
> +
> +	if (!ddata->regmap)
> +		return -ENODEV;
> +
> +	/* Set/clear corresponding bit for given led index */
> +	val = !brightness ? BIT(ddata->index) : 0;
> +
> +	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
> +	if (ret < 0)
> +		dev_err(cdev->dev, "failed to set brightness %d", ret);
> +
> +	return ret;
> +}
> +
> +static int max5970_setup_led(struct max5970_led *ddata, struct regmap *regmap,
> +			     struct device_node *nc, u32 reg)
> +{
> +	int ret;
> +
> +	if (of_property_read_string(nc, "label", &ddata->cdev.name))
> +		ddata->cdev.name = nc->name;
> +
> +	ddata->cdev.max_brightness = 1;
> +	ddata->cdev.brightness_set_blocking = max5970_led_set_brightness;
> +	ddata->cdev.default_trigger = "none";
> +
> +	ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);
> +	if (ret)
> +		dev_err(ddata->dev, "Error initializing LED %s", ddata->cdev.name);
> +
> +	return ret;
> +}
> +
> +static int max5970_led_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev->parent);
> +	struct regmap *regmap;
> +	struct device_node *led_node;
> +	struct device_node *child;
> +	struct max5970_led *ddata[MAX5970_NUM_LEDS];
> +	int ret = -ENODEV, num_leds = 0;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	led_node = of_get_child_by_name(np, "leds");
> +	if (!led_node)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(led_node, child) {
> +		u32 reg;
> +
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg >= MAX5970_NUM_LEDS) {
> +			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX5970_NUM_LEDS);
> +			continue;
> +		}
> +
> +		ddata[num_leds] = devm_kzalloc(dev, sizeof(struct max5970_led), GFP_KERNEL);
> +		if (!ddata[num_leds]) {
> +			ret = -ENOMEM;

Hi,

Should we have a "of_node_put(child);" here?

> +			goto exit;
> +		}
> +
> +		ddata[num_leds]->index = reg;
> +		ddata[num_leds]->regmap = regmap;
> +		ddata[num_leds]->dev = dev;
> +
> +		ret = max5970_setup_led(ddata[num_leds], regmap, child, reg);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to initialize LED %u\n", reg);

Should we have a "of_node_put(child);" here?

> +			goto exit;
> +		}
> +		num_leds++;
> +	}
> +
> +	return ret;
> +
> +exit:
> +	for (int j = 0; j < num_leds; j++)
> +		devm_led_classdev_unregister(dev, &ddata[j]->cdev);

Is it really needed?
There is no equivalent call in a .remove function and 
devm_led_classdev_register() is used.

Shouldn't the unregister step be done automatically by the framework?

CJ

> +
> +	return ret;
> +}
> +
> +static struct platform_driver max5970_led_driver = {
> +	.driver = {
> +		.name = "max5970-led",
> +	},
> +	.probe = max5970_led_probe,
> +};
> +
> +module_platform_driver(max5970_led_driver);
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> +MODULE_LICENSE("GPL");
> 
> base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8

