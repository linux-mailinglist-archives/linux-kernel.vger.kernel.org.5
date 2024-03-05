Return-Path: <linux-kernel+bounces-92566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292A87223B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F4228690C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75FC126F31;
	Tue,  5 Mar 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WngndaV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E9126F15;
	Tue,  5 Mar 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650782; cv=none; b=ifJQ5gaDBPIWM7TsCmZQ77FnrfPRsC+Sp0r9jcjdWeJBQay+QZHLYtZKc6O8QSobLB3pERskussgQ5i/V4346CREbvGg9z8iNQAYn1Pcq4xknz37h8qGWP/kI/6nCSub/sbOdlGYHeMQxc6sP6zUVeU9skM3gG9NZEM7RLju/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650782; c=relaxed/simple;
	bh=r7pHATTXsaw9KxP9JeujvJcXEY4p72TqyQOmikllC28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP6AmPv/Xrf2fCLY3qswfZly+RRim9wFHDHVP9oaCHp6+WOowHgbb2qyKHKwDII/r4aV7wSSUp/qsXlBqjkhKzrgRrli70D9drnaAecC653DaFJ/RwpoJxpLDbjcWTGE+fyGk0gHkLhR2m7d6rwuSH4oli8Rg5ma1cY4PseA1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WngndaV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E0BC433C7;
	Tue,  5 Mar 2024 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650781;
	bh=r7pHATTXsaw9KxP9JeujvJcXEY4p72TqyQOmikllC28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WngndaV1RjE7JGASzCD+VpcR2p1lRbqc38SHo5fRRIGTKrFBwilKmNmRbWzExpJ4J
	 6f+lC5fNlxIhIl7og1GKKEmwQ9aLZO2utIsSDi0mJoHTKKRLQ4UPUrw0T7n6hk3Wjd
	 yK8xn+zkPOspdQQb0wgRvJ0w6K+ovbbpZUGXuedzUAEcUvPREe+uUq9jHkgaPTNsSh
	 D+kKI3HeNngyCUE47n71g37zaFd6i0LDn70wRYvThgnC8+d0oMnRtLyw/lZWJSjmWX
	 nWDgKG0zdaaEq7zaNeTuHfi27PAh2JsRUhJ4eRal1Nybr3aqVjoK6zcCIHbEn3TPLf
	 yIf+6T5L67nMA==
Date: Tue, 5 Mar 2024 06:59:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20240305065939.2d419ff2@kernel.org>
In-Reply-To: <20240305111021.5c892d5a@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
	<20240304185734.5f1a476c@kernel.org>
	<ZebZpspMCqjLES/W@shell.armlinux.org.uk>
	<20240305111021.5c892d5a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 11:10:21 +0100 K=C3=B6ry Maincent wrote:
> > No. In the case of mvpp2 + marvell PHY, the two PTP implementations are
> > entirely separate. =20
>=20
> Yes the PTP clock can be independent from the netdev.
> We need to know which software layer register the PHC to be able to call =
its
> callbacks.
>=20
> My commit log is a bit small here. I will enhance it in the next version.

Still, wouldn't it be simpler to store all accessible PTP instances=20
in the netdev?

