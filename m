Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1670079BC32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378798AbjIKWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbjIKNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:45:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEBCD7;
        Mon, 11 Sep 2023 06:45:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68faf930054so1485031b3a.0;
        Mon, 11 Sep 2023 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694439932; x=1695044732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKJwEN0Dy86pNFLq9byT1XW/Xw47waFHpHmeiDZLDec=;
        b=Zh0p+gBiJwd/xnu/hxGJ+LNbw3lybcX/ofKbQ6Udp/vzpTh2BrfSKs112cfqVtovqt
         /oEJUPsbuIuEyLTEdjftCAXRePFnvZi5aBNIkckpR5Vy0iwqp6k2B3LjUJ6+jwy/cbeg
         FMxJwpje5G9VS4qMfbOgswI38ylXR3jGXTm5AT0JnSw2oaAzVB0PqHfo9yPjRTHzAR/S
         G7exmovAqKeHWdfWwnkv/vfsaN/D2Sx5luXhwEqkH0T+cePl0taBW9LbDw6qMOgq3IF1
         bsO/2w5ESNGR4wiBPKGNW/2+V3bUnWontGCeqv9xPDmBvC4IbNPk7ys8N+UvfZiQTtRI
         Ncgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439932; x=1695044732;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKJwEN0Dy86pNFLq9byT1XW/Xw47waFHpHmeiDZLDec=;
        b=irSeLEmrT2JO81mpamf9duJtkBMgYPhVOFVfMjlAjAnGZ7ZF9cSMYDrgF1Z8L2IsXr
         JoucWg7vY9kqaInhfje9cXLLKBfAYhScsjIkcF1ZfPYWqCtrGWHacYoMQ/SerkDwTUzY
         x2bjb0DrU9+MW7RQ2HBvhnXEa3P8vVURPLEV09Fuk9VEQT8Tyaat0zZXAGXeNDeX8qoJ
         LnBsCICEzVjcGjl6XH9dQ4aGxVzj345Mk4NjlmUnrfs1lVinEphpWtRB1cjBfIus5V9k
         canrTn+d49QezYRw9bXjbUV7LrPsd4UD19HAik5HxuiqbbLi6wAR31jZ3xJ5PtxHuM7/
         RflQ==
X-Gm-Message-State: AOJu0YxG7sQ6qcp2/TmeBxzW2ljYiqXDdsirbClbhqYSATdvvoCeXzNi
        FMEoFX4RjZ0h/RhrkROG8N8=
X-Google-Smtp-Source: AGHT+IHPUmJFFBMzEXX/iaqAP/rP4wR95WVsaLY1NQ3O8AaXhg3AUOqurvk/ju49JPlt1ptnFpU50g==
X-Received: by 2002:a05:6a00:1496:b0:68c:69c8:e0f0 with SMTP id v22-20020a056a00149600b0068c69c8e0f0mr11646291pfu.18.1694439932348;
        Mon, 11 Sep 2023 06:45:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cl10-20020a056a0032ca00b0068fd026b496sm1155551pfb.46.2023.09.11.06.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:45:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <27bc5a74-531d-696e-f218-a755172af9e9@roeck-us.net>
Date:   Mon, 11 Sep 2023 06:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230911083735.11795-1-daniel.matyas@analog.com>
 <20230911083735.11795-2-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: max31827: Functional enhancement of the driver
In-Reply-To: <20230911083735.11795-2-daniel.matyas@analog.com>
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

On 9/11/23 01:37, Daniel Matyas wrote:
> Modify some bits depending on the device tree.
> 

The subject and the above sentence are meaningless. Please improve.

> Added custom device attributes for resolution and timeout. The wait time
> for a conversion in one-shot mode (enable = 0) depends on the
> resolution.
> 
> Used enums and static const arrays in order to remove nested switch
> blocks.
> 

One logical change per patch, please. Do not mix no-trivial cleanups
with functional changes.

> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>   Documentation/hwmon/max31827.rst |  65 ++++--
>   drivers/hwmon/max31827.c         | 326 ++++++++++++++++++++++++-------
>   2 files changed, 306 insertions(+), 85 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index b0971d05b8a4..ae884e9e6085 100644
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
> @@ -68,13 +76,32 @@ clear the status bits before changing the operating mode.
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
> -the resolution. The conversion time doubles with every bit of increased
> -resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
> -(default) 140ms. When chip is in shutdown mode and a read operation is
> -requested, one-shot is triggered, the device waits for 140 (conversion time) + 1
> -(error) ms, and only after that is the temperature value register read.
> +the resolution.
> +
> +The conversion time doubles with every bit of increased resolution. The
> +available resolutions are:
> +	- 8 bit -> 8.75 ms conversion time
> +	- 9 bit -> 17.5 ms conversion time
> +	- 10 bit -> 35 ms conversion time
> +	- 12 bit (default) -> 140 ms conversion time
> +
> +When chip is in shutdown mode and a read operation is requested, one-shot is
> +triggered, the device waits for <conversion time> ms, and only after that is
> +the temperature value register read. Note that the conversion times are rounded
> +up to the nearest possible integer.
>   
>   The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
>   the temperatures are displayed in milli-degrees. This means, that some data is
> @@ -83,8 +110,18 @@ in the writing of alarm values too. For positive numbers the user-input value
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
> +PEC is not implemented.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index 66f5fcf937ff..9f48dec99b7f 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -12,6 +12,18 @@
>   #include <linux/i2c.h>
>   #include <linux/mutex.h>
>   #include <linux/regmap.h>
> +#include <linux/hwmon-sysfs.h>
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
>   #define MAX31827_T_REG	0x0
>   #define MAX31827_CONFIGURATION_REG	0x2
> @@ -22,22 +34,120 @@
>   
>   #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>   #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
> +#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
> +#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> +#define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
> +#define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
>   #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
>   #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
>   
> -#define MAX31827_12_BIT_CNV_TIME	141
> -
> -#define MAX31827_CNV_1_DIV_64_HZ	0x1
> -#define MAX31827_CNV_1_DIV_32_HZ	0x2
> -#define MAX31827_CNV_1_DIV_16_HZ	0x3
> -#define MAX31827_CNV_1_DIV_4_HZ		0x4
> -#define MAX31827_CNV_1_HZ	0x5
> -#define MAX31827_CNV_4_HZ	0x6
> -#define MAX31827_CNV_8_HZ	0x7
> +#define MAX31827_8_BIT_CNV_TIME		9
> +#define MAX31827_9_BIT_CNV_TIME		18
> +#define MAX31827_10_BIT_CNV_TIME	35
> +#define MAX31827_12_BIT_CNV_TIME	140
>   
>   #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
>   #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
>   #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
> +#define MAX31827_FLT_Q
> +
> +enum max31827_cnv {
> +	MAX31827_CNV_1_DIV_64_HZ = 1,
> +	MAX31827_CNV_1_DIV_32_HZ,
> +	MAX31827_CNV_1_DIV_16_HZ,
> +	MAX31827_CNV_1_DIV_4_HZ,
> +	MAX31827_CNV_1_HZ,
> +	MAX31827_CNV_4_HZ,
> +	MAX31827_CNV_8_HZ,
> +};
> +
> +static const u16 max31827_conversions[] = {
> +	[MAX31827_CNV_1_DIV_64_HZ] = 64000,
> +	[MAX31827_CNV_1_DIV_32_HZ] = 32000,
> +	[MAX31827_CNV_1_DIV_16_HZ] = 16000,
> +	[MAX31827_CNV_1_DIV_4_HZ] = 4000,
> +	[MAX31827_CNV_1_HZ] = 1000,
> +	[MAX31827_CNV_4_HZ] = 250,
> +	[MAX31827_CNV_8_HZ] = 125,
> +};
> +
> +enum max31827_resolution {
> +	MAX31827_RES_8_BIT = 0,
> +	MAX31827_RES_9_BIT,
> +	MAX31827_RES_10_BIT,
> +	MAX31827_RES_12_BIT,
> +};
> +
> +static const u16 max31827_resolutions[] = {
> +	[MAX31827_RES_8_BIT] = 8,
> +	[MAX31827_RES_9_BIT] = 9,
> +	[MAX31827_RES_10_BIT] = 10,
> +	[MAX31827_RES_12_BIT] = 12,
> +};
> +
> +enum cfg_index {
> +	cfg_timeout_idx = 0,
> +	cfg_res_idx,
> +	cfg_num
> +};
> +
> +static const unsigned int cfg_masks[cfg_num] = {
> +	[cfg_timeout_idx] = MAX31827_CONFIGURATION_TIMEOUT_MASK,
> +	[cfg_res_idx] = MAX31827_CONFIGURATION_RESOLUTION_MASK,
> +};
> +
> +enum max31827_cnv {
> +	MAX31827_CNV_1_DIV_64_HZ = 1,
> +	MAX31827_CNV_1_DIV_32_HZ,
> +	MAX31827_CNV_1_DIV_16_HZ,
> +	MAX31827_CNV_1_DIV_4_HZ,
> +	MAX31827_CNV_1_HZ,
> +	MAX31827_CNV_4_HZ,
> +	MAX31827_CNV_8_HZ,
> +};
> +
> +static const u16 max31827_conversions[] = {
> +	[MAX31827_CNV_1_DIV_64_HZ] = 64000,
> +	[MAX31827_CNV_1_DIV_32_HZ] = 32000,
> +	[MAX31827_CNV_1_DIV_16_HZ] = 16000,
> +	[MAX31827_CNV_1_DIV_4_HZ] = 4000,
> +	[MAX31827_CNV_1_HZ] = 1000,
> +	[MAX31827_CNV_4_HZ] = 250,
> +	[MAX31827_CNV_8_HZ] = 125,
> +};
> +
> +enum max31827_resolution {
> +	MAX31827_RES_8_BIT = 0,
> +	MAX31827_RES_9_BIT,
> +	MAX31827_RES_10_BIT,
> +	MAX31827_RES_12_BIT,
> +};
> +
> +static const u16 max31827_resolutions[] = {
> +	[MAX31827_RES_8_BIT] = 8,
> +	[MAX31827_RES_9_BIT] = 9,
> +	[MAX31827_RES_10_BIT] = 10,
> +	[MAX31827_RES_12_BIT] = 12,
> +};
> +
> +static const u16 max31827_conv_times[] = {
> +	[MAX31827_RES_8_BIT] = MAX31827_8_BIT_CNV_TIME,
> +	[MAX31827_RES_9_BIT] = MAX31827_9_BIT_CNV_TIME,
> +	[MAX31827_RES_10_BIT] = MAX31827_10_BIT_CNV_TIME,
> +	[MAX31827_RES_12_BIT] = MAX31827_12_BIT_CNV_TIME,
> +};
> +
> +enum cfg_index {
> +	cfg_timeout_idx = 0,
> +	cfg_res_idx,
> +	cfg_num
> +};
> +
> +static const unsigned int cfg_masks[cfg_num] = {
> +	[cfg_timeout_idx] = MAX31827_CONFIGURATION_TIMEOUT_MASK,
> +	[cfg_res_idx] = MAX31827_CONFIGURATION_RESOLUTION_MASK,
> +};
>   
>   struct max31827_state {
>   	/*
> @@ -46,6 +156,7 @@ struct max31827_state {
>   	struct mutex lock;
>   	struct regmap *regmap;
>   	bool enable;
> +	unsigned int resolution;
>   };
>   
>   static const struct regmap_config max31827_regmap = {
> @@ -166,8 +277,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   					mutex_unlock(&st->lock);
>   					return ret;
>   				}
> -
> -				msleep(MAX31827_12_BIT_CNV_TIME);
> +				msleep(max31827_conv_times[st->resolution]);
>   			}
>   			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
>   
> @@ -243,32 +353,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
>   
>   			uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
>   					 uval);
> -			switch (uval) {
> -			case MAX31827_CNV_1_DIV_64_HZ:
> -				*val = 64000;
> -				break;
> -			case MAX31827_CNV_1_DIV_32_HZ:
> -				*val = 32000;
> -				break;
> -			case MAX31827_CNV_1_DIV_16_HZ:
> -				*val = 16000;
> -				break;
> -			case MAX31827_CNV_1_DIV_4_HZ:
> -				*val = 4000;
> -				break;
> -			case MAX31827_CNV_1_HZ:
> -				*val = 1000;
> -				break;
> -			case MAX31827_CNV_4_HZ:
> -				*val = 250;
> -				break;
> -			case MAX31827_CNV_8_HZ:
> -				*val = 125;
> -				break;
> -			default:
> -				*val = 0;
> -				break;
> -			}
> +			*val = max31827_conversions[uval];
>   		}
>   		break;
>   
> @@ -284,6 +369,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			  u32 attr, int channel, long val)
>   {
>   	struct max31827_state *st = dev_get_drvdata(dev);
> +	int res = 1;
>   	int ret;
>   
>   	switch (type) {
> @@ -333,39 +419,27 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			if (!st->enable)
>   				return -EOPNOTSUPP;
>   
> -			switch (val) {
> -			case 125:
> -				val = MAX31827_CNV_8_HZ;
> -				break;
> -			case 250:
> -				val = MAX31827_CNV_4_HZ;
> -				break;
> -			case 1000:
> -				val = MAX31827_CNV_1_HZ;
> -				break;
> -			case 4000:
> -				val = MAX31827_CNV_1_DIV_4_HZ;
> -				break;
> -			case 16000:
> -				val = MAX31827_CNV_1_DIV_16_HZ;
> -				break;
> -			case 32000:
> -				val = MAX31827_CNV_1_DIV_32_HZ;
> -				break;
> -			case 64000:
> -				val = MAX31827_CNV_1_DIV_64_HZ;
> -				break;
> -			default:
> +			/*
> +			 * Convert the desired conversion rate into register
> +			 * bits. res is already initialized with 1.
> +			 *
> +			 * This was inspired by lm73 driver.
> +			 */
> +			while (res < ARRAY_SIZE(max31827_conversions) &&
> +			       val < max31827_conversions[res])
> +				res++;
> +
> +			if (res == ARRAY_SIZE(max31827_conversions) ||
> +			    val != max31827_conversions[res])
>   				return -EOPNOTSUPP;
> -			}
>   
> -			val = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -					 val);
> +			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +					 res);
>   
>   			return regmap_update_bits(st->regmap,
>   						  MAX31827_CONFIGURATION_REG,
>   						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -						  val);
> +						  res);
>   		}
>   		break;
>   
> @@ -376,14 +450,121 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   	return -EOPNOTSUPP;
>   }
>   
> -static int max31827_init_client(struct max31827_state *st)
> +static ssize_t cfg_show(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
>   {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	const unsigned int mask = cfg_masks[attr->index];
> +	unsigned int val, res;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
> +	/*
> +	 * FIELD_GET did not work because mask is not a compile time constant.
> +	 * There is no bitfield check now.
> +	 */
> +	val = (val & mask) >> max31827__bf_shf(mask);
> +
> +	if (attr->index == cfg_res_idx)
> +		res = max31827_resolutions[val];
> +	else
> +		res = !val;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", res);
> +}
> +
> +static ssize_t cfg_store(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	const unsigned int mask = cfg_masks[attr->index];
> +	unsigned int res = 0;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (attr->index == cfg_res_idx) {
> +		/*
> +		 * Convert the desired conversion rate into register
> +		 * bits. res is already initialized with 1.
> +		 *
> +		 * This was inspired by lm73 driver.
> +		 */
> +		while (res < ARRAY_SIZE(max31827_resolutions) &&
> +		       val > max31827_resolutions[res])
> +			res++;
> +
> +		if (res == ARRAY_SIZE(max31827_resolutions) ||
> +		    val != max31827_resolutions[res])
> +			return -EOPNOTSUPP;
> +
> +		st->resolution = res;
> +	} else {
> +		res = !val;
> +	}
> +
> +	/*
> +	 * FIELD_PREP did not work because mask is not a compile time constant.
> +	 * There is no bitfield check now.
> +	 */
> +	res = (res << max31827__bf_shf(mask)) & mask;
> +	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +				 cfg_masks[attr->index], res);
> +
> +	return (ret) ? ret : count;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RW(cfg_resolution, cfg, cfg_res_idx);
> +static SENSOR_DEVICE_ATTR_RW(cfg_timeout, cfg, cfg_timeout_idx);
> +
> +static struct attribute *max31827_attrs[] = {
> +	&sensor_dev_attr_cfg_resolution.dev_attr.attr,
> +	&sensor_dev_attr_cfg_timeout.dev_attr.attr,


Those attributes are not acceptable. First of all, the cfg_ prefix is useless.
The timeout is system related and should be a devicetree property.
The resolution maps into the number of conversions per second,
and therefore the standard update_interval property can be used.

Guenter

> +	NULL
> +};
> +ATTRIBUTE_GROUPS(max31827);
> +
> +static int max31827_init_client(struct max31827_state *st,
> +				struct fwnode_handle *fwnode)
> +{
> +	bool comp_int, alrm_pol;
> +	u32 flt_q, lsb_idx;
> +	unsigned int res = 0;
> +	int ret;
> +
>   	st->enable = true;
> +	res |= MAX31827_DEVICE_ENABLE(1);
> +
> +	st->resolution = MAX31827_RES_12_BIT;
> +	res |= MAX31827_CONFIGURATION_RESOLUTION_MASK;
>   
> -	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> -				  MAX31827_CONFIGURATION_1SHOT_MASK |
> -					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> -				  MAX31827_DEVICE_ENABLE(1));
> +	comp_int = fwnode_property_read_bool(fwnode, "adi,comp-int");
> +	res |= FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, comp_int);
> +
> +	alrm_pol = fwnode_property_read_bool(fwnode, "adi,alrm-pol");
> +	res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, alrm_pol);
> +
> +	ret = fwnode_property_read_u32(fwnode, "adi,flt-q", &flt_q);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Convert the desired fault queue into register bits.
> +	 */
> +	lsb_idx = max31827__bf_shf(flt_q);
> +	if (lsb_idx > 3 || flt_q != BIT(lsb_idx)) {
> +		pr_err("max31827: Invalid data in fault queue\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
> +
> +	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
>   }
>   
>   static const struct hwmon_channel_info *max31827_info[] = {
> @@ -411,6 +592,7 @@ static int max31827_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct max31827_state *st;
> +	struct fwnode_handle *fwnode;
>   	int err;
>   
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> @@ -427,13 +609,15 @@ static int max31827_probe(struct i2c_client *client)
>   		return dev_err_probe(dev, PTR_ERR(st->regmap),
>   				     "Failed to allocate regmap.\n");
>   
> -	err = max31827_init_client(st);
> +	fwnode = dev_fwnode(dev);
> +
> +	err = max31827_init_client(st, fwnode);
>   	if (err)
>   		return err;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
>   							 &max31827_chip_info,
> -							 NULL);
> +							 max31827_groups);
>   
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }

