Return-Path: <linux-kernel+bounces-162748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DC08B6006
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C177A1F218F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54AE126F08;
	Mon, 29 Apr 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5Bi/Urb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB98595F;
	Mon, 29 Apr 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411737; cv=none; b=QnimhtaSlGwBuA+eE0wR8XhgLCztFIIlTqCxIQ4CdBm8Xn7oYBCCAY+3DjqUIXXeMd6nw/MuMte8HrBuPipltNPzYfmosYs5cYUbvLovIbPiX2UJmq2TAVDXIcAqTFjy7vZ/nllFi0x4J/R6S+qcZC0eWlBXNjSfekxYBQCdfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411737; c=relaxed/simple;
	bh=V/EdWqjSL66K2W+Rljv5d3dHA1Y71VTttKSIAVGvPVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSsLndQejD2nTKttp+Dq0hgS2sToNwCBWeisAls9atrh/FxAEVrEmilgtqZH6O9MTjiWL+2zw9B868dsFby+F7GqD2rkevA1sPabvooymKys6HA/egEGbNY++VuHRlRIaOXPvryL7StYdEuSSBNGu6il8JJNi9xNu2df/+Zbwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5Bi/Urb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13BCE20005;
	Mon, 29 Apr 2024 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714411732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3NitkVDANPDUYTKXLeCe7dOJF6tcodDJ3rgCbuQyDo=;
	b=U5Bi/UrbUpDiDFR83uoGZnDosNkfFT1p7MFxseTl4LwmMXU3UhER9hr739l0a7IxRvA3bU
	Bb2dXrQry8bnnFfFRYn0mlyJVD7SvDYEr2xdTvLqQNhaPg67S/uRdv950nBxvk9F3uItp6
	bDog9dJmJO2J/uXFV0X6yqrU+swBIuOU9KpUnOXmF0lBgtgbUH8NpmrFyZBbIIbeVsH1oO
	FrfLPaG4z9nsXoNiqvkG9WhZGq2YX6BJVGxsowGpN/0BC6j18XscvZxQpntXVoVg7ouX7W
	crA1MouDEsi3e2B5Q5Vd/65riGIwdTQi+3zT4oh+7Sb9gUfypgvJf/+KP84tBA==
Date: Mon, 29 Apr 2024 19:28:48 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kyle Swenson
 <kyle.swenson@est.tech>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <20240429192848.13c576b7@kmaincent-XPS-13-7390>
In-Reply-To: <Zi--4ko_vAtFSxyn@finisterre.sirena.org.uk>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
	<Zi--4ko_vAtFSxyn@finisterre.sirena.org.uk>
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

On Tue, 30 Apr 2024 00:38:10 +0900
Mark Brown <broonie@kernel.org> wrote:

Hello all, thank for your replies!
That gives me more hint for the development.

> On Fri, Apr 26, 2024 at 12:42:53PM +0200, Kory Maincent wrote:
>=20
> > Let's begin simple, in PSE world we are more talking about power.
> > Would it be ok to add a regulator_get/set_power_limit() and
> > regulator_get_power() callback to regulator API. Would regulator API ha=
ve
> > interest to such callbacks? =20
>=20
> Why would these be different to the existing support for doing current
> limiting?  If the voltage for the supply is known then the power is a
> simple function of the current and the voltage.  I suppose you could try
> to do a convenience functions for a fixed voltage, but there'd be issues
> there if the voltage isn't configured to an exact voltage and might
> vary.

That's right I was focusing on power where I could use already implemented
voltage and current callbacks. Would you be interested to a new get_current=
()
callback to know the current and allows regulator to deduce the consumed po=
wer
or should it be specific to PSE subsystem.

> > Port priority, more complex subject:
> > Indeed a PSE controller managing several ports may be able to turn off =
ports
> > with low priority if the total power consumption exceed a certain level.
> > - There are controller like PD692x0 that can managed this on the hardwa=
re
> > side. In that case we would have a regulator_get/set_power_limit()
> > callbacks from the regulator parent (the PSE contoller) and a
> > regulator_get/set_priory() callbacks for the regulator children (PSE
> > ports). =20
>=20
> All this priority stuff feels very PSE specific but possibly doable.
> You'd have to define the domains in which priorities apply as well as
> the priorities themselves.

If you think that it is really specific to PSE no need to add it in the
regulator API, it will also remove me some brain knots.

> > - There are controller like TPS23881 or LTC4266 that can set two priori=
ties
> >   levels on their ports and a level change in one of their input pin can
> >   shutdown all the low priority ports. In that case the same callbacks
> > could be used. regulator_get/set_power_limit() from the parent will be =
only
> > at software level. regulator_get/set_priority() will set the priorities=
 of
> > the ports on hardware level. A polling function have to read frequently=
 the
> > total power used and compare it to the power budget, then it has to call
> > something like regulator_shutdown_consumer() in case of power overflow.=
   =20
>=20
> I would expect the regulators can generate notifications when they go
> out of regulation?  Having to poll feels very crude for something with
> configurable power limits.

Yep that's true. Indeed using notification would be way better!

> > https://lore.kernel.org/netdev/20240417-feature_poe-v9-10-242293fd1900@=
bootlin.com/
> > But in case the port is enabled from Linux then shutdown from the PSE
> > controller for any reason, I have to run disable and enable command to
> > enable it again. Not really efficient :/ =20
>=20
> If that is a hot path something has gone very wrong with the system,
> especially if it's such a hot path that the cost of a disable is making
> a difference. =20

That's not in the hotpath.

> Note that hardware may have multiple error handling
> strategies, some hardware will turn off outputs when there's a problem
> while other implementations will try to provide as good an output as
> they can.  Sometimes the strategy will depend on the specific error
> condition, and there may be timeouts involved.  This all makes it very
> difficult to assume any particular state after an error has occurred, or
> that the state configured in the control registers reflects the physical
> state of the hardware so you probably want some explicit handling for
> any new state you're looking for.

Alright, didn't thought of these different management of an error condition.
We might also see similar things in PSE, so I will keep it like that.

> > I am thinking of disabling the usage of counters in case of a
> > regulator_get_exclusive(). What do you think? Could it break other usag=
e? =20
>=20
> Yes, that seems likely to break other users and in general a sharp edge
> for people working with the API.

Okay,

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

