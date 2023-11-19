Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228237F0634
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjKSMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:47:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971F12D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:47:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso10689355e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700398036; x=1701002836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9jj2kVfyh50QxOoLJ625SIhskaw/bcrMBciOJYpMHaI=;
        b=cBEFiWev/ANlNZZbDFw+kq3ZVSrCtJyexgZdtLS6LjT1Rhws4Zw3nthmayZF5gQdz5
         pGHnJzjWAaC5uZE3LcE+twW2MuvznAIhmn0xjQz48HP5vD9aaIoQqMuzP9+yrjWKF3de
         9mag7grlLZ9J+X+rVqFhYXOqflT5vhSzpPQuI+KxsziaUnGvntgh9aK8aNw8rlM9ObBQ
         EIxM7fZxxMLCfIrZibm3swSQC0cOoVrYEeCKKA2HM6cjXnQQKMxZp7VcrGY8vbsPsRWQ
         KFvc7tsy9OUJ7DJzV1OeGL35EVD9m9K9IPdT2n8eJ23S6Sh6xxGPCVIE8x+HIdbFtNH9
         qNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700398036; x=1701002836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jj2kVfyh50QxOoLJ625SIhskaw/bcrMBciOJYpMHaI=;
        b=G2P+PxjT6bcQwpMu3JxoRtsh1RhfeQXs8ohC0dzDBnkhKYg7tNUz4LSnRtbOKNeNtM
         bALhPm9HQqyNKqzdRszF78fbVV3kmmsFqMbaEqxwcUFknzWfx0vu+66HgzaWexjv1j98
         mNUcuDJHCXeeAAuzX4pBipJwsMFDaTOPP99ZWYmADQtyYpPyTvBcJJ5XsdAy8Qc5+4yP
         LaKXpcdqPjuB7at5+woAUlJtSZN0cpj/4fqwxs/5BF1FBTnyC2HVusmQIuje2/3g5EED
         SKC/1qIzoJS8ZEzkL8YiFeDbHQJ+8/yTRnoxo104EmCa90dVGGtCbBTWyZ+RnLgQ2Sf+
         aWpg==
X-Gm-Message-State: AOJu0YyI0CtslVq9llIqGxKntp6gR5J6FYfS5am4sAmZy+WdC5B5s5Zc
        TvF0X/guw8KYl5ZPa71uJEeIJQ==
X-Google-Smtp-Source: AGHT+IFH8u7/ruLuKquP6ej5SWkaMEkVOT+3IDUPMQs/WURPY3L64qTSo6/TSJ1wkXCJRU/l4yMaaA==
X-Received: by 2002:a05:600c:19ca:b0:409:7aa9:a8f9 with SMTP id u10-20020a05600c19ca00b004097aa9a8f9mr4791952wmq.16.1700398035708;
        Sun, 19 Nov 2023 04:47:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id bf14-20020a0560001cce00b0032dde679398sm8034194wrb.8.2023.11.19.04.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 04:47:15 -0800 (PST)
Message-ID: <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
Date:   Sun, 19 Nov 2023 13:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for
 Realtek DHC SoCs
To:     James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231117162709.1096585-2-james.tai@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 17:27, James Tai wrote:
> Add the YAML documentation for Realtek DHC SoCs.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Marc Zyngier <maz@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-kernel@vger.kernel.org
> CC: devicetree@vger.kernel.org
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
> v1 to v2 change:
> - Tested the bindings using 'make dt_binding_check'

I doubt it.

And bot prooves it.

> - Fixed code style issues

Be specific - what code style issues did you fix?

> 
>  .../realtek,rtd1319-intc.yaml                 | 79 +++++++++++++++++++
>  .../realtek,rtd1319d-intc.yaml                | 79 +++++++++++++++++++
>  .../realtek,rtd1325-intc.yaml                 | 79 +++++++++++++++++++
>  .../realtek,rtd1619b-intc.yaml                | 78 ++++++++++++++++++
>  4 files changed, 315 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml

Why do you have four bindings for the same? Please explain me the
differences.

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
> new file mode 100644
> index 000000000000..b88f3ac07cd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1319-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC RTD1319 Interrupt Controller Device Tree Bindings
> +
> +description:
> +  This interrupt controller is a component of Realtek DHC RTD1319 and
> +  is designed to receive interrupts from peripheral devices.
> +
> +  Each DHC SoC has two sets of interrupt controllers, each capable of
> +  handling up to 32 interrupts.
> +
> +maintainers:
> +  - James Tai <james.tai@realtek.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  "#interrupt-cells":
> +    const: 1


compatible is first, put the cells next to other interrupt controller
properties.

> +
> +  compatible:
> +    enum:
> +      - realtek,rtd1319-intc-iso
> +      - realtek,rtd1319-intc-misc
> +
> +  "#address-cells":
> +    const: 0
> +
> +  interrupt-controller: true
> +
> +  interrupts-extended:

interrupts instead.

Anyway, you must describe the items. Why this is not fixed but flexible?
Hardware has different number of pins? That's unlikely.

> +    minItems: 1
> +    maxItems: 4
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - "#interrupt-cells"
> +  - "#address-cells"
> +  - compatible
> +  - interrupt-controller
> +  - interrupts-extended
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rtd1319_iso_irq: interrupt-controller@40 {
> +      compatible = "realtek,rtd1319-intc-iso";
> +      reg = <0x00 0x40>;
> +      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-controller;
> +      #address-cells = <0>;
> +      #interrupt-cells = <1>;
> +    };
> +
> +    rtd1319_misc_irq: interrupt-controller@80 {
> +      compatible = "realtek,rtd1319-intc-misc";

Drop, one example is enough. This is the same as previous.

> +      reg = <0x00 0x80>;
> +      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +                            <&gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-controller;
> +      #address-cells = <0>;
> +      #interrupt-cells = <1>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
> new file mode 100644
> index 000000000000..75aba448baf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1319d-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC RTD1319D Interrupt Controller Device Tree Bindings
> +
> +description:
> +  This interrupt controller is a component of Realtek DHC RTD1319D and
> +  is designed to receive interrupts from peripheral devices.
> +
> +  Each DHC SoC has two sets of interrupt controllers, each capable of
> +  handling up to 32 interrupts.
> +
> +maintainers:
> +  - James Tai <james.tai@realtek.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  "#interrupt-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - realtek,rtd1319d-intc-iso
> +      - realtek,rtd1319d-intc-misc

So this is the same as the other one? Why it cannot be part of that one?
...

> +
> +maintainers:
> +  - James Tai <james.tai@realtek.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  "#interrupt-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - realtek,rtd1325-intc-iso
> +      - realtek,rtd1325-intc-misc

All my comments apply to all your bindings...


Best regards,
Krzysztof

