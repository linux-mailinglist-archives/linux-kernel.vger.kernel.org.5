Return-Path: <linux-kernel+bounces-89535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29786F1AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9212F28356A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977662BB12;
	Sat,  2 Mar 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q7cc409v"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453D2576E;
	Sat,  2 Mar 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709400828; cv=none; b=vFHFLni5t/9mqQZrVafb606YoVm/ThKUKUjKgjUjBVqrL6pTCsofKBmz9QByBRulgS2+BmipjepMsz7lEu1HKcYUton3iQZ3XBCTaqgGWSn8rmBJrzNpN0pzX1BjeUSyjF33shIOL4tlCif3cEKVRfcS4vDSiq9Exz0VSRfpOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709400828; c=relaxed/simple;
	bh=7wzKlRr3KNoyYV+XJySI9N+Suy6+yQ4gF1JspQ+dKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyHrKNf4Uyz+GruAm/Bkhdwya4SgaxNmPXY0o/uJPWac1Kqx6Iy78Rraw3vc9V6JGiJvreKaKchFFHgtBOMPu8WJqHgybtNns4b6hp7vrPdOs7NEJzlXpWqN2Nf3sL2xgaSi80aFkjLta6chWpfJJKUvo1oe4DnP1KOkucZF0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q7cc409v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SCSvTS84dtDPixkR5UknuDrt5ZxGw8Irc52+regEcFc=; b=Q7cc409vjN3T4oKQsoWEker1H4
	ihswIy+PKzLflbmvDzFw9rL3tEx0LSq3SRznJGoJneHaACzJYOhq37zR3aI6fR5kMv9d79aJgzFAY
	WRHhlqbug1shcyQ+SojkZmUAxvn9iGCOjao52aHHEsmL3POhjqibA1ZPTRFLmHkODFITQaEJg8BTj
	82ICoDNChrJ0M4pRUnXIAgIfBIFiQoUOImwWKMiK5Mm5zEIfXUEvlsK7KVvM44j9RKELdvLe1Z0AR
	MFdU8i4kP8RtWldorVIyQz/MOh4maLHE/1S0/3l6jMPH+1Mx37uPMyIUCFhDRS2dj1B1eAjCr8Jpz
	cWxmokKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rgT7N-0002nv-2e;
	Sat, 02 Mar 2024 17:25:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rgT7K-0002oq-1G; Sat, 02 Mar 2024 17:25:46 +0000
Date: Sat, 2 Mar 2024 17:25:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v8 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Message-ID: <ZeNhGURTEfzwhikL@shell.armlinux.org.uk>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-4-o.rempel@pengutronix.de>
 <d550b591-cd83-4ac6-8fd5-f5e0e2ad71d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d550b591-cd83-4ac6-8fd5-f5e0e2ad71d9@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 02, 2024 at 06:16:34PM +0100, Heiner Kallweit wrote:
> On 01.03.2024 11:01, Oleksij Rempel wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > 
> > The MAC driver can request that the PHY stops the clock during EEE
> > LPI. This has normally been does as part of phy_init_eee(), however
> > that function is overly complex and often wrongly used. Add a
> > standalone helper, to aid removing phy_init_eee().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/phy/phy.c | 20 ++++++++++++++++++++
> >  include/linux/phy.h   |  1 +
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 2bc0a7d51c63f..ab18b0d9beb47 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -1579,6 +1579,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
> >  }
> >  EXPORT_SYMBOL(phy_mac_interrupt);
> >  
> > +/**
> > + * phy_eee_clk_stop_enable - Clock should stop during LIP
> > + * @phydev: target phy_device struct
> > + *
> > + * Description: Program the MMD register 3.0 setting the "Clock stop enable"
> > + * bit.
> > + */
> > +int phy_eee_clk_stop_enable(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&phydev->lock);
> > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
> > +			       MDIO_PCS_CTRL1_CLKSTOP_EN);
> > +	mutex_unlock(&phydev->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(phy_eee_clk_stop_enable);
> > +
> I don't see a user of this function in the series.
> Based on the commit description, wouldn't it be better to
> make this patch part of a future series removing
> phy_init_eee()?

That depends who is going to do that work. If it's individual driver
maintainers, then I think we want this to go in along with this series
so that we don't end up with individual driver maintainers having to
carry this patch, and submissions ending up with multiple copies of
this patch or depending on other maintainers submissions.

On the other hand, if someone is going to go through all the network
drivers and update them as one series, then it probably makes more
sense to move this to that series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

