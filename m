Return-Path: <linux-kernel+bounces-71159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5985A178
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE015B216D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BC28E34;
	Mon, 19 Feb 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nI38QFIL"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8628DD0;
	Mon, 19 Feb 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340263; cv=none; b=Yu7pkKsJreqQCxamdgrOdWNBNICwgAYNmkUBg564lsOpXzu6BzUETkYwokrp52SbLH9P29LArdfPTjahT6t4O3I4y19Ms9vuwPIN7oVtZMCmnT6b3/whLltIGhNXn0YJz2yUCc9VscUP6d9yDfwFgEzCVCaYQKADEb7qYs8ilHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340263; c=relaxed/simple;
	bh=FsRYHVbp9tuQHI4J9Xv48IZ5RPikPqpgiZ6BV57fJt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzF44WFTaOUOQLSiSocguXZa/KjYOicLwyt1J+aaHJjKMs64F/G3dfTIsDQKquRIpk6rWqtRWCoQN9ycyCzagnvfdFFc3yxkaFYjxbufn231b/OdagJWip3ImHPohxO4S6rrlPVIdHYkpNHei692nHaV0ioNr6cCYVPac9EgQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nI38QFIL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE1D9FF803;
	Mon, 19 Feb 2024 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708340259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjw46L82Im/+NbPXXzGcB4oRwbdkB7kHEPgjm1bWJJA=;
	b=nI38QFIL7mTDl70sEBBsujtotl7H/QkDNtlUXzaiuYxYc8mYwsGMRfKTcXKAPFVmpp70ay
	ghxreXuYIX1KNsMxnp9TGj4BEV4NEZG8+wmUXP4nsR6LdregpG4Z/Rom5O0GXiNEg84VfX
	QSgqFLQr5Y69wsQpkkaEFs7M96/aF434Db09qVIyN2k/GQD+tnwxGpCLIssgfyW46F35aR
	OPaNcsx8/uR/ggHXSCfl1Z1TbfRPP/yCJ9Ls8XGwNuVxykIUtzVj0UJMntv0uzpmxDT53Z
	bjlDqmTyrfPfsBECzoRD3C+mHRsrNTczljzni65pQnaIjHPlFmuZNCUk4iVHpg==
Date: Mon, 19 Feb 2024 11:57:36 +0100
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
Subject: Re: [PATCH RFC net-next v8 06/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240219115736.7138a2a0@kmaincent-XPS-13-7390>
In-Reply-To: <87frxsgt4i.fsf@nvidia.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
	<20240216-feature_ptp_netnext-v8-6-510f42f444fb@bootlin.com>
	<87frxsgt4i.fsf@nvidia.com>
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

On Fri, 16 Feb 2024 10:27:32 -0800
Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:

> > +/**
> > + * struct kernel_ethtool_ts_info - kernel copy of struct ethtool_ts_in=
fo
> > + * @cmd: command number =3D %ETHTOOL_GET_TS_INFO
> > + * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMP=
ING
> > flags
> > + * @phc_index: device index of the associated PHC, or -1 if there is n=
one
> > + * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration
> > values
> > + * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumerat=
ion
> > values
> > + */
> > +struct kernel_ethtool_ts_info {
> > +	u32 cmd;
> > +	u32 so_timestamping;
> > +	int phc_index;
> > +	enum hwtstamp_tx_types tx_types; =20
>=20
> I might just be terrible at reading code, but isn't this what
> tx_reserved in ethtool_ts_info is for? I feel like using one of the
> reserved memspaces for this enum removes the need to make
> kernel_ethtool_ts_info? I might be missing something obvious however.

I did it to prepare the introduction phc_qualifier in patch 12. I am not su=
re it
would be wise to put it under tx/rx_reserved field. IMHO create a new kernel
structure is cleaner for that than the hack of using one of the tx/rx_reser=
ved
field.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

