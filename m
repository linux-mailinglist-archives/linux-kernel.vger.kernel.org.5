Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4620E7D8DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJ0FKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0FKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:10:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B41A5;
        Thu, 26 Oct 2023 22:10:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9c687f83a2so1196422276.3;
        Thu, 26 Oct 2023 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698383432; x=1698988232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bFKgHNz6FE2kpechnoomAD9Qkm+ROmrq2aPVbLIIaE=;
        b=JMDLrGugAjNyEBSNxzHeBZN339coGij7fmIElUM7vv0kGxzWBrQ6xzLaOfRU0cZANy
         sN8KW9vVzUZ63OTeIOoKEXNOlHjrFBPzeMeJE+fLhm3Ubxm//btZoH92vAvlP0TBUZN0
         Y/k6V/T56bZh+i91qfHji8+nWBzBLk2p0xRThyr7h4yXEhJwII22aM7FdwJoIq7Q7Lqp
         g73d9Jci7pIoyEe1yzOzMpiqkoCyXqv3cMBPMSIF4cknLFAQQHA+uPxqJwQrfnnBJdWT
         uk13b+IiioL8txhTiQbXF3pK7musfATKWzDrHw+cTGWwiyptxVO6TPO83yHB2yxh9pBp
         X2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383432; x=1698988232;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bFKgHNz6FE2kpechnoomAD9Qkm+ROmrq2aPVbLIIaE=;
        b=DHHluuoXW1gt1Bo43gBalHgVhr3eoVpBmtUKrnpc7wHOEFhWX/Jbshq0lSLMnsB2zb
         i1pYhpwzL/j0vXwSTOHUrB0gldhsjTQAeT3KJcFGRiFaFVJQJJ0fef3fVK/tO7ebgESK
         im7qz7lNQjkmjDCE3p8JpCQcngz6w8CNVRIL4QaM191EVbQQ3BWVMwQAAlLFBVqXaQqP
         IC8mh1yMqqHwyqaQqCO+TpMS2uOeQFvyOymxHf8fmExQyf2JXbfGJ5zkC7ikXLjxJI3f
         PDDoGMHC3ystkoAc/j3EIHjRc4MUyG5qXeUKeDHxbL09mmkw2ysxifMxW5Vi1i93K4Vz
         T1BQ==
X-Gm-Message-State: AOJu0Yx0jZ92s1rlf7eAeZSh0BMVqbmuKiSlkS/oPAoRyD+yk1qHD36X
        VOM8DQqgmhIOTLW50uRmLr/7FPB2dPM=
X-Google-Smtp-Source: AGHT+IHhIDphEAMsBoxJEU0uXMKTZjmTh9RS1isCZQfaC/umqQQf7eYQYWfwzCDlJe9SFT4myLU+uA==
X-Received: by 2002:a25:2684:0:b0:da0:3924:3c9b with SMTP id m126-20020a252684000000b00da039243c9bmr1694665ybm.23.1698383431626;
        Thu, 26 Oct 2023 22:10:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a259744000000b00da041da21e7sm367443ybo.65.2023.10.26.22.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 22:10:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bb467d2d-0557-0239-03e0-e5ac910db7e0@roeck-us.net>
Date:   Thu, 26 Oct 2023 22:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026144405.546822-1-daniel.matyas@analog.com>
 <20231026144405.546822-4-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 4/4] hwmon: max31827: Add custom attribute for
 resolution
In-Reply-To: <20231026144405.546822-4-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 07:44, Daniel Matyas wrote:
> Added custom channel-specific (temp1) attribute for resolution. The wait
> time for a conversion in one-shot mode (enable = 0) depends on the
> resolution.
> 
> When resolution is 12-bit, the conversion time is 140ms, but the minimum
> update_interval is 125ms. Handled this problem by waiting an additional
> 15ms (125ms + 15ms = 140ms).
> 
> Added 'mask' parameter to the shutdown_write() function. Now it can
> either write or update bits, depending on the value of mask. This is
> needed, because for alarms a write is necessary, but for resolution only
> the resolution bits should be updated.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
> 
> v4 -> v5: No change.
> 
> v3 -> v4: No change.
> 
> v2 -> v3: Fixed indentation problems in .rst.
> 
> v1 -> v2: Changed subject. Separated patch. Removed timeout sysfs
> attribute and kept only resolution. Added temp1_ prefix to resolution.
> Changed value of resolution from bits to milli-degrees Celsius. Added
> appropriate documentation.
> 
> 
>   Documentation/hwmon/max31827.rst |  29 ++++++--
>   drivers/hwmon/max31827.c         | 121 ++++++++++++++++++++++++++++---
>   2 files changed, 134 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index a8bbfb85dd02..44ab9dc064cb 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -90,11 +90,28 @@ the data sheet are:
>   
>   Enabling the device when it is already enabled has the side effect of setting
>   the conversion frequency to 1 conv/s. The conversion time varies depending on
> -the resolution. The conversion time doubles with every bit of increased
> -resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
> -(default) 140ms. When chip is in shutdown mode and a read operation is
> -requested, one-shot is triggered, the device waits for 140 (conversion time) ms,
> -and only after that is the temperature value register read.
> +the resolution.
> +
> +The conversion time doubles with every bit of increased resolution. The
> +available resolutions are:
> +
> +- 8 bit -> 8.75 ms conversion time
> +- 9 bit -> 17.5 ms conversion time
> +- 10 bit -> 35 ms conversion time
> +- 12 bit (default) -> 140 ms conversion time
> +
> +There is a temp1_resolution attribute which indicates the unit change in the
> +input temperature in milli-degrees C.
> +
> +- 1000 mC -> 8 bit
> +- 500 mC -> 9 bit
> +- 250 mC -> 10 bit
> +- 62 mC -> 12 bit (default) - actually this is 62.5, but the fil returns 62

fil ? Should that be "attribute" ?

> +
> +When chip is in shutdown mode and a read operation is requested, one-shot is
> +triggered, the device waits for <conversion time> ms, and only after that is
> +the temperature value register read. Note that the conversion times are rounded
> +up to the nearest possible integer.
>   
>   The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
>   the temperatures are displayed in milli-degrees. This means, that some data is
> @@ -117,4 +134,4 @@ corresponding status bits.
>   Notes
>   -----
>   
> -PEC and resolution are not implemented.
> +PEC is not implemented.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index 8ba387b51157..c9fa6d4d6194 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -37,6 +37,9 @@
>   #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
>   #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
>   
> +#define MAX31827_8_BIT_CNV_TIME		9
> +#define MAX31827_9_BIT_CNV_TIME		18
> +#define MAX31827_10_BIT_CNV_TIME	35
>   #define MAX31827_12_BIT_CNV_TIME	140
>   
>   #define MAX31827_ALRM_POL_HIGH	0x1
> @@ -68,6 +71,27 @@ static const u16 max31827_conversions[] = {
>   	[MAX31827_CNV_8_HZ] = 125,
>   };
>   
> +enum max31827_resolution {
> +	MAX31827_RES_8_BIT = 0,
> +	MAX31827_RES_9_BIT,
> +	MAX31827_RES_10_BIT,
> +	MAX31827_RES_12_BIT,
> +};
> +
> +static const u16 max31827_resolutions[] = {
> +	[MAX31827_RES_8_BIT] = 1000,
> +	[MAX31827_RES_9_BIT] = 500,
> +	[MAX31827_RES_10_BIT] = 250,
> +	[MAX31827_RES_12_BIT] = 62,
> +};
> +
> +static const u16 max31827_conv_times[] = {
> +	[MAX31827_RES_8_BIT] = MAX31827_8_BIT_CNV_TIME,
> +	[MAX31827_RES_9_BIT] = MAX31827_9_BIT_CNV_TIME,
> +	[MAX31827_RES_10_BIT] = MAX31827_10_BIT_CNV_TIME,
> +	[MAX31827_RES_12_BIT] = MAX31827_12_BIT_CNV_TIME,
> +};
> +
>   struct max31827_state {
>   	/*
>   	 * Prevent simultaneous access to the i2c client.
> @@ -75,6 +99,8 @@ struct max31827_state {
>   	struct mutex lock;
>   	struct regmap *regmap;
>   	bool enable;
> +	unsigned int resolution;
> +	unsigned int update_interval;
>   };
>   
>   static const struct regmap_config max31827_regmap = {
> @@ -91,9 +117,9 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
>   	int ret;
>   
>   	/*
> -	 * Before the Temperature Threshold Alarm and Alarm Hysteresis Threshold
> -	 * register values are changed over I2C, the part must be in shutdown
> -	 * mode.
> +	 * Before the Temperature Threshold Alarm, Alarm Hysteresis Threshold
> +	 * and Resolution bits from Configuration register are changed over I2C,
> +	 * the part must be in shutdown mode.
>   	 *
>   	 * Mutex is used to ensure, that some other process doesn't change the
>   	 * configuration register.
> @@ -211,9 +237,18 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   					mutex_unlock(&st->lock);
>   					return ret;
>   				}
> -
> -				msleep(MAX31827_12_BIT_CNV_TIME);
> +				msleep(max31827_conv_times[st->resolution]);
>   			}
> +
> +			/*
> +			 * For 12-bit resolution the conversion time is 140 ms,
> +			 * thus an additional 15 ms is needed to complete the
> +			 * conversion: 125 ms + 15 ms = 140 ms
> +			 */
> +			if (max31827_resolutions[st->resolution] == 12 &&
> +			    st->update_interval == 125)
> +				usleep_range(15000, 20000);
> +
>   			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
>   
>   			mutex_unlock(&st->lock);
> @@ -371,10 +406,14 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
>   					 res);
>   
> -			return regmap_update_bits(st->regmap,
> -						  MAX31827_CONFIGURATION_REG,
> -						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -						  res);
> +			ret = regmap_update_bits(st->regmap,
> +						 MAX31827_CONFIGURATION_REG,
> +						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +						 res);
> +			if (ret)
> +				return ret;
> +
> +			st->update_interval = val;
>   		}
>   		break;
>   
> @@ -385,6 +424,68 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   	return -EOPNOTSUPP;
>   }
>   
> +static ssize_t temp1_resolution_show(struct device *dev,
> +				     struct device_attribute *devattr,
> +				     char *buf)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_GET(MAX31827_CONFIGURATION_RESOLUTION_MASK, val);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", max31827_resolutions[val]);
> +}
> +
> +static ssize_t temp1_resolution_store(struct device *dev,
> +				      struct device_attribute *devattr,
> +				      const char *buf, size_t count)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	unsigned int idx = 0;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Convert the desired resolution into register
> +	 * bits. idx is already initialized with 0.
> +	 *
> +	 * This was inspired by lm73 driver.
> +	 */
> +	while (idx < ARRAY_SIZE(max31827_resolutions) &&
> +	       val < max31827_resolutions[idx])
> +		idx++;
> +
> +	if (idx == ARRAY_SIZE(max31827_resolutions) ||
> +	    val != max31827_resolutions[idx])
> +		return -EOPNOTSUPP;

		-EINVAL

Question here is if this should return the closest value/index
or return an error. Traditionally, for ranges like this, drivers
would accept all values and select the closest supported value.
[ just as the lm73 driver, which is listed as example here, does ]
There are even helper functions for that - find_closest()
or find_closest_descending(). I would very much prefer the
more flexible approach and not burden the user with having to find
supported values.

> +
> +	st->resolution = idx;
> +
> +	ret = shutdown_write(st, MAX31827_CONFIGURATION_REG,
> +			     MAX31827_CONFIGURATION_RESOLUTION_MASK,
> +			     FIELD_PREP(MAX31827_CONFIGURATION_RESOLUTION_MASK,
> +					idx));
> +
> +	return (ret) ? ret : count;

drop () around ret

> +}
> +
> +static DEVICE_ATTR_RW(temp1_resolution);
> +
> +static struct attribute *max31827_attrs[] = {
> +	&dev_attr_temp1_resolution.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(max31827);
> +
>   static const struct i2c_device_id max31827_i2c_ids[] = {
>   	{ "max31827", max31827 },
>   	{ "max31828", max31828 },
> @@ -501,7 +602,7 @@ static int max31827_probe(struct i2c_client *client)
>   
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
>   							 &max31827_chip_info,
> -							 NULL);
> +							 max31827_groups);
>   
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }

