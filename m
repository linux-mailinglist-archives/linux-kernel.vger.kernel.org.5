Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0717CE189
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjJRPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjJRPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:37:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423511D;
        Wed, 18 Oct 2023 08:37:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E11C433C8;
        Wed, 18 Oct 2023 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697643459;
        bh=KuvGZME4C2exlYdvjeO0ta7U9dgF8t2M9SMRbaom3jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nt6i5XYrXUinUiWPTgJLAPojMaalJL6Om+IOp19+CXtjh/vouX7US47u+OtKyzrdV
         iWPydwvm82WjSXn16Mmu/7s+kZmkoy/RWNYnLZd21hLR4rxk+tqRMlfujQojMTz9Lw
         XjbhkWtQvUHldkdcJuVqmuisbVq2jMpS4HRnVxbHJyvbuVRR/kQ2WmkAl0Kc6sDh5m
         iZnANV6bpB78O/ksTUJG8L/SBkhOiLi8Qmy75V7ggZ9vIQuxUNF5hPtgssn7i/P097
         48NC/NXanHlMnNCgSNqMnJKtMNbecrKf8fDwIn5gveCmDlPVpdcfHK8gyILGzxhLjR
         Wd3xEHr5RQWxA==
Date:   Wed, 18 Oct 2023 16:37:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231018-basket-pelt-1cac6a6926d0@spud>
References: <20231014211254.16719-1-fr0st61te@gmail.com>
 <20231014211254.16719-2-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57kmueR2dZ6U4lAk"
Content-Disposition: inline
In-Reply-To: <20231014211254.16719-2-fr0st61te@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--57kmueR2dZ6U4lAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 12:12:53AM +0300, Ivan Mikhaylov wrote:
> The hardware binding for i2c current monitoring device with overcurrent
> control.
>=20
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>

It looks as if the comments on the property names & the conditionals
=66rom previous versions have been resolved.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34=
408.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yam=
l b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> new file mode 100644
> index 000000000000..4cba856e8d47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX34408/MAX34409 current monitors with overcurrent control
> +
> +maintainers:
> +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> +
> +description: |
> +  The MAX34408/MAX34409 are two- and four-channel current monitors that =
are
> +  configured and monitored with a standard I2C/SMBus serial interface. E=
ach
> +  unidirectional current sensor offers precision high-side operation wit=
h a
> +  low full-scale sense voltage. The devices automatically sequence throu=
gh
> +  two or four channels and collect the current-sense samples and average=
 them
> +  to reduce the effect of impulse noise. The raw ADC samples are compare=
d to
> +  user-programmable digital thresholds to indicate overcurrent condition=
s.
> +  Overcurrent conditions trigger a hardware output to provide an immedia=
te
> +  indication to shut down any necessary external circuitry.
> +
> +  Specifications about the devices can be found at:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/MA=
X34408-MAX34409.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max34408
> +      - maxim,max34409
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description:
> +      Shutdown Output. Open-drain output. This output transitions to hig=
h impedance
> +      when any of the digital comparator thresholds are exceeded as long=
 as the ENA
> +      pin is high.
> +    maxItems: 1
> +
> +  powerdown-status-gpios:
> +    description:
> +      SHTDN Enable Input. CMOS digital input. Connect to GND to clear th=
e latch and
> +      unconditionally deassert (force low) the SHTDN output and reset th=
e shutdown
> +      delay. Connect to VDD to enable normal latch operation of the SHTD=
N output.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    $ref: adc.yaml
> +    type: object
> +    description:
> +      Represents the internal channels of the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          - minimum: 0
> +            maximum: 3
> +
> +      maxim,rsense-val-micro-ohms:
> +        description:
> +          Adjust the Rsense value to monitor higher or lower current lev=
els for
> +          input.
> +        enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 50000=
0]
> +        default: 1000
> +
> +    required:
> +      - reg
> +      - maxim,rsense-val-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: maxim,max34408
> +    then:
> +      patternProperties:
> +        "^channel@[2-3]$": false
> +        "^channel@[0-1]$":
> +          properties:
> +            reg:
> +              maximum: 1
> +    else:
> +      patternProperties:
> +        "^channel@[0-3]$":
> +          properties:
> +            reg:
> +              maximum: 3
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1e {
> +              compatible =3D "maxim,max34409";
> +              reg =3D <0x1e>;
> +              powerdown-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> +              powerdown-status-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;
> +
> +              channel@0 {
> +                  reg =3D <0x0>;
> +                  maxim,rsense-val-micro-ohms =3D <5000>;
> +              };
> +
> +              channel@1 {
> +                  reg =3D <0x1>;
> +                  maxim,rsense-val-micro-ohms =3D <10000>;
> +             };
> +        };
> +    };
> --=20
> 2.42.0
>=20

--57kmueR2dZ6U4lAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/7vwAKCRB4tDGHoIJi
0neKAQCD6rOZgvbznHoFC94D8o8wiVrPS2ip26fyAhsxPGqPSwD/UAKGAMvo7/5v
EL7arWOGdOEASMpLOrmoh1frIZ8EzQU=
=+50V
-----END PGP SIGNATURE-----

--57kmueR2dZ6U4lAk--
