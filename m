Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D69802F02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjLDJnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjLDJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:43:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC8D6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:43:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B8CC433C7;
        Mon,  4 Dec 2023 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701683024;
        bh=OgG54f7CW3gUgc2H+TO5dUHN3X3mqI/wAR/hHnHXcRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ew4y8eVqcEl6gudf6nE7lvLKPOPeLa1WqJFLrtpinSb/2YSoIs0JM14Be1SxoBGsN
         5L45mRaftVc9PdKcHkLImd885PcRIcKGXVT+AUKnfN2OFzsVBPebEvVxorRoPaXtZi
         sSAE8fPSkN/F5jlm7Up2z3Z3jCK27VLaRNSt7fjvLvvempIufzktK4MEWNX5BhPoS5
         x6zG3FbAIjDlrNwD6BMLbIGHWh9tCXRgUqV1aV0xez6n8fLX5KTg0qlZ/zbmODJEOj
         LF0ZojqVIv5AX6g9J8bUgKhoS6NHeXV5x3IOjlJpdnEeWQS0kbSsdsta1pMCeig8Tk
         uUZ1Ntg4TwK+w==
Date:   Mon, 4 Dec 2023 09:43:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <conor@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20231204094335.21800f38@jic23-huawei>
In-Reply-To: <7974eb280202c551eb66000c8c26276080ad7da2.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
        <20231025134404.131485-2-marius.cristea@microchip.com>
        <20231025-cheddar-tucking-b2ea777ed4f9@spud>
        <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
        <20231026-perkiness-financial-55313e297230@spud>
        <20231027152625.44b26d80@jic23-huawei>
        <7974eb280202c551eb66000c8c26276080ad7da2.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 16:27:54 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
>=20
> On Fri, 2023-10-27 at 15:26 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Thu, 26 Oct 2023 17:08:07 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >  =20
> > > On Thu, Oct 26, 2023 at 03:23:46PM +0000,
> > > Marius.Cristea@microchip.com=C2=A0wrote: =20
> > > > Hi Conor,
> > > >=20
> > > > On Wed, 2023-10-25 at 16:08 +0100, Conor Dooley wrote: =20
> > > > > Hey Marius,
> > > > >=20
> > > > > On Wed, Oct 25, 2023 at 04:44:03PM +0300,
> > > > > marius.cristea@microchip.com=C2=A0wrote: =20
> > > > > > From: Marius Cristea <marius.cristea@microchip.com>
> > > > > >  =20
> .................
> > > > > > +$id:
> > > > > > http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Microchip PAC1934 Power Monitors with Accumulator
> > > > > > +
> > > > > > +maintainers:
> > > > > > +=C2=A0 - Marius Cristea <marius.cristea@microchip.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +=C2=A0 Bindings for the Microchip family of Power Monitors with
> > > > > > Accumulator.
> > > > > > +=C2=A0 The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934
> > > > > > can be
> > > > > > found here:
> > > > > > +
> > > > > > https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/=
ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> > > > > > +
> > > > > > +properties:
> > > > > > +=C2=A0 compatible:
> > > > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1931
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1932
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1933
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,pac1934
> > > > > > +
> > > > > > +=C2=A0 reg:
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 "#address-cells":
> > > > > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > +
> > > > > > +=C2=A0 "#size-cells":
> > > > > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > > > > +
> > > > > > +=C2=A0 interrupts:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: IRQ line of the ADC
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 drive-open-drain:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: The IRQ signal is configured a=
s open-drain.
> > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 microchip,slow-io:
> > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +=C2=A0=C2=A0=C2=A0 description: |
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A GPIO used to trigger a change=
 is sampling rate
> > > > > > (lowering
> > > > > > the chip power consumption).
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In default mode, if this pin is=
 forced high, sampling
> > > > > > rate
> > > > > > is forced to eight
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 samples/second. When it is forc=
ed low, the sampling
> > > > > > rate is
> > > > > > 1024 samples/second unless
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a different sample rate has bee=
n programmed. =20
> > > > >=20
> > > > > This description doesn't really make sense to me - if a GPIO is
> > > > > used
> > > > > to
> > > > > drive the pin low or high, why do we need a property? A DT
> > > > > property
> > > > > implies that this is a static configuration depending on the
> > > > > board,
> > > > > but
> > > > > reading the description this seems to be something that can be
> > > > > toggled
> > > > > at runtime.
> > > > > I do note though, that this GPIO is not documented in the
> > > > > binding, so
> > > > > I
> > > > > suppose what really needs to happen here is document the gpio
> > > > > so that
> > > > > the driver can determine at runtime what state this pin is in?
> > > > >=20
> > > > > Also, you say "In default mode", but don't mention what the
> > > > > non-
> > > > > default
> > > > > mode is. What happens in the other mode? =20
> > >  =20
> > > > This is a "double function" pin. On the PAC193x there is the
> > > > SLOW/ALERT
> > > > pin. At runtime this pin could be configured as an input to the
> > > > PAC and
> > > > the functionality will be "SLOW" that means if it is forced high,
> > > > the
> > > > PAC will work in low power mode by changing the sample rate to 8
> > > > SPS.
> > > > If it's forced low the PAC will work at it's full sample rate. =20
> > >=20
> > > Since this is a runtime thing, it doesn't make sense to have a
> > > property
> > > that is set at dts creation time that decides what mode the pin is
> > > in.
> > >  =20
> > > > "SLOW" is the default function of the pin but it may be
> > > > programmed to
> > > > function as ALERT pin (Open Collector when functioning as ALERT,
> > > > requires pull-up resistor to VDD I/O). This time the pin will be
> > > > set as
> > > > output from PAC (ALERT functionality) to trigger an interrupt to
> > > > the
> > > > system (this is covered by the interrupts and drive-open-drain). =20
> > >=20
> > > Hmm, at the risk of getting out of my depth with what the GPIO
> > > subsystem
> > > is capable of doing, I would expect to see something like
> > >=20
> > > sampling-rate-gpios:
> > > =C2=A0 description:
> > > =C2=A0=C2=A0=C2=A0 <what you have above>
> > > =C2=A0 maxItems: 1
> > >=20
> > > Which would allow the driver to either drive this pin via the gpio
> > > subsystem, or to use the interrupt property to use it as an
> > > interrupt
> > > instead.
> > >=20
> > > Perhaps Jonathan etc knows better for these sort of dual mode pins. =
=20
> >=20
> > Beyond them being a pain? The fun is they may get wired to interrupt
> > controllers that are also GPIOs or they may not (and the other way
> > around
> > with them wired to GPIO pins that aren't interrupt pins).
> >=20
> > I don't understand the usecase for the SLOW control.
> > Given it seems software can override the use for SLOW I'd be tempted
> > to
> > always do that.
> > Thus making this pin useable only as an optional interrupt.
> >  =20
>=20
> I was thinking to have something like interrupt or an equivalent to
> "powerdown-gpios", "richtek,mute-enable", "shutdown-gpios", "mute-
> gpios", "gain-gpios". I think the driver should know (from the Device
> Tree) if the pin is routed to a gpio and it could be used as "SLOW"/low
> power.
If we assume the slow pin is always connected to the host CPU then
simply providing the interrupt and the gpio definition is sufficient.
A comment will do to say they are the same physical pin.

Things get messier if we assume that slow control is coming from something
external to the world Linux knows about.  That tends to be when we need
things like mute-enable

Jonathan

>=20
> > If someone hard wires it to high or low that is harmless if we aren't
> > letting it control anything.
> >  =20
> > >  =20
> > > > The system could work fine without this pin. The driver doesn't
> > > > use
> > > > interrupt at this time, but it could be extended. =20
> > >=20
> > > Cheers,
> > > Conor. =20
> >  =20
> Thanks,
> Marius
>=20

