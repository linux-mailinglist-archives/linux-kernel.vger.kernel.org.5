Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72497D8674
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjJZQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5A1A6;
        Thu, 26 Oct 2023 09:08:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6900C433C7;
        Thu, 26 Oct 2023 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698336491;
        bh=WFxJq0/989teIWW06N+2g4pyBHa4H3eufPVUdxZPeYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADe+Z3lMEHuDh0qqqAVl77fLn6VPJYM1TQjiDbmugE9JXn1ZNrTTLAzpd+jwgsw6t
         VjnTUmu0zsKv3Dz62Ko5AL3P8PDQ9HNBA/Q9dWtZq5dqjYcd+LIeFnC5kCjiK3Avly
         JZ84ad8+qqjrZwMDUR713ka8roxIz/X86QZvp2oX8rv4uR9hF0k/3pcVTdKTNZid/i
         gPvlxVKShWCpx6DRniFMs55ekXzS0VBw2L5vOFXYSZufV1mJaIkHmcVvxTFUfp+aQ6
         9Wa6Olw3kRNIfOq10k3PLxwXjcD+Uu/YgP64IePiEPNi/XRh4UeK8JpqWDYUxZBL/W
         ZzsK6Ctp+gIdw==
Date:   Thu, 26 Oct 2023 17:08:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marius.Cristea@microchip.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, linux-kernel@vger.kernel.org, jic23@kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20231026-perkiness-financial-55313e297230@spud>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
 <20231025134404.131485-2-marius.cristea@microchip.com>
 <20231025-cheddar-tucking-b2ea777ed4f9@spud>
 <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6/TCsU+pwTa96crd"
Content-Disposition: inline
In-Reply-To: <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6/TCsU+pwTa96crd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 03:23:46PM +0000, Marius.Cristea@microchip.com wrot=
e:
> Hi Conor,
>=20
> On Wed, 2023-10-25 at 16:08 +0100, Conor Dooley wrote:
> > Hey Marius,
> >=20
> > On Wed, Oct 25, 2023 at 04:44:03PM +0300,
> > marius.cristea@microchip.com=A0wrote:
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > This is the device tree schema for iio driver for
> > > Microchip PAC193X series of Power Monitors with Accumulator.
> > >=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---
> > > =A0.../bindings/iio/adc/microchip,pac1934.yaml=A0=A0 | 146
> > > ++++++++++++++++++
> > > =A01 file changed, 146 insertions(+)
> > > =A0create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > new file mode 100644
> > > index 000000000000..837053ed8a71
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > @@ -0,0 +1,146 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Microchip PAC1934 Power Monitors with Accumulator
> > > +
> > > +maintainers:
> > > +=A0 - Marius Cristea <marius.cristea@microchip.com>
> > > +
> > > +description: |
> > > +=A0 Bindings for the Microchip family of Power Monitors with
> > > Accumulator.
> > > +=A0 The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be
> > > found here:
> > > +=A0=A0=A0
> > > https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produc=
tDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> > > +
> > > +properties:
> > > +=A0 compatible:
> > > +=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0 - microchip,pac1931
> > > +=A0=A0=A0=A0=A0 - microchip,pac1932
> > > +=A0=A0=A0=A0=A0 - microchip,pac1933
> > > +=A0=A0=A0=A0=A0 - microchip,pac1934
> > > +
> > > +=A0 reg:
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 "#address-cells":
> > > +=A0=A0=A0 const: 1
> > > +
> > > +=A0 "#size-cells":
> > > +=A0=A0=A0 const: 0
> > > +
> > > +=A0 interrupts:
> > > +=A0=A0=A0 description: IRQ line of the ADC
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 drive-open-drain:
> > > +=A0=A0=A0 description: The IRQ signal is configured as open-drain.
> > > +=A0=A0=A0 type: boolean
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 microchip,slow-io:
> > > +=A0=A0=A0 type: boolean
> > > +=A0=A0=A0 description: |
> > > +=A0=A0=A0=A0=A0 A GPIO used to trigger a change is sampling rate (lo=
wering
> > > the chip power consumption).
> > > +=A0=A0=A0=A0=A0 In default mode, if this pin is forced high, samplin=
g rate
> > > is forced to eight
> > > +=A0=A0=A0=A0=A0 samples/second. When it is forced low, the sampling =
rate is
> > > 1024 samples/second unless
> > > +=A0=A0=A0=A0=A0 a different sample rate has been programmed.
> >=20
> > This description doesn't really make sense to me - if a GPIO is used
> > to
> > drive the pin low or high, why do we need a property? A DT property
> > implies that this is a static configuration depending on the board,
> > but
> > reading the description this seems to be something that can be
> > toggled
> > at runtime.
> > I do note though, that this GPIO is not documented in the binding, so
> > I
> > suppose what really needs to happen here is document the gpio so that
> > the driver can determine at runtime what state this pin is in?
> >=20
> > Also, you say "In default mode", but don't mention what the non-
> > default
> > mode is. What happens in the other mode?

> This is a "double function" pin. On the PAC193x there is the SLOW/ALERT
> pin. At runtime this pin could be configured as an input to the PAC and
> the functionality will be "SLOW" that means if it is forced high, the
> PAC will work in low power mode by changing the sample rate to 8 SPS.
> If it's forced low the PAC will work at it's full sample rate.

Since this is a runtime thing, it doesn't make sense to have a property
that is set at dts creation time that decides what mode the pin is in.

> "SLOW" is the default function of the pin but it may be programmed to
> function as ALERT pin (Open Collector when functioning as ALERT,
> requires pull-up resistor to VDD I/O). This time the pin will be set as
> output from PAC (ALERT functionality) to trigger an interrupt to the
> system (this is covered by the interrupts and drive-open-drain).

Hmm, at the risk of getting out of my depth with what the GPIO subsystem
is capable of doing, I would expect to see something like

sampling-rate-gpios:
  description:
    <what you have above>
  maxItems: 1

Which would allow the driver to either drive this pin via the gpio
subsystem, or to use the interrupt property to use it as an interrupt
instead.

Perhaps Jonathan etc knows better for these sort of dual mode pins.

> The system could work fine without this pin. The driver doesn't use
> interrupt at this time, but it could be extended.

Cheers,
Conor.

--6/TCsU+pwTa96crd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTqO5wAKCRB4tDGHoIJi
0hmYAQCmkSnFNbvLOYoS5zpR/RrKQCjnseNtPyG7Q7Cd/8Q6lQEA5xp0wOClCL69
r+PqDSbFGSDxR9U6JeWtWD5lnAIvMQw=
=8fmx
-----END PGP SIGNATURE-----

--6/TCsU+pwTa96crd--
