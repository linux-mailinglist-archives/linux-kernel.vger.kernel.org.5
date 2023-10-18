Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5347CD4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjJRHBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJRHBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:01:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA30EA;
        Wed, 18 Oct 2023 00:01:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af64a4c97eso3541161b6e.2;
        Wed, 18 Oct 2023 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697612471; x=1698217271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tov+DeHbMDyFN68SZwsGVOS2MZy5FzMU6m+ne5E245U=;
        b=Yi/XMZl99IiN5bZ2LcG4J1OEsY2viC3Oiyp+UldAl2t0A5eE6IeUZ6JPLM7xN030NA
         NwtUFMvM557yqUVtbcS4sW93HLtV6c9V1tOrbfhsMCj0zBJZGxtyEhw5VxQO5HhKLc1P
         bOtm5q3GX5MDJiRpLUWi/BWmzkk2bAYQ3AjF+G6/ixoqGyHne16QHRujJzdAOYt6WF91
         D2GEJhgXK+PqU0ipNzvO3XoIVUFuoQzmSqaN8W1MLPzswpegVAJ0rBTowYXsAU3opO5C
         Gne1lOlLo3xnKAEK2MA7Gs9rMXj41qKm8jf92caLB/z8DXPMxLchFpUIj7A9RlVvJVmy
         L/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612471; x=1698217271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tov+DeHbMDyFN68SZwsGVOS2MZy5FzMU6m+ne5E245U=;
        b=FHesfya3eGD84jB6U2wJ+Ke9GIbf+HpnNN36pm1WuWiAZwWFwkQH00AaUCwmRX9TGf
         JYAUQI57d5MpIvkS0Ddj6iKGG+TnHBbxSB6jIuQhj6jgIN8uTgSrihqnWpyO6Y+p6BYE
         A8//wZOkjH1NZ/4vCFsPKtYRYpNhO/+NZ1b2AXWR1g4QUJ50Uk5imOMsy1PoMOa62aww
         AXW49wnl6LVTXd8C490FWU3tAickiOnKYWoFjRj376ztMCYMT5FyGNEr8yQUIeyidc0j
         ZfTT23PFTQuyqf+6NDn3cQBydiRqNGEe3E7ZBk9LWyYNYyndIJCSAvisGJy46c77i/kU
         9FQQ==
X-Gm-Message-State: AOJu0YzIiB2JJHwJpji1RDiM4Re/ZoLCsAWO7wPM1iu+pF3smM7eEgxi
        dOUzq0nuAS8MzBsOvfwGp10=
X-Google-Smtp-Source: AGHT+IHuFPGzG5oAjQAaVoMsTLGtwkHHQikVV0uYP5h0bMdQO8i1S2N/GDe9xxq//owE/NrzK42asQ==
X-Received: by 2002:aca:1717:0:b0:3a7:4161:44ee with SMTP id j23-20020aca1717000000b003a7416144eemr4142855oii.6.1697612471317;
        Wed, 18 Oct 2023 00:01:11 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n5-20020a654cc5000000b00565e96d9874sm850346pgt.89.2023.10.18.00.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:01:10 -0700 (PDT)
Message-ID: <c6394168-97a3-46c7-839a-ec0928ffb3b5@gmail.com>
Date:   Wed, 18 Oct 2023 15:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-3-ychuang570808@gmail.com>
 <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
 <17a80031-98bf-48bf-8cea-c0ca4400f142@gmail.com>
 <254837e5-a0fa-4796-8928-277db4b98bf1@linaro.org>
 <8e983479-709f-4ec8-85e2-c46a5256a2ec@gmail.com>
 <6c8a3ed2-879c-4423-b6e7-80f8b127a1c1@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <6c8a3ed2-879c-4423-b6e7-80f8b127a1c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Krzysztof,

Thank you for the review.


On 2023/10/18 下午 01:58, Krzysztof Kozlowski wrote:
> On 18/10/2023 05:26, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>> Thank you for the review.
>>
>>
>> On 2023/10/17 上午 03:52, Krzysztof Kozlowski wrote:
>>> On 16/10/2023 06:32, Jacky Huang wrote:
>>>>>> +  '#size-cells':
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  nuvoton,sys:
>>>>>> +    description:
>>>>>> +      phandle to the syscon node
>>>>> sys is quite generic. Description explains nothing except duplicating
>>>>> known information. Drop duplicated info and instead explain to what this
>>>>> phandle points and how it is going to be used.
>>> Read comments carefully.
>>
>> I will update the description of 'nuvoton,sys'.
> What is the full name of destination block?


The full name is 'system-management'. From:

         sys: system-management@40460000 {
             compatible = "nuvoton,ma35d1-reset", "syscon";
             reg = <0x0 0x40460000 0x0 0x200>;
             #reset-cells = <1>;
         };


>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>> +    items:
>>>>>> +      maxItems: 1
>>>>> So just phandle, not phandle-array, unless it is defined like this in
>>>>> some other binding.
>>>> I would like to update this as:
>>>>
>>>>      nuvoton,sys:
>>> Nothing improved.
>> Here just fix  the 'phandle-array' to 'phandle' and remove 'maxItems'.
>>
>>>>        $ref: /schemas/types.yaml#/definitions/phandle
>>>>        description:
>>>>          Help pinctrl driver to access system registers by means of regmap.
>>> Driver is not relevant here. Say which part of syscon are necessary for
>>> pinctrl operation.
>>>
>> I will update description as:
>>
>>     nuvoton,sys:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description:
>>         The pin function control registers are located in the system
>>         control register space. This phandle provides pinctrl the
>>         ability to access the pin function control registers through
>>         the use of regmap.
> regmap is unrelated to the bindings.

So, I will just update the description as:

phandle of the system-management node.


>>>>>> +        maximum: 7
>>>>>> +
>>>>>> +      input-enable: true
>>>>>> +
>>>>>> +      input-schmitt-enable: true
>>>>>> +
>>>>>> +      power-source:
>>>>>> +        description:
>>>>>> +          I/O voltage in millivolt.
>>>>>> +        enum: [ 1800, 3300 ]
>>>>> Missing units in property name. power-source also does not really
>>>>> describe the property.
>>>> The output voltage level of GPIO can be configured as 1.8V or 3.3V,
>>>> but I cannot find any suitable output properties in 'pincfg-node.yaml.'
>>> There is actually power-source, but treated as actual choice of power
>>> supplies.
>>>
>>>> I noticed that 'xlnx,zynq-pinctrl.yaml' and 'xlnx,zynq-pinctrl.yaml' use
>>>> 'power source' to specify the output voltage.  Should I follow their
>>>> approach or define a vendor-specific one?
>>> Maybe Rob or Linus have here some recommendation, but I would suggest to
>>> go either with rtd1319d-pinctrl.yaml approach or add a generic property
>>> to pincfg-node expressed in real units like "io-microvolt".
>> OK, I will update it as:
>>
>>         power-source:
>>           description: |
>>             Valid arguments are described as below:
>>             0: power supply of 1.8V
>>             1: power supply of 3.3V
>>           enum: [0, 1]
>>
>>
>>> Rob, Linus, any ideas for generic property replacing register-specific
>>> power-source?
> I proposed io-microvolt
>
> Best regards,
> Krzysztof
>

I will use 'io-microvolt' once it is available.



Best Regards,
Jacky Huang

