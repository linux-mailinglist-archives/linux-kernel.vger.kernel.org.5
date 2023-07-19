Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43747591E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGSJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGSJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:44:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256F1BE4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:44:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991da766865so917234166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689759888; x=1692351888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+zwscRtF1C8UdZp1lsJTJMlqaQ1kF6S6ZnoWJPQIe4=;
        b=cNMuWBL02/Kw4sbmmk+eAL7eFvL3AsJH5l87SbDvYTaR3lZ8GbTuwlSOu06w+Dtp+N
         IOqvNXq7ed/rqgX7FFJxI7h2XGwcvCsXIEOHKGmJeQJz2gZwEsJ5D33hPPHKGjyhAK5J
         qa59/mjBKlgPrekvHk0uVzsezazoOGQRkf7WHPR19xFoEUXLuIWeat25kmEEG6NxedOh
         l/mlyRFoq1/8fdkZwotNn6olkLPlDZNafFczCPBFUWszngER2lR3rA8wAhiolVLcD3EW
         9gRUNGhgZ1cHamfa260S0Jf6UuZ8YSYMp+Cwu3xbvRioUc7s+Xy7MV8ry07IvMIX55I2
         6Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759888; x=1692351888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+zwscRtF1C8UdZp1lsJTJMlqaQ1kF6S6ZnoWJPQIe4=;
        b=UcVWWrlb2CCB8Ub2s3rw/UBSuF8rZ2SN9BrrS+1hu0S6WFlcWBzLe2WiNLZmMwl/uA
         sEReuwfvZmZ81gwInxlLeZap+al7R6VBiG4o8pkAplnBCD0F3+BRLlDrjz8aPIvKJFDK
         2dmTAKjoKCX3vzwDzEkiEHkfiQdvq/a1B5YziboeAeRoLEF5j9wcKza8LWX4IMc0EG79
         hB3xdyuT2/ojZRoD4g2MYcqvTjWiW/DB6KrGhbs04jzEFhYw2nbCMhP4V5HejNugBi5f
         tVbibmm3TVBjuEUVUvCg2MzCPDXV9ARGLq+hgFN3ypXqkY0g6x6tUPkF9I0ES0XVyOdx
         +Ydg==
X-Gm-Message-State: ABy/qLa+BMvU8cvZfdlpBJ53x1zcW8fCDoSbX99etizXakVO5+MTcv1o
        SuHH9XqmkmouARgcfdSDq8FKQw==
X-Google-Smtp-Source: APBJJlEjZzNTxV645CJDPpCzpL6VTHIQnUiqJPrgZ8dUBC4SHxyVpiE0cRArjVL0tNUODm1v7HCtCQ==
X-Received: by 2002:a17:906:151:b0:999:26f6:1579 with SMTP id 17-20020a170906015100b0099926f61579mr1411617ejh.35.1689759887827;
        Wed, 19 Jul 2023 02:44:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906694800b0098d2261d189sm2140121ejs.19.2023.07.19.02.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:44:47 -0700 (PDT)
Message-ID: <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
Date:   Wed, 19 Jul 2023 11:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     alina_yu@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 11:24, alina_yu@richtek.com wrote:
> From: alinayu <alina_yu@richtek.com>
> 
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
> v4
> - Modify filename to "richtek,rtq2208"
> - Add more desciptions for "regulator-allowed-modes"
> ---
>  .../bindings/regulator/richtek,rtq2208.yaml        | 208 +++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> new file mode 100644
> index 0000000..6cc441f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> @@ -0,0 +1,208 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rtq2208-regulator.yaml#

Please test the patch before sending.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Also, one patchset version per day... give people time to review.


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RTQ2208 SubPMIC Regulator
> +
> +maintainers:
> +  - Alina Yu <alina_yu@richtek.com>
> +
> +description: |
> +  RTQ2208 is a highly integrated power converter that offers functional safety dual
> +  multi-configurable synchronous buck converters and two LDOs.
> +
> +  Bucks support "regulator-allowed-modes" and "regulator-mode". The former defines the permitted
> +  switching operation in normal mode; the latter defines the operation in suspend to RAM mode.
> +
> +  No matter the RTQ2208 is configured to normal or suspend to RAM mode, there are two switching
> +  operation modes for all buck rails, automatic power saving mode (Auto mode) and forced continuous
> +  conduction mode (FCCM).
> +
> +  The definition of modes is in the datasheet which is available in below link
> +  and their meaning is::
> +    0 - Auto mode for power saving, which reducing the switching frequency at light load condition
> +    to maintain high frequency.
> +    1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
> +
> +  Datasheet will be available soon at
> +  https://www.richtek.com/assets/Products
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rtq2208
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    
> +  richtek,mtp-sel:
> +    type: boolean
> +    description:
> +      vout register selection based on this boolean value.
> +      false - Using DVS0 register setting to adjust vout
> +      true - Using DVS1 register setting to adjust vout
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^buck-[a-h]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          description for buck-[a-h] regulator.
> +
> +        properties:
> +          regulator-allowed-modes:
> +            description:
> +              two buck modes in different switching accuracy.
> +              0 - Auto mode
> +              1 - FCCM
> +            items:
> +              enum: [0, 1]
> +
> +          regulator-mode:
> +            enum: [0, 1]
> +            description:
> +              describe buck initial operating mode in suspend state.

There is no such property on this level. Aren't you mixing initial one?

> +
> +      "^ldo[1-2]$":
> +        type: object
> +        $ref: regulator.yaml#

Missing unevaluatedProperties: false.

> +        description:
> +          regulator description for ldo[1-2].
> +
> +        properties:
> +          regulator-compatible:
> +            pattern: "^LDO[1-2]$"
> +
> +          richtek,fixed-uV:
> +            $ref: "/schemas/types.yaml#/definitions/uint32"

This is pointed out by schema, so standard text:
It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +            enum: [ 900000, 1200000, 1800000, 3300000 ]
> +            description:
> +              the fixed voltage in micro volt which is decided at the factory.

I don't understand this property. Why this is different from min/max
microvolt? Plus, you use incorrect unit suffix.

> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +unevaluatedProperties: false

Instead: additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@10 {
> +        compatible = "richtek,rtq2208";
> +        reg = <0x10>;
> +        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +        richtek,mtp-sel;
> +
> +        regulators {
> +         buck-a {

Wrong indentation. If you use 2 spaces, use it consistently.

> +            regulator-min-microvolt = <400000>;
> +            regulator-max-microvolt = <2050000>;
> +            regulator-allowed-modes = <0 1>;

...

> +          };
> +         ldo2 {
> +            regulator-always-on;

And three spaces here?

> +            richtek,fixed-uV = <3300000>;
> +            regulator-state-mem {
> +              regulator-on-in-suspend;
> +            };
> +          };
> +        };
> +      };
> +    };

Best regards,
Krzysztof

