Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6675FB50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGXP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGXP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A48E;
        Mon, 24 Jul 2023 08:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171F861233;
        Mon, 24 Jul 2023 15:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C82C433C8;
        Mon, 24 Jul 2023 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690214284;
        bh=y7P1Asqtsj5TcaaiF0pTY9gZJBqQYmy0urIAQWVytIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ac1IzIMDJxuhsGHd7Rshbg0CWHb+GEugmrHfIMd7suuPkCjRZVtQ6/UAjp8IgtwKY
         5nk9ecWJeNlZihtvrVvl7Q+DqvlwWKif3KDagZZc8G4qTKOL1jmggR0etjzZ3axqDf
         k70cO3CWVr5SNKjs5Qtg9DJKCrMUxlPtWfhoNSHbIZD8/ht12jQvH3nSG9yfSnRJC2
         x3vxJQ9Of586tvVpOWF7oqBQlLnlgdUgCEdYjHJe07+GnBdCapiOlfO9WlzLJfQjuf
         seh6mc+led2dYUZXA1kCH9RM4G7jOVA8ZK+ZqkePXUdn6UAIkCSNTorAWJ2OdwhUEf
         meNtpJeP+PRfQ==
Received: (nullmailer pid 3615968 invoked by uid 1000);
        Mon, 24 Jul 2023 15:58:02 -0000
Date:   Mon, 24 Jul 2023 09:58:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: convert syna,rmi4 to DT schema
Message-ID: <20230724155802.GA3609728-robh@kernel.org>
References: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:00:08PM +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
> Changes during conversion:
> 1. Add reset-gpios already used in DTS and mentioned by RMI4
>    specification.
> 2. Do not require address/size cells, because without functions
>    (children) they aren't really needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Jason, Matthias, Vincent,
> I put your names as maintainers, because moderately recently you were
> changing the driver. Let me know if this is okay or you prefer not to
> maintain the hardware.
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt     |  56 ----
>  .../bindings/input/rmi4/rmi_f01.txt           |  39 ---
>  .../bindings/input/rmi4/rmi_i2c.txt           |  61 ----
>  .../bindings/input/rmi4/rmi_spi.txt           |  56 ----
>  .../devicetree/bindings/input/syna,rmi4.yaml  | 271 ++++++++++++++++++
>  5 files changed, 271 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/input/syna,rmi4.yaml


> diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> new file mode 100644
> index 000000000000..286b4d52cea9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> @@ -0,0 +1,271 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/syna,rmi4.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics RMI4 compliant devices
> +
> +maintainers:
> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> +  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> +  - Vincent Huang <vincent.huang@tw.synaptics.com>
> +
> +description: |
> +  The Synaptics RMI4 (Register Mapped Interface 4) core is able to support RMI4
> +  devices using different transports (I2C, SPI) and different functions (e.g.
> +  Function 1, 2D sensors using Function 11 or 12).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - syna,rmi4-i2c
> +      - syna,rmi4-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Active low signal
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  syna,reset-delay-ms:
> +    description:
> +      Delay to wait after resetting the device.
> +
> +  syna,startup-delay-ms:
> +    description:
> +      Delay to wait after powering on the device.
> +
> +  vdd-supply: true
> +  vio-supply: true
> +
> +  rmi4-f01@1:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Function 1
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      syna,nosleep-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        description:
> +          If set the device will run at full power without sleeping.  nosleep
> +          has 3 modes, 0 will not change the default setting, 1 will disable
> +          nosleep (allow sleeping), and 2 will enable nosleep (disabling
> +          sleep).
> +
> +      syna,wakeup-threshold:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Defines the amplitude of the disturbance to the background
> +          capacitance that will cause the device to wake from dozing.
> +
> +      syna,doze-holdoff-ms:
> +        description:
> +          The delay to wait after the last finger lift and the first doze
> +          cycle.
> +
> +      syna,doze-interval-ms:
> +        description:
> +          The time period that the device sleeps between finger activity.
> +
> +    required:
> +      - reg
> +
> +patternProperties:
> +  "^rmi4-f1[12]@1[12]$":
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +    description:
> +      RMI4 Function 11 and Function 12 are for 2D touch position sensing.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      syna,clip-x-low:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Minimum value for X.
> +
> +      syna,clip-y-low:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Minimum value for Y.
> +
> +      syna,clip-x-high:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Maximum value for X.
> +
> +      syna,clip-y-high:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Maximum value for Y.
> +
> +      syna,offset-x:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Add an offset to X.
> +
> +      syna,offset-y:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Add an offset to Y.
> +
> +      syna,delta-x-threshold:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Minimum distance on the X axis required to generate an interrupt in
> +          reduced reporting mode.
> +
> +      syna,delta-y-threshold:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Minimum distance on the Y axis required to generate an interrupt in
> +          reduced reporting mode.
> +
> +      syna,sensor-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2]
> +        description: |
> +          Sensor type: 1 for touchscreen 2 for touchpad.
> +
> +      syna,disable-report-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Mask for disabling posiiton reporting. Used to disable reporing
> +          absolute position data.
> +
> +      syna,rezero-wait-ms:
> +        description:
> +          Time to wait after issuing a rezero command.
> +
> +    required:
> +      - reg
> +
> +  "^rmi4-f[0-9a-z]+@[0-9a-z]+$":

a-f in both places.

> +    type: object
> +    description:
> +      Other functions, not documented yet.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syna,rmi4-i2c
> +    then:
> +      properties:
> +        spi-rx-delay-us: false
> +        spi-tx-delay-us: false
> +    else:
> +      properties:
> +        syna,reset-delay-ms: false
> +        syna,startup-delay-ms: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@20 {
> +            compatible = "syna,rmi4-i2c";
> +            reg = <0x20>;
> +            interrupt-parent = <&gpx1>;
> +            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +
> +            syna,startup-delay-ms = <100>;
> +            vdd-supply = <&tsp_vdd>;
> +            vio-supply = <&ldo32_reg>;
> +
> +            pinctrl-0 = <&touch_irq>;
> +            pinctrl-names = "default";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            rmi4-f01@1 {
> +                reg = <0x1>;
> +                syna,nosleep-mode = <1>;
> +            };
> +
> +            rmi4-f12@12 {
> +                reg = <0x12>;
> +                syna,sensor-type = <1>;
> +            };
> +
> +            rmi4-f1a@1a {
> +                reg = <0x1a>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@0 {
> +            compatible = "syna,rmi4-spi";
> +            reg = <0x0>;
> +            interrupt-parent = <&gpx1>;
> +            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +
> +            spi-max-frequency = <4000000>;
> +            spi-rx-delay-us = <30>;
> +            spi-cpha;
> +            spi-cpol;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            rmi4-f01@1 {
> +                reg = <0x1>;
> +                syna,nosleep-mode = <1>;
> +            };
> +
> +            rmi4-f11@11 {
> +                reg = <0x11>;
> +                touchscreen-inverted-y;
> +                syna,sensor-type = <2>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
