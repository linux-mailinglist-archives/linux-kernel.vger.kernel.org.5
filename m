Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79CE7E1760
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKEWcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:32:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B72CF;
        Sun,  5 Nov 2023 14:31:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc58219376so35269555ad.1;
        Sun, 05 Nov 2023 14:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699223517; x=1699828317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6a/1tK8D+3pTldim80ICuo8nqDfb6HPfUZNmM3VgcKU=;
        b=fSsn2cB1nQVpXzbz6+lG5X1IfOoAzHdt/iGAcjxZ8RjMxIOHzkMWA63GpGi0OZGZKw
         1sdY7LUFfDQBdSxytlRAT33+UMXG45ApGHcy83sEdH5qQWpuLEh3cuaTU9WX5bwAMbHs
         hsm1xTFlNzzcKdXYABSNJwN1GMZxNR0jHh9ySVIAUp4BnQUT37yKudGO1BA14Smkiy0c
         9m53BlYZB80LibhO55BQq+i1XFD9vAdub10Ol+nKH9Vpla3GLBx8XJ0TuPORzHGM++rp
         ks3K4wK6NhlU+uFTQhafHyMKjM8Y93iOGSmwvtEvxd398E9NBXTgmbsL++UvqrDz5zwP
         vMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699223517; x=1699828317;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a/1tK8D+3pTldim80ICuo8nqDfb6HPfUZNmM3VgcKU=;
        b=vQK1PeEP2nwPejyLTKWhWWbeJMUUvGH/4hkhlx8axKj9bdI2a3Bxh2MeRV/5R9Q7gL
         WfnsQXiiiN7xKgVwarCJR2bsNjUCx0WqhM8vmK8ZS/aac1gJlewkdWHMjqiEK4JF64eC
         GADH7OWu9uLCBv26GrKyLLKoWZFrFrVvRr1pwieFZ4VruQiIi+xTHaW7yjNcu7xBAU9P
         RdDhYDRRtW8Tn7SnFFbYTslBQkphdSGlmwL0q3zzdrtwCypTUXPCUXSzA6nDK4pJyT3Y
         Db6zQNi3/tIQGiayhCYwK3Fl/Xxbm1TnBaA+lSOEtx3V45OPGbe67lnT4vEhhSrR/G5M
         ZKPQ==
X-Gm-Message-State: AOJu0YwHm5LwnqbqZ8ggd2zIXwDcijW8atz0xQKQ0ouyIzhcCB0i39oN
        qVDtrxIKdar9XZg3lWHg0kPTDNT+Kkg=
X-Google-Smtp-Source: AGHT+IHZkPwNJTMvTHqoSzKqkc/ITPuwRakqA+/WNw2k9lD10DMBwsR2Tw8ff4nqT48atB9/kkePzw==
X-Received: by 2002:a17:902:f301:b0:1cc:31a8:d733 with SMTP id c1-20020a170902f30100b001cc31a8d733mr18569270ple.44.1699223517260;
        Sun, 05 Nov 2023 14:31:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b001bf8779e051sm4684459plb.289.2023.11.05.14.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 14:31:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e4d3e8e-0a38-46d9-9277-31b7f6dbd0f3@roeck-us.net>
Date:   Sun, 5 Nov 2023 14:31:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rtc: add pcf85053a
Content-Language: en-US
To:     Carlos Menin <menin@carlosaurelio.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Sergio Prado <sergio.prado@e-labworks.com>
References: <20231103125106.78220-1-menin@carlosaurelio.net>
 <5451ac26-c498-4af5-b3fa-fe2265433ccc@roeck-us.net>
 <ZUf4czmwLEqKpM28@arch-bow>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZUf4czmwLEqKpM28@arch-bow>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/23 12:17, Carlos Menin wrote:
> On Fri, Nov 03, 2023 at 07:09:27AM -0700, Guenter Roeck wrote:
>> On 11/3/23 05:51, Carlos Menin wrote:
>>> Add support for NXP's PCF85053A RTC chip.
>>>
>>> Signed-off-by: Carlos Menin <menin@carlosaurelio.net>
>>> Reviewed-by: Sergio Prado <sergio.prado@e-labworks.com>
>>> ---
>>
>> [ ... ]
>>
>>> +static int pcf85053a_bvl_to_mv(unsigned int bvl)
>>> +{
>>> +	long mv_table[] = {
>>> +		1700,
>>> +		1900,
>>> +		2100,
>>> +		2300,
>>> +		2500,
>>> +		2700,
>>> +		2900,
>>> +		3100,
>>
>> How are those numbers determined ? The datasheet gives voltage ranges.
>> I'd have assumed that the center of those ranges is chosen, but for the
>> most part it is the maximum, except for 2900 which is a bit above center
>> and 3100 for "> 3.0V". Not that I care too much, but it seems to me that
>> using the center voltage for each range would be more consistent.
>>
> 
> I just used numbers that would result in the same step between levels
> (200 mV) at the same time they would fit in the ranges, but I agree

Ah, thanks for the explanation. Still, I find it a bit misleading.

> that using the center of the ranges makes sense. In this case which
> values would you suggest for <= 1.7 and > 3.0 ?
> 

The datasheet says that the battery voltage must be between 1.55 V and 3.6 V.
With that in mind, and since the next voltages would be 1800 and 2850 if you
use center voltages, I'd probably use 1600 and 3100. You'd then have
	1600, 1800, 2000, 2200, 2400, 2600, 2850, 3100
This gets close to using the same step size but also reflects voltages
more accurately.

>>> +static int pcf85053a_hwmon_register(struct device *dev, const char *name)
>>> +{
>>> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
>>> +	struct device *hwmon_dev;
>>> +
>>> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, name, pcf85053a,
>>> +							 &pcf85053a_hwmon_chip_info,
>>> +							 0);
>>
>> This won't compile if CONFIG_HWMON=n or if CONFIG_RTC_DRV_PCF85053A=y and
>> CONFIG_HWMON=m.
>>
>> Guenter
>>
> 
> I will add dependencies in the Kconfig file.
> 
You'll also need something like IS_REACHABLE() here unless you make the driver
depend on HWMON, which is probably not what you want.

Thanks,
Guenter

