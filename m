Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61C7EE3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjKPPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345392AbjKPPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:01:51 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0FD52
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:01:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77ba957043cso50790385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146905; x=1700751705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inOVU0x3pZACyCPPsXiQOvFDB8AI+bULX2g91qYkKhY=;
        b=bAk79e7i5N/uEfbIItoYRKzaOiqIvxlzCqWzAY0C/2LTIXBcrt+uznGpGr/5SL4285
         i1awqhZKzLoeuCqd5fXFH4+ppKGTKETTn8AGsbpW6Vg6HuTh/WMlv5GYr3PF7bTWdAow
         YxIZ/jE+YAAqHzFo1APknpV5TWa3YTsUrhu9XUHWs2wpmDhVoAkTCtcdsMtAHe/4XlQA
         jBOVWWD/Se15yHj7dytm6SGUEruqTNylgHuGKHDfV14pBeYIT9FZifppzom8t1pLDwp2
         5zAxqRwQVjhLA74LrDTdFXAoSLlqz/jKv1YWFGuKAsX1ss2ohgRj/BAimvQxggRlfU1a
         Bxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146905; x=1700751705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inOVU0x3pZACyCPPsXiQOvFDB8AI+bULX2g91qYkKhY=;
        b=i0M3Bat0aw/x/bpW7mr88ECPtG1u9unt7wUZAjrIo/nBkl+FAUT8ESiVs6aYKQJm1H
         Avfrg8cJYCFK0XtYixYr0chp0WMS7M1JNqwM5v9qUDZjWXPUZnIalBHA0EESAAL3PKd5
         wg9f623+YIM3t6mQOxafeGCUZmGUh3MHUMAJoZV5Y53YQT7fUMAaFTCqmMXWS3Fp2YHf
         SZJQTH6t/+kViiBpKZyb+kPcaxRsVGzOlZHe7qcyJQPAYI53ZO/zpSn4TzmLKNCZm81F
         /TABAztdsuU01gCyNLyFNK1RS3Oqx8gWA34VM/gNAcL4gmD77aQ3PvBBuiYUEcd/lDaw
         uR5g==
X-Gm-Message-State: AOJu0Yx9QmkqQ0dXx4eZfTvbJAjAQOvjQs5fk+O3gBp08sQcfIKe4qDf
        BdOg5BnSNIoBIcVqOWv3Ah6C4A==
X-Google-Smtp-Source: AGHT+IGx7Ka5ImFx6cFZHYECx3kiiMZo9skRpwA5REYpdMG4aLvVNqTWkwT1waUFxWXG+HDSY+m7+Q==
X-Received: by 2002:a0c:eb4e:0:b0:677:a09a:83bd with SMTP id c14-20020a0ceb4e000000b00677a09a83bdmr9150643qvq.19.1700146904714;
        Thu, 16 Nov 2023 07:01:44 -0800 (PST)
Received: from [10.50.4.74] ([50.201.115.146])
        by smtp.gmail.com with ESMTPSA id pp23-20020a056214139700b0065b02eaeee7sm1415782qvb.83.2023.11.16.07.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:01:44 -0800 (PST)
Message-ID: <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
Date:   Thu, 16 Nov 2023 16:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Content-Language: en-US
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231115134453.6656-1-marius.cristea@microchip.com>
 <20231115134453.6656-2-marius.cristea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231115134453.6656-2-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 14:44, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip PAC193X series of Power Monitors with Accumulator.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1934.yaml   | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> new file mode 100644
> index 000000000000..2609cb19c377
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1934 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Accumulator.
> +  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1931
> +      - microchip,pac1932
> +      - microchip,pac1933
> +      - microchip,pac1934
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  microchip,slow-io:
> +    type: boolean
> +    description: |
> +      A GPIO used to trigger a change is sampling rate (lowering the chip power consumption).

Use Linux coding style wrapping (as described in Linux Coding style). I
am not going to tell you numbers because I want you to read the document
first.

This is boolean, not GPIO. I don't understand. "A GPIO", so any GPIO or
some specific? How is this property related to GPIO?


> +      If configured in SLOW mode, if this pin is forced high, sampling rate is forced to eight

This pin? This is boolean, not a GPIO. GPIOs are phandles.

> +      samples/second. When it is forced low, the sampling rate is 1024 samples/second unless
> +      a different sample rate has been programmed.
> +
> +patternProperties:
> +  "^channel@[1-4]+$":
> +    type: object
> +    $ref: adc.yaml
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      shunt-resistor-micro-ohms:
> +        description: |
> +          Value in micro Ohms of the shunt resistor connected between
> +          the SENSE+ and SENSE- inputs, across which the current is measured. Value
> +          is needed to compute the scaling of the measured current.
> +
> +    required:
> +      - reg
> +      - shunt-resistor-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: interrupts


I don't understand what do you want to say here. I am also 100% sure you
did not test it on a real case (maybe example passes but nothing more).

> +    then:
> +      properties:
> +        microchip,slow-io: false
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: microchip,slow-io
> +      then:
> +        properties:
> +          interrupts: false

Best regards,
Krzysztof

