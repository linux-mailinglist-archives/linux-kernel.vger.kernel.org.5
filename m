Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362387CD2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJRD0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRD02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:26:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E3BA;
        Tue, 17 Oct 2023 20:26:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf55a81eeaso43598565ad.0;
        Tue, 17 Oct 2023 20:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697599586; x=1698204386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHviYvEcpPmVkvkxsXVgEvF0IjYVpOyRZvIZTPHvuAc=;
        b=R0qQdZqwIgH9z/5NaNp0aLzqkLlX3Tr1WmKY0mW2oyg8BsqAlOpI9Wp1uUbBazaSlh
         3bXUaAgfw2ZBMWZPQ+O/o7Q5ZkjxlxTj8v8d/Gf7zPr1PRvk7U2L3+i+xjYLVEnq8YMs
         GcNcM0kkYYlAXRmmF7BxCWORMyejgNZDRLAcoPy9NA+mWgUI3I9Q5TSN+b6LgIkZJqYd
         yTiutZWD/9vvdIouXB0vVbATCj/fkoXotA/ZhK/3xC6dhFzq5nOipWOFCnaa+JUyBHuk
         HdHH6MDbOwXbyFVOgX9xc3+oYsYLIKiAdfDoDyoInYao3pZhcpNIaPJGCNnNf620VEtU
         nijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697599586; x=1698204386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHviYvEcpPmVkvkxsXVgEvF0IjYVpOyRZvIZTPHvuAc=;
        b=gz1XqWpQT1rwfdQhndJkCxuqFrBdjLF8aQpfpkwqpVv7lyKcSn+OHtdhng5vxNgjIz
         WqDc1CxtoDZlHisO5SlEfh+lZXtmKi+t8CCLFzvOc3oNEbpBvpYnva8ANqIvlS4LuhYH
         GAMfX7TWy/bJafgHuJL0rWNQz2pB3YKnci0fRRq4dkAQwkAgeTCV3ZQ/dnfl0SWuuA5j
         CSNswJvntmLBq3zs1uQhxK0UD7aB0KZkgUY+eOwGHk5q5LVffibkfTirzIjNd7WMBzie
         kIbrps3ifJldlLYL2nQ9bBRplywJQ65HeRJYr+HNECgjWwUAuexydx/vUYxm0akYCufK
         20rw==
X-Gm-Message-State: AOJu0YyWsP7Ydh4Hi45gPn58LaD+kWb/Q3iFSutaSid8AXVLGZ3PfYoY
        s1xYCreJ7yXWEWOyDdNUdLOQ/RW8QMI=
X-Google-Smtp-Source: AGHT+IFw85MD3M6uPf/yTnwSEICiOIUnNEgW2hmGP7tvPfmUGI+pJ+r5CWuCD+qsBdx+/YR8e9yRsg==
X-Received: by 2002:a17:902:c649:b0:1c4:4462:f1bd with SMTP id s9-20020a170902c64900b001c44462f1bdmr3340196pls.35.1697599586067;
        Tue, 17 Oct 2023 20:26:26 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902c25400b001c9b70609e8sm2336469plg.256.2023.10.17.20.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 20:26:25 -0700 (PDT)
Message-ID: <8e983479-709f-4ec8-85e2-c46a5256a2ec@gmail.com>
Date:   Wed, 18 Oct 2023 11:26:21 +0800
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
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <254837e5-a0fa-4796-8928-277db4b98bf1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for the review.


On 2023/10/17 上午 03:52, Krzysztof Kozlowski wrote:
> On 16/10/2023 06:32, Jacky Huang wrote:
>>>> +  '#size-cells':
>>>> +    const: 1
>>>> +
>>>> +  nuvoton,sys:
>>>> +    description:
>>>> +      phandle to the syscon node
>>> sys is quite generic. Description explains nothing except duplicating
>>> known information. Drop duplicated info and instead explain to what this
>>> phandle points and how it is going to be used.
> Read comments carefully.


I will update the description of 'nuvoton,sys'.

>
>>>
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    items:
>>>> +      maxItems: 1
>>> So just phandle, not phandle-array, unless it is defined like this in
>>> some other binding.
>> I would like to update this as:
>>
>>     nuvoton,sys:
> Nothing improved.

Here just fix  the 'phandle-array' to 'phandle' and remove 'maxItems'.

>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description:
>>         Help pinctrl driver to access system registers by means of regmap.
> Driver is not relevant here. Say which part of syscon are necessary for
> pinctrl operation.
>

I will update description as:

   nuvoton,sys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The pin function control registers are located in the system
       control register space. This phandle provides pinctrl the
       ability to access the pin function control registers through
       the use of regmap.


>>
>>
>>>> +
>>>> +  ranges: true
>>>> +
>>>> +allOf:
>>>> +  - $ref: pinctrl.yaml#
>>> allOf: goes after required: block.
>> I will fix it.
>>
>>>> +
>>>> +patternProperties:
>>>> +  "gpio[a-n]@[0-9a-f]+$":
>>> ^gpio@[0-9a-f]+$":
>> I will fix this, and also fix the dtsi.
>>
>>>> +    type: object
>>>> +    additionalProperties: false
>>>> +    properties:
>>>> +
>>> Drop blank line
>> I will fix it.
>>
>>>> +      gpio-controller: true
>>>> +
>>>> +      '#gpio-cells':
>>>> +        const: 2
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +
>>>> +      clocks:
>>>> +        maxItems: 1
>>>> +
>>>> +      interrupt-controller: true
>>>> +
>>>> +      '#interrupt-cells':
>>>> +        const: 2
>>>> +
>>>> +      interrupts:
>>>> +        description:
>>>> +          The interrupt outputs to sysirq.
>>>> +        maxItems: 1
>>>> +
>>>> +    required:
>>>> +      - reg
>>>> +      - interrupts
>>>> +      - interrupt-controller
>>>> +      - '#interrupt-cells'
>>>> +      - gpio-controller
>>>> +      - '#gpio-cells'
>>> Keep the same order as in list of properties.
>> I will fix the order.
>>
>>>> +
>>>> +  "pcfg-[a-z0-9-.]+$":
>>> Why using different naming than other Nuvoton SoCs? You also accept
>>> "foobarpcfg-1", which does not look intentional.
>>>
>> I will use '"^pin-[a-z0-9-.]+$" instead.
> [.] is redundant... What exactly do you want to match?

I want to match the name like "-1.8v" or "-3.3v".
However, this should be specified in the property, so I will drop the "-.".


>>
>>>> +    type: object
>>>> +    description:
>>>> +      A pinctrl node should contain at least one subnodes representing the
>>>> +      pinctrl groups available on the machine. Each subnode will list the
>>>> +      pins it needs, and how they should be configured, with regard to muxer
>>>> +      configuration, pullups, drive strength, input enable/disable and input
>>>> +      schmitt.
>>>> +
>>>> +    allOf:
>>>> +      - $ref: pincfg-node.yaml#
>>> missing additional/unevaluatedProperties: false.
>> I will add unevaluatedProperties: false.
>>
>>>> +
>>>> +    properties:
>>>> +      bias-disable: true
>>> Why do you need this and other ones?
>> We expect the pin configuration to select one of ==>
>> bias-disable;
>> bias-pull-down;
>> bias-pull-up;
>>
>> This is the same as rockchip,pinctrl.yaml and renesas,rzv2m-pinctrl.yaml.
> OK, then go with nuvoton approach. List the properties (:true) and use
> additionalProperties: false.

I got it.

>>>> +
>>>> +      bias-pull-down: true
>>>> +
>>>> +      bias-pull-up: true
>>>> +
>>>> +      drive-strength:
>>>> +        minimum: 0
>>> 0 mA? Is it really valid? Are you sure you used correct property?
>> We treat this value as the value to be written to the control register,
>> not as
>> a current value in mA. I will correct this mistake.
> Instead treat it as mA. Is this possible?

I will update it as:

       drive-strength-microamp:
         oneOf:
           - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
             description: 1.8V I/O driving strength
           - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 
82000 ]
             description: 3.3V I/O driving strength

And use a lookup table in the pinctrl driver to translate it into 
register value.


>>>> +        maximum: 7
>>>> +
>>>> +      input-enable: true
>>>> +
>>>> +      input-schmitt-enable: true
>>>> +
>>>> +      power-source:
>>>> +        description:
>>>> +          I/O voltage in millivolt.
>>>> +        enum: [ 1800, 3300 ]
>>> Missing units in property name. power-source also does not really
>>> describe the property.
>>
>> The output voltage level of GPIO can be configured as 1.8V or 3.3V,
>> but I cannot find any suitable output properties in 'pincfg-node.yaml.'
> There is actually power-source, but treated as actual choice of power
> supplies.
>
>> I noticed that 'xlnx,zynq-pinctrl.yaml' and 'xlnx,zynq-pinctrl.yaml' use
>> 'power source' to specify the output voltage.  Should I follow their
>> approach or define a vendor-specific one?
> Maybe Rob or Linus have here some recommendation, but I would suggest to
> go either with rtd1319d-pinctrl.yaml approach or add a generic property
> to pincfg-node expressed in real units like "io-microvolt".

OK, I will update it as:

       power-source:
         description: |
           Valid arguments are described as below:
           0: power supply of 1.8V
           1: power supply of 3.3V
         enum: [0, 1]


> Rob, Linus, any ideas for generic property replacing register-specific
> power-source?
>
>
> Best regards,
> Krzysztof
>

Best Regards,
Jacky Huang

