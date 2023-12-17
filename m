Return-Path: <linux-kernel+bounces-2480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB1815DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1C1283843
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD41851;
	Sun, 17 Dec 2023 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJnRGfAX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58917E6;
	Sun, 17 Dec 2023 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7c5cb5eeab1so569119241.3;
        Sat, 16 Dec 2023 22:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702793167; x=1703397967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QCc4fkhc+oDJ/r5+AQtqwzG8eeBYVzNEuSyvoV+hHGc=;
        b=CJnRGfAXZowqZX0qdhA1Um9BHuDJWOLOX2ik3ScKt2RArDdbo2+unJD8zB3hmGM9YM
         JIDfRPzaYn0QrnNwwHdVOzcKBjE4pdI4ECJ8doAVKlsGb1OhGcvX7BU7CFUVL6DPfQ+A
         t2SVYqoVVPOxx4pCc/87+uKXBRdxkfF7hdG4PvsdLgNEmWVBWKFVyTwVhhSTfI9Zwh01
         jwmqwBi9oQ9CYYixSj2k05rhUglUdEsNoY6jK6ARnMpWDbXViv+lujdXFasAHvCfsWKL
         N37F/x5xkVuqlN0cZN0zzDoptI0kvKYQM8s1O78ME25Y00nsRHDyEoY2xnw3ykkobeGa
         lRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702793167; x=1703397967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCc4fkhc+oDJ/r5+AQtqwzG8eeBYVzNEuSyvoV+hHGc=;
        b=iedMsDnl9yp2MXTcVPuefBfA4SR0u7/lszqccB0Q78kMDpKdFqwo5kCQiRGZwbrTIa
         3/rJe7VillAT0LJHZiTI2ehbQUYF1PqTDb89Ao1IB4uXtGgyL4Cq/UN7O8O9hY5fxJfI
         RjWbpbjbUBYOvgIXRvwAsoGve0AT5InGxqJiT1a+/8h7IZZ45eTAmYO42hgGu0InE7s3
         vwkvbCib/Op+x0J1cFhykoVGvYcTN8k0ATsYBApZcHrLHeN+d/iqXJqOss0lTvkOgYyu
         1BZyo1cP6+Obbedwcr1ZZINZ9Vr4I0vwNkE3Q7hmeB+CKlfJpzkkquKT5t/joC/hbBHb
         Ul2Q==
X-Gm-Message-State: AOJu0Yw/z/AOkw+XnQ4WlgHZUHqmIjh59pYXqx90ZD48OJgpLeLB2bGR
	so5zPNsGGaUcAj9iOCowTkA=
X-Google-Smtp-Source: AGHT+IHObFZGtYtsx1n/ZyWuij7h+owC/JJOBkt/yYYU/U/C3H5BnxtvBv2Kqhfjvtj/i1GJRt89rA==
X-Received: by 2002:a05:6102:cc8:b0:464:3c0a:fdd4 with SMTP id g8-20020a0561020cc800b004643c0afdd4mr10957968vst.2.1702793166617;
        Sat, 16 Dec 2023 22:06:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f28-20020a056102151c00b004666fa3fb6bsm364508vsv.0.2023.12.16.22.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 22:06:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fbcceae6-2daf-4855-b8f2-f7a832a53339@roeck-us.net>
Date: Sat, 16 Dec 2023 22:06:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Content-Language: en-US
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
 <aa93010a-7ab0-4b9d-bb5d-25ea15b81120@roeck-us.net> <ZX4frjGqOGb4zMmx@abdel>
 <c606c40b-8571-4618-827a-555ceab3ae74@roeck-us.net> <ZX6AQg1vz/Zz6JeG@abdel>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZX6AQg1vz/Zz6JeG@abdel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 20:59, Abdel Alkuor wrote:
> On Sat, Dec 16, 2023 at 05:40:35PM -0800, Guenter Roeck wrote:
>> On 12/16/23 14:07, Abdel Alkuor wrote:
>>> On Sat, Dec 16, 2023 at 10:46:53AM -0800, Guenter Roeck wrote:
>>>> On 12/16/23 08:39, Abdel Alkuor wrote:
>>> Should I use tmp112 params for as6200?
>>>
>>
>> Sure, or just add a separate entry for as6200.
>>
> I think some modifications need to be done regarding setting the default
> configuration for chips with config reg of 16 bits.
> 
> Currently, tmp112 set_mask and clr_mask look like this
> 
>     [tmp112] = {
>     	 .set_mask = 3 << 5,	/* 8 samples / second */
>     	 .clr_mask = 1 << 7,	/* no one-shot mode*/
>     	 ...
>     }
> 
> and in probe function, we are using i2c_smbus_read_byte_data which
> basically reads byte 1 of tmp112 config reg and in lm75_write_config
> it writes byte 1 of tmp112 config reg. Now based on tmp112 set_mask,
> we want to set the sample rate but we actually setting R0 and R1 instead.
> According to tmp112 datasheet on pg. 16, byte 1 is written first then
> byte 2, where byte 2 has the conversion rate at bit 6 and 7 (CR0/CR1).
> 
> tmp112 datasheet: https://www.ti.com/lit/ds/symlink/tmp112.pdf?ts=1702713491401&ref_url=https%253A%252F%252Fwww.google.com%252F
> 
> Now, to accommodate 16 bit config register read/write, something along these lines can
> be done:
> - In struct lm75_params,
>    - change set_mask and clr_mask from u8 to u16
>    - Add config reg two bytes size flag
> - Use the proper function to read the config reg based on config reg size i.e
>    For one byte config reg, use i2c_smbus_read_byte_data, and for 2 bytes
>    config reg, use regmap_read.
> 
>    static int lm75_probe(struct i2c_client *client)
>    {
>     	...
> 	if (data->params->config_reg_16bits)
>    		status = regmap_read(client, LM75_REG_CONF, &regval);
> 		if (status < 0) {
> 			dev_dbg(dev, "Can't read config? %d\n", status);
> 			return status;
> 		}
> 		data->orig_conf = regval;
> 		data->current_conf = regval;
> 	} else {
>    		status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
> 		if (status < 0) {
> 			dev_dbg(dev, "Can't read config? %d\n", status);
> 			return status;
> 		}
> 		data->orig_conf = status;
> 		data->current_conf = status;
> 	}
> 	...
>     }
> 
>     static int lm75_write_config(struct lm75_data *data, u16 set_mask,
>     			     u16 clr_mask)
>     {
>       
>       if (data->params->config_reg_16bits)
>       	clr_mask |= LM75_SHUTDOWN << 8;
>       else
>       	clr_mask |= LM75_SHUTDOWN;
>       ...
>       	if (data->params->config_reg_16bits)
>       		err = regmap_write(data->regmap, LM75_REG_CONF, value);
>       	else
>       		err = i2c_smbus_write_byte_data(data->client,
>       			       			LM75_REG_CONF,
>       						value);
>       ...
>     }
> 
> Based on that, the new tmp112 set_mask and clr_mask would look like this instead,
>    [tmp112] = {
>    	.set_mask = 3 << 6,	/* 8 samples / second */
>    	.clr_mask = 1 << 15,	/* no one-shot mode*/
> 	.config_reg_16bits = 1,
>    	...
>    }
> 

Yes, you are correct, we'll need something like that. lm75_update_interval()
tries to solve the problem for tmp112, but that doesn't work with
set_mask/clear_mask. We should have a separate function lm75_read_config(),
though, to hide the complexity.

Thanks,
Guenter



