Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA67DE339
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjKAPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjKAPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:31:08 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D3102;
        Wed,  1 Nov 2023 08:31:03 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b3f938331fso513660b6e.1;
        Wed, 01 Nov 2023 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698852662; x=1699457462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x+eJKl5QhBuA8gSgrtZxHDFNkGmY8s8qRo9IFIWyhMY=;
        b=DoGRI3akXtuLrFjpGkJcIEZThZrs76jeiVmaWsFLgP6MQDx4xnpHdDrPWIErNV7Rzq
         zKD20n+IusDLHd5DIsZCxaUOmPM4rnHmJksfrMLjqf0GPPLPZa6KJ4EASu8vdQrsvqpL
         BtLAiqL2koXj9O1yO6q7W+JU70ELgmpNIXSJ8K+VbWfnL7ySg0ZheUDBo73EWBfI897d
         Ei6s4HEJ/7Pwf7iDK3hXz2vZM5ylMKHE3izGPud8teMK66omUHF2NqWuJsrLhuh1o8fa
         7uISIGutHapmuteTU9IJ9nnuxuwwaOcxy7a3h4Zm/IHMwi4FFx59BAgcFrmR/0ALfNe0
         Stfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852662; x=1699457462;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+eJKl5QhBuA8gSgrtZxHDFNkGmY8s8qRo9IFIWyhMY=;
        b=uTNDwzSoHwrPge4hgof57hvJZYMtg9SvHbuKvg7kv4BN1UT1j/SdyhtC3JwoRc3J2X
         WQkaXVEh/9IPyDEygrB4Cgnw+Cz0V5qizJFfloPNB0JOGHtLoRq/nxDwWB19jWful/2r
         PPnrd4GcV/tYfXrftbTFB7KA63KUeTDHfSk+rnQDFQYa1QB6GIV+b1DvSaEck9e95NJM
         1N7zewH1qsvKmdv95xjaH1R+salr3uK9vPXdpPUxL/I4ZO790u/OBqgHaWO5JdexwP9U
         n4T6ZpZS4CLF2B9daUeKyRJAmUobzbIGFJh0cLCQxsXIAsW8yE0OYgxlX8F+mCDCi/4i
         MFzg==
X-Gm-Message-State: AOJu0YzJ99tHfQBcqek93ynccx7oGIY4xD8pExCXwZf8mX36h3pdyD4L
        zEEv29br7UKVaef5WMTuaScBD0cKMOA=
X-Google-Smtp-Source: AGHT+IF8ccE6RAg+/SxiwfG7bYocm3sGs5LRAximEXuh8mLqr/9Izsz6GifMeiIvo+KD2H+fjnfgag==
X-Received: by 2002:a05:6808:1507:b0:3ad:c018:7d9a with SMTP id u7-20020a056808150700b003adc0187d9amr1817791oiw.13.1698852662448;
        Wed, 01 Nov 2023 08:31:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2-20020a0568080b2200b003af6eeed9b6sm247866oij.27.2023.11.01.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:31:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <590b1e94-ec4f-4c6e-b6cb-d87e72bd0fd0@roeck-us.net>
Date:   Wed, 1 Nov 2023 08:30:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rtc: max31335: add driver support
Content-Language: en-US
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <20231101094835.51031-1-antoniu.miclaus@analog.com>
 <20231101094835.51031-2-antoniu.miclaus@analog.com>
 <81efcde1-8305-465a-85a2-cfe449e8a8da@roeck-us.net>
 <CY4PR03MB3399426A31899901EBADDECF9BA7A@CY4PR03MB3399.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CY4PR03MB3399426A31899901EBADDECF9BA7A@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 08:21, Miclaus, Antoniu wrote:
>> On Wed, Nov 01, 2023 at 11:48:14AM +0200, Antoniu Miclaus wrote:
>>> RTC driver for MAX31335 ±2ppm Automotive Real-Time Clock with
>>> Integrated MEMS Resonator.
>>>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>> changes in v4:
>>>   - add Kconfig entry for HWMON dependency.
>>>   MAINTAINERS                |   8 +
>>>   drivers/rtc/Kconfig        |  20 +
>>>   drivers/rtc/Makefile       |   1 +
>>>   drivers/rtc/rtc-max31335.c | 765
>> +++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 794 insertions(+)
>>>   create mode 100644 drivers/rtc/rtc-max31335.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index dd5de540ec0b..bc484cb997ab 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -12823,6 +12823,14 @@ F:
>> 	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>   F:	Documentation/hwmon/max31827.rst
>>>   F:	drivers/hwmon/max31827.c
>>>
>>> +MAX31335 RTC DRIVER
>>> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> +L:	linux-rtc@vger.kernel.org
>>> +S:	Supported
>>> +W:	https://ez.analog.com/linux-software-drivers
>>> +F:	Documentation/devicetree/bindings/rtc/adi,max31335.yaml
>>> +F:	drivers/rtc/rtc-max31335.c
>>> +
>>>   MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
>>>   L:	linux-hwmon@vger.kernel.org
>>>   S:	Orphan
>>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>> index d7502433c78a..360da13fe61b 100644
>>> --- a/drivers/rtc/Kconfig
>>> +++ b/drivers/rtc/Kconfig
>>> @@ -373,6 +373,26 @@ config RTC_DRV_MAX8997
>>>   	  This driver can also be built as a module. If so, the module
>>>   	  will be called rtc-max8997.
>>>
>>> +config RTC_DRV_MAX31335
>>> +	tristate "Analog Devices MAX31335"
>>> +	depends on I2C
>>> +	select REGMAP_I2C
>>> +	help
>>> +	  If you say yes here you get support for the Analog Devices
>>> +	  MAX31335.
>>> +
>>> +	  This driver can also be built as a module. If so, the module
>>> +	  will be called rtc-max31335.
>>> +
>>> +config RTC_DRV_MAX31335_HWMON
>>> +	bool "HWMON support for Analog Devices MAX31335"
>>> +	depends on RTC_DRV_MAX31335 && HWMON
>>> +	depends on !(RTC_DRV_MAX31335=y && HWMON=m)
>>> +	default y
>>> +	help
>>> +	  Say Y here if you want to expose temperature sensor data on
>>> +	  rtc-max31335.
>>> +
>>
>> This isn't used in the driver. Did you test with HWMON=n ?
>>
> 
> I need to start thinking a bit more out of the box instead of
> taking other driver approaches as being the only way to go. 😊
> 

There are essentially two options: Either the above, or use
	depends on HWMON || HWMON=n
for RTC_DRV_MAX31335.

In both cases, the driver hwmon code has to be surrounded with #if[def].
Depending on your approach, that will be "#ifdef RTC_DRV_MAX31335_HWMON"
or "#if IS_REACHABLE(HWMON)".

You could also use "depends on HWMON" for RTC_DRV_MAX31335 to avoid the
#ifdef in the driver, but that is normally undesirable.

Guenter

