Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9983786820
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbjHXHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbjHXHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:09:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F832E59
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:09:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso854987066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692860964; x=1693465764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jPyWvXn53+Ri3DMXwy23u6DWod2sy7gyH7yQg33cwQ=;
        b=z722U1KJ+xYzP/H4uwgNt+mpwlr2QKVRGOIvXwWWhRPxKCfPUxq9eh2cpXuC+Y/9JJ
         jELUwcFvGfOs8kPi3oMnsYJ3rYzKxnLpRlhK/d2rC3FEPXV/2o41xAsB65wStyO+eKqf
         OW9nYu0EWsCsH5JFcyltZbYP9pdUYViBq3TP6DNRyDNu+U93nwnxmbswAFf4ZyUMJFIn
         ZBenrEANRQRH4cXkNOy869Kq4EXC2E48gtGgj53PgKXNh8qk3K9njLUGlPP/bFmJfzb+
         hQTynSHUyh+H6bQ29fRvgvIdMba5cAEOSl7EXFJBdJs8ysrTDoegQF9ZoBfD7v/c5ja3
         acYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860964; x=1693465764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jPyWvXn53+Ri3DMXwy23u6DWod2sy7gyH7yQg33cwQ=;
        b=inEKy2lSte/l9XZSMlq1nFUSNwjn23bZRaM5KiYrcaOKjO53FGFhqaghYGIuPqQgaq
         XnkgqziUwXTrpNvIXRFZRdGF2ECU4rJauEM3caMa0jGF5vNogszYfM7ZH0vyxkPHpZxn
         avGl6EPp5hGfDlpw7a+b8ZhdMKMh3AlNni+YzG5oC7WsCbuJI+kk/73KE6pP0rmvlUEb
         5Li1M/2Ru41fBt6tuF5GEVIu8MhJdAPU9TFJWJ4q+8clxQW3CLUO1If2CKAmjx0HkDjV
         S2BIPWGKz6K1a1xNPZRlRO7fWpZTOpoOm8YHVuNqQpKHmuzVds/NJrH3YQWjABlvTkfY
         ILgg==
X-Gm-Message-State: AOJu0YzouyZnlwDlce7wgV1l0r2HCvooOpxFCT/oaEiVWMuqEfpB+kSu
        ACn7KCOUb1xq7FTXXGeEQVW4LQ==
X-Google-Smtp-Source: AGHT+IErz7N1ky2M5rOVizPYGZ7g0DYRQMGtp5g0kTurjLC9ZcaXYSTRIs4+x32FgOE8Xn3OZpwZyg==
X-Received: by 2002:a17:907:7715:b0:9a1:f21e:cdfe with SMTP id kw21-20020a170907771500b009a1f21ecdfemr2417857ejc.58.1692860964425;
        Thu, 24 Aug 2023 00:09:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709060b4800b0099bc8db97bcsm10529998ejg.131.2023.08.24.00.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:09:23 -0700 (PDT)
Message-ID: <429b8559-c539-d60e-fb68-bfc3f8a58fbf@linaro.org>
Date:   Thu, 24 Aug 2023 09:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add TWL6032 32K clocks
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh@kernel.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20230819134147.456060-1-andreas@kemnade.info>
 <20230819134147.456060-2-andreas@kemnade.info>
 <20230821205745.GA2270173-robh@kernel.org> <20230823173807.0b80a70a@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823173807.0b80a70a@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 17:38, Andreas Kemnade wrote:
> On Mon, 21 Aug 2023 15:57:45 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Sat, Aug 19, 2023 at 03:41:45PM +0200, Andreas Kemnade wrote:
>>> To be able to be referenced from a future yaml-version of
>>> mfd/twl-family.txt depending on toplevel compatible have a separate
>>> file for the 6032  
>>
>> Really, the parent needs to be done first...
>>
> well, for some other subdevices, a yaml is already in the tree
> and Krzysztof recently added a R-By to another one.

Yep, but I am not checking every possible parent-child relationship. It
would not be even possible...

> 
> But if the clocks should not have a node, then it is obvious.
> What would be the route to conversion here: Is a conversion
> of mfd/twl-family.txt without specifying subnodes ok for the first step,
> maybe with additionalProperties: yes?

Yes.

> 
> 
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>  .../bindings/clock/ti,twl6032-clk.yaml        | 38
>>> +++++++++++++++++++ 1 file changed, 38 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
>>> b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml new
>>> file mode 100644 index 0000000000000..aebd9f8d761a2 --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
>>> @@ -0,0 +1,38 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/ti,twl6032-clk.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Clocks of the TWL6032 PMIC
>>> +
>>> +maintainers:
>>> +  - Andreas Kemnade <andreas@kemnade.info>
>>> +
>>> +description:
>>> +  The TWL6032 has some 32Khz clock outputs which can be
>>> controlled.  
>>
>> outputs? Seems like only 1 with no clock cells to specify which one.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,twl6032-clk32kaudio
>>> +      - ti,twl6032-clk32kg  
>>
>> Or is it 1 output per compatible? I hope not.
>>
> yes, it is. It was inspired by the clk-palmas driver:

Creating nodes for single clocks is rather antipattern. Also, many early
designs of drivers and bindings assumed mapping 1-to-1 between driver
and DT nodes. This is also considered an antipattern now.

> $ grep palmas.*32 arch/arm/boot/dts/ti/omap/omap5-*
> arch/arm/boot/dts/ti/omap/omap5-board-common.dtsi:
> clk32kgaudio: palmas_clk32k@1 {
> arch/arm/boot/dts/ti/omap/omap5-board-common.dtsi:
> 	compatible = "ti,palmas-clk32kgaudio";
> 
> Well, we have the CLK_IGNORE_UNUSED, so if we use #clock-cells = 1,
> an unused clock will not be touched by the kernel, right?

I don't understand what OS flag has anything to do with clock-cells...

> 
>>> +
>>> +  '#clock-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - '#clock-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    twl {
>>> +        clk32kaudio {
>>> +            compatible = "ti,twl6032-clk32kaudio";
>>> +            #clock-cells = <0>;
>>> +        };  
>>
>> You don't need a child node to be a clock provider. Just add 
>> #clock-cells to the parent node.
>>
> hmm, we have child nodes there for every subdevice in that family,
> even if I doubt it is totally technically required.
> So why should the clk device be an exception? 

There is no rule of having nodes for subdevices, thus there cannot be
such exception. The rule is nodes are created when needed, not to match
some consistency of Linux drivers.


Best regards,
Krzysztof

