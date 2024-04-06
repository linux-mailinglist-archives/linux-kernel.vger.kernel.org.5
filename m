Return-Path: <linux-kernel+bounces-134066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1089ACC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E236F1F215D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097114D9EC;
	Sat,  6 Apr 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UdzQFQX5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B518C1F;
	Sat,  6 Apr 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712432249; cv=none; b=bRGBs2doIQTLYKPY9RVZg0mOxs05DeF90po+6FZFOtrGg4xJBQbFEUoERFdCkfKlfTENzMSQoa+OPbQguq0JcNWk4L2zdl3JOETy/JvZ6Q1OWv5t9q91AOZ3F3G3QeMkhdPYUCxhQnpsH6T/PXpU0WfglGGA7z6L/XdxLIDRJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712432249; c=relaxed/simple;
	bh=1yTZEU/vJ9V2y1oczGyBe2jTqiaJrhR2iH2mxRx3bDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Himnn4sGbZSttw5iViLrFZWkTFW19DncdVDx6s8TCZZKo/0M9g8sboHmRZ/xBKPgQJxMSA9X1LTaYz+AOXaqag6WaEWYL20ztKOA6rtCA0CW8W1KSvd+ZZYBjBAK6UncB+eLNmgzsmcdHl9lV60lIwjgmXiVHxVEwP594TpW8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UdzQFQX5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CE9820004;
	Sat,  6 Apr 2024 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712432237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMOotppbw75EKHyjwTmpQRZSaQ2VgCtSbhNhN302GVw=;
	b=UdzQFQX5ibpVLlHAcPf9Ypzu2EbOUUi7Wo62tQqki8HQ9pXyvkSrxloO6B0P1jh0fIKyyh
	YgC1ay1ENafKx0rOOBvioAMHmgDM/7RQlOBuTwY4nIibUPXaWyeaQK3+6d+NZ9sgewUjQR
	5gCEhPYMpcw1sUQWYTCd3HcSanhx8Qpv5gkjdoQKWxUJ8BK+R8wWalZULmHyDxLNPg1VMk
	OF7YbjEMI/vauLqAw/XEuXi7FbROB/zKBaZb/VpV3RWPAnjfQGmC3EGiBxs/JlKSuA3Pvo
	vl+XO+ph8EFKa82E5XWW6K7v+CsNeXSkBzz6nzeEq4DA1CG0r7D3zmQiJSK1iw==
Date: Sat, 6 Apr 2024 21:37:14 +0200
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
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240406213714.0ae64623@kmaincent-XPS-13-7390>
In-Reply-To: <20240404103854.29ef418c@kmaincent-XPS-13-7390>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
	<20240402132637.GA3744978-robh@kernel.org>
	<20240403111548.30e780b5@kmaincent-XPS-13-7390>
	<20240403143142.GA3508225-robh@kernel.org>
	<20240404103854.29ef418c@kmaincent-XPS-13-7390>
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

On Thu, 4 Apr 2024 10:38:54 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 3 Apr 2024 09:31:42 -0500
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Wed, Apr 03, 2024 at 11:15:48AM +0200, Kory Maincent wrote: =20
> > > On Tue, 2 Apr 2024 08:26:37 -0500
> > > Rob Herring <robh@kernel.org> wrote:
> > >    =20
> > > > > +          pairset-names:
> > > > > +            $ref: /schemas/types.yaml#/definitions/string-array
> > > > > +            description:
> > > > > +              Names of the pairsets as per IEEE 802.3-2022, Sect=
ion
> > > > > 145.2.4.
> > > > > +              Valid values are "alternative-a" and "alternative-=
b".
> > > > > Each name     =20
> > > >=20
> > > > Don't state constraints in prose which are defined as schema=20
> > > > constraints.   =20
> > >=20
> > > Ok, I will remove the line.
> > >    =20
> > > > > +          pairsets:
> > > > > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +            description:
> > > > > +              List of phandles, each pointing to the power suppl=
y for
> > > > > the
> > > > > +              corresponding pairset named in 'pairset-names'. Th=
is
> > > > > property
> > > > > +              aligns with IEEE 802.3-2022, Section 33.2.3 and
> > > > > 145.2.4.
> > > > > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Ta=
ble
> > > > > 145\u20133)
> > > > > +
> > > > > |-----------|---------------|---------------|---------------|----=
-----------|
> > > > > +              | Conductor | Alternative A | Alternative A |
> > > > > Alternative B | Alternative B |
> > > > > +              |           |    (MDI-X)    |     (MDI)     |     =
 (X)
> > > > > |      (S)      |
> > > > > +
> > > > > |-----------|---------------|---------------|---------------|----=
-----------|
> > > > > +              | 1         | Negative VPSE | Positive VPSE | \u20=
14
> > > > >     | \u2014             |
> > > > > +              | 2         | Negative VPSE | Positive VPSE | \u20=
14
> > > > >     | \u2014             |
> > > > > +              | 3         | Positive VPSE | Negative VPSE | \u20=
14
> > > > >     | \u2014             |
> > > > > +              | 4         | \u2014             | \u2014         =
    |
> > > > > Negative VPSE | Positive VPSE |
> > > > > +              | 5         | \u2014             | \u2014         =
    |
> > > > > Negative VPSE | Positive VPSE |
> > > > > +              | 6         | Positive VPSE | Negative VPSE | \u20=
14
> > > > >     | \u2014             |
> > > > > +              | 7         | \u2014             | \u2014         =
    |
> > > > > Positive VPSE | Negative VPSE |
> > > > > +              | 8         | \u2014             | \u2014         =
    |
> > > > > Positive VPSE | Negative VPSE |
> > > > > +            minItems: 1
> > > > > +            maxItems: 2     =20
> > > >=20
> > > > "pairsets" does not follow the normal design pattern of foos,
> > > > foo-names, and #foo-cells. You could add #foo-cells I suppose, but =
what
> > > > would cells convey? I don't think it's a good fit for what you need.
> > > >=20
> > > > The other oddity is the number of entries and the names are fixed. =
That=20
> > > > is usually defined per consumer.    =20
> > >=20
> > > Theoretically if the RJ45 port binding was supported it would make mo=
re
> > > sense, but in reality it's not feasible as the PSE controller need th=
is
> > > information in its init process.
> > > The PSE controller reset all its port to apply a configuration so we =
can't
> > > do it when the consumer (RJ45) probe. It would reset the other ports =
if
> > > one consumer is probed later in the process.   =20
> >=20
> > There is no reason other than convenience that all information some=20
> > driver needs has to be in one node or one hierarchy of nodes. You can=20
> > fetch anything from anywhere in the DT. It does feel like some of this=
=20
> > belongs in a connector node. We often haven't described connectors in D=
T=20
> > and stick connector properties in the controller node associated with=20
> > the connector. Then as things get more complicated, it becomes a mess. =
 =20
>=20
> Right, we could indeed put all the informations of the pse_pi node in the
> future RJ45 port abstraction node. Then, this series will be put aside un=
til
> we manage to have the port abstraction get merged.
> I am not glad about this as it will stuck my work until then, but indeed
> removing this pse_pi wrapper node which is between the pse_controller nod=
e and
> the connector node seems cleaner.

After some new thought, I thinks it is quite similar on the devicetree side=
 to
have it in a pse_pi node or in the connector node.
Here are my agruments to continue using this pse_pi binding description:
- The connector abstraction is in its early work and won't really see a v1 =
soon
  while the PoE series got mainly all reviewed-by thanks to Andrew.
  This would stuck the PoE series until maybe one or two Linux version.
- It allows to use the "Power Interface" name like described in the standar=
ds.
- Even if this is in the PSE controller node, it is generic to all PSEs so =
it
  shouldn't become a mess.
- It allows to have the PSE controller and Power Interfaces parameters grou=
ped
  together and it will be easier to read. May not really be an argument! ;)
- It will keep the logic of PoDL with the PHY using a single reference to t=
he
  PSE PI through the pses parameter.=20

Is it okay for you to continue with it?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

