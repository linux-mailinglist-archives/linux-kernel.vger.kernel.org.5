Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF27A2AFB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjIOX0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjIOX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:26:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490F1FE0;
        Fri, 15 Sep 2023 16:26:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79536bc6697so93107839f.1;
        Fri, 15 Sep 2023 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694820367; x=1695425167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VveHYG4t+Sx71RsJ49uoEqzBEzyROBRkGjZT0OajziQ=;
        b=REhjnIxBkYrZH9BK/pNDgzZvKYwEZJMN9EbFj2kaq9b7rwO6Ut9AVlBZQ82jjfgG6S
         iz8JWY9MjH46i1exAh8KG3QDadORWviEnzxwZiqecOsnSAPnC/xo+CwD9WwZlpx0KAn3
         EJp2vXlbv9sY8plo07oH6H/MYgSF3piyct+6yMmfwkxnJ3yM3TrqIie8/Vji5jqBa8Fp
         i0EJ/vBntlxwq+gINoiTAzRQSSqhSVeSu856TsLfm0jHTdCLM2uf9NYJILL58IZ6TRz7
         ZRL/R4ORUTwFzizl69kgzodVXpvyvJnzv8UIi2rftRsJc8LvqOzL5Lg7viBsFlHEEGkS
         wSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694820367; x=1695425167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VveHYG4t+Sx71RsJ49uoEqzBEzyROBRkGjZT0OajziQ=;
        b=b2ch7A39HRYtV2bgRi+wux3EdyBXGjffaKPiKf/8wt9JyvsjHRl5Y5qqwkMCpvn0j1
         qj92ysvw5kVl1WdQ/Dgxpj0sTsUUCm5pwcAPdE+OepOSKVMMaMJyUE4gRlYQIzehW2YS
         tAxqUiBSZuNH0bIAPYlKB0xhfKY7luqf2mubp+xiCanAzRPF0iM1qsCXzAgIgQAcvB4L
         HE3uNx11ahsbtfX6UhHQDrbI5gCjZg597ql58E7TBnWzIXIDKW4KdvHUY+gTd427ZRze
         LNZLUOCFMlyQXjPUd/8B4gUXIlMXXyITuY0Gq+IVxgzTXVGBX/RPv8gOnl8eCTxtoAtP
         XioQ==
X-Gm-Message-State: AOJu0YyqTcx8ulxF+cRDtVW3UeisuMTWiWClIL8W+3fVelUh/JkpALj+
        3C11qSh1zZ+Kb2DjpHz4m4Q=
X-Google-Smtp-Source: AGHT+IH7cvbGJLUli9sUi4RsxsbXBXezLfY6sKB0FuM1UIIbvYyqaLF/F4P3ivWVXeOm6baUGDlU1g==
X-Received: by 2002:a5d:9c46:0:b0:794:e11c:d8c3 with SMTP id 6-20020a5d9c46000000b00794e11cd8c3mr3548695iof.16.1694820366928;
        Fri, 15 Sep 2023 16:26:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24-20020a02ab98000000b004312e5c9b0dsm1286277jan.139.2023.09.15.16.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 16:26:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <44e84cb8-b573-0e1a-91e5-cdee0441d0f9@roeck-us.net>
Date:   Fri, 15 Sep 2023 16:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/5] hwmon: max31827: Make code cleaner
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230914075948.208046-1-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230914075948.208046-1-daniel.matyas@analog.com>
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

On 9/14/23 00:59, Daniel Matyas wrote:
> Now the wait time for one-shot is 140ms, instead of the old 141
> (removed the 1ms error).
> 

It was explicitly documented that the wait time was 140 + 1 milli-seconds,
presumably to be sure that the conversion is really complete.

Why was this an error ? It was _documented_ that way.

Guenter

> Used enums and while loops to replace switch for selecting and getting
> update interval from conversion rate bits.
> 
> Divided the write_alarm_val function into 2 functions. The new function
> is more generic: it can be used not only for alarm writes, but for any
> kind of writes which require the device to be in shutdown mode.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
> 
> v2 -> v3: No change.
> 
> v2: Added patch.
> 
>   Documentation/hwmon/max31827.rst |   4 +-
>   drivers/hwmon/max31827.c         | 127 ++++++++++++++-----------------
>   2 files changed, 58 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index b0971d05b8a4..9a1055a007cf 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -73,8 +73,8 @@ the conversion frequency to 1 conv/s. The conversion time varies depending on
>   the resolution. The conversion time doubles with every bit of increased
>   resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
>   (default) 140ms. When chip is in shutdown mode and a read operation is
> -requested, one-shot is triggered, the device waits for 140 (conversion time) + 1
> -(error) ms, and only after that is the temperature value register read.
> +requested, one-shot is triggered, the device waits for 140 (conversion time) ms,
> +and only after that is the temperature value register read.
>   
>   The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
>   the temperatures are displayed in milli-degrees. This means, that some data is
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index 602f4e4f81ff..f05762219995 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -25,20 +25,32 @@
>   #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
>   #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
>   
> -#define MAX31827_12_BIT_CNV_TIME	141
> -
> -#define MAX31827_CNV_1_DIV_64_HZ	0x1
> -#define MAX31827_CNV_1_DIV_32_HZ	0x2
> -#define MAX31827_CNV_1_DIV_16_HZ	0x3
> -#define MAX31827_CNV_1_DIV_4_HZ		0x4
> -#define MAX31827_CNV_1_HZ		0x5
> -#define MAX31827_CNV_4_HZ		0x6
> -#define MAX31827_CNV_8_HZ		0x7
> +#define MAX31827_12_BIT_CNV_TIME	140
>   
>   #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
>   #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
>   #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
>   
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
>   struct max31827_state {
>   	/*
>   	 * Prevent simultaneous access to the i2c client.
> @@ -54,15 +66,13 @@ static const struct regmap_config max31827_regmap = {
>   	.max_register = 0xA,
>   };
>   
> -static int write_alarm_val(struct max31827_state *st, unsigned int reg,
> -			   long val)
> +static int shutdown_write(struct max31827_state *st, unsigned int reg,
> +			  unsigned int val)
>   {
>   	unsigned int cfg;
> -	unsigned int tmp;
> +	unsigned int cnv_rate;
>   	int ret;
>   
> -	val = MAX31827_M_DGR_TO_16_BIT(val);
> -
>   	/*
>   	 * Before the Temperature Threshold Alarm and Alarm Hysteresis Threshold
>   	 * register values are changed over I2C, the part must be in shutdown
> @@ -82,9 +92,10 @@ static int write_alarm_val(struct max31827_state *st, unsigned int reg,
>   	if (ret)
>   		goto unlock;
>   
> -	tmp = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
> +	cnv_rate = MAX31827_CONFIGURATION_CNV_RATE_MASK & cfg;
> +	cfg = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
>   		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
> -	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, tmp);
> +	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
>   	if (ret)
>   		goto unlock;
>   
> @@ -92,13 +103,23 @@ static int write_alarm_val(struct max31827_state *st, unsigned int reg,
>   	if (ret)
>   		goto unlock;
>   
> -	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
> +	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +				 cnv_rate);
>   
>   unlock:
>   	mutex_unlock(&st->lock);
>   	return ret;
>   }
>   
> +static int write_alarm_val(struct max31827_state *st, unsigned int reg,
> +			   long val)
> +{
> +	val = MAX31827_M_DGR_TO_16_BIT(val);
> +
> +	return shutdown_write(st, reg, val);
> +}
> +
>   static umode_t max31827_is_visible(const void *state,
>   				   enum hwmon_sensor_types type, u32 attr,
>   				   int channel)
> @@ -243,32 +264,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
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
> @@ -284,6 +280,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			  u32 attr, int channel, long val)
>   {
>   	struct max31827_state *st = dev_get_drvdata(dev);
> +	int res = 1;
>   	int ret;
>   
>   	switch (type) {
> @@ -333,39 +330,27 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
>   			if (!st->enable)
>   				return -EINVAL;
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
> -				return -EINVAL;
> -			}
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
> +				return -EOPNOTSUPP;
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

