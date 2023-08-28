Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB378AC20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjH1KhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjH1KhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:37:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250BB9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:37:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so390494466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693219020; x=1693823820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXKNqL4IkjAZx8ALDSnWwXUafm6Syu0p3/vkPAUXVgM=;
        b=v1k638whdHBo4hUCkngFzIYxCDBin0XvP/jkQsTWxH0jsnHSG3mIPEftiODHn3HiAZ
         qZ+xDILXYkNkZ3Mz66WQkq9YjMY9f8HIO2bUzPtZx9/eXFUxI1osaWP8MyU/tYgBXGnd
         eb+bRB63ZcnA6kxjXBzOTDtTdQ/ZUAY+3znT8C85+MZtVv5VDeUKZj4Dx+/BzIRRgUn5
         0sqg/eFSOB+GHDDLFvn0cMN32O/esIzKBLfH+6zGiWmagQndTwSRRUlCKzeLIOhnTn4B
         SzYtvJ3ZmixCh5Eovbf1qbV3HktoZnRaikT7q+R1YVzVf5+cYyxz8WKLLpapa2vh5ZuM
         zExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219020; x=1693823820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXKNqL4IkjAZx8ALDSnWwXUafm6Syu0p3/vkPAUXVgM=;
        b=Cfq8F2i+u4fGnhH+/s+NREEX/EAYlf6G6yhhoJK5BpVGNkYLkyIUNQDOgm7YuA+YvT
         cVM1m4qybBsRb1tIwl03VH22YHHBRgtMC0Q/Gv9RpOgNF8/w8s1l74YBH4PB8HJDwnfJ
         k09RiWMDcGnLAd2NKYMtwgjhgRIPBY0Be0pKe1FJ+tALaemeHMzI9EjYf24fgUt2SiGv
         qTPP1y1XtDaXqu1jczpeh5wygu2LrjL/PJhsvkZ3aEcyaZf/B/LeZcDvVM7OUUDcWAkf
         g4RmJmXCx+WmMzTCCtAvk0TVIkUkRHfKl4ozXFfT8KOHPiI+HrlGNRAsdbphxxYDPxYp
         /z/w==
X-Gm-Message-State: AOJu0Yyi3+SN/kdoXlKDuSWBWdFGQDUaFvIPMYE5uXf+GUgBBeCnSSYT
        +MeUKdKdZXgdBsgmXvPYRdy5LQ==
X-Google-Smtp-Source: AGHT+IG3g61kWl/7b9A2JNiMon+0jr/1icvqwpp/HtI229jumk8p1OrSnYtrCpq97W05dbDwSl0LUg==
X-Received: by 2002:a17:907:7607:b0:9a1:c9c5:5fa1 with SMTP id jx7-20020a170907760700b009a1c9c55fa1mr12153327ejc.4.1693219020668;
        Mon, 28 Aug 2023 03:37:00 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906138a00b0099d959f9536sm4594759ejc.12.2023.08.28.03.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:37:00 -0700 (PDT)
Message-ID: <c984d558-11b5-d5ea-9819-7641129de584@linaro.org>
Date:   Mon, 28 Aug 2023 12:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20230827203612.173562-1-tmaimon77@gmail.com>
 <20230827203612.173562-2-tmaimon77@gmail.com>
 <eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org>
 <CAP6Zq1jj0WDbtL1zhr=tVyh2GPRy6-=oHjVURmJzNRm3n0HBNg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1jj0WDbtL1zhr=tVyh2GPRy6-=oHjVURmJzNRm3n0HBNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 12:26, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comments
> 
> On Mon, 28 Aug 2023 at 10:10, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/08/2023 22:36, Tomer Maimon wrote:
>>> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
>>> pinmux and GPIO controller.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>
>>
>>> +  '^pin':
>>> +    $ref: pincfg-node.yaml#
>>> +
>>> +    properties:
>>> +      pins:
>>> +        description:
>>> +          A list of pins to configure in certain ways, such as enabling
>>> +          debouncing
>>
>> What pin names are allowed?
> Do you mean to describe all the allowed pin items?
> for example:
>       items:
>         pattern:
> 'GPIO0/IOX1_DI/SMB6C_SDA/SMB18_SDA|GPIO1/IOX1_LD/SMB6C_SCL/SMB18_SCL'
> or
>       items:
>         pattern: '^GPIO([0-9]|[0-9][0-9]|[1-2][0-4][0-9]|25[0-6])$'
> 
> is good enough?

Something like this. Whichever is correct.

>>
>>> +
>>> +      bias-disable: true
>>> +

>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +
>>> +    soc {
>>> +      #address-cells = <2>;
>>> +      #size-cells = <2>;
>>> +
>>> +      pinctrl: pinctrl@f0800260 {
>>
>> Nothing improved here. Test your DTS. This is being reported - I checked.
> what do you suggest since the pinctrl doesn't have a reg parameter,
> maybe pinctrl: pinctrl@0?

It has ranges, so yes @0 looks correct here. Which leds to second
question - how pinctrl could have @0? It's already taken by SoC! So your
DTS here - unit address and ranges - are clearly wrong.


> BTW, I have run both dt_binding_check and W=1 dtbs_check, and didn't
> see an issue related to the pinctrl: pinctrl@f0800260, do I need to
> add another flag to see the issue?

Did you read my message last time? I said - it's about DTS, not the binding.



Best regards,
Krzysztof

