Return-Path: <linux-kernel+bounces-3185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA338168AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC11C224AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A551097B;
	Mon, 18 Dec 2023 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JF2MrTeR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723F10941;
	Mon, 18 Dec 2023 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D3A740004;
	Mon, 18 Dec 2023 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702889399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwiHZrMTP7Wiahde4BM0HLwINyMuE+Tg6ATmX7gQwnc=;
	b=JF2MrTeRWDXBcGI3/WDea3Ht6B5N4RpvQCz83GOeUkIzg/MMjDrma3A5Sd9oxYcA5nY4FG
	hT/vHT/3XUxSwbssvhSQIMxTB+cN1bArWKrrEMZIDMH52aR2gqHA+yyE2PX76CvtGPmrQl
	6WY5ukQYYj3HYcyPd/Mu8/qiQBy8ZtZGzvSZ7g8hFPrGQ/cWYWtNvUF1PCZCu7+k41VYgH
	YyI9ox40tOZ2SErdfmb95t9SP1Eu10YpojxePqvpQhO4R0DsFcGIdOXiuNh4i7oDE8scf1
	Xnk6AlK61qgnKVIJ4lvA7It8nGqZjUdIiuJwRSvE8LOz8GwEr9EtW5bT0UaOwA==
Date: Mon, 18 Dec 2023 09:49:56 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231218094956.676e7ed0@device-28.home>
In-Reply-To: <ede222d4-11da-4b95-a685-17cb480694dd@lunn.ch>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-1-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-2-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-2-maxime.chevallier@bootlin.com>
	<20231215214523.ntk5kec32mb5vqjs@skbuf>
	<ede222d4-11da-4b95-a685-17cb480694dd@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

Thanks for the review,

On Sun, 17 Dec 2023 17:57:10 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Dec 15, 2023 at 11:45:23PM +0200, Vladimir Oltean wrote:
> > On Fri, Dec 15, 2023 at 06:12:23PM +0100, Maxime Chevallier wrote:  
> > > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > > index d8e9335d415c..89daaccc9276 100644
> > > --- a/drivers/net/phy/phy_device.c
> > > +++ b/drivers/net/phy/phy_device.c
> > > @@ -1491,6 +1500,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> > >  
> > >  		if (phydev->sfp_bus_attached)
> > >  			dev->sfp_bus = phydev->sfp_bus;
> > > +
> > > +		err = phy_link_topo_add_phy(&dev->link_topo, phydev,
> > > +					    PHY_UPSTREAM_MAC, dev);
> > > +		if (err)
> > > +			goto error;
> > >  	}
> > >  
> > >  	/* Some Ethernet drivers try to connect to a PHY device before
> > > @@ -1816,6 +1830,7 @@ void phy_detach(struct phy_device *phydev)
> > >  	if (dev) {
> > >  		phydev->attached_dev->phydev = NULL;
> > >  		phydev->attached_dev = NULL;
> > > +		phy_link_topo_del_phy(&dev->link_topo, phydev);
> > >  	}
> > >  	phydev->phylink = NULL;
> > >  
> > > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> > > new file mode 100644
> > > index 000000000000..22f6372d002c
> > > --- /dev/null
> > > +++ b/drivers/net/phy/phy_link_topology.c
> > > +int phy_link_topo_add_phy(struct phy_link_topology *topo,
> > > +			  struct phy_device *phy,
> > > +			  enum phy_upstream upt, void *upstream)
> > > +{
> > > +	struct phy_device_node *pdn;
> > > +	int ret;
> > > +
> > > +	/* Protects phy and upstream */
> > > +	ASSERT_RTNL();  
> > 
> > Something to think for the PHY library maintainers. This is probably
> > the first time when the rtnl_lock() requirement is asserted at
> > phy_attach_direct() time.  
> 
> There are two use cases here for plain MAC drivers.
> 
> 1) phy_attach_direct() is called from probe. RTNL is normally not
> held, the driver would have to take it before making the call.
> 
> 2) phy_attach_direct() is called from ndo_open. In that case,
> __dev_open() has a ASSERT_RTNL() so we can assume RTNL has been taken.
> 
> So i don't think we can assume RTNL is held, but it might be held.
> 
> We need a better understanding what is being protected here.

I'm protecting the struct phy_device and the *upstream pointer (which
can be a net_device or a struct phy_device as well). In particular, I'm
protecting the phy_device->phyindex field. While I don't see any case
where we would concurrently write to it, given the weird topologies
that might be implemented in the future, I guess better safe than sorry.

For the rest, the actual phy list and the next_index pointer from the
topology should be already protected by the xarray mechanism.

Thanks,

Maxime


