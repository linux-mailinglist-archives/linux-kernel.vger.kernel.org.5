Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32247755F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGQJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjGQJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:40:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BA3C2A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:39:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso878635466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689586744; x=1692178744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0Abj6UC9IBcOuGYotmVfSuiZNB5aYWz62cWUjDEEUg=;
        b=oNVQ4IxLU5eX07C5sklU29DxI6u6wg6e2WB+o1jYa8ec1pIsG+BAHCXbIxFDRp3qTl
         /dzmITQUrQQAtrbiRbTKZ7mq/rdWdu+IY4bT2jTa5aUo9wx6WkrAvvLb0bRSd7M0ZydQ
         b29rvFfZZGyNnhzH4VVO4rGTo0TGUdB9O6a27CQXtCHKjU0W1AvEl5NC9OA7pA5Ua0WT
         2QAa11Z87kgv9ExsFKCWzMZMoLOgRhBMS8YGxwsV7sbWrTqGIVGhrip83rrcvyfi851o
         rJzoec2YkfyS05pvyryJhBl8FoshXHTLwU2JZW7ssjAP1OaNkbGfKIRVXNLz5N+4DxLD
         lKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586744; x=1692178744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0Abj6UC9IBcOuGYotmVfSuiZNB5aYWz62cWUjDEEUg=;
        b=BhQweT+OvGWq/kAcu8nErtCRQGST55x24b+KrMsdI2ZgxD334DOKTIcBql1NowdN50
         UZ8Qsm757WOL3xZQIwxtX3GALDFoVzDbmA0pxX4Vpvy5HulWln/EPYZt/u+prunBT3Lm
         a+8bbRjrlupr4+2lq8TNbEHr9iHvwlv6RiyZG97FwlaBMW5OgfEh5DuHw/pofAXW6I5k
         /oBlGacsNij4gnJ0FptQOBcsp/ELj9vIV82gi8W2EPHT/APl4YbkQfU/78YAfvPPKZi8
         +hSCzsdj0KAiDvOG4z/W1UFORSqnaDgVzTEgPzWf9HQqK2n61utlshLI0sk+4IHsQt4e
         CAYg==
X-Gm-Message-State: ABy/qLaf+WTpaU0k9x+hgEUvfP+t9cZyx/i8MWml+HAsge07ubyMLU27
        3DoAv1KhCswfFBJGv+ZC+MuroA==
X-Google-Smtp-Source: APBJJlESrTNaJcx/BujEXJeNKPZNlBYFJGnbXsuE/wnWYk8Pltb8LBwpD6Msb01kwBYC5AzGsjQodw==
X-Received: by 2002:a17:906:28a:b0:988:15f4:fdba with SMTP id 10-20020a170906028a00b0098815f4fdbamr12038269ejf.14.1689586744230;
        Mon, 17 Jul 2023 02:39:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ov4-20020a170906fc0400b00992b50fbbe9sm9051066ejb.90.2023.07.17.02.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:39:03 -0700 (PDT)
Message-ID: <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
Date:   Mon, 17 Jul 2023 11:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
To:     =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 11:01, 蔡承達 wrote:
> Guenter Roeck <linux@roeck-us.net> 於 2023年7月17日 週一 上午1:00寫道：
>>
>> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
>>
>> [ ... ]
>>
>>>>
>>>> This patch serial doesn't use to binding the fan control h/w. It is
>>>> used to binding the two independent h/w blocks.
>>>> One is used to provide pwm output and another is used to monitor the
>>>> speed of the input.
>>>> My patch is used to point out that the pwm and the tach is the
>>>> different function and don't need to
>>>> bind together. You can not only combine them as the fan usage but also
>>>> treat them as the individual module for
>>>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
>>>> tach can be used to monitor the heart beat signal.
>>>
>>> Isn't this exactly the same as in every other SoC? PWMs can be used in
>>> different ways?
>>>
>>
>> ... and in every fan controller. Not that it really makes sense because
>> normally the pwm controller part of such chips is tied to the fan input,
>> to enable automatic fan control, but it is technically possible.
>> In many cases this is also the case in SoCs, for example, in ast2500.
>> Apparently this was redesigned in ast2600 where they two blocks are
>> only lightly coupled (there are two pwm status bits in the fan status
>> register, but I have no idea what those mean). If the blocks are tightly
>> coupled, separate drivers don't really make sense.
>>
>> There are multiple ways to separate the pwm controller part from the
>> fan inputs if that is really necessary. One would be to provide a
>> sequence of address mappings, the other would be to pass the memory
>> region from an mfd driver. It is not necessary to have N instances
>> of the fan controller, even if the address space is not continuous.
>>
> 
> Hi Guenter,
> 
> May I ask about the meaning of the sequence of address mappings? It appears
> to consist of multiple tuples within the 'reg' property, indicating
> the usage of PWM/Tach
> registers within a single instance. After that I can use the dts like following:
> 
> pwm: pwm@1e610000 {
> ...
> reg = <0x1e610000 0x8
> 0x1e610010 0x8
> 0x1e610020 0x8
> 0x1e610030 0x8
> 0x1e610040 0x8
> 0x1e610050 0x8
> 0x1e610060 0x8
> 0x1e610070 0x8
> 0x1e610080 0x8
> 0x1e610090 0x8
> 0x1e6100A0 0x8
> 0x1e6100B0 0x8
> 0x1e6100C0 0x8
> 0x1e6100D0 0x8
> 0x1e6100E0 0x8
> 0x1e6100F0 0x8>;


Uh, no... I mean, why? We keep pointing out that this should not be done
differently than any other SoC. Open any other SoC PWM controller and
tell me why this is different? Why this cannot be one address space?

Best regards,
Krzysztof

