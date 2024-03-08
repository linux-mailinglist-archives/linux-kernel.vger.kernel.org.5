Return-Path: <linux-kernel+bounces-96597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4C875EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4631C2202D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85D4F891;
	Fri,  8 Mar 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gLlv8wGx"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19262C1A0;
	Fri,  8 Mar 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883746; cv=none; b=ArhYVKkI+ebWTGT+usUxXc6JPQOIkrdMHStZYkj/+gPA8Quy0nTGUfhxNE+p+ABQblbYQ4hC9P0sV/+q5kXaTfQFMQCv6Qyg0saTAo0YaLUD05m6EvD/wgSLk1BW6MbcUNrSddqiLUTbXOBfDOO8riIdkx+6N7BRBQdDGY9TWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883746; c=relaxed/simple;
	bh=TTtXyo/DiJN4A3MwPEwDAd8UEfHq/A17ZdBZkYFdH/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvYv1ovA23VffG3LNzwsR4P6Y30saZ+BoN9/yfuug65ELa355I9cUC4QdM8BPxyYrLiiD6EQjXx46Nvev+YxvFQ6jejj65nIP+zuuM8t5zTV2323DhRN6rracZp0ucLRpB7luPtvhUMdQtA/d1Bn6PV4L5zF8Lid/RaCXHyKIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gLlv8wGx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBB4760005;
	Fri,  8 Mar 2024 07:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709883735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkispZ2cSgHHvQHUKtQPYvm4JRgYfxl+31ZzbV0ajJQ=;
	b=gLlv8wGxjiogeG9C46oG5EgFoqN4SH1b9sabNz5g3QO62yEOKg3XJIQW0hFi2a4mlTo9/J
	wDoyd7Ks0a9nOehGgDBetroeoVaVTpjSUCvwUdrENEVJ9GDuL1UA1UNTIwOIUkdVv7PDl0
	HLNnzR8Dn0hQvEKvIyQYWURylmHBn7971Bw1G7BDNxLq55CYjsQOW+BxO91WXoQ2oMPJVa
	BRg5CV53PmNRQlKzjl1MjxvhcrVmwlRk7/L9gakI8vPJfBh17Jt0/24YwSwpQHdYgAzNV6
	1MSXvZT0koXMkeBdc5LURUgoUaMY53WPEDVkI+xX8/0aO6DbnEZN41o86mVc5A==
Date: Fri, 8 Mar 2024 08:42:12 +0100
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
Message-ID: <20240308084212.4aa58761@xps-13>
In-Reply-To: <CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
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

sjg@chromium.org wrote on Fri, 8 Mar 2024 15:44:25 +1300:

> Hi Miquel,
>=20
> On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
> >
> > Hi Simon,
> > =20
> > > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > > +  The binman node provides a layout for firmwa=
re, used when packaging firmware
> > > > > > > > > > > > > > +  from multiple projects. It is based on fixed=
-partitions, with some
> > > > > > > > > > > > > > +  extensions, but uses 'compatible' to indicat=
e the contents of the node, to
> > > > > > > > > > > > > > +  avoid perturbing or confusing existing insta=
llations which use 'label' for a
> > > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +  Binman supports properties used as inputs to=
 the firmware-packaging process,
> > > > > > > > > > > > > > +  such as those which control alignment of par=
titions. This binding addresses
> > > > > > > > > > > > > > +  these 'input' properties. For example, it is=
 common for the 'reg' property
> > > > > > > > > > > > > > +  (an 'output' property) to be set by Binman, =
based on the alignment requested
> > > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +  Once processing is complete, input propertie=
s have mostly served their
> > > > > > > > > > > > > > +  purpose, at least until the firmware is repa=
cked later, e.g. due to a
> > > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' bind=
ing should provide enough
> > > > > > > > > > > > > > +  information to read the firmware at runtime,=
 including decompression if
> > > > > > > > > > > > > > +  needed. =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > How is this going to work exactly? binman reads t=
hese nodes and then
> > > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you=
've lost the binman
> > > > > > > > > > > > > specifc parts needed for repacking. =20
> > > > > > > > > > > >
> > > > > > > > > > > > No, they are the same node. I do want the extra inf=
ormation to stick
> > > > > > > > > > > > around. So long as it is compatible with fixed-part=
ition as well, this
> > > > > > > > > > > > should work OK. =20
> > > > > > > > > > >
> > > > > > > > > > > How can it be both? The partitions node compatible ca=
n be either
> > > > > > > > > > > 'fixed-partitions' or 'binman'. =20
> > > > > > > > > >
> > > > > > > > > > Can we not allow it to be both? I have tried to adjust =
things in
> > > > > > > > > > response to feedback but perhaps the feedback was leadi=
ng me down the
> > > > > > > > > > wrong path? =20
> > > > > > > > >
> > > > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > > > fixed-partitions. =20
> > > > > > > >
> > > > > > > > Can we cross that bridge later? There might be resistance t=
o it. I'm
> > > > > > > > not sure. For now, perhaps just a binman compatible works w=
ell enough
> > > > > > > > to make progress. =20
> > > > > > >
> > > > > > > Is there any way to make progress on this? I would like to ha=
ve
> > > > > > > software which doesn't understand the binman compatible to at=
 least be
> > > > > > > able to understand the fixed-partition compatible. Is that ac=
ceptable? =20
> > > > > >
> > > > > > There's only 2 ways that it can work. Either binman writes out
> > > > > > fixed-partition nodes dropping/replacing anything only defined =
for
> > > > > > binman or fixed-partition is extended to include what binman ne=
eds. =20
> > > > >
> > > > > OK, then I suppose the best way is to add a new binman compatible=
, as
> > > > > is done with this v6 series. People then need to choose it instea=
d of
> > > > > fixed-partition. =20
> > > >
> > > > I'm sorry this is not at all what Rob suggested, or did I totally
> > > > misunderstand his answer?
> > > >
> > > > In both cases the solution is to generate a "fixed-partition" node.=
 Now
> > > > up to you to decide whether binman should adapt the output to the
> > > > current schema, or if the current schema should be extended to
> > > > understand all binman's output.
> > > >
> > > > At least that is my understanding and also what I kind of agree wit=
h. =20
> > >
> > > I do want to binman schema to include all the features of Binman.
> > >
> > > So are you saying that there should not be a 'binman'  schema, but I
> > > should just add all the binman properties to the fixed-partition
> > > schema? =20
> >
> > This is my current understanding, yes. But acknowledgment from Rob is
> > also welcome. =20
>=20
> I am trying again to wade through all the confusion here.
>=20
> There is not actually a 'fixed-partition' node. So are you saying I
> should add one? There is already a 'partitions' node. Won't they
> conflict?

Sorry for the confusion, there is a 'partitions' node indeed. This
node shall declare it's "programming model" (let's say), ie. how it
should be parsed. What defines this programming model today is the
'fixed-partitions' compatible. I think we (Rob and myself, but again,
Rob, please confirm) agree on the fact that we don't want to duplicate
the fixed-partitions compatible/logic and thus the binman compatible
was rejected.

Hence, in order to move forward, I would definitely appreciate an
update of the fixed-partitions binding in order to support what binman
can generate.

We are here talking about the output of binman, not its input. TBH I
haven't understood the point in having binman's input parsed by the
generic yaml binding. I would advise to focus on binman's output first
because it feels more relevant, at a first glance.

> Would it be possible for you to look at my patches and suggest
> something? I think at this point, after so many hours of trying
> different things and trying to understand what is needed, I could
> really use a little help.

I hope the above details will help.

Thanks,
Miqu=C3=A8l

