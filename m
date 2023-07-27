Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC6765602
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjG0ObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjG0Oa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:30:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34E2D42;
        Thu, 27 Jul 2023 07:30:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbdc05a93bso5364435ad.0;
        Thu, 27 Jul 2023 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468258; x=1691073058;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yjq9/74+fd3FNAG1SVAL1aAvZ3EGzRY6BxDlYY3Aykw=;
        b=U615EZINP7qeK40Qv7KXvEypIC4lDuZ76QXYZDla/y3FXHB5ooFeJvKvPDLGhTyrpM
         corOEA6p0wnbFxiRt6P8Z8vUoLimKpRVfM6+TO7KxjkqGZgnudFCUZf0ylR0XZLQNm0I
         Ng3RepEI8VMNfzPElrEueTbcdBMZbCrM1QisLj8gX9qL32AQxgHOm1N7Fo4boUT4R0EK
         EB1pea9bsy/2x0iXA+l5ntC9WOR/JazNfznbFJvKu4n14xaFbA45I6gja7cal7kaZvNP
         ZJ8ZMomcW5mY02JoXtCDxSD9/uL+9FAEhgt8tDCBrvChh1Scns4g0EGVkwTNkFrnjBa5
         Xrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468258; x=1691073058;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjq9/74+fd3FNAG1SVAL1aAvZ3EGzRY6BxDlYY3Aykw=;
        b=R9SCqBLR+pUA7lf2Qo2QyYoC4QcfsZ+N4IGXdCcww1E0uI418R2BtpmT6A/CMVvFSB
         forHTlJTf6clQWlc6VWQ5Xfy5n+eMF6wYCt6yrmjUlShjVKuJ70/mpa/BOGDMR7pd1LL
         tXsPmkBIjWyOtdypoKUMzu6KZX/HuvV+GwGHfUfptxmbUsh0RRrntXFJPn/gmK3XzMGP
         yaRtyifvn8kFcXOHyCafaA/nQyBQYJFZHM+KUqWOgm0/kZTNQOcoAoOB1w7Tpw0erVHK
         wcnuMB1qnDWy4As3X+x6lDMpTCH8O1+vZxIpIS+25NsWAbyf3HJTSD5X+rMspB9Q3LXq
         NSSA==
X-Gm-Message-State: ABy/qLb8lGdt6gFWkkeqHqSZEn11sFTdpso8GGhou1Xyu/7y78wrZCqA
        DyILxeEQtv/vz8n12CWoJX9EUsydhQg=
X-Google-Smtp-Source: APBJJlHWXbGSaSuQ6uzcnTrwIvVyWiNvuPXadSXul7PKZfnOeuOGcQF0MCWZY3MxfhZWvkvfRrcxeA==
X-Received: by 2002:a17:902:da8a:b0:1b3:fb76:215b with SMTP id j10-20020a170902da8a00b001b3fb76215bmr5966191plx.48.1690468257821;
        Thu, 27 Jul 2023 07:30:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001bb9f104328sm1711209plc.146.2023.07.27.07.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:30:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <71c9d96f-d815-7cf4-927b-76af44fdd3e0@roeck-us.net>
Date:   Thu, 27 Jul 2023 07:30:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-2-mail@carsten-spiess.de>
 <206ad774-bf6f-aed3-81a7-3d9c8f80a69e@roeck-us.net>
 <20230727093536.4cd2f84f.mail@carsten-spiess.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
In-Reply-To: <20230727093536.4cd2f84f.mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 00:35, Carsten Spieß wrote:
> 
> On 7/26/23 18:14, Gueter Roeck wrote:
>> On 7/26/23 08:22, Carsten Spieß wrote:
>>> +The shunt value in micro-ohms, shunt gain and averaging can be set
>>> +via device tree at compile-time.
>>
>> At _compile-time_ ?
> How to explain better that it isn't set at runtime?
> Other drivers use the same term.

You mean it is ok to exceed the speed limit because others do it
as well ?

[ Sorry, I have heard the "Other drivers do it" pseudo-argument too many times.
   That doesn't mean it is the right thing to do. ]

Why not just leave it off ? What value does it add ? Besides,
even "via devicetree" isn't really correct because it can also
be set via ACPI or by a platform driver when using device_ properties.
I would suggest "can be set with device properties".

> 
>> I'd argue that shunt voltage is all but useless, but if you want to have it supported
>> it _has_ to be in mV.
> That's a problem.
> 
> In my case the ER-6P has a 8 milli Ohm (or 8000 micro Ohm) shunt and a powersupply with
> max. 2.5 A. This gives a max shunt voltage of 20 mV at 2.5 A.
> The device normaly consumes between 200 and 500 mA. (typ ~250 mA).
> This results in shunt voltage of 1.6 to 4.0 mV (typ ~2mV).
> Having no fractions will make it useless.
> 
> Unfortunately there is no possibility to give a scaling factor.
> Or returning float values (i know, this can't and shouldn't be changed)
> 

Just like the ABI must not be changed. The sensors command would display your
4mV shunt voltage as 4V, which is just as useless.

In practice, the shunt voltage _is_ useless for hardware monitoring purpose
because it can be calculated from current and shunt resistor value.
I'd say if you really want it, provide it as debugfs attribute. As hwmon
attribute it has to be in mV.

>> Why not support limit attributes ?
> Due to limited time, left for later enhancement.
> 
> 
>>> +#define ISL28022_REG_SHUNT	0x01
>>> +#define ISL28022_REG_BUS	0x02
> 
> 
>>> +	switch (type) {
>>> +	case hwmon_in:
>>> +		switch (attr) {
>>> +		case hwmon_in_input:
>>> +			err = regmap_read(data->regmap,
>>> +					  ISL28022_REG_SHUNT + channel, &regval);
>>
>> That never reads REG_BUS.
> Hmm,
> channel 0: ISL28022_REG_SHUNT + 0 == 0x01
> channel 1: ISL28022_REG_SHUNT + 1 == 0x02 == ISL28022_REG_BUS
> or do i miss something?
> 

No, I missed the "+ channel".

>>> +			if (err < 0)
>>> +				return err;
>>> +			*val = (channel == 0) ?
>>> +					(long)((s16)((u16)regval)) * 10 :
>>> +					(long)(((u16)regval) & 0xFFFC);
>>
>> I don't think the sign extensions are correct based on the datasheet.
>> This will have to use sign_extend.
>  From my understading (see table 11 on page 16 of the ISL28022 datasheet)
> shunt value is already sign extended, (D15-D12 is sign)
> bus value (table 12 on page 16) is unsigned.
> 

Not really. For the shunt voltage, 0xf000 has different meanings depending on scale
and range settings. LSB for bus voltage is 4 mV and starts at bit 2 or 3 depending
on BRNG. The above just happens to be correct if BRNG = 10 OR 11 per datasheet.
If that is intentional, it needs to get a comment.

>>> +			err = regmap_read(data->regmap,
>>> +					  ISL28022_REG_CURRENT, &regval);
>>> +			if (err < 0)
>>> +				return err;
>>> +			if (!data->shunt)
>>> +				return -EINVAL;
>>
>> Getting an error message each time the "sensors" command is executed ?
>> Unacceptable.
> o.k., will change to set *val = 0;
> 
Still unacceptable.

>>> +			err = regmap_read(data->regmap,
>>> +					  ISL28022_REG_POWER, &regval);
>>> +			if (err < 0)
>>> +				return err;
>>> +			if (!data->shunt)
>>> +				return -EINVAL;
>>
>> Unacceptable.
> o.k., as above
> 
>>> +			*val = ((long)regval * 409600000L * (long)data->gain) /
>>> +				(long)(8 * data->shunt);
>>
>> I don't think this was checked for overflows.
> Yes, i must first divide then multiply.
> I have to think about how to keep accuracy on high shunt resistor values.
> 
>>> +static int isl28022_config(struct device *dev)
>>> +{
>>> +	struct isl28022_data *data = dev_get_drvdata(dev);
>>> +
>>> +	if (!dev || !data)
>>> +		return -EINVAL;
>>
>> How would this ever happen ?
> Shouldn't, but i'm carefully (i had it once during development due to an error
> (using dev instead of hwmon_dev) on calling this function
>   

Parameter checks are only acceptable on API functions. This is not an API function.
Local functions are expected to be consistent. If this function is called with
a bad argument, that needs to be fixed during development.

>>> +	regmap_write(data->regmap, ISL28022_REG_CONFIG, data->config);
>>> +	regmap_write(data->regmap, ISL28022_REG_CALIB, data->calib);
>>
>> Error checking needed.
> o.k. will add.
> 
>>> +static int isl28022_probe(struct i2c_client *client)
>>> +{
> 
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_BYTE_DATA |
>>> +				     I2C_FUNC_SMBUS_WORD_DATA))
>>> +		return -EIO;
>>
>> This is not an IO error. Return -ENODEV as most other drivers do.
> o.k.
> 
>>> +	of_property_read_u32(dev->of_node, "shunt-gain", &data->gain);
>>> +	of_property_read_u32(dev->of_node, "average", &data->average);
>>
>> Check for errors and provide defaults if properties are not set.
> o.k.
> 
>> Also please use device_property_read_u32() to enable use from non-devicetree
>> systems.
> o.k. Never used this, have to look for an example on using it.
> Many (old) drivers are using the of_property_* functions, is it intended to replace it.

This is not an old driver. It is more generic than of_ functions and
should be used in new drivers.

> What about backporting this driver to e.g. 5.15, will it affect it?
> 

Device property callback functions existed for a long time. The function
exists in v4.14.y, which is the oldest supported kernel. Either case,
lack of support in an older kernel version is not an argument for avoiding
a new API. Anyone who backports a driver to an older kernel is responsible
for handling the backport, which may include new API functions.

Specific example: Your driver will have to use the .probe callback.
That has one argument in the latest kernel. In v5.15.y, it has two arguments.
You'll have to use the .probe_new callback there. Yes, technically you could
try sneaking in the use of .probe_new in your driver, but that callback will
be removed in v6.6. So you'll _have_ to do some backport, if you want it or not.

>>> +	status = isl28022_config(hwmon_dev);
>>> +	if (status)
>>> +		return status;
>>
>> That has to happen before the call to devm_hwmon_device_register_with_info()
>> to avoid race conditions.
> o.k.
> 
>>> +static struct i2c_driver isl28022_driver = {
>>> +	.class		= I2C_CLASS_HWMON,
>>> +	.driver = {
>>> +		.name	= "isl28022",
>>> +		.of_match_table = of_match_ptr(isl28022_of_match),
>>
>> Drop of_match_ptr()
> Most drivers have this, why drop?
> 

It is needed for device_property_read_u32() to work. And, again, "other drivers
do it" is not a valid argument.

Guenter

