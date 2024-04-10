Return-Path: <linux-kernel+bounces-138148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFF89ED51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882ECB25162
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8A13D61C;
	Wed, 10 Apr 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WA8TM38v"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223811C0DD9;
	Wed, 10 Apr 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736727; cv=none; b=LdkLJi6zulFDo2j4oQQcL3Ypq5F22r8m20sCyO+6ejl1eg9tBebJm2hDN0omh+MBxfgBGcZQZyWYaAgPAvMPzeiXgNK2s1b2MLFDZrsx6BeAO2QRX/+qAl3FL2YbGG7qh/Ye1h1Jjv1i6Qh6j1ClJL7ubw5VEPwIH08DXHbERH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736727; c=relaxed/simple;
	bh=v6RohLZhf7RHLMFs+sUQVcrNsRJwJufrk4MF7ek/Q7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igKZBQEdDaeM3ZcAH+R6uC/y4fX9NXTMaszAHhxJRqvTmSdnkGX4s3sq5ThWiJ2v5Xk4wrrkdN+YTcMNfB4MOPrulEtrjtKlP3yCXhGaKyftFTu8HdBc5LnUbgGehhwQZQzR7zQO2jkdbvfG6hBHiYwcdPv7x/X0oXAVROo24cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WA8TM38v; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0749220005;
	Wed, 10 Apr 2024 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712736723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6RohLZhf7RHLMFs+sUQVcrNsRJwJufrk4MF7ek/Q7I=;
	b=WA8TM38vhVlEmUH0wpVp8WLmuvQ9yLbg099JdJKi1rCaBht+YuzjRuiNZLpt6l4cIoAMs0
	AwU9VNr1R2iq5ygHhx1LdqRhh757t1zEQWkZUa/8GTfToDr531ymXRkeu5wgedMOFBGd7Q
	SWmfeQXXvGFSfrivTolvxh/b6hEhyy29uGGX8m8gONHxTF+MS+KifZXaVeJ0WrdTAtFTdj
	R+9tlPygwYeYDwZ+fNpXej8UfyW1Jfft9NYD+gpbiP9OxxJAQYG548ar495/h5oOXDn2f1
	bHx/0/eFEUamcglVUGEeRqlVhGhpZ2LMtJIEJsxupVaX/64MrWtGidleRygw5w==
Date: Wed, 10 Apr 2024 10:12:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
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
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v10 07/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240410101200.0178e594@kmaincent-XPS-13-7390>
In-Reply-To: <20240409182725.139856d5@kernel.org>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
	<20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
	<20240409182725.139856d5@kernel.org>
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

On Tue, 9 Apr 2024 18:27:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 09 Apr 2024 10:26:29 +0200 Kory Maincent wrote:
> > In prevision to add new UAPI for hwtstamp we will be limited to the str=
uct
> > ethtool_ts_info that is currently passed in fixed binary format through=
 the
> > ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> > already started operating on an extensible kernel variant of that
> > structure, similar in concept to struct kernel_hwtstamp_config vs struct
> > hwtstamp_config.
> >=20
> > Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> > we introduce the kernel-only structure in include/linux/ethtool.h.
> > The manual copy is then made in the function called by ETHTOOL_GET_TS_I=
NFO.
> > =20
>=20
> This one now conflicts :(
>=20
> Applying: net: Add struct kernel_ethtool_ts_info
> error: sha1 information is lacking or useless (drivers/net/phy/marvell_pt=
p.c).
> error: could not build fake ancestor

gnn patching my out of tree patch in the series! Sorry for that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

