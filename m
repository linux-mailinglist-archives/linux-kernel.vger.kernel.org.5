Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D978C2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjH2Kye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjH2KyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:54:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EAE5A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so548634166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693306421; x=1693911221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScYLHmfpyeacZnUk3RAsTGCOdLcciysG/Eo/y0cpOvw=;
        b=Z38RDbTCVeGtAWGwNP/kSpyGlANDzT0RUhcyIWbDR6aJ9NfhercehioT/dxYT80CFd
         Zv3GhMrdY9zty56+9QAFHnfKJoAr9eIhUmfUgzbdsCuu5gGYk+J8SBM4CU1Xh7KlbTpZ
         buFE30gGVt0sFP8W0W7Va1y0lF/hJjEPf6aE1FrkDBIfrjbyD80hSVGfOEeASQvNqUXT
         gUPWAqCa6ZYUPTMiK96Qo6ahZ8PEjIYJQf07douid0JRSmwjBfRqw2HMbOfWFJtyRB/B
         d/ghDuvqThvNAXuTcoWHTyjWU6J8x1Im1JAfS6tdLLcbEU5HmXem/UVzEqtWm3SVWGaT
         BgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693306421; x=1693911221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScYLHmfpyeacZnUk3RAsTGCOdLcciysG/Eo/y0cpOvw=;
        b=DH1R4k66K/JDQLlDHg+NFEGkM+hFBLXmqCC+hJdyy7m9qrUcT1ce6j7Dk+Ux8snkPc
         kt1SKofEFRKvGpAjvWuWebzxF8ZZcg8CG43z5lJ2aNexN6uSJ1VoIhbEldGjbfBAuaEG
         1ZiLEd1bpkFL+va9mHi5guPkoZifhynvcGsXPrGvoHp9oF7ND9LcV/5avhnGP6eJINfd
         tLPdKAnmMW4HctoR4sXHm4xXX9CWyVbticR+fZbtBq+j7DXBF5wKnCHS+e+1ZJFzpTVJ
         oollKsNl87pBR4TifR836ha2J3/iszYevSS0KJC0OLeFEALtw7HYYqjq9vyG2nLncdzn
         0MyA==
X-Gm-Message-State: AOJu0YwCBvLFi/acuiFrdYzCP7a74xVxH9UV8FGHwri/GIxPwsgYMm8/
        cQ5/QODNImmDqbUdK3neI8Gi8g==
X-Google-Smtp-Source: AGHT+IGCqK5Wx4jpyAbSwSpv6d2WKd80TDtZhvdTujd1k9XqZ/jSAgncpdCEQb3nkbimc7eJq1YDzw==
X-Received: by 2002:a17:907:a0c6:b0:9a5:ca17:b58c with SMTP id hw6-20020a170907a0c600b009a5ca17b58cmr1129568ejc.60.1693306421404;
        Tue, 29 Aug 2023 03:53:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id v15-20020a1709064e8f00b00991e2b5a27dsm5803023eju.37.2023.08.29.03.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:53:40 -0700 (PDT)
Message-ID: <ac4dcf4a-af8d-61fd-92c5-f90f62aa643b@linaro.org>
Date:   Tue, 29 Aug 2023 12:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/2] backlight: mp3309c: Add support for MPS MP3309C
Content-Language: en-US
To:     Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230829101546.483189-1-f.suligoi@asem.it>
 <20230829101546.483189-2-f.suligoi@asem.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829101546.483189-2-f.suligoi@asem.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 12:15, Flavio Suligoi wrote:
> The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
> programmable switching frequency to optimize efficiency.
> The brightness can be controlled either by I2C commands (called "analog"
> mode) or by a PWM input signal (PWM mode).
> This driver supports both modes.
> 
> For DT configuration details, please refer to:
> - Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> 
> The datasheet is available at:
> - https://www.monolithicpower.com/en/mp3309c.html
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  MAINTAINERS                          |   6 +
>  drivers/video/backlight/Kconfig      |  13 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/mp3309c_bl.c | 491 +++++++++++++++++++++++++++
>  4 files changed, 511 insertions(+)
>  create mode 100644 drivers/video/backlight/mp3309c_bl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..895c56ff4f1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14333,6 +14333,12 @@ S:	Maintained
>  F:	Documentation/driver-api/tty/moxa-smartio.rst
>  F:	drivers/tty/mxser.*
>  
> +MP3309C BACKLIGHT DRIVER
> +M:	Flavio Suligoi <f.suligoi@asem.it>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> +F:	drivers/video/backlight/mp3309c_bl.c
> +
>  MR800 AVERMEDIA USB FM RADIO DRIVER
>  M:	Alexey Klimov <klimov.linux@gmail.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 51387b1ef012..65d0ac9f611d 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -389,6 +389,19 @@ config BACKLIGHT_LM3639
>  	help
>  	  This supports TI LM3639 Backlight + 1.5A Flash LED Driver
>  
> +config BACKLIGHT_MP3309C

Why is this placed between LM and LP entries? Keep things ordered.

> +	tristate "Backlight Driver for MPS MP3309C"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  This supports MPS MP3309C backlight WLED Driver in both PWM and
> +	  analog/I2C dimming modes.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called mp3309c_bl.
> +
>  config BACKLIGHT_LP855X


>  	tristate "Backlight driver for TI LP855X"
>  	depends on I2C && PWM
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index f72e1c3c59e9..c42c5bccc5ac 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
>  obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
>  obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
>  obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
> +obj-$(CONFIG_BACKLIGHT_MP3309C)		+= mp3309c_bl.o
>  obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
>  obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
> diff --git a/drivers/video/backlight/mp3309c_bl.c b/drivers/video/backlight/mp3309c_bl.c
> new file mode 100644
> index 000000000000..7cb7a542ceca
> --- /dev/null
> +++ b/drivers/video/backlight/mp3309c_bl.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for MPS MP3309C White LED driver with I2C interface
> + *
> + * Copyright (C) 2023 ASEM Srl
> + * Author: Flavio Suligoi <f.suligoi@asem.it>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/workqueue.h>
> +
> +#define REG_I2C_0	0x00
> +#define REG_I2C_1	0x01
> +
> +#define REG_I2C_0_EN	0x80
> +#define REG_I2C_0_D0	0x40
> +#define REG_I2C_0_D1	0x20
> +#define REG_I2C_0_D2	0x10
> +#define REG_I2C_0_D3	0x08
> +#define REG_I2C_0_D4	0x04
> +#define REG_I2C_0_RSRV1	0x02
> +#define REG_I2C_0_RSRV2	0x01
> +
> +#define REG_I2C_1_RSRV1	0x80
> +#define REG_I2C_1_DIMS	0x40
> +#define REG_I2C_1_SYNC	0x20
> +#define REG_I2C_1_OVP0	0x10
> +#define REG_I2C_1_OVP1	0x08
> +#define REG_I2C_1_VOS	0x04
> +#define REG_I2C_1_LEDO	0x02
> +#define REG_I2C_1_OTP	0x01
> +
> +#define ANALOG_MAX_VAL	31
> +#define ANALOG_REG_MASK 0x7c
> +
> +enum backlight_status {
> +	FIRST_POWER_ON,
> +	BACKLIGHT_OFF,
> +	BACKLIGHT_ON,
> +};
> +
> +enum dimming_mode_value {
> +	DIMMING_PWM,
> +	DIMMING_ANALOG_I2C,
> +};
> +
> +struct mp3309c_platform_data {
> +	u32 max_brightness;
> +	u32 brightness;
> +	u32 switch_on_delay_ms;
> +	u32 switch_off_delay_ms;
> +	u32 reset_on_delay_ms;
> +	u32 reset_on_length_ms;
> +	u8  dimming_mode;
> +	u8  reset_pulse_enable;
> +	u8  over_voltage_protection;
> +
> +	unsigned int status;
> +};
> +
> +struct mp3309c_chip {
> +	struct device *dev;
> +	struct mp3309c_platform_data *pdata;
> +	struct backlight_device *bl;
> +	struct gpio_desc *enable_gpio;
> +	struct regmap *regmap;
> +	struct pwm_device *pwmd;
> +
> +	struct delayed_work enable_work;
> +	struct delayed_work reset_gpio_work;
> +	int irq;
> +
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static const struct regmap_config mp3309c_regmap = {
> +	.name = "mp3309c_regmap",
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.max_register = REG_I2C_1,
> +};
> +
> +static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
> +				 struct mp3309c_platform_data *pdata)

This should be just before probe function. It is part of probe path.

> +{
> +	struct device_node *node = chip->dev->of_node;
> +	const char *tmp_string;
> +	int ret;
> +
> +	if (!node) {
> +		dev_err(chip->dev, "failed to get DT node\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Dimming mode: the MP3309C provides two dimming methods:
> +	 *
> +	 * - PWM mode
> +	 * - Analog by I2C control mode
> +	 */
> +	ret = of_property_read_string(node, "mps,dimming-mode", &tmp_string);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "missed dimming-mode in DT\n");
> +		return ret;
> +	}
> +	if (!strcmp(tmp_string, "pwm")) {
> +		dev_info(chip->dev, "dimming method: PWM\n");

Drop

> +		pdata->dimming_mode = DIMMING_PWM;
> +	}
> +	if (!strcmp(tmp_string, "analog-i2c")) {
> +		dev_info(chip->dev, "dimming method: analog by I2C commands\n");

Drop


> +		pdata->dimming_mode = DIMMING_ANALOG_I2C;
> +	}
> +
> +	/* PWM steps (levels): 0 .. max_brightness */
> +	ret = of_property_read_u32(node, "max-brightness",
> +				   &pdata->max_brightness);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to get max-brightness from DT\n");
> +		return ret;
> +	}
> +
> +	/* Default brightness at startup */
> +	ret = of_property_read_u32(node, "default-brightness",
> +				   &pdata->brightness);
> +	if (ret < 0) {
> +		dev_err(chip->dev,
> +			"failed to get default-brightness from DT\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Optional backlight switch-on/off delay
> +	 *
> +	 * Note: set 10ms as minimal value for switch-on delay, to stabilize
> +	 *       video data
> +	 */
> +	pdata->switch_on_delay_ms = 50;
> +	of_property_read_u32(node, "mps,switch-on-delay-ms",
> +			     &pdata->switch_on_delay_ms);
> +	if (pdata->switch_on_delay_ms < 10) {
> +		pdata->switch_on_delay_ms = 10;

You miss constraints in the bindings.

> +		dev_warn(chip->dev,
> +			 "switch-on-delay-ms set to 10ms as minimal value\n");
> +	}
> +	pdata->switch_off_delay_ms = 0;
> +	of_property_read_u32(node, "mps,switch-off-delay-ms",
> +			     &pdata->switch_off_delay_ms);
> +
> +	/*
> +	 * Reset: GPIO, initial delay and pulse length
> +	 *
> +	 * Use this optional GPIO to reset an external device (LCD panel, video
> +	 * FPGA, etc) when the backlight is switched on
> +	 */
> +	pdata->reset_pulse_enable = 0;
> +	chip->reset_gpio = devm_gpiod_get_optional(chip->dev, "mps,reset",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(chip->reset_gpio)) {
> +		ret = PTR_ERR(chip->reset_gpio);
> +		dev_err(chip->dev, "error acquiring reset gpio: %d\n", ret);
> +		return ret;

return dev_err_probe()

> +	}
> +	if (chip->reset_gpio) {
> +		pdata->reset_pulse_enable = 1;
> +
> +		pdata->reset_on_delay_ms = 10;
> +		of_property_read_u32(node, "mps,reset-on-delay-ms",
> +				     &pdata->reset_on_delay_ms);
> +		pdata->reset_on_length_ms = 10;
> +		of_property_read_u32(node, "mps,reset-on-length-ms",
> +				     &pdata->reset_on_length_ms);
> +	}
> +
> +	/*
> +	 * Over-voltage protection (OVP)
> +	 *
> +	 * These (optional) properties are:
> +	 *
> +	 *  - overvoltage-protection-13v --> OVP point set to 13.5V
> +	 *  - overvoltage-protection-24v --> OVP point set to 24V
> +	 *  - overvoltage-protection-35v --> OVP point set to 35.5V
> +	 *
> +	 * If not chosen, the hw default value for OVP is 35.5V
> +	 */
> +	pdata->over_voltage_protection = REG_I2C_1_OVP1;
> +	if (of_property_read_bool(node, "mps,overvoltage-protection-13v"))
> +		pdata->over_voltage_protection = 0x00;
> +	if (of_property_read_bool(node, "mps,overvoltage-protection-24v"))
> +		pdata->over_voltage_protection = REG_I2C_1_OVP0;
> +	if (of_property_read_bool(node, "mps,overvoltage-protection-35v"))
> +		pdata->over_voltage_protection = REG_I2C_1_OVP1;
> +
> +	return 0;
> +}
> +

...

> +
> +static const struct backlight_ops mp3309c_bl_ops = {
> +	.update_status = mp3309c_bl_update_status,
> +};
> +
> +static int mp3309c_probe(struct i2c_client *client)
> +{
> +	struct mp3309c_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct mp3309c_chip *chip;
> +	struct backlight_properties props;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "failed to check i2c functionality\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(struct mp3309c_chip),

sizeof(*)

> +			    GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +	chip->dev = &client->dev;
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &mp3309c_regmap);
> +	if (IS_ERR(chip->regmap)) {
> +		ret = PTR_ERR(chip->regmap);
> +		dev_err(&client->dev, "failed to allocate register map\n");

Are you sure regmap allocation should be followed by error message?
Allocations must not... so if this is not allocation, then syntax is:

return dev_err_probe()

> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, chip);
> +
> +	if (!pdata) {
> +		pdata = devm_kzalloc(chip->dev,
> +				     sizeof(struct mp3309c_platform_data),

sizeof(*)

> +				     GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = pm3309c_parse_dt_node(chip, pdata);
> +		if (ret) {
> +			dev_err(&client->dev, "failed parsing DT node\n");

Why do you print errors multiple times? parse_dt_node already does it.

> +			return ret;
> +		}
> +	}
> +	chip->pdata = pdata;
> +
> +	chip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->enable_gpio)) {
> +		ret = PTR_ERR(chip->enable_gpio);
> +		return ret;

return dev_err_probe()

> +	}
> +
> +	/* Backlight */
> +	props.type = BACKLIGHT_RAW;
> +	props.brightness = pdata->brightness;
> +	props.max_brightness = pdata->max_brightness;
> +	props.scale = BACKLIGHT_SCALE_LINEAR;
> +	chip->bl =
> +	    devm_backlight_device_register(chip->dev, "mp3309c_bl",
> +					   chip->dev, chip, &mp3309c_bl_ops,
> +					   &props);
> +	if (IS_ERR(chip->bl)) {
> +		dev_err(&client->dev, "failed registering backlight\n");
> +		return PTR_ERR(chip->bl);

return dev_err_probe()

> +	}
> +	pdata->status = FIRST_POWER_ON;
> +
> +	/* Enable PWM, if required */
> +	if (pdata->dimming_mode == DIMMING_PWM) {
> +		chip->pwmd = devm_pwm_get(chip->dev, NULL);
> +		if (IS_ERR(chip->pwmd)) {
> +			dev_err(&client->dev, "failed getting pwm device\n");
> +			return PTR_ERR(chip->pwmd);

return dev_err_probe()

> +		}
> +		pwm_apply_args(chip->pwmd);
> +	}
> +
> +	/*
> +	 * Workqueue for delayed backlight enabling
> +	 */
> +	INIT_DELAYED_WORK(&chip->enable_work, mp3309c_enable);
> +
> +	/*
> +	 * Workqueue for (optional) external device GPIO reset
> +	 */
> +	if (pdata->reset_pulse_enable) {
> +		dev_info(&client->dev, "reset pulse enabled\n");

Drop, not really helpful.

> +		INIT_DELAYED_WORK(&chip->reset_gpio_work, mp3309c_reset_gpio);
> +	}
> +
> +	dev_info(&client->dev, "MP3309C backlight initialized");

Drop simple tracing messages.

> +	return 0;
> +}
> +
> +static int mp3309c_backlight_switch_off(struct pwm_device *pwmd)
> +{
> +	struct pwm_state pwmstate;
> +
> +	/* Switch-off the backlight */
> +	pwm_get_state(pwmd, &pwmstate);
> +	pwmstate.duty_cycle = 0;
> +	pwmstate.enabled = false;
> +	pwm_apply_state(pwmd, &pwmstate);
> +
> +	return 0;
> +}
> +
> +static void mp3309c_remove(struct i2c_client *client)
> +{
> +	struct mp3309c_chip *chip = i2c_get_clientdata(client);
> +
> +	if (chip->pdata->dimming_mode == DIMMING_PWM)
> +		mp3309c_backlight_switch_off(chip->pwmd);
> +	if (chip->pdata->reset_pulse_enable)
> +		cancel_delayed_work(&chip->reset_gpio_work);
> +}
> +
> +static void mp3309c_shutdown(struct i2c_client *client)
> +{
> +	struct mp3309c_chip *chip = i2c_get_clientdata(client);
> +
> +	if (chip->pdata->dimming_mode == DIMMING_PWM)
> +		mp3309c_backlight_switch_off(chip->pwmd);

Why do you need shutdown function?

> +}
> +
> +static const struct of_device_id mp3309c_match_table[] = {
> +	{ .compatible = "mps,mp3309c-backlight", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mp3309c_match_table);
> +


Best regards,
Krzysztof

