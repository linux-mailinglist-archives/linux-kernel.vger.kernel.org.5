Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B202878DEED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjH3THf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbjH3P4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:56:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907C193;
        Wed, 30 Aug 2023 08:56:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34bbc5eb310so19208485ab.2;
        Wed, 30 Aug 2023 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693410994; x=1694015794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luyD1p5JmVUmw7nJjtInUcMJ1swr6a3B/SKZIUhECg4=;
        b=mKIbyqgtUCfFOAduJbz1ubsOujOH4FJcg6jY+W07gBkcm8r2w+OMFEa5qMuGpTniZl
         hEsOUfnDFdZ82YFa7CnP2HbkdzQHe9YadYcgwb4gOHgJTlZoNy57po2vRaSmkg9juV0P
         TBOV2aUAaSa/IfsF5nfmZBnKgguviObarwlX33x+UVBrR0cJ93A2twrOwywOBe+Dg5aZ
         mXcCM+msykM+isX1flG74KdmfNmRuQluVEVxElpBzO/M6Ut30vEGC46VZxislTupfKeZ
         hmANLVCns+iKIeVysV5Hussej6l04hq8Z1H/CHJczsJHZgGMZYy1OAYO/Nk2xgKZgGSp
         gmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693410994; x=1694015794;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luyD1p5JmVUmw7nJjtInUcMJ1swr6a3B/SKZIUhECg4=;
        b=aGJBYc5JQ/hPW4gkmDl+sI5cw42Lfp25kk4TW7gor5tOtyMnTP/1sK2AAhjBFb+kVx
         J/PijdOjv61YqOw+9ARVioFxyWtM37C0hZ7GWIsEhIwI+M7V8jkzXfoLfI0t8kzJ5dZu
         sjPyiJS+xhA4lJ3nEk1EdIcSDy6f/lF0x6a/pBIQYMd8/u7W+umn7GI468tDFbrutC75
         dRFv4faTGO2BdvEIXFRSlHhx2ELWY7sespv8bH3uVlwP8jFL/qxwQenDIyIeP0sk60hb
         nLRkyO/GBwVYiWTIWhDKFGM3mfX1uocku8oVtjXf8aXGfbJ0ODPjZrY91CDGm1nJqtcl
         jFSg==
X-Gm-Message-State: AOJu0YxPvRS3BAu+Pb8v17TPxmSP/VPVPTs3BvH/xXXYb7rKVv7I9hJS
        y7MxAdTJjzOaJyXVwhUrvK4=
X-Google-Smtp-Source: AGHT+IFQXeYZ34vQa1o1bGHTu3FNDHxfdJgx9pyisFUG2ONSxwcvGKBQzV/KQ9kbcgpFLjjUbpPJJA==
X-Received: by 2002:a92:d991:0:b0:34c:cc37:3064 with SMTP id r17-20020a92d991000000b0034ccc373064mr2856366iln.15.1693410994138;
        Wed, 30 Aug 2023 08:56:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25-20020a02c619000000b0042b068d921esm3961475jan.16.2023.08.30.08.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:56:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0bfbbbb3-6144-fc9a-c8ab-423a8865591b@roeck-us.net>
Date:   Wed, 30 Aug 2023 08:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     zev@bewilderbeest.net, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230830111319.3882281-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] regulator (max5970): Add hwmon support
In-Reply-To: <20230830111319.3882281-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 04:13, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/regulator/max5970-regulator.c | 119 ++++++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> index b56a174cde3d..3a6f7c293526 100644
> --- a/drivers/regulator/max5970-regulator.c
> +++ b/drivers/regulator/max5970-regulator.c
> @@ -10,6 +10,7 @@
>   #include <linux/bitops.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/hwmon.h>
>   #include <linux/module.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
> @@ -32,6 +33,116 @@ enum max597x_regulator_id {
>   	MAX597X_SW1,
>   };
>   
> +static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
> +{
> +	u8 reg_data[2];
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, reg, &reg_data[0], 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (reg_data[0] << 2) | (reg_data[1] & 3);
> +
> +	return 0;
> +}
> +
> +static int max5970_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct max5970_data *ddata = dev_get_drvdata(dev);
> +	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			ret = max5970_read_adc(regmap, MAX5970_REG_CURRENT_H(channel), val);
> +			/*
> +			 * Calculate current from ADC value, IRNG range & shunt resistor value.
> +			 * ddata->irng holds the voltage corresponding to the maximum value the
> +			 * 10-bit ADC can measure.
> +			 * To obtain the output, multiply the ADC value by the IRNG range (in
> +			 * millivolts) and then divide it by the maximum value of the 10-bit ADC.
> +			 */
> +			*val = (*val * ddata->irng[channel]) >> 10;
> +			/* Convert the voltage meansurement across shunt resistor to current */
> +			*val = (*val * 1000) / ddata->shunt_micro_ohms[channel];
> +			return ret;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
> +			/*
> +			 * Calculate voltage from ADC value and MON range.
> +			 * ddata->mon_rng holds the voltage corresponding to the maximum value the
> +			 * 10-bit ADC can measure.
> +			 * To obtain the output, multiply the ADC value by the MON range (in
> +			 * microvolts) and then divide it by the maximum value of the 10-bit ADC.
> +			 */
> +			*val = mul_u64_u32_shr(*val, ddata->mon_rng[channel], 10);

Why do you use mul_u64_u32_shr() here but a direct shift above ?

> +			/* uV to mV */
> +			*val = *val / 1000;
> +			return ret;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t max5970_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	struct max5970_data *ddata = (struct max5970_data *)data;
> +
> +	if (channel >= ddata->num_switches)
> +		return 0;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;

		default:
			break;

> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			/* Current measurement requires knowledge of the shunt resistor value. */
> +			if (ddata->shunt_micro_ohms[channel])
> +				return 0444;
		default:
			break;

> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops max5970_hwmon_ops = {
> +	.is_visible = max5970_is_visible,
> +	.read = max5970_read,
> +};
> +
> +static const struct hwmon_channel_info *max5970_info[] = {
> +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT, HWMON_I_INPUT),
> +	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT, HWMON_C_INPUT),

Your call, but the chip does support limit and status registers, so you
could add reporting those as well since you are at it, possibly even including
notifications.

> +	NULL
> +};
> +
> +static const struct hwmon_chip_info max5970_chip_info = {
> +	.ops = &max5970_hwmon_ops,
> +	.info = max5970_info,
> +};
> +
>   static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
>   {
>   	int ret, reg;
> @@ -432,6 +543,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   	struct regulator_config config = { };
>   	struct regulator_dev *rdev;
>   	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> +	struct device *hwmon_dev;
>   	int num_switches;
>   	int ret, i;
>   
> @@ -485,6 +597,13 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
>   	}
>   
> +	hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970_hwmon", max597x,
> +							 &max5970_chip_info, NULL);

This makes the driver dependent on hwmon, so you either need a strict
	depends on HWMON
in Kconfig, or
	depends on HWMON || HWMON=n
and add #if IS_ENABLED(CONFIG_HWMON) as appropriate into the code.


> +	if (IS_ERR(hwmon_dev)) {
> +		return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev), \
> +				     "Unable to register hwmon device\n");
> +	}
> +
>   	if (i2c->irq) {
>   		ret =
>   		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
> 
> base-commit: 35d0d2350d774fecf596cfb2fb050559fe5e1850

