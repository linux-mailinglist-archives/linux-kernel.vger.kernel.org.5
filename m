Return-Path: <linux-kernel+bounces-156893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88568B0A02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DE61F23EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC315B549;
	Wed, 24 Apr 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="R5kbLw91";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XMR3ziPw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A41219EA;
	Wed, 24 Apr 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962960; cv=none; b=fDTfeoc4D6aP49gpwuv9Gkep6c0LwukFdGoayzXLkTLtWhQ+2OIsi9rnGKO4yyhT5rDfp101fGAED6xL791P+zrDIGwb7VZIWmWwckVQ7jeYnoQXCmeyPsghPfCHzPeFgbErTm2nERnVONgkIEWSBarFRDt4TaQlB7ZqYHRVs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962960; c=relaxed/simple;
	bh=VdU+Xq3t2ScH+5gw2z0PqnIEUjrWzU/wrEXQ4Siljos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcao2beiki9w1+RgUP14QKoNjmgch8nwBbTFtUgWSMkfzZ5lQK+t/kIE6yFiF40b0QKCjuUe5jIjl2eD+j1qmHa1SFnTwASqEAxAYqlkT95Bb9Mei2F3CN9pHuaSpDzJ7hQ7Fgvnm+mV2js6kFE+KHk9GDTzlRDTQdRq9zXYxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=R5kbLw91; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XMR3ziPw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713962956; x=1745498956;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Nfzou4bPZHEFbM1qrzBnY6X7a0PW/6vDaAjCrguNNwM=;
  b=R5kbLw91zBmviiN8nUoTkpgGujjU74+EStk29BSOZrgzlyoGfINGD03N
   YqmM0w2GCGPAxB7+SUm2MMSfiF2JdsKmjKCm8umJFvgWE8ipgIUyXz4s+
   8azxOo3Ilsw8wpn9NDPwE68B6fswIjnAU2BWEFVwZ2yAMFM493erUuOwE
   HM8OHR1pMv3D1zjgTPy3Zqrx9RjmN7hAG4tF08Np8HaifGyJJfsll36S6
   0j+o+ZWt2Bcngt8zehra5p0goIwKgfiVguqSJKONLjhcP0ABcoMj6W5rt
   zy69AmB/Eirk0oBR8TKYbHO1FbWUDM8a2ajVC6G4wPxdzecivhCzhe6Ra
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,226,1708383600"; 
   d="scan'208";a="36591428"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Apr 2024 14:49:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 769131704ED;
	Wed, 24 Apr 2024 14:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713962949;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Nfzou4bPZHEFbM1qrzBnY6X7a0PW/6vDaAjCrguNNwM=;
	b=XMR3ziPw0K9k6la6ctKkef70lQo/JHakhQOLNUZId4/jeeRZHaubqInVH4APWt5GUR8uPr
	HdvlKpVgOGRDWMIpUIvyKgMd2v2adlzkR97fdaTQU9bZcEM+Yaq8hc/uQptXjvdN5TUnwV
	uNqDcAhTIYOIkNaO/nmFq92AVQBr1e5/utic4Uk69XOl0L292tWyHzyNm52/YPXMxhCEmi
	T7cOrnQ8RGa0irdw+8Z3y0EYrV3c1YRRgiBF/YZDLkh38nelFCMLf8U5jXIa4DKU/oH9L8
	EiinX9yyKDKLM5HMdFHfmweqxvKucwTojcQcse5MDDW8UC4G4AP8mopISLRLZA==
Message-ID: <1cb8bafb44075858221b31c056d75a40d7ba2ee1.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@ew.tq-group.com
Date: Wed, 24 Apr 2024 14:49:07 +0200
In-Reply-To: <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
	 <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2024-04-24 at 14:42 +0200, Andrew Lunn wrote:
> On Wed, Apr 24, 2024 at 02:10:22PM +0200, Matthias Schiffer wrote:
> > The embedded PHYs of the MV88E6020 (88E6250 family) switch are very
> > basic - they do not even have an Extended Address / Page register.
> >=20
> > This adds support for the PHYs to the driver to set up PHY interrupts
> > and retrieve error stats. The ethtool stat functions are slightly
> > refactored to allow dealing with different marvell_hw_stat definitions.
> >=20
> > The same code should also work with other 88E6250 family switches
> > (6250/6220/6071/6070), but it is unclear whether these use the same PHY
> > ID - the spec only lists the prefix 0x01410c00 and describes the lower
> > 10 bits as reserved, but that seems too unspecific to be useful, as it
> > would cover several existing PHY IDs already supported by the driver.
>=20
> This sounds like:
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/mv88e6xxx/=
chip.c#L3642
>=20
> So the DSA driver will fill in the lower bits, and it should work for
> all devices in the family.
>=20
> > @@ -4072,6 +4134,7 @@ static struct mdio_device_id __maybe_unused marve=
ll_tbl[] =3D {
> >  	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
> >  	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
> >  	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
> > +	{ MARVELL_PHY_ID_88E6020, MARVELL_PHY_ID_MASK },
> >  	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },
>=20
> Please follow the naming convention. MARVELL_PHY_ID_88E6250_FAMILY.
>=20
>        Andrew

We currently do not override the PHY ID for this family in the DSA driver -=
 my understanding was
that this is only necessary for switches that don't provide a usable PHY ID=
 at all. As I have no
idea if this PHY ID works for the whole family or just the single switch, I=
 went with the more
specific naming here.

Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

