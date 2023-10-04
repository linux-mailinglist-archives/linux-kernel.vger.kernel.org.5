Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDB7B8288
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbjJDOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjJDOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:39:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BFC1;
        Wed,  4 Oct 2023 07:39:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B3BC433C8;
        Wed,  4 Oct 2023 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696430379;
        bh=U1NGLITL8Rf5crY2/ZChUEDsdN/rfYafMwCe01hDqrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mbx+7rdw5z7ej9ZE0HDGdXN+9m4YPieLkiCAUhg4dVbfqSzn883zLJtkYOmWqtnQt
         mo1JiH5gPe9pp/2bSpW+OHWTwuwMJ0UT2CHZc6732OCqngpcFWYqXE1rVP/JeGXRRQ
         pVsV90YHhI7LNRYhSK4lMfJWeuSL8I8z15RJDBnkZ2xhu+tu8zYjQ0WsB8TxMgrH+k
         JQF0poq0QHSIzfF+jpn3T8QO+B0HoY1tUt39OiF9+wq79srYvi1zso8yvpY9QmSc9+
         YJYmuV7LdT/pQy+6C71boqEHMaq66WsKJ3bkcQlc2ouOHH2Ea/blRvtcSgcEQdgjIs
         yud/XLSc28Z4A==
Received: (nullmailer pid 3103312 invoked by uid 1000);
        Wed, 04 Oct 2023 14:39:37 -0000
Date:   Wed, 4 Oct 2023 09:39:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
Message-ID: <20231004143937.GA3091822-robh@kernel.org>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
 <20231004063712.3348978-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004063712.3348978-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 08:35:27AM +0200, Alvin Šipraga wrote:
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
>  .../bindings/clock/silabs,si5351.yaml         | 253 ++++++++++++++++++
>  2 files changed, 253 insertions(+), 126 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> new file mode 100644
> index 000000000000..400c8cec2a3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> @@ -0,0 +1,253 @@
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
> +  silabs,pll-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      A list of cell pairs containing a PLL index and its source. Allows to
> +      overwrite clock source of the internal PLLs.
> +    minItems: 1

The minimum is 1 by default (can't have 0).

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
> +    properties:
> +      reg:
> +        $ref: /schemas/types.yaml#/definitions/uint32

reg already has a type. Drop.

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
> +        description: |

Don't need '|' if no formatting to preserve.

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
> +              minimum: 0

The minimum is already 0. Drop.

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
> +              enum: [ 0, 1, 2, 3 ]
> +        else:
> +          properties:
> +            silabs,clock-source:
> +              enum: [ 0, 1, 2 ]
> +    required:
> +      - reg
> +
> +    additionalProperties: false

Move this next to 'type: object'

> +
> +allOf:
> +  - $ref: /schemas/clock/clock.yaml

Don't need this.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - silabs,si5351a
> +              - silabs,si5351a-msop
> +              - silabs,si5351b

Isn't this just the 'else' for the next one? Or more parts are coming?

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

Define clocks and clock-names at the top level and just use 
minItems/maxItems in the if/then schemas.

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
> -- 
> 2.42.0
> 
