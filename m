Return-Path: <linux-kernel+bounces-166673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032278B9DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3561F21ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97A15CD5D;
	Thu,  2 May 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i9REoFqU"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA239AF9;
	Thu,  2 May 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665571; cv=none; b=ahsGHPe5uhD7JtCqGgeggBhtxtM++hdgMH65wxPLM+QyqT6VBZzikcjBX2CDBR3xcCrvqa/aVVNNvac2YsqUrgIFYUYaq2SVsx0W/ocX9uLQ22PS/UInRduOi5QeIHkGqmrCqeTeCGWpVndAmfgzwD+VtLDgwm+VhP9Ox/jv56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665571; c=relaxed/simple;
	bh=6205eTo2ELZgf4C8BpEINDos2RgSt/dUUw4L22YIVqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8/Vhqck94UDUtXcqmoNPpR3OCmdYLkavsrVZWX32a5uxAi3YKkAvQsKObvCf/zazu8Zqfac2G2zKPt0wsVOZ5UJInOsZ2+CTuUfU1S4ZaSoQMSWg7AUYx51l/C1AWJIkxCcZcdpePvHOprqNU5o8qfUDvmUlG4KTXPM8ltg82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i9REoFqU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rDB4vizde9mgPvk2q5qy3BdQeV4PdtdHe8QL7mBeQmA=; b=i9REoFqU4WtA01uzXJyomR6xbE
	tv3nW/uSDhfUfQcn6MpsBC4YFQnq4mXRNwSOlupmKaZehhEzmCxKkP1QGimLUFCZiqAu6JgYJSIIC
	bKaVYl+fXrwaP01GVmOjRAhMBo1gkg48kt3qjzUojW2wx9pC0MWzm+iFsQZPs+rtHfh/LQmJs27x5
	5zdrzO6KzR8MOzOEDXh9x67wqHd7RSEuVLtgxNsR4NqHE+lVWk4ot0yqfJjBqums1ad4fuAHF6CoS
	SAzgvjpP2p/JifutQyLNm1eEhVtYM8Tf1JHM9D8pdks4+Fo7QTTuQ6WPm0UgV20sC9peLoCM8OTiO
	5Ps/0DKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38346)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2Yq7-0007Rz-2t;
	Thu, 02 May 2024 16:59:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2Yq6-0003lB-S4; Thu, 02 May 2024 16:59:18 +0100
Date: Thu, 2 May 2024 16:59:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 02, 2024 at 04:51:42PM +0200, Andrew Lunn wrote:
> On Tue, Apr 30, 2024 at 10:36:35AM +0530, Raju Lakkaraju wrote:
> > Introduce a new member named 'wolopts' to the 'phy_device' structure to
> > store the user-specified Wake-on-LAN (WOL) settings. Update this member
> > within the phy driver's 'set_wol()' function whenever the WOL configuration
> > is modified by the user.
> > 
> > Currently, when the system resumes from sleep, the 'phy_init_hw()' function
> > resets the PHY's configuration and interrupts, which leads to problems upon
> > subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
> > we can ensure that the PHY's WOL configuration is correctly reapplied
> > through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
> > the issue
> 
> Sorry it took a white to review this.
> 
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> >  drivers/net/phy/mxl-gpy.c    | 5 +++++
> >  drivers/net/phy/phy_device.c | 5 +++++
> >  include/linux/phy.h          | 2 ++
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> > index b2d36a3a96f1..6edb29a1d77e 100644
> > --- a/drivers/net/phy/mxl-gpy.c
> > +++ b/drivers/net/phy/mxl-gpy.c
> > @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
> >  	struct net_device *attach_dev = phydev->attached_dev;
> >  	int ret;
> >  
> > +	phydev->wolopts = 0;
> 
> Is this specific to mlx-gpy?
> 
> You should be trying to solve the problem for all PHYs which support
> WoL. So i expect the core to be doing most of the work. In fact, i
> don't think there is any need for driver specific code.

It would be good to hear exactly why its necessary for phylib to track
this state, and why the PHY isn't retaining it.

I suspect this may have something to do with resets - the PHY being
hardware reset when coming out of resume (resulting in all state
being lost.) What's resetting it would also be good to track down
(as in hardware, firmware, or the kernel.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

