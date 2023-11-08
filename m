Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E87E568F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbjKHMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKHMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:55:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857081BF6;
        Wed,  8 Nov 2023 04:55:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc5b7057d5so62017695ad.2;
        Wed, 08 Nov 2023 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699448123; x=1700052923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnFnGa1Xq3NRu1+Ex0WsMtBFHv4Yfs3kHDcwQXFSzNU=;
        b=aIoqscuB0S3rqTjBvVxNyDGXyscccXl99cGr2UR5Jz3LCJeW1Vz0oiHw4rSbndkvH4
         S0Q4RsZP13vx310dw3bIYO6pZEgAeBm45R6V48tiGy8sWL6ZB71loHS9+9jIdHCzz75m
         fOW3WY3Wpag708onJp4CavwpXNawEaY4jeJdYsMZdyzi44HNHo4tiD31cSlYkPZD8fCE
         s/gxukKAXegJ5DfQf2CJiRz4gvjo4luj0huPo1BW4R5qLZs+VNHvfOkcA9yra27SYzhg
         SMw8cQjUSlrMP5LPGca2uG7y0Ts+QGkdrxqf/mvP67BXGSTxUkc7srUfgq8Fn07cUBa8
         bskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699448123; x=1700052923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnFnGa1Xq3NRu1+Ex0WsMtBFHv4Yfs3kHDcwQXFSzNU=;
        b=r8U/bjizn0e9DFHeLPAAzWwj/rQwMKL999pa0N4072RYH0cLNk6vzDD23ZqU5UBBL3
         jTuISfrJt9PlrcwFb+zC4CQANesFkUh2YaWVN1VaJAjDBb+N+4YQj2Bql2jPxsvyPDO1
         Dyi5Zr/4rlPk1XOSQWRe5oF8SNLoe1TU7go4Xa+b13KDCBPzG08ANM+jcwBOJVmLDjvG
         KP2sgjII+cOZe3fpniNRS/unf7Ec+fqCY8j8HnSx+N3+ynuCM18RiB7ARpOcqKgwW0nn
         fm4Z1iF298O29cSnyEzVqtYOpsRUwEgoAyUU1OKvfdBp9+KQK6tbISw9dxxLl/lK3jfD
         aDww==
X-Gm-Message-State: AOJu0Yy2u+mwuUcyMDCUMTU8OKvMopxSlfxIXCFbwsM6Q4lms7nQFudo
        Ujw3n3d31ri47LBU93yUz5M=
X-Google-Smtp-Source: AGHT+IGrbJU4UhYwNZD8MuOWryrbZUlLrn0fvKGeRWexgJYA0rdUWu3Ogr2W8YqZPCXVFJU2nxeJFQ==
X-Received: by 2002:a17:902:c403:b0:1ca:7086:60f7 with SMTP id k3-20020a170902c40300b001ca708660f7mr2494532plk.28.1699448122932;
        Wed, 08 Nov 2023 04:55:22 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b001b8622c1ad2sm1695286plb.130.2023.11.08.04.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 04:55:22 -0800 (PST)
Message-ID: <e192a58e-47f8-4410-81a5-de1ebab3251d@gmail.com>
Date:   Wed, 8 Nov 2023 18:23:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: add asair,ags02ma
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231107173100.62715-1-anshulusr@gmail.com>
 <20231107173100.62715-2-anshulusr@gmail.com>
 <1d5d1357-0b53-4639-add9-2b3f38aae744@linaro.org>
 <90cacd34-4812-4792-9bf0-362200431452@gmail.com>
 <77e1d308-6ac3-4200-b72a-6d5717869b06@linaro.org>
 <7501036c-4e1f-4993-97a7-6c36c7cc8358@gmail.com>
 <6f654341-a9c0-4412-ac87-5800d6122023@linaro.org>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <6f654341-a9c0-4412-ac87-5800d6122023@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 17:59, Krzysztof Kozlowski wrote:
> On 08/11/2023 13:15, Anshul Dalal wrote:
>> On 11/8/23 17:31, Krzysztof Kozlowski wrote:
>>> On 08/11/2023 12:54, Anshul Dalal wrote:
>>>>
>>>> Hello Krzysztof,
>>>>
>>>> On 11/7/23 23:17, Krzysztof Kozlowski wrote:
>>>>> On 07/11/2023 18:30, Anshul Dalal wrote:
>>>>>> Add bindings for Asair AGS02MA TVOC sensor to trivial devices.
>>>>>>
>>>>>> The sensor communicates over i2c with the default address 0x1a.
>>>>>> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>>>>>>
>>>>>> Datasheet:
>>>>>>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>>>>>> Product-Page:
>>>>>>   http://www.aosong.com/m/en/products-33.html
>>>>>>
>>>>>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>>> index cd58179ae337..9cd67b758a88 100644
>>>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>>> @@ -47,6 +47,8 @@ properties:
>>>>>>            - adi,lt7182s
>>>>>>              # AMS iAQ-Core VOC Sensor
>>>>>>            - ams,iaq-core
>>>>>> +            # TVOC (Total Volatile Organic Compounds) i2c sensor
>>>>>> +          - asair,ags02ma
>>>>>
>>>>> I think you miss VDD supply.
>>>>
>>>> I am sorry but I'm not sure what you meant. Are you referring to the
>>>> addition of some information in the commit description?
>>>
>>> I meant that your device might not be trivial. Your device takes VDD
>>> supply, which is now not described in the bindings. Do you want to say
>>> that VDD supply in all possible designs is hard-wired to
>>> non-controllable regulator supply?
>>
>> I can't speak for all possible designs but for testing this driver I had
>> just connected the VDD pin to 5V out of the Raspberry Pi. I have since
>> verified 3.3V to also work.
>> Could you explain why `vdd-supply` is a property or point me to further
>> sources. Wouldn't almost all devices have a VDD/VCC pin for power in?
> 
> Most of the devices have such pin. For most of the devices we include it
> in the bindings.
> 
> git grep regulator_get -- drivers/iio/
> git grep vdd -- drivers/iio/
> 
> If you do not describe it in the bindings, then your device will have to
> be supplied by always-on regulators (and marking controllable regulator
> as always-on because of this is not correct).
>
Thanks for the explanation Krzysztof. If I understand correctly, having
an vdd-supply in the binding indicates that the device may be powered by
a controllable power source instead of one that is always on.

> If you are unsure and you just work on some sensor not used for final
> product, I think it's fine as is, so to add the regulator later if ever
> needed.

No problem, I can add the required properties in the next patch version.
I need to make a few changes to the driver anyways.

Just out of curiosity, the sensor supports reassigning of the i2c
address by writing to the 0x21 register from the default address of
0x1a. Is there some way to represent this in the binding.
For future reference, is there some exhaustive list or specification
document for all the allowed properties.

Thanks for the help,
Anshul
