Return-Path: <linux-kernel+bounces-133959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A4A89AB75
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEFD1C21295
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A72383B0;
	Sat,  6 Apr 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO9hAoNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21892836D;
	Sat,  6 Apr 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415224; cv=none; b=a0xSRnt/ZV77g9ZH5n+tDMsXbAJGh/UCDJOinJCatnoNkWxSWtMk4pnRSPsa4P2CJEnrL8ycoV4qG+SA8r4UpP2AsfzijlVohPmFplBi6WLAfKI77Y1+xXNEsGFNl/z23AMyyok8C/fNMcI8xnzvjcx3qIPDTMWMBiesTQTULPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415224; c=relaxed/simple;
	bh=sh884fNA6S5RuC5vse0fp8JsGbFYwPP3jKvo8Vnm7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qhbq+ebwHA7+RTF2mdwQlOzIHOB2UhnHYi2mIErPstUpEAXDOXTXx4t9GDak3dkXO/98mb2+Aqz/CbMcpj64cyQCqtFwOz8lkkfCBkARar0Sz0enCXfkkdxCrgECqBFZS4wEoVYiBuuEr6egzHTCWudRETG++Q6t9tgJd4frBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO9hAoNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53204C433F1;
	Sat,  6 Apr 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712415223;
	bh=sh884fNA6S5RuC5vse0fp8JsGbFYwPP3jKvo8Vnm7EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BO9hAoNQxdJ21GfnWHKkKE011uV8mqdGbXobIYPnDyiWopBusmuabiODazwL21t8A
	 Nh/pXJ+og11tSPiWo+cA9QVbuiBm//AoLiP4UJb+eAoysQL+r7ASLFKhoJ17lPHX3n
	 Ur50R2pvLKeHsVYsAneHCvMyfjR+EP2LHjlMQ5xHu8/NRU19eXscQOkjJWfAwqI5Nv
	 OqnT5L3UGjP8BGo5LXc9raAKnpr7ul9brlXI9cfe7sLIpd8mHBqQ77dn0O0jynuaJS
	 T8lNTd/MiZdcSjBIF42khS+lp7CKH+P9O0dfqmg/jOPQbHDVcVi+i6EoaOpZj6GvEk
	 cCgrIX7u5wiJQ==
Date: Sat, 6 Apr 2024 15:53:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240406155328.447b594f@jic23-huawei>
In-Reply-To: <CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-1-34618a9cc502@analog.com>
	<CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
	<25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
	<CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024 10:40:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, Apr 3, 2024 at 2:43=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gma=
il.com> wrote:
> >
> > On 01/04/2024 22:37, David Lechner wrote: =20
> > > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote: =20
> > >>
> > >> From: Dumitru Ceclan <dumitru.ceclan@analog.com> =20
> >
> > ...
> > =20
> > >>      properties:
> > >>        reg:
> > >> +        description:
> > >> +          Reg values 16-19 are only permitted for ad4111/ad4112 cur=
rent channels.
> > >>          minimum: 0
> > >> -        maximum: 15
> > >> +        maximum: 19 =20
> > >
> > > This looks wrong. Isn't reg describing the number of logical channels
> > > (# of channel config registers)?
> > >
> > > After reviewing the driver, I see that > 16 is used as a way of
> > > flagging current inputs, but still seems like the wrong way to do it.
> > > See suggestion below.
> > > =20
> >
> > This was a suggestion from Jonathan, maybe I implemented it wrong.

Maybe Jonathan was wrong!  I was younger then than now :)

However, reg values for child nodes are unique so can't just use a flag the=
se
need to be different values.

> > Other alternative that came to my mind: attribute "adi,current-channel"=
 =20
>=20
> Having a boolean flag like this would make more sense to me if we
> don't agree that the suggestion below is simpler.
>=20
> > >>
> > >>        diff-channels:
> > >> +        description:
> > >> +          For using current channels specify only the positive chan=
nel.
> > >> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0> =20
> > >
> > > I find this a bit confusing since 2 is already VIN2 and 0 is already
> > > VIN0. I think it would make more sense to assign unique channel
> > > numbers individually to the negative and positive current inputs.
> > > Also, I think it makes sense to use the same numbers that the
> > > registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> > > positive).
> > >
> > > So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>
> > >
> > > =20
> > It would mean for the user to look in the datasheet at the possible
> > channel INPUT configurations values, decode the bit field into two
> > integer values and place it here (0110101010) -> 13 10. This is
> > cumbersome for just choosing current input 2. =20
>=20
> It could be documented in the devicetree bindings, just as it is done
> in adi,ad4130.yaml so that users of the bindings don't have to
> decipher the datasheet.

The <13 10> option makes sense to me and avoids suggesting a common negative
input.

The 'fun' bit here is that diff-channels doesn't actually tell us anything.
So we could just not provide it and rely on documentation of reg =3D 16-19 =
meaning
the current channels?

>=20
> > =20
> > >> +
> > >> +          Family AD411x supports a dedicated VCOM voltage input.
> > >> +          To select it set the second channel to 16.
> > >> +            (VIN2, VCOM) -> diff-channels =3D <2 16> =20
> > >
> > > The 411x datasheets call this pin VINCOM so calling it VCOM here is a
> > > bit confusing.
> > > =20
> >
> > Sure, I'll rename to VINCOM.
> > =20
> > > Also, do we need to add a vincom-supply to get this voltage? Or is it
> > > safe to assume it is always connected to AVSS? The datasheet seems to
> > > indicate that the latter is the case. But then it also has this
> > > special case (at least for AD4116, didn't check all datasheets)
> > > "VIN10, VINCOM (single-ended or differential pair)". If it can be used
> > > as part of a fully differential input, we probably need some extra
> > > flag to indicate that case.
> > > =20
> >
> > I cannot see any configuration options for these use cases. All inputs
> > are routed to the same mux and routed to the differential positive and
> > negative ADC inputs.
> >
> > "VIN10, VINCOM (single-ended or differential pair)" the only difference
> > between these two use cases is if you connected VINCOM to AVSS (with
> > unipolar coding) or not with bipolar encoding. The channel is still
> > measuring the difference between the two selected inputs and comparing
> > to the selected reference.
> > =20
> > > Similarly, do we need special handling for ADCIN15 on AD4116? It has a
> > > "(pseudo differential or differential pair)" notation that other
> > > inputs don't. In other words, it is more like VINCOM than it is to the
> > > other ADCINxx pins. So we probably need an adcin15-supply for this pin
> > > to properly get the right channel configuration. I.e. the logic in the
> > > IIO driver would be if adcin15-supply is present, any channels that
> > > use this input are pseudo-differential, otherwise any channels that
> > > use it are fully differential.
> > > =20
> >
> > I cannot seem to understand what would a adcin15-supply be needed for.
> > This input, the same as all others, enters the mux and is routed to
> > either positive or negative input of the ADC.
> >
> > The voltage on the ADCIN15 pin is not important to the user, just the
> > difference in voltage between that pin and the other one selected.
> > =20
>=20
> These suggestions come from some recent discussion about
> pseudo-differential vs. fully differential inputs (e.g. search the IIO
> mailing list for AD7380).
>=20
> So what I suggested here might be more technically correct according
> to what I got out of that discussion. But for this specific case, I
> agree it is good enough to just treat all inputs as always
> fully-differential to keep things from getting too unwieldy.

Hmm.  That whole approach to pseudo differential does get messy if
we have the common line routed through the main MUX rather than an opt
in only on the negative side. =20

If I read this right, its almost a trick to support a pseudo differential
wiring with simple registers (I guess reflecting MUX limitations).

So what could we do?

We could assume that VINCOM is used like a conventional pseudo
differential negative signal and have supply-vincom + non diffferential
channels if that's the configuration wanted.

Then for differential channels can support all the VINX VINX+1
and swapped options.
For VIN10 it gets fun as non differential and differential options
I think map to same actual config.   Don't see reason we need to express
that in the binding though so let that have VIN10 VINCOM (probably using
a magic channel number) and  VIN10 pseudo differential.

Similar setup for ADCIN15 equivalent usage

Code wise this probably won't be particular hard to support in the driver
(obviously I haven't tried though :) is it worth the effort to keep
it inline with other devices that support pseudo differential channesl.


>=20
> > >>          items:
> > >>            minimum: 0
> > >>            maximum: 31
> > >> @@ -166,7 +191,6 @@ allOf:
> > >>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >>
> > >>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> > >> -  # Other models have [0-3] channel registers =20
> > >
> > > Did you forget to remove
> > >
> > >             reg:
> > >               maximum: 3
> > >
> > > from this if statement that this comment is referring to?
> > >
> > > =20
> >
> >
> > Other way around, forgot in a previous patch to remove the comment.
> > I'll move this change to a precursor patch.
> > =20
> > >>    - if:
> > >>        properties:
> > >>          compatible:
> > >> @@ -187,6 +211,37 @@ allOf:
> > >>                  - vref
> > >>                  - refout-avss
> > >>                  - avdd
> > >> +
> > >> +  - if:
> > >> +      properties:
> > >> +        compatible:
> > >> +          contains:
> > >> +            enum:
> > >> +              - adi,ad4114
> > >> +              - adi,ad4115
> > >> +              - adi,ad4116
> > >> +              - adi,ad7173-8
> > >> +              - adi,ad7175-8
> > >> +    then:
> > >> +      patternProperties:
> > >> +        "^channel@[0-9a-f]$":
> > >> +          properties:
> > >> +            reg:
> > >> +              maximum: 15 =20
> > >
> > > As with the previous reg comment, this if statement should not be
> > > needed since maximum should not be changed to 19.
> > > =20
> >
> > We'll see what is the best approach regarding the current channels,
> > perhaps the one you mentioned in the later reply with always configuring
> > like the temp channel.
> > =20
That's an option as well.  In many early drivers we just provided all the
channels. Somewhat depends on whether people buy devices with lots of
channels they don't wire.  Mostly I suspect they don't as that's money
wasted!

Jonathan


