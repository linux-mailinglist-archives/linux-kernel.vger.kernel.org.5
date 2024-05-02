Return-Path: <linux-kernel+bounces-166036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89C8B950F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DA1C20F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C4224EF;
	Thu,  2 May 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B8j1f5Uu"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F413D0D5;
	Thu,  2 May 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633567; cv=none; b=XbdNTRJ2X86H7vQkwYaE0ZS1moCPSUwDToem5hmlzT2vk40LNtKuHBHuUl/QZxUewwg5j+D4/Ej89tgZd4F7p9uTFu1Rrklh8Ion+9xNW6SkOPt+x8xXlklan9m9YagcX0RISSzFyRqYDmHfuhueeAdXrMWAWgwlxgGAnxIYa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633567; c=relaxed/simple;
	bh=VCJpFTyWHDVtl37lStzlxQlOOcbZwfJtBV574sUGtMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpLAfynZbU35jTEgtrwek4kXkBTA0+ss4j1Glm3Mr/bjvN7x1pkylZvsjxphsaldUsLyyO0vaT1gWa3qmoOPbwLjgGiAkYRnv9Q7WLBWEk7Z7NN0HpasKVM9hnnS0Ti3z3ILlXlw3KUOSKpff7yKy8XMRfuYNO0C1pwiMPedsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B8j1f5Uu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4106FF80D;
	Thu,  2 May 2024 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714633557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sik2Srpo/NMXeuyqGPdiEfnhnvExYt+wCnwEMFyOk40=;
	b=B8j1f5UuQ+vnS71+EkEfNv+tOaeI+G68TJyKlaSdEUr0+GqduZ45SWwDpOX7X4irVbzNS7
	a4LaDpYPb7Jg8J3QlefxyiaPGvJsx8zgrXU5WnqTYAiKEf0KBI0DM4gbsaXEO5pqZbkmeB
	3Rn3nZcsmy20kDJ+0AOPvKop4Pyu7Jg5CuCPsMNrRBhwFAo395d0n9BtC8da9mxa6kCq03
	VdCexfNiKI7V0TYnqpbWJRLr6L0YiwNdVw8RHR+bGV6snnXZlCOfw9vvdO9cuqPbYwdQLx
	N3kQO+6SagPNJ0JLlsU4WG07zz2n5Eipa7j+1TRwajgFBFYld3xtZKV/SGhUkQ==
Date: Thu, 2 May 2024 09:05:53 +0200
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
Message-ID: <20240502090553.485bf36b@device-28.home>
In-Reply-To: <2422613d-0f9c-4485-bad3-5aa7cf12c0b1@gmail.com>
References: <20240429131008.439231-1-maxime.chevallier@bootlin.com>
	<1ed5b8cb-c79b-44b9-8dbe-f78d7505b3b4@gmail.com>
	<20240430135734.503f51a2@device-28.home>
	<2422613d-0f9c-4485-bad3-5aa7cf12c0b1@gmail.com>
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

Hi,

On Tue, 30 Apr 2024 23:29:37 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 30.04.2024 13:57, Maxime Chevallier wrote:
> > Hello Heiner,
> > 
> > On Tue, 30 Apr 2024 10:17:31 +0200
> > Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >   
> >> On 29.04.2024 15:10, Maxime Chevallier wrote:  
> >>> The core of the phy_link_topology isn't directly tied to phylib, and at
> >>> the moment it's initialized, phylib might not be loaded yet. Move the
> >>> initialization of the topology to the phy_link_topology_core header,
> >>> which contains the bare minimum so that we can initialize it at netdev
> >>> creation.
> >>>     
> >>
> >> The change fixes the issue for me, but according to my personal taste
> >> the code isn't intuitive and still error-prone. Also there's no good
> >> reason to inline a function like phy_link_topo_create() and make it
> >> publicly available. Do you expect it to be ever used outside net core?
> >> In general it may make sense to add a config symbol for the topology
> >> extension, there seem to be very few, specialized use cases for it.  
> > 
> > I think I'm missing the point here then. Do you mean adding a Kconfig
> > option to explicitely turn phy_link_topology on ? or build it as a
> > dedicated kernel module ?
> > 
> > Or do you see something such as "if phylib is M or Y, then build the
> > topology stuff and make sure it's allocated when a netdev gets created
> > ?"
> > 
> > Thanks,
> > 
> > Maxime
> >   
> >>  
> >>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> >>> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> >>> ---
> >>>  drivers/net/phy/phy_link_topology.c    | 23 --------------------
> >>>  include/linux/phy_link_topology.h      |  5 -----
> >>>  include/linux/phy_link_topology_core.h | 30 +++++++++++++++++---------
> >>>  3 files changed, 20 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> >>> index 985941c5c558..960aedd73308 100644
> >>> --- a/drivers/net/phy/phy_link_topology.c
> >>> +++ b/drivers/net/phy/phy_link_topology.c
> >>> @@ -12,29 +12,6 @@
> >>>  #include <linux/rtnetlink.h>
> >>>  #include <linux/xarray.h>
> >>>  
> >>> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> >>> -{
> >>> -	struct phy_link_topology *topo;
> >>> -
> >>> -	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> >>> -	if (!topo)
> >>> -		return ERR_PTR(-ENOMEM);
> >>> -
> >>> -	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> >>> -	topo->next_phy_index = 1;
> >>> -
> >>> -	return topo;
> >>> -}
> >>> -
> >>> -void phy_link_topo_destroy(struct phy_link_topology *topo)
> >>> -{
> >>> -	if (!topo)
> >>> -		return;
> >>> -
> >>> -	xa_destroy(&topo->phys);
> >>> -	kfree(topo);
> >>> -}
> >>> -
> >>>  int phy_link_topo_add_phy(struct phy_link_topology *topo,
> >>>  			  struct phy_device *phy,
> >>>  			  enum phy_upstream upt, void *upstream)
> >>> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> >>> index 6b79feb607e7..ad72d7881257 100644
> >>> --- a/include/linux/phy_link_topology.h
> >>> +++ b/include/linux/phy_link_topology.h
> >>> @@ -32,11 +32,6 @@ struct phy_device_node {
> >>>  	struct phy_device *phy;
> >>>  };
> >>>  
> >>> -struct phy_link_topology {
> >>> -	struct xarray phys;
> >>> -	u32 next_phy_index;
> >>> -};
> >>> -
> >>>  static inline struct phy_device *
> >>>  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> >>>  {
> >>> diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
> >>> index 0a6479055745..0116ec49cd1b 100644
> >>> --- a/include/linux/phy_link_topology_core.h
> >>> +++ b/include/linux/phy_link_topology_core.h
> >>> @@ -2,24 +2,34 @@
> >>>  #ifndef __PHY_LINK_TOPOLOGY_CORE_H
> >>>  #define __PHY_LINK_TOPOLOGY_CORE_H
> >>>  
> >>> -struct phy_link_topology;
> >>> +#include <linux/xarray.h>
> >>>  
> >>> -#if IS_REACHABLE(CONFIG_PHYLIB)
> >>> -
> >>> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
> >>> -void phy_link_topo_destroy(struct phy_link_topology *topo);
> >>> -
> >>> -#else
> >>> +struct phy_link_topology {
> >>> +	struct xarray phys;
> >>> +	u32 next_phy_index;
> >>> +};
> >>>  
> >>>  static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> >>>  {
> >>> -	return NULL;
> >>> +	struct phy_link_topology *topo;
> >>> +
> >>> +	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> >>> +	if (!topo)
> >>> +		return ERR_PTR(-ENOMEM);
> >>> +
> >>> +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> >>> +	topo->next_phy_index = 1;
> >>> +
> >>> +	return topo;
> >>>  }
> >>>  
> >>>  static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> >>>  {
> >>> -}
> >>> +	if (!topo)
> >>> +		return;
> >>>  
> >>> -#endif
> >>> +	xa_destroy(&topo->phys);
> >>> +	kfree(topo);
> >>> +}
> >>>  
> >>>  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */    
> >>  
> >   
> 
> To go a little bit more into detail:
> 
> phy_link_topo_create() and phy_link_topo_destroy() are used in net/core/dev.c
> only. Do you expect them to be ever used by other callers?
> If not, their functionality could be moved to net/core/dev.c.
> Supposedly guarded by IS_ENABLED(CONFIG_PHYLIB), alternatively a new config
> symbol for link_topo support.
> 
> To get rid of the dependency you could also lazy-inizialize
> netdev->link_topo. For this phy_link_topo_add_phy() would have
> to take the netdev as first argument, not the topo.
> Then the first call to phy_link_topo_add_phy() would initialize
> netdev->link_topo.
> 
> I think functions like phy_link_topo_get_phy() should also check for
> topo != NULL first, maybe combined with a WARN_ON().
> They are exported and you have no control over its use.

Thanks Heiner for the explanations. I'll rework based on that. The
original reason I didn't directly include the netdev as a parameter for
these function, or didn't put any helper in net/core/dev.c is because I
wanted to avoid too strong of a link between the topology and netdev.

There are some PHYs for which we can't assign any netdev (PHYs that
would sit in-between 2 chained DSA switches is the only example I have
in mind though), but TBH the code in its actual shape doesn't address
these either, so it's a useless design constraint.

So, let me indeed do that, it will probably make for a simpler and more
straightforward design.

Thanks for the input,

Maxime

