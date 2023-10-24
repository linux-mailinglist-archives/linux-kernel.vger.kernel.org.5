Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2B7D5CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjJXVBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjJXVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:01:01 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6AF10E0;
        Tue, 24 Oct 2023 14:00:58 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce2fc858feso2947437a34.3;
        Tue, 24 Oct 2023 14:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181258; x=1698786058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ahN2wgmandrDUcYXF1otkyCWX4COVl8iKIWsZRBos=;
        b=boC7unmuqsCHvpoikeoil8SSjls/qcEazcM6JaQPpxXYkgE4UQ2MRtLjfoa10roAsg
         n5yvtxO5KAusrj8zACtyWXW/1gu1SnSFPquDvkMi1nfCksU9ogb+/bEEO9hrnRfoARhV
         Hv1Ya0QqtEZsRarp4a//MgOF8RCiFoTVV/7ZMDSNnDbagN2G2mhz7OtxL4FauRGP04nm
         cz8DPDarrP45y3BrRR40lBe35asqe2NLvm6VISerZFw9tTaCJGkTBsij6AY2gKwY5h9R
         btDmGdGAXFLV1zqWd3TnO6gOnri4H43he5josdB7FmhdCCEWLgQVRxEvvIqgs2wEIbGf
         JLEA==
X-Gm-Message-State: AOJu0YyTPgh2N6I5DCHdLCO/+JJuRzvLxO0/pSfi1i+zNbPFZLW5talo
        DSUyyDHhFhrf3BRivUihjg==
X-Google-Smtp-Source: AGHT+IEqzZ7dFJphdv2fBZY0LcxqoAX2ItFumUJh4bZLaLq9rQ+oAzoMcwBLKvcjGBd6nkm8hlgAOw==
X-Received: by 2002:a9d:7356:0:b0:6b9:9bcd:32fe with SMTP id l22-20020a9d7356000000b006b99bcd32femr12693130otk.17.1698181257937;
        Tue, 24 Oct 2023 14:00:57 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g19-20020a9d6c53000000b006cdf9935af2sm1983935otq.53.2023.10.24.14.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:00:57 -0700 (PDT)
Received: (nullmailer pid 564202 invoked by uid 1000);
        Tue, 24 Oct 2023 21:00:55 -0000
Date:   Tue, 24 Oct 2023 16:00:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dt-bindings: mfd: ams,as3711: Convert to json-schema
Message-ID: <20231024210055.GB529288-robh@kernel.org>
References: <9af48b816f2b6397f5ada58a9b5ced85213e5194.1698085945.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af48b816f2b6397f5ada58a9b5ced85213e5194.1698085945.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:38:07PM +0200, Geert Uytterhoeven wrote:
> Convert the Austria MicroSystems AS3711 Quad Buck High Current PMIC with
> Charger Device Tree binding documentation to json-schema.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> RFC, as I couldn't get the multiple dependencies right (see FIXMEs):
>   1. How to incorporate "su2-dev: [ su2-max-uA ]" and
>      "su2-feedback-curr-auto: [ su2-dev ]"?
>   2. su2-dev requiring one of su2-fbprot-* does not seem to work?
> 
> Anyone with better *Of foo? Thanks!
> ---
>  .../devicetree/bindings/mfd/ams,as3711.yaml   | 223 ++++++++++++++++++
>  .../devicetree/bindings/mfd/as3711.txt        |  73 ------
>  2 files changed, 223 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ams,as3711.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ams,as3711.yaml b/Documentation/devicetree/bindings/mfd/ams,as3711.yaml
> new file mode 100644
> index 0000000000000000..d9f08e017194c4f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ams,as3711.yaml
> @@ -0,0 +1,223 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ams,as3711.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Austria MicroSystems AS3711 Quad Buck High Current PMIC with Charger
> +
> +maintainers:
> +  - Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> +
> +description:
> +  AS3711 is an I2C PMIC from Austria MicroSystems with multiple DCDC and LDO
> +  power supplies, a battery charger and an RTC.  So far only bindings for the
> +  two stepup DCDC converters are defined.

step-up?

> +
> +properties:
> +  compatible:
> +    const: ams,as3711
> +
> +  reg:
> +    maxItems: 1
> +
> +  backlight:
> +    description:
> +      Step-up converter configuration, to be used as a backlight source
> +    type: object
> +    properties:
> +      compatible:
> +        const: ams,as3711-bl
> +
> +      su1-dev:
> +        description: Framebuffer phandle for the first step-up converter
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      su1-max-uA:
> +        description: Maximum current for the first step-up converter
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      su2-dev:
> +        description: Framebuffer phandle for the second step-up converter
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      su2-max-uA:
> +        description: Maximum current for the second step-up converter
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      su2-feedback-voltage:
> +        description: Second step-up converter uses voltage feedback
> +        type: boolean
> +
> +      su2-feedback-curr1:
> +        description:
> +          Second step-up converter uses CURR1 input for current feedback
> +        type: boolean
> +
> +      su2-feedback-curr2:
> +        description:
> +          Second step-up converter uses CURR2 input for current feedback
> +        type: boolean
> +
> +      su2-feedback-curr3:
> +        description:
> +          Second step-up converter uses CURR3 input for current feedback
> +        type: boolean
> +
> +      su2-feedback-curr-auto:
> +        description:
> +          Second step-up converter uses automatic current feedback selection
> +        type: boolean
> +
> +      su2-fbprot-lx-sd4:
> +        description:
> +          Second step-up converter uses LX_SD4 for over-voltage protection
> +        type: boolean
> +
> +      su2-fbprot-gpio2:
> +        description:
> +          Second step-up converter uses GPIO2 for over-voltage protection
> +        type: boolean
> +
> +      su2-fbprot-gpio3:
> +        description:
> +          Second step-up converter uses GPIO3 for over-voltage protection
> +        type: boolean
> +
> +      su2-fbprot-gpio4:
> +        description:
> +          Second step-up converter uses GPIO4 for over-voltage protection
> +        type: boolean
> +
> +      su2-auto-curr1:
> +        description:
> +          Second step-up converter uses CURR1 input for automatic current
> +          feedback
> +        type: boolean
> +
> +      su2-auto-curr2:
> +        description:
> +          Second step-up converter uses CURR2 input for automatic current
> +          feedback
> +        type: boolean
> +
> +      su2-auto-curr3:
> +        description:
> +          Second step-up converter uses CURR3 input for automatic current
> +          feedback
> +        type: boolean
> +
> +    required:
> +      - compatible
> +
> +    dependencies:
> +      # To use the SU1 converter as a backlight source the following two
> +      # properties must be provided:
> +      su1-dev: [ su1-max-uA ]
> +      su1-max-uA: [ su1-dev ]
> +
> +      # To use the SU2 converter as a backlight source the following two
> +      # properties must be provided:
> +      # FIXME How to incorporate "su2-dev: [ su2-max-uA ]"?
> +      # FIXME su2-dev requiring one of su2-fbprot-* does not seem to work?
> +      su2-dev:
> +        allOf:
> +          - oneOf:
> +              - required:
> +                  - su2-feedback-voltage
> +              - required:
> +                  - su2-feedback-curr1
> +              - required:
> +                  - su2-feedback-curr2
> +              - required:
> +                  - su2-feedback-curr3
> +              - required:
> +                  - su2-feedback-curr-auto
> +          - oneof:
> +              - required:
> +                  - su2-fbprot-lx-sd4
> +              - required:
> +                  - su2-fbprot-gpio2
> +              - required:
> +                  - su2-fbprot-gpio3
> +              - required:
> +                  - su2-fbprot-gpio4
> +
> +      su2-max-uA: [ su2-dev ]
> +      su2-feedback-voltage: [ su2-dev ]
> +      su2-feedback-curr1: [ su2-dev ]
> +      su2-feedback-curr2: [ su2-dev ]
> +      su2-feedback-curr3: [ su2-dev ]
> +      # FIXME How to incorporate "su2-feedback-curr-auto: [ su2-dev ]"?
> +      su2-feedback-curr-auto:
> +        anyOf:
> +          - required:
> +              - su2-auto-curr1
> +          - required:
> +              - su2-auto-curr2
> +          - required:
> +              - su2-auto-curr3
> +      su2-fbprot-lx-sd4: [ su2-dev ]
> +      su2-fbprot-gpio2: [ su2-dev ]
> +      su2-fbprot-gpio3: [ su2-dev ]
> +      su2-fbprot-gpio4: [ su2-dev ]
> +      su2-auto-curr1: [ su2-feedback-curr-auto ]
> +      su2-auto-curr2: [ su2-feedback-curr-auto ]
> +      su2-auto-curr3: [ su2-feedback-curr-auto ]
> +
> +    additionalProperties: false

Move this above 'properties'. Easier to read in the indented cases.

> +
> +  regulators:
> +    description: Other DCDC and LDO supplies
> +    type: object
> +    patternProperties:
> +      "^(sd[1-4]|ldo[1-8])$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +    unevaluatedProperties: false

Same here, though this one is short.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        as3711@40 {

pmic@40

> +            compatible = "ams,as3711";
> +            reg = <0x40>;
> +
> +            regulators {
> +                sd4 {
> +                    regulator-name = "1.215V";
> +                    regulator-min-microvolt = <1215000>;
> +                    regulator-max-microvolt = <1235000>;
> +                };
> +                ldo2 {
> +                    regulator-name = "2.8V CPU";
> +                    regulator-min-microvolt = <2800000>;
> +                    regulator-max-microvolt = <2800000>;
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                };
> +            };
> +
> +            backlight {
> +                compatible = "ams,as3711-bl";
> +                su2-dev = <&lcdc>;
> +                su2-max-uA = <36000>;
> +                su2-feedback-curr-auto;
> +                su2-fbprot-gpio4;
> +                su2-auto-curr1;
> +                su2-auto-curr2;
> +                su2-auto-curr3;
> +            };
> +        };
> +    };
