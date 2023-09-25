Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6C7AD110
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjIYHHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIYHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:07:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9980CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:07:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b275afb6abso417075466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695625631; x=1696230431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hgI6A5TI/hgQO4BAnbd8tQJDlo2yAW6QdgmQX8/IME=;
        b=iCF2TOqjK3evIlYOMoesRCvWt+oKpY2Dkkzo01tBRVwZvVduT4kHB4KqN4Dm9Am2S1
         j3g43H+qdUil0gmyfyg9nWsUDL4G/eXrubRR33cV7dY2Zg1r55oBIscZMH2/f5vEFjxm
         wh2TOWLFm5Z76AgqAfSml8ALA7hHYcRlvcbhyi0/x9zIs2RGh6GFtzM2XL8Ejs47JjDZ
         WCPjy/GLGTZuEOEd6iKLNgSZQLtMWzrieLirm1NbsTmNUNNJHXOJcFxM5PHO2R8Z+H1L
         UqIQjsvYIhOAcT1MxnZDIaOZrS2uQyU5l9Ex03y/VkrMn36zNZNvuYtulVN0Sobm4xcp
         7vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625631; x=1696230431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hgI6A5TI/hgQO4BAnbd8tQJDlo2yAW6QdgmQX8/IME=;
        b=j1jzNWhDoKaiQkat7zwFDhHjeUviIdiWIwhjniYsuwxG7QSrXo9ZPCfF0BzEo7haUI
         GhbR/FU2oy9u45y+g3wDfFIOefzJ9Xt82LyvyV+bsJ0+T5WC9e5m5ymM0iirhVQjuJiI
         g3wX6O6sY/MIS/nLrh47b2GRvdfsI8w5wpkcpDRNlUS6tmViwacaRYUIF1EwWaTrfoJg
         HavYa2Kw4HTXd3Uwe4kCX2za5Oo7Vp4h1A2yp3VaFG7LUNA9YE+AsjmXxtQoyIwm9jzB
         IieHX4n11C7r7QSzgj1pdE/HVqaFvk/IoFcWKLt9/NhFtfJwYKctUnQYq5XaH6SVpiy2
         11Fw==
X-Gm-Message-State: AOJu0Yw65T7Lk8cE9cpJMX6dwcTZY5UocqX1Ap9vIL2dJJXhWNHNdGYD
        s/mvxf16OMl7uQihVZciYHVqrg==
X-Google-Smtp-Source: AGHT+IEJwe8xpBqNTBEAg00i05LU7GHxzDQ/Fs7qchRms8TLaP+jcLANKhn7bJ4oc8AEe+k8lQVZKA==
X-Received: by 2002:a17:907:9483:b0:9a5:7d34:e68a with SMTP id dm3-20020a170907948300b009a57d34e68amr14085048ejc.28.1695625631245;
        Mon, 25 Sep 2023 00:07:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906061900b00997d76981e0sm5830258ejb.208.2023.09.25.00.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:07:10 -0700 (PDT)
Message-ID: <eea00166-3f02-4eb0-9f82-26ffd0133dcc@linaro.org>
Date:   Mon, 25 Sep 2023 09:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: power: mfd: max8925: Convert to DT schema
 format
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230922233142.1479677-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230922233142.1479677-1-sebastian.reichel@collabora.com>
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

On 23/09/2023 01:31, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> The sub-functions of this MFD device do not have their own compatible
> string and are thus described directly in the MFD binding document
> after being converted to YAML.
> 

...

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The cell is the IRQ number
> +
> +  maxim,tsc-irq:
> +    description: second interrupt from max8925
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^SDV[1-3]$|^LDO[1-9]$|^LDO1[0-9]$|^LDO20$":
> +        description: regulator configuration for SDV1-3 and LDO1-20
> +        $ref: /schemas/regulator/regulator.yaml

Missing on this level: unevaluatedProperties: false

> +
> +    additionalProperties: false
> +
> +  backlight:
> +    type: object
> +    properties:
> +      maxim,max8925-dual-string:
> +        description: set to 1 to support dual string
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0
> +
> +    additionalProperties: false
> +
> +  charger:
> +    type: object
> +    properties:
> +      batt-detect:
> +        description: set to 1 if battery detection via ID pin is supported
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0
> +
> +      topoff-threshold:
> +        description: charging current in topoff mode, configures bits 5-6 in CHG_CNTL1
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      fast-charge:
> +        description: set charging current in fast mode, configures bits 0-3 in CHG_CNTL1
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7
> +        default: 0
> +
> +      no-temp-support:
> +        description: set to 1 if temperature sensing is not supported
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0
> +
> +      no-insert-detect:
> +        description: set to 1 if AC detection is not supported
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max8925@3c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "maxim,max8925";
> +            reg = <0x3c>;
> +            interrupts = <1>;
> +            interrupt-parent = <&intcmux4>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +            maxim,tsc-irq = <0>;
> +
> +            regulators {
> +                SDV1 {
> +                    regulator-min-microvolt = <637500>;
> +                    regulator-max-microvolt = <1425000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                LDO1 {
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <3900000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +
> +            backlight {
> +                maxim,max8925-dual-string = <0>;
> +            };
> +
> +            charger {
> +                batt-detect = <0>;
> +                topoff-threshold = <1>;
> +                fast-charge = <7>;
> +                no-temp-support = <0>;
> +                no-insert-detect = <0>;
> +            };
> +        };
> +    };


Best regards,
Krzysztof

