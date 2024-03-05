Return-Path: <linux-kernel+bounces-92040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04B871A20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A98E282C02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137354770;
	Tue,  5 Mar 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VVi1O8qY"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9E4D9F9;
	Tue,  5 Mar 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632967; cv=none; b=WcJj0KHWqKQd3Wu6PqYF1VD0G2h5aLkQWfe9VjUv2mKB4RvxWm5KLb1m8F8gsPY7b1IiL/GGaH5y+tasjajE27r3uQbsPA8O2mQfkd+gTwHRRdTXA0BjKEadj1Ip3MwyBszKKahcuyrm8VH+LG1vZAIH/UaBWTGSzOvWEU4R1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632967; c=relaxed/simple;
	bh=D0vHsAJNAvotsrRPO6R/H2ATrWJBLX7q5KDT/CK6xHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CM3BLAY4STbSB4pWrtpyy1MuOEQOXU0hz81HCLdsFW7jfW7PV0fLsHmDfH9NURUSDoiBWZSnSkmEzug8JVo6KeKCuLjYeq+841givfKyJLK+OiBBuBr/vDnWHCI948TJYKMzzC1UKg8KtKDTNOzsm7UE05veVCbGfXNMIGo6fLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VVi1O8qY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73A50FF80D;
	Tue,  5 Mar 2024 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709632957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTaRrrhLCd6vyS/QfkqHI3GV6BwIOBGsPobf3wIDHq0=;
	b=VVi1O8qYd5QxG5YleJVNsRGWGhyJrG2nWLJCm/HkgI2Ns2NYFG2iQh0cYziYqsrmMUHu0I
	cgaMBRsfv5YvqfisZwq5Tei8FTxe6Zl0s9fCH9H6VPpPOjLdbw89p+9qfpOaxhONG0Pv7L
	YDgWeY0I3MmCSQKMOvk07wo5ciZPR8nXXzOrtH+hIuVvvdqswZa7ERshUtrr2w0EodQt5P
	RU/p/Zh/qb/Rb4RoJ6jxh0Nk+/Io904/tm/HAmHoKfZXwKigWpzqgpJpwj5e6AuFlw4fLr
	aMpfNnNck5UUseFDRkBkqlM/Rc9Sa5MRa6EAoyPirTYyhT2Jdrj9KES9HLgDfA==
Date: Tue, 5 Mar 2024 11:02:33 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
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
Subject: Re: [PATCH net-next v9 02/13] net: Make dev_get_hwtstamp_phylib
 accessible
Message-ID: <20240305110233.2aca99f7@kmaincent-XPS-13-7390>
In-Reply-To: <20240305105627.1d277a76@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-2-455611549f21@bootlin.com>
	<20240304184048.1c1724fa@kernel.org>
	<20240305105627.1d277a76@kmaincent-XPS-13-7390>
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

On Tue, 5 Mar 2024 10:56:27 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index f07c8374f29c..7f78aef73fe1 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -4005,6 +4005,8 @@ int generic_hwtstamp_set_lower(struct net_device
> > > *dev, int dev_set_hwtstamp_phylib(struct net_device *dev,
> > >  			    struct kernel_hwtstamp_config *cfg,
> > >  			    struct netlink_ext_ack *extack);
> > > +int dev_get_hwtstamp_phylib(struct net_device *dev,
> > > +			    struct kernel_hwtstamp_config *cfg);   =20
> >=20
> > since we don't expect modules to call this, how about we move dev_set*
> > and the new declaration to net/core/dev.h ? =20
>=20
> Ok for me.

I replied to quickly.
It seems this header in not include in ethtool part.=20
This would imply adding #include "../core/dev.h" in the tsinfo.c file.
Not sure this is what we want.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

