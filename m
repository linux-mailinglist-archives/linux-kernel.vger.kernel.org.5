Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51A7BE84A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbjJIRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377385AbjJIRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:35:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806E94;
        Mon,  9 Oct 2023 10:35:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1366C433C8;
        Mon,  9 Oct 2023 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872906;
        bh=1ZYVBGazHy2d4Xk2g9EBASgik4ghV3l90e5mT3K1Ytc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDr93PRPR2Q/aDAn5KZ/clRWHgfjNEsU4Sm9fe6ojAyybNu2a+vz/JFOL2gBgyem0
         AviVkEuKu9pfF2QwsiUVUQjWBbosIgwB8QehsabJ0WrNFrsQmHkomYR5wfARuJcWvV
         9lYEMe6yh0eq4kI766BIsvtm7SP1Bd8TtBNfTSXzJQx1+l+DcG7YwYGJHpHiXyhFF1
         C40bo6oAG24vz3K9ABTdBjX5SH2NEz18pOdnrViwbuNXJk/7KASVBejSR5KhC3Kqn3
         pTLkC/ruDcqrsZsVHZxUdLgzYgxlV4xDE8oECUV5qfVWyx2FFXYmjXBPTnw0N2Tuvm
         2ZY/ZXS2vVDiw==
Date:   Mon, 9 Oct 2023 18:35:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: ltc2991: add bindings
Message-ID: <20231009-maimed-reenact-05c6e3b36ca9@spud>
References: <20231003080059.8041-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sb32d3m8HlxF4rSL"
Content-Disposition: inline
In-Reply-To: <20231003080059.8041-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sb32d3m8HlxF4rSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 11:00:39AM +0300, Antoniu Miclaus wrote:
> Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
> monitor.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - expand description for differential channels and temperature channels =
by
>    mentioning the pin configuration that is set via these properties.
>  - add `additionalProperties: false` for the channel properties
>  - make `reg` required for channel properties
>  - make `adi,temperature-enable` and `shunt-resistor-micro-ohms` mutually
>    exclusive following the approach suggested in review.

Thanks for the updates.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>  .../bindings/hwmon/adi,ltc2991.yaml           | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/D=
ocumentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> new file mode 100644
> index 000000000000..011e5b65c79c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2991 Octal I2C Voltage, Current and Temperature=
 Monitor
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The LTC2991 is used to monitor system temperatures, voltages and curre=
nts.
> +  Through the I2C serial interface, the eight monitors can individually =
measure
> +  supply voltages and can be paired for differential measurements of cur=
rent
> +  sense resistors or temperature sensing transistors.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ltc2991.html
> +
> +properties:
> +  compatible:
> +    const: adi,ltc2991
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
> +  vcc-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    description:
> +      Represents the differential/temperature channels.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. LTC2991 can monitor 4 currents/temperature=
s.
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          The value of curent sense resistor in micro ohms. Pin configur=
ation is
> +          set for differential input pair.
> +
> +      adi,temperature-enable:
> +        description:
> +          Enables temperature readings. Pin configuration is set for rem=
ote
> +          diode temperature measurement.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    allOf:
> +      - if:
> +          required:
> +            - shunt-resistor-micro-ohms
> +        then:
> +          properties:
> +            adi,temperature-enable: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        hwmon@48 {
> +            compatible =3D "adi,ltc2991";
> +            reg =3D <0x48>;
> +            vcc-supply =3D <&vcc>;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        hwmon@48 {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            compatible =3D "adi,ltc2991";
> +            reg =3D <0x48>;
> +            vcc-supply =3D <&vcc>;
> +
> +            channel@0 {
> +                    reg =3D <0x0>;
> +                    shunt-resistor-micro-ohms =3D <100000>;
> +            };
> +
> +            channel@1 {
> +                    reg =3D <0x1>;
> +                    shunt-resistor-micro-ohms =3D <100000>;
> +            };
> +
> +            channel@2 {
> +                    reg =3D <0x2>;
> +                    adi,temperature-enable;
> +            };
> +
> +            channel@3 {
> +                    reg =3D <0x3>;
> +                    adi,temperature-enable;
> +            };
> +        };
> +    };
> +...
> --=20
> 2.42.0
>=20

--Sb32d3m8HlxF4rSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQ5xQAKCRB4tDGHoIJi
0g+SAP48zfjGLubhF083okMidLJzwi9GXWmdPgm2K/XEx2vJ4wEA0rwolj+tSDO4
X8BeLlW4PVLEukU92W77hIo/kNPSAw0=
=ymEK
-----END PGP SIGNATURE-----

--Sb32d3m8HlxF4rSL--
