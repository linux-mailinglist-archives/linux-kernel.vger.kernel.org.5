Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1C7ACAD3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIXQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:57:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC838FC;
        Sun, 24 Sep 2023 09:57:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE36C433C8;
        Sun, 24 Sep 2023 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695574648;
        bh=pcqmIy1Oq4US3JaYcyp2KhT0P2GlDacSxfYdLEt31LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=piWVI9jdLyRif7YKlT4Kl3TPfpbY+im7I7I3WCI5xe0yuB0r1GLG8PEsisSviBHE5
         f8LsuGbVIfZBYzt/2VWh8m2dDp+2XvuGMBAi3HRBslBSP3JxzhE5RJ8OByJQsnazBs
         nS/Rbx1GSRd+iVmeIrwZpu3RbVGuI1xaJMk6H0UBUAv8pcGFGE3nPwJ8QfN0dfH1L1
         9Tcfl6INT2s05PvPoH5RnYN5/VwLu79K2KvrcSV4wSX2pdct3rIrjOAY6Jmi+UhyIe
         1qKYZbPXfe1Enh2NKkmSaW7qjDeSakl9hTNp1tswqMJZzUqqKX+svBDiCcCyNapG8Z
         xsoB9nEAi+IXw==
Date:   Sun, 24 Sep 2023 17:57:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <20230924175720.3be2540b@jic23-huawei>
In-Reply-To: <20230921144400.62380-2-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-2-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
> 
> Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

We've become more fussy about it recently but for new bindings at least,
we want to include all power supplies and mark them as required.

A few other trivial things inline,

Jonathan


> ---
> 
> v2 changes:
> * Add Co-developed-by:
> * Remove extraneous quotes on strings
> * Remove extraneous pipe on some multi-line descriptions
> 
>  .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> new file mode 100644
> index 000000000000..f55c9652cfb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> @@ -0,0 +1,150 @@
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
> +    A1  A0  Result

Should say what A0 and A1 are.  It's down below but seems odd
that it is here for RES0 and RES1 but not the A1 and A0 signals.

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

That is impressively random ;)  Good to call it out.

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

What if someone is being odd and connected only 1 of them?
It's annoying how often people run out of pins and do things like this.

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

Good description as this was non obvious.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - clocks
> +  - sample-gpios
> +  - assigned-resolution-bits
> +
> +oneOf:
> +  - required:
> +      - mode-gpios
> +  - required:
> +      - adi,fixed-mode
I think this allows for both.  It's fiddlier to exclude that but would be a nice
to have perhaps rather than relying on text above that says 'don't do it'.

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
> +            clocks = <&ext_osc>;
> +            sample-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
> +            mode-gpios = <&gpio0 86 0>, <&gpio0 87 0>;
> +            resolution-gpios = <&gpio0 88 0>, <&gpio0 89 0>;
> +            assigned-resolution-bits = <16>;
> +        };
> +    };

