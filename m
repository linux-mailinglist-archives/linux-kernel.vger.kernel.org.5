Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8B7C6725
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjJLHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjJLHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:53:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936ACCF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:53:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso103840566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697097185; x=1697701985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5JKAw7l2R5GRN5PjCy/S1oc67fYhQaFH+TzRSuCn3Q=;
        b=mLbifKKcdQS1kebWFCIG99/lKv2JaGeQ934qNT7Etd5Yu64HwAe5ZfICcnkAFPZ8w9
         aUrD3XLEO9nAUzyqO5Xju5CdVyxJERJ1M6y4yqFi9HHzdypV6bUzqJeFb+SOJLzoele6
         oFNcN990a800Jys581PhfZN5rGWWIUryKTNtFTS1wzVStYn+gOty/1x36/jvE25kOTdq
         YvUsNmNvWruVeAiTpONUDr9AE+Td9oAGD3ufpMYB9MrEd5yDXwx+0pgL451nY1YC/bRV
         s6pLPEpBozrItLuMrK7NwBAFb+LUtD37bLwK37CI0XQsT1x8vIsSrJPSS98LpJF7tSKt
         tzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097185; x=1697701985;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5JKAw7l2R5GRN5PjCy/S1oc67fYhQaFH+TzRSuCn3Q=;
        b=TwwFCfF4PAyiU/GuMV7I0+5zFRvqkL0TZRuy071i0jUN+Nsitu2UJDUqdjCDs0CUoK
         Nk8PxJnx9BbJ0OVjwXy4TpVWAxg5e54FznY7o90lG9CIJruaDjdCk21DBNzBKchsrkg/
         KqhU1G94krNOkttzlZ38s3Bk9jzkiOgRMRqpGE4db6u27wuNnQdoAXV1WlN1mnxmL9ez
         8jFYDVG0n3S7gBLBMm8wc7iSpAH7gsgp89hVMb7h/kcEE1diy2kDhgAUiRxK2vnaShgA
         9rwc1AZi7KZVN4BlyW+wdWx7KEg0HKld1XQpjtq/CwXodfIqKumywKSGhNycvbFc9ZHV
         AH+Q==
X-Gm-Message-State: AOJu0Ywuxkcaasn84HSIvsiF5U005O7Qv4W5SJl60+26sluMuauAFkHy
        Ba/3pgIu+5OqLwfqu+yfch3WSQ==
X-Google-Smtp-Source: AGHT+IEL+HNBfTbENZmEPS3kjdy/2Cew+5AGmGYVGduLtVFjOe0wNBD/6dbw3SnpFaRkALpKhcofkw==
X-Received: by 2002:a17:906:1011:b0:9ae:69b3:3e18 with SMTP id 17-20020a170906101100b009ae69b33e18mr22462387ejm.25.1697097184954;
        Thu, 12 Oct 2023 00:53:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906299400b00997c1d125fasm10895258eje.170.2023.10.12.00.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:53:04 -0700 (PDT)
Message-ID: <f24bab3b-4a45-4843-a834-e3a57c7d8aed@linaro.org>
Date:   Thu, 12 Oct 2023 09:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: max310x: convert to YAML
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231011222105.2587175-1-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231011222105.2587175-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 00:21, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Convert binding from text format to YAML.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. Missing prefix: serial:


> 
> Additions to original text binding:
>   - add rs485 reference.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---


> diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
> new file mode 100644
> index 000000000000..05fd00d95260
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/maxim,max310x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX310X Advanced Universal Asynchronous Receiver-Transmitter (UART)
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max3107
> +      - maxim,max3108
> +      - maxim,max3109
> +      - maxim,max14830
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      When there is no clock provider visible to the platform, this
> +      is the source crystal frequency for the IC in Hz.
> +    minimum: 1000000
> +    maximum: 4000000

This wasn't in original binding. Explain this in the commit msg.

> +
> +  clock-names:
> +    enum:
> +      - xtal # External crystal
> +      - osc  # External clock source

clock-names follow immediately clocks.

> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 16
> +
> +allOf:

allOf: block goes after required: block.

> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/serial/serial.yaml#
> +  - $ref: /schemas/serial/rs485.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +oneOf:
> +  - required:
> +      - clocks
> +      - clock-names
> +  - required:
> +      - clock-frequency

That's also something new as well. The original binding required clocks.
Why are you changing this?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        serial@2c {
> +            compatible = "maxim,max3107";
> +            reg = <0x2c>;
> +            clocks = <&xtal4m>;
> +            clock-names = "xtal";
> +            interrupt-parent = <&gpio3>;
> +            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +

One example is enuogh. All other are the same.


Best regards,
Krzysztof

