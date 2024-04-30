Return-Path: <linux-kernel+bounces-164024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1959E8B774D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24773B20838
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BA171E60;
	Tue, 30 Apr 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T+sfuGgU"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F112CDB5;
	Tue, 30 Apr 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484229; cv=none; b=MWY8KvUrSKKgvZTjIcneijpt7mSE1QyJvBjDauUa3+NTOuQJmXSEamikVD7Nh33YIZ8Ts1zYQ4qIdwO6ZYcDXI5ABqxiIRrO64tSrWdwiurQYm/UadgVZXboDhKlJob62TRjS9c3WRLkWPZTxG2SpJM1d7VCUa+bMSL4CaK3PQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484229; c=relaxed/simple;
	bh=5yFphC5yPc/T4pS2Pcf0KOygyeRSPkokyRTwwuSopyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY5E1z2n7N+IzFy7hCBgJi1B/Dg0ayQl/ThjlFEXrxipiwEi13acBQc3zm8ZE3h1MUuctLnwinYCyUK0oLeQxPxPziEFF0Dko6IhrdnIGjyIry7ZaP466UT2xLiDdnklhtyh1wKpzVLj8OP4y9gdT/MHu8SBhGxuTuJoiUYNQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T+sfuGgU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 124CBC0012;
	Tue, 30 Apr 2024 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714484219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkM9d0xicBmnajscafdTXqIyu0TvtJ/Gq9ScB83e5TE=;
	b=T+sfuGgU5KSE1xqFD4DqmpJcEqUDQLEqw80ye09yk02ttYXASrPoS7CY4ixjU205l+r48X
	nuJHFs5/lTNcoWKdNiowEPUs8bSCcwB08eQ1HmHXATvgi/76W/JrmLnu3F/nVx3DtLAFFt
	8dWs44KNLxdcvpvuJqSNjfizr8t7ovtI3DUbyFYE+GRCo23dyHA1aoHCbCUb1DD0f0yJFJ
	vZcjQJt01t2DFxKX2narbYb6vSLMzL4dzbLNyoqJOkZ9IJPI+3bVl8unhPXGcgcMUvblsV
	K7LuHYnmPQ3EBW3/e21Y46J624gYiHguO/Psw+ot1c6qZA876nSTd1DLkfnsbw==
Date: Tue, 30 Apr 2024 15:36:55 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor
 <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next] net: phy: Don't conditionally compile the
 phy_link_topology creation
Message-ID: <20240430153655.2df7a54c@device-28.home>
In-Reply-To: <20240430135734.503f51a2@device-28.home>
References: <20240429131008.439231-1-maxime.chevallier@bootlin.com>
	<1ed5b8cb-c79b-44b9-8dbe-f78d7505b3b4@gmail.com>
	<20240430135734.503f51a2@device-28.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 30 Apr 2024 13:57:34 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello Heiner,
> 
> On Tue, 30 Apr 2024 10:17:31 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> > On 29.04.2024 15:10, Maxime Chevallier wrote:  
> > > The core of the phy_link_topology isn't directly tied to phylib, and at
> > > the moment it's initialized, phylib might not be loaded yet. Move the
> > > initialization of the topology to the phy_link_topology_core header,
> > > which contains the bare minimum so that we can initialize it at netdev
> > > creation.
> > >     
> > 
> > The change fixes the issue for me, but according to my personal taste
> > the code isn't intuitive and still error-prone. Also there's no good
> > reason to inline a function like phy_link_topo_create() and make it
> > publicly available. Do you expect it to be ever used outside net core?
> > In general it may make sense to add a config symbol for the topology
> > extension, there seem to be very few, specialized use cases for it.  
> 
> I think I'm missing the point here then. Do you mean adding a Kconfig
> option to explicitely turn phy_link_topology on ? or build it as a
> dedicated kernel module ?
> 
> Or do you see something such as "if phylib is M or Y, then build the
> topology stuff and make sure it's allocated when a netdev gets created
> ?"

I've prototyped something that's cleaner and should fit what you
described, which is to have a Kconfig option for phy_topology and
have it autoselected by CONFIG_SFP (for now, the only case where we can
have multiple PHYs on the link). When phy mux support is added (I'll
followup with that once the topology is settled), we can also make is
select the phy_topology config option. I'll send that patch when I'll
have properly tested it, especially with all the different bits
(phylib, sfp, drivers) being tested as modules or builtin.

Thanks for the tips,

Maxime

> 
> Thanks,
> 
> Maxime
> 
> >   
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> > > Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> > > ---
> > >  drivers/net/phy/phy_link_topology.c    | 23 --------------------
> > >  include/linux/phy_link_topology.h      |  5 -----
> > >  include/linux/phy_link_topology_core.h | 30 +++++++++++++++++---------
> > >  3 files changed, 20 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> > > index 985941c5c558..960aedd73308 100644
> > > --- a/drivers/net/phy/phy_link_topology.c
> > > +++ b/drivers/net/phy/phy_link_topology.c
> > > @@ -12,29 +12,6 @@
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/xarray.h>
> > >  
> > > -struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> > > -{
> > > -	struct phy_link_topology *topo;
> > > -
> > > -	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> > > -	if (!topo)
> > > -		return ERR_PTR(-ENOMEM);
> > > -
> > > -	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> > > -	topo->next_phy_index = 1;
> > > -
> > > -	return topo;
> > > -}
> > > -
> > > -void phy_link_topo_destroy(struct phy_link_topology *topo)
> > > -{
> > > -	if (!topo)
> > > -		return;
> > > -
> > > -	xa_destroy(&topo->phys);
> > > -	kfree(topo);
> > > -}
> > > -
> > >  int phy_link_topo_add_phy(struct phy_link_topology *topo,
> > >  			  struct phy_device *phy,
> > >  			  enum phy_upstream upt, void *upstream)
> > > diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> > > index 6b79feb607e7..ad72d7881257 100644
> > > --- a/include/linux/phy_link_topology.h
> > > +++ b/include/linux/phy_link_topology.h
> > > @@ -32,11 +32,6 @@ struct phy_device_node {
> > >  	struct phy_device *phy;
> > >  };
> > >  
> > > -struct phy_link_topology {
> > > -	struct xarray phys;
> > > -	u32 next_phy_index;
> > > -};
> > > -
> > >  static inline struct phy_device *
> > >  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> > >  {
> > > diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
> > > index 0a6479055745..0116ec49cd1b 100644
> > > --- a/include/linux/phy_link_topology_core.h
> > > +++ b/include/linux/phy_link_topology_core.h
> > > @@ -2,24 +2,34 @@
> > >  #ifndef __PHY_LINK_TOPOLOGY_CORE_H
> > >  #define __PHY_LINK_TOPOLOGY_CORE_H
> > >  
> > > -struct phy_link_topology;
> > > +#include <linux/xarray.h>
> > >  
> > > -#if IS_REACHABLE(CONFIG_PHYLIB)
> > > -
> > > -struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
> > > -void phy_link_topo_destroy(struct phy_link_topology *topo);
> > > -
> > > -#else
> > > +struct phy_link_topology {
> > > +	struct xarray phys;
> > > +	u32 next_phy_index;
> > > +};
> > >  
> > >  static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> > >  {
> > > -	return NULL;
> > > +	struct phy_link_topology *topo;
> > > +
> > > +	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> > > +	if (!topo)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> > > +	topo->next_phy_index = 1;
> > > +
> > > +	return topo;
> > >  }
> > >  
> > >  static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> > >  {
> > > -}
> > > +	if (!topo)
> > > +		return;
> > >  
> > > -#endif
> > > +	xa_destroy(&topo->phys);
> > > +	kfree(topo);
> > > +}
> > >  
> > >  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */    
> >   
> 
> 


