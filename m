Return-Path: <linux-kernel+bounces-26512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550882E25A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EEC1F22EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A721B58A;
	Mon, 15 Jan 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EWopEcah"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B781B584
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd33336b32so120594631fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705355631; x=1705960431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0juhdxoJdNDjw3AWC7m674HZgZNMoXBN904ysxBcgSY=;
        b=EWopEcahXmwmGocHFB/tEfXBcVBpIcPv/tsOi5vf+WJiaFOsGWf+DulHLv6qRY3cCB
         mqAXrDj8wzlUZp5tK/uHJZ90F3VS2d4qHC7YyqbpcZwQsMqH4WbKtv3ncVm4+XQD9iJn
         6+DYnm6E7Go8xH5W41NVXN2RtZqW5UCUau6tU7EPumUvIzIxsl7gwN8fsSSobMwe2Yxl
         jNVVsDXW0FBnqyFiqnwZv34rV98zXoVk348KSgiyBR/S5vs/wUMVLp9SfsBTviDNL719
         VvBilHo1n+lx+mTd9FGlEUQhXDMt+Y3w4RmDwUZZ81Fj5edz1Zl0k6JOLP0byG86KCpx
         zhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355631; x=1705960431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0juhdxoJdNDjw3AWC7m674HZgZNMoXBN904ysxBcgSY=;
        b=FYEdyKOay27xp4OGvUyh1oXI75Y23tnzlSiRSO8i1IZTykMhouhUXXtgRrHOTis/dd
         6tm+IEG7El64HNXAkHmp+SAmGpAVMI2aZrpaTGp7XyChiMyCqvlK7tAJ2g2VEtgdlxa8
         hSzYaDPq0W8c1V4KPapdhku/OLVSIBvyhiGqCKuhnlrgY0wNJAlR0AnP3NGvRKDhHReQ
         /TOtq4JwXTfG3eER9SrkUsq/CNirmBkF/it1KDPyup0jPRgfyZQdPmLaybC+KPa8BZbE
         Dlvm9f8HI+bC4SQhvzFqHXthbGnSWL/GYP0GZyAK05y6jzwmNLzv7yWQe6uL399JXK9W
         uVgw==
X-Gm-Message-State: AOJu0Yxyabck20M+faMK45yuIGQDUx8sqAoUbfSgJ04tTLY2GlawBRJR
	/vmQdYdZHFignMvVktc7O3ECpmI88t/6RviI38WvZUTaTUiDXd8keqD3Um1u0qw=
X-Google-Smtp-Source: AGHT+IGYi8HACiYudVUVmDmfVIu6fL9eg+hsPDqQoeSbZVORoJSzUkCzMnPUtyA7lZ+zfvqM1cVeE1n8Nt1Yi0D892s=
X-Received: by 2002:a2e:9c91:0:b0:2cc:9882:4cb5 with SMTP id
 x17-20020a2e9c91000000b002cc98824cb5mr3372646lji.45.1705355630105; Mon, 15
 Jan 2024 13:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
In-Reply-To: <20231220104810.3179-1-mitrutzceclan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jan 2024 15:53:39 -0600
Message-ID: <CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 4:48=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmail=
com> wrote:
>
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel application=
s
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Sorry for the late reply as I see this has been applied already but...

(I've been going over the datasheets for these and other related parts
(AD411x) in detail today so please CC me on future updates to the
bindings/driver for these if you don't mind)

>  .../bindings/iio/adc/adi,ad7173.yaml          | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> new file mode 100644
> index 000000000000..7c8caef76528
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -0,0 +1,188 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7173 ADC
> +
> +maintainers:
> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported=
 chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
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

As discussed in v8 [1] it is not clear what signal this is. Based on
that discussion, I'm assuming the RDY signal, but how would bindings
consumers know that without a description since it is not the only
digital output signal of the chip? And why the ERROR signal was
omitted here was never addressed AFAICT.

[1]: https://lore.kernel.org/linux-iio/20231217135007.3e5d959a@jic23-huawei=
/

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

According to the timing diagram in the datasheet, SCLK is high during
idle, so don't we need `spi-cpol: true` here?

Likewise, data is valid on the trailing SCLK edge, so don't we need
`spi-cpha: true` here?


> +  gpio-controller:
> +    description: Marks the device node as a GPIO controller.
> +
> +  "#gpio-cells":
> +    const: 2
> +    description:
> +      The first cell is the GPIO number and the second cell specifies
> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> +
> +  refin-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.

If I'm understanding correctly, this represents both voltage inputs
REF+ and REF-, correct? The datasheet says "Reference Input Negative
Terminal. REF=E2=88=92 can span from AVSS to AVDD1 =E2=88=92 1 V". It seems=
 like they
should be separate supplies in case REF- is non-zero. Otherwise, how
can we know what voltage it is? (same comment applies to refin2.)

> +
> +  refin2-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.
> +
> +  avdd-supply:
> +    description: avdd supply, can be used as reference for conversion.
> +
> +  avdd2-supply:
> +    description: avdd2 supply, used as the input to the internal voltage=
 regulator.
> +
> +  iovdd-supply:
> +    description: iovdd supply, used for the chip digital interface.
> +

I overlooked this before, but these chips also have an optional
external clock input so it seems like they should have an optional
clocks property as well.

> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        items:
> +          minimum: 0
> +          maximum: 31
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          refin      : REFIN(+)/REFIN(=E2=88=92).
> +          refin2     : REFIN2(+)/REFIN2(=E2=88=92)
> +          refout-avss: REFOUT/AVSS (Internal reference)
> +          avdd       : AVDD
> +
> +          External reference refin2 only available on ad7173-8.
> +          If not specified, internal reference used.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - refin
> +          - refin2
> +          - refout-avss
> +          - avdd
> +        default: refout-avss
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Why are interrupts required? What if the pin is not connected?

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: adi,ad7173-8
> +    then:
> +      properties:
> +        refin2-supply: false
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,reference-select:
> +              enum:
> +                - refin
> +                - refout-avss
> +                - avdd
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "adi,ad7173-8";
> +        reg =3D <0>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-parent =3D <&gpio>;
> +        spi-max-frequency =3D <5000000>;
> +        gpio-controller;
> +        #gpio-cells =3D <2>;
> +
> +        refin-supply =3D <&dummy_regulator>;
> +
> +        channel@0 {
> +          reg =3D <0>;
> +          bipolar;
> +          diff-channels =3D <0 1>;
> +          adi,reference-select =3D "refin";
> +        };
> +
> +        channel@1 {
> +          reg =3D <1>;
> +          diff-channels =3D <2 3>;
> +        };
> +
> +        channel@2 {
> +          reg =3D <2>;
> +          bipolar;
> +          diff-channels =3D <4 5>;
> +        };
> +
> +        channel@3 {
> +          reg =3D <3>;
> +          bipolar;
> +          diff-channels =3D <6 7>;
> +        };
> +
> +        channel@4 {
> +          reg =3D <4>;
> +          diff-channels =3D <8 9>;
> +          adi,reference-select =3D "avdd";
> +        };
> +      };
> +    };
> --
> 2.42.0
>
>

