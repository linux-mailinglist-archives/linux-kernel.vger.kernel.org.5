Return-Path: <linux-kernel+bounces-4179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53B8178E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455251C25286
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673005BFB9;
	Mon, 18 Dec 2023 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNchnvP8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F11E4BF;
	Mon, 18 Dec 2023 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3b66733a9so6559985ad.2;
        Mon, 18 Dec 2023 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921079; x=1703525879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9oaFHCCDI1MHrsKGmso+es37yBkgml+kPF0HQgZSQ20=;
        b=hNchnvP8j3qR3jE75AkYhvPIJIzexySLQamDK13GsB7Ojk3fxWZ6hWZXJegnUoQoWX
         9u6FmVbc8aKAJB80H8DXB4C5lM1A1SGwom2RBb62OLh84pWq8P+gn/gzbs2ZM3+spwre
         rmPGpXm2e4a0QdkwjfcKSsQiZSPhviQgefEeOaxZEE7LWIuL0vNtgAYPg62oa314eRiE
         L5QfVWlGxEP7LRUM1/98CWmePKOXJZH4Z+tqIOJIydrFKtX1Uq+1Pn1xrbLx6UsyIS5P
         SbSiHOu5ExFEebrR/V1EUCcy2ZP11AXgcf8fzWOYcVAlm1YfqKB8jX2Mk8k7fZzbcnO1
         4GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921079; x=1703525879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oaFHCCDI1MHrsKGmso+es37yBkgml+kPF0HQgZSQ20=;
        b=O6XhrnI+W0k7sqRb4+RBKVlwNAiyExrTOCCr7Ouv78zwNHb5HVH8L/FJaV2LFTaS31
         +Vac/XoW5rd8i3bLLv2p0DWD+dd17dRjlR6xbmZRLLX2jmmO2s+thTtpbaGImc/jtkuY
         sLYcOWIbkRGI6C3sWShNY93k3turEu0yOmm2j5uewaXPTx/FowQzn08Jb9aAE96Tdh9O
         iRsEDttebDUoYEJW6LI78bNpvTF+/JvC1L9ur0vuLzS62rxe9pVpOt1qcj13FjIYtwER
         +ASXcNVC6OoGo2588oQS1GxdZGQQfT/DXzpjs4KUFKsASEX9Dz85fhJVi5rppMCTfxiX
         p3gQ==
X-Gm-Message-State: AOJu0YxqAXorbHFjiw9ctrpZo4iuKTf/QRgY/i16ybqqwTwqCylET85l
	MxikEFxFaTVV0mVAMTeiPyg=
X-Google-Smtp-Source: AGHT+IETgqfFvqXl4D6oTt8HqSBTHeU5qIhotu6cWcFE5mphMS+hJLeTcvmtsRtxh3VpBUV5K9k01A==
X-Received: by 2002:a17:902:a517:b0:1d0:6ffd:ce97 with SMTP id s23-20020a170902a51700b001d06ffdce97mr8244321plq.80.1702921079335;
        Mon, 18 Dec 2023 09:37:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b001d3d9be4d5bsm35613plb.88.2023.12.18.09.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:37:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dea56d34-bab1-4bca-9daf-5a48b4e0507e@roeck-us.net>
Date: Mon, 18 Dec 2023 09:37:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Content-Language: en-US
To: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/23 20:52, Abdel Alkuor wrote:
> as6200 is a temperature sensor with 0.0625°C resolution and a
> range between -40°C to 125°C.
> 
> By default, the driver configures as6200 as following:
> - Converstion rate: 8 Hz
> - Conversion mode: continuous
> - Consecutive fault counts: 4 samples
> - Alert state: high polarity
> - Alert mode: comparator mode
> 
> Interrupt is supported for the alert pin.
> 
> Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v2:
>    - Incorporate as6200 into lm75 driver
> 
>   Documentation/hwmon/lm75.rst |  10 +++
>   drivers/hwmon/lm75.c         | 132 +++++++++++++++++++++++++++++------
>   2 files changed, 122 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
> index 8d0ab4ad5fb5..6adab608dd05 100644
> --- a/Documentation/hwmon/lm75.rst
> +++ b/Documentation/hwmon/lm75.rst
> @@ -133,6 +133,16 @@ Supported chips:
>   
>                  https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
>   
> +  * AMS OSRAM AS6200
> +
> +    Prefix: 'as6200'
> +
> +    Addresses scanned: none
> +
> +    Datasheet: Publicly available at the AMS website
> +
> +               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
>   Author: Frodo Looijaard <frodol@dds.nl>
>   
>   Description
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 5b2ea05c951e..2d153f6729e0 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/init.h>
> +#include <linux/interrupt.h>
>   #include <linux/slab.h>
>   #include <linux/jiffies.h>
>   #include <linux/i2c.h>
> @@ -25,6 +26,7 @@
>   
>   enum lm75_type {		/* keep sorted in alphabetical order */
>   	adt75,
> +	as6200,
>   	at30ts74,
>   	ds1775,
>   	ds75,
> @@ -55,6 +57,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>   
>   /**
>    * struct lm75_params - lm75 configuration parameters.
> + * @config_reg_16bits	Configure register size is 2 bytes.

@config_reg_16bits:

>    * @set_mask:		Bits to set in configuration register when configuring
>    *			the chip.
>    * @clr_mask:		Bits to clear in configuration register when configuring
> @@ -75,17 +78,20 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>    * @sample_times:	All the possible sample times to be set. Mandatory if
>    *			num_sample_times is larger than 1. If set, number of
>    *			entries must match num_sample_times.
> + * @alarm		Alarm is supported.

@alarm:

>    */
>   
>   struct lm75_params {
> -	u8			set_mask;
> -	u8			clr_mask;
> +	bool			config_reg_16bits;
> +	u16			set_mask;
> +	u16			clr_mask;
>   	u8			default_resolution;
>   	u8			resolution_limits;
>   	const u8		*resolutions;
>   	unsigned int		default_sample_time;
>   	u8			num_sample_times;
>   	const unsigned int	*sample_times;
> +	bool			alarm;
>   };
>   
>   /* Addresses scanned */
> @@ -104,8 +110,8 @@ struct lm75_data {
>   	struct i2c_client		*client;
>   	struct regmap			*regmap;
>   	struct regulator		*vs;
> -	u8				orig_conf;
> -	u8				current_conf;
> +	u16				orig_conf;
> +	u16				current_conf;
>   	u8				resolution;	/* In bits, 9 to 16 */
>   	unsigned int			sample_time;	/* In ms */
>   	enum lm75_type			kind;
> @@ -128,6 +134,15 @@ static const struct lm75_params device_params[] = {
>   		.default_resolution = 12,
>   		.default_sample_time = MSEC_PER_SEC / 10,
>   	},
> +	[as6200] = {
> +		.config_reg_16bits = true,
> +		.set_mask = 0x94C0,	/* 8 sample/s, 4 CF, positive polarity */
> +		.default_resolution = 12,
> +		.default_sample_time = 125,
> +		.num_sample_times = 4,
> +		.sample_times = (unsigned int []){ 125, 250, 1000, 4000 },
> +		.alarm = true,
> +	},
>   	[at30ts74] = {
>   		.set_mask = 3 << 5,	/* 12-bit mode*/
>   		.default_resolution = 12,
> @@ -317,20 +332,23 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
>   	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
>   }
>   
> -static int lm75_write_config(struct lm75_data *data, u8 set_mask,
> -			     u8 clr_mask)
> +static int lm75_write_config(struct lm75_data *data, u16 set_mask,
> +			     u16 clr_mask)
>   {
> -	u8 value;
> +	unsigned int value;
>   
> -	clr_mask |= LM75_SHUTDOWN;
> +	clr_mask |= LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
>   	value = data->current_conf & ~clr_mask;
>   	value |= set_mask;
>   
>   	if (data->current_conf != value) {
>   		s32 err;
> -
> -		err = i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
> -						value);
> +		if (data->params->config_reg_16bits)
> +			err = regmap_write(data->regmap, LM75_REG_CONF, value);
> +		else
> +			err = i2c_smbus_write_byte_data(data->client,
> +							LM75_REG_CONF,
> +							value);
>   		if (err)
>   			return err;
>   		data->current_conf = value;
> @@ -338,6 +356,33 @@ static int lm75_write_config(struct lm75_data *data, u8 set_mask,
>   	return 0;
>   }
>   
> +static int lm75_read_config(struct lm75_data *data, u16 *config)
> +{
> +	int ret;
> +	unsigned int status;
> +
> +	if (data->params->config_reg_16bits) {
> +		ret = regmap_read(data->regmap, LM75_REG_CONF, &status);
> +	} else {
> +		ret = i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
> +		status = ret;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*config = status;
> +	return 0;
> +}
> +
> +static irqreturn_t lm75_alarm_handler(int irq, void *private)
> +{
> +	struct device *hwmon_dev = private;
> +
> +	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
> +	return IRQ_HANDLED;
> +}
> +
>   static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
>   		     u32 attr, int channel, long *val)
>   {
> @@ -366,6 +411,9 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
>   		case hwmon_temp_max_hyst:
>   			reg = LM75_REG_HYST;
>   			break;
> +		case hwmon_temp_alarm:
> +			reg = LM75_REG_CONF;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -373,7 +421,17 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
>   		if (err < 0)
>   			return err;
>   
> -		*val = lm75_reg_to_mc(regval, data->resolution);
> +		if (attr == hwmon_temp_alarm) {
> +			switch (data->kind) {
> +			case as6200:
> +				*val = (regval >> 5) & 0x1;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else {
> +			*val = lm75_reg_to_mc(regval, data->resolution);
> +		}
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -436,6 +494,7 @@ static int lm75_update_interval(struct device *dev, long val)
>   			data->resolution = data->params->resolutions[index];
>   		break;
>   	case tmp112:
> +	case as6200:
>   		err = regmap_read(data->regmap, LM75_REG_CONF, &reg);
>   		if (err < 0)
>   			return err;
> @@ -503,6 +562,9 @@ static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
>   		case hwmon_temp_max:
>   		case hwmon_temp_max_hyst:
>   			return 0644;
> +		case hwmon_temp_alarm:
> +			if (config_data->params->alarm)
> +				return 0444;

Missing
			break;

>   		}
>   		break;
>   	default:
> @@ -515,7 +577,8 @@ static const struct hwmon_channel_info * const lm75_info[] = {
>   	HWMON_CHANNEL_INFO(chip,
>   			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
>   	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_ALARM),
>   	NULL
>   };
>   
> @@ -574,7 +637,7 @@ static int lm75_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct lm75_data *data;
> -	int status, err;
> +	int err;
>   	enum lm75_type kind;
>   
>   	if (client->dev.of_node)
> @@ -623,13 +686,13 @@ static int lm75_probe(struct i2c_client *client)
>   		return err;
>   
>   	/* Cache original configuration */
> -	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
> -	if (status < 0) {
> -		dev_dbg(dev, "Can't read config? %d\n", status);
> -		return status;
> +	err = lm75_read_config(data, &data->current_conf);
> +	if (err) {
> +		dev_dbg(dev, "Can't read config? %d\n", err);
> +		return err;
>   	}

I don't think splitting the return value from the error code adds any value,
even more so since it needs to be dereferenced below anyway. Please just keep
the original semantics here, and have lm75_read_config() return the combined
error code and status.

> -	data->orig_conf = status;
> -	data->current_conf = status;
> +
> +	data->orig_conf = data->current_conf;
>   
>   	err = lm75_write_config(data, data->params->set_mask,
>   				data->params->clr_mask);
> @@ -646,6 +709,30 @@ static int lm75_probe(struct i2c_client *client)
>   	if (IS_ERR(hwmon_dev))
>   		return PTR_ERR(hwmon_dev);
>   
> +	if (client->irq) {
> +		if (data->params->alarm) {
> +			err = devm_request_threaded_irq(dev,
> +							client->irq,
> +							NULL,
> +							&lm75_alarm_handler,
> +							IRQF_ONESHOT,
> +							client->name,
> +							hwmon_dev);
> +			if (err)
> +				return err;
> +		} else {
> +			/*
> +			 * Currently, alarm is only supported for chips with
> +			 * alarm bit.
> +			 * In the future, if alarm is needed for chips with
> +			 * no alarm bit, current temp needs to be compared
> +			 * against the max and max hyst values to set/clear
> +			 * the alarm state.

Please don't make such suggestions. If userspace wants to compare attributes
if there is no alarm attribute, it is free to do it. We should not even try
to do it in the kernel.

> +			 */
> +			dev_warn(dev, "alarm interrupt is not supported\n");

I think this should be an error: There should be no interrupt configured on a
chip not supporting it.

> +		}
> +	}
> +
>   	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
>   
>   	return 0;
> @@ -654,6 +741,7 @@ static int lm75_probe(struct i2c_client *client)
>   static const struct i2c_device_id lm75_ids[] = {
>   	{ "adt75", adt75, },
>   	{ "at30ts74", at30ts74, },
> +	{ "as6200", as6200, },

Alphabetic order, please

>   	{ "ds1775", ds1775, },
>   	{ "ds75", ds75, },
>   	{ "ds7505", ds7505, },
> @@ -689,6 +777,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>   		.compatible = "adi,adt75",
>   		.data = (void *)adt75
>   	},
> +	{
> +		.compatible = "ams,as6200",
> +		.data = (void *)as6200
> +	},
>   	{
>   		.compatible = "atmel,at30ts74",
>   		.data = (void *)at30ts74


