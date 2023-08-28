Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1578AC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjH1Kj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjH1Kjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:39:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A280A7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:39:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso4132255a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693219176; x=1693823976;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbEjmLs3QGz39aRMzKs8Sd0VII9u+eayDuhczUIkBCc=;
        b=qzH8IW/9bJOId1PwuIVHVWgdvL3q8g/A85mFFHUilHyvwAUo9+ErZ6cykB9dlz6Mo7
         q1yJUjhQkb2Ze2xoZ7OR58A2OkggDhupqjAP0j1KW/jFzD9GeMd4KybjFdEn4AjeT7o2
         NznptOyByTzZc5XSSeD8PtT9u5UoSgaJARmwnSGladd00kDAMgitAJaFcb/Tc0YqwnLQ
         MX3KgwlKqtG0B7DyK4qHoUm+GtbfBMQm2pKgNuAto8AEhYsHI8MRxZ0PxkAaLjIEWpFy
         TN9lGfbql4Yu+4pumOSKhdd6PQSh+/KSxxK4PPnLektYdkSgpnCLtuOinoj3VnaNe1mq
         SnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219176; x=1693823976;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbEjmLs3QGz39aRMzKs8Sd0VII9u+eayDuhczUIkBCc=;
        b=ZGzwDGMEDue/XH9SSQLVafpCHnaEEoDr6BdoBH8N4ihpkdIjDM3F9qf7OBo1Ue5wO3
         b2CaCpzKnvCBHTytCcKlVTrmnpLAQRVORY49TatimX6pZ+OUKdfJTALtN8dnYyf44TXp
         fT5RYaGj5vo58YW03UbXelgiIefbzgItYON8bBMr8bwtlvMpecCl8mBZ6vQhDr/SllIQ
         5mMCkr2orOeX//4RZKqCCJo+B2tum5NlwvXUp91L9B2eV5NwG+HeQP7XOmd544XM4Vx2
         uL1oC7+7bk9lIKGPCIJvDoNGBBN4vetL9PGrHudHmA8dHAL69ja+50lpQpBdsE7a64BF
         GM+Q==
X-Gm-Message-State: AOJu0YxXAf63hT3lqKW5Djoc5Y9YnIV2Ode2F7KnHT0dtPArswZTogjb
        wabVcn7vI0f6v7GJTLbLvIOQKw==
X-Google-Smtp-Source: AGHT+IER1RoTJpN/WOl8lPgg7vlmqwVHY7D+CYcCIMJfB2n7O3GNWanGpZdgdieT4PyEMRlOc8xOcw==
X-Received: by 2002:aa7:d058:0:b0:51b:d567:cfed with SMTP id n24-20020aa7d058000000b0051bd567cfedmr21575438edo.5.1693219175747;
        Mon, 28 Aug 2023 03:39:35 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id y21-20020aa7c255000000b005257da6be23sm4302550edo.75.2023.08.28.03.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:39:35 -0700 (PDT)
Message-ID: <5c0d985a-0492-778c-46b9-80899e52134c@linaro.org>
Date:   Mon, 28 Aug 2023 12:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <c984d558-11b5-d5ea-9819-7641129de584@linaro.org>
In-Reply-To: <c984d558-11b5-d5ea-9819-7641129de584@linaro.org>
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

On 28/08/2023 12:36, Krzysztof Kozlowski wrote:
> On 28/08/2023 12:26, Tomer Maimon wrote:
>> Hi Krzysztof,
>>
>> Thanks for your comments
>>
>> On Mon, 28 Aug 2023 at 10:10, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 27/08/2023 22:36, Tomer Maimon wrote:
>>>> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
>>>> pinmux and GPIO controller.
>>>>
>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>
>>>
>>>> +  '^pin':
>>>> +    $ref: pincfg-node.yaml#
>>>> +
>>>> +    properties:
>>>> +      pins:
>>>> +        description:
>>>> +          A list of pins to configure in certain ways, such as enabling
>>>> +          debouncing
>>>
>>> What pin names are allowed?
>> Do you mean to describe all the allowed pin items?
>> for example:
>>       items:
>>         pattern:
>> 'GPIO0/IOX1_DI/SMB6C_SDA/SMB18_SDA|GPIO1/IOX1_LD/SMB6C_SCL/SMB18_SCL'
>> or
>>       items:
>>         pattern: '^GPIO([0-9]|[0-9][0-9]|[1-2][0-4][0-9]|25[0-6])$'
>>
>> is good enough?
> 
> Something like this. Whichever is correct.
> 
>>>
>>>> +
>>>> +      bias-disable: true
>>>> +
> 
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>> +
>>>> +    soc {
>>>> +      #address-cells = <2>;
>>>> +      #size-cells = <2>;
>>>> +
>>>> +      pinctrl: pinctrl@f0800260 {
>>>
>>> Nothing improved here. Test your DTS. This is being reported - I checked.
>> what do you suggest since the pinctrl doesn't have a reg parameter,
>> maybe pinctrl: pinctrl@0?
> 
> It has ranges, so yes @0 looks correct here.

Wait, your address according to ranges is 0xf0010000, not 0x0, not
0xf0800260...


> Which leds to second
> question - how pinctrl could have @0? It's already taken by SoC! So your
> DTS here - unit address and ranges - are clearly wrong.
> 
> 
>> BTW, I have run both dt_binding_check and W=1 dtbs_check, and didn't
>> see an issue related to the pinctrl: pinctrl@f0800260, do I need to
>> add another flag to see the issue?
> 
> Did you read my message last time? I said - it's about DTS, not the binding.

Best regards,
Krzysztof

