Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844E7BD75F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbjJIJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbjJIJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:42:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96217A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:42:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50308217223so5384659e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696844530; x=1697449330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DhwIR/TEsxYLvB0Erz8lks6ITQCb2MJgXSQrF/MM4=;
        b=F3c6FravOzbodut9dnbmEvObrXRAuCX2ql7OQ+b+qyrSAiLAhdQt6Ue4E7GjPerwCG
         HW6cmOiZ2kFw4NzD2GDSSTC2KpA7jZuP7jjvAtf9g/dxtK27R+b/Gg5/2gwHNIK/KyzE
         mjyX4iATZb5Y7VCLep6+V9qw2OA5uWe1BupDPoMJtX89syI0f5o4IzYUVeN8wb0uRLkt
         gyPvwXcNgmmJN+iN3Fpe/T6ynjdVXgXKEfVIzV2hSy4A4FTxiMwL5JiwjE3F1XHcOCVO
         4v0WhEEw7fwuZ1n7M4J8pV9jIWcjeOrSaDwDG907qj6n6FvWOYLX3WQGu5WQpDSl5WHQ
         AKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844530; x=1697449330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/DhwIR/TEsxYLvB0Erz8lks6ITQCb2MJgXSQrF/MM4=;
        b=rp2cP2gJiehvuPSht+awPvMKdqpUT2o2igqpO++CBJIvMDkmGXOEYTMlLUGXA/XMsQ
         1WPuSC2tpFVbaOw2rkos4abLD9+KOROOeaUj1jNCg9vvmwPuEY/xh1gi/H6iE9Ca7gC7
         Nt0rQzQ8RSvN5HS+opqunMHa2AoJt0bQTYUroA7h/YW7N46f8XqBlLV1NG7mI8hr+loQ
         Nd9CsGQ46pdA9l6Xn4DtKDWxYQeDFAQjaNm9XtVaQLWwF2fSpGvtkGTd8hnVv7IFByZV
         rdjrI7coVFScjs8Kgs39TjSqYa6yBsRmegVuhC6JDWGvDwCyWkR3/ByGFY9LCDRY7JFF
         NsRw==
X-Gm-Message-State: AOJu0YweFuhxwV/MnDyrDVU4Ab/jLcLvZJPtBvNHEl4xfI1bwxbHGBTF
        JgzHHbVUlBNXgQt6MOHXkVWszA==
X-Google-Smtp-Source: AGHT+IHN1qZlPIufcgW0ntP7Gk4gW6+oibZ0P4vLTbaymcFoc63INE8W5gN80F5jIaFN5kmEcQXTng==
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id q5-20020ac24a65000000b00500c2d73ab4mr11239943lfp.8.1696844529780;
        Mon, 09 Oct 2023 02:42:09 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm13025587wmb.34.2023.10.09.02.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:42:09 -0700 (PDT)
Message-ID: <82e30bd1-b7b4-4d95-9f13-008398082ca0@linaro.org>
Date:   Mon, 9 Oct 2023 11:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO
 base warning
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
 <20231006125557.212681-1-m.majewski2@samsung.com>
 <CAPLW+4kmA6iYDPFxyASHLJifz63DRxT9gqQ-AsMAVy0RzoaFRw@mail.gmail.com>
 <04260159-f5a8-47f7-b267-33f4ea19b8a6@linaro.org>
 <CAPLW+4nyLunQw+wCxQmw9VDCGx2ECeAhUzjKRCBeHW7fGS1dFA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPLW+4nyLunQw+wCxQmw9VDCGx2ECeAhUzjKRCBeHW7fGS1dFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2023 20:45, Sam Protsenko wrote:

>>>
>>> Thank you for handling this! Those deprecation warnings have been
>>> bugging me for some time :) While testing this series on my E850-96
>>> board (Exynos850 based), I noticed some changes in
>>> /sys/kernel/debug/gpio file, like these:
>>>
>>> 8<------------------------------------------------------------------------------------------>8
>>> -gpiochip0: GPIOs 0-7, parent: platform/11850000.pinctrl, gpa0:
>>> - gpio-7   (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
>>> +gpiochip0: GPIOs 512-519, parent: platform/11850000.pinctrl, gpa0:
>>> + gpio-519 (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
>>>
>>> -gpiochip1: GPIOs 8-15, parent: platform/11850000.pinctrl, gpa1:
>>> - gpio-8   (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
>>> +gpiochip1: GPIOs 520-527, parent: platform/11850000.pinctrl, gpa1:
>>> + gpio-520 (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
>>>
>>> -gpiochip2: GPIOs 16-23, parent: platform/11850000.pinctrl, gpa2:
>>> +gpiochip2: GPIOs 528-535, parent: platform/11850000.pinctrl, gpa2:
>>>
>>> ...
>>> 8<------------------------------------------------------------------------------------------>8
>>>
>>> So basically it looks like all line numbers were offset by 512. Can
>>> you please comment on this? Is it an intentional change, and why it's
>>> happening?
>>>
>>> Despite of that change, everything seems to be working fine. But I
>>> kinda liked the numeration starting from 0 better :)
>>
>> Could it be the reason of dynamic allocation?
>>
> 
> I just asked because I didn't know :) But ok, if you want me to do
> some digging... It seems like having GPIO_DYNAMIC_BASE=512 is not
> necessarily the reason of dynamic allocation, but instead just a way
> to keep 0-512 range for legacy GPIO drivers which might use that area
> to allocate GPIO numbers statically. It's mentioned here:
> 
>     /*
>      * At the end we want all GPIOs to be dynamically allocated from 0.
>      * However, some legacy drivers still perform fixed allocation.
>      * Until they are all fixed, leave 0-512 space for them.
>      */
>     #define GPIO_DYNAMIC_BASE    512
> 
> As mentioned in another comment in gpiochip_add_data_with_key(), that
> numberspace shouldn't matter and in the end should go away, as GPIO
> sysfs interface is pretty much deprecated at this point, and everybody
> should stick to GPIO descriptors.
> 
> Anyway, now that it's clear that the base number change was intended
> and shouldn't matter, for all patches in the series:
> 
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>

If all the GPIOs changed due to switch to dynamic allocation, aren't we
breaking all user-space users?

Best regards,
Krzysztof

