Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2777EE69F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjKPSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKPSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17A192
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:21:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B91C433C8;
        Thu, 16 Nov 2023 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700158897;
        bh=afcjSCTVmlV4p68dsI5fTXVa0bQhtpJng5oNuW2v4Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vhf0ra+0c6tEw4RTVE8zXQFo821hMFV3IIi4ZHo4MACQm6Xg84Nesnspov8/oyY20
         0nwWzipJ13BeDXrXcYEO/BIay6078ghGLkWB32pzXiKLr+g9/+ovKAUBqZHjOvuQN2
         fdNdQQTjV7mKZLCHFnyGLW2z+TqGMiitKy5ABkyFfRQG0O2z4E19Mm4u1IuSk6r3/f
         ffjuJG3uAtHVGH5Z5Luc9JV1IPKZCImNnCKPdaKRs6ruPB7AzJEuNBZ5p+thd4njqP
         y3s+JAcjB30SNTSxu/bAHyqMe3i78zsRYYFIm/jEMxLbrR/0Hg2s4Y5V6Jg777aFAY
         sO8sPfvN4vspw==
Date:   Thu, 16 Nov 2023 18:21:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <20231116-channel-variety-cc7c262924ad@squawk>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
 <20231115134453.6656-2-marius.cristea@microchip.com>
 <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CqQpzGUiaD3Sqhz2"
Content-Disposition: inline
In-Reply-To: <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CqQpzGUiaD3Sqhz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 04:01:43PM +0100, Krzysztof Kozlowski wrote:
> On 15/11/2023 14:44, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> >=20
> > This is the device tree schema for iio driver for
> > Microchip PAC193X series of Power Monitors with Accumulator.
> >=20
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---
> >  .../bindings/iio/adc/microchip,pac1934.yaml   | 137 ++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip=
,pac1934.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac193=
4.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > new file mode 100644
> > index 000000000000..2609cb19c377
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip PAC1934 Power Monitors with Accumulator
> > +
> > +maintainers:
> > +  - Marius Cristea <marius.cristea@microchip.com>
> > +
> > +description: |
> > +  This device is part of the Microchip family of Power Monitors with A=
ccumulator.
> > +  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found=
 here:
> > +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,pac1931
> > +      - microchip,pac1932
> > +      - microchip,pac1933
> > +      - microchip,pac1934
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  microchip,slow-io:
> > +    type: boolean
> > +    description: |
> > +      A GPIO used to trigger a change is sampling rate (lowering the c=
hip power consumption).
>=20
> Use Linux coding style wrapping (as described in Linux Coding style). I
> am not going to tell you numbers because I want you to read the document
> first.
>=20
> This is boolean, not GPIO. I don't understand. "A GPIO", so any GPIO or
> some specific? How is this property related to GPIO?
>=20
>=20
> > +      If configured in SLOW mode, if this pin is forced high, sampling=
 rate is forced to eight
>=20
> This pin? This is boolean, not a GPIO. GPIOs are phandles.

I said it on the previous version, but this really seems like it should
be something like "slow-io-gpios". I know Jonathan expressed some
concerns about having to deal with it on the operating system side (as
the pin is either an input & used for this slow-io control, or an output
and used as an interrupt) but that is, in my opinion, a problem for the
operating system & the binding should describe how the hardware works,
even if that is not convenient. With this sort of property, a GPIO hog
would be required to be set up (and the driver for that gpio controller
bound etc before the pac driver loads) for correction functionality if
this property was in the non-default state.

> > +      samples/second. When it is forced low, the sampling rate is 1024=
 samples/second unless
> > +      a different sample rate has been programmed.
> > +
> > +patternProperties:
> > +  "^channel@[1-4]+$":
> > +    type: object
> > +    $ref: adc.yaml
> > +    description: Represents the external channels which are connected =
to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        items:
> > +          minimum: 1
> > +          maximum: 4
> > +
> > +      shunt-resistor-micro-ohms:
> > +        description: |
> > +          Value in micro Ohms of the shunt resistor connected between
> > +          the SENSE+ and SENSE- inputs, across which the current is me=
asured. Value
> > +          is needed to compute the scaling of the measured current.
> > +
> > +    required:
> > +      - reg
> > +      - shunt-resistor-micro-ohms
> > +
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: interrupts
>=20
>=20
> I don't understand what do you want to say here. I am also 100% sure you
> did not test it on a real case (maybe example passes but nothing more).

As far as I understand, the same pin on the device is used for both an
output or an input depending on the configuration. As an input, it is
the "slow-io" control, and as an output it is an interrupt.
I think Marius is trying to convey that either this pin can be in
exclusively one state or another.

_However_ I am not sure that that is really the right thing to do - they
might well be mutually exclusive modes, but I think the decision can be
made at runtime, rather than at devicetree creation time. Say for
example the GPIO controller this is connected to is capable of acting as
an interrupt controller. Unless I am misunderstanding the runtime
configurability of this hardware, I think it is possible to actually
provide a "slow-io-gpios" and an interrupt property & let the operating
system decide at runtime which mode it wants to work in.

I'm off travelling at the moment Marius, but I should be back in work on
Monday if you want to have a chat about it & explain a bit more to me?

Cheers,
Conor.

>=20
> > +    then:
> > +      properties:
> > +        microchip,slow-io: false
> > +    else:
> > +      if:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: microchip,slow-io
> > +      then:
> > +        properties:
> > +          interrupts: false
>=20
> Best regards,
> Krzysztof
>=20

--CqQpzGUiaD3Sqhz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZdqwAKCRB4tDGHoIJi
0ujbAQCjXBBuVPgyP4WT9ADe31P1IzbnBiEVymzdiv9hZVxnRAD/d9hSmWkAXypj
w1fZogUDEFwlkt04d1QG4OsATZhxNQ8=
=3oED
-----END PGP SIGNATURE-----

--CqQpzGUiaD3Sqhz2--
