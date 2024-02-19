Return-Path: <linux-kernel+bounces-71649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2685A85E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F291F220FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB83C498;
	Mon, 19 Feb 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UtWtc1GB"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8438F96;
	Mon, 19 Feb 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359124; cv=none; b=JJOdlN9+QCbtjuS2M29xu+pvzdJHcIG7lgrVOiJ6WPeMP7svewbtGcx3fuISBy/yiC4KGZoWAdP7Nj1y99QbtfZ17tcFhP8/MnKoOsvitdhjyHVyj5FmONrA2Go3yktFEwIRCJgwlFvH0lOR8NeXiWhqMR0TtUiJprPsUaGgAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359124; c=relaxed/simple;
	bh=iq6s+7WKZLZSrLV/9jdqYXS3RZE6PFmDztuMLteg06E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjysTuDy0QDM7mqbOEbLWfDGMvlNwp8f9SEdrhkjlRvTHW9gQx+8DjRt/1q1uu5c1l5IzvQWiK10o9NfjH8s0XgREfnadPWHWdqAAj304rCqCeGv+poDsha6Iria2jqkW/W29zm+NlcW3xXjo9rXM2R8dCCbpm6zMh0TJ0T//m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UtWtc1GB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m2nD4Vwza+aDllTk70i73HnQsiQ53xBK6QE6s2gWwMY=; b=UtWtc1GBcTmeW9Sgii2wiouPQc
	4gEhMxxwzplTX9PRgnnwprVsPBi6GkUOY05K3a+jS24JnB3DvLoSSgLyNj0rlSl1IZWqPT2DpnysI
	zPV6mUG5Rvw2XJ7qv7+QQyF3hKN3bOCcCWEQ66cqG5CpPOMae7xjLNSZgKv0vAQi+mqw0tGThFxSs
	LudSLJh9EuSUUmlQ5kQpZPxFn6LD/iEPzr09MvzUZ5e6zsPUQZfEfStUvqgVoKJJHuV5MmY4+nax8
	m1e4Re3VoEgATz6u8YIr3QCb4vJyTHptI+TLOWxXh/X2B2La17dWFuU7V+zPm7DW5nTJLuhOnaQeF
	Pd2gmp4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rc6El-0007Kt-2a;
	Mon, 19 Feb 2024 16:11:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rc6Ee-0008V0-Sj; Mon, 19 Feb 2024 16:11:16 +0000
Date: Mon, 19 Feb 2024 16:11:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <ZdN9pPf3wXwE/9nX@shell.armlinux.org.uk>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com>
 <20240219142936.62112d34@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219142936.62112d34@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 19, 2024 at 02:29:36PM +0100, Köry Maincent wrote:
> On Fri, 16 Feb 2024 10:09:36 -0800
> Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> 
> > On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootlin.com>
> > wrote:
> > > Change the API to select MAC default time stamping instead of the PHY.
> > > Indeed the PHY is closer to the wire therefore theoretically it has less
> > > delay than the MAC timestamping but the reality is different. Due to lower
> > > time stamping clock frequency, latency in the MDIO bus and no PHC hardware
> > > synchronization between different PHY, the PHY PTP is often less precise
> > > than the MAC. The exception is for PHY designed specially for PTP case but
> > > these devices are not very widespread. For not breaking the compatibility
> > > default_timestamp flag has been introduced in phy_device that is set by
> > > the phy driver to know we are using the old API behavior.
> > >
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---  
> > 
> > Overall, I agree with the motivation and reasoning behind the patch. It
> > takes dedicated effort to build a good phy timestamping mechanism, so
> > this approach is good. I do have a question though. In this patch if we
> > set the phy as the default timestamp mechanism, does that mean for even
> > non-PTP applications, the phy will be used for timestamping when
> > hardware timestamping is enabled? If so, I think this might need some
> > thought because there are timing applications in general when a
> > timestamp closest to the MAC layer would be best.
> 
> This patch comes from a request from Russell due to incompatibility between MAC
> and PHY timestamping when both were supported.
> https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/
> 
> His point was adding PTP support to a PHY driver would select timestamp from it
> by default even if we had a better timestamp with the MAC which is often the
> case. This is an unwanted behavior.
> https://lore.kernel.org/netdev/Y%2F6Cxf6EAAg22GOL@shell.armlinux.org.uk/
> 
> In fact, with the new support of NDOs hwtstamp and the
> dev_get/set_hwtstamp_phylib functions, alongside this series which make
> timestamp selectable, changing the default timestamp may be not necessary
> anymore.
> 
> Russell any thought about it? 

My position remains: in the case of Marvell PP2 network driver with a
Marvell PHY, when we add PTP support for the Marvell PHYs (I have
patches for it for years) then we must _not_ regress the existing
setup where the PP2 timestamps are the default.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

