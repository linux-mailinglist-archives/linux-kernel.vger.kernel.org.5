Return-Path: <linux-kernel+bounces-143802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA28A3DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4971C1F21995
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AD4D106;
	Sat, 13 Apr 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9byVTfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DD28EA;
	Sat, 13 Apr 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713024866; cv=none; b=RCgMMhadKHk1SzPMK0dBes0fzCL0s0PwV8btBorPqS5e6eVSG34iRaJTUJrNl6xZC00pVgU+0RBy36FqwUXHWhbr5CvB7XWNQrcDzhsqnBfYsX61NHMOLxjDO9nIMTlfCztejfd/kZUiOCRA+dLAy94IrXOviqWl8pc/6n0G46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713024866; c=relaxed/simple;
	bh=EG54GmgohlqxXTg+gda5rYJMmQ8eRU3Vm55LkUqh0Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwfu0NPSWbU6U77Yupmk4P9OR1XPXYo/1XZyGmsKLjI+h7QKJ8LQuE4TSahhBueNonenvUMytISWPcUZ9QTmKM5sNK3roBoVtgkdg2myaNWjfst6hCKxKW6gfTe6RIrxZnkh27eF2B651Fj18wuokzf+31ne3gP7bkhglM915nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9byVTfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAFC2BBFC;
	Sat, 13 Apr 2024 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713024865;
	bh=EG54GmgohlqxXTg+gda5rYJMmQ8eRU3Vm55LkUqh0Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9byVTfG/AbwzuFPfSRVUSpAOlWLAAoEqc+oDcji0JM5yQSM16u370a3qMRmJImd3
	 1FrFXPRnZCsxr6RezJ5PiZYRoCYr/q5QSXA1Y0HXpw+5tylP0Z89XPBE11udtAQoPu
	 4U2jI6D8uGwwSCef7tuUDRlEQMcqgx+3lQbPxn4a5xTxgnkofAHhEkLYcWH+9zJrV4
	 cvqHe1P7mXpfQ4dc1uKv1okDq3LU9i1vgW2l8c6xHoEyagt9+oqkTrsLGVndWELlJR
	 g8CaTxp70xTUZVk+s0QqQWOJg6IdxU91CLsbayFgaEWjT+ZxDrBS0oaef7hSSPseNp
	 Tt2Cfd40ktBSA==
Date: Sat, 13 Apr 2024 17:14:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240413171409.4575fe6f@jic23-huawei>
In-Reply-To: <ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
	<ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 12:30:09 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 04/08, David Lechner wrote:
> > On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote: =20
> > >
> > > Add device tree documentation for AD4000 family of ADC devices.
> > >
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4000-4004-4008.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4001-4005.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4002-4006-4010.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4003-4007-4011.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4020-4021-4022.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/adaq4001.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/adaq4003.pdf
> > > =20
> >=20
> > Suggested-by: David Lechner <dlechner@baylibre.com>
> >=20
> > (if you still use mostly my suggestions in the end) =20
>=20
> Yes, it's been of great help. Will include the tag in future ad4000 DT pa=
tches.
>=20
> >  =20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 208 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4=
000.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > new file mode 100644
> > > index 000000000000..ca06afb5149e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > @@ -0,0 +1,201 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD4000 and similar Analog to Digital Converters
> > > +
> > > +maintainers:
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices AD4000 family of Analog to Digital Converters with =
SPI support.
> > > +  Specifications can be found at:
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad4000-4004-4008.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad4001-4005.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad4002-4006-4010.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad4003-4007-4011.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad4020-4021-4022.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/adaq4001.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/adaq4003.pdf
> > > +
> > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad4000
> > > +      - adi,ad4001
> > > +      - adi,ad4002
> > > +      - adi,ad4003
> > > +      - adi,ad4004
> > > +      - adi,ad4005
> > > +      - adi,ad4006
> > > +      - adi,ad4007
> > > +      - adi,ad4008
> > > +      - adi,ad4010
> > > +      - adi,ad4011
> > > +      - adi,ad4020
> > > +      - adi,ad4021
> > > +      - adi,ad4022
> > > +      - adi,adaq4001
> > > +      - adi,adaq4003
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  adi,spi-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ single, chain ] =20
> >=20
> > It sounds like there are more possible wiring configurations for these
> > chips that I thought when suggesting reusing this binding from AD7944
> > so we probably need more options here. (see my reply to the cover
> > letter for the complete context of these remarks)
> >=20
> > We identified A) an additional wiring configuration where SDI of the
> > ADC chip is wired to SDO of the SPI controller and B) a potential need
> > to pin mux between wiring modes to work around SPI controller
> > limitations perhaps we could omit the adi,spi-mode property and just
> > use the standard pinctrl properties.
> >=20
> >   pinctrl-names:

I'm lost on how pinctrl makes sense here.
Yes you are changing the modes of the pins, but not in a conventional sense
of some register that is being updated to say now use them like this.
The mode is dependent on the timing sequence of how the pins are used.
Otherwise looking at it a different way it's an external wiring thing we
aren't controlling it at all.  Is pinctrl suitable for that?
I always thought of it as a way to change configurations of SoC pins.

A pointer to some precendence in another driver for using it like this
would go some way towards convincing me.

Jonathan


> >     description: |
> >       Names for possible ways the SDI line of the controller is wired.
> >=20
> >       * default: The SDI line of the ADC is connected to the SDO line o=
f the
> >         SPI controller.  CNV line of the ADC is connected to CS of the =
SPI
> >         controller. =20
> Not sure if should be DT, but maybe also point out that in default mode t=
he
> SPI controller must be capable of keeping ADC SDI (controller SDO) line h=
igh
> during ADC conversions.
>=20
> >       * single: The datasheet calls this "3-wire mode".  (NOTE: The dat=
asheet's
> >         definition of 3-wire mode is NOT at all related to the standard
> >         spi-3wire property!)  In this mode, SDI is tied to VIO, and the=
 CNV line
> >         can be connected to the CS line of the SPI controller (typical)=
 or to a
> >         GPIO, in which case the CS line of the controller is unused.  T=
he SDO
> >         line of the SPI controller is not connected.
> >       * multi: The datasheet calls this "4-wire mode" and is used when =
multiple
> >         chips are connected in parallel.  In this mode, the ADC SDI lin=
e is tied
> >         to the CS line on the SPI controller and the CNV line is connec=
ted to
> >         a GPIO.  The SDO line of the SPI controller is not connected.
> >       * chain: The datasheet calls this "chain mode".  This mode is use=
d to save
> >         on wiring when multiple ADCs are used.  In this mode, the SDI l=
ine of
> >         one chip is tied to the SDO of the next chip in the chain and t=
he SDI of
> >         the last chip in the chain is tied to GND.  Only the first chip=
 in the
> >         chain is connected to the SPI bus.  The CNV line of all chips a=
re tied
> >         together.  The CS line of the SPI controller can be used as the=
 CNV line
> >         only if it is active high.
> >=20
> >       If one name is specified, it is assumed the chip is hard-wired in=
 this
> >       configuration.
> >=20
> >       If two names are specified, it is assumed that a pinmux can switc=
h between
> >       the two wiring configurations.  The first is the default mode for=
 reading
> >       and writing registers on the chip and the second is the mode for =
reading
> >       the conversion data from the chip.
> >     oneOf:
> >       - items:
> >           - enum:
> >             - default
> >             - single
> >             - multi
> >             - chain
> >       - items:
> >           - const: default
> >           - enum:
> >             - single
> >             - multi
> >             - chain
> >=20
> >   pinctrl-0:
> >     maxItems: 1
> >=20
> >   pinctrl-1:
> >     maxItems: 1

