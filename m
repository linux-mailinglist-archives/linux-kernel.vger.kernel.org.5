Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6A79EF39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjIMQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIMQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:47:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F46272E;
        Wed, 13 Sep 2023 09:44:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf7a6509deso49690715ad.3;
        Wed, 13 Sep 2023 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694623494; x=1695228294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LJE7+qXCJmoTi/omoFna3Xr7ZtHmLFPfam+faJSi/V8=;
        b=VWQVpyAKd+Zq4iKhgRbEpWXhKK6jXpFDLqqiy6gwbvayDlPKoaqbBoFxi/MzzXoLuA
         xHEGsWdARLWkfEwqYAYz+V9QgGzxl0XLe2IfRc/iuYlo6gHs7woFzjxilKIYpuc9LnBj
         THe5dLqRo3VDX/+jMfr6oBSUENFzqLYhh2PCfKFAwxV+qrSHV41n5fPF+sKZ3TJYHU9k
         ONR0lY9QMTx/ZlE+39yU9vfTQmlNPX4clfwNA6OZ/xDjrSlixBcFuReZYwSPbIGUZbRC
         EXtGPKUYghdVCqxwDH3pqbE0smpF7XmmhBA8X/DWgkOlrnKxgCb3eo5+1N5E0Ah5kjTy
         wJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623494; x=1695228294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJE7+qXCJmoTi/omoFna3Xr7ZtHmLFPfam+faJSi/V8=;
        b=aeYaGkqViaOX3O/nn0nzkNT4lWsrUgHrlXCv+q/zrcli046fepMUNeKn2u0gi8ERdF
         l5dk1zP2m68yTDYPhvbyf2AcHjkuTTpOZ4Ju41cXkyLBhu+4M1srPttIwhrpmFdRfPXd
         Afo2xS4Qs29sg70h0B/siuvydqrSHpbSm2DC441qBDEotGJX/yzne7YUMSxtzqgB1rGm
         KNKCEEEGcyvqpFtsHEZ5KjWdzHes34PDa/P03bY/Hv1mixvl6dcWJHCkOaLxz+0RTSpn
         9X8q/r//aun/V40SksCoOGxQnzUUPUGT6MdvsQnYRcVAW4P1md4gOyURXh7Kuivuj3BU
         +zLA==
X-Gm-Message-State: AOJu0YyaTxkj6vo1drciDj3Clo0XY5U4v2cq7UiQlTL/iieLGle+ewdZ
        2m2VpYc9r/ZzTEmDlhQjpTI=
X-Google-Smtp-Source: AGHT+IEAz9RhM/emxZRTy2Gcteoqak54PMBtzTJhoyzg9o0xek1stFp6NFGUDnCjF7p30mICUIT/AQ==
X-Received: by 2002:a17:902:c081:b0:1c0:c3cc:d12a with SMTP id j1-20020a170902c08100b001c0c3ccd12amr3415022pld.20.1694623493710;
        Wed, 13 Sep 2023 09:44:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001c20c608373sm10672178plq.296.2023.09.13.09.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:44:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b01ee87b-2a17-f556-c24b-3b07dbb97e97@roeck-us.net>
Date:   Wed, 13 Sep 2023 09:44:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] hwmon: max31827: Handle new properties from the
 devicetree
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230913152135.457892-1-daniel.matyas@analog.com>
 <20230913152135.457892-4-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230913152135.457892-4-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 08:21, Daniel Matyas wrote:
> Used fwnode to retrieve data from the devicetree in the init_client
> function.
> 
> Added support for devices max31828 and max31829. For these devices, when
> adi,flt-q and/or adi,alrm-pol are not mentioned, the default
> configuration is loaded.
> 

Still more than one logical change in a single patch.

> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>   Documentation/hwmon/max31827.rst |  47 ++++++++--
>   drivers/hwmon/max31827.c         | 142 +++++++++++++++++++++++++++----
>   2 files changed, 165 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 9a1055a007cf..e0eca1eb5c06 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -52,13 +52,21 @@ MAX31827 has low and over temperature alarms with an effective value and a
>   hysteresis value: -40 and -30 degrees for under temperature alarm and +100 and
>   +90 degrees for over temperature alarm.
>   
> -The alarm can be configured in comparator and interrupt mode. Currently only
> -comparator mode is implemented. In Comparator mode, the OT/UT status bits have a
> -value of 1 when the temperature rises above the TH value or falls below TL,
> -which is also subject to the Fault Queue selection. OT status returns to 0 when
> -the temperature drops below the TH_HYST value or when shutdown mode is entered.
> -Similarly, UT status returns to 0 when the temperature rises above TL_HYST value
> -or when shutdown mode is entered.
> +The alarm can be configured in comparator and interrupt mode from the
> +devicetree. In Comparator mode, the OT/UT status bits have a value of 1 when the
> +temperature rises above the TH value or falls below TL, which is also subject to
> +the Fault Queue selection. OT status returns to 0 when the temperature drops
> +below the TH_HYST value or when shutdown mode is entered. Similarly, UT status
> +returns to 0 when the temperature rises above TL_HYST value or when shutdown
> +mode is entered.
> +
> +In interrupt mode exceeding TH also sets OT status to 1, which remains set until
> +a read operation is performed on the configuration/status register (max or min
> +attribute); at this point, it returns to 0. Once OT status is set to 1 from
> +exceeding TH and reset, it is set to 1 again only when the temperature drops
> +below TH_HYST. The output remains asserted until it is reset by a read. It is
> +set again if the temperature rises above TH, and so on. The same logic applies
> +to the operation of the UT status bit.
>   
>   Putting the MAX31827 into shutdown mode also resets the OT/UT status bits. Note
>   that if the mode is changed while OT/UT status bits are set, an OT/UT status
> @@ -68,6 +76,17 @@ clear the status bits before changing the operating mode.
>   
>   The conversions can be manual with the one-shot functionality and automatic with
>   a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
> +The conversion rate can be modified with update_interval attribute of the chip.
> +Conversion/second = 1/update_interval. Thus, the available options according to
> +the data sheet are:
> +	- 64000 (ms) = 1 conv/64 sec
> +	- 32000 (ms) = 1 conv/32 sec
> +	- 16000 (ms) = 1 conv/16 sec
> +	- 4000 (ms) = 1 conv/4 sec
> +	- 1000 (ms) = 1 conv/sec (default)
> +	- 250 (ms) = 4 conv/sec
> +	- 125 (ms) = 8 conv/sec
> +
>   Enabling the device when it is already enabled has the side effect of setting
>   the conversion frequency to 1 conv/s. The conversion time varies depending on
>   the resolution. The conversion time doubles with every bit of increased
> @@ -83,8 +102,18 @@ in the writing of alarm values too. For positive numbers the user-input value
>   will always be rounded down to the nearest possible value, for negative numbers
>   the user-input will always be rounded up to the nearest possible value.
>   
> +Bus timeout resets the I2C-compatible interface when SCL is low for more than
> +30ms (nominal).
> +
> +Alarm polarity determines if the active state of the alarm is low or high. The
> +behavior for both settings is dependent on the Fault Queue setting. The ALARM
> +pin is an open-drain output and requires a pullup resistor to operate.
> +
> +The Fault Queue bits select how many consecutive temperature faults must occur
> +before overtemperature or undertemperature faults are indicated in the
> +corresponding status bits.
> +
>   Notes
>   -----
>   
> -Currently fault queue, alarm polarity and resolution cannot be modified.
> -PEC is not implemented either.
> +PEC and resolution are not implemented.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f05762219995..4dc14642775a 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -12,6 +12,19 @@
>   #include <linux/i2c.h>
>   #include <linux/mutex.h>
>   #include <linux/regmap.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/of_device.h>
> +
> +/*
> + * gcc turns __builtin_ffsll() into a call to __ffsdi2(), which is not provided
> + * by every architecture. __ffs64() is available on all architectures, but the
> + * result is not defined if no bits are set.
> + */
> +#define max31827__bf_shf(x)			 \
> +	({					 \
> +		typeof(x) x_ = (x);		 \
> +		((x_) != 0) ? __ffs64(x_) : 0x0; \
> +	})
>   
>   #define MAX31827_T_REG			0x0
>   #define MAX31827_CONFIGURATION_REG	0x2
> @@ -22,15 +35,25 @@
>   
>   #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>   #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> -#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
> -#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
> +#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
> +#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
> +#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> +#define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
> +#define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
> +#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
> +#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
>   
>   #define MAX31827_12_BIT_CNV_TIME	140
>   
> +#define MAX31827_FLT_Q_1	0x0
> +#define MAX31827_FLT_Q_4	0x2
> +
>   #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
>   #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
>   #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
>   
> +enum chips { max31827, max31828, max31829 };
> +
>   enum max31827_cnv {
>   	MAX31827_CNV_1_DIV_64_HZ = 1,
>   	MAX31827_CNV_1_DIV_32_HZ,
> @@ -58,6 +81,7 @@ struct max31827_state {
>   	struct mutex lock;
>   	struct regmap *regmap;
>   	bool enable;
> +	struct i2c_client *client;
>   };
>   
>   static const struct regmap_config max31827_regmap = {
> @@ -361,14 +385,93 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   	return -EOPNOTSUPP;
>   }
>   
> -static int max31827_init_client(struct max31827_state *st)
> +static const struct i2c_device_id max31827_i2c_ids[] = {
> +       { "max31827", max31827 },
> +       { "max31828", max31828 },
> +       { "max31829", max31829 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> +
> +static int max31827_init_client(struct max31827_state *st,
> +				struct fwnode_handle *fwnode)
>   {
> +	bool prop;
> +	u32 data, lsb_idx;
> +	unsigned int res = 0;
> +	enum chips type;
> +	int ret;
> +
>   	st->enable = true;
> +	res |= MAX31827_DEVICE_ENABLE(1);
> +
> +	res |= MAX31827_CONFIGURATION_RESOLUTION_MASK;
>   
> -	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> -				  MAX31827_CONFIGURATION_1SHOT_MASK |
> -					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -				  MAX31827_DEVICE_ENABLE(1));
> +	prop = fwnode_property_read_bool(fwnode, "adi,comp-int");
> +	res |= FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, prop);
> +
> +	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
> +	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
> +
> +	if (st->client->dev.of_node)
> +		type = (enum chips)of_device_get_match_data(&st->client->dev);
> +	else
> +		type = i2c_match_id(max31827_i2c_ids, st->client)->driver_data;
> +
> +	if (fwnode_property_present(fwnode, "adi,alrm-pol")) {
> +		ret = fwnode_property_read_u32(fwnode, "adi,alrm-pol", &data);
> +		if (ret)
> +			return ret;
> +
> +		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
> +	} else {
> +		switch (type) {
> +		case max31827:
> +		case max31828:
> +			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
> +					  0x0);
> +			break;
> +		case max31829:
> +			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
> +					  0x1);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	if (fwnode_property_present(fwnode, "adi,flt-q")) {
> +		ret = fwnode_property_read_u32(fwnode, "adi,flt-q", &data);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Convert the desired fault queue into register bits.
> +		 */
> +		lsb_idx = max31827__bf_shf(data);
> +		if (lsb_idx > 3 || data != BIT(lsb_idx)) {
> +			dev_err(&st->client->dev, "Invalid data in fault queue\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
> +	} else {
> +		switch (type) {
> +		case max31827:
> +			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
> +					  MAX31827_FLT_Q_1);
> +			break;
> +		case max31828:
> +		case max31829:
> +			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
> +					  MAX31827_FLT_Q_4);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
>   }
>   
>   static const struct hwmon_channel_info *max31827_info[] = {
> @@ -396,6 +499,7 @@ static int max31827_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct max31827_state *st;
> +	struct fwnode_handle *fwnode;
>   	int err;
>   
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> @@ -412,7 +516,10 @@ static int max31827_probe(struct i2c_client *client)
>   		return dev_err_probe(dev, PTR_ERR(st->regmap),
>   				     "Failed to allocate regmap.\n");
>   
> -	err = max31827_init_client(st);
> +	st->client = client;
> +	fwnode = dev_fwnode(dev);
> +
> +	err = max31827_init_client(st, fwnode);
>   	if (err)
>   		return err;
>   
> @@ -423,14 +530,19 @@ static int max31827_probe(struct i2c_client *client)
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   
> -static const struct i2c_device_id max31827_i2c_ids[] = {
> -	{ "max31827", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> -
>   static const struct of_device_id max31827_of_match[] = {
> -	{ .compatible = "adi,max31827" },
> +	{
> +		.compatible = "adi,max31827",
> +		.data = (void *)max31827
> +	},
> +	{
> +		.compatible = "adi,max31828",
> +		.data = (void *)max31828
> +	},
> +	{
> +		.compatible = "adi,max31829",
> +		.data = (void *)max31829
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, max31827_of_match);

