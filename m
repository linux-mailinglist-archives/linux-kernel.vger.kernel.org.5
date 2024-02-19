Return-Path: <linux-kernel+bounces-71403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEEA85A4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF11C23670
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D457364A9;
	Mon, 19 Feb 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kQoj3e8z"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39536132;
	Mon, 19 Feb 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349385; cv=none; b=hD7VOzMgixgZ5p/GfMQxTU1kejpitECOTDfO8jvbyGjyd8NSe5bTazbzwrhnfs0cxgZzW1H3yLQ89CT2FENrrWIaA6WqU7Rnd7dyWRFxFcCwfG/fP8lxZcK1Q9HC909k6/vwGOE8w13TgpdwyS1fm4bed5maCFuWdWV2wDyw9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349385; c=relaxed/simple;
	bh=OQyFDUX5gbESQWUcHgynurH9W9y75J4IWsTxpX5PpzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPJDUcjOp/WF5f1qo9kaQxbe+HbiRh3/zCFpGi6EgIA26Y/hLWaBofhG7D3Q5sqmj9yFQ3X9m7qD9YIoEgWYCf8P84wjbqYaQKtjXB+bDhPu/yqbvzYuWJPS+YTGUgKdjU75VKFZAkWGSstI1wPtuRpHvYm1Qqa4DpCuMoatA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kQoj3e8z; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5AE4C0004;
	Mon, 19 Feb 2024 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708349380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQyFDUX5gbESQWUcHgynurH9W9y75J4IWsTxpX5PpzE=;
	b=kQoj3e8zggZx2HUbzNGgWUvjl2tZdpNnjmi4YvhYNDGXFf1skWEjdAKvqJWKaoNj/BYILQ
	xyVEfh1+5RIdu5fgIH6I41uVO9vbJSwEoj5EOUC2oEl/3QfMIpgyDWGTGfLP629NIEhrsI
	49HDHeoae5n+S0zfOSAlI0rU1QwlOwTP0uomYquWROLogGyz++hr+sCAx27WKFQW73J654
	vElGXZ4UaOzyORHSkQZHdnK7xKuJNX3UIxzstXU+HilraGFtZUaltQGJdBBCH/XjzUr5Vq
	V+uSk9HBY1dYxv159NlYgR7c6QCmvC4eTeKO4ou8IiR1K2Z6HqrJqGCVLtrqgA==
Date: Mon, 19 Feb 2024 14:29:36 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Message-ID: <20240219142936.62112d34@kmaincent-XPS-13-7390>
In-Reply-To: <87jzn4gtlv.fsf@nvidia.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
	<20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
	<87jzn4gtlv.fsf@nvidia.com>
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

On Fri, 16 Feb 2024 10:09:36 -0800
Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:

> On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootlin.=
com>
> wrote:
> > Change the API to select MAC default time stamping instead of the PHY.
> > Indeed the PHY is closer to the wire therefore theoretically it has less
> > delay than the MAC timestamping but the reality is different. Due to lo=
wer
> > time stamping clock frequency, latency in the MDIO bus and no PHC hardw=
are
> > synchronization between different PHY, the PHY PTP is often less precise
> > than the MAC. The exception is for PHY designed specially for PTP case =
but
> > these devices are not very widespread. For not breaking the compatibili=
ty
> > default_timestamp flag has been introduced in phy_device that is set by
> > the phy driver to know we are using the old API behavior.
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > --- =20
>=20
> Overall, I agree with the motivation and reasoning behind the patch. It
> takes dedicated effort to build a good phy timestamping mechanism, so
> this approach is good. I do have a question though. In this patch if we
> set the phy as the default timestamp mechanism, does that mean for even
> non-PTP applications, the phy will be used for timestamping when
> hardware timestamping is enabled? If so, I think this might need some
> thought because there are timing applications in general when a
> timestamp closest to the MAC layer would be best.

This patch comes from a request from Russell due to incompatibility between=
 MAC
and PHY timestamping when both were supported.
https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/

His point was adding PTP support to a PHY driver would select timestamp fro=
m it
by default even if we had a better timestamp with the MAC which is often the
case. This is an unwanted behavior.
https://lore.kernel.org/netdev/Y%2F6Cxf6EAAg22GOL@shell.armlinux.org.uk/

In fact, with the new support of NDOs hwtstamp and the
dev_get/set_hwtstamp_phylib functions, alongside this series which make
timestamp selectable, changing the default timestamp may be not necessary
anymore.

Russell any thought about it?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

