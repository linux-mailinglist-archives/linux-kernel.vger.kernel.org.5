Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9297B40EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjI3Oen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjI3Oel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:34:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEDAC2;
        Sat, 30 Sep 2023 07:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E5C433C8;
        Sat, 30 Sep 2023 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084470;
        bh=D7I4cJTKlBE/dmAH42x6oWLc4hjUfl3NJBot7m7U8I8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JxfnKyn884+kDOtNHDkjRG0017UWi2qHsdCQ4pXgLIN6wK/tmVgmplFcLraSt3vtd
         izJu8sAq/3xD+HuXKNjM/vi2wj1hiI7izTS7+depU7c5ubQf8A1oM179rXf6UvZ8rp
         78p97TU+H30FDCndxlgouVcDvW0Zy6BiUmU1yuPdCYzyrYto3vx6fimZn4LOJAeodY
         nHI6/eWXoZZDps+OG9VUc0BhzKQfjEZb8ijg/cdJ3WleNKPQivRWwjIj7fv4eVAVcr
         z13TR/YpcbOoSnHtaVJBTJ0RHgwVXR+R1wLEROt5pcRlUqs0FZYZmy8KaWhALgGt2D
         ONJryU4SAIAxA==
Date:   Sat, 30 Sep 2023 15:34:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: Re: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <20230930153429.0387ab8c@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:23:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
> 
> Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Michael, ideally I'd like your ack on this given it volunteers you as
maintainer. If I don't hear I'm fine with leaving Michael listed
because he's in MAINTAINERS anyway covering these bindings via
a wild card entry:

ANALOG DEVICES INC IIO DRIVERS
M:	Lars-Peter Clausen <lars@metafoo.de>
M:	Michael Hennerich <Michael.Hennerich@analog.com>
...
F:	Documentation/devicetree/bindings/iio/*/adi,*

So any queries should hit Michael anyway.

LGTM but I'll also want the dt binding maintainers input before picking this
up.

Jonathan

> ---
> 
> v3 changes:
> * Expanded top-level description of A0/A1 lines.
> * Added required voltage -supply properties. (I did not pick up Rob's
>   Reviewed-by since I wasn't sure if this was trivial enough.)
> 
> v2 changes:
> * Add Co-developed-by:
> * Remove extraneous quotes on strings
> * Remove extraneous pipe on some multi-line descriptions
> 
>  .../bindings/iio/resolver/adi,ad2s1210.yaml        | 177 +++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> new file mode 100644
> index 000000000000..8980b3cd8337
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/resolver/adi,ad2s1210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD2S1210 Resolver-to-Digital Converter
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  The AD2S1210 is a complete 10-bit to 16-bit resolution tracking
> +  resolver-to-digital converter, integrating an on-board programmable
> +  sinusoidal oscillator that provides sine wave excitation for
> +  resolvers.
> +
> +  The AD2S1210 allows the user to read the angular position or the
> +  angular velocity data directly from the parallel outputs or through
> +  the serial interface.
> +
> +  The mode of operation of the communication channel (parallel or serial) is
> +  selected by the A0 and A1 input pins. In normal mode, data is latched by
> +  toggling the SAMPLE line and can then be read directly. In configuration mode,
> +  data is read or written using a register access scheme (address byte with
> +  read/write flag and data byte).
> +
> +    A1  A0  Result
> +     0   0  Normal mode - position output
> +     0   1  Normal mode - velocity output
> +     1   0  Reserved
> +     1   1  Configuration mode
> +
> +  In normal mode, the resolution of the digital output is selected using
> +  the RES0 and RES1 input pins. In configuration mode, the resolution is
> +  selected by setting the RES0 and RES1 bits in the control register.
> +
> +  RES1  RES0  Resolution (Bits)
> +     0     0  10
> +     0     1  12
> +     1     0  14
> +     1     1  16
> +
> +  Note on SPI connections: The CS line on the AD2S1210 should hard-wired to
> +  logic low and the WR/FSYNC line on the AD2S1210 should be connected to the
> +  SPI CSn output of the SPI controller.
> +
> +  Datasheet:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad2s1210.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,ad2s1210
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  spi-cpha: true
> +
> +  avdd-supply:
> +    description:
> +      A 4.75 to 5.25 V regulator that powers the Analog Supply Voltage (AVDD)
> +      pin.
> +
> +  dvdd-supply:
> +    description:
> +      A 4.75 to 5.25 V regulator that powers the Digital Supply Voltage (DVDD)
> +      pin.
> +
> +  vdrive-supply:
> +    description:
> +      A 2.3 to 5.25 V regulator that powers the Logic Power Supply Input
> +      (VDrive) pin.
> +
> +  clocks:
> +    maxItems: 1
> +    description: External oscillator clock (CLKIN).
> +
> +  reset-gpios:
> +    description:
> +      GPIO connected to the /RESET pin. As the line needs to be low for the
> +      reset to be active, it should be configured as GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  sample-gpios:
> +    description:
> +      GPIO connected to the /SAMPLE pin. As the line needs to be low to trigger
> +      a sample, it should be configured as GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  mode-gpios:
> +    description:
> +      GPIO lines connected to the A0 and A1 pins. These pins select the data
> +      transfer mode.
> +    minItems: 2
> +    maxItems: 2
> +
> +  resolution-gpios:
> +    description:
> +      GPIO lines connected to the RES0 and RES1 pins. These pins select the
> +      resolution of the digital output. If omitted, it is assumed that the
> +      RES0 and RES1 pins are hard-wired to match the assigned-resolution-bits
> +      property.
> +    minItems: 2
> +    maxItems: 2
> +
> +  fault-gpios:
> +    description:
> +      GPIO lines connected to the LOT and DOS pins. These pins combined indicate
> +      the type of fault present, if any. As these pins a pulled low to indicate
> +      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,fixed-mode:
> +    description:
> +      This is used to indicate the selected mode if A0 and A1 are hard-wired
> +      instead of connected to GPIOS (i.e. mode-gpios is omitted).
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [config, velocity, position]
> +
> +  assigned-resolution-bits:
> +    description:
> +      Resolution of the digital output required by the application. This
> +      determines the precision of the angle and/or the maximum speed that can
> +      be measured. If resolution-gpios is omitted, it is assumed that RES0 and
> +      RES1 are hard-wired to match this value.
> +    enum: [10, 12, 14, 16]
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - avdd-supply
> +  - dvdd-supply
> +  - vdrive-supply
> +  - clocks
> +  - sample-gpios
> +  - assigned-resolution-bits
> +
> +oneOf:
> +  - required:
> +      - mode-gpios
> +  - required:
> +      - adi,fixed-mode
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        resolver@0 {
> +            compatible = "adi,ad2s1210";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            spi-cpha;
> +            avdd-supply = <&avdd_regulator>;
> +            dvdd-supply = <&dvdd_regulator>;
> +            vdrive-supply = <&vdrive_regulator>;
> +            clocks = <&ext_osc>;
> +            sample-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
> +            mode-gpios = <&gpio0 86 0>, <&gpio0 87 0>;
> +            resolution-gpios = <&gpio0 88 0>, <&gpio0 89 0>;
> +            assigned-resolution-bits = <16>;
> +        };
> +    };
> 

