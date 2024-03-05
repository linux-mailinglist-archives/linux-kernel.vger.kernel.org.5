Return-Path: <linux-kernel+bounces-92807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B3872634
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE8F1F2761A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4B1B96B;
	Tue,  5 Mar 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD+rzhRB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB91B950;
	Tue,  5 Mar 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661869; cv=none; b=eSDWaP1uZWbZ5SxhDTqAGbWMqA1P+7rccGLg8XWPdXcTwEJHOlH4UJ6CgF2FdqZHKgUOU25+S8NVVwT9rTTDQa/jwty1SDw7ADtAnvgASTEEIjfTNItgwMzfk1pMJRVt1Hae8AmsgceWxpYvLqW1AKhQO7Q3AfOR6w3DRgojGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661869; c=relaxed/simple;
	bh=8uBoflw7ylg6FwA/YZf/wgGJPgmGBD3bhaSObnhOsRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdgfTVdOEUfFRZa+TbZ2Djj57YEExrN6nTitEHJgFOFLBN6KhDxTTLgcXE9g0VPvIWEQ8bIpy0YFHLwRD98aficC+Yh6pS1RvStZ41ztqm+1L0thXf6q7kc23ym9jkubpQnrlKm8phpVb6qr+Drve/2F7w7uuESjZsDcwT9vb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD+rzhRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4968C43390;
	Tue,  5 Mar 2024 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661868;
	bh=8uBoflw7ylg6FwA/YZf/wgGJPgmGBD3bhaSObnhOsRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uD+rzhRBR3WZRsGzIXZIPVQJnZzb6q6XALgHCnBmj2DvCfYQ7F4ewgG+YPHXxa/4u
	 totVJc0mw9s8mQ6IpuaOyDciwZepaRg/MA1/KS75QfS9CZJcUSwJ70F6Aym4aoQW5h
	 twn9tWsAX4FAga0kos0DAOwEtFc9TKbt+yWrhLzWAfaanQyt0teTLRIH3iTnYNNBTW
	 ACoqVwWGYVxm0cw2ioVWkzSLGsh5X7GVXkmoJHO8DWQYGhvR8+/JRXl9jCzS/8NUWo
	 d1aUreWkh8Mr1GEqeN+dsXGkiAOT2i8tE8Xbg1wYk7/wvy+lY9xZioq4zKQvPlfNuU
	 b8FSYVWR4To/Q==
Date: Tue, 5 Mar 2024 10:04:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v9 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Message-ID: <20240305100426.5ed724f3@kernel.org>
In-Reply-To: <20240305175253.764f041a@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-12-455611549f21@bootlin.com>
	<20240304192733.1e8e08cc@kernel.org>
	<20240305175253.764f041a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 17:52:53 +0100 K=C3=B6ry Maincent wrote:
> > > +		/* Does the hwtstamp supported in the netdev topology */
> > > +		if (mod) {
> > > +			hwtstamp.ptp =3D ptp_clock_get_by_index(phc_index);   =20
> >=20
> > This just returns a pointer without any refcounting, right?
> > What guarantees the ptp object doesn't disappear? =20
>=20
> Could the ptp object disappears within rtnlock?

I believe so, yes.

> Maybe I should add refcounting.

