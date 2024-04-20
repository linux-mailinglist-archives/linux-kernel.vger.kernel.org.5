Return-Path: <linux-kernel+bounces-152224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70B8ABAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BB51F21C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FCC1803A;
	Sat, 20 Apr 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRvE0v4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB717BCB;
	Sat, 20 Apr 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713608018; cv=none; b=aVQA7Nz5TokDUC8OMNyr3Yp1QyVk93ADaKL7gadoxypPvzCvmXsTwF8Hcd4+Boda6u8MogI+B/kAwmen4Yucn2TVbDKprvV6Sb6IUx/cPVnrrpV5oKN202nPkEumppcLuAerc3GhVd+I57R4kfBeUewOjC/5fdfpm2wgHcisBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713608018; c=relaxed/simple;
	bh=T6hRC6jL+eTBc3PIphJU7PiQYuX26KZYCYa6iUkWykk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRg3ktcud8FCOf59zkO8DCUQBwMAxU91RuC1G6EjSupwNfuzJG0kMoqqVlFee7L4E6NSxDExlaqRkR2EApjqFgfRGAVzBZ3pcq4MuhBhpbd9gKCMopNc20ITEln30m2rOBbcyrmUBMwlT2Mqsut7+qMxurQCebfJrx8TjKF30c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRvE0v4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FEAC072AA;
	Sat, 20 Apr 2024 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713608017;
	bh=T6hRC6jL+eTBc3PIphJU7PiQYuX26KZYCYa6iUkWykk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRvE0v4uPE16ZnqeL4tVgZVjjWzj5nHT4HVY0UO1bMDa1rKeO+oydra+IWH0QsMa6
	 R1N3F+srHlzqBwKcvYuGwOyZl4jLWLhj1zbDbDOUrEyoOBKI/0F1S2x1WI/SNdTbK9
	 BGqlwNjFo4kfIh7+01rf8WRypcHe8ytH49ogosnY8lq2Ln2x5DL+vjabT1auphR0V2
	 Ucw4EAndP1a5qAasVi5+Xd2bjNbbkXBMOmDXvgpnSLaRuNBV34wDVxlDNPxeIs4t2n
	 b7k3uHa9gIRR+kCAKpPYThrdtPZczZtEjqT0ycL2Znny7+vZ38+UJCsipLkCSx4saY
	 X1V5e3P4fe4Bw==
Date: Sat, 20 Apr 2024 11:13:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240420111322.4fa026f3@jic23-huawei>
In-Reply-To: <PH0PR03MB714170F4494EA0E1B4112291F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
	<20240413160610.4cec010b@jic23-huawei>
	<CAMknhBHMd2mK3yVoH_XjW7BapX5BTRZjUJpF=ZQrF8Mctf-NJQ@mail.gmail.com>
	<20240413181025.39d1a62e@jic23-huawei>
	<PH0PR03MB714170F4494EA0E1B4112291F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Apr 2024 14:40:56 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, April 14, 2024 1:10 AM
> > To: David Lechner <dlechner@baylibre.com>
> > Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-iio@vger.kernel=
org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter Cl=
ausen
> > <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
> >=20
> > [External]
> >=20
> > On Sat, 13 Apr 2024 11:21:55 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > On Sat, Apr 13, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kern=
el.org> =20
> > wrote: =20
> > > >
> > > > On Fri, 12 Apr 2024 16:23:00 -0500
> > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > =20
> > > > > On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> > > > > <kimseer.paller@analog.com> wrote: =20
> > > > > > =20
> > >
> > > ...
> > > =20
> > > > >
> > > > > And there is V~ on both which can be between -5.5V/-15.75V and GN=
D, so
> > > > > optional v-neg-supply seems appropriate. =20
> > > >
> > > > Only make it optional in the binding if the settings of the device =
change
> > > > depending on whether it is there or not.  Looks like there is an in=
ternal
> > > > reference, so maybe it really is optional. =20
> > >
> > > I suggested optional with the thinking that if the pin is tied to GND,
> > > then the property would be omitted. =20
> >=20
> > We could but given VND isn't really that special in this case I think
> > I'd prefer a fixed voltage reg of 0V if someone does wire it like that.
> > (I think that works, though not sure I've tried a 0V supply ;) =20
>=20
> To clarify, does this mean we should still add an optional property for i=
t in the binding?
I think it should not be optional.  Should be fine providing a 0V fixed reg=
ulator
via DT if it is wired to 0.

Given that is a little unusual, check it works!

>=20
> > > ...
> > >
> > > =20
> > > > >
> > > > > * (both) The MUX/MUXOUT pins look like we have an embedded pin mu=
x, =20
> > so =20
> > > > > it could mean we need #pinctrl-cells. ltc2664 would also need
> > > > > muxin-gpios for this. =20
> > > > Not convinced that's the right approach - looks more like a channel
> > > > selector than a conventional mux or pin control. Sure that's a mux,=
 but
> > > > we want a clean userspace control to let us choose a signal to meas=
ure
> > > > at runtime
> > > >
> > > > If you wanted to support this I'd have the binding describe optional
> > > > stuff to act as a consumer of an ADC channel on another device.
> > > > The IIO driver would then provide a bunch of input channels to allow
> > > > measurement of each of the signals.
> > > >
> > > > Look at io-channels etc in existing bindings for how to do that.
> > > > =20
> > >
> > > Right. I was thinking that this pin might be connected to something
> > > else external rather than the signal coming back to the SoC (or
> > > whatever has the SPI controller). But it makes more sense that we
> > > would want it as extra channels being read back by the SoC for
> > > diagnostics. =20
> >=20
> > It might indeed.  But I think that's an exercise for the future if
> > it matters.  Might be a debugfs control only perhaps. =20
>=20
> We can consider potential future use cases as they become relevant.
> For now, we might not to include or support this functionality.

The pins should be in the DT binding, though the driver support can of cour=
se
be a future exercise.  Make them optional.

>=20
> > >
> > > ...
> > > =20
> > > > > =20
> > > > > > +
> > > > > > +      patternProperties:
> > > > > > +        "^channel@([0-3])$":
> > > > > > +          $ref: '#/$defs/toggle-operation'
> > > > > > +          unevaluatedProperties: false
> > > > > > +
> > > > > > +          description: Channel in toggle functionality.
> > > > > > +
> > > > > > +          properties:
> > > > > > +            adi,output-range-microvolt:
> > > > > > +              description: Specify the channel output full sca=
le range. =20
> > > > >
> > > > > How would someone writing a .dts know what values to select for t=
his
> > > > > property? Or is this something that should be configured at runti=
me
> > > > > instead of in the devicetree? Or should this info come from the
> > > > > missing voltage supplies I mentioned? =20
> > > >
> > > > Sometimes this one is a wiring related choice.  Sometimes to the ex=
tent
> > > > that picking the wrong one from any userspace control can cause dam=
age
> > > > or is at least nonsense.
> > > >
> > > > You look to be right though that the possible values here aren' fine
> > > > if the internal reference is used, but not the external.
> > > >
> > > > However, it's keyed off MPS pins so you can't control it if they ar=
en't
> > > > tied to all high.  So I'd imagine if the board can be damaged it wi=
ll
> > > > be hard wired.  Hence these could be controlled form userspace.
> > > > It's a bit fiddly though as combines scale and offset controls and
> > > > you can end trying to set things to an invalid combination.
> > > > E.g. scale set to cover 20V range and offset set to 0V
> > > > To get around that you have to clamp one parameter to nearest
> > > > possible when the other is changed.
> > > > =20
> > >
> > > Thanks for the explanation. It sounds like I missed something in the
> > > datasheet that would be helpful to call out in the description for
> > > this property. =20
> > Agreed - it needs more detail.
> >=20
> > Jonathan
> >  =20
>=20


