Return-Path: <linux-kernel+bounces-143985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B78A4069
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A12C1F2134B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F31BF37;
	Sun, 14 Apr 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kjm/Dwpu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970411B7E9;
	Sun, 14 Apr 2024 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713072818; cv=none; b=krSsJ28dRVSOb3cJtPYeEYWgd0dFJWTKV1PnKiBlq77ST+4FinDXjJl1qe8dSxwd01DCnQU8yopj3zYFYioD4LbsXEFho5cOg3LP+7rVSQ/PnfzbYFPL8urGl1jvlFVIHxlUY5uaQLrQKZHjoMFR5ztwOEGa6pup4nCUINMdz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713072818; c=relaxed/simple;
	bh=v0O1wkR6wbnMmmQDu44nt7zPFp5nIQyL4vIoHfxOQXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAA/HL8nyf94muFbbzaqN0FFE4va6uvr8dlpW024o0nX1PeLVP7tDmxwm1VDzjGKmepXyaGFpyVpsg2rjnk+XIx18Pd9UfjDSv5BeI9zA9moQal5SofxBHbIW/tb5LinaN7JL/PJRKv0rCn/pG3l5vfgQpgtWT/xQDWYoGM4EkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kjm/Dwpu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CDEB1BF203;
	Sun, 14 Apr 2024 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713072807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUKnW0MYxp8X8CORgAZ0KT25kUnIRWHF8DdTNT1mliE=;
	b=Kjm/DwputspWyyw5H0eQjPK9H8b6cmGmKI8b4VmmflJxeo4FAJZlSboBiCnwGmo4z470mz
	K7szKldCeoiusuQcZ5XaVYeblBtoD6QRrWLMbEOgFXppp0YReDCb+nDhCLlPiTTBL08P/V
	nwZBdxcy0CnWZDcXbFw4xMhMknrFtjqtERXoqKHjCXBzHkyuLS7AhkXXA0SberDqzZw8ei
	0Z46GaofJB/ukzevDg0AiuomRb9qdKBFGnubhi5w1e5vMBH7zhoLPsUAMVit/gAhQUK62L
	MZ7KpC7bw9Qr5CeiHv7qsDHkHQNzXXLeNDVVLa3dUrwiZ4OhENJlAU+4HjxtMA==
Date: Sun, 14 Apr 2024 07:33:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jonathan Corbet <corbet@lwn.net>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v10 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20240414073315.5aa7adf0@kmaincent-XPS-13-7390>
In-Reply-To: <66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
	<20240409-feature_ptp_netnext-v10-8-0fa2ea5c89a9@bootlin.com>
	<66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
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

On Wed, 10 Apr 2024 23:00:53 -0400
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> > +/**
> > + * netdev_ptp_clock_register() - register a PTP hardware clock driver =
for
> > + *				 a net device
> > + *
> > + * @info: Structure describing the new clock.
> > + * @dev:  Pointer of the net device
> > + */
> > +
> > +extern struct ptp_clock *
> > +netdev_ptp_clock_register(struct ptp_clock_info *info,
> > +			  struct net_device *dev); =20
>=20
> No need for explicit extern?

Indeed I don't think it is needed.
I am wondering why few other functions uses it (ptp_clock_register,
ptp_clock_event, ptp_clock_index). Do you know?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

