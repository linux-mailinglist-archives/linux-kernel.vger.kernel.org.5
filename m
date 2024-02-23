Return-Path: <linux-kernel+bounces-78372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759A86129F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875951C215F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52907EEFC;
	Fri, 23 Feb 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MuRonoQJ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F897CF07;
	Fri, 23 Feb 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694796; cv=none; b=Wk2TSZQfBcw98Pnd0U7+ltiEneIEjmrIIVbnO72iKiJQvI9RuPLQVcB1KfQ7h5ChtoMyeOKKrqrrnZq9peBIrCUbajzDsdF+fITwQ5e+1j2c1F/pbzqS9sEzNXPx90vGxAZ22GbGYa6OK1KqcZvtIATQsdH1E7+i/NSB/1Bcvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694796; c=relaxed/simple;
	bh=Tf7aX/FTaRCDNtZO0MwhzruVt/DN0iFPEGYQkbTXuA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/g/Orz6ktuY9T6aVSIgUhIRl2Lg/oW5fwnebnF2L5TP/JP0uXdR1L3+v510acXZJRkysBl+PoXDyaWGBAEJBqR8M5zBba15GARbj1xxWfNkGHj/qTltHocaEUuftt12uW+9WMFxRGmAZdybklom+bDFGxZFwrIWlku2Gw8ZjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MuRonoQJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UTy1McEruUXSKAHy4z2drC9VelYQbaaKCTJThvXVjsc=; b=MuRonoQJX91hq0UD2clgjM/LdF
	kgvLk7QwNyrFS4er3KZib6MmkrN5q8iAzlqmGfphV5C017J2MATN0aCWC5hgqfTkr+UFcw3o1KiJ2
	HhvBCqJQHLMnK2BHCyKqIRpX3HKzYuRjP5vC2CHW1Wa8r3UMtGtQw8O1+SQqrRHVe+BiAJP0NqDy3
	KpEzC863VDDjNJJ7Doth0/PyS5g1lhEtN+ob6QUmOJE8D3V64J34fok7W1dZSu9jsOCoFhE/jmKms
	JQBgmXnb3rbAn388OWUra2tQnfMy9HpJ0ydnGOrffzOBbXwLTo23SEBv/2Xl6TZf7CCGCUglfrApE
	BuwNYDSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45362)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdVZF-00082u-2C;
	Fri, 23 Feb 2024 13:26:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdVZC-0003eN-AW; Fri, 23 Feb 2024 13:26:18 +0000
Date: Fri, 23 Feb 2024 13:26:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 23, 2024 at 02:17:59PM +0100, Andrew Lunn wrote:
> On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
> > On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> > > +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > > +				      struct ethtool_keee *data)
> > > +{
> > > +	if (phydev->eee_cfg.tx_lpi_enabled !=
> > > +	    data->tx_lpi_enabled) {
> > > +		eee_to_eeecfg(data, &phydev->eee_cfg);
> > > +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> > > +		if (phydev->link)
> > > +			phy_link_up(phydev);
> > 
> > I'm not convinced this is a good idea. Hasn't phylib previously had
> > the guarantee that the link will go down between two link-up events?
> > So calling phy_link_up() may result in either the MAC driver ignoring
> > it, or modifying registers that are only supposed to be modified while
> > the MAC side is down.
> 
> When auto-neg is used, we expect the link to go down and come back up
> again.
> 
> Here we are dealing with the case that autoneg is not used. The MAC
> needs informing somehow. If we want to preserve the down/up, we could
> call phy_link_down() and then phy_link_up() back to back.

Would it be better to have a separate callback for EEE state (as I
mentioned in another comment on this series?) That would be better
for future SmartEEE support.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

