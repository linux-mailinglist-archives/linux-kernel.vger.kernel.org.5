Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5A7FB5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjK1Jcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjK1Jcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:32:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120BDE;
        Tue, 28 Nov 2023 01:32:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c115026985so5141316b3a.1;
        Tue, 28 Nov 2023 01:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701163968; x=1701768768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3assMsvuUHbHCvmkHme+u60KSQVX3/rK9TdeJztWus4=;
        b=msRcg+4sWfW2Syktsf/QZ+d5gsqdFKtOWALIXK+qjgukyssKjoDpXz5Unk8xhZNTQU
         ax+Z9trgqgKyrLGbTQyS19ssu7Pu8xjiTWYBIiBsrzLpvQjdKjxZRpkOHjK+XRDPBLTv
         N0nP72+vxwq2S1BUDp3UleWq4+HapA2P81Ot3/0A4waFxKhZvfLmNkMQqSejqIDMq55u
         vG96r348HKdBVaLRJzJAgaxAQB0Pwmc5x5eNGWyimkv6lXRzhbdroJk0ILLIQnSAWDFy
         FD0A6yY9pLrW0moudvFvoNyDXx8w0aUjmxAkLXKIGBGa9tObPikJ4DFDACKyXC2Nr1DT
         2ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163968; x=1701768768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3assMsvuUHbHCvmkHme+u60KSQVX3/rK9TdeJztWus4=;
        b=OsHvKRkappSqo7rt9Zyh4qcBwjc+lKBgJV1IdQv9ZiKYlYKTo+twe/jxXCz5yIsDJ5
         kqMDR8ofsAE7VzYhwgsr9WQkkHEP0nq3kfZffGfF7yE6hShy+FIccLnW8LQlRWSkU8y3
         CtutYCrIWeNo9KQx8JHlVfE8L5k9gZXWlRJ5Nva9jmETF4vItakwa8FMGqpaj3jnskoF
         Zz7fNLHhRS9Q+bSE8gqYL7yWC6g2xyDml8DBKgh1dfHF3sVunyzoF2TmiOU9y5mnZ8i5
         i1lYbPeTkOmNSGFN1zFl7R8trMAeOksxnF3+dM3ZHbDZOqdn2t88kqqU0/bsNS3AU/0m
         mLHg==
X-Gm-Message-State: AOJu0Yxz3nUktXSmBppv3Yf2VA2FpRr8FdOwSZozUEVReaLjadPaeJ5B
        eMMeGDq4gu9XQenpOuC1hpA=
X-Google-Smtp-Source: AGHT+IEi5HfqmGz4750uJCRofUcy8WZVhqq0EXmPX3LT/1+1NCUKKnoUDyGSSyblMGBsBoTN6J+5/A==
X-Received: by 2002:a05:6a21:3815:b0:17b:426f:829 with SMTP id yi21-20020a056a21381500b0017b426f0829mr13876287pzb.37.1701163967955;
        Tue, 28 Nov 2023 01:32:47 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c7453fae33sm2421448plb.280.2023.11.28.01.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:32:47 -0800 (PST)
Message-ID: <2e0f58cc-0cfa-4957-bac1-c40897d7135b@gmail.com>
Date:   Tue, 28 Nov 2023 17:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-3-ychuang570808@gmail.com>
 <7c24aaf8-8f93-4b93-b7e5-abc88e95682d@linaro.org>
 <ffbaad9b-9a30-4cdd-bb78-8fb7d6ff4e9f@gmail.com>
 <5ac7f79a-68d3-49ef-9615-3c0076591d78@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <5ac7f79a-68d3-49ef-9615-3c0076591d78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thanks for your review.

On 2023/11/28 下午 04:33, Krzysztof Kozlowski wrote:
> On 28/11/2023 09:29, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>> Thanks for your review.
>>
>>
>> On 2023/11/28 下午 03:34, Krzysztof Kozlowski wrote:
>>> On 28/11/2023 07:11, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>> Your changelog said:
>>>
>>>>     - Remove ma35d1-pinfunc.h which is unused after update definition of
>>> 'nuvoton,pins'.
>>>
>>> You forgot to add:
>>>
>>> " - Do not test the bindings before sending"
>>>
>>> I assume none of the driver changes compile either.
>> It's my mistake. I forgot to remove 'ma35d1-pinfunc.h' from my local
>> copy, and as a consequence, the 'dt_binding_check' did not catch this
>> error. I will fix this.
> But then git status would point you that tree is not clean and you did
> not finish commiting.
>
> ..
>

Yes, I should have been more careful in checking.

>>>> +
>>>> +allOf:
>>>> +  - $ref: pinctrl.yaml#
>>> allOf goes before additionalProperties.
>>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - nuvoton,sys
>>> This goes after patternProperties
>> I will fix the above two as:
>>
>> allOf:
>>     - $ref: pinctrl.yaml#
> Look:
>
>>> allOf goes before additionalProperties.
> Open example-schema.
>
> ..

I found that 'pinctrl.yaml' is not required for this document, so I will 
drop it.

>>>> +      - $ref: pincfg-node.yaml#
>>>> +
>>>> +    properties:
>>>> +      bias-disable: true
>>> Drop this and other "true", why do you need them here?
>> We are following the conventions used in other pinctrl documents, such as
>> 'realtek,rtd1315e-pinctrl.yaml' and 'xlnx,zynqmp-pinctrl.yaml'.
> But they are quite different there.
>
>> After comparing various pinctrl documents, I noticed that they all express
>> it as 'bias-disable: true'. Therefore, may I keep the current format?
> No, you cannot copy pieces of other binding, selectively ignoring the
> rest. Look how these other bindings are constructed - they have
> additionalProperties, which you don't.
>
> Drop all these true properties if the only reason of them being here is
> they were copied.
>
>
>
> Best regards,
> Krzysztof
>

OK, I will drop these properties.


Best Regards,
Jacky Huang

