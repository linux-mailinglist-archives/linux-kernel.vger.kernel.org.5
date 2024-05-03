Return-Path: <linux-kernel+bounces-168374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57C8BB7B2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426ABB24E46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C183A1A;
	Fri,  3 May 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nqvsmtiu"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731E5A4D1;
	Fri,  3 May 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776089; cv=none; b=RP0th63Ymb/O8X90kZC/0ieQdHTFY6pRml18nd66texmIyO5LjRP2Da/kFugyt2enrv9OUD8QORObd+KRCNEGdSx1ittt8JdI9jtaBUOgEw3qJxUXdmf7BABe+DrqrwcjgBj2NEO07yEBpi7/v7p9sjiWDtXDJ8uWRINSLVOUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776089; c=relaxed/simple;
	bh=RbTEJRV19W8aUV25aicB9Lc9FGKSV9i7uBy5lh277iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVXO6QdrwhH0W9KTfZseR1bZZhv7h3O7+i+fk9CZ2HCsE4KrR8GEEUbb6U0Vi0TaxNrF3S3fa2bi3zxsGerrNULRLDBlZlxdLqVmyBR9p6iFmjC3emp1jaG20/H60UZPAsZ0jV68NHvRlmUeSTpC9S9D4HtPxtI5LwuYN5ps8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nqvsmtiu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YbCgkPFJ7uX0DwyxFD5pk3vPIn/OhpmKwMp9kOGE4Vs=; b=NqvsmtiuTI8ZAQwI9lJ4o9s5yR
	M4Qyd6viYX5AMAvYmHXavG4DMapBiPHPJOlbDIulrPS/aSUU6IQfxRG9b1GZ46d9jGxPJSirgpYkK
	wyY4SLEULF2hpq2dgfoMgsTGmzcgnye4gDWRtR0GGrKQeVZ9YKkZ+hErd9crdnnDoRFkrWltqdoIU
	WbyJtZrx0wJM37LjJrzo22eOG2JKusyAyHVPbbO89qez1bLsPC73EZ1sfE6VJ96gq92/UconGPHIk
	GZpOKL0VYzMLOIhL2N0lmMbj2Cpwk/jWa17xzpbBganpT2ggHKEYRyTBQ650dMWFVCOpqu02NmJ4+
	p12haisA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49644)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s31aT-0000W0-1K;
	Fri, 03 May 2024 23:41:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s31aR-0004x5-Hl; Fri, 03 May 2024 23:41:03 +0100
Date: Fri, 3 May 2024 23:41:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <ZjVn/5KD72zKEcnK@shell.armlinux.org.uk>
References: <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
 <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
 <ZjOYuP5ypnH8GJWd@eichest-laptop>
 <ZjOftdnoToSSsVJ1@shell.armlinux.org.uk>
 <ZjUSaVqkmt7+ihTA@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUSaVqkmt7+ihTA@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 03, 2024 at 06:35:53PM +0200, Stefan Eichenberger wrote:
> On Thu, May 02, 2024 at 03:14:13PM +0100, Russell King (Oracle) wrote:
> > On Thu, May 02, 2024 at 03:44:24PM +0200, Stefan Eichenberger wrote:
> > > Hi Russell,
> > > 
> > > Sorry for the late reply but I wanted to give you some update after
> > > testing with the latest version of your patches on net-queue.
> > 
> > I've also been randomly distracted, and I've been meaning to ping you
> > to test some of the updates.
> > 
> > http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> > 
> > The current set begins with:
> > 
> > "net: sfp-bus: constify link_modes to sfp_select_interface()" which is
> > now in net-next, then the patches between and including:
> > 
> > "net: phylink: validate sfp_select_interface() returned interface" to
> > "net: phylink: clean up phylink_resolve()"
> > 
> > That should get enough together for the PCS "neg" mode to be consistent
> > with what the MAC driver sees.
> > 
> > The remaining bits that I still need to sort out is the contents of
> > phylink_pcs_neg_mode() for the 802.3z mode with PHY, and also working
> > out some way of handling the SGMII case where the PHY and PCS disagree
> > (one only supporting inband the other not supporting inband.)
> > 
> > I'm not sure when I'll be able to get to that - things are getting
> > fairly chaotic again, meaning I have again less time to spend on
> > mainline... and I'd like to take some vacation time very soon (I really
> > need some time off!)
> 
> No problem, I'm also quite busy at the moment and I have the workaround
> to test the hardware, so it is nothing urgent for me.
> 
> > > I think I see the problem you are describing.
> > > 
> > > When the driver starts it will negotiate MLO_AN_PHY based on the
> > > capabilities of the PHY and of the PCS. However when I switch to 1GBit/s
> > > it should switch to MLO_AN_INBAND but this does not work. Here the
> > > output of phylink:
> > 
> > I'm designing this to work the other way - inband being able to fall
> > back to PHY (out of band) mode rather than PHY mode being able to fall
> > forwards to inband mode.
> 
> I tested again with 89e0a87ef79db9f3ce879e9d977429ba89ca8229 and I think
> in my setup the problem is that it doesn't fall back to PHY mode but
> takes it as default mode. Here what happens when I have the mxl-gpy PHY
> connected to a 1000 GBit/s port:
> [    9.331179] mvpp2 f2000000.ethernet eth1: Using firmware node mac address 00:51:82:11:22:02
> [   14.674836] mvpp2 f2000000.ethernet eth1: PHY f212a600.mdio-mii:11 doesn't supply possible interfaces
> [   14.674853] mvpp2 f2000000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6,13-14
> [   14.674864] mvpp2 f2000000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-6,13-14
> [   14.674871] mvpp2 f2000000.ethernet eth1:  interface 9 (rgmii) rate match none supports 0-3,5-6,13-14
> [   14.674877] mvpp2 f2000000.ethernet eth1:  interface 10 (rgmii-id) rate match none supports 0-3,5-6,13-14
> [   14.674883] mvpp2 f2000000.ethernet eth1:  interface 11 (rgmii-rxid) rate match none supports 0-3,5-6,13-14
> [   14.674889] mvpp2 f2000000.ethernet eth1:  interface 12 (rgmii-txid) rate match none supports 0-3,5-6,13-14
> [   14.674895] mvpp2 f2000000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-6,13-14
> [   14.674900] mvpp2 f2000000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6,13-14,47
> [   14.674907] mvpp2 f2000000.ethernet eth1: PHY [f212a600.mdio-mii:11] driver [Maxlinear Ethernet GPY215C] (irq=POLL)
> [   14.685444] mvpp2 f2000000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,0000606f advertising 00,00000000,00008000,0000606f
> [   14.686635] mvpp2 f2000000.ethernet eth1: configuring for phy/2500base-x link mode
> [   14.694263] mvpp2 f2000000.ethernet eth1: major config, requested phy/2500base-x

                                                                       ^^^

You're still requesting (from firmware) for PHY mode, and phylink will
_always_ use out-of-band if firmware requests that.

> [   14.700402] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/2500base-x

So it uses PHY mode for 2500base-X, which is correct.

> [   17.768370] mvpp2 f2000000.ethernet eth1: major config, requested phy/sgmii

Still requesting PHY mode with SGMII, which historically we've always
used out-of-band mode for, so we preserve that behaviour.

> [   17.774602] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband

So we complain about it with an error, because it is wrong...

> [   17.782976] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/sgmii

and we still try to use it (correctly, because that's what phylink
has always done in this case.)

As I tried to explain, there is fall-back from MLO_AN_INBAND to
MLO_AN_PHY, but there won't be fall-forward from MLO_AN_PHY to
MLO_AN_INBAND.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

