Return-Path: <linux-kernel+bounces-92574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBB872265
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF384B2349A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C51272B4;
	Tue,  5 Mar 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIGLpqWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54E126F2B;
	Tue,  5 Mar 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651125; cv=none; b=FFEiw0jR/1eID5pqFiHBJbo43qHC5MPw2l6Yr8TlKnin+BEAPfJeLQ0N+C8S9zAszsqjxo+KiG/yaqrdQZRnOKfSpghdJi9Vx/4vOPeQ0fCIhDZge75G7DQC86D+SmwBxIQaphCuZEJl27Oicn+0qNkleP0gtTg8DgKyKyqLnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651125; c=relaxed/simple;
	bh=oa8V2FuxjKUdYLS/9PBgK2zWedJ1BSk3Kddft+iXeSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+irZE3FVed65Ht/7h/hQxcgY3qexm+Jt27ysJfsAGIOlF0i6YQ3lrZoWYeyYv1fJOT/Sj5Ndu19rdyn7nfh0W8W+Sj9TasEXO2ZhGNX7uYk7xCJGFqi20KIy5XyryvXJOouZQ6IDZfV4LYhBMnhoC8w8OTCBiVRAxg6p6xUyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIGLpqWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8926C43390;
	Tue,  5 Mar 2024 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651124;
	bh=oa8V2FuxjKUdYLS/9PBgK2zWedJ1BSk3Kddft+iXeSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIGLpqWBcZGxv1iogMEV+qDw/QkkvcaClKKhiDzWOnv7GMauxBTK8XJv9bPZ6LZd2
	 umAJKCzddDP5rWWIcn6XBx6SPP5SyijmzJnNODgwpoYCE/bRYuz0tMRvOwmXoP0IyU
	 F0XSpEdQE96l4ociEM+O/0N3IK5MR7W8u2/ujs0Blqf6d0HIpn6FteXMQ6WVWDduHX
	 LTZB76xhIATOrWBZ56KtmnQrK/WnxeoDsIYiDRNjZM2H/oKreWwyBSG9Oh7aYzi+TF
	 gu2rlqZgTFW5Ys/OjpiXctM0VYmHO4nlJdYxq1VWst/R22Toani3riWH/JlZFCkx27
	 MulUdpVmKS+qg==
Date: Tue, 5 Mar 2024 07:05:22 -0800
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
Subject: Re: [PATCH net-next v9 02/13] net: Make dev_get_hwtstamp_phylib
 accessible
Message-ID: <20240305070522.7064e11a@kernel.org>
In-Reply-To: <20240305110233.2aca99f7@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-2-455611549f21@bootlin.com>
	<20240304184048.1c1724fa@kernel.org>
	<20240305105627.1d277a76@kmaincent-XPS-13-7390>
	<20240305110233.2aca99f7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 11:02:33 +0100 K=C3=B6ry Maincent wrote:
> > > since we don't expect modules to call this, how about we move dev_set*
> > > and the new declaration to net/core/dev.h ?   =20
> >=20
> > Ok for me. =20
>=20
> I replied to quickly.
> It seems this header in not include in ethtool part.=20
> This would imply adding #include "../core/dev.h" in the tsinfo.c file.
> Not sure this is what we want.

It's not amazing but I think that's better than putting internal stuff
in netdevice.h. ethtool is separated from core for code organization,
it's not really a separate entity, it controls very core things.

