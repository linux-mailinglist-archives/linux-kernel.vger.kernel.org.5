Return-Path: <linux-kernel+bounces-123066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7E8901AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB41F25405
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FA1272AC;
	Thu, 28 Mar 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ORguJtxs"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB914011;
	Thu, 28 Mar 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635858; cv=none; b=Q3/qt7wWBwAN2NAMRVZ9bIiBwq0wifcVFr/N41LTip6YsVrxnbAFPxOmWbmGgtAw1IvSZCG90PQIP/0xftgDaEtYok05wBT7WQtaZ3AIQH0huOlogHWf4BdE82ymm1UHO52ax7+5IyfjbHOLfQqcrfxdKCbviLwVmzJx3XlAols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635858; c=relaxed/simple;
	bh=GpSW9qy/DbCkeanF/WDNIkt+UbrGs1BU2sGeTKT1BZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKH+moJ+q33xyN1mnb0QnSffdXqegqIpKj0kq+4nXUCGIEX7nFCcH+RG1/RqNmSyOjz9dXKVwRRsY35R1Bcxz2n9Z2VJALE/vbimDbKduoCtu0VDgWsy59N5+YWNATrIrfGO3n3vc8dUoNfbfAmbCxcS1kHsNZeYNY29azIpAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ORguJtxs; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E012760002;
	Thu, 28 Mar 2024 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711635847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPK8OWtA7r2lnM0J492qYwHtOe3RtTG+NnxTRXgMEzE=;
	b=ORguJtxsDZUdBCmxS9tQJ3NMnzZ/VeROyKqHmRgFQEMnKdwLvphs8X2Niycnfnh2+obNGB
	twnVypHhM1PgDDy8u5f/49EpRAKmxxPIP7bjr18BYamJJTqeHlhWIhSoZsHSyrhvxUm7Wf
	C4JLbjTiQPeGiA6oqw19YN+IipmTT0M/Dr8jhTuSKw+S2IJmyFMwfNgKMvqcoADvZIFbVE
	0j7qIBfzzB09U+EKC/1y0qAARFC+uJtO0r2HgZQOFSqaCOs6bgaUujSqLmXU5y+N9OqlBP
	lu30+/I1XcrkVsDV5rAFn2v+b4V+1qVK330MnPQcGLoya/3G2cNJdaIIsvyjZg==
Date: Thu, 28 Mar 2024 15:23:59 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240328152359.63f8e93a@kmaincent-XPS-13-7390>
In-Reply-To: <2d325acb-fc35-4ca3-80f2-ac88359578fd@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
	<2d325acb-fc35-4ca3-80f2-ac88359578fd@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 28 Mar 2024 13:31:06 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

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
> > Positive VPSE | Negative VPSE | =20
>=20
> Is it possible to avoid \u encoding? Ideally this documentation should
> be understandable without having to render it using a toolset. I just
> want to use less(1).
>=20
> Or is this a email problem? Has something converted your UTF-8 file to
> this \u notation?

It seems to come from the documentation I copied pasted from Oleksij mail.
Will fix it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

