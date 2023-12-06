Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29208076CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378891AbjLFRmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjLFRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:42:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A001D42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:42:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c25973988so415585e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701884555; x=1702489355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xL6l/N6Q8ibIUwN32H6CRM/75jAc9m5uQ7LdoK0NFQ0=;
        b=oIj54mkEzYhRHZgTbMbA0I8rJ3vEdGxdoQI2DdlWSHhuP29tXXCQyb91slQ3Eh+XiJ
         sA+mt/eSQflswEa7wdsYdpZ2BcxSwJ8BW3+1V8h0hK8cA86nvfsDv6N0m93uJWDMVRco
         bQzjsWQEk4rILJxTWMoYhIrgtgf3EQeNrWtxz96yHbqCCsKkUwHM+vWdF0dXJUrJ8Mfg
         e3Mw14xHlpmUb0ZPW0GUBJIibyHB4DvbjuG3vVqaTxG2AbLYysbCIiuS9jDNw5gMjuVR
         WgPQg4PNVJYmBtZo6N5BmKRIYDwTSDLcuFSRou3qe937uDyhK8veo1xc/cJhMMA/YxQk
         gnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884555; x=1702489355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xL6l/N6Q8ibIUwN32H6CRM/75jAc9m5uQ7LdoK0NFQ0=;
        b=pEncDqXjvLjw2fWAj7uGAqlv3+AA1131+uyDL7EZcqGi8VzZ3fi2SxQ829CDFcUfvK
         9PDK4XmqzhDUnsORRkT9UEvNpHVxjziLEiu1UvTMFmEI6WTHwGdhMwcijC2cojy8c7rT
         /B29IYJbnOtFuLCtYPo9K1OQyKVssJnIslUu3KdvYurOW7Iys8rg2wzAVKI+uA4DypWp
         rDvzIyIHqZzu0oWArQCK75/m3Ff1TkzeftmozZ5M86CPa63vlR/HPhl6MuZcZCWngS8l
         DP2ExeX5A/R+EpAHz8vylQ6PNhtmN4h7LzPJFR+aD8ckZrGRmIq1sL5FLqlHgfcm8KtS
         XSqw==
X-Gm-Message-State: AOJu0Yx+t0LLvS4PEvTPqYuPb913EU7flVYdY3QBIne2Vxs+37u6N1z5
        Z9plMAQsIprzLCEDDKED561dIMk7rx1D09zBbB8=
X-Google-Smtp-Source: AGHT+IECHHqHXZQhOSj7MV4IYl/O0OaGZY54ibS89pE4kTLTkgO5ibieqVwwkEJTY6JC3gE3cIBnVQ==
X-Received: by 2002:a05:600c:3d88:b0:40c:6e8:610a with SMTP id bi8-20020a05600c3d8800b0040c06e8610amr843330wmb.56.1701884554705;
        Wed, 06 Dec 2023 09:42:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b00a0d672bfbb0sm213002eji.142.2023.12.06.09.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:42:34 -0800 (PST)
Message-ID: <3fff866f-fbe8-4d23-87f3-275380adf3d4@linaro.org>
Date:   Wed, 6 Dec 2023 18:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: memory: additional compatible strings
 for Broadcom DPFE
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
 <20231205184741.3092376-2-mmayer@broadcom.com>
 <f17dcd86-7f87-4433-a106-eb7bfdfb05ab@linaro.org>
 <42677f2d-190c-4043-a61d-8bfba581a764@broadcom.com>
 <5497447c-023b-4837-a5e2-b465ba2f624d@linaro.org>
 <25177e5c-880e-4c7b-8a72-2d908a970afb@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <25177e5c-880e-4c7b-8a72-2d908a970afb@broadcom.com>
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

On 06/12/2023 18:36, Florian Fainelli wrote:
> On 12/6/23 09:29, Krzysztof Kozlowski wrote:
>> On 06/12/2023 17:32, Florian Fainelli wrote:
>>>
>>>
>>> On 12/6/2023 3:09 AM, Krzysztof Kozlowski wrote:
>>>> On 05/12/2023 19:47, Markus Mayer wrote:
>>>>> Add versioned compatible strings for Broadcom DPFE. These take the form
>>>>> brcm,dpfe-cpu-v<N> where <N> is a number from 1 to 4.
>>>>>
>>>>> These API version related compatible strings are more specific than the
>>>>> catch-all "brcm,dpfe-cpu" and more generic than chip-specific compatible
>>>>> strings.
>>>>
>>>> None of this explains: Why? I don't see any point in this and commit
>>>> does not explain.
>>>>
>>>>>
>>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>>> ---
>>>>>    .../bindings/memory-controllers/brcm,dpfe-cpu.yaml        | 8 +++++++-
>>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>>>> index 08cbdcddfead..6dffa7b62baf 100644
>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>>>> @@ -16,6 +16,11 @@ properties:
>>>>>          - enum:
>>>>>              - brcm,bcm7271-dpfe-cpu
>>>>>              - brcm,bcm7268-dpfe-cpu
>>>>> +      - enum:
>>>>> +          - brcm,dpfe-cpu-v1
>>>>> +          - brcm,dpfe-cpu-v2
>>>>> +          - brcm,dpfe-cpu-v3
>>>>> +          - brcm,dpfe-cpu-v4
>>>>
>>>> No, that's just wrong. So you want to say bcm7271 is brcm,dpfe-cpu-v4?
>>>
>>> No as the example shows it "speaks" API v1.
>>
>> Example is not a binding. It does not matter except of validating the
>> binding. This is just incorrect.
>>
>>>
>>> I would be inclined to completely remove the chip specific compatible
>>> strings from the binding because they are not sufficient or descriptive
>>> enough to determine which API version is being spoken, since the
>>> firmware is unfortunately allowed to change major APIs (and the
>>> messaging format, because why not?) at a moments notice.
>>
>> Then versions do not give you anything more.
> 
> The versions indicate exactly which API to be spoken to with the 
> firmware. The firmware API was not properly designed, it should have had 
> a way to indicate which API it has, regardless of the messaging format 
> it implements, but for reasons unknown that is not how it was implemented.
> 
> Essentially we need to know right away and ahead of time which API to be 
> used, otherwise that means doing runtime detection like what patch 4 
> does which you do not want to see.

Yeah, I see, you explained this deeper in response to 3/4, which I read
after this one.

Deprecating specific compatibles makes sense. If you have subset of FW
per given SoC, you could keep the specific compatible followed by subset
of version-compatibles (e.g. bcm7271 + v1 + generic fallback). However
then generic fallback is useless and you should actually drop it. The
only, *ONLY* point of generic fallback is to be used by OS alone. In
that case it cannot be used alone, so it is useless.

We do not use generic compatibles in a way of "I want to call all of
these devices a DPFE" or "I want to call it a default".

Now, if you do not have subset of FW per given SoC, so anything can
match with anything, then in one commit:
1. Deprecate specific compatible followed by useless generic fallback
2. Add versioned-compatibles alone, since generic fallback gives nothing.

Best regards,
Krzysztof

