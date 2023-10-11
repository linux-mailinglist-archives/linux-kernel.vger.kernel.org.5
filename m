Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C77C569F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjJKOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJKOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:20:14 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153494;
        Wed, 11 Oct 2023 07:20:09 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b5f7f4e733so894010241.3;
        Wed, 11 Oct 2023 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697034009; x=1697638809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEqT+8WbEBzcapEwgMqi0AdiU+0yNDpiLyRrMbsTcxo=;
        b=I1Hzd4U6blLnwt+StlOANy3gE7FU3tR7ZO19xzu6GeM5YqaPAtqtttZD47udiqZlrk
         AkILDj2OwRLkJ3vBeM0gEz63jQm8e8pfGD1kqbUmARsUZckW8akJwLPnzSAi74n8qPCU
         VqjBkOPqDIxDF7eQAKg7Z2Tocu63uO5TS8n2y+5V/Q2Akn2qJIitO2ZC6nudVPwCrDMs
         P+pR8dTvSn0u+6N1vSB6Zsk1zkIVekKyv2DMB+JKtclbE+UJgEBWGaB5r/vupt2nqHee
         b/6/gzrE6XEc3pvT2+d7pDiDMLXn+9+6exlokXMDFadAMW7MJZ1Ktqf8dgZvmztU9RKa
         OUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034009; x=1697638809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEqT+8WbEBzcapEwgMqi0AdiU+0yNDpiLyRrMbsTcxo=;
        b=uxv5cFGIRc9pla+t7N3j0qx8H4G/TReiB0MTVtVkiXsxaOLOI62C3n/K1J4HeIYLYZ
         QVQjiupdQYdV5vL/J1bJfAdhEIKdyQDrj4iW2TBgfHqJsv+Rn7bOMu6eW1HZvZOUjX0b
         7r9+adO0O1JzZ19wyKvOXZ/J8yOfpn1965jfnJjd46rwiuJjQk6G2/eBVdTkvSI0Coiq
         1aSZPsSwrnU64ZMtm9XSYZmr+BymVgEygjkjucxjoQJfUReomtC7aKyHxp5nRW5FL2RK
         YqGSiQV3qJzkjHnDlrMaYAvN6sjFNYl0MD6dgk3IxYQODgAzfW4FKBUj8XZKCd5iKcbB
         4K/g==
X-Gm-Message-State: AOJu0YyKlXhR/XYZWRWY4GCFHDM+XOXYl3VFTfX0MZHwJ2/Q5xfl6Vn4
        Qru62vAc9WFgUBRfZ6Y0XuE=
X-Google-Smtp-Source: AGHT+IHUUhpDB9OXraSU3wdynsnh3F5aH6AzgLuAN1Cglp4u8JoGbW5Q1EoPGMNvIajhFAOkS+NzbA==
X-Received: by 2002:a05:6102:3c7:b0:452:8422:1318 with SMTP id n7-20020a05610203c700b0045284221318mr19694515vsq.27.1697034008095;
        Wed, 11 Oct 2023 07:20:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16-20020a0561020dd000b0045779cfd2c9sm1280887vst.16.2023.10.11.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:20:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 07:20:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5] regulator (max5970): Add hwmon support
Message-ID: <a1bae0c4-0453-4f17-808f-859b684ae525@roeck-us.net>
References: <20231005075508.1656071-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005075508.1656071-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:55:07AM +0200, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V5:
> - Simplify memory allocation for rdevs
> Changes in V4:
> - Use IS_REACHABLE
> - Use rdevs array for hwmon ops.
> - Remove duplicate i2c_set_clientdata

I just noticed this one. Not my decision how to handle this,
but the change is really unrelated to this patch.

> Changes in V3:
> - Update signed-off
> - Add break
> - Update hwmon dev register name to max5970
> - Remove changes in Kconfig.
> Changes in V2:
> - default case added for switch statement
> - Add dependency on HWMON
> ---
>  drivers/regulator/max5970-regulator.c | 141 +++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> index b56a174cde3d..71b4a543339a 100644
> --- a/drivers/regulator/max5970-regulator.c
> +++ b/drivers/regulator/max5970-regulator.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/hwmon.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -32,6 +33,128 @@ enum max597x_regulator_id {
>  	MAX597X_SW1,
>  };
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
> +	struct regulator_dev **rdevs = dev_get_drvdata(dev);
> +	struct max5970_regulator *ddata = rdev_get_drvdata(rdevs[channel]);
> +	struct regmap *regmap = ddata->regmap;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			ret = max5970_read_adc(regmap, MAX5970_REG_CURRENT_H(channel), val);

			if (ret < 0)
				return ret;

> +			/*
> +			 * Calculate current from ADC value, IRNG range & shunt resistor value.
> +			 * ddata->irng holds the voltage corresponding to the maximum value the
> +			 * 10-bit ADC can measure.
> +			 * To obtain the output, multiply the ADC value by the IRNG range (in
> +			 * millivolts) and then divide it by the maximum value of the 10-bit ADC.
> +			 */
> +			*val = (*val * ddata->irng) >> 10;
> +			/* Convert the voltage meansurement across shunt resistor to current */
> +			*val = (*val * 1000) / ddata->shunt_micro_ohms;
> +			return ret;

			return 0;

> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
			if (ret < 0)
				return ret;

> +			/*
> +			 * Calculate voltage from ADC value and MON range.
> +			 * ddata->mon_rng holds the voltage corresponding to the maximum value the
> +			 * 10-bit ADC can measure.
> +			 * To obtain the output, multiply the ADC value by the MON range (in
> +			 * microvolts) and then divide it by the maximum value of the 10-bit ADC.
> +			 */
> +			*val = mul_u64_u32_shr(*val, ddata->mon_rng, 10);
> +			/* uV to mV */
> +			*val = *val / 1000;
> +			return ret;

			return 0;

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
> +	struct regulator_dev **rdevs = (struct regulator_dev **)data;
> +	struct max5970_regulator *ddata;
> +
> +	if (channel >= MAX5970_NUM_SWITCHES || !rdevs[channel])
> +		return 0;
> +
> +	ddata = rdev_get_drvdata(rdevs[channel]);
> +
> +	if (!ddata || channel >= ddata->num_switches)

How would ddata ever be NULL ? I don't see that check
elsewhere in the driver.

> +		return 0;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			/* Current measurement requires knowledge of the shunt resistor value. */
> +			if (ddata->shunt_micro_ohms)
> +				return 0444;

The common approach in hwmon drivers is to define a default
(typically 1 mOhm) if the value is not set, to let the user
configure it from userspace with the sensors configuration file.

Checking ... Never mind. I guess the problem here is that while the
shunt-resistor-micro-ohms property is mandatory, the dt author can
explicitly configure a shunt resistor value of 0 and that is accepted
by the rest of the code. I am not sure if that makes sense, but ...
With this in mind, keep as is, but please add a note explaining that
this can happen.

> +			break;
> +		default:
> +			break;
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
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info max5970_chip_info = {
> +	.ops = &max5970_hwmon_ops,
> +	.info = max5970_info,
> +};
> +
>  static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
>  {
>  	int ret, reg;
> @@ -431,7 +554,8 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>  	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
>  	struct regulator_config config = { };
>  	struct regulator_dev *rdev;
> -	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> +	struct regulator_dev **rdevs = NULL;
> +	struct device *hwmon_dev;
>  	int num_switches;
>  	int ret, i;
>  
> @@ -442,6 +566,11 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>  	if (!max597x)
>  		return -ENOMEM;
>  
> +	rdevs = devm_kcalloc(&i2c->dev, MAX5970_NUM_SWITCHES, sizeof(struct regulator_dev *),
> +			     GFP_KERNEL);
> +	if (!rdevs)
> +		return -ENOMEM;
> +
>  	i2c_set_clientdata(i2c, max597x);
>  
>  	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
> @@ -451,7 +580,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>  	else
>  		return -ENODEV;
>  
> -	i2c_set_clientdata(i2c, max597x);
>  	num_switches = max597x->num_switches;
>  
>  	for (i = 0; i < num_switches; i++) {
> @@ -485,6 +613,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>  		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
>  	}
>  
> +	if (IS_REACHABLE(CONFIG_HWMON)) {
> +		hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", rdevs,
> +								 &max5970_chip_info, NULL);
> +		if (IS_ERR(hwmon_dev)) {
> +			return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
> +					     "Unable to register hwmon device\n");
> +		}
> +	}
> +
>  	if (i2c->irq) {
>  		ret =
>  		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
> 
> base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
> -- 
> 2.41.0
> 
