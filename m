Return-Path: <linux-kernel+bounces-63573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FD853192
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25251F234CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEB15578B;
	Tue, 13 Feb 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="WWtpkNP1"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F15482DA;
	Tue, 13 Feb 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830250; cv=none; b=p58hGz1080WaBIw/iebBbv3QsYJZlJonpAAEiN4YYeaopnRuz8lGq5MOvl8QX40rq8exyZJQUApgQmJWJDp0vvSS6AoA/mq72p65rmGYpwYqGHXGpILaP2bhRgl7tD1TsefXVW0IVBeqt7YcUc1tpwJ8bjxg2yKdsCpYKSGiH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830250; c=relaxed/simple;
	bh=jsW7Dd3TmL2Apaja+UufhnCsfH+q6gNeYmS5eODj+ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiFl9oTMIPwJk6BSWR1ghkskKrBYE0twyJWoGYkEcRyrR3IiQPja8bo6r4kodi48fOKtOJ0TUJecRcRZBYAamfgxlxijWWGGblWevSrfiaRgUbcSvjjali49ohAqEeNBefNzfx5/Jdk/JtVv0avsN1p5J55KOFIOTHAnh+ZTULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=WWtpkNP1; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id 24EE56F00E4;
	Tue, 13 Feb 2024 14:07:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1707829657;
	bh=jsW7Dd3TmL2Apaja+UufhnCsfH+q6gNeYmS5eODj+ao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WWtpkNP17wz7326yaVL8jqY5UBqW3JhQjlR0AlPt90vYhxIo/hTivU+dOSH6+6O+B
	 0XUJfjVYTc+Ue5dAnGvCn//OFJxCKBp1qjIWdt/6Y6rPe+5zRDCSmAnOIqT1zUtReS
	 0igb/iz/q7+5Ds5xWv+/Agzc9RkHhQjTLAfIFTufpIwdgSQD0oMc10fda/drAtTmQA
	 K+0XWl5U8H5YHJvmn+KYy4/ZK3UwWiWKCelgW/Ofr8LMQ6XNsa2VLbrWJ62GqH4qqX
	 XelwXJBwb1gfgKeIThQwfuUk4y6iKrG+1qfxxErndZ2Q7G+xQxBkuXT5m71oQhrkKH
	 jVmh8n3xRvPLg==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cOL2cd5_kG_X; Tue, 13 Feb 2024 14:07:34 +0100 (CET)
Received: from [IPv6:2a01:c23:7cd0:5500:82a2:35d6:b461:cb6a] (dynamic-2a01-0c23-7cd0-5500-82a2-35d6-b461-cb6a.c23.pool.telefonica.de [IPv6:2a01:c23:7cd0:5500:82a2:35d6:b461:cb6a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 1C1076F00D8;
	Tue, 13 Feb 2024 14:07:34 +0100 (CET)
Message-ID: <7b985e81cc0e7f8f3dab939a097ebeecd78f9477.camel@osasysteme.de>
Subject: Re: [PATCH v2] net: phy: dp83822: Fix RGMII TX delay configuration
From: Tim Pambor <tp@osasysteme.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 14:07:01 +0100
In-Reply-To: <63d59bff272f572c94f97000475c4ac3e157c013.camel@redhat.com>
References: <20240204101128.49336-1-tp@osasysteme.de>
	 <63d59bff272f572c94f97000475c4ac3e157c013.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paolo,

On Thu, 2024-02-08 at 11:12 +0100, Paolo Abeni wrote:
> On Sun, 2024-02-04 at 11:11 +0100, Tim Pambor wrote:
> > The logic for enabling the TX clock shift is inverse of enabling
> > the RX
> > clock shift. The TX clock shift is disabled when
> > DP83822_TX_CLK_SHIFT is
> > set. Correct the current behavior and always write the delay
> > configuration
> > to ensure consistent delay settings regardless of bootloader
> > configuration.
> >=20
> > Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf=C2=A0p. 69
> >=20
> > Fixes: 8095295292b5 ("net: phy: DP83822: Add setting the fixed
> > internal delay")
> > Signed-off-by: Tim Pambor <tp@osasysteme.de>
> > ---
> > Changes in v2:
> > =C2=A0 - Further cleanup of RGMII configuration
>=20
> This overall makes the change more invasive, I'm unsure is in the
> direction pointed by Russell
>=20
> > =C2=A0 - Check for errors setting DP83822_RGMII_MODE_EN
> > ---
> > =C2=A0drivers/net/phy/dp83822.c | 41 +++++++++++++---------------------=
-
> > ----
> > =C2=A01 file changed, 14 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> > index b7cb71817780..1b2c34a97396 100644
> > --- a/drivers/net/phy/dp83822.c
> > +++ b/drivers/net/phy/dp83822.c
> > @@ -380,42 +380,29 @@ static int dp83822_config_init(struct
> > phy_device *phydev)
> > =C2=A0{
> > =C2=A0	struct dp83822_private *dp83822 =3D phydev->priv;
> > =C2=A0	struct device *dev =3D &phydev->mdio.dev;
> > -	int rgmii_delay;
> > -	s32 rx_int_delay;
> > -	s32 tx_int_delay;
> > +	int rcsr_mask =3D DP83822_RGMII_MODE_EN;
> > +	int rcsr =3D 0;
> > =C2=A0	int err =3D 0;
> > =C2=A0	int bmcr;
> > =C2=A0
> > =C2=A0	if (phy_interface_is_rgmii(phydev)) {
> > -		rx_int_delay =3D phy_get_internal_delay(phydev, dev,
> > NULL, 0,
> > -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true);
> > +		rcsr |=3D DP83822_RGMII_MODE_EN;
> > =C2=A0
> > -		if (rx_int_delay <=3D 0)
> > -			rgmii_delay =3D 0;
> > -		else
> > -			rgmii_delay =3D DP83822_RX_CLK_SHIFT;
> > +		/* Set DP83822_RX_CLK_SHIFT to enable rx clk
> > internal delay */
> > +		if (phy_get_internal_delay(phydev, dev, NULL, 0,
> > true) > 0)
> > +			rcsr |=3D DP83822_RX_CLK_SHIFT;
> > =C2=A0
> > -		tx_int_delay =3D phy_get_internal_delay(phydev, dev,
> > NULL, 0,
> > -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
> > -		if (tx_int_delay <=3D 0)
> > -			rgmii_delay &=3D ~DP83822_TX_CLK_SHIFT;
> > -		else
> > -			rgmii_delay |=3D DP83822_TX_CLK_SHIFT;
> > +		/* Set DP83822_TX_CLK_SHIFT to disable tx clk
> > internal delay */
> > +		if (phy_get_internal_delay(phydev, dev, NULL, 0,
> > false) <=3D 0)
> > +			rcsr |=3D DP83822_TX_CLK_SHIFT;
> > =C2=A0
> > -		if (rgmii_delay) {
> > -			err =3D phy_set_bits_mmd(phydev,
> > DP83822_DEVADDR,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MII_DP83822_RCSR,
> > rgmii_delay);
> > -			if (err)
> > -				return err;
> > -		}
> > -
> > -		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
> > -					MII_DP83822_RCSR,
> > DP83822_RGMII_MODE_EN);
> > -	} else {
> > -		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
> > -					MII_DP83822_RCSR,
> > DP83822_RGMII_MODE_EN);
> > +		rcsr_mask |=3D DP83822_RX_CLK_SHIFT |
> > DP83822_TX_CLK_SHIFT;
>=20
> It looks like there is a change of behavior here. The current code
> clear the DP83822_RGMII_MODE_EN, while this patch will clear
> DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, leaving
> DP83822_RGMII_MODE_EN unmodified.

The behavior of DP83822_RGMII_MODE_EN should not have changed.
DP83822_RGMII_MODE_EN is always set in rcsr_mask and if the interface
is RGMII, DP83822_RX_CLK_SHIFT and DP83822_TX_CLK_SHIFT are added to
the mask as well.

I also have tested this patch on hardware with a DP83822 phy in RGMII
mode.

>=20
> It does not look correct to me.
>=20
> Cheers,
>=20
> Paolo
>=20


