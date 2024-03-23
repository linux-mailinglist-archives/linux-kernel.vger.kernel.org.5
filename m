Return-Path: <linux-kernel+bounces-112451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACB4887A02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47E3B21119
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CD56B78;
	Sat, 23 Mar 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWZjGrdi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9A51C49;
	Sat, 23 Mar 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219510; cv=none; b=cr5+3PHZ0hSzKqdr3BYvR2dDpg93fJBwJ2gWyxgkBUFG7mH6c38HRmT689ThizroU7IQY09EdBlXijdH7oreXYL8UdERQH0OSgkQ0ewMPvRE/QsRFT3ns9Hm0nfhp+SkQheCDJxKLcyPz5aMnXXEuypQqSdav97+bosIqp1nEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219510; c=relaxed/simple;
	bh=qnY8bUQGz3q3YShhbANJdVaqAPOJZlTPY1PW4EUz5Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDrDHuvk45/F2YGaBbLWPso84Rik1U0/fIkGqgOBugQrNUjTKxDQ4YoTtl62a/4MPBoOHPdcZe47C5Sj8jqoTxe/E/3PLh2WQqMRZdX604I5vUVEsXTSxMkfZl7qlc3zFDo2q1ktKRt1p14rE+RLDceL33mN2g5C8FAVp32gwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWZjGrdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB379C433F1;
	Sat, 23 Mar 2024 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711219510;
	bh=qnY8bUQGz3q3YShhbANJdVaqAPOJZlTPY1PW4EUz5Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWZjGrdiUpIV4xQ0rhkoy3+cAeHAtQ6DwT1YA+1OaT0/V74kZ+rq+iznscZsfieCt
	 h4IzVjCSDIAmuJigqeo6fXzr97TUrwwUJlA65AwUI47sRogdgI0aP1MkHsvG4h30Lj
	 vpT1krkIuVTdQ3qPU2MJppZowKUjl7+6X1fua/qAOhSv2uFEn69PGla7j8qNKMAB9+
	 fOxT/nO6tCOVLx43eITl4PmCaSnvxlwBzJZrQ+HvF/05RUy3B+WAIq6wfbPGrUsJ5F
	 rsZ2kHBUYakqsM9hp08ZJbTfrrcfn/2hHK/3+3YQ7tu6AWoqF1eZX+EgQd+Cqg6Uzu
	 lLWVaq18zUu7g==
Date: Sat, 23 Mar 2024 18:44:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240323184454.201edbc3@jic23-huawei>
In-Reply-To: <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
	<81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 19:05:08 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4000 series of ADC devices.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Pasting relevant comment from cover letter here to aid reviewers.
> 
> These devices have the same SPI (Strange Peripheral Interface) as AD7944
> devices, which has been documented in ad7944.rst [1].
> The device tree description for SPI connections and mode can be the same as of
> ad7944 adi,spi-mode [2].
> Because ad4000 driver does not currently support daisy-chain mode, I simplified
> things a little bit. If having a more complete doc is preferred, I'm fine
> changing to that.
> 
> [1]: https://lore.kernel.org/linux-iio/20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/20240304-ad7944-mainline-v5-1-f0a38cea8901@baylibre.com/
> 
>  .../bindings/iio/adc/adi,ad4000.yaml          | 151 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> new file mode 100644
> index 000000000000..9e3d6a3920ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4000 ADC device driver
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4000
> +      - adi,ad4001
> +      - adi,ad4002
> +      - adi,ad4003
> +      - adi,ad4004
> +      - adi,ad4005
> +      - adi,ad4006
> +      - adi,ad4007
> +      - adi,ad4008
> +      - adi,ad4010
> +      - adi,ad4011
> +      - adi,ad4020
> +      - adi,ad4021
> +      - adi,ad4022
> +      - adi,adaq4001
> +      - adi,adaq4003
> +
> +  reg: true
> +  spi-max-frequency: true
> +
> +  vref-supply:
> +    description: Phandle to the regulator for ADC reference voltage.
> +
> +  adi,gain-milli:
> +    description: |
> +      The hardware gain applied to the ADC input (in milli units).
> +      The gain provided by the ADC input scaler is defined by the hardware
> +      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
> +      If not present, default to 1000 (no actual gain applied).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [454, 909, 1000, 1900]
> +    default: 1000
> +
> +  adi,spi-cs-mode:

We've just merged a driver for the ad7944 and bindings which has a
similar 3-wire-mode.  Please share the approach used in that binding.
Whilst it seems we don't have the other mode here, I think we still want
to use a similar enum.
+CC David to take a look at this one given he went through long
discussions on how to deal with it for the driver he was working on
so probably remembers the reasoning etc better than I do :)

Jonathan



> +    type: boolean
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it indicates that the device SDI pin is
> +      connected to SPI controller CS line and device CNV pin has been connected
> +      to a GPIO. Datasheets call this "4-wire mode".
> +
> +      When this property is present, the driver must assume standard SPI
> +      connections which, for these devices, consists of connecting the
> +      controller CS line to device CNV pin. This configuration is
> +      (misleadingly) called "3-wire mode" in datasheets.
> +
> +  cnv-gpios:
> +    description: The GPIO connected to the CNV pin.
> +    maxItems: 1
> +
> +patternProperties:
> +  "^channel@([0-1])$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the external channel connected to the ADC.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      diff-channels: true
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        adi,spi-cs-mode: false
> +    then:
> +      required:
> +        - cnv-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        /* Example for a AD4000 devices */
> +        adc@0 {
> +            compatible = "adi,ad4020";
> +            reg = <0>;
> +            spi-max-frequency = <71000000>;
> +            vref-supply = <&vref>;
> +            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <0 1>;
> +            };
> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        /* Example for a ADAQ4000 devices */
> +        adc@0 {
> +            compatible = "adi,adaq4003";
> +            reg = <0>;
> +            spi-max-frequency = <80000000>;
> +            vref-supply = <&vref>;
> +            adi,spi-cs-mode;
> +            adi,gain-milli = <454>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <0 1>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2662ec49b297..3ca90f842298 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1135,6 +1135,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>  F:	drivers/iio/dac/ad3552r.c
>  
> +ANALOG DEVICES INC AD4000 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org


