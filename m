Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C597BB49B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjJFJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJFJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:55:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB1BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:55:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5ff5f858dso15054335ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696586108; x=1697190908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=va6279LqB/seoOCOHbdXG67T3Sqj31GhP8cK9knO7lQ=;
        b=LZnfMslZotV92c5PlQ0A5N0WIv9zbDDWmUlX4qMNCiqR8Kcys/ygvcB3cAk1knt+qC
         EaGRZyX9rzZSrZr6ciYMitFfYuzAiUkxGTaSue53PXkOpWyoNOnqOoJBzmCBXqNfEq/f
         +4IydxWml0PMdDZ9/Zps3KEvmAJ5f5ItfqPAauA4QdnHl9k0unSbfXFVlPU8KMezHGbv
         KyBBsltr+sQuoeEUo+q/AOG8GgWwifnVAPYCuygYSSgCUafmYAW1syOQ9cD+1lDO4QXD
         tQDFlKC0LPhjY7L4rzHAcWXmnZ9qbMa3UzUb3M5sLdogmqGkhMhesUbqn4z6Dfj+lEyO
         wvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696586108; x=1697190908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=va6279LqB/seoOCOHbdXG67T3Sqj31GhP8cK9knO7lQ=;
        b=l9i6bzQWJDH8AjppahmU8KkA8vhfhJ8m3u+uZnPS6JxcwE+JJGvTmoroVZw/uLBHs6
         +l30UFzGfrO2dpmJGNA0pkrPJB26qeti8/MsWLEBjHxxIxbQ1+LW2PL0QcXiUct4u7If
         19eD3XrJh2rkQQTg+r4QJ0tL4atCgf48A4kceJGY0w3c3+5KOkhbHrQtp4ZlXzl9DSPU
         8X3CBK9O9ZeugOpu2D4F/edFQgjqyPv5ScdZZozNDOeX+1ZL7QgA87qu7sYC3ZpCsxQD
         wL61UdEMhpgwTCkXnCvznA4ge8Xrm09JMOHp2Azer5skrQJoDEq2zNwKupTutPhrx7KP
         f5wA==
X-Gm-Message-State: AOJu0YyroC1FeyH0Th91fEHIlXfpAtIOUYLUjN8eyWbAY/dowOf+potS
        mqg1O2tcfPZSqO349GgVBKwC4w==
X-Google-Smtp-Source: AGHT+IFcNrFSTODFX+dGgwWocT0UzAFWNQzLB1H3jlWLEy7tDCtTRcn8etVzAnGEe7SIBHS8vPII1Q==
X-Received: by 2002:a17:903:110d:b0:1c1:fe97:bf34 with SMTP id n13-20020a170903110d00b001c1fe97bf34mr9060380plh.24.1696586108092;
        Fri, 06 Oct 2023 02:55:08 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001bde65894c8sm3372472pld.268.2023.10.06.02.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 02:55:07 -0700 (PDT)
Message-ID: <1006be55-85be-4f13-90c3-ec9c06996534@linaro.org>
Date:   Fri, 6 Oct 2023 11:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Content-Language: en-US
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231005185537.32267-1-fr0st61te@gmail.com>
 <20231005185537.32267-2-fr0st61te@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231005185537.32267-2-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 20:55, Ivan Mikhaylov wrote:
> The hardware binding for i2c current monitoring device with overcurrent
> control.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> new file mode 100644
> index 000000000000..4262bedb4bfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Two- and four-channel current monitors with overcurrent control
> +
> +maintainers:
> +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> +
> +description: |
> +  The MAX34408/MAX34409 are two- and four-channel current monitors that are
> +  configured and monitored with a standard I2C/SMBus serial interface. Each
> +  unidirectional current sensor offers precision high-side operation with a
> +  low full-scale sense voltage. The devices automatically sequence through
> +  two or four channels and collect the current-sense samples and average them
> +  to reduce the effect of impulse noise. The raw ADC samples are compared to
> +  user-programmable digital thresholds to indicate overcurrent conditions.
> +  Overcurrent conditions trigger a hardware output to provide an immediate
> +  indication to shut down any necessary external circuitry.
> +
> +  Specifications about the devices can be found at:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max34408
> +      - maxim,max34409
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  shutdown-gpios:
> +    description:
> +      Shutdown Output. Open-drain output. This output transitions to high impedance
> +      when any of the digital comparator thresholds are exceeded as long as the ENA
> +      pin is high.
> +    maxItems: 1
> +
> +  shtdn-enable-gpios:

Are these both GPIOs different than standard powerdown-gpios? I suspect
one is different, but the other should be the same. If both are
different, use different names. shutdown gpios is the same as powerdown
gpios....

> +    description:
> +      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
> +      unconditionally deassert (force low) the SHTDN output and reset the shutdown
> +      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg

required goes after patternProperties.

> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    $ref: adc.yaml
> +    type: object
> +    description:
> +      Represents the internal channels of the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      maxim,rsense-val-micro-ohms:
> +        description:
> +          Adjust the Rsense value to monitor higher or lower current levels for
> +          input.
> +        enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +        default: 1000
> +
> +    required:
> +      - reg
> +      - maxim,rsense-val-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: maxim,max34408
> +    then:
> +      patternProperties:
> +        "^channel@[2-3]$": false
> +        "^channel@[0-1]$":
> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 1
> +    else:
> +      patternProperties:
> +        "^channel@[0-3]$":
> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 3
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +

Stray blank line.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1e {
> +              compatible = "maxim,max34409";
> +              reg = <0x1e>;
> +
> +              #address-cells = <1>;
> +              #size-cells = <0>;

Missing blank line


Extend example with GPIOs to make it as complete as reasonable/possible.

Best regards,
Krzysztof

