Return-Path: <linux-kernel+bounces-143690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673448A3C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839A21C20DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331A3D547;
	Sat, 13 Apr 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3PJ2Nwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9441C93;
	Sat, 13 Apr 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005393; cv=none; b=Ye+TK9OsdgTwn4vTuMtcuh7gM4mHI/K5t6QLUieZYAhw48AC6+w988Wqb6H7SKMJw6vPDXZrUxB2L5xyvtlceaMT6x9wtLYXzyuucOyUzJqBnTZ0g9SshQWkiZWLdj27eYDHsuf255BfJ3847gam26Ih6/RTgm/q6es8C/qVl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005393; c=relaxed/simple;
	bh=mO23632JfDtOfpWTcyjhmM/Z16JBnq5k44dsgvYltSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXVgAfYgeYvA1qiE8MSwpf6+hKi05ApQeOzX8XjqwTXe5Sc2Wk3NL10yWOEAo46hQVWQZ/8tXS/aPGAh63sanLhrRKn3etMstCC4INXPtwlyjsGW34twXIKSBvpXb9TpB4qO8OpnjFUVckaTFAbPqSxLHIb98qPn8etGsEy3Fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3PJ2Nwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11445C2BBFC;
	Sat, 13 Apr 2024 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713005393;
	bh=mO23632JfDtOfpWTcyjhmM/Z16JBnq5k44dsgvYltSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3PJ2Nwi5svx/gDA1H0tdIgrgXGvWoEe4hxIm3u41nEXczx0tW5j/KWReaUakJBlM
	 9EjWv0yUDqQSDb59nB7AojUR63RDCQp3exO/ZCdpUEZpg+WaSY7CwfuMRb1xBN+e9/
	 NkLvPx/14hKMAD1Gd5ZHTJp9qIuzDZyFTJtO3tTaRgPkXqxCH89C8qGwXpWqy4wu+y
	 HsND7RFhVHeXZvRX5zN6JxweQFyRrHAh9YL5BBnEKM6/oFD/qgd/RQWJlbNnncLozM
	 3ZUXoiCFDDMzi0T5/fCno6OVaPcu+2kAB9pl6WXB8QdjQ/7eqHS1dEGW23YNgWj1JG
	 e6cQpNxWRAKkw==
Date: Sat, 13 Apr 2024 11:49:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240413114825.74e7f3fa@jic23-huawei>
In-Reply-To: <64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-1-34618a9cc502@analog.com>
	<CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
	<25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
	<CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
	<20240406155328.447b594f@jic23-huawei>
	<64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 11:08:28 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 06/04/2024 17:53, Jonathan Cameron wrote:
> > On Wed, 3 Apr 2024 10:40:39 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On Wed, Apr 3, 2024 at 2:43=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@=
gmail.com> wrote: =20
> >>>
> >>> On 01/04/2024 22:37, David Lechner wrote:   =20
> >>>> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> >>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:   =20
> >>>>>
> >>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>   =20
> >>>
> >>> ...
> >>>   =20
> >>>>>      properties:
> >>>>>        reg:
> >>>>> +        description:
> >>>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 cu=
rrent channels.
> >>>>>          minimum: 0
> >>>>> -        maximum: 15
> >>>>> +        maximum: 19   =20
> >>>>
> >>>> This looks wrong. Isn't reg describing the number of logical channels
> >>>> (# of channel config registers)?
> >>>>
> >>>> After reviewing the driver, I see that > 16 is used as a way of
> >>>> flagging current inputs, but still seems like the wrong way to do it.
> >>>> See suggestion below.
> >>>>   =20
> >>>
> >>> This was a suggestion from Jonathan, maybe I implemented it wrong. =20
> >=20
> > Maybe Jonathan was wrong!  I was younger then than now :)
> >=20
> > However, reg values for child nodes are unique so can't just use a flag=
 these
> > need to be different values.
> >  =20
>=20
> I do not see where the restriction appears when using just the flag, when=
 defining
> the channels you would still define unique reg values.

Good point. I'd got it into my head we had reg matching the channel index
but that doesn't work anyway because those can repeat.   Sorry for misdirec=
tion!

>=20
> >>> Other alternative that came to my mind: attribute "adi,current-channe=
l".   =20
> >>
> >> Having a boolean flag like this would make more sense to me if we
> >> don't agree that the suggestion below is simpler.
> >> =20
> >>>>>
> >>>>>        diff-channels:
> >>>>> +        description:
> >>>>> +          For using current channels specify only the positive cha=
nnel.
> >>>>> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0>   =20
> >>>>
> >>>> I find this a bit confusing since 2 is already VIN2 and 0 is already
> >>>> VIN0. I think it would make more sense to assign unique channel
> >>>> numbers individually to the negative and positive current inputs.
> >>>> Also, I think it makes sense to use the same numbers that the
> >>>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> >>>> positive).
> >>>>
> >>>> So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>
> >>>>
> >>>>   =20
> >>> It would mean for the user to look in the datasheet at the possible
> >>> channel INPUT configurations values, decode the bit field into two
> >>> integer values and place it here (0110101010) -> 13 10. This is
> >>> cumbersome for just choosing current input 2.   =20
> >>
> >> It could be documented in the devicetree bindings, just as it is done
> >> in adi,ad4130.yaml so that users of the bindings don't have to
> >> decipher the datasheet. =20
> >=20
> > The <13 10> option makes sense to me and avoids suggesting a common neg=
ative
> > input.
> >=20
> > The 'fun' bit here is that diff-channels doesn't actually tell us anyth=
ing.
> > So we could just not provide it and rely on documentation of reg =3D 16=
-19 meaning
> > the current channels?
> >  =20
>=20
> So a channel without diff-channels defined and reg=3D16 means IN0+ IN0-?

Yes, but with you correcting my error above maybe this isn't as clear cut as
I'd falsely recalled.

We do directly relate reg to channel numbers in drivers like the ad7292 (wh=
ere not
all channels are differential)  I'm not convinced either way on what is best
here where reg is currently just an index into a channel specification, not
meaningful for which pins are involved.

It doesn't seem worth adding an equivalent of diff-channels for a single ch=
annel
setup but I guess it would be more consistent.

>=20
> >> =20
> >>>   =20
> >>>>> +
> >>>>> +          Family AD411x supports a dedicated VCOM voltage input.
> >>>>> +          To select it set the second channel to 16.
> >>>>> +            (VIN2, VCOM) -> diff-channels =3D <2 16>   =20
> >>>>
> >>>> The 411x datasheets call this pin VINCOM so calling it VCOM here is a
> >>>> bit confusing.
> >>>>   =20
> >>>
> >>> Sure, I'll rename to VINCOM.
> >>>   =20
> >>>> Also, do we need to add a vincom-supply to get this voltage? Or is it
> >>>> safe to assume it is always connected to AVSS? The datasheet seems to
> >>>> indicate that the latter is the case. But then it also has this
> >>>> special case (at least for AD4116, didn't check all datasheets)
> >>>> "VIN10, VINCOM (single-ended or differential pair)". If it can be us=
ed
> >>>> as part of a fully differential input, we probably need some extra
> >>>> flag to indicate that case.
> >>>>   =20
> >>>
> >>> I cannot see any configuration options for these use cases. All inputs
> >>> are routed to the same mux and routed to the differential positive and
> >>> negative ADC inputs.
> >>>
> >>> "VIN10, VINCOM (single-ended or differential pair)" the only differen=
ce
> >>> between these two use cases is if you connected VINCOM to AVSS (with
> >>> unipolar coding) or not with bipolar encoding. The channel is still
> >>> measuring the difference between the two selected inputs and comparing
> >>> to the selected reference.
> >>>   =20
> >>>> Similarly, do we need special handling for ADCIN15 on AD4116? It has=
 a
> >>>> "(pseudo differential or differential pair)" notation that other
> >>>> inputs don't. In other words, it is more like VINCOM than it is to t=
he
> >>>> other ADCINxx pins. So we probably need an adcin15-supply for this p=
in
> >>>> to properly get the right channel configuration. I.e. the logic in t=
he
> >>>> IIO driver would be if adcin15-supply is present, any channels that
> >>>> use this input are pseudo-differential, otherwise any channels that
> >>>> use it are fully differential.
> >>>>   =20
> >>>
> >>> I cannot seem to understand what would a adcin15-supply be needed for.
> >>> This input, the same as all others, enters the mux and is routed to
> >>> either positive or negative input of the ADC.
> >>>
> >>> The voltage on the ADCIN15 pin is not important to the user, just the
> >>> difference in voltage between that pin and the other one selected.
> >>>=20

That statement is the root of disagreement I think.
If they are wired for pseudo differential measurement ADCIN15 a reference v=
oltage
not a varying signal. It can equally be used as a negative channel of
a differential pair.   Not different from point of view of hardware
config, but potentially different from point of view of how the
analog wiring is done and how we may want to present it to userspace.

> >>
> >> These suggestions come from some recent discussion about
> >> pseudo-differential vs. fully differential inputs (e.g. search the IIO
> >> mailing list for AD7380).
> >>
> >> So what I suggested here might be more technically correct according
> >> to what I got out of that discussion. But for this specific case, I
> >> agree it is good enough to just treat all inputs as always
> >> fully-differential to keep things from getting too unwieldy. =20
> >=20
> > Hmm.  That whole approach to pseudo differential does get messy if
> > we have the common line routed through the main MUX rather than an opt
> > in only on the negative side. =20
> >=20
> > If I read this right, its almost a trick to support a pseudo differenti=
al
> > wiring with simple registers (I guess reflecting MUX limitations).
> >=20
> > So what could we do?
> >=20
> > We could assume that VINCOM is used like a conventional pseudo
> > differential negative signal and have supply-vincom + non diffferential
> > channels if that's the configuration wanted.
> >=20
> > Then for differential channels can support all the VINX VINX+1
> > and swapped options.
> > For VIN10 it gets fun as non differential and differential options
> > I think map to same actual config.   Don't see reason we need to express
> > that in the binding though so let that have VIN10 VINCOM (probably using
> > a magic channel number) and  VIN10 pseudo differential.
> >=20
> > Similar setup for ADCIN15 equivalent usage
> >=20
> > Code wise this probably won't be particular hard to support in the driv=
er
> > (obviously I haven't tried though :) is it worth the effort to keep
> > it inline with other devices that support pseudo differential channesl.=
 =20
>=20
> Then this would need to be done to any fully differential ADC as support
> for pseudo differential channels is present (connect a fixed non 0 voltage
> to the negative input).

Whilst you could argue that, I'd counter that a clearly stated pseudo
differential mode with a simple choice of negative input (typically
only one pin is used for these modes), is a feature of the ADC, rather
than a wiring choice such as tying all negative inputs together and to
a reference supply.

>=20
> The AD717x family supports pseudo differential channels as well... should
> this change be applied to them too? It is just the case that the document=
ation
> does not mentions this use case.

Maybe you could argue that if we used the REF- for the negative input.
Otherwise I think it falls into the category where there isn't a clearly de=
fined
pseudo differential mode.

>=20
> I think that a distinction needs to be made here:
> - When a device is only pseudo differential, sure, it is in a different c=
ategory
> - When a device is fully differential and you are using it as pseudo-diff=
erential
>   you are having two inputs compared to one another
>=20
> I would need more clarification is why would supply-vincom be a requireme=
nt.
> The voltage supplied to VINCOM will not be used in any computation within=
=20
> the driver. From the perspective of getting the data it doesn't matter if=
=20
> you are using the channel in a pseudo-differential, single ended or fully
> differential manner.

I'd missed until now that the datasheet (I looked ad4114) says aincomm shou=
ld be connected to analog
ground so indeed nothing to turn on in this case and no offset to supply
(the offset will be 0 so we don't present it).

I'll note the datasheet describes the VINCOM as follows.

Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when the inpu=
ts are configured
as single-ended.  Connect AINCOM to analog ground.

The reference to single ended is pretty clear hint to me that this case
is not a differential channel. The more complex case is the one David
raised of the AD4116 where we have actual pseudo differential inputs.

>=20
> Regarding VINX VINX+1, it is not mandatory to respect those, from AD4111 =
page27:
> "Due to the matching resistors on the analog front end, the
>  differential inputs must be paired together in the following
>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
>  VIN6 and VIN7. If any two voltage inputs are paired in a
>  configuration other than what is described in this data sheet,
>  the accuracy of the device cannot be guaranteed."

OK, but I'll assume no 'good' customer of ADI will do that as any support
engineer would grumpily point at that statement if they ever reported
a problem :)

>=20
> Tried the device and it works as fully differential when pairing any
> VINx with VINCOM. Still works when selecting VINCOM as the positive
> input of the ADC.
>=20
> I really see this as overly complicated and unnecessary. These families
> of ADCs are fully differential. If you are using it to measure a single e=
nded
> (Be it compared to 0V or pseudo differential where you are comparing to V=
ref/2
> and obtaining results [Vref/2 , -Vref/2]) the final result will not requi=
re knowing
> the common voltage.

For single ended VINCOM should be tied to analog 0V.  If the chip docs allo=
wed
you to tie it to a different voltage then the single ended mode would be of=
fset
wrt to that value.

For the AD4116 case in pseudo differential mode, You would need an ADCIN15 =
supply because
that is not connected to analog 0V.  If the device is being used in a pseud=
o differential
mode that provides a fixed offset voltage.

So my preference (though I could maybe be convinced it's not worth the effo=
rt)
is to treat pseudo differential as single ended channels where 'negative' p=
in is
providing a fixed voltage (or 0V if that's relevant).  Thus measurements pr=
ovided
to userspace include the information of that offset.

We haven't handled pseudo differential channels that well in the past, but =
the
recent discussions have lead to a cleaner overall solution and it would be =
good
to be consistent going forwards.  We could deprecate the previous bindings =
in
existing drivers, but that is a job for another day  (possibly never happen=
s!)

Jonathan



>=20
>=20
>=20


