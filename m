Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6867E5609
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjKHMRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjKHMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:16:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC261BCC;
        Wed,  8 Nov 2023 04:16:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b709048f32so6195099b3a.0;
        Wed, 08 Nov 2023 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699445817; x=1700050617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0odlHwOtNd/gQ2OSreSLITmOX7RsQ54slrLEuU0nUY=;
        b=iG7w/PALHQgB9i8Zpgf8ymo5m07IYdCqCnznMlmwuLebRQkKkrWY884X1gAJL3QT/3
         4DJ7RcKjfneZGwUj0Cb1QgBCPblP2CPHOk4o5HH5pq5HBk9uUa3xPDgvtrkq4ZzHo0if
         wXjDQBsRdvePndQ4shjZfQrg1oipjKa0SkC4XZDb9HgBHFDWjRz0CosF9keg+mKnjf0R
         6NrDhgyBPytOqxZ7g0bYu0chKj/qwWqSjqfRMKKwTpHMaaI7SR5iXEcnrAHOx3LMlzUf
         LSyNqkLB4InwV/NLzLmNtsVMxVB/fA6yRksiypvx7btcakDzdibiX3hN9tFXRrYbJElv
         wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445817; x=1700050617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0odlHwOtNd/gQ2OSreSLITmOX7RsQ54slrLEuU0nUY=;
        b=D63sUZXMw7m0+NWjeC5GYRpZgXkeEa/UVJbVukvqKlzOpVA3EfSwlmm+spJzCTXj9b
         N4powreraNSR6BQK0kpqzZy6oJoWRMOiuKnwYEPFOO5bFD2xr3YbkgF/luB5potDzgya
         zfqULV1/VCxNNaosE59VsY7FMiSY9Vdg4tcyV9V013NyVN7qeSnwSCaztWpdWlL4HbGS
         CDYa/4mUX52NHtF/hR4m9Iauefnjza7ceNDBolE1cDpUbcaCMbaeG4z98iFkXBNOeYWW
         AfG0T2zv4is0wrCCqHqIKlJs7QT2MGzhlZiQWsBsZQFuJvS+xOe25WQNZR1Vn62Ztc7X
         NShw==
X-Gm-Message-State: AOJu0Yxmelgmt1wrJk2t5i3bs38+VKx6aFiOjJlSpZINlCab0kJVi35t
        jkAD/4iVesuxnQ2EEnWdYc0=
X-Google-Smtp-Source: AGHT+IEgvBlfFoAm3o5yLspuEPCkpGv8ovqzhX0voi151tq5DxVHhnPFdmjziZe7SPm7I5oHL/driA==
X-Received: by 2002:a05:6a00:88b:b0:6c2:cb9a:885e with SMTP id q11-20020a056a00088b00b006c2cb9a885emr1597966pfj.15.1699445816503;
        Wed, 08 Nov 2023 04:16:56 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id b21-20020a056a0002d500b00688965c5227sm8836395pft.120.2023.11.08.04.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 04:16:56 -0800 (PST)
Message-ID: <7501036c-4e1f-4993-97a7-6c36c7cc8358@gmail.com>
Date:   Wed, 8 Nov 2023 17:45:24 +0530
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
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <77e1d308-6ac3-4200-b72a-6d5717869b06@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 17:31, Krzysztof Kozlowski wrote:
> On 08/11/2023 12:54, Anshul Dalal wrote:
>>
>> Hello Krzysztof,
>>
>> On 11/7/23 23:17, Krzysztof Kozlowski wrote:
>>> On 07/11/2023 18:30, Anshul Dalal wrote:
>>>> Add bindings for Asair AGS02MA TVOC sensor to trivial devices.
>>>>
>>>> The sensor communicates over i2c with the default address 0x1a.
>>>> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>>>>
>>>> Datasheet:
>>>>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>>>> Product-Page:
>>>>   http://www.aosong.com/m/en/products-33.html
>>>>
>>>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> index cd58179ae337..9cd67b758a88 100644
>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> @@ -47,6 +47,8 @@ properties:
>>>>            - adi,lt7182s
>>>>              # AMS iAQ-Core VOC Sensor
>>>>            - ams,iaq-core
>>>> +            # TVOC (Total Volatile Organic Compounds) i2c sensor
>>>> +          - asair,ags02ma
>>>
>>> I think you miss VDD supply.
>>
>> I am sorry but I'm not sure what you meant. Are you referring to the
>> addition of some information in the commit description?
> 
> I meant that your device might not be trivial. Your device takes VDD
> supply, which is now not described in the bindings. Do you want to say
> that VDD supply in all possible designs is hard-wired to
> non-controllable regulator supply?

I can't speak for all possible designs but for testing this driver I had
just connected the VDD pin to 5V out of the Raspberry Pi. I have since
verified 3.3V to also work.
Could you explain why `vdd-supply` is a property or point me to further
sources. Wouldn't almost all devices have a VDD/VCC pin for power in?

Best Regards,
Anshul
