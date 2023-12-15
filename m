Return-Path: <linux-kernel+bounces-678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88088814457
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAAD1C22A00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080F1802E;
	Fri, 15 Dec 2023 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SIjj4ClP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16117994;
	Fri, 15 Dec 2023 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L8q7VvWi1VZ46dfphKynAQs7E8HdoHkmIWEzQFSMVyE=; b=SIjj4ClPT3DhO7FFkPTNVYr2C8
	gviPBKUqPoArRpx79RrpmusZ5y0EWM4mPieRb1vEfkyOhKA+WZwXAU6nCbSMDOTr0vgby2+PDNY9L
	vu+VbR5I7xPaTqy683MTpCtvow4sto2z4wA+peTFrZTnbYper+uFuAhVHdJ6HjfgAu7e2v3p5oMbe
	zKQORm7otDe5osLhY9dJUnAuRugn0uYewMwr3MKeCTYB4bhYREsq6MD3i5uoZYx39nmuNPaSHTpeJ
	ERJtA0NUJ8kkB+GJNcRY/HHifYVSKaZNXjMO+r25CLHcTLsxXaT1MBk4uDq3pKmBqdjeE9We4EsfN
	+29y8HlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42556)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rE4J1-0002QP-2g;
	Fri, 15 Dec 2023 09:16:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rE4J1-0003Tl-Tk; Fri, 15 Dec 2023 09:16:27 +0000
Date: Fri, 15 Dec 2023 09:16:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 2/4] net: phy: extend PHY package API to
 support multiple global address
Message-ID: <ZXwZaycfV38AY54r@shell.armlinux.org.uk>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-3-ansuelsmth@gmail.com>
 <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>
 <657b921d.5d0a0220.7815b.87dd@mx.google.com>
 <ZXuVsotg1DV596lV@shell.armlinux.org.uk>
 <657b9999.5d0a0220.ec414.ed08@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657b9999.5d0a0220.ec414.ed08@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 06:29:28PM +0100, Christian Marangi wrote:
> On Thu, Dec 14, 2023 at 11:54:26PM +0000, Russell King (Oracle) wrote:
> > On Thu, Dec 14, 2023 at 05:54:51PM +0100, Christian Marangi wrote:
> > > What I don't like is the wrap check.
> > > 
> > > But I wonder... Isn't it easier to have 
> > > 
> > > unsigned int addr = shared->base_addr + addr_offset;
> > > 
> > > and check if >= PHY_MAC_ADDR?
> > > 
> > > Everything is unsigned (so no negative case) and wrap is not possible as
> > > nothing is downcasted.
> > 
> > I'm afraid that I LOL'd at "wrap is not possible" ! Of course it's
> > possible. Here's an example:
> >
> 
> Yes I just think about it and I'm also LOLing at the "not possible"...
> 
> > 	shared->base_addr is 20
> > 	addr_offset is ~0 (or -1 casted to an unsigned int)
> > 	addr becomes 19
> > 
> > How about:
> > 
> > 	if (addr_offset >= PHY_MAX_ADDR)
> > 		return -EIO;
> > 
> > 	addr = shared->base_addr + addr_offset;
> > 	if (addr >= PHY_MAX_ADDR)
> > 		return -EIO;
> > 
> > and then we could keep 'addr' as u8.
> 
> Ok just to make sure
> 
> static int phy_package_address(struct phy_device *phydev,
>                                unsigned int addr_offset)
> {
>         struct phy_package_shared *shared = phydev->shared;
>         unsigned int addr;
> 
>         if (addr_offset >= PHY_MAX_ADDR)
>                 return -EIO;
> 
>         addr = shared->base_addr + addr_offset;
>         if (addr >= PHY_ADDR_MAX)
>                 return -EIO;
> 
>         /* we know that addr will be in the range 0..31 and thus the
>          * implicit cast to a signed int is not a problem.
>          */
>         return addr;
> }

Yep.

> And call u8 addr = phy_package_address(phydev, addr_offset);

This has to be int to cater for -EIO

> Maybe one if can be skipped with the following fun thing?
> 
> static int phy_package_address(struct phy_device *phydev,
>                                unsigned int addr_offset)
> {
>         struct phy_package_shared *shared = phydev->shared;
>         u8 base_addr = shared->base_addr;
> 
>         if (addr_offset >= PHY_MAX_ADDR - base_addr)
>                 return -EIO;

That also works.
> 
>         /* we know that addr will be in the range 0..31 and thus the
>          * implicit cast to a signed int is not a problem.
>          */
>         return base_addr + addr_offset;
> }
> 
> (don't hate me it's late here and my brain is half working ahahha)
> 
> > 
> > Honestly, I have wondered why the mdio bus address is a signed int, but
> > never decided to do anything about it.
> > 
> 
> Maybe because direct usage of mdiobus_ is discouraged and phy_write will
> use an addr that is already validated.

It's discourged in PHY drivers where one has the phy_device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

