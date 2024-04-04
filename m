Return-Path: <linux-kernel+bounces-131118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFE89834A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CCE1F2984D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCE71B3A;
	Thu,  4 Apr 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NFt5iasf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5B2134A;
	Thu,  4 Apr 2024 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219944; cv=none; b=FtX0IwMJjD6XOtH8+FOmV+b1hDNJcU4Mh6e0IP0e5aTEnahAU90zzcK66qml0yYMI1McIC+J1pIdWIHvAvhxEs0rMXM9vy6TGkPeR1eKYcOnFqy0x9/m08c6dWjCzWXnCdvTvGpg/WXRc9SItxJICje9LkcW6Kf8Vj+BQfRB1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219944; c=relaxed/simple;
	bh=NsO+UaJBprZElwpaChh8YhCzSfoqK0pR4nEa/PQxt9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUa8gVVfzCJRJ786S+y3TYX+JIOvXdpNqa6dCzRQzRRIO/8NlrBj7ly1UfsWBxKfqwtTFzuPcNO9N3FD0FOe0Zyt8ggypUX/9KLIN5UQLXLtxY5J0sxiSVTyYYlIHWXJSoJmUnPdDoSW2NHVjtN9TtniBla/zTlEsw5T2eMvYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NFt5iasf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F4E0E0005;
	Thu,  4 Apr 2024 08:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712219939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAmpL8vsX5KgArp9IvAY0m85YPH50TlrPGvCXKaUhig=;
	b=NFt5iasfPklTMwMaNn0kBGOxNPcCFEWRQ1NfQj9aKtWhmcw0kKqYyP0SL2FqsZlK8qOsZ9
	92A1yTA06WS5jARRoktHosOBhKzUjpfsGR/hxO9CiC/fnk8JWe4HURmil/reMTIllGXkxT
	dOxBZDXiG6kzngRLJtY5Isrepe+Aeb8dWxh9+t/aqy6HugDGT4Dc1mnIZyXxjMZvOk9KTl
	/38ey+Ds/3f0tXAgeFSJz5VDH4A0iiWGIVuEIAEj5gEdioNAiGHLJBZkSgVK73SvpCVFD3
	XwqLQeB93ACFC6DH7vOT5DN7uW/JrzWJVz3EETRafgUb+nSBkk5aTitUVzNh0g==
Date: Thu, 4 Apr 2024 10:38:54 +0200
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
Message-ID: <20240404103854.29ef418c@kmaincent-XPS-13-7390>
In-Reply-To: <20240403143142.GA3508225-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
	<20240402132637.GA3744978-robh@kernel.org>
	<20240403111548.30e780b5@kmaincent-XPS-13-7390>
	<20240403143142.GA3508225-robh@kernel.org>
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

On Wed, 3 Apr 2024 09:31:42 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Apr 03, 2024 at 11:15:48AM +0200, Kory Maincent wrote:
> > On Tue, 2 Apr 2024 08:26:37 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >  =20
> > > > +          pairset-names:
> > > > +            $ref: /schemas/types.yaml#/definitions/string-array
> > > > +            description:
> > > > +              Names of the pairsets as per IEEE 802.3-2022, Section
> > > > 145.2.4.
> > > > +              Valid values are "alternative-a" and "alternative-b".
> > > > Each name   =20
> > >=20
> > > Don't state constraints in prose which are defined as schema=20
> > > constraints. =20
> >=20
> > Ok, I will remove the line.
> >  =20
> > > > +          pairsets:
> > > > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +            description:
> > > > +              List of phandles, each pointing to the power supply =
for
> > > > the
> > > > +              corresponding pairset named in 'pairset-names'. This
> > > > property
> > > > +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.=
2.4.
> > > > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table
> > > > 145\u20133)
> > > > +
> > > > |-----------|---------------|---------------|---------------|------=
---------|
> > > > +              | Conductor | Alternative A | Alternative A |
> > > > Alternative B | Alternative B |
> > > > +              |           |    (MDI-X)    |     (MDI)     |      (=
X)
> > > > |      (S)      |
> > > > +
> > > > |-----------|---------------|---------------|---------------|------=
---------|
> > > > +              | 1         | Negative VPSE | Positive VPSE | \u2014
> > > >     | \u2014             |
> > > > +              | 2         | Negative VPSE | Positive VPSE | \u2014
> > > >     | \u2014             |
> > > > +              | 3         | Positive VPSE | Negative VPSE | \u2014
> > > >     | \u2014             |
> > > > +              | 4         | \u2014             | \u2014           =
  |
> > > > Negative VPSE | Positive VPSE |
> > > > +              | 5         | \u2014             | \u2014           =
  |
> > > > Negative VPSE | Positive VPSE |
> > > > +              | 6         | Positive VPSE | Negative VPSE | \u2014
> > > >     | \u2014             |
> > > > +              | 7         | \u2014             | \u2014           =
  |
> > > > Positive VPSE | Negative VPSE |
> > > > +              | 8         | \u2014             | \u2014           =
  |
> > > > Positive VPSE | Negative VPSE |
> > > > +            minItems: 1
> > > > +            maxItems: 2   =20
> > >=20
> > > "pairsets" does not follow the normal design pattern of foos, foo-nam=
es,=20
> > > and #foo-cells. You could add #foo-cells I suppose, but what would ce=
lls=20
> > > convey? I don't think it's a good fit for what you need.
> > >=20
> > > The other oddity is the number of entries and the names are fixed. Th=
at=20
> > > is usually defined per consumer.  =20
> >=20
> > Theoretically if the RJ45 port binding was supported it would make more
> > sense, but in reality it's not feasible as the PSE controller need this
> > information in its init process.
> > The PSE controller reset all its port to apply a configuration so we ca=
n't
> > do it when the consumer (RJ45) probe. It would reset the other ports if=
 one
> > consumer is probed later in the process. =20
>=20
> There is no reason other than convenience that all information some=20
> driver needs has to be in one node or one hierarchy of nodes. You can=20
> fetch anything from anywhere in the DT. It does feel like some of this=20
> belongs in a connector node. We often haven't described connectors in DT=
=20
> and stick connector properties in the controller node associated with=20
> the connector. Then as things get more complicated, it becomes a mess.=20

Right, we could indeed put all the informations of the pse_pi node in the f=
uture
RJ45 port abstraction node. Then, this series will be put aside until we ma=
nage
to have the port abstraction get merged.
I am not glad about this as it will stuck my work until then, but indeed
removing this pse_pi wrapper node which is between the pse_controller node =
and
the connector node seems cleaner.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

