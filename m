Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787957F153F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjKTOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjKTOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:04:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C746F3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:04:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so3320617f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700489052; x=1701093852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CBRhAg9oeeIt14xtcuewTxfszmZOswydLjQjk1Y0cQ0=;
        b=I/4CTUUXrA0t9Eu8PJBURBh0l/+HDiSHr3oIf8GfOmGf5pHjApCNqO8zGGtXf4gQlb
         6mjJF1VXKY71hyAdCpkfYDFONhEQA+xIZg/P224NwG7HvHzroRrFfkH8d+XCok91F+Vp
         8OeSxD0a9D6LTw7r01eldr/2BhcoU8CNCpH18xD2M92jh+NAi8GvKZbC6WPWtov9LTgW
         Bl07FgUMz8nZPoPdP6I1/j/pzmWWRGjUfyrx1eviOkhTOmagGRGv0bVHheyD7cZOaMwl
         kEeKCrHMiYA3pXBrUlcFQBTyM2r+pdJPdFlsZ3B7YK9a5Lvzptgqtqi4bC/HmAUGDXs+
         hiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489052; x=1701093852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBRhAg9oeeIt14xtcuewTxfszmZOswydLjQjk1Y0cQ0=;
        b=oPBIS3IknKKgrn6UseIruUtxpB9KmFnprWZVrvjJUIZF2KvFthEM5zveA2l3O29S0J
         JSmRP0Qd1iNFgMt/2pkgSaSKl8CpJoZnw4LeIu7ZlWGZDF7M1CZykDbocnPSRxw3kWQf
         dNW4QoYNsi3PxlsZd1PAOiq6nEgz37lFl6cM1TiG4v/fNfaRUEyvEWIpR0P1UKLgxrza
         04Z1NAD9cxDjPWBJO4NssESfk0InBl/wT9aUafsZJZbEp5IIVXHLxpf8ghIZrqwnyKxr
         pNVaSkBF8LYLF8cX/35bn0orz+krPm6roUb2+mfB2yaizbZ/6vl/bxPaEDrzvjNeJiCq
         eodg==
X-Gm-Message-State: AOJu0YzFWww77/6TSzDcWEfGc+/16XoIOli+wsyYzc0ilwelORM4pTxB
        BA112fee86vk7n70jRMQVrDBuw==
X-Google-Smtp-Source: AGHT+IFjr1r7yZob1E566V3Mqv9IHQfS0bAjVNf5DoqPd9RJYC+vHUFmf5FMQAWybD9NO4YXYdj2EQ==
X-Received: by 2002:a5d:46c9:0:b0:32f:acb6:7f6a with SMTP id g9-20020a5d46c9000000b0032facb67f6amr4130963wrs.64.1700489051665;
        Mon, 20 Nov 2023 06:04:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d4a0a000000b00331702ab6acsm8620379wrq.7.2023.11.20.06.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:04:10 -0800 (PST)
Message-ID: <8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>
Date:   Mon, 20 Nov 2023 15:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org> <ZVtiVM2Gm1x1j_G1@sunspire>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZVtiVM2Gm1x1j_G1@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 14:42, Petre Rodan wrote:

>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - honeywell,hsc
>>
>> Way too generic
> 
> I'm new to this, please excuse my ignorance.
> my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.

We talk here about bindings, not driver. For the driver you can use
whatever name is approved by reviewers of your driver.

> that is why my intention was to provide a rather generic name for the driver itself.
> are you afraid that they will come up with a different device that they will call "hsc" in the future?
> in this case honeywell,trustability-hsc would be fine?
> 
> as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like
> 
> pressure@28 {
> 	compatible = "honeywell,hsc030pa";

The compatible should be specific, thus for example match exact model
number.

If you can guarantee that all devices from given family are the same in
respect of programming model and hardware requirements (e.g. supplies),
then you could go with family name. However such guarantees are rarely
given. Therefore for mprls0025pa I agreed for using one specific model
for entire family.

https://lore.kernel.org/all/d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org/


> 	reg = <0x28>;
> 	honeywell,transfer-function = <0>;
> 	honeywell,pressure-range = "250MD";
> };
> 
> ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.
> 
> so do you prefer
>  honeywell,trustability-hsc  OR
>  honeywell,hsc030pa

I think the latter, just like we did for mprls0025pa. How many devices
do you have there?


> 
>>> +  honeywell,range_str:
>>
>> No underscores in property names.
>>
>> "str" is redundant. Instead say what is it, because "range" is way too
>> vague.
> 
> will rename to honeywell,pressure-range if that is ok with you.

Yes

> 
>>> +    description: |
>>> +      Five character string that defines "pressure range, unit and type"
>>> +      as part of the device nomenclature. In the unlikely case of a custom
>>> +      chip, set to "NA" and provide honeywell,pmin-pascal honeywell,pmax-pascal
>>> +    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 010BA, 1.6MD, 2.5MD, 004MD,
>>> +           006MD, 010MD, 016MD, 025MD, 040MD, 060MD, 100MD, 160MD, 250MD,
>>> +           400MD, 600MD, 001BD, 1.6BD, 2.5BD, 004BD, 2.5MG, 004MG, 006MG,
>>> +           010MG, 016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG,
>>> +           600MG, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 010BG, 100KA, 160KA,
>>> +           250KA, 400KA, 600KA, 001GA, 160LD, 250LD, 400LD, 600LD, 001KD,
>>> +           1.6KD, 2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD,
>>> +           100KD, 160KD, 250KD, 400KD, 250LG, 400LG, 600LG, 001KG, 1.6KG,
>>> +           2.5KG, 004KG, 006KG, 010KG, 016KG, 025KG, 040KG, 060KG, 100KG,
>>> +           160KG, 250KG, 400KG, 600KG, 001GG, 015PA, 030PA, 060PA, 100PA,
>>> +           150PA, 0.5ND, 001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND,
>>> +           001PD, 005PD, 015PD, 030PD, 060PD, 001NG, 002NG, 004NG, 005NG,
>>> +           010NG, 020NG, 030NG, 001PG, 005PG, 015PG, 030PG, 060PG, 100PG,
>>> +           150PG, NA]
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +  honeywell,pmin-pascal:
>>> +    description: |
>>> +      Minimum pressure value the sensor can measure in pascal.
>>> +      To be specified only if honeywell,range_str is set to "NA".
>>> +    $ref: /schemas/types.yaml#/definitions/int32
>>
>> That's uint32. Why do you need negative values?
> 
> signed int32 is intentional. some chips have two physical input ports and measure a pressure differential in which case pmin is negative.
> see either of the pdfs at page 14, table 8, column 2, row 7+

Then the best would be to change the type in other bindings to have
int32 everywhere... but dtschema also requires unt32:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

I think pressure can be negative (e.g. when device measures pressure in
relation to atmospheric pressure), thus maybe we need to fix dtschema first.

> 
>>> +  honeywell,pmax-pascal:
>>> +    description: |
>>> +      Maximum pressure value the sensor can measure in pascal.
>>> +      To be specified only if honeywell,range_str is set to "NA".
>>> +    $ref: /schemas/types.yaml#/definitions/int32
>>
>> Ditto
> 
> well, since we saw pmin needs to be signed should we have pmax unsigned?

I guess this could stay uint32, although it depends on final units for
pascal.

Best regards,
Krzysztof

