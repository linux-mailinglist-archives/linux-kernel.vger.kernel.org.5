Return-Path: <linux-kernel+bounces-4156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DB817897
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF801F23503
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4C5BFBC;
	Mon, 18 Dec 2023 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr9qv1og"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A185A845;
	Mon, 18 Dec 2023 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd86e3a9afso1241214a12.1;
        Mon, 18 Dec 2023 09:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920142; x=1703524942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w6K0/NiXGchDMTiOr+7eRMHgU+/hkbBVVErT4LbtoLY=;
        b=Dr9qv1ogsrWodKpc7zCaNzysy68ANqqoCEDtMSjCtGa5JSzEqHAMEO+fbTWV8wpIdt
         pUzEXWsYtshv0/EMzK9syEVABfDnt8+Vjjb3AHqrlGlDzB/uXfGosKI4isB313ofVIHJ
         iIGDLXQYOvmxmIoyUiIHSM8yXCvgAGBczpdIAEXeXTwjn2EfJwT0oMl/avzh4VbTD+Sy
         HgY/Dq2RhUoAcbwbHbfwRDoei9kpmF+UqAsWjMl7JO9He3n5J0flCqn5b+u8iPHm7ccb
         8P0NCy7nEPup/CyXkjPl4sGNT1DRYSyVQTYaNsAH0nvlWpDS4gm83GlXmSHID2Ue9WfR
         Wqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920142; x=1703524942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6K0/NiXGchDMTiOr+7eRMHgU+/hkbBVVErT4LbtoLY=;
        b=B/LHPzP9gb54Xb/kZ0iMox7QJJGeUk31aFjp6mljUKdOYvZOtu4ls5qkkYoLzFS5js
         OxTQo+oEX+mOSBmU5XsdoT7lluC78HqMhklHqFGcLNvqePsILwjSMaDwpepaMlXz8Faq
         SKlPrJ7g8IJwRXj6oeoZ5VCMX65V6VGzr9K4wMWGnw/AmQaLmJlTkIH8PwZWEdvplpnv
         DO4sEIrDSr8rQl3E0RRu+6fCU5P9YKVeKXXaX8nlz7LqxaeUUqq+tigk61/F4FBRRGeP
         RK5zA6yYXUUYHcSrpQ7gUhvqZjiCN4+TW73QzYcPMmTfbk2gdyOc9BgjgNCKo2ccOvG4
         5Msw==
X-Gm-Message-State: AOJu0YxXA+66kmyjvKJDC9/+2RLcFFmpVbYr+Nqrr7AjSt/bLtjVsbvV
	+oYSzmGSnB+krrZa3WjTuFo=
X-Google-Smtp-Source: AGHT+IHz9yyeL9jQHPKCQRZEb02OwHwFoelgORqY6jpcbZAJslua/yKCKjKkWcBXEQYHNwCtPRyjJQ==
X-Received: by 2002:a05:6a20:320b:b0:187:29f9:e12e with SMTP id hl11-20020a056a20320b00b0018729f9e12emr16188961pzc.29.1702920142047;
        Mon, 18 Dec 2023 09:22:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p31-20020a056a000a1f00b006d85c3cf56bsm1528223pfh.215.2023.12.18.09.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:22:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <86e0e357-5b31-4984-a66f-d27128178470@roeck-us.net>
Date: Mon, 18 Dec 2023 09:22:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Content-Language: en-US
To: "Matyas, Daniel" <Daniel.Matyas@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-2-daniel.matyas@analog.com>
 <43c3f6cb-aeb2-40c8-a79d-c2222414b49c@linaro.org>
 <a5bc25d5-f59c-43ce-a44a-3eabc4b2d06c@roeck-us.net>
 <SJ0PR03MB67643A8DD1F7AD8CEF66BBBE8990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <SJ0PR03MB67643A8DD1F7AD8CEF66BBBE8990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 01:08, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Friday, December 15, 2023 6:03 PM
>> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Matyas, Daniel
>> <Daniel.Matyas@analog.com>
>> Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-doc@vger.kernel.org
>> Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as
>> compatible string
>>
>> [External]
>>
>> On 12/15/23 00:49, Krzysztof Kozlowski wrote:
>>> On 14/12/2023 15:36, Daniel Matyas wrote:
>>>> In the device ada4224 the max31827 temperature sensor will be used,
>>>> so the default values corresponding to adaq4224_temp are the same
>> for
>>>> max31827.
>>>>
>>>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>>>
>>> Please use subject prefixes matching the subsystem. You can get them
>>> for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
>>> directory your patch is touching.
>>>
>>>> ---
>>>>    Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 5
>> ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> index f60e06ab7d0a..9f3b0839aa46 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> +++
>> b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> @@ -20,6 +20,7 @@ properties:
>>>>          - const: adi,max31827
>>>>          - items:
>>>>              - enum:
>>>> +              - adi,adaq4224_temp
>>>
>>> Underscores are not allowed
>>>
>>
>> That isn't the main problem with this patch.
>> https://urldefense.com/v3/__https://github.com/analogdevicesinc/linux/
>> tree/dev_adaq4224_dts__;!!A3Ni8CS0y2Y!_2D1w1DD5sjJrNyArZYZ3QW9
>> nS8URmP6X0n6R7q1sBnDB1HPL6jROhD_w9u3fJixt2hDDNtO6VpgLM1Jka
>> Q$
>> suggests that it may be a development system which utilizes the
>> max31827.
>>   From there, we can see that there is a devicetree description of a board
>> with that name which uses
>>
>>                   temperature1: temperature@5f {
>>                           compatible = "adi,adaq4224_temp";
>>                           reg = <0x5f>;
>>                           vref-supply = <&vio>;
>>
>>                           adi,comp-int;
>>                           adi,alarm-pol = <0>;
>>                           adi,fault-q = <1>;
>>                           adi,timeout-enable;
>>                   };
>>
>> That doesn't make sense to me. I don't know why they don't just
>> reference max31827.
>> I am most definitely not going to accept a driver change just to map
>> adi,adaq4224_temp (or adi,adaq4224-temp) to the actually used
>> temperature sensor chip. If we start accepting that, we'd end up with no
>> end of "<vendor>,<board_name>-{temp,voltage,current,power,...}"
>> compatibles.
>>
>> Looking more into the above mentioned repository/branch, an earlier
>> version of the dts file did reference adi,max31827 for that chip. It also
>> looks like there may be an adaq4224 ADC (per drivers/iio/adc/ad4630.c),
>> but that would be a SPI chip. It seems highly unlikely that a SPI ADC would
>> have a separate I2C interface connected to a temperature sensor.
>> Confusing.
>>
>> There is also some indication that this may some IP to be loaded into an
>> FPGA.
>> which utilizes an FPGA implementation of max31827 (or maybe connects
>> to one).
>> If that is the case, it should still be referenced as max31827.
>>
>> All that wasted time because of "let's provide as little as possible
>> information about what we are actually doing" :-(.
>>
>> Guenter
> 
> I asked around to get some more clarification on the matter. There will be a new chip released, named adaq4224. This chip will have the max31827 implemented in the silicon, so the driver used to get temperature information would be max31827.c. The chip will have spi and i2c communication too. The other driver you mentioned, the ad4630.c will communicate through spi.
> 
> Because the chip has a different name, I was asked to add a new label for the max31827, so that it will be clear for the user, that the max31827 is part of the chip.
> 

It is still a max31827 core. If there is no difference in programming
to max31827, it can possibly be reflected in devicetree as
"adi,adaq4224-temp", in addition to "adi,max31827". This would not
require a change in the driver code as "adi,max31827" would still
be mandatory.

But I don't think changing the driver or device name for this purpose
would be appropriate. We don't do that for any of the other hwmon
drivers, and I really don't want to open a floodgate. The lm75 driver
supports more than 20 chips from various different vendors,
but it is still the lm75 driver. The jc42 driver supports many chips
from different vendors, but the driver only has a single
"jedec,jc-42.4-temp" binding, and devices are instantiated as "jc42".
I don't see why this one should be handled differently.

Guenter


