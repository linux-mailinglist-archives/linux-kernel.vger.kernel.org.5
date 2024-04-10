Return-Path: <linux-kernel+bounces-138685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678189F906
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677B31C27A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D216F28E;
	Wed, 10 Apr 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZrTQ2QM8"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CA15E80D;
	Wed, 10 Apr 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757260; cv=none; b=qrBz6UvqRyW81E2MfcGoGvVgX8MgIiw/XefT2JZpBYNAMAp5VUKhZtnjlg8hPyZ68id6WkXlt7PJ60jH0npPxq7jcp4m4wcqR/gdTGj8gdwow1PYGyNNDfmpN7vx98POHVpzspFy5RIJhM6oKcJ2GpkTRpO6EPzRChuA35n0XmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757260; c=relaxed/simple;
	bh=qXgUkN/ZVhwE3W9k+C8UdVjBcT37D8ecxyft3UoOeCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8+BJHdBUBscO9hvm7snJrv3QU+MjshPeW7Cu1+fnrLDnKGXU8JDteBD0+C3wbJVxe6l7dYietervG8ycwV5X+pmMwDt0MrZBouqzTpjDx4+rgMO294PLQF9AMhaXKN+w7kLwZWHZv1zjo2cLASKXKn0LhpZrVUzjuhR2vP/bCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZrTQ2QM8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B17C60008;
	Wed, 10 Apr 2024 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712757255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCEBE0ZN4OCzSX6TY382vI7qZ2HEUdWjDQGoDSCw+Mg=;
	b=ZrTQ2QM8b0VdoGlNRf/5eqC2AbdRaW74M5OQka9hEkmseL0pW75UoGr7nDzC31/bniRwlT
	K5ut/65XW1lIb10ii2zpJwlcLDzXAGTLbbxW550BvAS6ecdr5dbQlo7JUR0jEPzNjD6ZOs
	h9msQpN31KtZ9QrOoXMd8jleKxGTRrKkyQ1o7CCDpPxTWmNY8kb4flCKy1sMY6kp7UvwuN
	XnEmU/nHtKCR/hcwsRehON9JO1MWFIcgksg2NY/R00R/EPKEcSqdTBQzoZ/o3gBARAgagB
	WhYuV0AkR9NqfEzUqVtXH0Qat/EcR3wF5o29xJrOw7JZNctyzYEUW84OPN0G8Q==
Date: Wed, 10 Apr 2024 15:54:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
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
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v10 07/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240410155412.2f34a117@kmaincent-XPS-13-7390>
In-Reply-To: <ZhZkNEYnY3FV7Q8E@shell.armlinux.org.uk>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
	<20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
	<20240409182725.139856d5@kernel.org>
	<20240410101200.0178e594@kmaincent-XPS-13-7390>
	<ZhZkNEYnY3FV7Q8E@shell.armlinux.org.uk>
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

On Wed, 10 Apr 2024 11:04:36 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 10, 2024 at 10:12:00AM +0200, Kory Maincent wrote:
> > On Tue, 9 Apr 2024 18:27:25 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> > > On Tue, 09 Apr 2024 10:26:29 +0200 Kory Maincent wrote: =20
> > > > In prevision to add new UAPI for hwtstamp we will be limited to the
> > > > struct ethtool_ts_info that is currently passed in fixed binary for=
mat
> > > > through the ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if =
new
> > > > kernel code already started operating on an extensible kernel varia=
nt
> > > > of that structure, similar in concept to struct kernel_hwtstamp_con=
fig
> > > > vs struct hwtstamp_config.
> > > >=20
> > > > Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, he=
re
> > > > we introduce the kernel-only structure in include/linux/ethtool.h.
> > > > The manual copy is then made in the function called by
> > > > ETHTOOL_GET_TS_INFO.=20
> > >=20
> > > This one now conflicts :(
> > >=20
> > > Applying: net: Add struct kernel_ethtool_ts_info
> > > error: sha1 information is lacking or useless
> > > (drivers/net/phy/marvell_ptp.c). error: could not build fake ancestor=
 =20
> >=20
> > gnn patching my out of tree patch in the series! Sorry for that. =20
>=20
> Given that this path corresponds to the driver I wrote, do I assume
> that you've picked up my work on PTP support for Marvell PHYs? You
> should be aware that I still have the patches out of tree but it's
> been pointless me reposting it until the issue of which PTP gets
> used has been solved. (Publishing will just increase the pressure
> to merge it without the PTP problems being solved, and thus break
> Marvell PP2 PTP.)

Yes I did with few fixes and I know you don't want to post the patches until
setting which PTP gets used has been solved. As you can see this is one of =
the
subject of this series. About it, could you review this series? This would =
help
a lot and you will be able to post again your Marvell PTP patches if its get
merged.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

