Return-Path: <linux-kernel+bounces-52165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806578494DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E7B1F213A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD410A33;
	Mon,  5 Feb 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DZZxgC3z"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC011188;
	Mon,  5 Feb 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119463; cv=none; b=RdQMIs2hwDs4jEcwmrgQIVP0uyBFQVb2nfBuQYnIz/2CTGCkzkoIDsJbtMXTq2NnXErM1jpG8IMVksuF2rSYpkDEWTgIIGsn+E3o5lE1xMYLpdy7kjc1z33x38gLob+5FRsntz9cXQQoEEnCjnMqX3Jxaq6oP8JaQqcgfIHcj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119463; c=relaxed/simple;
	bh=S2xBjKjY1LGTJgJd4nXlaZSTeDejAJKnqwuXSuZsozM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abveTzxqnAYfcopIzIVuQB9VQ6AHXka3X4+QmWKDaDQclZqFWassclLDdz1BZn3By7vC7eZjc9o7f8Hp2Xvz1W7lOX5h4D4pBwPv92GfFDqdsF1WXLfW0nH925B4BjMIn9EE/1Oa76Is+6hl0UxbpUZwvY94RrehY9+okpMWLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DZZxgC3z; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E417260008;
	Mon,  5 Feb 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707119458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttQ4uDt0B0MWz9Y2OYBfdOsR8cq/5uUelC94dh61iTE=;
	b=DZZxgC3z/SAhCFg7Oojb3mU4qZ2BwsdhLuZ6dOWjQAMLeIDp1BQ0mP8t2g9uNe0rgLYSRZ
	fgnLj18+PZSCVUwFN77NRnXVob4ElSpA3gq5gpN1UAfcDhuVbnsCIMuYpP2vMfQObTnGBw
	IkFhfuhEFpA+sdBmkEQRKeRRIn0AsgFKYz3hjeZP6BdU688kLWionAXZ+OhV/CodiPMJz1
	CMIN2AJqk4zDYvlZqBpji8zjNLVXASZPQkHbAX4sJQ4ThzJW5VYSQKVfPWuVD22ccpuUht
	EkiHr5ribVdDq/SUp37+DAFUEDXuJOKGb/2Q9Kcdd/QqUudmJZRmbVX2kusISw==
Date: Mon, 5 Feb 2024 08:50:56 +0100
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
Message-ID: <20240205085056.44278f2c@xps-13>
In-Reply-To: <CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com>
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

sjg@chromium.org wrote on Sun, 4 Feb 2024 05:07:38 -0700:

> Hi Rob,
>=20
> On Wed, 17 Jan 2024 at 08:56, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jan 4, 2024 at 3:54=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote: =20
> > >
> > > Hi Rob,
> > >
> > > On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote: =20
> > > >
> > > > Hi Rob,
> > > >
> > > > On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote: =
=20
> > > > >
> > > > > On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote: =20
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrot=
e: =20
> > > > > > >
> > > > > > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chro=
mium.org> wrote: =20
> > > > > > > >
> > > > > > > > Hi Rob,
> > > > > > > >
> > > > > > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> =
wrote: =20
> > > > > > > > >
> > > > > > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wro=
te: =20
> > > > > > > > > > Add a compatible string for binman, so we can extend fi=
xed-partitions
> > > > > > > > > > in various ways.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v5)
> > > > > > > > > >
> > > > > > > > > > Changes in v5:
> > > > > > > > > > - Add #address/size-cells and parternProperties
> > > > > > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > > > > > - Drop 'select: false'
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - Change subject line
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Drop fixed-partition additional compatible string
> > > > > > > > > > - Drop fixed-partitions from the example
> > > > > > > > > > - Mention use of compatible instead of label
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Drop mention of 'enhanced features' in fixed-partitio=
ns.yaml
> > > > > > > > > > - Mention Binman input and output properties
> > > > > > > > > > - Use plain partition@xxx for the node name
> > > > > > > > > >
> > > > > > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++=
++++++++++++++++
> > > > > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > > > > >  MAINTAINERS                                   |  5 ++
> > > > > > > > > >  3 files changed, 74 insertions(+)
> > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/m=
td/partitions/binman.yaml
> > > > > > > > > >
> > > > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/part=
itions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binma=
n.yaml
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..329217550a98
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/=
binman.yaml
> > > > > > > > > > @@ -0,0 +1,68 @@
> > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > > > +# Copyright 2023 Google LLC
> > > > > > > > > > +
> > > > > > > > > > +%YAML 1.2
> > > > > > > > > > +---
> > > > > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binm=
an.yaml#
> > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > > +
> > > > > > > > > > +title: Binman firmware layout
> > > > > > > > > > +
> > > > > > > > > > +maintainers:
> > > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > > +
> > > > > > > > > > +description: |
> > > > > > > > > > +  The binman node provides a layout for firmware, used=
 when packaging firmware
> > > > > > > > > > +  from multiple projects. It is based on fixed-partiti=
ons, with some
> > > > > > > > > > +  extensions, but uses 'compatible' to indicate the co=
ntents of the node, to
> > > > > > > > > > +  avoid perturbing or confusing existing installations=
 which use 'label' for a
> > > > > > > > > > +  particular purpose.
> > > > > > > > > > +
> > > > > > > > > > +  Binman supports properties used as inputs to the fir=
mware-packaging process,
> > > > > > > > > > +  such as those which control alignment of partitions.=
 This binding addresses
> > > > > > > > > > +  these 'input' properties. For example, it is common =
for the 'reg' property
> > > > > > > > > > +  (an 'output' property) to be set by Binman, based on=
 the alignment requested
> > > > > > > > > > +  in the input.
> > > > > > > > > > +
> > > > > > > > > > +  Once processing is complete, input properties have m=
ostly served their
> > > > > > > > > > +  purpose, at least until the firmware is repacked lat=
er, e.g. due to a
> > > > > > > > > > +  firmware update. The 'fixed-partitions' binding shou=
ld provide enough
> > > > > > > > > > +  information to read the firmware at runtime, includi=
ng decompression if
> > > > > > > > > > +  needed. =20
> > > > > > > > >
> > > > > > > > > How is this going to work exactly? binman reads these nod=
es and then
> > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost=
 the binman
> > > > > > > > > specifc parts needed for repacking. =20
> > > > > > > >
> > > > > > > > No, they are the same node. I do want the extra information=
 to stick
> > > > > > > > around. So long as it is compatible with fixed-partition as=
 well, this
> > > > > > > > should work OK. =20
> > > > > > >
> > > > > > > How can it be both? The partitions node compatible can be eit=
her
> > > > > > > 'fixed-partitions' or 'binman'. =20
> > > > > >
> > > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > > response to feedback but perhaps the feedback was leading me do=
wn the
> > > > > > wrong path? =20
> > > > >
> > > > > Sure, but then the schema has to and that means extending
> > > > > fixed-partitions. =20
> > > >
> > > > Can we cross that bridge later? There might be resistance to it. I'm
> > > > not sure. For now, perhaps just a binman compatible works well enou=
gh
> > > > to make progress. =20
> > >
> > > Is there any way to make progress on this? I would like to have
> > > software which doesn't understand the binman compatible to at least be
> > > able to understand the fixed-partition compatible. Is that acceptable=
? =20
> >
> > There's only 2 ways that it can work. Either binman writes out
> > fixed-partition nodes dropping/replacing anything only defined for
> > binman or fixed-partition is extended to include what binman needs. =20
>=20
> OK, then I suppose the best way is to add a new binman compatible, as
> is done with this v6 series. People then need to choose it instead of
> fixed-partition.

I'm sorry this is not at all what Rob suggested, or did I totally
misunderstand his answer?

In both cases the solution is to generate a "fixed-partition" node. Now
up to you to decide whether binman should adapt the output to the
current schema, or if the current schema should be extended to
understand all binman's output.

At least that is my understanding and also what I kind of agree with.

Thanks,
Miqu=C3=A8l

