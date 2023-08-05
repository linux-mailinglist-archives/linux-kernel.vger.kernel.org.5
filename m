Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD757711BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHETXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjHETXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:23:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E46194
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:23:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso31341225e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691263394; x=1691868194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWGkcMT5pxDyHMqOfqebMqnEsKhKLvpT6WJfc2oB8Rw=;
        b=Yv1rkbTeM5N+4K+Ah61alwDWwU9/JPJKtSh3TC0Z1GRFmgI8FgPDgBFZdVTb2lKSbX
         gt86mwE67u7Ce8lgHpEkZO4tCX6YOAn+cnuRXR3EBnRMiVXKxy71odOpmdFoNQJlKgCV
         BaM1t/EYgP0oRUqmTCiRAUQgD1gIyQC1sflKJaIl23Gp53d976zEVb2Urm7X/pA9edI2
         5PsCAGNbM5VzOCOAe1EH2Q4w4rODtKuOIeMSndDkz7Zeatl5XMziygVINRLyp+gfgAvL
         6TbtfbG/ejmwZLUD4QBSifFWlnqbprq1l8uiP33qfmlhnYiyn1yYCVVmmxbrkwu6rWxA
         ygmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691263394; x=1691868194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWGkcMT5pxDyHMqOfqebMqnEsKhKLvpT6WJfc2oB8Rw=;
        b=LjSDF9Kuk21nZ2Fue4qxJfWWeWbgVECXA/nkb1bUTVQsA/vmBLn3CXgEoGSBZF/UrZ
         T/mkub7rgbZsdfvPsXJ17tWKGNVbWILWwNV4h0M1tgXRyu3crgC3lFwUaVCffvxMZzqO
         8inGe7ObIZ9KFaSz/FBDqK9LNcRRmAax3y3sVlkZcd74/CP4V78qYiJmn8i+VLZHT6u2
         YFdJHP/D1WO5hg3WtFQ8fjW2nRo5xGGC9YWLc5yk8eOVxXLyET+Do4lNp7R8ykpGrU+8
         kL0nNkZG6XYxlRxfdzNHxUA0wIjw1OO5irMQVngXX9fwj6deEBswyreKORKv2aMOGDfc
         Gx5Q==
X-Gm-Message-State: AOJu0Yy5qtwhmBDWGR51zdiAHYuLisWqwg2fsO95Sr69OOlFxj63pBXj
        i2IwsJBsHWpB2Z0fqIbt6MHd9g==
X-Google-Smtp-Source: AGHT+IF5WmOuQZNborhxI3YPeZRFi8i72W0aWCq33li/JuGD/f7hub3HyXB1DY2qheXjQAa6kXntZw==
X-Received: by 2002:a1c:7715:0:b0:3fc:182:7eac with SMTP id t21-20020a1c7715000000b003fc01827eacmr4027317wmi.33.1691263394228;
        Sat, 05 Aug 2023 12:23:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003fa96fe2bd9sm10026422wml.22.2023.08.05.12.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 12:23:13 -0700 (PDT)
Message-ID: <721798b0-d9f8-3c17-0373-b5927d8fe230@linaro.org>
Date:   Sat, 5 Aug 2023 21:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: add binding for i2c-hotplug-gpio
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230729160857.6332-1-clamor95@gmail.com>
 <20230729160857.6332-2-clamor95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729160857.6332-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 18:08, Svyatoslav Ryhel wrote:
> Document device tree schema which describes hot-pluggable via GPIO
> i2c bus.
> 

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/i2c/i2c-hotplug-gpio.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
> new file mode 100644
> index 000000000000..21f2b74ca6c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/i2c-hotplug-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO detected hot-plugged I2C bus
> +
> +maintainers:
> +  - Michał Mirosław <mirq-linux@rere.qmqm.pl>
> +
> +description:
> +  Driver for hot-plugged I2C busses, where some devices on a bus
> +  are hot-pluggable and their presence is indicated by GPIO line.
> +
> +properties:
> +  compatible:
> +    items:

Drop items.

> +      - const: i2c-hotplug-gpio
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

Why do you need these two? You do not have any children.
> +
> +  interrupts-extended:

Just interrupts.

> +    minItems: 1

maxItems instead

> +
> +  detect-gpios:
> +    maxItems: 1
> +
> +  i2c-parent:
> +    maxItems: 1

Where is the type defined? Why this has maxItems? Is it an array?

> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - interrupts-extended
> +  - detect-gpios
> +  - i2c-parent
> +
> +unevaluatedProperties: false

Without any $ref, this should be additionalProperties: false.

> +
> +examples:
> +  - |
> +    /*
> +     * Asus Transformers use I2C hotplug for attachable dock keyboard
> +     */
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c-dock {
> +        compatible = "i2c-hotplug-gpio";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        interrupts-extended = <&gpio 164 IRQ_TYPE_EDGE_BOTH>;
> +        detect-gpios = <&gpio 164 GPIO_ACTIVE_LOW>;
> +
> +        i2c-parent = <&gen2_i2c>;

So do you expect here any children or not?

> +    };
> +...

Best regards,
Krzysztof

