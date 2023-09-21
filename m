Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502487A9EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjIUUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjIUUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:14:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED7C9BE4;
        Thu, 21 Sep 2023 11:19:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DFCC433C7;
        Thu, 21 Sep 2023 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695320348;
        bh=aWZsx72+ZA5JrEnMaE67KMYs7oCDmblGw0CZ5efjjuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4sc8M8Y4SRwOy5cv9DG7OgTI2HX+oUskrTMR0su566s8uGjiI/DBYBkPAxqfeXf7
         UHfkJQeyfmEF4Nzg3BYy6HpFK5Zr8H2EP5Mmf/40UAreBOXWo4ONWpVL74k8LeoWYE
         Nk8WtUcaue0ewRd5DGFc6y/sckSDPMuz37cxZQdO81s37DnlPL+QkuI/6G/IvtedJC
         SVxuvmz8dh9VU6qBbk/OCoxzMYkJ4vsY9jCM5fAuVJri/sMTOLZyz0lA+eRu/UvB8T
         XJd/YGipRGIEXB0NrkT81KMe1F7O8IWFlLhi0FJF5gSlBwfYtuJmZIXhZ0sf8RmuyH
         2naRJ9QGVH6LA==
Received: (nullmailer pid 761372 invoked by uid 1000);
        Thu, 21 Sep 2023 18:19:04 -0000
Date:   Thu, 21 Sep 2023 13:19:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: si5351: convert to yaml
Message-ID: <20230921181904.GA750881-robh@kernel.org>
References: <20230920140343.2329225-1-alvin@pqrs.dk>
 <20230920140343.2329225-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920140343.2329225-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:09:53PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The following additional properties are described:
> 
>   - clock-names
>   - clock-frequency of the clkout child nodes
> 
> In order to suppress warnings from the DT schema validator, the clkout
> child nodes are prescribed names clkout@[0-7] rather than clkout[0-7].
> The latter form is still admissible but the example has been changed to
> use the former.
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
>  .../bindings/clock/silabs,si5351.txt          | 126 ---------
>  .../bindings/clock/silabs,si5351.yaml         | 251 ++++++++++++++++++
>  2 files changed, 251 insertions(+), 126 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.yaml
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
> index 000000000000..3ca8d998c48c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> @@ -0,0 +1,251 @@
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
> +    description: |
> +      I2C address of the clock generator

Drop the description.

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
> +  silabs,pll-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 2

This only defines the number of entries. You need the inner dimensions:

items:
  - description: PLL A (0) or PLL B (1)
    enum: [ 0, 1 ]
  - description: PLL source
    enum: [ ??? ]

> +    description: |
> +      Pair of <number source> for each PLL. Allows to overwrite clock source of
> +      PLL A (number=0) or PLL B (number=1).
> +
> +patternProperties:
> +  "^clkout@?[0-8]$":

"@" should not be optional. We should fix the node names in the dts 
files.

Shouldn't it be 0-7?

> +    type: object
> +
> +    properties:
> +      reg:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Clock output number.
> +
> +      clock-frequency:
> +        $ref: /schemas/clock/clock.yaml#/properties/clock-frequency

Don't need this ref. Just 'clock-frequency: true' is enough if there are 
no constraints? I'm sure there's some min and max freq?

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
> +        enum: [2, 4, 6, 8]
> +        description: Output drive strength in mA.
> +
> +      silabs,multisynth-source:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
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
> +        enum: [0, 1, 2, 3]
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
> +              minimum: 0
> +              maximum: 2
> +        else:
> +          properties:
> +            reg:
> +              minimum: 0
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
> +              enum: [0, 1, 2, 3]
> +        else:
> +          properties:
> +            silabs,clock-source:
> +              enum: [0, 1, 2]
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/clock/clock.yaml
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
> +          minItems: 1
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: xtal
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: silabs,si5351c
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: xtal
> +            - const: clkin
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
> +      si5351a: clock-generator@60 {

Drop unused labels.

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
> -- 
> 2.41.0
> 
