Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9667B6489
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjJCInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjJCInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:43:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF9A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:43:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso105841566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696322614; x=1696927414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SL97zAxIUC9k1IlgpaOnwdtJoVdfWSEq6aWQGA8726w=;
        b=UavXr8+dG7sEVWzswx8sHPDVXI/4uXgY6ufNiyYp//dvWWZ6AGDIAO5sioNyaGct/Q
         BwHnpo8QsPtJvLbWMbdRA/2tMes3lm/sS7BSYt/MWrL68oneuwyduOgof/SGoDNBdlid
         P5XsdJGhAKSJf7aaY9LlAJ6vm0J5Myx8THdq8VMo1QqcpNHjdUDSp9xwEGwytoXP3K93
         c/wjQozCWLrkIvT6Ljw3Nlpyi1/05T1pGuSCojuqQ7FgZiBqiahftfD/dzM/Z/yJeteV
         Ssx7eM7ygZ+UjTRYBXtTByy/I3nm8w3GBqUBTpk8MhX8wOy923DCUQ5g086aXLft8ePg
         zUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322614; x=1696927414;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL97zAxIUC9k1IlgpaOnwdtJoVdfWSEq6aWQGA8726w=;
        b=Zjw4UyJ1nX/coFMc/egF9yl50H9TQavv/rA/q6Q6vPjrq+Sy1yTbkZXSqNaVNOGGHH
         6xZ6wsSj0rJ6t+dpCZ1qrRfk9fJOtjh6Qb6FU3L0Y7V0FtnuZKp0o4Z6GuW5wX0rjOmL
         HAlRdFyws9Mdmub03n3GFbDp1ZxI/Ri51bhSYaTgaKVesw70kmP1feaXpzkfa2D6UlH3
         LjFTIxAlzOZ43tJnwgsSwqSa4q/gfli50ZjQ20CVCEniQXfH6VxSjYMwCBRJFE83nvz1
         rUUvnIOIR9tnhN0BGhav0HiD1ScgjZdnd7zBw99N6Th/wmORuHczHvstjlbkrl5rMSRB
         VuIQ==
X-Gm-Message-State: AOJu0Yxg2ipQWv3a738rO0RP2ehfee7uJsDjqPCONm3chQAL08O9ZlW7
        8J3OWvWofrZNhOugQcepOhGgyg==
X-Google-Smtp-Source: AGHT+IFGr95v474knEptRc4sLKxzKmvwMMtESgm8+6/Pm/LNuwEWolFDlu+ZB8H9cPZ3SjLCKg69PQ==
X-Received: by 2002:a17:906:24d:b0:9ae:5db5:149 with SMTP id 13-20020a170906024d00b009ae5db50149mr14054363ejl.35.1696322614150;
        Tue, 03 Oct 2023 01:43:34 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709063bc800b009ad8338aafasm693458ejf.13.2023.10.03.01.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:43:33 -0700 (PDT)
Message-ID: <ca6f8f30-c305-42bf-a812-b43561c4da2b@linaro.org>
Date:   Tue, 3 Oct 2023 10:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based
 gpio
Content-Language: en-US
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
 <20231002144155.GA1675188-robh@kernel.org> <ZRtjVnWhAK2CZaRM@octopus>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZRtjVnWhAK2CZaRM@octopus>
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

On 03/10/2023 02:41, AKASHI Takahiro wrote:
> Hi Rob,
> 
> On Mon, Oct 02, 2023 at 09:41:55AM -0500, Rob Herring wrote:
>> On Mon, Oct 02, 2023 at 11:16:02AM +0900, AKASHI Takahiro wrote:
>>> A dt binding for SCMI pinctrl based gpio driver is defined in this
>>> commit. It basically conforms to generic pinctrl-gpio mapping framework.
>>
>> What is "generic pinctrl-gpio mapping framework"? DT doesn't have 
>> frameworks.
> 
> I meant to refer to section 2.1-2.3 in "Documentation/devicetree/bindings/gpio/gpio.txt". The semantics is implemented in drivers/gpio/gpiolib(-of).c.

Linux specific GPIO library is as well outside of DT scope. Please focus
here on hardware, not Linux specifics.

> 
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  .../bindings/gpio/arm,scmi-gpio.yaml          | 71 +++++++++++++++++++
>>>  1 file changed, 71 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
>>> new file mode 100644
>>> index 000000000000..2601c5594567
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
>>> @@ -0,0 +1,71 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/gpio/arm,scmi-gpio.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SCMI pinctrl based generic GPIO controller
>>> +
>>> +maintainers:
>>> +  - AKASHI Takahiro <akashi.takahiro@linaro.org>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^scmi_gpio(@[0-9a-f]+)$"
>>
>> Not the correct name.
> 
> How not?

Underscores are no allowed and are pointed by dtc (W=2). scmi is
redundant here, because names should be generic. Anyway, we do not add
node name requirements to device schema.

> 
>>> +
>>> +  compatible:
>>> +    const: arm,scmi-gpio-generic
>>
>> What makes it generic? No such thing. Just drop '-generic'.
> 
> I will discuss this issue in following Cristian's comment.
> 
>>
>>> +
>>> +  gpio-controller: true
>>> +
>>> +  "#gpio-cells":
>>> +    const: 2
>>> +
>>> +  gpio-ranges: true
>>> +
>>> +  gpio-ranges-group-names: true
>>> +
>>> +patternProperties:
>>> +  "^.+-hog(-[0-9]+)?$":
>>> +    type: object
>>> +    properties:
>>> +      gpio-hog: true
>>> +      gpios: true
>>> +      input: true
>>> +      output-high: true
>>> +      output-low: true
>>> +      line-name: true
>>> +
>>> +    required:
>>> +      - gpio-hog
>>> +      - gpios
>>
>> You don't need all this just 'required: [ gpio-hog ]'. Then the hog 
>> schema will check the rest.
> 
> Okay.
> 
>>> +
>>> +    additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - gpio-controller
>>> +  - "#gpio-cells"
>>> +  - gpio-ranges
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +
>>> +    scmi_gpio_0: scmi_gpio@0 {
>>
>> gpio {
>>
>> But doesn't SCMI have protocol numbers?
>>
>>> +        compatible = "arm,scmi-gpio";
>>> +        gpio-controller;
>>> +        #gpio-cells = <2>;
>>> +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
>>> +                      <&scmi_pinctrl 5 0 0>;
>>> +        gpio-ranges-group-names = "",
>>> +                                  "pinmux_gpio";
>>> +    };
>>> +
>>> +    // Consumer:
>>
>> Outside the scope of this binding. Drop this node.
> 
> Even though it's in an example?
> "#gpio-cells" has a meaning in consumer side.

Just look at any other bindings.

Best regards,
Krzysztof

