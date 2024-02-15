Return-Path: <linux-kernel+bounces-66697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E803856054
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A0281C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7E1384B7;
	Thu, 15 Feb 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g1hJ/Hwe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887684FD1;
	Thu, 15 Feb 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993692; cv=none; b=FdvTqti5rcpNUDAOLyfBPddC/QOPKOnhYWrAeaBeHL/uUVH5+9iVIqyZ5p72yfSmjr0qjfdwFZ5LQPHsjdJtR4LeY/Yq0Q/HlUncIN+D6R+7tJPAhmbSjVYnwv5KEWaGY1ZCN7e88WJdxrAib04zuFkBef1jzYFebH9SvDiznMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993692; c=relaxed/simple;
	bh=eVKgJ+PdR5o6UVkgqUdQLFko+Czs5USvovgYmgBi2Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELx3YrNVZRhiAHEnSuQrJUxWO/W55nEsUsNdGeQMM0HLLOBmA5Pq1E5V1HyZJHLo8GaJUDRzchDFjvgLPNxY9hRCaFzottKTk/UaVhJ8PS+CF7zsRzqDkXNj42Hi8GH9/J/7cs406KX5jj8m544KSqkiRzKA0FyHufiq+azEAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g1hJ/Hwe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 282AA240011;
	Thu, 15 Feb 2024 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707993686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVKgJ+PdR5o6UVkgqUdQLFko+Czs5USvovgYmgBi2Dc=;
	b=g1hJ/Hwe7l8CextjF6EYChrf3HeQbqFoxg96KtpO+dqy3f/NIh7H2IVvt7ciyU7AlWyiEM
	9aydTbAdFrLGwKHwvMEsIN8Tonb5SIrmQd+Hk5sk8PNjJkN63tcsCFBdour9lG4okj0lIH
	15l2A7F9/wmNIX17BR9cS/+BPoSGn4ug0Ef0+EfVUShLQuprbM6iSoreONOuj+D9suTYS+
	p/a4Bj5r7eoq1AVfQktXq1llinvAsjKo0rDqTDKNKs/tdBcIwAfPFjBG9WDx6/WoFmBHsM
	GdBsjc9FfSx3XWdqMZVG0R+JXfeBwdCG3glQaqd2A+fbdOcCj9Vd8hsIFDK+GQ==
Date: Thu, 15 Feb 2024 11:41:23 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add
 bindings for PD692x0 PSE controller
Message-ID: <20240215114123.128e7907@kmaincent-XPS-13-7390>
In-Reply-To: <Zc3IrO_MXIdLXnEL@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
	<20240209145727.GA3702230-robh@kernel.org>
	<ZciUQqjM4Z8Tc6Db@pengutronix.de>
	<618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
	<Zc3IrO_MXIdLXnEL@pengutronix.de>
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

On Thu, 15 Feb 2024 09:17:48 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Feb 14, 2024 at 06:41:54PM +0100, Andrew Lunn wrote:
> > > Alternative A and B Overview
> > > ----------------------------
> > >=20
> > > - **Alternative A:** Utilizes the data-carrying pairs for power
> > > transmission in 10/100BaseT networks. The power delivery's polarity in
> > > this alternative can vary based on the MDI (Medium Dependent Interfac=
e)
> > > or MDI-X (Medium Dependent Interface Crossover) configuration.
> > >=20
> > > - **Alternative B:** Delivers power over the spare pairs not used for
> > > data in 10/100BaseT networks. Unlike Alternative A, Alternative B's
> > > method separates power from data lines within the cable. Though it is
> > > less influenced by data transmission direction, Alternative B includes
> > > two configurations with different polarities, known as variant X and
> > > variant S, to accommodate different network requirements and device
> > > specifications. =20
> >=20
> > Thanks for this documentation.
> >=20
> > It might be worth pointing out that RJ-45 supports up to 4
> > pairs. However, 10/100BaseT only makes use of two pairs for data
> > transfer from the four. 1000BaseT and above make use of all four pairs
> > for data transfer. If you don't know this, it is not so obvious what
> > 'data-carrying pairs' and 'spare pairs' mean. =20
>=20
> @Kory, can you please update it.
>=20
> > And what happens for 1000BaseT when all four pairs are in use? =20
>=20
> Hm.. good question. I didn't found the answer in the spec. By combining a=
ll
> puzzle parts I assume, different Alternative configurations are designed
> to handle conflict between "PSE Physical Layer classification" and PHY
> autoneg.

Oleksij how did you get the definition of Alternative A uses the "data-carr=
ying"
pairs for power transmission and Alternative B Delivers power over the "spa=
re
pairs"?

On my understanding of the 2022 standard the definition is:=20
- Alternative A is for pinout conductors 1, 2, 3 and 6
- Alternative B is for pinout conductors 4, 5, 7, 8.

Then indeed if we are in 10/100BaseT Alternative A are "data-carrying
pairs" and Alternative B are "spare pairs" but that's not the case on
1000BaseT.

You can see it in the figures in the paragraph 145.2.3.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

