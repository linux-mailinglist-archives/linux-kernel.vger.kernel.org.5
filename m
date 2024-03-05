Return-Path: <linux-kernel+bounces-92613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BE8722E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90EE2835B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD93127B4A;
	Tue,  5 Mar 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pGe0d5y7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5FC1272D4;
	Tue,  5 Mar 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652953; cv=none; b=upcb4InYVGT8qbNe6FuFciXIx/+Q0YENXqSIMf60CXk9s3h8AS6aplsOml7xbgKEn+3fl2PjK36G7yGn7uc3zrWEYIvD/VAXD3mSHhns4RryTpv3E0rzCQLp6GibVyhqU/IoL7dmKN6x0geMRkWW4D6qcAqORS+jR9CbySXiy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652953; c=relaxed/simple;
	bh=GF32o6mLZBCNxYK9qX7xyh4y+U6z2NwNaLAEw9sMSOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOMuy47NTE6FMfHEJ7xBw3/wZWANDg5grKZbG5TmF6eAt0hM4jWu5RdYFCEHzQYrGpk6yG2ppGBIKEWER/hCDlKmzBX2Tbl/m7zK9/GSpiGyc7S8I/Vqyr+eRmjJfsCqI1h+k7/o1xZefyddG//4q9UYhZzotglkl3m6OXkcXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pGe0d5y7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4F131C000A;
	Tue,  5 Mar 2024 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709652949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT4WtSDtpTkd9ywhcIQhF34YAJjW4wWxhDNZEztSJaI=;
	b=pGe0d5y7UjCFlV9NPpXyD4m/RlxLnktAQKpFS3GlAopanJah/TXlc255UxEHdZhxGLqmT5
	l7EM70RaKM07/P0dPFK9WhDhPFSI9H7yLPoaEAFBIhD00RjNGfjqb0j7J3Zq3e87ZaI26B
	vkFjcDl50WDQV1/C4brQA82WOS+0h8mnONjcf4ub1P55l9vAyVmGYbH/1OZIywf6IzprV+
	2Ha/JPtKo/6dNYtHccgoCc+iUEQyIVVWrBBftlBbt1eu6DmlzwbET2yVEDSDtSgO2gzxvz
	uJ+U9KhVsxS+cM/3zdvbAtzCK96a232Gscm9Us0lUExJop6tijk/LaV70ahQGA==
Date: Tue, 5 Mar 2024 16:35:46 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20240305163546.3b9f3ed9@kmaincent-XPS-13-7390>
In-Reply-To: <20240305065939.2d419ff2@kernel.org>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
	<20240304185734.5f1a476c@kernel.org>
	<ZebZpspMCqjLES/W@shell.armlinux.org.uk>
	<20240305111021.5c892d5a@kmaincent-XPS-13-7390>
	<20240305065939.2d419ff2@kernel.org>
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

On Tue, 5 Mar 2024 06:59:39 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 5 Mar 2024 11:10:21 +0100 K=C3=B6ry Maincent wrote:
> > > No. In the case of mvpp2 + marvell PHY, the two PTP implementations a=
re
> > > entirely separate.   =20
> >=20
> > Yes the PTP clock can be independent from the netdev.
> > We need to know which software layer register the PHC to be able to cal=
l its
> > callbacks.
> >=20
> > My commit log is a bit small here. I will enhance it in the next versio=
n. =20
>=20
> Still, wouldn't it be simpler to store all accessible PTP instances=20
> in the netdev?

You are talking about something like the phy topology but for the ptp?

Then when asking information on a PHC (tsinfo or hwtstamp config) from etht=
ool
we would have to look at the PHC topology of the netdev. This could work. N=
ot
sure it is much simpler, do you see other advantages that it could have?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

