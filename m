Return-Path: <linux-kernel+bounces-111601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442B886E64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386761F22485
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834947F41;
	Fri, 22 Mar 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YahQzIVQ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68B3EA69;
	Fri, 22 Mar 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117360; cv=none; b=J9R+mNwep1S3rlYk04HWB4UqJ8Xci2CitcTz+Slj9zOGq+KMNBiweedDGuVx3NX2rOWQdzvDPiJ0WT3njprJu8oIEYN9e5BSp91TymmbtQmiTPdElOzOOSjcWdnUulJY81PFwqBivqdwZqd7Sosc32wa3hQk+2yI35YeIB7xKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117360; c=relaxed/simple;
	bh=BR0WlKret8eILef1rpRsE7FbijXE68ZU4YU5Orzxgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQJdsga4Zb/5E3+ZY9ch1XNSXLdyhoajkbwR4z7Nl2VKhWuvFtTC+wQZkJrcE88/xhuLGM8u0COkE2pUhN2gTu0R1mIl5jHtf38fbyI/21URXsyfwfolyINZJTfovGD5tyfAK4oiq4dI3lOYbyf6CnCLRVjIM2gpds5E4vDCZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YahQzIVQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B31AE0004;
	Fri, 22 Mar 2024 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711117349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH1XRhULQIs8JPRuZsRMbAGpvto0OH+vLr70bNJGEho=;
	b=YahQzIVQq0jJ1ScOJhQ/K+EwS4rg6H7JA024lGZUDBFPIlgbkqTCFwDO5ePCgG+fjLWptk
	Es6WkS2daYPgFJsTy9CiAkveBWPlcPHZApIlp6nlAepa1ykZHJWcsb6GE9jRaEMcj4A6bE
	2xNxzOT6ZuruAE8/uWn/8MuIHYlhHUDq9gWgVKBZb2tjg9nJnULQdy/nJnGFz+ULMhcyiD
	C5wdMigkNMVqYqwwHGK6KUsrwnq6HtYYzLhIwt2HQw0xH+TbTmm+tZng3Q6FY6+TpHOLmt
	b+gsW6jyAQhDTC9Mi6bP4ureTAOgB3GiqQpiXRVNptdmT02lrzTQ1RlB/DoTuQ==
Date: Fri, 22 Mar 2024 15:22:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240322152226.7de347a6@kmaincent-XPS-13-7390>
In-Reply-To: <Zf2QsfsxcPoCq_SC@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<ZeObuKHkPN3tiWz_@pengutronix.de>
	<20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
	<ZeWi90H-B4XeSkFs@pengutronix.de>
	<20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
	<ZfxjosqPMo0ECBmx@pengutronix.de>
	<20240322113950.27d35376@kmaincent-XPS-13-7390>
	<Zf2QsfsxcPoCq_SC@pengutronix.de>
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

On Fri, 22 Mar 2024 15:07:45 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hay Kory,
>=20
> On Fri, Mar 22, 2024 at 11:39:50AM +0100, Kory Maincent wrote:
> > Hello Oleksij,
> >=20
> > On Thu, 21 Mar 2024 17:43:14 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Thu, Mar 21, 2024 at 05:15:24PM +0100, Kory Maincent wrote: =20
> > > > Hello Oleksij,
> > > > Sorry, I forgot to reply about this.
> > > > This is specific to pse_regulator driver. Could we tackle this chan=
ge in
> > > > another patch series when the current patch series got applied?
> > > > Also I don't have the hardware to test it.   =20
> > >=20
> > > ACK, no problem. =20
> >=20
> > I have a question unrelated to this.
> > Why do you add refcount on the pse_control struct?
> > The pse control is related to the RJ45 port. Each port is exclusively
> > related to one pse control.
> > Shouldn't we return an error in case of two get of the same pse control
> > index? Do you see use cases where a pse control could be get two times?=
 =20
>=20
> I assume, any instance which need coordinate PSE behavior with own action=
s.
> For example - PHY will probably need to coordinate PHY state with PSE PD
> classification process.

Indeed, I was focused on devicetree and didn't thought of coordination
between PHY and PSE. Thanks for your reply.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

