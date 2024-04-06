Return-Path: <linux-kernel+bounces-133951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AA89AB56
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553C71F21659
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216A38397;
	Sat,  6 Apr 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DanSoNxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB32914;
	Sat,  6 Apr 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413612; cv=none; b=CLFUUNh9cSmCocuBw2DEVFOY2s9BS8WTN3cgnZwQIYiFRxSngmtxYB9Xl9qQ6+UU1BhWDXnomI0JrZ51hG7HJ/nw8R5lrhWZa3DdAymhF23C0U1uAo8Fghwc/fWoi7Ckt6zCpHIIQlVLbjMV6pzctRjaTz3gw6P2uRw7T+qbjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413612; c=relaxed/simple;
	bh=vB8L9DX/5J7woTCTJf8HqVrEfFR0fvotCf/wHpMo2G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RY2GyjZcvtPHMCraz8WRdPNbv9vL+fT1czxNC0Xi0rayCNZbo6bPo1P6GXHnjFJtm6wrwmJIxpgwWbl+OLvJb7k/FzOxa3LRKjQsF1VCJpvxhT7GrmNuj+jBZ2zwV0Ts7vlcW+wR85nrgqRCZjhlWID8sDwIhOb2ShdgZa8ATAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DanSoNxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088DC433C7;
	Sat,  6 Apr 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712413611;
	bh=vB8L9DX/5J7woTCTJf8HqVrEfFR0fvotCf/wHpMo2G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DanSoNxjaPzyiNCwope2FSm+ymb0DOVSj+HTeJVxpjRAvlMsJW+a8TxwUnhupPNoA
	 qdxqcU6piuKGHxaxWt68bOw50RRF3nHCbyt1NpPrgXvGE+4XHTn9XS82uQeoBarDwv
	 sX++3EwvCJD7GvhqSdfk6/86qBKNhjMsDcQuy1rfnOn2LJ48/WLn2Qpdj6VO701KCb
	 O8iITUNY++qLhuU3nABV7IxgDR83//3Xxp5GFWi1uRNc2HN8q7QXRcK0VRxoBkQpEk
	 yZiVO3L2vNNTxyJqaDnu1BfBq0Lfmh8nekHebUFls8EHRncLI7DN8y7vhx9IHTB5w1
	 Te1txfWR2fhgQ==
Date: Sat, 6 Apr 2024 15:26:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240406152637.5d53c34f@jic23-huawei>
In-Reply-To: <aa84a3c5-a3e6-4c76-9b67-624ed8d8c704@gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-1-34618a9cc502@analog.com>
	<CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
	<CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
	<0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
	<CAMknhBHhxi7mN88+peU7BGkzSP2vtipCuvM-XfQzgusqKvARsg@mail.gmail.com>
	<aa84a3c5-a3e6-4c76-9b67-624ed8d8c704@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Apr 2024 16:08:56 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 03/04/2024 18:22, David Lechner wrote:
> > On Wed, Apr 3, 2024 at 2:50=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@g=
mail.com> wrote: =20
> >> On 02/04/2024 00:16, David Lechner wrote: =20
> >>> On Mon, Apr 1, 2024 at 2:37=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote: =20
> >>>> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> >>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote: =20
> >>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>>>> =20
> >> ...
> >> =20
> >>>>>      properties:
> >>>>>        reg:
> >>>>> +        description:
> >>>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 cu=
rrent channels.
> >>>>>          minimum: 0
> >>>>> -        maximum: 15
> >>>>> +        maximum: 19 =20
> >>>> This looks wrong. Isn't reg describing the number of logical channels
> >>>> (# of channel config registers)?
> >>>>
> >>>> After reviewing the driver, I see that > 16 is used as a way of
> >>>> flagging current inputs, but still seems like the wrong way to do it.
> >>>> See suggestion below.
> >>>> =20
> >>>>>        diff-channels:
> >>>>> +        description:
> >>>>> +          For using current channels specify only the positive cha=
nnel.
> >>>>> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0> =20
> >>>> I find this a bit confusing since 2 is already VIN2 and 0 is already
> >>>> VIN0. I think it would make more sense to assign unique channel
> >>>> numbers individually to the negative and positive current inputs.
> >>>> Also, I think it makes sense to use the same numbers that the
> >>>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> >>>> positive).
> >>>>
> >>>> So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10> =20
> >>> Thinking about this a bit more...
> >>>
> >>> Since the current inputs have dedicated pins and aren't mix-and-match
> >>> with multiple valid wiring configurations like the voltage inputs, do
> >>> we even need to describe them in the devicetree?
> >>>
> >>> In the driver, the current channels would just be hard-coded like the
> >>> temperature channel since there isn't any application-specific
> >>> variation. =20
> >>  Sure, but we still need to offer the user a way to configure which
> >> current inputs he wants and if they should use bipolar or unipolar cod=
ing. =20
> > From the datasheet, it looks like only positive current input is
> > allowed so I'm not sure bipolar applies here. But, yes, if there is
> > some other variation in wiring or electrical signal that needs to be
> > describe here, then it makes sense to allow a channel configuration
> > node for it. =20
>=20
> AD4111 datasheet pg.29:
> When the ADC is configured for bipolar operation, the output
> code is offset binary with a negative full-scale voltage resulting
> in a code of 000 =E2=80=A6 000, a zero differential input voltage resulti=
ng in
> a code of 100 =E2=80=A6 000, and a positive full-scale input voltage
> resulting in a code of 111 =E2=80=A6 111. The output code for any
> analog input voltage can be represented as
> Code =3D 2^(N =E2=80=93 1) =C3=97 ((V_IN =C3=97 0.1/V REF) + 1)
> The output code for any input current is represented as
> Code =3D 2^(N =E2=88=92 1) =C3=97 ((I_IN =C3=97 50 =CE=A9/V REF) + 1)
>=20
> I would say bipolar applies here, not a great idea because of the limitat=
ion on
>  the negative side (Input Current Range min:=E2=88=920.5 max:+24 mA) so s=
till, the option
>  is available.
Just to check I am correct in thinking you 'might' use bipolar if you want
to be able to measure small negative currents, but the range is much larger
in the positive direction?

J
>=20


