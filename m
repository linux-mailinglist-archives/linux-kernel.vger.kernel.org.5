Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B37DC800
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjJaIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjJaIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:16:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F914DE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:16:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3c8adb27so792817766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698740170; x=1699344970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goof15RNeU0KLHtGHQUeg5uXRfnDboIB8cpBpI1bxBs=;
        b=X51vj4IgtJlDylKdzk/D2cw31TexiCzaOPxPFLD0Xji1B6eo28Fbs9qRVGMmTdbodl
         0w3BPnAqx0hpcsc3WPBpfd8B66etK7U1GlGHD2X3w+BXK06b/SKUlIBQ4QUwDxtEOtPU
         WdrlkP7DEYGJ4tUVaomTngSPQNUKF50MWM4kMBc2ILZlKTlq/tvqEHaMrjmc5spRBFqv
         ubdPGtGo2l93D98wGqc0TDZlP3bhIKHlwv6hFPPIGzkUko5l8Q0ZSis+nTUCLjk7Ucyz
         wmPCbZFUA3wyhX/AAbfTcXutKtRdSQw74TJ765hKrptuYDOIAng7XV++Ux+c2wwfTe8S
         LN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740170; x=1699344970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goof15RNeU0KLHtGHQUeg5uXRfnDboIB8cpBpI1bxBs=;
        b=iAj71ZxFin45pj9iFoYycWINw5379Sdf5hnjtHdoTpIYEOlM9WhDt+pbNfrlurP5Kr
         9qqIuYNA/dIc0h4Fe00LDnmsVQgW/j+yFBT/Wog7Q+oxvIXAv29kdv3McDGLvYYi2AcE
         Td1+xZF5yJDCDE/R3OJFC4gkBliry8iwWYWSXqgH0Z8deHOnmD7ZZSpD5vZLocKSkYDE
         w+eRtw5gDe+9R9Pzv+zWMcKyurqz/8sLbDRKaMHB+9uxr3FbEPJY7zdu/2JyATD5JH1F
         CiQGXlwFNucpN02MlzOkUkgKgHN0elAh3ZVydC7lZ6dl92WJ8K1mjGYT0lOT7b++N8Vt
         HOgQ==
X-Gm-Message-State: AOJu0YxswCK+Nic2L8vsPG4gGYtBraMXnffgiCM+OG3Sgrps5jFdFrRV
        m8yNRNHTG12z8oZq45enBrGQIw==
X-Google-Smtp-Source: AGHT+IHcFLwPmducaku0lltVCh0Y5JO215+TBhxgO/K0NuBXPhXcsRPvx0/+IcuLhYSi3M25webhFw==
X-Received: by 2002:a17:907:6015:b0:9d1:a628:3e3f with SMTP id fs21-20020a170907601500b009d1a6283e3fmr4997256ejc.45.1698740170539;
        Tue, 31 Oct 2023 01:16:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z7-20020a50cd07000000b0053e5a1bf77dsm704672edi.88.2023.10.31.01.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:16:09 -0700 (PDT)
Message-ID: <d10dfd28-0116-47cc-8ee7-52261495698f@linaro.org>
Date:   Tue, 31 Oct 2023 09:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] leds: add mp3326 driver
Content-Language: en-US
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
References: <ab9663a6b41e4bd7b347f51f72f5c4a1@monolithicpower.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ab9663a6b41e4bd7b347f51f72f5c4a1@monolithicpower.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 08:01, Yuxi (Yuxi) Wang wrote:
> 
> This patch adds mp3326 led driver.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> ---
>  drivers/leds/Kconfig       |   7 +
>  drivers/leds/Makefile      |   1 +
>  drivers/leds/leds-mp3326.c | 632 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 640 insertions(+)
>  create mode 100644 drivers/leds/leds-mp3326.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b92208eccdea..ac8115bffc2e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -260,6 +260,13 @@ config LEDS_MIKROTIK_RB532
>  	  This option enables support for the so called "User LED" of
>  	  Mikrotik's Routerboard 532.
>  
> +config LEDS_MP3326
> +	tristate "LED Support for MPS MP3326"
> +	depends on LEDS_CLASS
> +	help
> +	  This option enables support for on-chip LED drivers found on
> +	  MPS MP3326.
> +
>  config LEDS_MT6323
>  	tristate "LED Support for Mediatek MT6323 PMIC"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d7348e8bc019..196befb56278 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
>  obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+= leds-rb532.o
>  obj-$(CONFIG_LEDS_MLXCPLD)		+= leds-mlxcpld.o
>  obj-$(CONFIG_LEDS_MLXREG)		+= leds-mlxreg.o
> +obj-$(CONFIG_LEDS_MP3326)		+= leds-mp3326.o
>  obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>  obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
>  obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
> diff --git a/drivers/leds/leds-mp3326.c b/drivers/leds/leds-mp3326.c
> new file mode 100644
> index 000000000000..140c71b334f7
> --- /dev/null
> +++ b/drivers/leds/leds-mp3326.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MP3326 Led driver
> + *
> + * Copyright 2023 Monolithic Power Systems, Inc
> + *
> + * Author: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> + */
> +#include <linux/bits.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/leds.h>
> +#include <linux/device.h>
> +#include <linux/led-class-multicolor.h>
> +
> +#define MP3326_PWM_DIM_FREQUENCY_CONFIG			0x00
> +#define MP3326_PWM_CTRL							0x01
> +#define MP3326_PWM_DIM_FREQUENCY_CONFIG			0x00
> +#define MP3326_PWM_CTRL_CHANNEL_9_16			0x04
> +#define MP3326_PWM_CTRL_CHANNEL_1_8				0x05
> +#define MP3326_PWM_OPEN_FAULT_CHANNEL_9_16		0x06
> +#define MP3326_PWM_OPEN_FAULT_CHANNEL_1_8		0x07
> +#define MP3326_PWM_SHORT_FAULT_CHANNEL_9_16		0x08
> +#define MP3326_PWM_SHORT_FAULT_CHANNEL_1_8		0x09
> +#define MP3326_PWM_CURRENT_SET_CHANNEL1			0x0A
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL1		0x0B
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL1		0x0C
> +#define MP3326_PWM_CURRENT_SET_CHANNEL2			0x0D
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL2		0x0E
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL2		0x0F
> +#define MP3326_PWM_CURRENT_SET_CHANNEL3			0x10
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL3		0x11
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL3		0x12
> +#define MP3326_PWM_CURRENT_SET_CHANNEL4			0x13
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL4		0x14
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL4		0x15
> +#define MP3326_PWM_CURRENT_SET_CHANNEL5			0x16
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL5		0x17
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL5		0x18
> +#define MP3326_PWM_CURRENT_SET_CHANNEL6			0x19
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL6		0x1A
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL6		0x1B
> +#define MP3326_PWM_CURRENT_SET_CHANNEL7			0x1C
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL7		0x1D
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL7		0x1E
> +#define MP3326_PWM_CURRENT_SET_CHANNEL8			0x1F
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL8		0x20
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL8		0x21
> +#define MP3326_PWM_CURRENT_SET_CHANNEL9			0x22
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL9		0x23
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL9		0x24
> +#define MP3326_PWM_CURRENT_SET_CHANNEL10		0x25
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL10		0x26
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL10		0x27
> +#define MP3326_PWM_CURRENT_SET_CHANNEL11		0x28
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL11		0x29
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL11		0x2A
> +#define MP3326_PWM_CURRENT_SET_CHANNEL12		0x2B
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL12		0x2C
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL12		0x2D
> +#define MP3326_PWM_CURRENT_SET_CHANNEL13		0x2E
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL13		0x2F
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL13		0x30
> +#define MP3326_PWM_CURRENT_SET_CHANNEL14		0x31
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL14		0x32
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL14		0x33
> +#define MP3326_PWM_CURRENT_SET_CHANNEL15		0x34
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL15		0x35
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL15		0x36
> +#define MP3326_PWM_CURRENT_SET_CHANNEL16		0x37
> +#define MP3326_PWM_DUTY_LSB_SET_CHANNEL16		0x38
> +#define MP3326_PWM_DUTY_MSB_SET_CHANNEL16		0x39
> +#define MAX_BRIGHTNESS	63
> +
> +enum led_ctrl {
> +	ENABLE = 0,
> +	BRIGHTNESS,
> +	COLOR_L4,
> +	COLOR_H8,
> +	OPEN_FAULT,
> +	SHORT_FAULT,
> +	Max_CTRL,

Dpn't use CamelCase

> +};
> +
> +enum mp3326_channel {
> +	Channel1,
> +	Channel2,
> +	Channel3,
> +	Channel4,
> +	Channel5,
> +	Channel6,
> +	Channel7,
> +	Channel8,
> +	Channel9,
> +	Channel10,
> +	Channel11,
> +	Channel12,
> +	Channel13,
> +	Channel14,
> +	Channel15,
> +	Channel16,

Ditto


> +	Max_Channel,> +};
> +
> +#define MP3326_Reg_Connect_Inner(prefix, range)	prefix##range
> +#define MP3326_Reg_Connect(prefix, range)		MP3326_Reg_Connect_Inner(prefix, range)
> +#define MP3326_Reg_Field(reg, minbit, maxbit)	REG_FIELD(reg, minbit, maxbit)
> +#define Range1(a, b) MP3326_Reg_Connect_Inner(a, b)
> +#define Range2(a, b) MP3326_Reg_Connect_Inner(a, b)

OK, so this driver was copied from some out-of-tree, poor quality old
code not even using Linux coding style. Please rewrite everything to
match Linux coding style.

> +
> +#define MP3326_Channel_FIELD(bit, num, range) { \
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_CTRL_CHANNEL_, range), bit, bit),	\
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_CURRENT_SET_CHANNEL, num), 0, 5),	\
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_DUTY_LSB_SET_CHANNEL, num), 0, 3),	\
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_DUTY_MSB_SET_CHANNEL, num), 0, 7),	\
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_OPEN_FAULT_CHANNEL_, range), bit, bit),	\
> +	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_SHORT_FAULT_CHANNEL_, range), bit, bit), \
> +	}
> +struct mp3326_led {
> +	struct mp3326 *private_data;
> +	struct led_classdev cdev;
> +	struct mc_subled *subled_info;
> +	int num_colors;
> +};

...

> +
> +		for_each_available_child_of_node(np, child) {
> +			ret = of_property_read_u32(child, "reg", &reg);
> +			if (ret || reg > Max_Channel) {
> +				dev_err(&chip->client->dev,
> +				"reg must less or equal than %d\n", Max_Channel);
> +				return -EINVAL;
> +			}
> +
> +			ret = of_property_read_u32(child, "color", &color);
> +			if (ret) {
> +				dev_err(&chip->client->dev, "color must have value\n");
> +				return ret;
> +			}
> +
> +			if (color > 3 || !color) {
> +				dev_err(&chip->client->dev,
> +				"color must be Red, Green and Blue. The color is %d\n", color);

Broken indentation. Everywhere. Be sure that checkpatch --strict does
not print any (any!) warnings.

> +				return ret;
> +			}
> +			info[i].color_index = color;
> +			info[i].channel = reg - 1;
> +			info[i].brightness = 0;
> +			i++;
> +		}
> +
> +		led->subled_info = info;
> +		led->num_colors = 3;
> +		cdev = &led->cdev;
> +		cdev->max_brightness = MAX_BRIGHTNESS;
> +		cdev->brightness_set_blocking = led_brightness_set;
> +		cdev->groups = led_sysfs_groups;
> +		init_data.fwnode = &np->fwnode;
> +
> +		ret = devm_led_classdev_register_ext(&chip->client->dev, &led->cdev, &init_data);
> +
> +		if (ret) {
> +			dev_err(&chip->client->dev, "Unable register multicolor:%s\n", cdev->name);
> +			return ret;
> +		}
> +	} else {
> +		ret = of_property_read_u32(np, "reg", &reg);
> +		if (ret || reg > Max_Channel) {
> +			dev_err(&chip->client->dev,
> +			"reg must less or equal than %d\n", Max_Channel);
> +			return -EINVAL;
> +		}
> +		info = devm_kcalloc(&chip->client->dev, 1, sizeof(*info), GFP_KERNEL);
> +		led->num_colors = 1;
> +		info[i].color_index = LED_COLOR_ID_WHITE;
> +		info[i].channel = reg - 1;
> +		info[i].brightness = 0;
> +		led->subled_info = info;
> +		cdev = &led->cdev;
> +		cdev->max_brightness = MAX_BRIGHTNESS;
> +		cdev->brightness_set_blocking = led_brightness_set;
> +		cdev->groups = led_sysfs_groups;
> +		init_data.fwnode = &np->fwnode;
> +		ret = devm_led_classdev_register_ext(&chip->client->dev, &led->cdev, &init_data);
> +		if (ret) {
> +			dev_err(&chip->client->dev, "Unable register led:%s\n", cdev->name);
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int mp3326_parse_dt(struct mp3326 *chip)
> +{
> +	struct device_node *np = dev_of_node(&chip->client->dev);
> +	struct device_node *child;
> +	int ret;
> +	int index;

iteration variables have name 'i'. Not index.

> +	int val;
> +
> +	for_each_available_child_of_node(np, child) {
> +		ret = mp3326_add_led(chip, child, index);
> +		if (ret)
> +			return ret;
> +		index++;
> +	}
> +	ret = of_property_read_u32(np, "led-protect", &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(chip->regmap, 0x01, BIT(4) | BIT(5), val << 4);
> +
> +	ret = regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_9_16, 0);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_1_8, 0);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static int mp3326_leds_probe(struct i2c_client *client)
> +{
> +	struct mp3326 *chip;
> +	const struct reg_field *reg_fields;
> +	int count, i, j;
> +
> +	count = device_get_child_node_count(&client->dev);
> +	if (!count) {
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				"Incorrect number of leds (%d)", count);
> +	}
> +	chip = devm_kzalloc(&client->dev, struct_size(chip, leds, count), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	chip->num_of_leds = count;
> +	i2c_set_clientdata(client, chip);
> +	chip->regmap = devm_regmap_init_i2c(client, &MP3326_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
> +
> +	for (i = 0; i < Max_Channel; i++) {
> +		reg_fields = channels_reg_fields[i];
> +		for (j = 0; j < Max_CTRL; j++) {
> +			chip->regmap_fields[i][j] = devm_regmap_field_alloc(&client->dev,
> +			chip->regmap, reg_fields[j]);
> +			if (IS_ERR(chip->regmap_fields[i][j])) {
> +				dev_err(&client->dev,
> +				"regmap field alloc fail, channel:%d, item: %d\n", i, j);
> +				return PTR_ERR(chip->regmap_fields[i][j]);

Messed indentation. Anyway, memory allocation errors are not usually
printed. Why should they be printed here?


> +			}
> +		}
> +	}
> +	if (mp3326_parse_dt(chip))
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static const struct i2c_device_id mp3326_id[] = {
> +	{"mp3326", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mp3326_id);
> +
> +static const struct of_device_id mp3326_of_match[] = {
> +	{ .compatible = "mps,mp3326" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp3326_of_match);
> +
> +static struct i2c_driver mp3326_driver = {
> +	.probe_new = mp3326_leds_probe,
> +	.driver = {
> +			.owner = THIS_MODULE,

Drop. Kernel does not have it since few years.


> +			.name = "MP3326_led",

One less indent.

> +			.of_match_table = mp3326_of_match,
> +		   },
> +	.id_table = mp3326_id,
> +};
> +
> +module_i2c_driver(mp3326_driver);
> +MODULE_AUTHOR("Yuxi Wang <Yuxi.Wang@monolithicpower.com>");
> +MODULE_DESCRIPTION("MPS MP3326 LED driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

