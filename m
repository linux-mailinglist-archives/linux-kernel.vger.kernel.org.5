Return-Path: <linux-kernel+bounces-152294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7C8ABBFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C3F1C20952
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA620DCC;
	Sat, 20 Apr 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD/k5eqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C318134DE;
	Sat, 20 Apr 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713623602; cv=none; b=YDZr4QPHB4UChoDSXFWsPPcSxay5d/2h4AHGJ53AH86thc7lT1wCHWQV75sH45XhMgTPu8RMve/LVxrH4b5gNDyo2CutHP8zNU0vP01Xyk19x66dd8PQaurmxB2P+i6U3Bqt4BBiEftKFEiwo1AED8whcipKdJGeflwj3V50H7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713623602; c=relaxed/simple;
	bh=IgQTNMkLykVUqzmkrxrmXVe8Ut0q4JFsZFxDDZCJqzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDj1RuHe5AIj6knX7Y5cyf8QeNN5jlUT5+ck64dE6QaIf3htdRzzlvuZwlpKB0BhSkRZv8B+GE7dlgrz+2fBLWTPzhLgs8plTZxOkMsITC1mdeL6OBStix8lhTxuZN33lJztbvSJbyQSRgC8UnnCoXTSp+WIMYQyVc/0ZwdhWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD/k5eqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EE1C072AA;
	Sat, 20 Apr 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713623602;
	bh=IgQTNMkLykVUqzmkrxrmXVe8Ut0q4JFsZFxDDZCJqzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QD/k5eqmRN5VVWiUCN/p6g8RyOKRl55u5c1oe/PRV3NNW8nwbPh8Om2zQrT2IgZHR
	 BGz2PP2htT5lchezZsbz0H6hSRBEQxK5gRfffAVm7kp0D6VpJ3+cN+zYNfT+zmffwz
	 KD2c/NEhNG7oR1P0RUZxgogt0aO0ol3oG1mzvLE99rqSU+WSx/7KoUYakuqYdGnh1P
	 5BalAqMic9kFNRYSa1yZjj0haqDertYIuCgns3SKE/HyeV7sg7fZcsR9zlhNpIGHWJ
	 RzFN9YjfdKFnO5rxuKcuRUWcRJPVMuT1xBYyah1mv7pn5g0HCI0cF6LG/5T8XM7+65
	 wCPNFBMOec0iA==
Date: Sat, 20 Apr 2024 15:33:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240420153310.7876cb8a@jic23-huawei>
In-Reply-To: <89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-1-34618a9cc502@analog.com>
	<CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
	<25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
	<CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
	<20240406155328.447b594f@jic23-huawei>
	<64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
	<20240413114825.74e7f3fa@jic23-huawei>
	<89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 21:42:50 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 13/04/2024 13:49, Jonathan Cameron wrote:
> > On Tue, 9 Apr 2024 11:08:28 +0300
> > "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> >  =20
> >> On 06/04/2024 17:53, Jonathan Cameron wrote: =20
> >>> On Wed, 3 Apr 2024 10:40:39 -0500
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>    =20
> >>>> On Wed, Apr 3, 2024 at 2:43=E2=80=AFAM Ceclan, Dumitru <mitrutzcecla=
n@gmail.com> wrote:   =20
> >>>>>
> >>>>> On 01/04/2024 22:37, David Lechner wrote:     =20
> >>>>>> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> >>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:     =20
> >>>>>>>
> >>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>     =20
> >>>>> =20
> ...
> >> =20
> >>>>> Other alternative that came to my mind: attribute "adi,current-chan=
nel".     =20
> >>>>
> >>>> Having a boolean flag like this would make more sense to me if we
> >>>> don't agree that the suggestion below is simpler.
> >>>>   =20
>=20
> ...
>=20
> >=20
> > We do directly relate reg to channel numbers in drivers like the ad7292=
 (where not
> > all channels are differential)  I'm not convinced either way on what is=
 best
> > here where reg is currently just an index into a channel specification,=
 not
> > meaningful for which pins are involved.
> >=20
> > It doesn't seem worth adding an equivalent of diff-channels for a singl=
e channel
> > setup but I guess it would be more consistent.
> >  =20
>=20
> Would you agree with the attribute adi,current-channel within the channel=
 and
>  diff-channels set to the correspondent current inputs (13 10 for pair IN=
2)?

=46rom another thread today I've concluded we do need a single-channel
equivalent of diff-channels, but you are right that here it is a differenti=
al
channel so <13 10> seems like the best option to me.

>=20
> >> =20
> >>>>   =20
> >>>>>     =20
> >>>>>>> +
> >>>>>>> +          Family AD411x supports a dedicated VCOM voltage input.
> >>>>>>> +          To select it set the second channel to 16.
> >>>>>>> +            (VIN2, VCOM) -> diff-channels =3D <2 16>     =20
> >>>>>>
> >>>>>> The 411x datasheets call this pin VINCOM so calling it VCOM here i=
s a
> >>>>>> bit confusing.
> >>>>>>     =20
> >>>>>
> >>>>> Sure, I'll rename to VINCOM.
> >>>>>     =20
> >>>>>> Also, do we need to add a vincom-supply to get this voltage? Or is=
 it
> >>>>>> safe to assume it is always connected to AVSS? The datasheet seems=
 to
> >>>>>> indicate that the latter is the case. But then it also has this
> >>>>>> special case (at least for AD4116, didn't check all datasheets)
> >>>>>> "VIN10, VINCOM (single-ended or differential pair)". If it can be =
used
> >>>>>> as part of a fully differential input, we probably need some extra
> >>>>>> flag to indicate that case.
> >>>>>>     =20
> >>>>>
> >>>>> I cannot see any configuration options for these use cases. All inp=
uts
> >>>>> are routed to the same mux and routed to the differential positive =
and
> >>>>> negative ADC inputs.
> >>>>>
> >>>>> "VIN10, VINCOM (single-ended or differential pair)" the only differ=
ence
> >>>>> between these two use cases is if you connected VINCOM to AVSS (with
> >>>>> unipolar coding) or not with bipolar encoding. The channel is still
> >>>>> measuring the difference between the two selected inputs and compar=
ing
> >>>>> to the selected reference.
> >>>>>     =20
> >>>>>> Similarly, do we need special handling for ADCIN15 on AD4116? It h=
as a
> >>>>>> "(pseudo differential or differential pair)" notation that other
> >>>>>> inputs don't. In other words, it is more like VINCOM than it is to=
 the
> >>>>>> other ADCINxx pins. So we probably need an adcin15-supply for this=
 pin
> >>>>>> to properly get the right channel configuration. I.e. the logic in=
 the
> >>>>>> IIO driver would be if adcin15-supply is present, any channels that
> >>>>>> use this input are pseudo-differential, otherwise any channels that
> >>>>>> use it are fully differential.
> >>>>>>     =20
> >>>>>
> >>>>> I cannot seem to understand what would a adcin15-supply be needed f=
or.
> >>>>> This input, the same as all others, enters the mux and is routed to
> >>>>> either positive or negative input of the ADC.
> >>>>>
> >>>>> The voltage on the ADCIN15 pin is not important to the user, just t=
he
> >>>>> difference in voltage between that pin and the other one selected.
> >>>>> =20
> >=20
> > That statement is the root of disagreement I think.
> > If they are wired for pseudo differential measurement ADCIN15 a referen=
ce voltage
> > not a varying signal. It can equally be used as a negative channel of
> > a differential pair.   Not different from point of view of hardware
> > config, but potentially different from point of view of how the
> > analog wiring is done and how we may want to present it to userspace.
> >  =20
> >>>>
> >>>> These suggestions come from some recent discussion about
> >>>> pseudo-differential vs. fully differential inputs (e.g. search the I=
IO
> >>>> mailing list for AD7380).
> >>>>
> >>>> So what I suggested here might be more technically correct according
> >>>> to what I got out of that discussion. But for this specific case, I
> >>>> agree it is good enough to just treat all inputs as always
> >>>> fully-differential to keep things from getting too unwieldy.   =20
> >>>
> >>> Hmm.  That whole approach to pseudo differential does get messy if
> >>> we have the common line routed through the main MUX rather than an opt
> >>> in only on the negative side. =20
> >>>
> >>> If I read this right, its almost a trick to support a pseudo differen=
tial
> >>> wiring with simple registers (I guess reflecting MUX limitations).
> >>>
> >>> So what could we do?
> >>>
> >>> We could assume that VINCOM is used like a conventional pseudo
> >>> differential negative signal and have supply-vincom + non diffferenti=
al
> >>> channels if that's the configuration wanted.
> >>>
> >>> Then for differential channels can support all the VINX VINX+1
> >>> and swapped options.
> >>> For VIN10 it gets fun as non differential and differential options
> >>> I think map to same actual config.   Don't see reason we need to expr=
ess
> >>> that in the binding though so let that have VIN10 VINCOM (probably us=
ing
> >>> a magic channel number) and  VIN10 pseudo differential.
> >>>
> >>> Similar setup for ADCIN15 equivalent usage
> >>>
> >>> Code wise this probably won't be particular hard to support in the dr=
iver
> >>> (obviously I haven't tried though :) is it worth the effort to keep
> >>> it inline with other devices that support pseudo differential channes=
l.   =20
> >>
> >> Then this would need to be done to any fully differential ADC as suppo=
rt
> >> for pseudo differential channels is present (connect a fixed non 0 vol=
tage
> >> to the negative input). =20
> >=20
> > Whilst you could argue that, I'd counter that a clearly stated pseudo
> > differential mode with a simple choice of negative input (typically
> > only one pin is used for these modes), is a feature of the ADC, rather
> > than a wiring choice such as tying all negative inputs together and to
> > a reference supply.
> >  =20
> >>
> >> The AD717x family supports pseudo differential channels as well... sho=
uld
> >> this change be applied to them too? It is just the case that the docum=
entation
> >> does not mentions this use case. =20
> >=20
> > Maybe you could argue that if we used the REF- for the negative input.
> > Otherwise I think it falls into the category where there isn't a clearl=
y defined
> > pseudo differential mode.
> >  =20
>=20
> While re-reading docs I've noticed that AD7176-2 mentions pseudo differen=
tial usage:
> "Pseudo Differential Inputs
>  The user can also choose to measure four different single-ended
>  analog inputs. In this case, each of the analog inputs is converted
>  as being the difference between the single-ended input to be
>  measured and a set analog input common pin. Because there is
>  a crosspoint multiplexer, the user can set any of the analog inputs
>  as the common pin. An example of such a scenario is to connect
>  the AIN4 pin to AVSS or to the REFOUT voltage (that is, AVSS
>  + 2.5 V) and select this input when configuring the crosspoint
>  multiplexer. When using the AD7176-2 with pseudo differential
>  inputs, the INL specification is degraded."
>=20
> As the crosspoint mux is present on all models it really makes me think t=
hat this
> paragraph applies to all models in the family

Interesting indeed.  So is your thinking that we need to support this
or take that "degraded" comment to imply that we should not bother
(at least until someone actually shouts that they want to do this?)

>=20
> >>
> >> I think that a distinction needs to be made here:
> >> - When a device is only pseudo differential, sure, it is in a differen=
t category
> >> - When a device is fully differential and you are using it as pseudo-d=
ifferential
> >>   you are having two inputs compared to one another
> >>
> >> I would need more clarification is why would supply-vincom be a requir=
ement.
> >> The voltage supplied to VINCOM will not be used in any computation wit=
hin=20
> >> the driver. From the perspective of getting the data it doesn't matter=
 if=20
> >> you are using the channel in a pseudo-differential, single ended or fu=
lly
> >> differential manner. =20
> >=20
> > I'd missed until now that the datasheet (I looked ad4114) says aincomm =
should be connected to analog
> > ground so indeed nothing to turn on in this case and no offset to supply
> > (the offset will be 0 so we don't present it).
> >=20
> > I'll note the datasheet describes the VINCOM as follows.
> >=20
> > Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when the =
inputs are configured
> > as single-ended.  Connect AINCOM to analog ground.
> >=20
> > The reference to single ended is pretty clear hint to me that this case
> > is not a differential channel. The more complex case is the one David
> > raised of the AD4116 where we have actual pseudo differential inputs.
> >  =20
>=20
> Alright, from my perspective they all pass through the same mux but okay,
> not differential. The only issue would differentiating cases in AD4116 wh=
ere
> the pair VIN10 - VINCOM is specified as single-ended or differential pair.
>=20
> Also, AD4116:
> "0101101111 ADCIN11, ADCIN15. (pseudo differential or differential pair)
>  0110001111 ADCIN12, ADCIN15. (pseudo differential or differential pair)
>  0110101111 ADCIN13, ADCIN15. (pseudo differential or differential pair)
>  0111001111 ADCIN14, ADCIN15. (pseudo differential or differential pair)"
>=20
> Not really sure where the "actual pseudo differential" sits.
>=20
> Would you agree with having device tree flags that specifies how is the
> channel used: single-ended, pseudo-differential, differential.
> For the first two, the differential flag will not be set in IIO.

Yes. I think that makes sense - though as you observe in some cases
the actual device settings end up the same (the ad4116 note above).

If a given channel supports single-ended and pseudo-differential is
that really just a low reference change (I assume from an input to the
the IO ground)? Or is there more going on?

If it's the reference, then can we provide that as the binding control
signal?  We have other drivers that do that (though we could perhaps make
it more generic) e.g. adi,ad7124 with adi,reference-select

I don't like that binding because it always ends up have a local enum
of values, but can't really think of a better solution.

>=20
> >>
> >> Regarding VINX VINX+1, it is not mandatory to respect those, from AD41=
11 page27:
> >> "Due to the matching resistors on the analog front end, the
> >>  differential inputs must be paired together in the following
> >>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
> >>  VIN6 and VIN7. If any two voltage inputs are paired in a
> >>  configuration other than what is described in this data sheet,
> >>  the accuracy of the device cannot be guaranteed." =20
> >=20
> > OK, but I'll assume no 'good' customer of ADI will do that as any suppo=
rt
> > engineer would grumpily point at that statement if they ever reported
> > a problem :)
> >  =20
> >>
> >> Tried the device and it works as fully differential when pairing any
> >> VINx with VINCOM. Still works when selecting VINCOM as the positive
> >> input of the ADC.
> >>
> >> I really see this as overly complicated and unnecessary. These families
> >> of ADCs are fully differential. If you are using it to measure a singl=
e ended
> >> (Be it compared to 0V or pseudo differential where you are comparing t=
o Vref/2
> >> and obtaining results [Vref/2 , -Vref/2]) the final result will not re=
quire knowing
> >> the common voltage. =20
> >=20
> > For single ended VINCOM should be tied to analog 0V.  If the chip docs =
allowed
> > you to tie it to a different voltage then the single ended mode would b=
e offset
> > wrt to that value.
> >=20
> > For the AD4116 case in pseudo differential mode, You would need an ADCI=
N15 supply because
> > that is not connected to analog 0V.  If the device is being used in a p=
seudo differential
> > mode that provides a fixed offset voltage.
> >=20
> > So my preference (though I could maybe be convinced it's not worth the =
effort)
> > is to treat pseudo differential as single ended channels where 'negativ=
e' pin is
> > providing a fixed voltage (or 0V if that's relevant).  Thus measurement=
s provided
> > to userspace include the information of that offset.
> >  =20
>=20
> What do you mean by offset? I currently understand that the user will have
> a way of reading the voltage of that specific supply from the driver.=20

How?  We could do it that way, but we don't have existing ABI for this that
I can think of.

>=20
> If you mean provide a different channel offset value when using it as
> pseudo-differential then I would disagree

Provided to user space as _offset on the channel, userspace can either
incorporate it if it wants to compute absolute (relative to some 0V somewhe=
re) value
or ignore it if it only wants the difference from the reference value.

I'm open to discussion other ABI options, but this is the one we most natur=
ally have
available.
>=20
>=20
> > We haven't handled pseudo differential channels that well in the past, =
but the
> > recent discussions have lead to a cleaner overall solution and it would=
 be good
> > to be consistent going forwards.  We could deprecate the previous bindi=
ngs in
> > existing drivers, but that is a job for another day  (possibly never ha=
ppens!)
> >  =20
>=20
> I really hope that a clean solution could be obtained for this driver as =
well :)=20

I bet you wish sometimes that you had easier parts to write drivers for! :)
These continue to stretch the boundaries which is good, but slow.

Jonathan

>=20
>=20


