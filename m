Return-Path: <linux-kernel+bounces-161517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5AA8B4D14
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16B61C20A41
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C507352D;
	Sun, 28 Apr 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZi2Dc8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6773506;
	Sun, 28 Apr 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324427; cv=none; b=gYcMbgtPVnAj5Gu0dFWSw/kYXgiXFn4ZB3LoGVZiMqPN9Nm70mRC2yg9ezAQ+Q1hUc8419vmeFBTkOnS6CLAkJr81U9z2DDtPHBnGdIEPyCM560OFxr4q3/Nf2ef26Hf3hQYT8nizHATQJyBTIwxrJXbb8pThxoFxbo4yIh42W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324427; c=relaxed/simple;
	bh=NDD+5WbdfZZojda6RGaWuTbw2sDv/64N8pV2uHYNZHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNsumNNiwuT1fBINBeIIuHff7Lkq5K1IidohKVn2CDTkeS2ECoDTAQhweymCOOWoSnhTzmzQHo9CCsjdz6++vlt2GgzlljUUpxIr96r2iNpVNlO/4AsTftvTLl9PRTpW2V4zeFYQApzC12CObatLgBUzeXIK9wnOfucR0ubZXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZi2Dc8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11902C4AF19;
	Sun, 28 Apr 2024 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714324426;
	bh=NDD+5WbdfZZojda6RGaWuTbw2sDv/64N8pV2uHYNZHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZi2Dc8mG6de/jE6D2D6gkdJ2XBcZRcJVYXvffE6ErOLht/bONz7qSuPJr3jwkH+s
	 mlYQ7FOcZABtRlPNwibrqRQ9VxsgltbtPOLd754XQEawhqstRlQbmmrYwOcYvYZnfi
	 8aLvkKQuFsSbzJvUh5ppN8KcV3ClnH3FlLxjCn1q3d5ewv6YEXsqAlmhgmm5rKg4H5
	 WGqN/PYs5++OkTcz/0llEA1F00a5ZuoeytJh3q5aS7GkIKTGLnx1BxtQmGLkOSrFmV
	 4Hwr0JOid5PkIkmjBws359OtRjCnrAd7gHKQypop23zlat0xxbRd+cAgauB/Cb/BQ4
	 b3jBhD/S1JB/A==
Date: Sun, 28 Apr 2024 18:13:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240428181334.5792e1df@jic23-huawei>
In-Reply-To: <681f3bfb-76d0-41a8-82b5-6d27641c24b6@gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-1-34618a9cc502@analog.com>
	<CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
	<25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
	<CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
	<20240406155328.447b594f@jic23-huawei>
	<64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
	<20240413114825.74e7f3fa@jic23-huawei>
	<89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
	<20240420153310.7876cb8a@jic23-huawei>
	<681f3bfb-76d0-41a8-82b5-6d27641c24b6@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 11:18:47 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 20/04/2024 17:33, Jonathan Cameron wrote:
> > On Mon, 15 Apr 2024 21:42:50 +0300
> > "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> >  =20
> >> On 13/04/2024 13:49, Jonathan Cameron wrote: =20
> >>> On Tue, 9 Apr 2024 11:08:28 +0300
> >>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> >>>    =20
> >>>> On 06/04/2024 17:53, Jonathan Cameron wrote:   =20
> >>>>> On Wed, 3 Apr 2024 10:40:39 -0500
> >>>>> David Lechner <dlechner@baylibre.com> wrote:
> >>>>>      =20
> >>>>>> On Wed, Apr 3, 2024 at 2:43=E2=80=AFAM Ceclan, Dumitru <mitrutzcec=
lan@gmail.com> wrote:     =20
> >>>>>>>
> >>>>>>> On 01/04/2024 22:37, David Lechner wrote:       =20
> >>>>>>>> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Re=
lay
> >>>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:       =20
> >>>>>>>>>
> >>>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>       =20
> >>>>>>>   =20
>=20
> ...
> =20
> >>>>
> >>>> The AD717x family supports pseudo differential channels as well... s=
hould
> >>>> this change be applied to them too? It is just the case that the doc=
umentation
> >>>> does not mentions this use case.   =20
> >>>
> >>> Maybe you could argue that if we used the REF- for the negative input.
> >>> Otherwise I think it falls into the category where there isn't a clea=
rly defined
> >>> pseudo differential mode.
> >>>    =20
> >>
> >> While re-reading docs I've noticed that AD7176-2 mentions pseudo diffe=
rential usage:
> >> "Pseudo Differential Inputs
> >>  The user can also choose to measure four different single-ended
> >>  analog inputs. In this case, each of the analog inputs is converted
> >>  as being the difference between the single-ended input to be
> >>  measured and a set analog input common pin. Because there is
> >>  a crosspoint multiplexer, the user can set any of the analog inputs
> >>  as the common pin. An example of such a scenario is to connect
> >>  the AIN4 pin to AVSS or to the REFOUT voltage (that is, AVSS
> >>  + 2.5 V) and select this input when configuring the crosspoint
> >>  multiplexer. When using the AD7176-2 with pseudo differential
> >>  inputs, the INL specification is degraded."
> >>
> >> As the crosspoint mux is present on all models it really makes me thin=
k that this
> >> paragraph applies to all models in the family =20
> >=20
> > Interesting indeed.  So is your thinking that we need to support this
> > or take that "degraded" comment to imply that we should not bother
> > (at least until someone actually shouts that they want to do this?)
> >  =20
>=20
>  My perspective is that support for this is already existent, the chips d=
o not
> need any special configuration in that use-case. If we want to be correct=
 in
> how the channel will be presented to the user, besides setting to false t=
he IIO
> differential flag I do not see what else should be done.

ah. The degraded bit bothered me.  That wording makes me thing no effort
should be applied to support this unless a user shouts that they really wan=
t it.
If we get it for free or near free than all is good!.

>=20
> >> =20
> >>>>
> >>>> I think that a distinction needs to be made here:
> >>>> - When a device is only pseudo differential, sure, it is in a differ=
ent category
> >>>> - When a device is fully differential and you are using it as pseudo=
-differential
> >>>>   you are having two inputs compared to one another
> >>>>
> >>>> I would need more clarification is why would supply-vincom be a requ=
irement.
> >>>> The voltage supplied to VINCOM will not be used in any computation w=
ithin=20
> >>>> the driver. From the perspective of getting the data it doesn't matt=
er if=20
> >>>> you are using the channel in a pseudo-differential, single ended or =
fully
> >>>> differential manner.   =20
> >>>
> >>> I'd missed until now that the datasheet (I looked ad4114) says aincom=
m should be connected to analog
> >>> ground so indeed nothing to turn on in this case and no offset to sup=
ply
> >>> (the offset will be 0 so we don't present it).
> >>>
> >>> I'll note the datasheet describes the VINCOM as follows.
> >>>
> >>> Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when th=
e inputs are configured
> >>> as single-ended.  Connect AINCOM to analog ground.
> >>>
> >>> The reference to single ended is pretty clear hint to me that this ca=
se
> >>> is not a differential channel. The more complex case is the one David
> >>> raised of the AD4116 where we have actual pseudo differential inputs.
> >>>    =20
> >>
> >> Alright, from my perspective they all pass through the same mux but ok=
ay,
> >> not differential. The only issue would differentiating cases in AD4116=
 where
> >> the pair VIN10 - VINCOM is specified as single-ended or differential p=
air.
> >>
> >> Also, AD4116:
> >> "0101101111 ADCIN11, ADCIN15. (pseudo differential or differential pai=
r)
> >>  0110001111 ADCIN12, ADCIN15. (pseudo differential or differential pai=
r)
> >>  0110101111 ADCIN13, ADCIN15. (pseudo differential or differential pai=
r)
> >>  0111001111 ADCIN14, ADCIN15. (pseudo differential or differential pai=
r)"
> >>
> >> Not really sure where the "actual pseudo differential" sits.
> >>
> >> Would you agree with having device tree flags that specifies how is the
> >> channel used: single-ended, pseudo-differential, differential.
> >> For the first two, the differential flag will not be set in IIO. =20
> >=20
> > Yes. I think that makes sense - though as you observe in some cases
> > the actual device settings end up the same (the ad4116 note above).
> > =20
>  This precisely why I suggest this approach, because a channel used as
> single-ended, pseudo or fully differential will have the same register
> configuration on all models. I do not see any other way to know from
> the driver this information.
>=20
> > If a given channel supports single-ended and pseudo-differential is
> > that really just a low reference change (I assume from an input to the
> > the IO ground)? Or is there more going on?
> >  =20
>  I'm not sure if I understood what was said here. The reference specified
> in the channel setup does not need to change.

So what is the effective difference?  My assumption was that single-ended
means reference to 0V in all cases.  Pseudo differential means reference
to an input that is common across multiple channels, but not necessarily 0V?

>=20
> > If it's the reference, then can we provide that as the binding control
> > signal?  We have other drivers that do that (though we could perhaps ma=
ke
> > it more generic) e.g. adi,ad7124 with adi,reference-select
> >  We already have adi,reference-select in the binding and driver, I do n=
ot =20
> see how it could help the driver differentiate between (single, pseudo...)

Indeed that doesn't work.  Problem in this discussion is I've normally forg=
otten
the earlier discussion when I come back to it :(=20
>=20
> > I don't like that binding because it always ends up have a local enum
> > of values, but can't really think of a better solution.
> > =20
>=20
> >> =20
> >>>>
> >>>> Regarding VINX VINX+1, it is not mandatory to respect those, from AD=
4111 page27:
> >>>> "Due to the matching resistors on the analog front end, the
> >>>>  differential inputs must be paired together in the following
> >>>>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
> >>>>  VIN6 and VIN7. If any two voltage inputs are paired in a
> >>>>  configuration other than what is described in this data sheet,
> >>>>  the accuracy of the device cannot be guaranteed."   =20
> >>>
> >>> OK, but I'll assume no 'good' customer of ADI will do that as any sup=
port
> >>> engineer would grumpily point at that statement if they ever reported
> >>> a problem :)
> >>>    =20
> >>>>
> >>>> Tried the device and it works as fully differential when pairing any
> >>>> VINx with VINCOM. Still works when selecting VINCOM as the positive
> >>>> input of the ADC.
> >>>>
> >>>> I really see this as overly complicated and unnecessary. These famil=
ies
> >>>> of ADCs are fully differential. If you are using it to measure a sin=
gle ended
> >>>> (Be it compared to 0V or pseudo differential where you are comparing=
 to Vref/2
> >>>> and obtaining results [Vref/2 , -Vref/2]) the final result will not =
require knowing
> >>>> the common voltage.   =20
> >>>
> >>> For single ended VINCOM should be tied to analog 0V.  If the chip doc=
s allowed
> >>> you to tie it to a different voltage then the single ended mode would=
 be offset
> >>> wrt to that value.
> >>>
> >>> For the AD4116 case in pseudo differential mode, You would need an AD=
CIN15 supply because
> >>> that is not connected to analog 0V.  If the device is being used in a=
 pseudo differential
> >>> mode that provides a fixed offset voltage.
> >>>
> >>> So my preference (though I could maybe be convinced it's not worth th=
e effort)
> >>> is to treat pseudo differential as single ended channels where 'negat=
ive' pin is
> >>> providing a fixed voltage (or 0V if that's relevant).  Thus measureme=
nts provided
> >>> to userspace include the information of that offset.
> >>>    =20
> >>
> >> What do you mean by offset? I currently understand that the user will =
have
> >> a way of reading the voltage of that specific supply from the driver. =
 =20
> >=20
> > How?  We could do it that way, but we don't have existing ABI for this =
that
> > I can think of.
> >  =20
> Expose a voltage channel which is not reading from the device...but that =
is
> too much of a hack to be accepted here

We have done things like that for a few corner cases where we were really s=
tuck
but it is indeed nasty and hard to comprehend. Also so far they've been 'ou=
t'
channels I think which doesn't make sense here.

> >>
> >> If you mean provide a different channel offset value when using it as
> >> pseudo-differential then I would disagree =20
> >=20
> > Provided to user space as _offset on the channel, userspace can either
> > incorporate it if it wants to compute absolute (relative to some 0V som=
ewhere) value
> > or ignore it if it only wants the difference from the reference value.
> >=20
> > I'm open to discussion other ABI options, but this is the one we most n=
aturally have
> > available. =20
> _offset is already used when the bipolar coding is enabled on the channel
> and is computed along datasheet specifications of how data should be proc=
essed,
> this is why I disagree with this.

OK.  It would be easy enough to apply an offset to that, but it would
complicate the driver and could seem a little odd.

>=20
> This feels over-engineered, most of the times if a channel is pseudo
> differential, the relevant measurement will be the differences between
> those two inputs.
>=20
> If a user needs to know the voltage on the common input, he just needs to
> also configure a single ended channel with the common input where the
> negative AIN is connected to AVSS.

OK.  I'm somewhat convinced that this is enough of a pain to describe that
we should just rely on them having some other way to get that offset if they
are deliberately using it to shift the range. We can revisit if it ever
becomes a problem.

So, I think the conclusion is just don't represent AIN-COMM (or similar)
as an explicit voltage we can measure.

> >>
> >> =20
> >>> We haven't handled pseudo differential channels that well in the past=
, but the
> >>> recent discussions have lead to a cleaner overall solution and it wou=
ld be good
> >>> to be consistent going forwards.  We could deprecate the previous bin=
dings in
> >>> existing drivers, but that is a job for another day  (possibly never =
happens!)
> >>>    =20
> >>
> >> I really hope that a clean solution could be obtained for this driver =
as well :)  =20
> >=20
> > I bet you wish sometimes that you had easier parts to write drivers for=
! :)
> > These continue to stretch the boundaries which is good, but slow.
> >=20
> > Jonathan =20
>=20
> Not easier, fewer crammed into the same driver :)

I sympathise! It's been an annoyingly busy kernel cycle in the day job. I w=
as hoping to
get back to you sooner so that more of this was fresh(ish) in my mind :(

My gut feeling is that this is a case for documentation / really detailed c=
over
letter for the next version to make sure we have come to at least a (mostly)
consistent conclusion.

Jonathan


