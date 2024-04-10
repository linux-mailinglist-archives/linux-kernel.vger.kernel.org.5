Return-Path: <linux-kernel+bounces-139268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB88A00BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6951C23B05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9C181B84;
	Wed, 10 Apr 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E2POfess"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F4181311;
	Wed, 10 Apr 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777876; cv=none; b=sQpuU+wH4BJ8GX9t90Yz41bbFpc4PoA+P6MN3reU7HTv3AqqwFS5w22A7XLbjAAZihdSJ4mk5+SRadAUgyOt7/4jmRy/kHIUEF6frzTQOIa9MUXe4SJoFzhkgrlv2UUNHFPQhOPyQ//bb30B6MrOIBsHsp+85zEpYZSLQrNfz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777876; c=relaxed/simple;
	bh=K6oeNAjQ7C0hW+8CzLz9+z7T4W2t9RvIZXZ2cFItEQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWvFHUHswGH8qqBTCzUw5Yzmr1ImB3mn48xrwJCuraie/wNKm3J2lz+N3EjpM8Wvi3CAOtIczFhy9JDZqzfpW6igq7WHVo4oPLoewXJ+FUYBrIaDQZFip+5+EWLopQJr/4U0M7gcKpcEsH6yZ52DrQFXtIDNsmAdrF8ftPxCSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E2POfess; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9hg2PSHk8E57TWYc2JeAWBrRdzJuP4lckAGhxVr40SI=; b=E2POfessUrhzeAkOj6YxIsuTDA
	5MSm9FGxBlByPThoFcsd928J9T7kuZFVBsC1QxL1CWf7txL2yPGrbT6SNAMeLpTbkNCvFugS6GV35
	WQRP+RzfwSeLAmzjsMC2B0nf6sWGoV+8yePiaNUvEnKqh03HDf+4WZ2yfU8ZegXqBecMsag894oWm
	dhBDXIGYsSpgsuJCc3dJGEY1kX9CJCgkHPxIbI8KOhzERGud6KtLMjB12iMt6bhcTrmc9zdr7dn+R
	XD3NvgLEWzU4Es6lYZROcPROfKJrV6glt+ppwnALjrDpG7sjto+t4Fb/cJ47q97/4Q3ARfVkBy3GF
	M5IlChNg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38562)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rudlF-0008SU-1J;
	Wed, 10 Apr 2024 20:37:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rudlB-0006Cv-25; Wed, 10 Apr 2024 20:37:29 +0100
Date: Wed, 10 Apr 2024 20:37:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v10 07/13] net: Add struct kernel_ethtool_ts_info
Message-ID: <ZhbqeCeTHIU0LrIn@shell.armlinux.org.uk>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
 <20240409182725.139856d5@kernel.org>
 <20240410101200.0178e594@kmaincent-XPS-13-7390>
 <ZhZkNEYnY3FV7Q8E@shell.armlinux.org.uk>
 <20240410155412.2f34a117@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410155412.2f34a117@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 10, 2024 at 03:54:12PM +0200, Kory Maincent wrote:
> On Wed, 10 Apr 2024 11:04:36 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Apr 10, 2024 at 10:12:00AM +0200, Kory Maincent wrote:
> > > On Tue, 9 Apr 2024 18:27:25 -0700
> > > Jakub Kicinski <kuba@kernel.org> wrote:
> > >   
> > > > On Tue, 09 Apr 2024 10:26:29 +0200 Kory Maincent wrote:  
> > > > > In prevision to add new UAPI for hwtstamp we will be limited to the
> > > > > struct ethtool_ts_info that is currently passed in fixed binary format
> > > > > through the ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new
> > > > > kernel code already started operating on an extensible kernel variant
> > > > > of that structure, similar in concept to struct kernel_hwtstamp_config
> > > > > vs struct hwtstamp_config.
> > > > > 
> > > > > Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> > > > > we introduce the kernel-only structure in include/linux/ethtool.h.
> > > > > The manual copy is then made in the function called by
> > > > > ETHTOOL_GET_TS_INFO. 
> > > > 
> > > > This one now conflicts :(
> > > > 
> > > > Applying: net: Add struct kernel_ethtool_ts_info
> > > > error: sha1 information is lacking or useless
> > > > (drivers/net/phy/marvell_ptp.c). error: could not build fake ancestor  
> > > 
> > > gnn patching my out of tree patch in the series! Sorry for that.  
> > 
> > Given that this path corresponds to the driver I wrote, do I assume
> > that you've picked up my work on PTP support for Marvell PHYs? You
> > should be aware that I still have the patches out of tree but it's
> > been pointless me reposting it until the issue of which PTP gets
> > used has been solved. (Publishing will just increase the pressure
> > to merge it without the PTP problems being solved, and thus break
> > Marvell PP2 PTP.)
> 
> Yes I did with few fixes and I know you don't want to post the patches until
> setting which PTP gets used has been solved. As you can see this is one of the
> subject of this series. About it, could you review this series? This would help
> a lot and you will be able to post again your Marvell PTP patches if its get
> merged.

I wish I could, but I'm seriously short of available time at the
moment. I'm fitting in what I can day by day and there are many
things wanting my attention - but I don't have enough time at the
moment for everything. So really I can't take on anything new
right now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

