Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A779B76D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbjIKVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbjIKMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:43:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD64CEB;
        Mon, 11 Sep 2023 05:43:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34e202a9cc9so14180055ab.2;
        Mon, 11 Sep 2023 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694436207; x=1695041007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zm43wCuo+RFtKsT+lmSugiZ0vyZ8wM+jKL/z+ZJJj4=;
        b=refEIejvVY7aa6Mqb4yHhx9WpZXkY7AIJf+Op+ivzTcuppWvz+zdSEH5BkAdDaoEJY
         mCX+lpPhuId997leem46z6PtGh5O614qE2gU5K21iWCQwmtHe12GuYC6dy/J4Nj2EhJZ
         ezzpAHsa2Xj8x6ljt2F856TKzU5Cq9EFkLydNi82KsEwipo6j6kDO/W+oiItWFx6RVCc
         and4hiMCFj5qBEOwKr5oQsskpMYvEifsZbi4F7V1/+6lPL10KwEZswy4rpRW9TwnaoUr
         Ft6t4VTzgQyEMzAfobIiKIlw1+tN976HlPnTkWHkfedKq3J2bPM+cSByeGT9PWPq/FSp
         1aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436207; x=1695041007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zm43wCuo+RFtKsT+lmSugiZ0vyZ8wM+jKL/z+ZJJj4=;
        b=tuTQsU1mh7tizIJH4l4KFDfJWXM9kBlppkTRKnRw0nn6C68c99kMD+6EddDtDM0KvJ
         oOVdWraWA6umhF7hUaUJ3HcLT16qVtkExIXNGn4YSceYDy95X2/1BLbSZT0XnyDjR/KW
         hZA38MUQX0MAgAhFw5fZlqHIWRtQNHIOwZsSlOpftbeeBgptUYDV4Jqc+d+C/6OLPOVu
         b2EI6X9xZ9/TawFVrJz4w4ziAbeRSbGiFsoiapph/63v3ZfTiu1nxeIqlkRON0JtgUe1
         v9AdIdmvxUx9Jr2iocomNfNDuzwO/aK2YuQbDLXxp5+gJlBs4HHI3qz+fQgaP3BxtU3t
         pK0A==
X-Gm-Message-State: AOJu0Yy/Zw3NXG7eyGD01xEh3dFzzrJSZETKekjLAdx3BjKTOWgImw/Y
        Pc2x5bNH2owh3U7c4xVKl/0=
X-Google-Smtp-Source: AGHT+IGGiXR/R5Gx5xuyQHW47RZqNCQ7YKCZillVNtTmqOTuOGstwZT6wgqj4Gz67ukJ2KGC0U1NjQ==
X-Received: by 2002:a92:c56b:0:b0:34f:7779:df7f with SMTP id b11-20020a92c56b000000b0034f7779df7fmr3849534ilj.0.1694436207164;
        Mon, 11 Sep 2023 05:43:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e0205c300b003459023deaasm2373384ils.30.2023.09.11.05.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 05:43:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2bc45165-2a2a-77b7-00bb-3fce567d8468@roeck-us.net>
Date:   Mon, 11 Sep 2023 05:43:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] regulator (max5970): Add hwmon support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230911113647.1259204-1-naresh.solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230911113647.1259204-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 04:36, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V3:
> - Update signed-off
> - Add break
> - Update hwmon dev register name to max5970
> - Remove changes in Kconfig.
> Changes in V2:
> - default case added for switch statement
> - Add dependency on HWMON
> ---
>   drivers/regulator/max5970-regulator.c | 126 ++++++++++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> index b56a174cde3d..208de66c0928 100644
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
> @@ -32,6 +33,121 @@ enum max597x_regulator_id {
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
>   static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
>   {
>   	int ret, reg;
> @@ -432,6 +548,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   	struct regulator_config config = { };
>   	struct regulator_dev *rdev;
>   	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> +	struct device *hwmon_dev;
>   	int num_switches;
>   	int ret, i;
>   
> @@ -485,6 +602,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
>   		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_HWMON)) {

This either needs to be IS_REACHABLE, or you need to add "depends on HWMON || HWMON=n"
to Kconfig. Otherwise there will be a build failure if CONFIG_HWMON=m and
CONFIG_REGULATOR_MAX5970=y.

Sorry, I thought I mentioned that before.

Guenter

> +		hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", max597x,
> +								 &max5970_chip_info, NULL);
> +		if (IS_ERR(hwmon_dev)) {
> +			return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
> +					     "Unable to register hwmon device\n");
> +		}
> +	}
> +
>   	if (i2c->irq) {
>   		ret =
>   		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
> 
> base-commit: 41f02a383ac652f1a0b5538c5901b7ec93e37290

