Return-Path: <linux-kernel+bounces-86390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841386C4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40001F23963
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D658ABD;
	Thu, 29 Feb 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fUQTkMoU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE758AA0;
	Thu, 29 Feb 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198272; cv=none; b=muCpaTDwLA2aMKUmacKTzDKMXpLtfm6dHomaDs8I+mBr155NiYWONjPT8OuRg/Fdu7DKiHJuMz7QeRtrsPfxh9FROfMd9xuGeyi+Zcpn3uctNDzBZvCErybesA9735oOim0OA1Xj8Qou69smZUgRSCnarbdNZ7SR4WXNVS6+DLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198272; c=relaxed/simple;
	bh=JC7LY6MOJvw096/9yY09D0IdT5x2U+eDx0fw6U/BXNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS5aoReEUFm4YDRhHIdBQwbNsVTvO4KiK1VDvQIPevNal/D0LpJ96rCWidjjyni+3PfTqcz6Owzxe/APWdQhrh4lEGUZZGpVS9A7leA8iSu45j++26e6ArUMuS+OMsrAioYDaMg7QM13rtaPsdQ1a4AKXygS8FOAidr4QbpkdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fUQTkMoU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56428FF80E;
	Thu, 29 Feb 2024 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709198262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC7LY6MOJvw096/9yY09D0IdT5x2U+eDx0fw6U/BXNY=;
	b=fUQTkMoU7i26EC3kV6o8BYQnUim5Gc1EEch3UbHe1RnYryma9zTl0y8fnl62/tGu3LLFRv
	rMK5NHv2e9Svo37t+K3eNpN2P0fvLLiiRa4siuiQtzqKuUBRflv2Wus6z20H8CYVbB9ZhM
	DxNk7JI2nIv+8k2gqcS3Kww82Xj0h8KjqrBq1IeNoGp6Uq1A4gdXBpGUvVfnsC4JaWcDx4
	cmMYamFSIQ4W9v2TPXmFzYxKONG2G/IPQ4zEnYVZcJ/jbpKBqdIufVZoVUDZzPbhC/dmT0
	UfQtNxhtRJUS8GmLs0VqG59JX/srrUBzaT0khFojQW+jfpT7tXQ/6hp3gvbI6w==
Date: Thu, 29 Feb 2024 10:17:39 +0100
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
Subject: Re: [PATCH net-next v9 06/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240229101739.2b1cdecb@kmaincent-XPS-13-7390>
In-Reply-To: <20240227192737.5d834155@kernel.org>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-6-455611549f21@bootlin.com>
	<20240227192737.5d834155@kernel.org>
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

On Tue, 27 Feb 2024 19:27:37 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 26 Feb 2024 14:39:57 +0100 Kory Maincent wrote:
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
> This one doesn't apply.
> It's going to be a pain to keep rebasing it, since its a nop AFAICT -
> do you want to post it separately to get it merged quickly?

Weird, it does on my side on net-next.
It would be great to have a review on the core of the new implementation
beforehand. I don't want this patch to be merged but not used at all if the
implementation does not fit what is expected. What do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

