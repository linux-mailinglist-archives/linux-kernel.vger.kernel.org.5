Return-Path: <linux-kernel+bounces-129408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E346D896A47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203A21C23070
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50071B3B;
	Wed,  3 Apr 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lkHzq6+j"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B456471;
	Wed,  3 Apr 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135762; cv=none; b=OwAXwDPsEqQc3jbOqL/19EZ2rp9gmkFrOb6xDXIPDBGb+Khq/LYrmjaPvmHdLSxeqQSsFkNCgvKUxGfTTe753Q3AZaTIFJBipDq5uPEpbNJS5+iGDJy9k+4kUJqfxgJZHJxGUIcPjf1djcG01iyU4GEvdaU9w0c3htM82SZemDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135762; c=relaxed/simple;
	bh=+8Uaj5iMPA4wsnMkfm+EfD8CPE0onEGyhG1BVrPx97g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPab0QaHvZQOKX9iV/AwvJazlBE+9I9ldphXoOL9v4DKpq3MN2Xgrb8yoZ46MCzgr7PAXbIAAhEp1VGEqLdeBBAfcNbl1AGONb//vTuDls/A9McSmcRIumR3C009TcseZvGdzHDQqQ5SR1U6B3/k98g+MRp2EaVK1dcvQxHs4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lkHzq6+j; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E8B82000A;
	Wed,  3 Apr 2024 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712135750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23YFb2E46Qkl4R91FdBc+xUfghupTFRI0Hd3AgYoG18=;
	b=lkHzq6+j2/DDtgVj31zpfNMAJMxPg8yOn6qPzCqx2wTw1MBtHZhSyG6kqwrPVGg4ePO5Iz
	NcZNNtS36kSkNIvvgqYCeDwaOGJGcf8B5mkrbSm9GgEvwCazDieF0gaM3p5XSbyHVw683q
	/HfOjD2j9oKDg3k8h9EWluISvPIKeVbuZkPS8sE2ToGsJPjdXgL9FiAHMIbHmy61j2d5na
	1OjxlQ49bUIxVhqBXh377Rtxyhf3yuZ/Wi15mTnbWSc1BwM9h7eka7YjPYU76uj2q3+qxS
	P8eUZu8rRhE47xMgp/h8bGaVtaIJPCstKCD+tsXh6Bkooi/nD4WJBWh9AwgwPQ==
Date: Wed, 3 Apr 2024 11:15:48 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240403111548.30e780b5@kmaincent-XPS-13-7390>
In-Reply-To: <20240402132637.GA3744978-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
	<20240402132637.GA3744978-robh@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 2 Apr 2024 08:26:37 -0500
Rob Herring <robh@kernel.org> wrote:

> > +          pairset-names:
> > +            $ref: /schemas/types.yaml#/definitions/string-array
> > +            description:
> > +              Names of the pairsets as per IEEE 802.3-2022, Section
> > 145.2.4.
> > +              Valid values are "alternative-a" and "alternative-b". Ea=
ch
> > name =20
>=20
> Don't state constraints in prose which are defined as schema=20
> constraints.

Ok, I will remove the line.

> > +          pairsets:
> > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > +            description:
> > +              List of phandles, each pointing to the power supply for =
the
> > +              corresponding pairset named in 'pairset-names'. This pro=
perty
> > +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table
> > 145\u20133)
> > +
> > |-----------|---------------|---------------|---------------|----------=
-----|
> > +              | Conductor | Alternative A | Alternative A | Alternativ=
e B
> > | Alternative B |
> > +              |           |    (MDI-X)    |     (MDI)     |      (X)
> > |      (S)      |
> > +
> > |-----------|---------------|---------------|---------------|----------=
-----|
> > +              | 1         | Negative VPSE | Positive VPSE | \u2014
> >     | \u2014             |
> > +              | 2         | Negative VPSE | Positive VPSE | \u2014
> >     | \u2014             |
> > +              | 3         | Positive VPSE | Negative VPSE | \u2014
> >     | \u2014             |
> > +              | 4         | \u2014             | \u2014             |
> > Negative VPSE | Positive VPSE |
> > +              | 5         | \u2014             | \u2014             |
> > Negative VPSE | Positive VPSE |
> > +              | 6         | Positive VPSE | Negative VPSE | \u2014
> >     | \u2014             |
> > +              | 7         | \u2014             | \u2014             |
> > Positive VPSE | Negative VPSE |
> > +              | 8         | \u2014             | \u2014             |
> > Positive VPSE | Negative VPSE |
> > +            minItems: 1
> > +            maxItems: 2 =20
>=20
> "pairsets" does not follow the normal design pattern of foos, foo-names,=
=20
> and #foo-cells. You could add #foo-cells I suppose, but what would cells=
=20
> convey? I don't think it's a good fit for what you need.
>=20
> The other oddity is the number of entries and the names are fixed. That=20
> is usually defined per consumer.=20

Theoretically if the RJ45 port binding was supported it would make more sen=
se,
but in reality it's not feasible as the PSE controller need this information
in its init process.
The PSE controller reset all its port to apply a configuration so we can't =
do
it when the consumer (RJ45) probe. It would reset the other ports if one
consumer is probed later in the process.

> As each entry is just a power rail, why can't the regulator binding be=20
> used here?

Olekisj already answered about it.
PSE PI is like a regulator but with few different features and more informa=
tion
like the pinout and the polarity, so we could not really fully rely on the
regulator binding style.

> > +
> > +          polarity-supported:
> > +            $ref: /schemas/types.yaml#/definitions/string-array
> > +            description:
> > +              Polarity configuration supported by the PSE PI pairsets.
> > +            minItems: 1
> > +            maxItems: 4
> > +            items:
> > +              enum:
> > +                - MDI-X
> > +                - MDI
> > +                - X
> > +                - S
> > +
> > +          vpwr-supply:
> > +            description: Regulator power supply for the PSE PI. =20
>=20
> I don't see this being used anywhere.

Right, I forgot to add it to the PD692x0 and TPS23881 binding example!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

