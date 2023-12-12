Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95180EFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376487AbjLLPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376469AbjLLPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:10:03 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE0E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:10:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so87060001fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702393806; x=1702998606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgb02zIfWO9XtSI9qBoLEAqXEVat4zbB8qv+HQtNLV8=;
        b=LHHGslb9jPETtJXQjN4Vk2QASbgCA6FkG3oCg1n9IS1L10xamOppZWjcS9nROeYuQK
         /q0w3D7SmGzlXRS5oT1MmC7KoFhYYoMkg5ytqDGyoqMqWm+3y2KxEWuQEuaNR/kpcBV0
         RiWB3f6zW3EGg6KafI44c990/ZuZ0hEaMvCOXByoy9BXGfbKr1pD3AEjuQ+lsNjep5JI
         RK9RGlOPmFLHyLkmjgx1ApoEpJhnKRGpxmqKcp3cFgTHYrvfKxlYYQDYG3t4w/O/0NEB
         ZqK/n6FLnDNgHiLWKPo8rImb/0Y9EGyxAZoN7WHh9wBuIuYvrlhOuAa4WI8y05fWhVvT
         2nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393806; x=1702998606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgb02zIfWO9XtSI9qBoLEAqXEVat4zbB8qv+HQtNLV8=;
        b=FiJVrZjR1kqsRi9uDUYaIfpbqEHfzSiHGXDnUcEYBXL2YlwswWUqgV9cepqLYsEkzC
         bnxbaC1XIrCpRyEKiCj+JPCi2SO6QO33u68nXmkQ66E9nWyXXTyiKIkTUntrlIHZ+ZvN
         quxw3qy02G9TXcaEiuB1hoeiV8wWkyEpU9rP7V88z9rZbqOtVo7/paX0oP/3mEuyHZX/
         xcphTTh27CdFcLqEIiT78KGff8zepsdrQ0wzfoKXO+1kjjxiWZzs9iXKRGdUgmm2MI23
         I9aMLuLucEetalz7PAute4KLOurtKRNiQzpnQNVXQYIBPuYYcmovD9LM2buFUtoc5A2h
         gq4A==
X-Gm-Message-State: AOJu0YwdWzWJGSdGtfPh2umzFnVPkD29QKCkPnHV9IwtEsAa2PFOMe4R
        YfRHmAfDwsq4+Ukv2yCfUle28cOflBiJLtUntZ8oDQ==
X-Google-Smtp-Source: AGHT+IEnmlxt1GZYnvsKLadBA5gaJL+Mw8J602tleM6Cq/s5xYNH1uxRqd0ikhqf6EblAuUXcVfJtJqyQ/mZTWNqVIM=
X-Received: by 2002:a2e:9f08:0:b0:2c9:f1a2:c396 with SMTP id
 u8-20020a2e9f08000000b002c9f1a2c396mr2674735ljk.101.1702393805929; Tue, 12
 Dec 2023 07:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
In-Reply-To: <20231212104451.22522-1-mitrutzceclan@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Tue, 12 Dec 2023 16:09:55 +0100
Message-ID: <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:45=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmai=
l.com> wrote:
>
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel application=
s
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.

As stated in [1], we should try to make complete bindings. I think
more could be done here to make this more complete. Most notably, the
gpio-controller binding is missing. Also maybe something is needed to
describe how the SYNC/ERROR pin is wired up since it can be an input
or an output with different functions?

[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-bin=
dings.html

>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> V7->V8
>  - include missing fix from V6

Including the cumulative changelog for all revisions would be helpful
to reviewers who haven't been following closely.

>
>  .../bindings/iio/adc/adi,ad7173.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> new file mode 100644
> index 000000000000..25a5404ee353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -0,0 +1,170 @@
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

Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
pin. Although I could see how RDY could be considered part of the SPI
bus. In any case, a description explaining what the interrupt is would
be useful.

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
> +  refin-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.
> +
> +  refin2-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.
> +
> +  avdd-supply:
> +    description: avdd supply, can be used as reference for conversion.

What about other supplies? AVDD1, AVDD2, IOVDD.


> +
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

Do we need to add overrides to limit the maximums for each compatible strin=
g?

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
> +        enum:
> +          - refin
> +          - refin2
> +          - refout-avss
> +          - avdd
> +        default: refout-avss

Missing string type?

> +
> +    required:
> +      - reg
> +      - diff-channels

Individual analog inputs can be used as single-ended or in pairs as
differential, right? If so, diff-channels should not be required to
allow for single-ended use.

And we would need to add something like a single-ended-channel
property to adc.yaml to allow mapping analog input pins to channels
similar to how diff-channels works, I think (I don't see anything like
that there already)?

So maybe something like:

oneOf:
  - required:
      single-ended-channel
  - required:
      diff-channels

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
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
