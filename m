Return-Path: <linux-kernel+bounces-148290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEED8A8068
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C520EB234A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B413AA2D;
	Wed, 17 Apr 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cC2jJ09I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rnsDuuQH"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C4128807;
	Wed, 17 Apr 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348465; cv=none; b=bbX+SctYYUmEQT4rEwJuvTMZ+W4Y9lBPw03zVXANkh5363egYbzvkGs6nUwKqVHOuBbglm/DIzR+Nkhjy7SUwAAYZFShvxS1AngsbIiPAEURP1ZJBsqLXbcgR3A7m3Spvy26UByGseEPmStJvlniQ1NXCMrNDefxps/hq0yqkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348465; c=relaxed/simple;
	bh=/hPVDH/l/50vOuhlKj+xEGfXoIYzQz449xMEPLDiU10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbGNKQZ9iYC03mBY41fJisphFe2Qpmcdc5IhJsOMhINoQFBpa+0Hnhyoln/qNydQncy+o0k9+NlqrC99BwZUgYr87XIAd5fPa2NTU63AD3hpfiuVf/x76ZVqPtIGzXfqOTdtkIiGFFUwh4LMJf9t3TDczhoYPk4YpHjcWc1cZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cC2jJ09I; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rnsDuuQH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713348461; x=1744884461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P4jjLHNDzTJwlTjX0l1tjUZ36wXeBEDfuonIOwgdrMk=;
  b=cC2jJ09IBGpB8/JbqmWlkxvMdqLfKrifVvH82HNOHN0TDdB/ySaILK6G
   oTB0+NgsdJcGBXNL2GWsG9pzoY82SZUMN355FhqtZw2fRevVOo0l8wovW
   VZHikQeL3yWbPr9cxhj2dIVQP4PAtJ3gx46qfGuro5/AygzdUoUyoIQ66
   9RGcLMiqMBLmmyZHhMwAALnC1Y5hsj/meAUU+buqzscWvhLSGLkQLIJLw
   BL1AYMCr5mgS1yC73+ihhkimGLXTvYPSahWD4rzLs2iaEJU+yFBmWi61W
   vpyF+cdDqfdE+R/0T2+y/t4uAgH+V+Te08uTjSmjJ2ByKudebA++Bp3Sb
   A==;
X-IronPort-AV: E=Sophos;i="6.07,208,1708383600"; 
   d="scan'208";a="36464413"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 12:07:38 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFB271703EB;
	Wed, 17 Apr 2024 12:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713348454;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P4jjLHNDzTJwlTjX0l1tjUZ36wXeBEDfuonIOwgdrMk=;
	b=rnsDuuQHFmSNSZ0itQmLdJ4PzQNgKcfOmgivwmVBHf5dmbBT4Ru3Czmh46Or+baeXY/QR/
	mflfyya8wsE5fA8O2BsOZ3sLjul1rMVVc/H8S27iFdsh21i34ppaW/uEJ3FDBGmaEb4HRG
	bNcwpK0X10bP+APDMir9fzk51a11tCu9NnCmjhN+cFCGz/+PT1zU6qq4B/uQTUZnh8bZwh
	XNz/mbTCPgtzPwrofAYGXXaHUiV21QXm/TfiRFrJq6qC3E4ZNUU7nCWYO7iYCxkJlBrXq3
	ukdhTvWQLgoSxlhDhFGlKUk9leCacfvEVrfxZDy0Df55wTKlaGq69Dc1+KZHXg==
Message-ID: <6f64a875911eff522674e9a22b6dc23ec629db3a.camel@ew.tq-group.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xx: fix supported_interfaces setup
 in mv88e6250_phylink_get_caps()
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Wed, 17 Apr 2024 12:07:32 +0200
In-Reply-To: <5f09543db3de88e83116c5b2f6e3d9edbfdb4af8.camel@ew.tq-group.com>
References: <20240416155054.3650354-1-matthias.schiffer@ew.tq-group.com>
	 <Zh6trxU0hB+yt6rV@shell.armlinux.org.uk>
	 <5f09543db3de88e83116c5b2f6e3d9edbfdb4af8.camel@ew.tq-group.com>
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

On Wed, 2024-04-17 at 09:13 +0200, Matthias Schiffer wrote:
> On Tue, 2024-04-16 at 17:56 +0100, Russell King (Oracle) wrote:
> > On Tue, Apr 16, 2024 at 05:50:54PM +0200, Matthias Schiffer wrote:
> > > +int mv88e6250_port_get_mode(struct mv88e6xxx_chip *chip, int port,
> > > +			    phy_interface_t *mode)
> > > +{
> > > +	int err;
> > > +	u16 reg;
> > > +
> > > +	if (port < 5) {
> > > +		*mode =3D PHY_INTERFACE_MODE_INTERNAL;
> > > +		return 0;
> > > +	}
> >=20
> > Note that if mv88e6xxx_phy_is_internal() returns TRUE for the port,
> > then this will be handled automatically.
> >=20
> > > +
> > > +	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
> > > +		*mode =3D PHY_INTERFACE_MODE_REVMII;
> > > +		break;
> > > +
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
> > > +		*mode =3D PHY_INTERFACE_MODE_MII;
> > > +		break;
> > > +
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
> > > +		*mode =3D PHY_INTERFACE_MODE_REVRMII;
> > > +		break;
> > > +
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
> > > +		*mode =3D PHY_INTERFACE_MODE_RMII;
> > > +		break;
> > > +
> > > +	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
> > > +		*mode =3D PHY_INTERFACE_MODE_RGMII;
> > > +		break;
> > > +
> > > +	default:
> > > +		*mode =3D PHY_INTERFACE_MODE_NA;
> >=20
> > What does this mean? I don't allow PHY_INTERFACE_MODE_NA to be set in
> > the list of supported interfaces because it isn't an interface mode.
> > If it's invalid, then it's probably best to return an error.
> >=20
> > I wonder whether it would just be better to pass the
> > supported_interfaces bitmap into this function and have it set the
> > appropriate bit itself, renaming the function to something more
> > better suited to that purpose.
> >=20
> > Thanks.
>=20
> I'm explicitly checking for PHY_INTERFACE_MODE_NA in the caller to handle=
 the "this interface isn't
> useable" case. Passing supported_interfaces into the function handling th=
e port modes is fine with
> me, too - will send a v2 later.
>=20
> Best regards,
> Matthias

.. and I realize I don't even check for PHY_INTERFACE_MODE_NA in the calle=
r in the version of the
patch I submitted. Oh well, time for v2.


>=20
>=20
> >=20
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

