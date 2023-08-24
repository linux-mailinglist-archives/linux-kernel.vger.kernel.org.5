Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304E78677A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjHXG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjHXG1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:27:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90E137
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:27:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so7951450a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692858420; x=1693463220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNCdYqQUps0lM4Vetry0zqGJRLv4Xo41z8z74LlzZb4=;
        b=Xo5tYdr4AOaUWBl9YgA2xLc+5vPD866bVqitEfg1TfsSsnS56D0YlqbwLQ8cSBZA0f
         LDLgSKlNH8dcTXg7IUj0IE9C2PUDygKYV+c37UHVkaTxJ2Tlja9VxXo/LEx6Q86eDht1
         fDtYy6b1x4Dimjwd21qkx0UclkRmsvzcsQhQU6W/R2CRmDFixrI6JxhD7iJrA7gZIQv2
         Rdcj7Cznd7ofiATaoPg4XQfw/jFOj+yw50ZmNEZS3MAAslBmMKJSPTchpxPQo4w2ewlQ
         JfPH6fvGIWDVJIuVkl2Ibbtq8K0hpctiQQScEAklaft/snw+V9KkQ9zKQtWdMVU4wXfQ
         mzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858420; x=1693463220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNCdYqQUps0lM4Vetry0zqGJRLv4Xo41z8z74LlzZb4=;
        b=RrAuYV+YUhFqNNWIUQz1YdJMBJivbW+2sqTzZwFRSZZynvFLYzY8SqpBkGY8pL9jNx
         ullmSsI1d8OEfCer1eZ0n2RN6uA05g7MDf5jTB7wpcDqCyKLBCwzM1eKWvCpv9q8Z14X
         aqLHx1oo5yA+belsUcNJVxio4Aj0N9nWSwuPYb63Hdf8oNrE8l1ISF1IMUvoVN8W4gnh
         V2iPk8ce5utkIOCvlhbKdnOSY0l2WrIEZh1n1TGFpWcHF2WyT//vkPo89t4iBCK87q0w
         u62U/hLpwc1QBN+Z/WxoC4kRj1wg/E4nFh5Un+vc8S5vdhHaL+cnugrYAtOiW0PevXzc
         Ac3A==
X-Gm-Message-State: AOJu0YzwPuLDMMu7LxP3FQpHwl8oO1ZEsZtzE/fe8tC2hVAuLYQI7pkV
        zvgFacUJRKVxWn/zCQT1PuPJuQ==
X-Google-Smtp-Source: AGHT+IFaKPL1GVeABrkF8YiNtStdFGw2o9uVH285QObhdfvwGKEaqB3vttmpLJpDTcJl19n6m4VyTw==
X-Received: by 2002:aa7:d5c5:0:b0:523:1410:b611 with SMTP id d5-20020aa7d5c5000000b005231410b611mr11092414eds.25.1692858419763;
        Wed, 23 Aug 2023 23:26:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id p6-20020aa7d306000000b0052574ef0da1sm9966034edq.28.2023.08.23.23.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:26:59 -0700 (PDT)
Message-ID: <50ce8e71-613e-1ef5-0c23-67a2f6f78949@linaro.org>
Date:   Thu, 24 Aug 2023 08:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC
 Type-C
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
 <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
 <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 08:03, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
>> On 22/08/2023 12:28, Stanley Chang wrote:
>>> Document the device-tree bindings for Realtek SoCs Type-C.
>>> Realtek DHC (digital home center) RTD SoCs support a Type-C module.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>> ---
>>>  .../bindings/extcon/extcon-rtk-type-c.yaml    | 77 +++++++++++++++++++
>>>  1 file changed, 77 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
>>
>> Filename like compatible.
> 
> I will rename.
> 
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
>>> b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
>>> new file mode 100644
>>> index 000000000000..d14b9ee544b9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
>>> @@ -0,0 +1,77 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
>>> +2023 Realtek Semiconductor Corporation %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/extcon/extcon-rtk-type-c.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Realtek DHC RTD SoCs USB Type-C detection
>>
>> Type-c usually go to usb directory.
> 
> This binding is not for a type-c controller.
> It is an extcon device for type-c connector detection.
> So I put it at extcon directory.

If this is not a type-c controller, then what is it? Explain me please
what is an "extcon device" without using any Linux subsystem naming.

> 
> And I will add “connector” to the title.
> title: Realtek DHC RTD SoCs USB Type-C Connector detection

So usb...


>>
>>> +
>>> +  realtek,rd-ctrl-gpio:
>>> +    description: The gpio node to control external Rd on board.
>>
>> The names are always "gpios".
> 
> Do you mean "realtek,rd-ctrl-gpios" ?

Yes, like all of such properties in DTS and bindings. Everywhere.

>>
>>> +    maxItems: 1
>>> +
>>
>> You miss here connector. Probably also VBUS supply and other supplies.
>>
> Ok, I will add connector.
> 
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    type-c@7220 {
>>> +        compatible = "realtek,rtd1619b-type-c";
>>> +        reg = <0x7220 0x20>;
>>> +        interrupts = <0 60 4>;
>>
>> Use proper defines for common constants.
> 
> Ok, I will revise this.
> 
>>> +
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&usb_cc1_pins>, <&usb_cc2_pins>;
> 
> You mention that the property of pinctrl not need in doc.
> Do I need to add the property of pintrl in example?

Does not matter.

Best regards,
Krzysztof

