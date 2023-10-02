Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD967B53A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjJBNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbjJBNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32199;
        Mon,  2 Oct 2023 06:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0088AC433C8;
        Mon,  2 Oct 2023 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696251642;
        bh=HeArIM02Qnv4lwvTAbzTJtNzOGPD/ms1sGZR8dVdPZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un6g0REdKqioq485uu78vWvDhqMLUyvRMuQyUp/Zcxw44DYckmgzNIhvn1qXxtRew
         olsuG2AXkzRftazezlM7rYsZ51CYuWpPkZOhIADL72qkiPNPNESHCjCQZ4Q8PhwRBf
         oEyTb7ufy3Yf4vpTkQ6slSLznxiVpyXoVz9NkxoRqhqM8Rzv3H77CZCNzzzwFO62Vb
         3y3vK15aiP9AdkD0j1i5vXUgtMQ2wqXkxCyiCNSOiKhVZooeQiHbpPFq48Zugs37bH
         61uIWW/HWNCfTHydeSRaa2+6HeGOD2fI+vJrKRhbtXsXom2elWVQouy4mG1QES/iS3
         FZxC7Ilj75UaQ==
Date:   Mon, 2 Oct 2023 14:00:37 +0100
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
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
Message-ID: <20231002-babbling-justice-73d3601a71aa@spud>
References: <20231002101835.39624-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qGEe174rhPUIzeC"
Content-Disposition: inline
In-Reply-To: <20231002101835.39624-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4qGEe174rhPUIzeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Oct 02, 2023 at 01:18:14PM +0300, Antoniu Miclaus wrote:
> Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
> monitor.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - make compatible const type
>  - remove `|` where not necessary
>  - switch to micro-ohms for the shunt resistor property
>  - add vendor prefix for temperature-enable

Thanks for the updates...

>  .../bindings/hwmon/adi,ltc2991.yaml           | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/D=
ocumentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> new file mode 100644
> index 000000000000..3811ea07a04f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> @@ -0,0 +1,114 @@
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
> +          The value of curent sense resistor in miliohms. Enables differ=
ential
> +          input pair.
> +
> +      adi,temperature-enable:
> +        description:
> +          Enables temperature readings for a input pair.
> +        type: boolean

=2E..but I did not see an answer to my question on v1:
	TBH, this seems like it is used just to control software behaviour.
	Why would you want to actually disable this in DT?
In other words, is there something in that hardware that precludes
measuring temperature for channels that do not contain this property?

Thanks,
Conor.

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
> +                    temperature-enable;
> +            };
> +
> +            channel@3 {
> +                    reg =3D <0x3>;
> +                    temperature-enable;
> +            };
> +        };
> +    };
> +...
> --=20
> 2.42.0
>=20

--4qGEe174rhPUIzeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRq+9QAKCRB4tDGHoIJi
0ueTAQDx05+Ro78ZLvC9iBZWPPBFodIfIuTafvjJsOC7s0x3+gEA7X0AM0o7Hrjo
L0CXzkMCQDQOz309zfkOE0uTkrcVIwc=
=EQhT
-----END PGP SIGNATURE-----

--4qGEe174rhPUIzeC--
