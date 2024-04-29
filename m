Return-Path: <linux-kernel+bounces-162294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22A8B592A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B41C21353
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43C74BF0;
	Mon, 29 Apr 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ClwGfZEy"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36A535C1;
	Mon, 29 Apr 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395135; cv=none; b=f5U8ZC+EtOVn1ZJzS1Nlb39RnRD7TEHkFHrpDIUXr01KOoRQrhmZ69hC+yDq3V9aLra/vWy1PrWrHA99DhB1NQMqk4ISLqSa1AP86BcrDqPEiqNKIF4V9xg33v4Va+JWBlv7x+Qoge7Yg+ymuI/sMtc1RS9qIK1A/h4ys8u3ZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395135; c=relaxed/simple;
	bh=pdAFVM/qnBIS1H9MPF0LH/pChAoh+tp5F7+U71Pkzdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pusf2tWd6uyjmNGT5ExNkeCj6LWrKH5dOSPM8iPZ0z2v9rOvalV8YwExJGzuXA/L13TjA9IGsMUgdpnzSOwjBlcM0I4vFK5jwoY5ScxJfBdvfXm7x871LMXzqEoIo31Kcwa4eVzWdsZngqnpUn4BN7wFDgyG8Jtz03EVwFQ2viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ClwGfZEy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BD444000E;
	Mon, 29 Apr 2024 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714395125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdAFVM/qnBIS1H9MPF0LH/pChAoh+tp5F7+U71Pkzdg=;
	b=ClwGfZEyV24yncIWiggonM/ucJfSBqdQgHdnhKlvJa2cQhtgdCflYYjIK/oG3djeECtzxl
	f/oq9VtM7oOjLZvbYP/EtF5mnlBsdhdtA5WMQjzXe69qALjL/Ug6idojlwieZOMxe3gf7K
	sUt9XpIaMY6TTpwDPzKarvjx3kF3mh2uKouvX+SC9IHSGUBB90xkEJDNXC8tU/I3/9KuRq
	Gn9klPmx79uNM/G/AfzL7t8eXdRy5RaqId0jLkZLxkX0GdB/W4+1wozAs6XzwdQ2TGoRzS
	80C2oetRpk+cyscIcPGw6322msRskyO9w1B7jGDxnl21QSngQLNH/VzUN+uK+w==
Date: Mon, 29 Apr 2024 14:52:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Kyle Swenson <kyle.swenson@est.tech>, Liam Girdwood
 <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <20240429145203.219bee06@kmaincent-XPS-13-7390>
In-Reply-To: <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
	<57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
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

On Sat, 27 Apr 2024 00:41:19 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Let's begin simple, in PSE world we are more talking about power.
> > Would it be ok to add a regulator_get/set_power_limit() and
> > regulator_get_power() callback to regulator API. Would regulator API ha=
ve
> > interest to such callbacks? =20
>=20
> Could you define this API in more details.

The first new PoE features targeted by this API was to read the consumed po=
wer
and get set the power limit for each ports. Yes mainly book keeping.
Few drivers callbacks that will be called by ethtool and maybe the read of =
power
limit and consumed power could be add to read-only sysfs regulator.

> I'm assuming this is mostly about book keeping? When a regulator is
> created, we want to say is can deliver up to X Kilowatts. We then want
> to allocate power to ports. So there needs to be a call asking it to
> allocate part of X to a consumer, which could fail if there is not
> sufficient power budget left. And there needs to be a call to release
> such an allocation.

This is more the aim of the second point I have raised, power priority and
parent power budget. And how the core can manage it.

> We are probably not so much interested in what the actual current
> power draw is, assuming there is no wish to over provision?
>=20
> There is in theory a potential second user of this. Intel have been
> looking at power control for SFPs. Typically they are guaranteed a
> minimum of 1.5W. However, they can operate at higher power
> classes. You can have boards with multiple SFPs, with a theoretical
> maximum power draw more than what the supply can supply. So you need
> similar sort of power budget book keeping to allocate power to an SFP
> cage before telling the SFP module it can swap to a higher power
> class. I say this is theoretical, because the device Intel is working
> on has this hidden away in firmware. But maybe sometime in the future
> somebody will want Linux doing this.

So there is a potential second user, that's great to hear it! Could the
priority stuff be also interesting? Like to allow only high priority SFP to=
 use
higher power class in case of a limiting power budget.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

