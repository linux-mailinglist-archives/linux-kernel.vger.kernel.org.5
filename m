Return-Path: <linux-kernel+bounces-92059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12A871A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFDEB22613
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3EB5A4C7;
	Tue,  5 Mar 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hb5413ee"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1B5490B;
	Tue,  5 Mar 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633437; cv=none; b=CQcfRCIsRRHbUW+5LE86GqfcbEeIPpxvE/ojkUGsuGt8AYLv/4izsGiORMCDOlHhsrcu1ZaqMfihQJaZmSR+2bM626rGpackSBGK4AngUyGkJbVA6Gn6EM4YcL7wPMX87ZeOk1f/ce1Za6EyhFBPThUapeKy7BW6EyiwfsVt9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633437; c=relaxed/simple;
	bh=OAVORbio8rX6MP7JstBR8elPmW+TfA86LMRUm++6e/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwS1iRCbSRBF3Oo0KI3Kac00qjP+7TocyRj+PHhADgxNuIl3OEL0p02g58McVfnl4i+ZrIkOBs3umN/06df9322EzYQP1LrOt7vfMKtM/U+7b4RfGBqcj89AV2BUGl1o2rtFMetOHAA2jxg8WEHZabV1zLHB7FwRQBhSrinNWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hb5413ee; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 956D76000A;
	Tue,  5 Mar 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709633426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAVORbio8rX6MP7JstBR8elPmW+TfA86LMRUm++6e/M=;
	b=Hb5413eedQK0YxQ1ILt65ybaUrNRAGNuplmwg//4ZQJjbbmG62g1t5GGVso/Et3lv2+wX4
	8T8hKdXBDXCYIW/ac983hQYxrucOUJ8QMkLOGBBVAjHIhBhdkqxvOcQ38UCp2/xXZUnYwz
	lgGee57RS1o0nFDWciYaCRsouSfckHadobj1iJOwElo6GhuMaQiSM9g8cpu84xSUT0ddm0
	AnqLohvyJG4BeZkLMwXhTIVdcGM7l9sPzImFcCR1gv/W8i+qVguhLVBj6qqkzmuudSZo6M
	1tD3t8hDMcZHuNuorgTOmH0R4WEB0MaHkhjY77/jxm3N1emWCFo7rHa1yoD6zg==
Date: Tue, 5 Mar 2024 11:10:21 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli
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
Message-ID: <20240305111021.5c892d5a@kmaincent-XPS-13-7390>
In-Reply-To: <ZebZpspMCqjLES/W@shell.armlinux.org.uk>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
	<20240304185734.5f1a476c@kernel.org>
	<ZebZpspMCqjLES/W@shell.armlinux.org.uk>
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

On Tue, 5 Mar 2024 08:36:54 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Mar 04, 2024 at 06:57:34PM -0800, Jakub Kicinski wrote:
> > On Mon, 26 Feb 2024 14:39:59 +0100 Kory Maincent wrote: =20
> > > Prepare for future hardware timestamp selection by adding source and
> > > corresponding pointers to ptp_clock structure. Additionally, introduce
> > > helpers for registering specific phydev or netdev PTP clocks, retriev=
ing
> > > PTP clock information such as hwtstamp source or phydev/netdev pointe=
rs,
> > > and obtaining the ptp_clock structure from the phc index. =20
> >=20
> > Can we assume there's one PHC per netdev?
> > We both store the netdev/phydev info in the ptp clock
> > and ptp clock in the netdev. Is there a reason for that? =20
>=20
> No. In the case of mvpp2 + marvell PHY, the two PTP implementations are
> entirely separate.

Yes the PTP clock can be independent from the netdev.
We need to know which software layer register the PHC to be able to call its
callbacks.

My commit log is a bit small here. I will enhance it in the next version.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

