Return-Path: <linux-kernel+bounces-148036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6158A7CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178EE1C20F02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390474401;
	Wed, 17 Apr 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AKWXqiV5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tgRR7L8b"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF076BB58;
	Wed, 17 Apr 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338046; cv=none; b=SsqD9i1mvejw7diiwL0VJPmjsoPdNZf4gYe+RmiSv3lwjQ+/sus8q8dkaSGePoWLXMfu2LMa55FF11RxUo7a74RVF3FG/nQFJbgV0MGiGucgRByyv6gjElSvUns+fcGW52cdj9HOq4dw2Tpytbev0W0o3MIdtum286GwrZaqJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338046; c=relaxed/simple;
	bh=2nnsV0uLoPgUeurBDIa4GBCWTyyWDiXq5bRAlfYpg4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRr1WxO4YWHBYNBTS43Bo5sPaQ0zqQci3Em5jCpNsNGudbgpKdmXFhj3dyJNhbVBgc/yZv2hobDev4lDsx99h7/mk3X8CqdbeV5NDTZFIe1HcXxiPIG4/GXnzEhQRZ06lwXl3Ro5SGS5d3bapN8wojKI4CXF3djM8ddfnF0sUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AKWXqiV5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tgRR7L8b reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713338043; x=1744874043;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AIBoe2UB0IuhJBhgewIF7D7CI6oTfNKrjyGYqYG2X9U=;
  b=AKWXqiV5nIt+XZA9peXXOElpnC/I9NJSGQ/FeuDa5Solae2Ga6WW/8+L
   1uUdFEz+p9iKDU+fqGUZH5j6ifCBs8OYhJZS6VQKXAv6CQ3GY32CRCZpH
   Dms6f3dUmOxGQoP8yQxJWs5cLS4KFpUYQejF5igRuxqB+ehf941C8NFBt
   1JbTCPjljWvk2Yk8eHCtt4/WatrPBny+ZzGSz36/pKZ/aDX8zUEUNhUMi
   S8pPsfJFd6yYSNzD6aqHo2Uj6Gc7xoYtRhHr478yED8asb3nYSc5tYK16
   sQ56uYg8ViCtx3QslYuwhjLG8PCOTpdjrICvcCdmi5WHbOzJ2LUtLnrP6
   w==;
X-IronPort-AV: E=Sophos;i="6.07,208,1708383600"; 
   d="scan'208";a="36457832"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 09:13:59 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E4A0170497;
	Wed, 17 Apr 2024 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713338035;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AIBoe2UB0IuhJBhgewIF7D7CI6oTfNKrjyGYqYG2X9U=;
	b=tgRR7L8bYEKCdtgxRTHAJ13xwvZlyRCC0XUcm/7v80/I5AKlMpKS58FkLQYDA4H3hF/7n0
	GiH2rjaKtanmM/MVctm0o15YAlmy4Nn/RKyvpAOvz6wLVQivYl37UMo4c1pncXFt5pnVx1
	VYzWo7Omvy6rl9LBuoxYdESTm5rjvrYuOKFhiM8L8nrnDiySyjsZeZgMCTgpcNKtdKo0lc
	3R7XtWptjmzH1Ne8Fr3BfFQtrUWjxweqVzVHG9R5f33ZmWUlYG4xVysJCuohsZI0JhSWGm
	Hcceymo8upob/za93iF245MUgo6J7SL4akT4B5f1IgQ4vpGsWIeTIrCfNsNN/w==
Message-ID: <5f09543db3de88e83116c5b2f6e3d9edbfdb4af8.camel@ew.tq-group.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xx: fix supported_interfaces setup
 in mv88e6250_phylink_get_caps()
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Wed, 17 Apr 2024 09:13:53 +0200
In-Reply-To: <Zh6trxU0hB+yt6rV@shell.armlinux.org.uk>
References: <20240416155054.3650354-1-matthias.schiffer@ew.tq-group.com>
	 <Zh6trxU0hB+yt6rV@shell.armlinux.org.uk>
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

On Tue, 2024-04-16 at 17:56 +0100, Russell King (Oracle) wrote:
> On Tue, Apr 16, 2024 at 05:50:54PM +0200, Matthias Schiffer wrote:
> > +int mv88e6250_port_get_mode(struct mv88e6xxx_chip *chip, int port,
> > +			    phy_interface_t *mode)
> > +{
> > +	int err;
> > +	u16 reg;
> > +
> > +	if (port < 5) {
> > +		*mode =3D PHY_INTERFACE_MODE_INTERNAL;
> > +		return 0;
> > +	}
>=20
> Note that if mv88e6xxx_phy_is_internal() returns TRUE for the port,
> then this will be handled automatically.
>=20
> > +
> > +	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
> > +	if (err)
> > +		return err;
> > +
> > +	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
> > +		*mode =3D PHY_INTERFACE_MODE_REVMII;
> > +		break;
> > +
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
> > +		*mode =3D PHY_INTERFACE_MODE_MII;
> > +		break;
> > +
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
> > +		*mode =3D PHY_INTERFACE_MODE_REVRMII;
> > +		break;
> > +
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
> > +		*mode =3D PHY_INTERFACE_MODE_RMII;
> > +		break;
> > +
> > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
> > +		*mode =3D PHY_INTERFACE_MODE_RGMII;
> > +		break;
> > +
> > +	default:
> > +		*mode =3D PHY_INTERFACE_MODE_NA;
>=20
> What does this mean? I don't allow PHY_INTERFACE_MODE_NA to be set in
> the list of supported interfaces because it isn't an interface mode.
> If it's invalid, then it's probably best to return an error.
>=20
> I wonder whether it would just be better to pass the
> supported_interfaces bitmap into this function and have it set the
> appropriate bit itself, renaming the function to something more
> better suited to that purpose.
>=20
> Thanks.

I'm explicitly checking for PHY_INTERFACE_MODE_NA in the caller to handle t=
he "this interface isn't
useable" case. Passing supported_interfaces into the function handling the =
port modes is fine with
me, too - will send a v2 later.

Best regards,
Matthias


>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

