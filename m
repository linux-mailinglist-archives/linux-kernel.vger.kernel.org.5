Return-Path: <linux-kernel+bounces-70584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233B859978
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2CB20B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9373185;
	Sun, 18 Feb 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a4/uc6Hf"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA59442;
	Sun, 18 Feb 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708290387; cv=none; b=WBXuzFxW9KZoqTiA+T1s2/PVc1ZtW0SHY/VMDE7hSgLAs72f+1hpBtS8AX2/HrtLQIxCvvwMMZtH2W2JSZc2dy9g1lT/9m6MDT/SlfvmswVafsJx1VJ5E1kTnIBOWUvRfX/b7h67d8nVpATqs12of3tr3mvwvz0JgQnZGA4uftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708290387; c=relaxed/simple;
	bh=fHUY2ehogUZNPWacJt8gLDI3qZGeVYGcpcezUo6wCoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbLF1DFLEHJ5soLTQQ+WwxADFau+2smG0vjTDnKNwWoZSodZPrm/Fz5nEyb04ijdSeXr4mAT4SUBNo7BqqqjN19I/88Xs7eQ7I41RILdkxNQnwjnhPCbPyG1oTHVVwsr7WR3GbBGVLAZItnfcSlsOwGCLSz2rp8SWeSjnpOiHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a4/uc6Hf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=caM0K02WPxJPPNQ9ZQRkyPtssDmb0dUkCjh6CwmGtx8=; b=a4/uc6Hfu0l3Ztln1I/WeExtef
	qtHSMdcB4slbGODnesPVv0FViMGpFzELe9XpFWA9ufsHvcK96xKBA+7nmhrmoqoaQ1SgV/tQlZpWp
	P7VIu3roHN8f7h1QF4ZINLotCDZOuw9D57jBWpB/bhq11zY6xRREe+HiRROTiWQWNk8e2jq1Tvwuw
	iBSbepkRuU98kTCnzHdscNYCXviLHnIAlTXCyjav/1V+UcLpzmVK5WYt2oAW6NLvmtGJA11ib5RoV
	d6KpNKFAa8uchzMKdtJhzgsU1XoBKwBZodlAIEy6dpAfT2fJwHose3TQPcobp4QD+agFDdue4kToP
	ClCbuYMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36802)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rboMT-0003kA-0P;
	Sun, 18 Feb 2024 21:06:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rboMP-0007jC-Rh; Sun, 18 Feb 2024 21:06:05 +0000
Date: Sun, 18 Feb 2024 21:06:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
Message-ID: <ZdJxPTFrRkbcgpnP@shell.armlinux.org.uk>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
 <65d2613d.170a0220.2eb48.a510@mx.google.com>
 <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>
 <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
 <ZdJpyGkFRiRufySw@shell.armlinux.org.uk>
 <65d26c13.df0a0220.63f42.d8e6@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d26c13.df0a0220.63f42.d8e6@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 18, 2024 at 09:44:03PM +0100, Christian Marangi wrote:
> On Sun, Feb 18, 2024 at 08:34:16PM +0000, Russell King (Oracle) wrote:
> > On Sun, Feb 18, 2024 at 09:27:22PM +0100, Christian Marangi wrote:
> > > On Sun, Feb 18, 2024 at 09:10:30PM +0100, Andrew Lunn wrote:
> > > > > > > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> > > > > > 
> > > > > > Why this cast? Try to write code that doesn't need casts.
> > > > > > 
> > > > > 
> > > > > This cast is needed to keep the dev_id const in the phy_device struct so
> > > > > that other are warned to not modify it and should only be handled by
> > > > > phy_probe since it's the one that fills it.
> > > > > 
> > > > > Alternative is to drop const and drop the warning.
> > > > 
> > > > Can you propagate the const. Make phy_dev_id point to a const?
> > > >
> > > 
> > > Mhh not following, I tried changing to const struct mdio_device_id *phy_dev_id
> > > but that results in memcpy complain (dest is void * not const) and
> > > writing in read-only for the single PHY part (the else part)
> > > 
> > > An alternative might be to make dev_id a pointer in struct phy_device
> > > and dynamically allocate a mdio_device_id for the case of single PHY
> > > (else case). That effectively remove the need of this cast but I would
> > > love to skip checking for -ENOMEM (this is why i made that local)
> > > 
> > > If it's OK to dynamically allocate for the else case then I will make
> > > this change. I just tested this implementation and works correctly with
> > > not warning.
> > 
> > Why do we need memcpy() etc - as I demonstrated in my proposal, it's
> > not necessary if we introduce a mdio_device_id within struct phy_driver
> > and we can just store a const pointer to the mdio_device_id that
> > matched. That was very much an intentional decision in my proposal to
> > make the code simple.
> >
> 
> With the allocated mdio_devic_id it would result in this snipped
> 
> 	const struct mdio_device_id *driver_dev_id;
> 	struct mdio_device_id *dev_id;
> 	int err = 0;
> 
> 	phydev->drv = phydrv;
> 	/* Fill the mdio_device_id for the PHY istance.
> 	 * If PHY driver provide an array of PHYs, search the right one,
> 	 * in the other case fill it with the phy_driver data.
> 	 */
> 	if (phy_driver_match(phydrv, phydev, &driver_dev_id) && driver_dev_id) {
> 		/* If defined, overwrite the PHY driver dev name with a
> 		 * more specific one from the matching dev_id.
> 		 */
> 		phydev->dev_id = driver_dev_id;
> 		if (driver_dev_id->name)
> 			drv->name = driver_dev_id->name;
> 	} else {
> 		dev_id = kzalloc(sizeof(*phydev->dev_id), GFP_KERNEL);
> 		if (!dev_id) {
> 			err = -ENOMEM;
> 			goto out;
> 		}
> 		dev_id->phy_id = phydrv->phy_id;
> 		dev_id->phy_id_mask = phydrv->phy_id_mask;
> 		dev_id->name = phydrv->name;
> 		phydev->dev_id = dev_id;
> 	}
> 
> Is it ok? (in phy.h the thing is const struct mdio_device_id *ids)
> I don't really like modifying phy_driver too much.

The thing that I don't like about this is that we need to free this
allocation (and know that we need to free it) which adds more
complexity and more possibilities for things leaking.

The advantage to putting it in the phy_driver structure is that its
lifetime is inherently tied to the driver structure and we don't
have the issue of having to free it - nor do we need to have separate
allocations for each PHY device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

