Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196277825B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjHJUvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHJUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB6270E;
        Thu, 10 Aug 2023 13:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D549965449;
        Thu, 10 Aug 2023 20:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD3C433C8;
        Thu, 10 Aug 2023 20:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700670;
        bh=D/+A79azXEalodMTBC1cWRFoAqzjpUxIqIK+CgZ8WcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7T4m0rQQGbHwzkP0K3ZaZQSlJN+UpYOynNdXP45ljAmD8T19J702URtqg9eo7Hii
         Kgy1KqdYazA2QcFpBOQyR1xCyBdIyxQ6fziWyY5zErD96I4OT8jgqprxo/grMhHbnE
         PTuYrwppjVS++yDL3YNPW++tyrWNMpptDXEoxgFyt9MST6B3eD5a0+5Hy+yPN/PR7B
         FeWnKDFRhU9iAvgklAQMw65M+smfCIwYZe+2BWubtXIbYSZ/UBnCKCqztZBisZVKVs
         XbhnagBxq7xMBZ02FkQaX11LreKY6NtdhnKin6mj1NSHX5HsLOKCG7g9KWQq+WXm4v
         Ea2yCjd1Px2SA==
Received: (nullmailer pid 1154620 invoked by uid 1000);
        Thu, 10 Aug 2023 20:51:07 -0000
Date:   Thu, 10 Aug 2023 14:51:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: adc: add AD717X
Message-ID: <20230810205107.GA1136590-robh@kernel.org>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093322.593259-1-mitrutzceclan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:33:16PM +0300, Dumitru Ceclan wrote:
> The AD717x family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad717x.yaml          | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
> new file mode 100644
> index 000000000000..f12926e69958
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad717x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD717X ADC family SPI driver

Drop 'SPI driver'. This is not a driver.

> +
> +maintainers:
> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7172-2
> +      - adi,ad7173-8
> +      - adi,ad7175-2
> +      - adi,ad7176-2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  spi-cpol:
> +    type: boolean
> +
> +  spi-cpha:
> +    type: boolean
> +
> +  adi,temp-channel:
> +    description:
> +      Enables temperature reading channel
> +    type: boolean
> +
> +  dependencies:
> +    adi,temp-channel:
> +      compatible:
> +        enum:
> +          - adi,ad7172-2
> +          - adi,ad7173-8
> +          - adi,ad7175-2

That's not actually valid schema. You are missing "properties" above 
"compatible". I'm also not sure the tools which do a number of 
fixups/transforms on schemas would handle this. I do think this is a bit 
nicer than the if/then schemas we normally use for restricting 
properties by compatibles.

> +
> +

Extra blank line.

> +  required:
> +    - compatible
> +    - reg
> +    - interrupts
> +    - spi-cpol
> +    - spi-cpha

If the device(s) are not configurable, then you shouldn't need these 2 
properties. The driver can hardcode the correct setting.

> +
> +patternProperties:
> +  "^channel@([0-9a-f])$":

Don't need ().

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        description:
> +          Analog input pins
> +        items:
> +          minimum: 0
> +          maximum: 31
> +      
> +      adi,bipolar:
> +        description: Specify if the channel should measure in bipolar mode.
> +        type: boolean
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      status = "okay";

Drop status.

You need #address-cells and #size-cells. Did you test this?

> +
> +      ad7173@0 {
> +        compatible = "adi,ad7173-8";
> +        reg = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-parent = <&gpio>;
> +        spi-max-frequency = <5000000>;
> +        spi-cpol;
> +        spi-cpha;
> +
> +        adi,temp-channel;
> +
> +        channel@0 {
> +          reg = <0>;
> +          adi,bipolar;
> +
> +          diff-channels = <0 1>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +
> +          diff-channels = <2 3>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +          adi,bipolar;
> +
> +          diff-channels = <4 5>;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +          adi,bipolar;
> +
> +          diff-channels = <6 7>;
> +        };
> +
> +        channel@4 {
> +          reg = <4>;
> +
> +          diff-channels = <8 9>;
> +        };
> +      };
> +    };
> -- 
> 2.30.2
> 
