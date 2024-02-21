Return-Path: <linux-kernel+bounces-74918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887985E008
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABA3B27265
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F280613;
	Wed, 21 Feb 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y6yTi2qQ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582307EF03;
	Wed, 21 Feb 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526421; cv=none; b=ejwueMlJyPtzNaCQZRtVb8PhYG7OABXAOFeUhpa8EIeijEWeFCVg/Gta7o2+DzcVOKrLvCZ1yQrflAlkepnuv/uDu3rm2wsjgMu0xlU4E+RgH5o09gm+9/O9Gfwik8LCiViuKNlq/7BltD1+vLbzoQniu1b/cQuQCzFU8FXxdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526421; c=relaxed/simple;
	bh=Vtj87ir413FfelSjrCQhZpK5ETcv5wHwL+6tPtbC/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgPb+phhpu8x/yCZhkwYs2ZBe3hfrdZ5qVR/YE6SK4o4o86rSFrYZolB3mqnNAEmbXlJ3pxKGtBNszAIK5pA/Q4QgcfLsB34KGgVnJ8Mk+66/fCjUi5IcNES0mipFcDpGarY8JhMJ3WVaVd8xMDsUt/CqUF37QZhleRSNlNJHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y6yTi2qQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44BA0C0005;
	Wed, 21 Feb 2024 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708526411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQm0Ki+vp+Zu8t/KqaIVW4arTM7ikJLGwDxFBBM8zRM=;
	b=Y6yTi2qQeizuS5QqtOVYt2nD/gLX1NBZSTTyeKh7qGJlx0SKp7Qbuom3BsiBfoyXIm1XBU
	89mGEKUeZo4PW7DXVu4VwkwHCZw81uvIl29JXXoe0nHedMk8bJWz/sMy+jMywiEaMSX6fU
	2R6XzTWuRfhe5/+FyRpfGc4dUN3LM82he24bmlACxF62NwzNTY65tL8eLSq9xR8ZflZcvF
	CXlqQ3azgASB6cZVNqsNtM0hzKIXEVikJzc1ThwlDphHdccIDb2nCAb/XrRJ5Mk4kZop0Y
	EO7Yns5A+Mti/OkLhpsNfzuzY94H0OB3oNUb2x5+VjgAaLV/xPyGlZvt92gHDw==
Date: Wed, 21 Feb 2024 15:40:06 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20240221154006.7ad2d66d@kmaincent-XPS-13-7390>
In-Reply-To: <11225a0d-bdc4-459c-9258-c9da217cc89e@lunn.ch>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
	<20240215105846.6dd48886@kernel.org>
	<20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
	<20240216173638.4bb12af2@kernel.org>
	<20240219160456.0b5e8de3@kmaincent-XPS-13-7390>
	<11225a0d-bdc4-459c-9258-c9da217cc89e@lunn.ch>
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

On Mon, 19 Feb 2024 16:44:34 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Feb 19, 2024 at 04:04:56PM +0100, K=C3=B6ry Maincent wrote:
> > On Fri, 16 Feb 2024 17:36:38 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote: =20
> > > > > but why the separate header? Is it going to be used in other part=
s of
> > > > > uAPI than just in ethtool?     =20
> > > >=20
> > > > We might use it in pse core if capabilities between PoE and PoDL di=
ffer
> > > > but I am not sure about it.
> > > > Do you prefer to move it to ethtool header and add prefix ETHTOOL_ =
to
> > > > the enum values?   =20
> > >=20
> > > I don't know enough to have an opinion :) Whatever you end up doing,
> > > it's probably worth documenting the reason for the choice in the comm=
it
> > > message? =20
> >=20
> > Mmh, I am still not sure of the best choice on this. I think I will mov=
e it
> > to ethtool as you suggested. =20
>=20
> kAPI is hard to change. So it is worth thinking about it.
>=20
> Can you think of any possible kAPI not using ethtool netlink? Its not
> going to be ioctl. We generally don't export new things in /sysfs if
> we have netlink, etc.
>=20
> So to me, it is only going to be used be the ethtool API, so i would
> follow the usual conventions for ethtool.

Oops sorry forgot to reply to you.
Indeed I reached to the same conclusion on my side.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

