Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47E7B3FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjI3JhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjI3JhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:37:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC01113;
        Sat, 30 Sep 2023 02:37:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA46C433C7;
        Sat, 30 Sep 2023 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696066634;
        bh=rMgXv2Vv3/9BKtG3DmJ+10rtoeky76HNbtM+rTF2Z/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twVrfwGZpZk3CM7LqwVSVbQAPX9v01GBcCpodDEziI0b5RbnUZMFtTw3jwCApEMT6
         OSMPrsOx9SBJXKBYvOAZsRe9CPtBv9A8XnglmkgRqnj30rMDWvelWOYiaKaTlRfWoN
         wGp2CuolBVqnReJ7NR5A0N/YM830shoTS/flknbAYE/g+M5aj0iWBosywARuiEbGiv
         FiyB+rRye7NjVXvlbNqOelJmiasV3sOedXvMkqmrfxRTtj2bO7/YwOFGNyEiPHuQ+S
         rWnbx0xs1o3eSGohl6kM5A3Oc4unUh9z9m4ZUI1WjWbQ9wX5aLJf7HQDETyjFhygu0
         Tok+FNAntkVEg==
Date:   Sat, 30 Sep 2023 10:37:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20230930-lusty-antihero-f381434ab682@spud>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
 <20230929200844.23316-2-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i1g3ldoWAaPljqK2"
Content-Disposition: inline
In-Reply-To: <20230929200844.23316-2-fr0st61te@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i1g3ldoWAaPljqK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Sep 29, 2023 at 11:08:43PM +0300, Ivan Mikhaylov wrote:
> The hardware binding for i2c current monitoring device with overcurrent
> control.
>=20
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34=
408.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yam=
l b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> new file mode 100644
> index 000000000000..cdf89fa4c80e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Two- and four-channel current monitors with overcurrent control
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
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  maxim,input1-rsense-val-micro-ohms:
> +    description:
> +      Adjust the Rsense value to monitor higher or lower current levels =
for
> +      input 1.
> +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +    default: 1000
> +
> +  maxim,input2-rsense-val-micro-ohms:
> +    description:
> +      Adjust the Rsense value to monitor higher or lower current levels =
for
> +      input 2.
> +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +    default: 1000
> +
> +  maxim,input3-rsense-val-micro-ohms:
> +    description:
> +      Adjust the Rsense value to monitor higher or lower current levels =
for
> +      input 3.
> +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +    default: 1000
> +
> +  maxim,input4-rsense-val-micro-ohms:
> +    description:
> +      Adjust the Rsense value to monitor higher or lower current levels =
for
> +      input 4.
> +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +    default: 1000

Having 4 almost identical properties makes it seem like this should have
some channel nodes, each containing an rsense-micro-ohms type property.

> +
> +  maxim,shtdn:
> +    description:
> +      Shutdown Output. Open-drain output. This output transitions to hig=
h impedance
> +      when any of the digital comparator thresholds are exceeded as long=
 as the ENA
> +      pin is high.
> +    type: boolean

I don't understand what this property is used for. The description here,
and below for "ena", read like they are the descriptions in the
datasheet for the pin, rather than how to use the property.

The drivers don't appear to contain users either - what is the point of
these properties?

> +
> +  maxim,ena:
> +    description:
> +      SHTDN Enable Input. CMOS digital input. Connect to GND to clear th=
e latch and
> +      unconditionally deassert (force low) the SHTDN output and reset th=
e shutdown
> +      delay. Connect to VDD to enable normal latch operation of the SHTD=
N output.
> +    type: boolean
> +
> +  supply-vdd: true

As pointed out by the bot, this is not correct. You need to use a
-supply affix, not a supply-prefix.

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1e {
> +              compatible =3D "maxim,max34409";
> +              reg =3D <0x1e>;
> +              maxim,input1-rsense-val-micro-ohms =3D <5000>;
> +              maxim,input2-rsense-val-micro-ohms =3D <10000>;
> +        };
> +    };
> --=20
> 2.42.0
>

--i1g3ldoWAaPljqK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRfsRQAKCRB4tDGHoIJi
0oeAAQDQttcTT6GshSw1wrxl9oLiBVnxhULkmPTWb8kZwpfvNAD/RmjnCRGHPpep
VGRT7//tCpquneArjV/Q94S2/RQ8RA0=
=EWZj
-----END PGP SIGNATURE-----

--i1g3ldoWAaPljqK2--
