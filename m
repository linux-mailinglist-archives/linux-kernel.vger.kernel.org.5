Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5617CCC30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjJQTZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:25:45 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A1F0;
        Tue, 17 Oct 2023 12:25:43 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso3099202fac.0;
        Tue, 17 Oct 2023 12:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570743; x=1698175543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAs+FgwImexf0INpy4oXhutMFwmFtTEn4MQSLBx1oj4=;
        b=sD3yKiwMwn1uWe5v2M8RU5TiaP9mk2VTJj56IyO2FwqkfV4KsmdMwbjcFTBoMhhR+O
         bqbVLlue6RGTENHQJl7Nus9c7n+dtJIb23Fth3Ue3JO0JhrG/A7YgXRT2cUSa4mDEF4G
         9qGJc7Pip7svhr5g9sJjOfhJOOiAN7DRACuOff1SjygVBLjGcjiv/v9D/pbN+2MqhIWG
         fjPXsJ8f9m/TMSgv0VHOT0E5Ex+Uc1qI7imk4T49T+I5zH4WD6FqhLU0mKMPbeTWZNR5
         O95LEiO7ZeRp4f1LFOAoDH5l3aQApKrqMMEue/5GPhppmzkObSlRfgPts55af78Ij/fX
         nfsw==
X-Gm-Message-State: AOJu0YwYD5Iopffh9C37iAZp3o30JiX5ezGhdlutxAc4YE6/SDw7Szoc
        I1Ubr/D87LV/iMFIF0maGQ==
X-Google-Smtp-Source: AGHT+IGKWc6Y0XnGNNq1PPoHter2D5U67fQ+HuH1dbV1fk0u+zwMknj2Is0LoFCnqGs1Phk2erih4g==
X-Received: by 2002:a05:6871:203:b0:1e9:88e0:b8ba with SMTP id t3-20020a056871020300b001e988e0b8bamr1561762oad.29.1697570742847;
        Tue, 17 Oct 2023 12:25:42 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bw10-20020a056820020a00b005737ca61829sm349815oob.13.2023.10.17.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:25:42 -0700 (PDT)
Received: (nullmailer pid 2544684 invoked by uid 1000);
        Tue, 17 Oct 2023 19:25:41 -0000
Date:   Tue, 17 Oct 2023 14:25:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: si5351: convert to yaml
Message-ID: <20231017192541.GA2540625-robh@kernel.org>
References: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
 <20231014-alvin-clk-si5351-no-pll-reset-v4-1-a3567024007d@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231014-alvin-clk-si5351-no-pll-reset-v4-1-a3567024007d@bang-olufsen.dk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 08:19:41PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The following additional properties are described:
> 
>   - clock-names
>   - clock-frequency of the clkout child nodes
> 
> In order to suppress warnings from the DT schema validator, the clkout
> child nodes are prescribed names clkout@[0-7] rather than clkout[0-7].
> 
> The example is refined as follows:
> 
>   - correct the usage of property pll-master -> silabs,pll-master
>   - give an example of how the silabs,pll-reset property can be used
> 
> I made myself maintainer of the file as I cannot presume that anybody
> else wants the responsibility.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/clock/silabs,si5351.txt    | 126 -----------
>  .../devicetree/bindings/clock/silabs,si5351.yaml   | 245 +++++++++++++++++++++
>  2 files changed, 245 insertions(+), 126 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.txt b/Documentation/devicetree/bindings/clock/silabs,si5351.txt
> deleted file mode 100644
> index bfda6af76bee..000000000000
> --- a/Documentation/devicetree/bindings/clock/silabs,si5351.txt
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -Binding for Silicon Labs Si5351a/b/c programmable i2c clock generator.
> -
> -Reference
> -[1] Si5351A/B/C Data Sheet
> -    https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/data-sheets/Si5351-B.pdf
> -
> -The Si5351a/b/c are programmable i2c clock generators with up to 8 output
> -clocks. Si5351a also has a reduced pin-count package (MSOP10) where only
> -3 output clocks are accessible. The internal structure of the clock
> -generators can be found in [1].
> -
> -==I2C device node==
> -
> -Required properties:
> -- compatible: shall be one of the following:
> -	"silabs,si5351a" - Si5351a, QFN20 package
> -	"silabs,si5351a-msop" - Si5351a, MSOP10 package
> -	"silabs,si5351b" - Si5351b, QFN20 package
> -	"silabs,si5351c" - Si5351c, QFN20 package
> -- reg: i2c device address, shall be 0x60 or 0x61.
> -- #clock-cells: from common clock binding; shall be set to 1.
> -- clocks: from common clock binding; list of parent clock
> -  handles, shall be xtal reference clock or xtal and clkin for
> -  si5351c only. Corresponding clock input names are "xtal" and
> -  "clkin" respectively.
> -- #address-cells: shall be set to 1.
> -- #size-cells: shall be set to 0.
> -
> -Optional properties:
> -- silabs,pll-source: pair of (number, source) for each pll. Allows
> -  to overwrite clock source of pll A (number=0) or B (number=1).
> -
> -==Child nodes==
> -
> -Each of the clock outputs can be overwritten individually by
> -using a child node to the I2C device node. If a child node for a clock
> -output is not set, the eeprom configuration is not overwritten.
> -
> -Required child node properties:
> -- reg: number of clock output.
> -
> -Optional child node properties:
> -- silabs,clock-source: source clock of the output divider stage N, shall be
> -  0 = multisynth N
> -  1 = multisynth 0 for output clocks 0-3, else multisynth4
> -  2 = xtal
> -  3 = clkin (si5351c only)
> -- silabs,drive-strength: output drive strength in mA, shall be one of {2,4,6,8}.
> -- silabs,multisynth-source: source pll A(0) or B(1) of corresponding multisynth
> -  divider.
> -- silabs,pll-master: boolean, multisynth can change pll frequency.
> -- silabs,pll-reset: boolean, clock output can reset its pll.
> -- silabs,disable-state : clock output disable state, shall be
> -  0 = clock output is driven LOW when disabled
> -  1 = clock output is driven HIGH when disabled
> -  2 = clock output is FLOATING (HIGH-Z) when disabled
> -  3 = clock output is NEVER disabled
> -
> -==Example==
> -
> -/* 25MHz reference crystal */
> -ref25: ref25M {
> -	compatible = "fixed-clock";
> -	#clock-cells = <0>;
> -	clock-frequency = <25000000>;
> -};
> -
> -i2c-master-node {
> -
> -	/* Si5351a msop10 i2c clock generator */
> -	si5351a: clock-generator@60 {
> -		compatible = "silabs,si5351a-msop";
> -		reg = <0x60>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		#clock-cells = <1>;
> -
> -		/* connect xtal input to 25MHz reference */
> -		clocks = <&ref25>;
> -		clock-names = "xtal";
> -
> -		/* connect xtal input as source of pll0 and pll1 */
> -		silabs,pll-source = <0 0>, <1 0>;
> -
> -		/*
> -		 * overwrite clkout0 configuration with:
> -		 * - 8mA output drive strength
> -		 * - pll0 as clock source of multisynth0
> -		 * - multisynth0 as clock source of output divider
> -		 * - multisynth0 can change pll0
> -		 * - set initial clock frequency of 74.25MHz
> -		 */
> -		clkout0 {
> -			reg = <0>;
> -			silabs,drive-strength = <8>;
> -			silabs,multisynth-source = <0>;
> -			silabs,clock-source = <0>;
> -			silabs,pll-master;
> -			clock-frequency = <74250000>;
> -		};
> -
> -		/*
> -		 * overwrite clkout1 configuration with:
> -		 * - 4mA output drive strength
> -		 * - pll1 as clock source of multisynth1
> -		 * - multisynth1 as clock source of output divider
> -		 * - multisynth1 can change pll1
> -		 */
> -		clkout1 {
> -			reg = <1>;
> -			silabs,drive-strength = <4>;
> -			silabs,multisynth-source = <1>;
> -			silabs,clock-source = <0>;
> -			pll-master;
> -		};
> -
> -		/*
> -		 * overwrite clkout2 configuration with:
> -		 * - xtal as clock source of output divider
> -		 */
> -		clkout2 {
> -			reg = <2>;
> -			silabs,clock-source = <2>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> new file mode 100644
> index 000000000000..16d1142c4a2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> @@ -0,0 +1,245 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/silabs,si5351.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Labs Si5351A/B/C programmable I2C clock generators
> +
> +description: |
> +  The Silicon Labs Si5351A/B/C are programmable I2C clock generators with up to
> +  8 outputs. Si5351A also has a reduced pin-count package (10-MSOP) where only 3
> +  output clocks are accessible. The internal structure of the clock generators
> +  can be found in [1].
> +
> +  [1] Si5351A/B/C Data Sheet
> +      https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/data-sheets/Si5351-B.pdf
> +
> +maintainers:
> +  - Alvin Šipraga <alsi@bang-olufsen.dk>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - silabs,si5351a      # Si5351A, 20-QFN package
> +      - silabs,si5351a-msop # Si5351A, 10-MSOP package
> +      - silabs,si5351b      # Si5351B, 20-QFN package
> +      - silabs,si5351c      # Si5351C, 20-QFN package
> +
> +  reg:
> +    enum:
> +      - 0x60
> +      - 0x61
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks: true

minItems: 1
maxItems: 2

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: xtal
> +      - const: clkin
> +
> +  silabs,pll-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      A list of cell pairs containing a PLL index and its source. Allows to
> +      overwrite clock source of the internal PLLs.
> +    items:
> +      items:
> +        - description: PLL A (0) or PLL B (1)
> +          enum: [ 0, 1 ]
> +        - description: PLL source, XTAL (0) or CLKIN (1, Si5351C only).
> +          enum: [ 0, 1 ]
> +
> +patternProperties:
> +  "^clkout@[0-7]$":
> +    type: object
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description: Clock output number.
> +
> +      clock-frequency: true
> +
> +      silabs,clock-source:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Source clock of the this output's divider stage.
> +
> +          0 - use multisynth N for this output, where N is the output number
> +          1 - use either multisynth 0 (if output number is 0-3) or multisynth 4
> +              (otherwise) for this output
> +          2 - use XTAL for this output
> +          3 - use CLKIN for this output (Si5351C only)
> +
> +      silabs,drive-strength:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 2, 4, 6, 8 ]
> +        description: Output drive strength in mA.
> +
> +      silabs,multisynth-source:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1 ]
> +        description:
> +          Source PLL A (0) or B (1) for the corresponding multisynth divider.
> +
> +      silabs,pll-master:
> +        type: boolean
> +        description: |
> +          The frequency of the source PLL is allowed to be changed by the
> +          multisynth when setting the rate of this clock output.
> +
> +      silabs,pll-reset:
> +        type: boolean
> +        description: Reset the source PLL when enabling this clock output.
> +
> +      silabs,disable-state:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2, 3 ]
> +        description: |
> +          Clock output disable state. The state can be one of:
> +
> +          0 - clock output is driven LOW when disabled
> +          1 - clock output is driven HIGH when disabled
> +          2 - clock output is FLOATING (HIGH-Z) when disabled
> +          3 - clock output is never disabled
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: silabs,si5351a-msop
> +        then:
> +          properties:
> +            reg:
> +              maximum: 2
> +        else:
> +          properties:
> +            reg:
> +              maximum: 7
> +
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: silabs,si5351c
> +        then:
> +          properties:
> +            silabs,clock-source:
> +              enum: [ 0, 1, 2, 3 ]
> +        else:
> +          properties:
> +            silabs,clock-source:
> +              enum: [ 0, 1, 2 ]
> +
> +    required:
> +      - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - silabs,si5351a
> +              - silabs,si5351a-msop
> +              - silabs,si5351b
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 2

Presumably here the minimum is 2? So 'minItems: 2' instead. If it is 1 
or 2, then you can drop this 'else'.


> +        clock-names:
> +          maxItems: 2

Ditto.

> +
> +required:
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      clock-generator@60 {
> +        compatible = "silabs,si5351a-msop";
> +        reg = <0x60>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #clock-cells = <1>;
> +
> +        /* Connect XTAL input to 25MHz reference */
> +        clocks = <&ref25>;
> +        clock-names = "xtal";
> +
> +        /* Use XTAL input as source of PLL0 and PLL1 */
> +        silabs,pll-source = <0 0>, <1 0>;
> +
> +        /*
> +         * Overwrite CLK0 configuration with:
> +         * - 8 mA output drive strength
> +         * - PLL0 as clock source of multisynth 0
> +         * - Multisynth 0 as clock source of output divider
> +         * - Multisynth 0 can change PLL0
> +         * - Set initial clock frequency of 74.25MHz
> +         */
> +        clkout@0 {
> +          reg = <0>;
> +          silabs,drive-strength = <8>;
> +          silabs,multisynth-source = <0>;
> +          silabs,clock-source = <0>;
> +          silabs,pll-master;
> +          clock-frequency = <74250000>;
> +        };
> +
> +        /*
> +         * Overwrite CLK1 configuration with:
> +         * - 4 mA output drive strength
> +         * - PLL1 as clock source of multisynth 1
> +         * - Multisynth 1 as clock source of output divider
> +         * - Multisynth 1 can change PLL1
> +         * - Reset PLL1 when enabling this clock output
> +         */
> +        clkout@1 {
> +          reg = <1>;
> +          silabs,drive-strength = <4>;
> +          silabs,multisynth-source = <1>;
> +          silabs,clock-source = <0>;
> +          silabs,pll-master;
> +          silabs,pll-reset;
> +        };
> +
> +        /*
> +         * Overwrite CLK2 configuration with:
> +         * - XTAL as clock source of output divider
> +         */
> +        clkout@2 {
> +          reg = <2>;
> +          silabs,clock-source = <2>;
> +        };
> +      };
> +    };
> 
> -- 
> 2.42.0
> 
