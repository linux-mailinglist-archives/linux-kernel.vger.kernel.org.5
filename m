Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B4D8118C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbjLMQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLMQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:10:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D57691
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:10:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF16BC433C7;
        Wed, 13 Dec 2023 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702483845;
        bh=6Cp4QoPrziOGTCMSk4UORYT4B4hBTsbrJjJUD3vnofQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DaPBC8q9bSXwlg7DJK7lOva3fmQIvfCrRPjT/JKRo+D7GNADZym1lXreSvh0xEGcX
         7qqXo8suAV7zGz1guhGKcOcDk9iA+dlRKVenK89Uq3l2sNHGIrydXH3/HQV2LSkcMJ
         JQEGTYWwY5DupDh9nWxWzVSicVtHkoJ6DyPgstdY9fLz51eLhJLNXkQZA58d+qBbZ+
         OymwzDhn92zRL8rO9cQ+L3/QSaWecCmxRCQlBLM9c5gSAJRQYD5vjTKERx+COT5cd2
         hCTY5Wb+x11tidCp0usO1V9s5usaSagfL8mXKqtnvnDShZvWUBIJBD5Q/UOzMbey05
         JfI5UYYV7UWIQ==
Date:   Wed, 13 Dec 2023 16:10:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20231213-grooving-bulk-58fcfc20be11@spud>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QDYW7xwkRaYUe+Lj"
Content-Disposition: inline
In-Reply-To: <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDYW7xwkRaYUe+Lj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 05:21:19AM -0600, David Lechner wrote:
> This adds a binding specification for the Analog Devices Inc. AD7380
> family of ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
> - Added maxItems to reg property
> - Replaced adi,sdo-mode property with spi-rx-bus-channels
> - Made spi-rx-bus-channels property optional with default value of 1
>     (this made the if: check more complex)
> - Changed example to use gpio for interrupt
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 116 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> new file mode 100644
> index 000000000000..43d58c52f7dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7380.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Simultaneous Sampling Analog to Digital Converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno S=E1 <nuno.sa@analog.com>
> +
> +description: |
> +  * https://www.analog.com/en/products/ad7380.html
> +  * https://www.analog.com/en/products/ad7381.html
> +  * https://www.analog.com/en/products/ad7383.html
> +  * https://www.analog.com/en/products/ad7384.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7380
> +      - adi,ad7381
> +      - adi,ad7383
> +      - adi,ad7384
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 80000000
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +  spi-rx-bus-channels:

This is now being framed as a standard property, so I think it should be
in spi-peripheral-props, no? Granted, you'd need a rather more
generalised explanation of the property in that case.

> +    description:
> +      In 1-wire mode, the SDOA pin acts as the sole data line and the SD=
OB/ALERT
> +      pin acts as the ALERT interrupt signal. In 2-wire mode, data for i=
nput A
> +      is read from SDOA and data for input B is read from SDOB/ALERT (an=
d the
> +      ALERT interrupt signal is not available).
> +    enum: [1, 2]

Jonathan also mentioned specifying that this defaults to 1-wire. I
didn't see a response or that implemented. Did you miss that comment
=66rom him?

Cheers,
Conor.

> +
> +  vcc-supply:
> +    description: A 3V to 3.6V supply that powers the chip.
> +
> +  vlogic-supply:
> +    description:
> +      A 1.65V to 3.6V supply for the logic pins.
> +
> +  refio-supply:
> +    description:
> +      A 2.5V to 3.3V supply for the external reference voltage. When omi=
tted,
> +      the internal 2.5V reference is used.
> +
> +  interrupts:
> +    description:
> +      When the device is using 1-wire mode, this property is used to opt=
ionally
> +      specify the ALERT interrupt.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - vlogic-supply
> +
> +allOf:
> +  - if:
> +      required:
> +        - spi-rx-bus-channels
> +    then:
> +      if:
> +        properties:
> +          spi-rx-bus-channels:
> +            const: 2
> +      then:
> +        properties:
> +          interrupts: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad7380";
> +            reg =3D <0>;
> +
> +            spi-cpol;
> +            spi-cpha;
> +            spi-max-frequency =3D <80000000>;
> +
> +            interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio0>;
> +
> +            vcc-supply =3D <&supply_3_3V>;
> +            vlogic-supply =3D <&supply_3_3V>;
> +            refio-supply =3D <&supply_2_5V>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe1f6f97f96a..e2a998be5879 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -430,6 +430,15 @@ W:	http://wiki.analog.com/AD7142
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/misc/ad714x.c
> =20
> +AD738X ADC DRIVER (AD7380/1/2/4)
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Nuno S=E1 <nuno.sa@analog.com>
> +R:	David Lechner <dlechner@baylibre.com>
> +S:	Supported
> +W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-ad=
c/ad738x
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +
>  AD7877 TOUCHSCREEN DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>=20
> --=20
> 2.34.1
>=20

--QDYW7xwkRaYUe+Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnXgAAKCRB4tDGHoIJi
0olQAQD0uGzuJAnzrkjyNQSFOQ2fC9H/eELRnpvt8Qn7xokQfAEAtm9kgIN7xibR
NYDDxEwEe+7NATpX/ImfrcOZYOoIIQw=
=xfs8
-----END PGP SIGNATURE-----

--QDYW7xwkRaYUe+Lj--
