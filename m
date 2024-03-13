Return-Path: <linux-kernel+bounces-101179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF787A3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF711C211CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F48171AC;
	Wed, 13 Mar 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SC2JTsVY"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3B12E54;
	Wed, 13 Mar 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315355; cv=none; b=TNnZrLRqt5GZ88yuZ4knHNA4TilIxlfMFXbxo10c2exOZXedQmDo9Gl6V6+sFMy/rETcpWLma5cZk7zMwRx7KEBGBblMWSQleNBv3/I2ki0PjoVOxQoI3h5CKn+HBh21m/3cuLl74y55ffI43R8Z2+o6mq5M5aUVWF8Ml4Ume1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315355; c=relaxed/simple;
	bh=AyTOZURiTOZHoYDRSeqeNuQut4lpLeLWEGaIHevlxA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhbmVvRqZlMV85BLzqoCscojQSqZwzlICxng9s0f3zDSc1ARcFHPZ8NufcAcm5NfYvq0mtNzP9lzl1wwGywz6XBwWKUbOPZ8CqfcsvNtlduuHjEdzol+bHb0M4I1Q6ZpXp14zz0vC21X3glCcSPyPrKKdpZiw7UGQfanTjyPXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SC2JTsVY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAFD9E0004;
	Wed, 13 Mar 2024 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710315344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMY+XSNXJZpg0rP2ibnjQyP7ikTmYekL+OvsMizJktY=;
	b=SC2JTsVYdRQQzQRyp1HfcYeCNZfGOnai6gE4a/oOVnTCpgJ7JjvBrEpcPek5xOMshAloN7
	5gMjiGsMGaK0VSUmq18DQ1VFJbOeTm35XRH3LndnsqKeTF3VOQoMJC4/lpWwXS7eI2e6ch
	KE3mR0d96+m6a0g5iUMy9/KhAX/m3tpA/xPmVUNr7jbz5yf8GGskzGcyacVGQgCaK3jQFf
	I4DQWNrjwlb87sV6thFp+5f/4Q9Coh3cCZ3VKfGHqxc2i7dAHfwxeBl0cl8oQ5Vakn1rF4
	GP/t7uutcpv3ul9thYuu0XT2Gc/NycMtQ9kdALHLsorI9k6NUZXYqwJpUrMA0g==
Date: Wed, 13 Mar 2024 08:35:41 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, Michael Walle
 <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman
 compatible
Message-ID: <20240313083541.1e7d4a2f@xps-13>
In-Reply-To: <CAFLszTi8w4gBoa-6uoKUN-Ng07ieA+DXy3gm2cdxfwgAybrgsQ@mail.gmail.com>
References: <20231116172859.393744-1-sjg@chromium.org>
	<20231208150042.GA1278773-robh@kernel.org>
	<CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
	<CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
	<CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
	<20231214172702.GA617226-robh@kernel.org>
	<CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
	<CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
	<CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
	<CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com>
	<20240205085056.44278f2c@xps-13>
	<CAFLszTi+8ygXOidnhxj7sdJwc6X5i+++QvnUyfe-kde5eSts_w@mail.gmail.com>
	<20240205131755.3462084f@xps-13>
	<CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
	<20240308084212.4aa58761@xps-13>
	<CAFLszTi8w4gBoa-6uoKUN-Ng07ieA+DXy3gm2cdxfwgAybrgsQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Simon,

sjg@chromium.org wrote on Wed, 13 Mar 2024 11:25:42 +1300:

> Hi Miquel,
>=20
> On Fri, 8 Mar 2024 at 20:42, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
> >
> > Hi Simon,
> >
> > sjg@chromium.org wrote on Fri, 8 Mar 2024 15:44:25 +1300:
> > =20
> > > Hi Miquel,
> > >
> > > On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote: =20
> > > >
> > > > Hi Simon,
> > > > =20
> > > > > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > > > > +  The binman node provides a layout for fi=
rmware, used when packaging firmware
> > > > > > > > > > > > > > > > +  from multiple projects. It is based on f=
ixed-partitions, with some
> > > > > > > > > > > > > > > > +  extensions, but uses 'compatible' to ind=
icate the contents of the node, to
> > > > > > > > > > > > > > > > +  avoid perturbing or confusing existing i=
nstallations which use 'label' for a
> > > > > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +  Binman supports properties used as input=
s to the firmware-packaging process,
> > > > > > > > > > > > > > > > +  such as those which control alignment of=
 partitions. This binding addresses
> > > > > > > > > > > > > > > > +  these 'input' properties. For example, i=
t is common for the 'reg' property
> > > > > > > > > > > > > > > > +  (an 'output' property) to be set by Binm=
an, based on the alignment requested
> > > > > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +  Once processing is complete, input prope=
rties have mostly served their
> > > > > > > > > > > > > > > > +  purpose, at least until the firmware is =
repacked later, e.g. due to a
> > > > > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' =
binding should provide enough
> > > > > > > > > > > > > > > > +  information to read the firmware at runt=
ime, including decompression if
> > > > > > > > > > > > > > > > +  needed. =20
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > How is this going to work exactly? binman rea=
ds these nodes and then
> > > > > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then=
 you've lost the binman
> > > > > > > > > > > > > > > specifc parts needed for repacking. =20
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > No, they are the same node. I do want the extra=
 information to stick
> > > > > > > > > > > > > > around. So long as it is compatible with fixed-=
partition as well, this
> > > > > > > > > > > > > > should work OK. =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > How can it be both? The partitions node compatibl=
e can be either
> > > > > > > > > > > > > 'fixed-partitions' or 'binman'. =20
> > > > > > > > > > > >
> > > > > > > > > > > > Can we not allow it to be both? I have tried to adj=
ust things in
> > > > > > > > > > > > response to feedback but perhaps the feedback was l=
eading me down the
> > > > > > > > > > > > wrong path? =20
> > > > > > > > > > >
> > > > > > > > > > > Sure, but then the schema has to and that means exten=
ding
> > > > > > > > > > > fixed-partitions. =20
> > > > > > > > > >
> > > > > > > > > > Can we cross that bridge later? There might be resistan=
ce to it. I'm
> > > > > > > > > > not sure. For now, perhaps just a binman compatible wor=
ks well enough
> > > > > > > > > > to make progress. =20
> > > > > > > > >
> > > > > > > > > Is there any way to make progress on this? I would like t=
o have
> > > > > > > > > software which doesn't understand the binman compatible t=
o at least be
> > > > > > > > > able to understand the fixed-partition compatible. Is tha=
t acceptable? =20
> > > > > > > >
> > > > > > > > There's only 2 ways that it can work. Either binman writes =
out
> > > > > > > > fixed-partition nodes dropping/replacing anything only defi=
ned for
> > > > > > > > binman or fixed-partition is extended to include what binma=
n needs. =20
> > > > > > >
> > > > > > > OK, then I suppose the best way is to add a new binman compat=
ible, as
> > > > > > > is done with this v6 series. People then need to choose it in=
stead of
> > > > > > > fixed-partition. =20
> > > > > >
> > > > > > I'm sorry this is not at all what Rob suggested, or did I total=
ly
> > > > > > misunderstand his answer?
> > > > > >
> > > > > > In both cases the solution is to generate a "fixed-partition" n=
ode. Now
> > > > > > up to you to decide whether binman should adapt the output to t=
he
> > > > > > current schema, or if the current schema should be extended to
> > > > > > understand all binman's output.
> > > > > >
> > > > > > At least that is my understanding and also what I kind of agree=
 with. =20
> > > > >
> > > > > I do want to binman schema to include all the features of Binman.
> > > > >
> > > > > So are you saying that there should not be a 'binman'  schema, bu=
t I
> > > > > should just add all the binman properties to the fixed-partition
> > > > > schema? =20
> > > >
> > > > This is my current understanding, yes. But acknowledgment from Rob =
is
> > > > also welcome. =20
> > >
> > > I am trying again to wade through all the confusion here.
> > >
> > > There is not actually a 'fixed-partition' node. So are you saying I
> > > should add one? There is already a 'partitions' node. Won't they
> > > conflict? =20
> >
> > Sorry for the confusion, there is a 'partitions' node indeed. This
> > node shall declare it's "programming model" (let's say), ie. how it
> > should be parsed. What defines this programming model today is the
> > 'fixed-partitions' compatible. I think we (Rob and myself, but again,
> > Rob, please confirm) agree on the fact that we don't want to duplicate
> > the fixed-partitions compatible/logic and thus the binman compatible
> > was rejected.
> >
> > Hence, in order to move forward, I would definitely appreciate an
> > update of the fixed-partitions binding in order to support what binman
> > can generate. =20
>=20
> OK, so I think my confusion is that I thought you were referring to a
> 'partitions' compatible. But you are just referring to the name of the
> node being 'partitions', with the compatible string being
> 'fixed-partitions'.

Yes.

>=20
> I believe I can make this work by adding a new 'binman.yaml' with the
> compatibles that I want to introduce. I cannot change partition.yaml
> since it does not itself specify a compatible.

What about fixed-partitions.ymal? The yaml file name should match the
compatible.

> > We are here talking about the output of binman, not its input. TBH I
> > haven't understood the point in having binman's input parsed by the
> > generic yaml binding. I would advise to focus on binman's output first
> > because it feels more relevant, at a first glance. =20
>=20
> Yes that is fine.
>=20
> > =20
> > > Would it be possible for you to look at my patches and suggest
> > > something? I think at this point, after so many hours of trying
> > > different things and trying to understand what is needed, I could
> > > really use a little help. =20
> >
> > I hope the above details will help. =20
>=20
> I think so, thank you. I will send another version.
>=20
> Regards,
> Simon


Thanks,
Miqu=C3=A8l

