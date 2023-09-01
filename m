Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B578FFE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbjIAPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjIAPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:23:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECA10FA;
        Fri,  1 Sep 2023 08:22:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79289fefdbeso75177139f.3;
        Fri, 01 Sep 2023 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693581762; x=1694186562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNII0s1sofIWcbvHAAzUd17gnj57olBPO0rA54JWsCA=;
        b=PIILvaRG0ANflRgJQyaSR9pY9lEp212FIVmOPsZi10421gGWVfUrKsfDplwws1hq+C
         dKsF5FMpwoALbt3rzBNLTDFjrhAn6PttPhbt0dnkPenlh8uMD1hwWOeRxzS+p4EvM6Y/
         KJhIx4vuQI16936T5jzaQMk+5+/8+BDAu1IdKRt0X0tFgq82iUrIYtOP045rqEFIubm2
         4xv6mQd8vb2ugO2VwxNWcKAdMgNFlkClwihBoJJLek4qYsJsBgEzJxuwS45Vb6CxmTlK
         bXJv2yURZO9vwV7USRz0ncIFuyBiC89twy9mKBzLBhM99oNkEEN5ru4qj4HSvJnI7Ea0
         lFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581762; x=1694186562;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNII0s1sofIWcbvHAAzUd17gnj57olBPO0rA54JWsCA=;
        b=Sfpo+i/bLDa37c7/S2QvYj84AV5tVWEiAV6oTa2NllBE7Adx0aUeFi1is4iHiKo201
         ksjeisVtdcRvSKVy6FMRn39EtrDPMhKS1KZ/hwAWAERkO0bu7e2T9mEo0X/77mWEQWv9
         KgAnFMPYqIfRelHKTYukI/B/Va6G9K9S9LyWARi+9VFNBDoG5p6F11uYqof2w/A8IJbS
         G9rV1p+RaABKRlOErJFsw/ekLDCWhnshCL4uco5Up8aQrREjva9q0O4zqSdi1tYPM63I
         160zhYpbgAc7y4A1aryUndx5oa6BG0VgGVAGykjZKMbh7vHkfl7Ywx6SX9xJn/vjf3MO
         WnLg==
X-Gm-Message-State: AOJu0YxXD5vxJAK4YzHJPtFZ5J5Dx9WLtvwcLAOzuRwMcPPtgR3XF3wQ
        jERrdFACPtc2ulkp3tgifPE=
X-Google-Smtp-Source: AGHT+IFahJpWa11g4EvgBD1fWsDRiald08+fWgKR+a2RUrhBaMjRdOASfGwhlr3/aEONOJSGY9Ilzw==
X-Received: by 2002:a6b:d607:0:b0:794:d833:4a8a with SMTP id w7-20020a6bd607000000b00794d8334a8amr2673934ioa.0.1693581760093;
        Fri, 01 Sep 2023 08:22:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g20-20020a05663811d400b0042b3ad1656bsm1152921jas.45.2023.09.01.08.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:22:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83f2afcc-aa9a-2d60-f5e2-971f7d669e00@roeck-us.net>
Date:   Fri, 1 Sep 2023 08:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230901093449.838414-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] regulator (max5970): Add hwmon support
In-Reply-To: <20230901093449.838414-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 02:34, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Nit, but you still have this:

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Naresh Solanki <naresh.solanki@9elements.com>' != 'Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>'

> ---
> Changes in V2:
> - default case added for switch statement
> - Add dependency on HWMON
> ---
>   drivers/regulator/Kconfig             |   1 +
>   drivers/regulator/max5970-regulator.c | 123 ++++++++++++++++++++++++++
>   2 files changed, 124 insertions(+)
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 965d4f0c18a6..ab245893033d 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -559,6 +559,7 @@ config REGULATOR_MAX5970
>   	depends on I2C
>   	depends on OF
>   	depends on MFD_MAX5970
> +	depends on HWMON

Not sure if that is acceptable. The maintainer will have to decide.

>   	help
>   	  This driver controls a Maxim 5970/5978 switch via I2C bus.
>   	  The MAX5970/5978 is a smart switch with no output regulation, but
> diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> index b56a174cde3d..c337044e1523 100644
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
> @@ -32,6 +33,120 @@ enum max597x_regulator_id {
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
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			/* Current measurement requires knowledge of the shunt resistor value. */
> +			if (ddata->shunt_micro_ohms[channel])
> +				return 0444;

missing break;

Interesting, I thought the compiler would complain about that nowadays,
but apparently it doesn't.

Guenter

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
>   static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
>   {
>   	int ret, reg;
> @@ -432,6 +547,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   	struct regulator_config config = { };
>   	struct regulator_dev *rdev;
>   	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> +	struct device *hwmon_dev;
>   	int num_switches;
>   	int ret, i;
>   
> @@ -485,6 +601,13 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
>   	}
>   
> +	hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970_hwmon", max597x,
> +							 &max5970_chip_info, NULL);
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

