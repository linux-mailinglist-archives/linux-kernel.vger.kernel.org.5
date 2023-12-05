Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7395804CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjLEIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjLEIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:47:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939710F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:47:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso4346707f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701766054; x=1702370854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWxaWBqyIxCtLJar33vj20NuFaCWDbc33Rb28jqqnUY=;
        b=Z2WrJAe47r9cjPziQO+3k7CfgK9r4EvJCKDQ7ItWdEOcfTQSYLvHWOxZK88N7EwpNg
         RMgWzAUc6Whxh42kb9fyUd3oYUG1pqdxj14i8kN1X/IAYmTrAlu6zN8VFZr+0sp65ihG
         wZq0EL6RhgYdOczhLk2xsv+sgEYhNI0p/6q7UEitAIBJn7X1uzJne1GvtQ+mon3C4Wqx
         PpZt/pcIPw3tQp9QMwAyfWjaC9mJ0oQzMI9uk48Dhn2o3DuyJtare43Mbcg/0zMM4QwJ
         /PHmG/TJP4XbEisxqeE4N6c5+y5RDYgdzyhsvVEPejiB6sdi2ZTJ/G21ny2voBEuGUnW
         7WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766054; x=1702370854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWxaWBqyIxCtLJar33vj20NuFaCWDbc33Rb28jqqnUY=;
        b=st/lFx+RBiN6oCVf2td0dEnZjUNK7A6uHe34FV8FqbnmvDiwl0ChJNAp2MvLuYJZzJ
         0XqsQ16dnQdCMT+9fxyW9XKkJ2LzkZBTGAHenXfUhhTHQ91hVvOzLvxvdMBq0Sg89Ex9
         MPBxhJ9huubYT7vx/VTNOXTYMGxC/lPuT3BPSdZZ47gK44HEJ3aPVvD2rnoXRpli2VD9
         qGiNhOtvIb6Eut2zHyFOL8NMsQwrcLzifBLlPDkHbvAtYVUX8VCLfDsg0JSFRzeEcnVR
         HAvpSVmiQL3dVfo5C3qm8JEEYuWM/44WY/csryPiO9D2t6aRVT8OIzjbFtChhd5x+TgC
         2yPA==
X-Gm-Message-State: AOJu0YySgQ/egXVn6pjAkJO4xATCFkZ8hRtVeWw3m2uu3W4y/MTLFWJ1
        aDWg4RpPXXUNi8aPGkhukj5URg2w+i9IVRU0hPs=
X-Google-Smtp-Source: AGHT+IHF8dr/N6W6HX7rkewtjLVj3ityepniUrWBEsD+P7w8hronp5Kh2eF+xzNBVhpVy9pPAo3X4A==
X-Received: by 2002:adf:f205:0:b0:32d:87c8:b548 with SMTP id p5-20020adff205000000b0032d87c8b548mr3410360wro.21.1701766053814;
        Tue, 05 Dec 2023 00:47:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id dj16-20020a0560000b1000b0033331f83907sm11164414wrb.65.2023.12.05.00.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:47:33 -0800 (PST)
Message-ID: <3356a35c-0c50-4539-a955-01d2e67b4eca@linaro.org>
Date:   Tue, 5 Dec 2023 09:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for
 Realtek DHC SoCs
Content-Language: en-US
To:     =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
 <7959920acf004f3cb8072de1e17439fa@realtek.com>
 <e1490203387d4c48a5f8c4040ece038a@realtek.com>
 <6250c57b-6d38-4085-9a79-58e4e5ed1e3d@linaro.org>
 <cf2f9fd124514cb9832e942e16b8fa6e@realtek.com>
 <5134d2c7-b499-400d-bec8-ae0de1eff7db@linaro.org>
 <f27cb5d8943e44b597a13d7655edf4d0@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f27cb5d8943e44b597a13d7655edf4d0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 09:43, James Tai [戴志峰] wrote:
> Hi Krzysztof,
> 
>>>>>>>> +  interrupts-extended:
>>>>>>>
>>>>>>> interrupts instead.
>>>>>>>
>>>>>>> Anyway, you must describe the items. Why this is not fixed but flexible?
>>>>>>> Hardware has different number of pins? That's unlikely.
>>>>>>>
>>>>>> I will replace it with 'interrupts'. Since our Interrupt controller
>>>>>> architecture doesn't involve multiple interrupt sources, using 'interrupts'
>>>> should suffice.
>>>>>>
>>>>>
>>>>> Due to changes in hardware design, some peripheral interrupts pin
>>>>> initially
>>>> connected to the Realtek interrupt controller were redirected to the GIC.
>>>>> However, the associated fields and statuses in the Realtek interrupt
>>>>> controller
>>>> registers were not removed.
>>>>> As a result, these interrupts cannot be cleared by peripheral
>>>>> register, and their
>>>> status clearing is still needing the Realtek interrupt controller driver to
>> manage.
>>>>>
>>>>> That's why flexibility is necessary.
>>>>
>>>> This does not explain why this is not fixed per variant.
>>>>
>>>
>>> Does the definition of "fixed" you mentioned refer to fixed interrupt pins? If
>>> not, could you please give me an example and let me know what you mean by
>>> "fixed"?
>>
>> Number of the interrupts per each device or variant should be strictly defined,
>> not variable.
> 
> Thank you for your explanation.
> 
> The DHC platforms contain two interrupt controllers, each handling peripheral device interrupts in the two power domains. 
> While each has a fixed IRQ numbers, the specific IRQ varies depending on the platform.

Srsly, what "specific IRQ" has anything to do with "number of interrupts
per each device or variant"?

Look at all other bindings covering multiple devices and their
clocks/interrupts/interconnects/reg etc.

Best regards,
Krzysztof

