Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF97A9E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjIUUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjIUUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549204691;
        Thu, 21 Sep 2023 10:22:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E57C197C4;
        Thu, 21 Sep 2023 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287217;
        bh=3tcJf+vo1lDEFwmLnpNMKtQhqnHVgNZwgjlJAK1przM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1h7QhGsb9DonuypEmBlwXwF+EvayA+OS4NyPwNnd7nQqdplyHkHkra1JyPgvEHW3
         YCRSWFhes//Be1zFN2FwO41IjRufTk/U8FaexIThieQIL/2w4Kt4EbJT6mP+B5Ucgt
         rYwmMguh0uXYuDK+y90Ao6taseaS2WcFIGi8KuI6QM1GSZRnXz8L/hYxIQNIB9PBE2
         k1wXfu1XGiiYy8q99ZKcwfZOzSJQZnGu877VZI0uIPwZ7sc649U6Ur760cWn6SCE9Q
         N4ew+jUSRB0e6O/11Bj8LvfeG6bFA18hruOP7gKiW9SGBvVggJIN/Vc/Q2BoJG6692
         ArCzwQqJVO1Rw==
Date:   Thu, 21 Sep 2023 10:06:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: resolver: add devicetree bindings
 for ad2s1210
Message-ID: <20230921-b304d3fd05b37a8588e101a2@fedora>
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-2-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owrJu3nfxN2zBqaa"
Content-Disposition: inline
In-Reply-To: <20230920170253.203395-2-dlechner@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owrJu3nfxN2zBqaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Sep 20, 2023 at 12:02:50PM -0500, David Lechner wrote:
> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
>=20
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Missing a From: or co-developed-by?

> ---
>  .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad=
2s1210.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.=
yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> new file mode 100644
> index 000000000000..cf6838710e52
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

Why's this a chap from analog, rather than the authors?

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
> +  Note on SPI connections: The CS line on the AD2S1210 should hard-wired=
 to
> +  logic low and the WR/FSYNC line on the AD2S1210 should be connected to=
 the
> +  SPI CSn output of the SPI controller.
> +
> +  Datasheet:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
2s1210.pdf
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
> +      GPIO connected to the /RESET pin. As the line needs to be low for =
the
> +      reset to be active, it should be configured as GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  sample-gpios:
> +    description: |

What do you need the pipe for here? Don't see some formatting requiring
preservation. Ditto below.

> +      GPIO connected to the /SAMPLE pin. As the line needs to be low to =
trigger
> +      a sample, it should be configured as GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  mode-gpios:
> +    description: |
> +      GPIO lines connected to the A0 and A1 pins. These pins select the =
data
> +      transfer mode.
> +    minItems: 2
> +    maxItems: 2
> +
> +  resolution-gpios:
> +    description: |
> +      GPIO lines connected to the RES0 and RES1 pins. These pins select =
the
> +      resolution of the digital output. If omitted, it is assumed that t=
he
> +      RES0 and RES1 pins are hard-wired to match the assigned-resolution=
-bits
> +      property.
> +    minItems: 2
> +    maxItems: 2
> +
> +  fault-gpios:
> +    description: |
> +      GPIO lines connected to the LOT and DOS pins. These pins combined =
indicate
> +      the type of fault present, if any. As these pins a pulled low to i=
ndicate
> +      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,fixed-mode:
> +    description: |
> +      This is used to indicate the selected mode if A0 and A1 are hard-w=
ired
> +      instead of connected to GPIOS (i.e. mode-gpios is omitted).
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["config", "velocity", "position"]

The bot is complaining about these "s not being needed.

> +
> +  assigned-resolution-bits:

I figure the lack of a vendor prefix here is "inspired" by the same
property for stm32?

Cheers,
Conor.

> +    description: |
> +      Resolution of the digital output required by the application. This
> +      determines the precision of the angle and/or the maximum speed tha=
t can
> +      be measured. If resolution-gpios is omitted, it is assumed that RE=
S0 and
> +      RES1 are hard-wired to match this value.
> +    enum: [10, 12, 14, 16]
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
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        resolver@0 {
> +            compatible =3D "adi,ad2s1210";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <20000000>;
> +            spi-cpha;
> +            clocks =3D <&ext_osc>;
> +            sample-gpios =3D <&gpio0 90 GPIO_ACTIVE_LOW>;
> +            mode-gpios =3D <&gpio0 86 0>, <&gpio0 87 0>;
> +            resolution-gpios =3D <&gpio0 88 0>, <&gpio0 89 0>;
> +            assigned-resolution-bits =3D <16>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--owrJu3nfxN2zBqaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwHpwAKCRB4tDGHoIJi
0v70AP4zQgNZ3lhzq1mZCa5+hgoIiGQ+hdOzpkcM2jR3Z3nQGQD8CT9tbJPTw5AJ
Wqrs2GhAyKCnRwkokriHEaHCPtVUeAE=
=T7Wa
-----END PGP SIGNATURE-----

--owrJu3nfxN2zBqaa--
