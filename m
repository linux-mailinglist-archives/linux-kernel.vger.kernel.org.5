Return-Path: <linux-kernel+bounces-92037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3A871A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A701C20C64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B015381E;
	Tue,  5 Mar 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pay51SMK"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5494CB58;
	Tue,  5 Mar 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632599; cv=none; b=u8uTQFv7nrgFTwmI5qXK07RgeG1wndCoGgtevQbAhmBEpMd1z1AQrwUWFZCMNRgDm7kCJOLnxunc2Cj7hKTDb5MIvoEmxOwAw2SDwYFxPcLJ/I3nqqbg5P0HTheIO6EpsvvO3hl2dyrq3VoH7pijXCk8rsNQxEKLNEvPJqu+HWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632599; c=relaxed/simple;
	bh=nwrkN9uc9z2M1DQPXzOJOpOvm5K9UgIMGJJb5KqYuJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWVhOE8Naco64Xs2fYnqMPJb8lng+T3O7jiv4c3uGm+hmCVciIF5/+PCVkRxHIpCiJChsLcolZIN374RnWanVFVo0MIedZSfgJy6m8Fk8qY/0qbIb4iIejNAvA4HdG2RqvDorQA+p9lP6uPcpEKtlMyrHPvroxOySmtEyE8kDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pay51SMK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 288A9E0006;
	Tue,  5 Mar 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709632590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX+5rMA8HaFPZvzB4A99eJcBrl7j5grxkkcSrE9QG+I=;
	b=Pay51SMKg+MFPEZLzIkQu8WBdqJ5ufqfFfZ67MaPo3m1SJHyQp30kcP6uDAsIlKz8xoIsD
	C9PCxELxEzvSPhuplMDuCtuw4MHAhU2AlRg0DT7pji4BNFKGEqKQCvfxeSsziNvASed6nD
	SNb8+wdTyCK4o4zuOhZwM4GisqEU1rP1TjM6u5cPtvbyWRhpZ7eh0ahbktDJdCo+udhf3P
	U4fVmmERduxQe9YDgUisPtiXbETzYs/D64fZzFlkdZWkcuXI8UgUOeQZ6iGX5azmN60JO2
	M0ABVV1KXpRc8Z52N+GjYIf5MLXthaREmHacNCd8lFuyMVVf2km5j9rxxtAR1Q==
Date: Tue, 5 Mar 2024 10:56:27 +0100
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
Message-ID: <20240305105627.1d277a76@kmaincent-XPS-13-7390>
In-Reply-To: <20240304184048.1c1724fa@kernel.org>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-2-455611549f21@bootlin.com>
	<20240304184048.1c1724fa@kernel.org>
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

On Mon, 4 Mar 2024 18:40:48 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 26 Feb 2024 14:39:53 +0100 Kory Maincent wrote:
> > Make the dev_get_hwtstamp_phylib function accessible in prevision to use
> > it from ethtool to read the hwtstamp current configuration. =20
>=20
> ethtool can't be a module, exports are only needed for code which ends
> up being called from modules.=20

Ah right!

> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index f07c8374f29c..7f78aef73fe1 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -4005,6 +4005,8 @@ int generic_hwtstamp_set_lower(struct net_device =
*dev,
> >  int dev_set_hwtstamp_phylib(struct net_device *dev,
> >  			    struct kernel_hwtstamp_config *cfg,
> >  			    struct netlink_ext_ack *extack);
> > +int dev_get_hwtstamp_phylib(struct net_device *dev,
> > +			    struct kernel_hwtstamp_config *cfg); =20
>=20
> since we don't expect modules to call this, how about we move dev_set*
> and the new declaration to net/core/dev.h ?

Ok for me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

