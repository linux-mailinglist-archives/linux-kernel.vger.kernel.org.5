Return-Path: <linux-kernel+bounces-142721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7B8A2F51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853621C20E03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9882480;
	Fri, 12 Apr 2024 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ikugZ6Ho"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852175E060;
	Fri, 12 Apr 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928223; cv=none; b=JmzAOoaRlv19F6HcpxbN8yPMeHhDb8GPw+lEfI6cxgK/8Mf7oLKSYXx4W3SVoUYPDb32vYs72AcT46YinpzACjSxPAuOIC1fqFnnF6UU738wiUbg6KYN7Ju4FCWmyMNq1uNLlzNNM7KBl5Fmw37tn6MjNkoP//v5Q4sH59nxF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928223; c=relaxed/simple;
	bh=dmgGyuZghQmrzidGRnKgMS8zsphHWSFLUQdNRumotfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIqnQ4NPGwvJQVK1CKf7hH8soEvEwv1SlDcmAju3UzDlF8gmey/ZgH+MDXTXDUcysMS8H4V1nCujJbqYLNSz01h2HJOdHzUn4BVXuwEUdlQoe2FmLZfDcKWsmCweO5wGMgDlI9EciFCVAKLBcnYFc1ju5JGE8e71gbyTAADl5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ikugZ6Ho; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA2C81BF206;
	Fri, 12 Apr 2024 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712928219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doyOEZSdANyC7Q7xeWp2ANWHCVWf4AoZkITCbrl7iqA=;
	b=ikugZ6HoNQbESBI07T85V9qMBxbcLYaKJRD1WyY/ihTz+PEW9rGF5RGrCBhIaRXAv6iYLB
	Z8PrxVx0kdLMi2vOCVx4Rf3LulE1cbmnQJKvT9reXFqVWF6iHa7v4IR5a7+0TcT1TfvPJW
	WyxYeOGyxIicNVFQmQQPdT92FAUWRS8H/Zojd606yx40oeymugbro3x6h9U0egvGhGB7I5
	K0cRvctTd7h277fRI2YtWpTxb9T+Q6Fc91xAyAd+3c98xszAHELw+MKguiInblE1Hpg50A
	Shsqtzuo1YNl0w7pPc5HqvyXrtS4NQumui1rJThlHUtO+kB/2cH7hUJBPIcbTg==
Date: Fri, 12 Apr 2024 15:23:35 +0200
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
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL
 topologies
Message-ID: <20240412152335.751a8dbb@device-28.home>
In-Reply-To: <c37482d9-f97b-4f9a-8a2d-efde1a654514@gmail.com>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
	<c37482d9-f97b-4f9a-8a2d-efde1a654514@gmail.com>
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

Hello Heiner,

On Fri, 12 Apr 2024 15:07:46 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 12.04.2024 12:46, Maxime Chevallier wrote:
> > In situations where phylib is a module, the topology can be NULL as it's
> > not initialized at netdev creation.
> >   
> 
> What we see here is a bigger drawback of IS_REACHABLE(). For phylib it's
> false from net core, but true from r8169 driver. So topo_create is a stub,
> but topo_add is not. IS_REACHABLE() hides dependencies.
> 
> topo_create et al don't really use something from phylib.
> Therefore, could/should it be moved to net core?

That's a valid point, and a better solution indeed.

> At least for topo_create this would resolve the dependency.
> 
> We could also add a config symbol and the PHY topology an optional
> extension of net core.

That could be a thing indeed. It could be selected by phylib then, I
don't see it being a user-controlled option, as this would make it very
confusing for users to only be able to see when there are mutiple PHYs
on the link when the relevant option is enabled (but I might be wrong).

Maxime

> 
> > Allow passing a NULL topology pointer to phy_link_topo helpers.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> > Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> > ---
> > 
> > Hi,
> > 
> > This patch fixes a commit that is in net-next, hence the net-next tag and the
> > lack of "Fixes" tag.
> > 
> > Nathan, Heiner, can you confirm this solves what you're seeing ?
> > 
> > I think we can improve on this solution by moving the topology init at
> > the first PHY insertion and clearing it at netdev destruction.
> > 
> > Maxime
> > 
> >  drivers/net/phy/phy_link_topology.c | 10 +++++++++-
> >  include/linux/phy_link_topology.h   |  7 ++++++-
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> > index 985941c5c558..0f3973f07fac 100644
> > --- a/drivers/net/phy/phy_link_topology.c
> > +++ b/drivers/net/phy/phy_link_topology.c
> > @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
> >  	struct phy_device_node *pdn;
> >  	int ret;
> >  
> > +	if (!topo)
> > +		return 0;
> > +
> >  	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> >  	if (!pdn)
> >  		return -ENOMEM;
> > @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
> >  void phy_link_topo_del_phy(struct phy_link_topology *topo,
> >  			   struct phy_device *phy)
> >  {
> > -	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
> > +	struct phy_device_node *pdn;
> > +
> > +	if (!topo)
> > +		return;
> > +
> > +	pdn = xa_erase(&topo->phys, phy->phyindex);
> >  
> >  	/* We delete the PHY from the topology, however we don't re-set the
> >  	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
> > diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> > index 6b79feb607e7..21ca78127d0f 100644
> > --- a/include/linux/phy_link_topology.h
> > +++ b/include/linux/phy_link_topology.h
> > @@ -40,7 +40,12 @@ struct phy_link_topology {
> >  static inline struct phy_device *
> >  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> >  {
> > -	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
> > +	struct phy_device_node *pdn;
> > +
> > +	if (!topo)
> > +		return NULL;
> > +
> > +	pdn = xa_load(&topo->phys, phyindex);
> >  
> >  	if (pdn)
> >  		return pdn->phy;  
> 


