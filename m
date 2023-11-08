Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4017E5639
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjKHM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjKHM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:29:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D319B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:29:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-409299277bbso47522445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699446585; x=1700051385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEwxhVkZ+suZRCLepHPEDyEGjw0C04lFSj6Fq9O+qQ0=;
        b=cIur9H3fZ6yXOAIgryFFFYA88qA2JtmMkNRXpWzMKG6wmhDOnC33AJZv5az26UW8mt
         K/KvWU4v2f3L4Fwo50AhBgHig2n8xy5yQFipTFV+14IbygnN5a9xUOnKmT9puhc8dqU7
         GDPXSZD3QMYdqgCiAYqi5xajXYDHJp21zvg2bhwFv5ROEE72XyoMN9OMfuETQKVPpx/U
         SBmT32iX1C5HcfSTOlW4wVBtNU8y4+wvELZNLq3CqqA8tqy3aOY9NZp+N1bVLqKtD3cn
         XGeGxGXXsq+ZXDEJpk1aCccRBVbm0lGFljt4DHmrS26oYp1FZHKyBUwdmPXEhWPYRm/d
         FWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699446585; x=1700051385;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEwxhVkZ+suZRCLepHPEDyEGjw0C04lFSj6Fq9O+qQ0=;
        b=k9ySFIMTTPi8/QLHt8+FR+xH/D8wK21k2Jyaf4oNr7V1AHXHtQ6ofaoVbbBK+c+A6Q
         RUsLcF55vo/mJLYIZauTj4Q2sVJebDlNzXxKoguvMM5KfckbYqoVnpo5CzoFa9eL63S3
         aWXgSgg83b/Ltuq7YzA4OnTfM8sVUKC2DDdU6d14SIalzGUlit34/lapjnBWY6UPldIV
         fXd7mo5/UM0/ItFQB4i7yYQO3uOV8oAN9QGWo/Lu/joOCbQQBmSvmvwZaQds1Jrq1+AC
         h6h3eDdbOt/oQ+Wp1GQ3TTMqsuVSZQn4QtddEs0LBBHdv9a6yLifpIlqsfe0maLQMcac
         T2og==
X-Gm-Message-State: AOJu0YzNOtcQW7VFwfq6bVa44OaND1yjDFocU1lbXHxkkhgMezbf85Ih
        egiwtuQ+ZWt8TNmfnzq+u2JWBOxg6TwopHGZ1cw=
X-Google-Smtp-Source: AGHT+IGtvteu6oY5MW/lFPUmgAUSn2VrQkswaslGXVnER/rgoZB80sOS5KVjqmC4mIFBHB7BCdNOlw==
X-Received: by 2002:a05:600c:4e86:b0:40a:20f3:d126 with SMTP id f6-20020a05600c4e8600b0040a20f3d126mr1515948wmq.6.1699446584659;
        Wed, 08 Nov 2023 04:29:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id jg2-20020a05600ca00200b004065daba6casm19287874wmb.46.2023.11.08.04.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 04:29:44 -0800 (PST)
Message-ID: <6f654341-a9c0-4412-ac87-5800d6122023@linaro.org>
Date:   Wed, 8 Nov 2023 13:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: add asair,ags02ma
Content-Language: en-US
To:     Anshul Dalal <anshulusr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7501036c-4e1f-4993-97a7-6c36c7cc8358@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 13:15, Anshul Dalal wrote:
> On 11/8/23 17:31, Krzysztof Kozlowski wrote:
>> On 08/11/2023 12:54, Anshul Dalal wrote:
>>>
>>> Hello Krzysztof,
>>>
>>> On 11/7/23 23:17, Krzysztof Kozlowski wrote:
>>>> On 07/11/2023 18:30, Anshul Dalal wrote:
>>>>> Add bindings for Asair AGS02MA TVOC sensor to trivial devices.
>>>>>
>>>>> The sensor communicates over i2c with the default address 0x1a.
>>>>> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>>>>>
>>>>> Datasheet:
>>>>>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>>>>> Product-Page:
>>>>>   http://www.aosong.com/m/en/products-33.html
>>>>>
>>>>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> index cd58179ae337..9cd67b758a88 100644
>>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> @@ -47,6 +47,8 @@ properties:
>>>>>            - adi,lt7182s
>>>>>              # AMS iAQ-Core VOC Sensor
>>>>>            - ams,iaq-core
>>>>> +            # TVOC (Total Volatile Organic Compounds) i2c sensor
>>>>> +          - asair,ags02ma
>>>>
>>>> I think you miss VDD supply.
>>>
>>> I am sorry but I'm not sure what you meant. Are you referring to the
>>> addition of some information in the commit description?
>>
>> I meant that your device might not be trivial. Your device takes VDD
>> supply, which is now not described in the bindings. Do you want to say
>> that VDD supply in all possible designs is hard-wired to
>> non-controllable regulator supply?
> 
> I can't speak for all possible designs but for testing this driver I had
> just connected the VDD pin to 5V out of the Raspberry Pi. I have since
> verified 3.3V to also work.
> Could you explain why `vdd-supply` is a property or point me to further
> sources. Wouldn't almost all devices have a VDD/VCC pin for power in?

Most of the devices have such pin. For most of the devices we include it
in the bindings.

git grep regulator_get -- drivers/iio/
git grep vdd -- drivers/iio/

If you do not describe it in the bindings, then your device will have to
be supplied by always-on regulators (and marking controllable regulator
as always-on because of this is not correct).

If you are unsure and you just work on some sensor not used for final
product, I think it's fine as is, so to add the regulator later if ever
needed.

Best regards,
Krzysztof

