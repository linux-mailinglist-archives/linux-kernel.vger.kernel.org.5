Return-Path: <linux-kernel+bounces-131163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8D8983ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DA51C22520
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DE745F4;
	Thu,  4 Apr 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K87hT6eF"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA871E86F;
	Thu,  4 Apr 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222716; cv=none; b=atVuPIoQO8i7RVuzGGb9359hg7bjawuHH6WENUEoKPUePBNQOekWnID+6mh0kLCjL0PcS43apXFKOj+EPWxngVpwaGN4ZimA/h/8CzRnA9HZvqPpqw609e2IeEBph9N5hnpMEfNbbqW7CBfVGq4g+Y0xU109z4uXB58zteho9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222716; c=relaxed/simple;
	bh=goGoyXyy2aFQvi0+QqmO6oV3VAEgFQ1Y15GcxBwoZ28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udTVr4Gx5gj9Tbc0aY5enpUIDFCC9Lc7hQa8jzZhBBvuMjNYLcX5e8D0nK7ZhN94ViOTxY2yKI8Iob377bY0Htl7dCY/t4aLCcnEC5v2DsN3N07FvCg0wQBg4PiXX4o/JV4DWEZOeSYIMHi080YK5KLQsqa92XT+C473gzaBmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K87hT6eF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 074A260008;
	Thu,  4 Apr 2024 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712222712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmD8Cz8LQvllwErFtC5QF38oacw9e604VmlkOt2aTy8=;
	b=K87hT6eFy1B8OGtdw6c4NM4XNlL1sD85a1Uge3xud4ocA7A/Sh0ogIKA0De/miAF0B6wEq
	fUWkit4VX2y1tVN0KhnXSMZy8aoAqRnwyf5j5Kkp/Fa8DiRti8LsC629SlqeSItha2dwrB
	JljeqzL3D6OnnzHF0NMyZvtP0n633+FVoqSP+ABlnBurdoRSIIlq1XtbBUzPUPDjwnVoVu
	+iUCEusnp+NAkyiT+85r7kqM7vZRoXz4GXHE0UF7yv+7pqYbODPTDxf11FJXL/C9ujBK+C
	OalDYtvgOYDwpJhwlD2WJu53LgPGEvfLZyIN8A1FbgS+0/xZrSEsA8Xqm3rLNQ==
Date: Thu, 4 Apr 2024 11:25:06 +0200
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
Message-ID: <20240404112506.2e155bad@kmaincent-XPS-13-7390>
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

> >  =20
> > > > +
> > > > +          polarity-supported:
> > > > +            $ref: /schemas/types.yaml#/definitions/string-array
> > > > +            description:
> > > > +              Polarity configuration supported by the PSE PI pairs=
ets.
> > > > +            minItems: 1
> > > > +            maxItems: 4
> > > > +            items:
> > > > +              enum:
> > > > +                - MDI-X
> > > > +                - MDI
> > > > +                - X
> > > > +                - S
> > > > +
> > > > +          vpwr-supply:
> > > > +            description: Regulator power supply for the PSE PI.   =
=20
> > >=20
> > > I don't see this being used anywhere. =20
> >=20
> > Right, I forgot to add it to the PD692x0 and TPS23881 binding example! =
=20
>=20
> But is this really common/generic? I would think input power rails would=
=20
> be chip specific.

I think as each PSE PI are seen as a regulator we may want it generic to tr=
ack
each PI parent. Having the parent regulator described like that would force=
 the
devicetree to describe where the power come from.
In contrary, for example, on the pd692x0 controller the regulators are conn=
ected
to the managers (PD69208) and not directly to the PIs. So the devicetree wo=
uld
not really fit the hardware. It is indeed chip specific but having described
like that would be more simple.

If we decided to make it chip specific the core would have a callback to ask
the driver to fill the regulator_init_data structure for each PI before
registering the regulators. It is feasible.

Mmh in fact I am still unsure about the solution.

Oleksij as you were the first to push the idea. Have you more argument in m=
ind
to make it generic?
https://lore.kernel.org/netdev/ZeObuKHkPN3tiWz_@pengutronix.de/

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

