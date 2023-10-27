Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F77D9B55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbjJ0O1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjJ0O1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:27:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FA3187;
        Fri, 27 Oct 2023 07:26:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA12C433C9;
        Fri, 27 Oct 2023 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698416819;
        bh=5YYMO0sV98SaBaoxX5bGhoOITg6bwSmCh29MACI1GyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HtZYQvNyGiDjSYb0MB5r3gav2CkvU/ekyxQQYaiudFp7pzJwlF8LV+r8nejXUNUar
         vuRWqDXAQ73RtcgWwhuztzWyE6s4HJNODj9uU0mfZSdBCCsykfnBhaLwD7HTr8ffKQ
         1WNN5+aX7JqTckQCES3Jdnce0cBZJ5wuwYvU5rc5ZLhnhkBE1gpuW7wRYUwznPnZAp
         htHAOFL/xKItAr3RF/9IlqiqQwFUDa9TC90y2MH28zQmSz8XmTNmIZcdfcda73QrAB
         uCRxqqZJm93VqbMq89TUtS++il460DuUKaNAGSHGx1C+EFVXzTtrLBDZV5OE8dbMaB
         w3/IUTxL+1s4w==
Date:   Fri, 27 Oct 2023 15:26:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Marius.Cristea@microchip.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20231027152625.44b26d80@jic23-huawei>
In-Reply-To: <20231026-perkiness-financial-55313e297230@spud>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
        <20231025134404.131485-2-marius.cristea@microchip.com>
        <20231025-cheddar-tucking-b2ea777ed4f9@spud>
        <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
        <20231026-perkiness-financial-55313e297230@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 17:08:07 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Oct 26, 2023 at 03:23:46PM +0000, Marius.Cristea@microchip.com wr=
ote:
> > Hi Conor,
> >=20
> > On Wed, 2023-10-25 at 16:08 +0100, Conor Dooley wrote: =20
> > > Hey Marius,
> > >=20
> > > On Wed, Oct 25, 2023 at 04:44:03PM +0300,
> > > marius.cristea@microchip.com=C2=A0wrote: =20
> > > > From: Marius Cristea <marius.cristea@microchip.com>
> > > >=20
> > > > This is the device tree schema for iio driver for
> > > > Microchip PAC193X series of Power Monitors with Accumulator.
> > > >=20
> > > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > > ---
> > > > =C2=A0.../bindings/iio/adc/microchip,pac1934.yaml=C2=A0=C2=A0 | 146
> > > > ++++++++++++++++++
> > > > =C2=A01 file changed, 146 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > > b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > > new file mode 100644
> > > > index 000000000000..837053ed8a71
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > > @@ -0,0 +1,146 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Microchip PAC1934 Power Monitors with Accumulator
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Marius Cristea <marius.cristea@microchip.com>
> > > > +
> > > > +description: |
> > > > +=C2=A0 Bindings for the Microchip family of Power Monitors with
> > > > Accumulator.
> > > > +=C2=A0 The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can=
 be
> > > > found here:
> > > > +=C2=A0=C2=A0=C2=A0
> > > > https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Prod=
uctDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> > > > +
> > > > +properties:
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1931
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1932
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1933
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1934
> > > > +
> > > > +=C2=A0 reg:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 "#address-cells":
> > > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > > +
> > > > +=C2=A0 "#size-cells":
> > > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > > +
> > > > +=C2=A0 interrupts:
> > > > +=C2=A0=C2=A0=C2=A0 description: IRQ line of the ADC
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 drive-open-drain:
> > > > +=C2=A0=C2=A0=C2=A0 description: The IRQ signal is configured as op=
en-drain.
> > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 microchip,slow-io:
> > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > +=C2=A0=C2=A0=C2=A0 description: |
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A GPIO used to trigger a change is =
sampling rate (lowering
> > > > the chip power consumption).
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In default mode, if this pin is for=
ced high, sampling rate
> > > > is forced to eight
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 samples/second. When it is forced l=
ow, the sampling rate is
> > > > 1024 samples/second unless
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a different sample rate has been pr=
ogrammed. =20
> > >=20
> > > This description doesn't really make sense to me - if a GPIO is used
> > > to
> > > drive the pin low or high, why do we need a property? A DT property
> > > implies that this is a static configuration depending on the board,
> > > but
> > > reading the description this seems to be something that can be
> > > toggled
> > > at runtime.
> > > I do note though, that this GPIO is not documented in the binding, so
> > > I
> > > suppose what really needs to happen here is document the gpio so that
> > > the driver can determine at runtime what state this pin is in?
> > >=20
> > > Also, you say "In default mode", but don't mention what the non-
> > > default
> > > mode is. What happens in the other mode? =20
>=20
> > This is a "double function" pin. On the PAC193x there is the SLOW/ALERT
> > pin. At runtime this pin could be configured as an input to the PAC and
> > the functionality will be "SLOW" that means if it is forced high, the
> > PAC will work in low power mode by changing the sample rate to 8 SPS.
> > If it's forced low the PAC will work at it's full sample rate. =20
>=20
> Since this is a runtime thing, it doesn't make sense to have a property
> that is set at dts creation time that decides what mode the pin is in.
>=20
> > "SLOW" is the default function of the pin but it may be programmed to
> > function as ALERT pin (Open Collector when functioning as ALERT,
> > requires pull-up resistor to VDD I/O). This time the pin will be set as
> > output from PAC (ALERT functionality) to trigger an interrupt to the
> > system (this is covered by the interrupts and drive-open-drain). =20
>=20
> Hmm, at the risk of getting out of my depth with what the GPIO subsystem
> is capable of doing, I would expect to see something like
>=20
> sampling-rate-gpios:
>   description:
>     <what you have above>
>   maxItems: 1
>=20
> Which would allow the driver to either drive this pin via the gpio
> subsystem, or to use the interrupt property to use it as an interrupt
> instead.
>=20
> Perhaps Jonathan etc knows better for these sort of dual mode pins.

Beyond them being a pain? The fun is they may get wired to interrupt
controllers that are also GPIOs or they may not (and the other way around
with them wired to GPIO pins that aren't interrupt pins).

I don't understand the usecase for the SLOW control.
Given it seems software can override the use for SLOW I'd be tempted to
always do that.=20
Thus making this pin useable only as an optional interrupt.

If someone hard wires it to high or low that is harmless if we aren't
letting it control anything.

>=20
> > The system could work fine without this pin. The driver doesn't use
> > interrupt at this time, but it could be extended. =20
>=20
> Cheers,
> Conor.

