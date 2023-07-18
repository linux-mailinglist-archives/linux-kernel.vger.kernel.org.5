Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E8757394
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGRGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRGEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:04:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEDD1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:04:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992acf67388so654766866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660267; x=1692252267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5f7NuoL+/s8bYQq96dyzOfuTIeGEJ1Q95iMxVbPcgI=;
        b=MHy1+SYOHT+v734z3zl3xn74SFQLQkv9kc8FKVktNOw56L3SKY61lRQ78NIIT3vUvo
         ulEO0QRsuhEpb++gPsLvHzmZR9h1DhUbLG+tnxxmWjOQNTgFAM/zzIPRJN5S564tH9aG
         LKIoq5w8p7yTYcR2U+mEg4zzpFSaGpI7TSg03jHUaydmbWxAr6QYzKjJxs4VunuwN9Y5
         erITxs2iEJt++4glBFj7M9wvY+9uDAsrKqiQfwy++246qnXAKWZ/LswXgt+Zlm093oxp
         LflpWgjGKXAiljfK4QfjQrV0dyBSIuLuX3rZEV8tjv21Lw/kBNmk6WPdQKFb3W6UYtuw
         9iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660267; x=1692252267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5f7NuoL+/s8bYQq96dyzOfuTIeGEJ1Q95iMxVbPcgI=;
        b=KjZfPclPcJD0Or1olERkvGjF/Uy89eh7SVDQMyTJMqrSc1Q45w+3r1GzLH1puAs2jk
         MG8ecktmyNsWVs1zYdthQ3zfRufNuoN4dMtBDjB66F2TL8OWjRQESUeGdb9rkZwyDgcZ
         AQ9KEralO9hwEkgCv3GoWap/JDeW2q0arFME9TU2xU/JIrqNS05Gd39S66O4r2SUOv0e
         9vvsAq+KFXkTtMnPp9pPpkXr/5aOt1P5D0ffPOBRGHeaoxlwB4gkSk/XP2yP8ghTpsmw
         vjK56Q4+FTq2kqlcCnoODf6pQLbI5zM5zmSgIzjmy1dQQImo02tE3KYRbG1Uv8OB1Opr
         5dqw==
X-Gm-Message-State: ABy/qLY9D0wcRUDCvEvAKzDfvX8F/de9rpDPtlNb/ByJIgcIIRlbwyFJ
        bAHoEo3lsME+Pdd3INgnGfKxFg==
X-Google-Smtp-Source: APBJJlFZbIMU5j4Cb+CtvRvuwgexr97UBWi37cXm30GLf2vtnoY8xEMV54HgvT+rU0dOhPyaqKQscQ==
X-Received: by 2002:a17:906:e17:b0:993:ffcb:ad4e with SMTP id l23-20020a1709060e1700b00993ffcbad4emr10760990eji.13.1689660267020;
        Mon, 17 Jul 2023 23:04:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906231600b00992e4d8cc89sm571966eja.57.2023.07.17.23.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:04:26 -0700 (PDT)
Message-ID: <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
Date:   Tue, 18 Jul 2023 08:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
To:     =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 06:01, 蔡承達 wrote:
>>
>> On 17/07/2023 11:01, 蔡承達 wrote:
>>> Guenter Roeck <linux@roeck-us.net> 於 2023年7月17日 週一 上午1:00寫道：
>>>>
>>>> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>
>>>>>> This patch serial doesn't use to binding the fan control h/w. It is
>>>>>> used to binding the two independent h/w blocks.
>>>>>> One is used to provide pwm output and another is used to monitor the
>>>>>> speed of the input.
>>>>>> My patch is used to point out that the pwm and the tach is the
>>>>>> different function and don't need to
>>>>>> bind together. You can not only combine them as the fan usage but also
>>>>>> treat them as the individual module for
>>>>>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
>>>>>> tach can be used to monitor the heart beat signal.
>>>>>
>>>>> Isn't this exactly the same as in every other SoC? PWMs can be used in
>>>>> different ways?
>>>>>
>>>>
>>>> ... and in every fan controller. Not that it really makes sense because
>>>> normally the pwm controller part of such chips is tied to the fan input,
>>>> to enable automatic fan control, but it is technically possible.
>>>> In many cases this is also the case in SoCs, for example, in ast2500.
>>>> Apparently this was redesigned in ast2600 where they two blocks are
>>>> only lightly coupled (there are two pwm status bits in the fan status
>>>> register, but I have no idea what those mean). If the blocks are tightly
>>>> coupled, separate drivers don't really make sense.
>>>>
>>>> There are multiple ways to separate the pwm controller part from the
>>>> fan inputs if that is really necessary. One would be to provide a
>>>> sequence of address mappings, the other would be to pass the memory
>>>> region from an mfd driver. It is not necessary to have N instances
>>>> of the fan controller, even if the address space is not continuous.
>>>>
>>>
>>> Hi Guenter,
>>>
>>> May I ask about the meaning of the sequence of address mappings? It appears
>>> to consist of multiple tuples within the 'reg' property, indicating
>>> the usage of PWM/Tach
>>> registers within a single instance. After that I can use the dts like following:
>>>
>>> pwm: pwm@1e610000 {
>>> ...
>>> reg = <0x1e610000 0x8
>>> 0x1e610010 0x8
>>> 0x1e610020 0x8
>>> 0x1e610030 0x8
>>> 0x1e610040 0x8
>>> 0x1e610050 0x8
>>> 0x1e610060 0x8
>>> 0x1e610070 0x8
>>> 0x1e610080 0x8
>>> 0x1e610090 0x8
>>> 0x1e6100A0 0x8
>>> 0x1e6100B0 0x8
>>> 0x1e6100C0 0x8
>>> 0x1e6100D0 0x8
>>> 0x1e6100E0 0x8
>>> 0x1e6100F0 0x8>;
>>
>>
>> Uh, no... I mean, why? We keep pointing out that this should not be done
>> differently than any other SoC. Open any other SoC PWM controller and
>> tell me why this is different? Why this cannot be one address space?
> 
> Hi Krzysztof,
> 
> This is because the register layout for PWM and Tach is not continuous.
> Each PWM/Tach instance has its own set of controller registers, and they
> are independent of each other.

Register layout is not continuous in many other devices, so again - why
this must be different?

> 
> For example:
> PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 and 0xc.
> PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x18 and 0x1c.
> ...
> 
> To separate the PWM controller part from the fan inputs, Guenter has
> provided two methods.
> The first method involves passing the memory region from an MFD
> driver, which was the

I have no clue how can you pass memory region
(Documentation/devicetree/bindings/reserved-memory/) from MFD and why
does it make sense here.

> initial method I intended to use. However, it seems that this method
> does not make sense to you.
> 
> Therefore, I would like to explore the second method suggested by
> Guenter, which involves providing
> a sequence of address mappings.

Best regards,
Krzysztof

