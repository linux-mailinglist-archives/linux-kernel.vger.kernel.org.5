Return-Path: <linux-kernel+bounces-52584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BD8499EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2F1F280F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F401A587;
	Mon,  5 Feb 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BnEbuHmr"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBB1BF3C;
	Mon,  5 Feb 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135482; cv=none; b=E86eSZ7LI+sSy33KVJRhTECibBsrEMVleJv2Bo/JKH0WMEacUtn64CrxQaPfaWM4z+NyWpufIyxSlrIA+JQiexS5vAyTJ0S1M4ZPfWQVUAIB+OrvA9RaW7kMdiQ2jII8Ct7nGi+IUs5ZtEPxfPxlLqNqeZsPjn5SdUsMvIg6VjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135482; c=relaxed/simple;
	bh=pY7XHYnoI+4w+LAAZtriOctiu2kUF5CNl3eTZWfJumg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8z4qGbJquWb/aOLj9uL14CKDBAM8GfT6uKCUR3nhsznV3o27z63cMbMJr6ckIiHHHajjDk6cm4NkWemkfDW5DJ1CrguDU0nT83b0/dlYSDEaMdeYLhY/3xpe1OO6o+PHIz9xez0kqTVYczmBDuWxURynvKZF4muYeW19MVPtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BnEbuHmr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52612240002;
	Mon,  5 Feb 2024 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707135477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+evZiLiKD7b5CexFbHLoJ/nJKE/+uE1gXiR+q3+Wjw=;
	b=BnEbuHmrgDWYV4Zwx4pHhHb3Ef7KcMKvOrrZ3+iq0AlT6UzxQe6TSa5R+imYuJy+U2bXIU
	a+QR5CQQc6wC3mNcshL90wOLjj9XtlN/9ES/waKZElJwZmkMK3wbSyFpi0iF3RFaYeI0c7
	3qHtNNtiOVMvIfRHQFVm8m+A378FLmy2D7C/hVAIujzXfWkJaojaMCzCMATuwLF4bGvxHF
	3tcSOVVUN47ZwjomCKVhHj4/GtFvlbgMzOh7AT+jic5X2ZO7o52QWvFjOlSmH5PXhhjp/Q
	Urp2dzCUeAdb4lpNuvf5W6ncJCEARN691Mmkn8ydX0tWH4RVvG1sQ4szSJBLtQ==
Date: Mon, 5 Feb 2024 13:17:55 +0100
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
Message-ID: <20240205131755.3462084f@xps-13>
In-Reply-To: <CAFLszTi+8ygXOidnhxj7sdJwc6X5i+++QvnUyfe-kde5eSts_w@mail.gmail.com>
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
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

> > > > > > > > > > > > +description: |
> > > > > > > > > > > > +  The binman node provides a layout for firmware, =
used when packaging firmware
> > > > > > > > > > > > +  from multiple projects. It is based on fixed-par=
titions, with some
> > > > > > > > > > > > +  extensions, but uses 'compatible' to indicate th=
e contents of the node, to
> > > > > > > > > > > > +  avoid perturbing or confusing existing installat=
ions which use 'label' for a
> > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > +
> > > > > > > > > > > > +  Binman supports properties used as inputs to the=
 firmware-packaging process,
> > > > > > > > > > > > +  such as those which control alignment of partiti=
ons. This binding addresses
> > > > > > > > > > > > +  these 'input' properties. For example, it is com=
mon for the 'reg' property
> > > > > > > > > > > > +  (an 'output' property) to be set by Binman, base=
d on the alignment requested
> > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > +
> > > > > > > > > > > > +  Once processing is complete, input properties ha=
ve mostly served their
> > > > > > > > > > > > +  purpose, at least until the firmware is repacked=
 later, e.g. due to a
> > > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding =
should provide enough
> > > > > > > > > > > > +  information to read the firmware at runtime, inc=
luding decompression if
> > > > > > > > > > > > +  needed. =20
> > > > > > > > > > >
> > > > > > > > > > > How is this going to work exactly? binman reads these=
 nodes and then
> > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've =
lost the binman
> > > > > > > > > > > specifc parts needed for repacking. =20
> > > > > > > > > >
> > > > > > > > > > No, they are the same node. I do want the extra informa=
tion to stick
> > > > > > > > > > around. So long as it is compatible with fixed-partitio=
n as well, this
> > > > > > > > > > should work OK. =20
> > > > > > > > >
> > > > > > > > > How can it be both? The partitions node compatible can be=
 either
> > > > > > > > > 'fixed-partitions' or 'binman'. =20
> > > > > > > >
> > > > > > > > Can we not allow it to be both? I have tried to adjust thin=
gs in
> > > > > > > > response to feedback but perhaps the feedback was leading m=
e down the
> > > > > > > > wrong path? =20
> > > > > > >
> > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > fixed-partitions. =20
> > > > > >
> > > > > > Can we cross that bridge later? There might be resistance to it=
 I'm
> > > > > > not sure. For now, perhaps just a binman compatible works well =
enough
> > > > > > to make progress. =20
> > > > >
> > > > > Is there any way to make progress on this? I would like to have
> > > > > software which doesn't understand the binman compatible to at lea=
st be
> > > > > able to understand the fixed-partition compatible. Is that accept=
able? =20
> > > >
> > > > There's only 2 ways that it can work. Either binman writes out
> > > > fixed-partition nodes dropping/replacing anything only defined for
> > > > binman or fixed-partition is extended to include what binman needs.=
 =20
> > >
> > > OK, then I suppose the best way is to add a new binman compatible, as
> > > is done with this v6 series. People then need to choose it instead of
> > > fixed-partition. =20
> >
> > I'm sorry this is not at all what Rob suggested, or did I totally
> > misunderstand his answer?
> >
> > In both cases the solution is to generate a "fixed-partition" node. Now
> > up to you to decide whether binman should adapt the output to the
> > current schema, or if the current schema should be extended to
> > understand all binman's output.
> >
> > At least that is my understanding and also what I kind of agree with. =
=20
>=20
> I do want to binman schema to include all the features of Binman.
>=20
> So are you saying that there should not be a 'binman'  schema, but I
> should just add all the binman properties to the fixed-partition
> schema?

This is my current understanding, yes. But acknowledgment from Rob is
also welcome.

Thanks,
Miqu=C3=A8l

