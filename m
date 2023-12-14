Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1068E8135CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443955AbjLNQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443716AbjLNQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:10:11 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C3129;
        Thu, 14 Dec 2023 08:10:15 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-59082c4aadaso4499965eaf.0;
        Thu, 14 Dec 2023 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702570215; x=1703175015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FWNp3FuJ5Df2LwpuxXMOpX/AHjcs+ffWdIGjGx9ZdRQ=;
        b=iBVa2iqujU+m/bvXyOQ7M/5vafwsCZt7VnBMYM0nPLY4Vk6NyZqoOCjF7G6NpJtBOy
         fES01FRM6fNQfQfz6QM5WuES3cDVCBpiqPAGtLaspRjEzIp8LxFZFwomZg520PBvpURH
         xTjvV71PGeaOR7rSgeW6wKiaWoqJQE1LOoRnUISWuBc3HI1mGoIphIapvIvAPoJKBStK
         PUO35pbTArB3Ga8HjUt3mL+uh+3mMwHU+pVGH5ManDDUggNHLtd2U+qaIAQDQmMEU2tJ
         hQHGxHT+H1fyspWmO5gFgSNm2XD8q4R/eIU8HOWGxQLWKi+s6agqXe5ksD8CSl3jZagR
         lkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570215; x=1703175015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWNp3FuJ5Df2LwpuxXMOpX/AHjcs+ffWdIGjGx9ZdRQ=;
        b=k19WqjZu42+y4rfiOpe686qqpyLmUa/lC+8OisvFqaXi8ox5U+MNF1sGNrwCaxZ1jn
         N7Gb0gdPszmUwuU4FMdAefvEOh07teOxDL17D/E8H4+zwUDwqdCklCyObkVf0bpaIYfj
         vz+0oWT8HWhYSmqY+kGnLzeFXKjXPcH2VKhEZcCVReddPWfvOqFn2x368ZSPQ4vp5+fD
         Tw0blfupsots7ZuK/pos8GSWKBFdCh9QCm6ZXIkHdbf164+R6JnYFr6zTo2vrfXCsm48
         f/ciNt9N7SheX0FTdT38FA6QtjUwjVT8YIn+q0SED/UPBhRZswPR+NO8gw/+t0kp7jmU
         1KpA==
X-Gm-Message-State: AOJu0YyOro2Dpr9kBH08VHBfX2xULn94fWubwKClPcel3pmDmkEr4m7N
        BiWbR48eWEwOql9NMxT1t+U=
X-Google-Smtp-Source: AGHT+IENFYIJPLT5Q/FXKivo7wZfFB8/J0f7w20KA1VEJPqMDJFhS72cjHOzSKQIcwSaC5g2HwEVSg==
X-Received: by 2002:a05:6820:162c:b0:590:6f86:f3c6 with SMTP id bb44-20020a056820162c00b005906f86f3c6mr8166910oob.12.1702570214809;
        Thu, 14 Dec 2023 08:10:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020a4a7002000000b0058ad7b0b1a8sm3542450ooc.13.2023.12.14.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:10:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2e0bf1cf-824d-40c6-9450-7ed4740f2f46@roeck-us.net>
Date:   Thu, 14 Dec 2023 08:10:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231214143648.175336-1-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231214143648.175336-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 06:36, Daniel Matyas wrote:
> Removed regmap and used my functions to read, write and update bits. In
> these functions i2c_smbus_ helper functions are used. These check if
> there were any PEC errors during read. In the write function, if PEC is
> enabled, I check for PEC Error bit, to see if there were any errors.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>

The "PEC" attribute needs to be attached to the I2C device.
See lm90.c or pmbus_core.c for examples.

The changes, if indeed needed, do not warant dropping regmap.
You will need to explain why the reg_read and reg_write callbacks
provideed by regmap can not be used.

On top of that, it is not clear why regmap can't be used in the first place.
It seems that the major change is that one needs to read the configuration
register after a write to see if there was a PEC error. It is not immediately
obvious why that additional read (if indeed necessary) would require regmap
support to be dropped.

Regarding "if indeed necessary": There needs to be a comment explaining
that the device will return ACK even after a packet with bad PEC is received.

> ---
>   Documentation/hwmon/max31827.rst |  14 +-
>   drivers/hwmon/max31827.c         | 219 +++++++++++++++++++++++--------
>   2 files changed, 171 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 44ab9dc064cb..ecbc1ddba6a7 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -131,7 +131,13 @@ The Fault Queue bits select how many consecutive temperature faults must occur
>   before overtemperature or undertemperature faults are indicated in the
>   corresponding status bits.
>   
> -Notes
> ------
> -
> -PEC is not implemented.
> +PEC (packet error checking) can be enabled from the "pec" device attribute.
> +If PEC is enabled, a PEC byte is appended to the end of each message transfer.
> +This is a CRC-8 byte that is calculated on all of the message bytes (including
> +the address/read/write byte). The last device to transmit a data byte also
> +transmits the PEC byte. The master transmits the PEC byte after a write
> +transaction, and the MAX31827 transmits the PEC byte after a read transaction.
> +
> +The read PEC error is handled inside the i2c_smbus_read_word_swapped() function.
> +To check if the write had any PEC error a read is performed on the configuration
> +register, to check the PEC Error bit.
> \ No newline at end of file
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index 71ad3934dfb6..db93492193bd 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -11,8 +11,8 @@
>   #include <linux/hwmon.h>
>   #include <linux/i2c.h>
>   #include <linux/mutex.h>
> -#include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/hwmon-sysfs.h>
>   #include <linux/of_device.h>
>   
>   #define MAX31827_T_REG			0x0
> @@ -24,11 +24,13 @@
>   
>   #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>   #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>   #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>   #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
>   #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
>   #define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
>   #define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
> +#define MAX31827_CONFIGURATION_PEC_ERR_MASK	BIT(13)
>   #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
>   #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
>   
> @@ -94,23 +96,67 @@ struct max31827_state {
>   	 * Prevent simultaneous access to the i2c client.
>   	 */
>   	struct mutex lock;
> -	struct regmap *regmap;
>   	bool enable;
>   	unsigned int resolution;
>   	unsigned int update_interval;
> +	struct i2c_client *client;
>   };
>   
> -static const struct regmap_config max31827_regmap = {
> -	.reg_bits = 8,
> -	.val_bits = 16,
> -	.max_register = 0xA,
> -};
> +static int max31827_reg_read(struct i2c_client *client, u8 reg, u16 *val)
> +{
> +	u16 tmp = i2c_smbus_read_word_swapped(client, reg);
> +
> +	if (tmp < 0)

An u16 variable will never be negative.

> +		return tmp;
> +
> +	*val = tmp;
> +	return 0;
> +}

If regmap can indeed not be used, it is unnecessary to provide a pointer
to the return value. Instead, just like with smbus calls, the error return
and the return value can be combined. Adding this function just to separate
error from return value adds zero value (and, as can be seen from the above,
actually adds an opportunity to introduce bugs).

> +
> +static int max31827_reg_write(struct i2c_client *client, u8 reg, u16 val)
> +{
> +	u16 cfg;
> +	int ret;
> +
> +	ret = i2c_smbus_write_word_swapped(client, reg, val);
> +	if (ret)
> +		return ret;
> +
> +	// If PEC is not enabled, return with success

Do not mix comment styles. The rest of the driver doesn't use C++ comments.
Besides, the comment does not add any value.

> +	if (!(client->flags & I2C_CLIENT_PEC))
> +		return 0;
> +
> +	ret = max31827_reg_read(client, MAX31827_CONFIGURATION_REG, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (cfg & MAX31827_CONFIGURATION_PEC_ERR_MASK)
> +		return -EBADMSG;
> +

EBADMSG is "Not a data message". I don't think that is appropriate here.

I would very much prefer
	if (client->flags & I2C_CLIENT_PEC) {
		...
	}

> +	return 0;
> +}
> +
> +static int max31827_update_bits(struct i2c_client *client, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	u16 tmp;
> +	int ret;
> +
> +	ret = max31827_reg_read(client, reg, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	tmp = (tmp & ~mask) | (val & mask);
> +	ret = max31827_reg_write(client, reg, tmp);
> +
> +	return ret;
> +}
>   
>   static int shutdown_write(struct max31827_state *st, unsigned int reg,
>   			  unsigned int mask, unsigned int val)
>   {
> -	unsigned int cfg;
> -	unsigned int cnv_rate;
> +	u16 cfg;
> +	u16 cnv_rate;

I really do not see the point of those changes. u16 is more expensive than
unsigned int on many architectures. If retained, you'll have to explain
why this is needed and beneficial.

>   	int ret;
>   
>   	/*
> @@ -125,34 +171,34 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
>   
>   	if (!st->enable) {
>   		if (!mask)
> -			ret = regmap_write(st->regmap, reg, val);
> +			ret = max31827_reg_write(st->client, reg, val);
>   		else
> -			ret = regmap_update_bits(st->regmap, reg, mask, val);
> +			ret = max31827_update_bits(st->client, reg, mask, val);
>   		goto unlock;
>   	}
>   
> -	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &cfg);
> +	ret = max31827_reg_read(st->client, MAX31827_CONFIGURATION_REG, &cfg);
>   	if (ret)
>   		goto unlock;
>   
>   	cnv_rate = MAX31827_CONFIGURATION_CNV_RATE_MASK & cfg;
>   	cfg = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
>   		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
> -	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
> +	ret = max31827_reg_write(st->client, MAX31827_CONFIGURATION_REG, cfg);
>   	if (ret)
>   		goto unlock;
>   
>   	if (!mask)
> -		ret = regmap_write(st->regmap, reg, val);
> +		ret = max31827_reg_write(st->client, reg, val);
>   	else
> -		ret = regmap_update_bits(st->regmap, reg, mask, val);
> +		ret = max31827_update_bits(st->client, reg, mask, val);
>   
>   	if (ret)
>   		goto unlock;
>   
> -	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> -				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -				 cnv_rate);
> +	ret = max31827_update_bits(st->client, MAX31827_CONFIGURATION_REG,
> +				   MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +				   cnv_rate);
>   
>   unlock:
>   	mutex_unlock(&st->lock);
> @@ -198,15 +244,16 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   			 u32 attr, int channel, long *val)
>   {
>   	struct max31827_state *st = dev_get_drvdata(dev);
> -	unsigned int uval;
> +	u16 uval;
>   	int ret = 0;
>   
>   	switch (type) {
>   	case hwmon_temp:
>   		switch (attr) {
>   		case hwmon_temp_enable:
> -			ret = regmap_read(st->regmap,
> -					  MAX31827_CONFIGURATION_REG, &uval);
> +			ret = max31827_reg_read(st->client,
> +						MAX31827_CONFIGURATION_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
> @@ -226,10 +273,10 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   				 * be changed during the conversion process.
>   				 */
>   
> -				ret = regmap_update_bits(st->regmap,
> -							 MAX31827_CONFIGURATION_REG,
> -							 MAX31827_CONFIGURATION_1SHOT_MASK,
> -							 1);
> +				ret = max31827_update_bits(st->client,
> +							   MAX31827_CONFIGURATION_REG,
> +							   MAX31827_CONFIGURATION_1SHOT_MASK,
> +							   1);
>   				if (ret) {
>   					mutex_unlock(&st->lock);
>   					return ret;
> @@ -246,7 +293,8 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   			    st->update_interval == 125)
>   				usleep_range(15000, 20000);
>   
> -			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
> +			ret = max31827_reg_read(st->client, MAX31827_T_REG,
> +						&uval);
>   
>   			mutex_unlock(&st->lock);
>   
> @@ -257,23 +305,26 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   
>   			break;
>   		case hwmon_temp_max:
> -			ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
> +			ret = max31827_reg_read(st->client, MAX31827_TH_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
>   			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>   			break;
>   		case hwmon_temp_max_hyst:
> -			ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG,
> -					  &uval);
> +			ret = max31827_reg_read(st->client,
> +						MAX31827_TH_HYST_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
>   			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>   			break;
>   		case hwmon_temp_max_alarm:
> -			ret = regmap_read(st->regmap,
> -					  MAX31827_CONFIGURATION_REG, &uval);
> +			ret = max31827_reg_read(st->client,
> +						MAX31827_CONFIGURATION_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
> @@ -281,23 +332,25 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   					 uval);
>   			break;
>   		case hwmon_temp_min:
> -			ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
> +			ret = max31827_reg_read(st->client, MAX31827_TL_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
>   			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>   			break;
>   		case hwmon_temp_min_hyst:
> -			ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG,
> -					  &uval);
> +			ret = max31827_reg_read(st->client, MAX31827_TL_HYST_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
>   			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>   			break;
>   		case hwmon_temp_min_alarm:
> -			ret = regmap_read(st->regmap,
> -					  MAX31827_CONFIGURATION_REG, &uval);
> +			ret = max31827_reg_read(st->client,
> +						MAX31827_CONFIGURATION_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
> @@ -313,8 +366,9 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   
>   	case hwmon_chip:
>   		if (attr == hwmon_chip_update_interval) {
> -			ret = regmap_read(st->regmap,
> -					  MAX31827_CONFIGURATION_REG, &uval);
> +			ret = max31827_reg_read(st->client,
> +						MAX31827_CONFIGURATION_REG,
> +						&uval);
>   			if (ret)
>   				break;
>   
> @@ -355,11 +409,11 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   
>   			st->enable = val;
>   
> -			ret = regmap_update_bits(st->regmap,
> -						 MAX31827_CONFIGURATION_REG,
> -						 MAX31827_CONFIGURATION_1SHOT_MASK |
> -						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -						 MAX31827_DEVICE_ENABLE(val));
> +			ret = max31827_update_bits(st->client,
> +						   MAX31827_CONFIGURATION_REG,
> +						   MAX31827_CONFIGURATION_1SHOT_MASK |
> +						   MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +						   MAX31827_DEVICE_ENABLE(val));
>   
>   			mutex_unlock(&st->lock);
>   
> @@ -402,10 +456,10 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
>   					 res);
>   
> -			ret = regmap_update_bits(st->regmap,
> -						 MAX31827_CONFIGURATION_REG,
> -						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -						 res);
> +			ret = max31827_update_bits(st->client,
> +						   MAX31827_CONFIGURATION_REG,
> +						   MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +						   res);
>   			if (ret)
>   				return ret;
>   
> @@ -425,10 +479,10 @@ static ssize_t temp1_resolution_show(struct device *dev,
>   				     char *buf)
>   {
>   	struct max31827_state *st = dev_get_drvdata(dev);
> -	unsigned int val;
> +	u16 val;
>   	int ret;
>   
> -	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
> +	ret = max31827_reg_read(st->client, MAX31827_CONFIGURATION_REG, &val);
>   	if (ret)
>   		return ret;
>   
> @@ -473,10 +527,63 @@ static ssize_t temp1_resolution_store(struct device *dev,
>   	return ret ? ret : count;
>   }
>   
> +static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	struct i2c_client *client = st->client;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
> +}
> +
> +static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	struct i2c_client *client = st->client;
> +	unsigned int val;
> +	u16 val2;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	val2 = FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK, val);
> +
> +	if (err)
> +		return err;
> +
> +	switch (val) {
> +	case 0:
> +		client->flags &= ~I2C_CLIENT_PEC;
> +		err = max31827_update_bits(client, MAX31827_CONFIGURATION_REG,
> +					   MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					   val2);
> +		if (err)
> +			return err;
> +		break;
> +	case 1:
> +		err = max31827_update_bits(client, MAX31827_CONFIGURATION_REG,
> +					   MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					   val2);
> +		if (err)
> +			return err;
> +		client->flags |= I2C_CLIENT_PEC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
>   static DEVICE_ATTR_RW(temp1_resolution);
> +static DEVICE_ATTR_RW(pec);
>   
>   static struct attribute *max31827_attrs[] = {
>   	&dev_attr_temp1_resolution.attr,
> +	&dev_attr_pec.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(max31827);
> @@ -489,9 +596,9 @@ static const struct i2c_device_id max31827_i2c_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
>   
> -static int max31827_init_client(struct max31827_state *st,
> -				struct device *dev)
> +static int max31827_init_client(struct max31827_state *st)
>   {
> +	struct device *dev = &st->client->dev;

Now we are absolutely down to personal preference changes.
I am not at all inclined to accept such changes, sorry.

Including such changes means I'll have to put extra scrutiny on your
patch submissions in the future to ensure that you don't try to sneak in
similar changes, which I find quite frustrating. Is that really necessary ?

Guenter

>   	struct fwnode_handle *fwnode;
>   	unsigned int res = 0;
>   	u32 data, lsb_idx;
> @@ -575,7 +682,7 @@ static int max31827_init_client(struct max31827_state *st,
>   		}
>   	}
>   
> -	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
> +	return max31827_reg_write(st->client, MAX31827_CONFIGURATION_REG, res);
>   }
>   
>   static const struct hwmon_channel_info *max31827_info[] = {
> @@ -613,17 +720,13 @@ static int max31827_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	mutex_init(&st->lock);
> -
> -	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
> -	if (IS_ERR(st->regmap))
> -		return dev_err_probe(dev, PTR_ERR(st->regmap),
> -				     "Failed to allocate regmap.\n");
> +	st->client = client;
>   
>   	err = devm_regulator_get_enable(dev, "vref");
>   	if (err)
>   		return dev_err_probe(dev, err, "failed to enable regulator\n");
>   
> -	err = max31827_init_client(st, dev);
> +	err = max31827_init_client(st);
>   	if (err)
>   		return err;
>   

