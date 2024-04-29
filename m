Return-Path: <linux-kernel+bounces-162182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF78B573C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AB21F2260D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12B52F6B;
	Mon, 29 Apr 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T1FzTGcp"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E551C2C;
	Mon, 29 Apr 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391759; cv=none; b=CCoY7HRGosZYCdDWKF055i+cSIBzMEv+Ownrd6A0bugeKLXjH69UGZyBTX874Wca9hMDMNcSaVKopuwxNSjoj+Qhdb+zWdF6miw0J08LrnJojja+5dLzjPcF4jkRKe8GRm7sfOlMi879JyDe23Cl4Az1jDL4WcNcDyv6BOohaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391759; c=relaxed/simple;
	bh=Rttk/sZ1q84cN4XbtTe/EhC3qBR6n5XjvSTc1yckR8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJyj+etfaRM/5HfhszUnufG48GOsnaiKcnPvVwFWx9piuGMob1xC40ynRlQ8Z+d8RjKyTnDuhhSrn/Js1Zrd6Ucfu06oyDUDtc+PlLhtfTanTmN6NapUXpqoN4f8N6mR8t9/sWj9rfdG5Fl6F2q2klHYZ+U4EoEvm5ZpvOG8pB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T1FzTGcp; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4353920007;
	Mon, 29 Apr 2024 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714391747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVjiQz4+6eouGFpCfe3kaMY1C/HczOpHYg45IACIDrE=;
	b=T1FzTGcpXo6qFjZOOhPVXy51vNt64OAwvwBr0PYKHGBWH7+aCu4WN5aH/6bf7tfJ72zdAA
	zqBFcdqxnt2xdUWXoVtN5fzfduBZ8eNAuAmFdFy4kewweHnMkczztNtQEmgNQwKqRCA4xm
	RI71/BN4bgcmRZhBiuRCYhmkALNS3VnPiSkGzbUf/aJEgz0kXOmTWVt7wgrhJgnnQ2fAGD
	GFonoGeqyB7Ob+L7VDSI0BTXQSTSxyHCCmXzgjpGwOtBmBbVGOZ7Nw80ODv4VxxdFQdNC3
	fGS5En/VIH0nhmpLBdzYG1YywAPhU4o0YMjn1QBqujNIU3jDbnyG0EuEhtLJJw==
Date: Mon, 29 Apr 2024 13:55:42 +0200
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
Message-ID: <20240429135542.73d039b2@device-28.home>
In-Reply-To: <d33888a9-3c26-47be-bead-5270b955307b@gmail.com>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
	<c37482d9-f97b-4f9a-8a2d-efde1a654514@gmail.com>
	<20240412152335.751a8dbb@device-28.home>
	<d33888a9-3c26-47be-bead-5270b955307b@gmail.com>
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

On Sat, 27 Apr 2024 21:34:21 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 12.04.2024 15:23, Maxime Chevallier wrote:
> > Hello Heiner,
> > 
> > On Fri, 12 Apr 2024 15:07:46 +0200
> > Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >   
> >> On 12.04.2024 12:46, Maxime Chevallier wrote:  
> >>> In situations where phylib is a module, the topology can be NULL as it's
> >>> not initialized at netdev creation.
> >>>     
> >>
> >> What we see here is a bigger drawback of IS_REACHABLE(). For phylib it's
> >> false from net core, but true from r8169 driver. So topo_create is a stub,
> >> but topo_add is not. IS_REACHABLE() hides dependencies.
> >>
> >> topo_create et al don't really use something from phylib.
> >> Therefore, could/should it be moved to net core?  
> > 
> > That's a valid point, and a better solution indeed.
> >   
> >> At least for topo_create this would resolve the dependency.
> >>
> >> We could also add a config symbol and the PHY topology an optional
> >> extension of net core.  
> > 
> > That could be a thing indeed. It could be selected by phylib then, I
> > don't see it being a user-controlled option, as this would make it very
> > confusing for users to only be able to see when there are mutiple PHYs
> > on the link when the relevant option is enabled (but I might be wrong).
> >   
> AFAIK the issue still exists on net-next. Are you going to submit
> an updated version?

It still is indeed. I've been very busy last week unfortunately, I'll
followup today though. Thanks for the patience,

Maxime

> 
> > Maxime
> >   
> >>  
> >>> Allow passing a NULL topology pointer to phy_link_topo helpers.
> >>>
> >>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> >>> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> >>> ---
> >>>
> >>> Hi,
> >>>
> >>> This patch fixes a commit that is in net-next, hence the net-next tag and the
> >>> lack of "Fixes" tag.
> >>>
> >>> Nathan, Heiner, can you confirm this solves what you're seeing ?
> >>>
> >>> I think we can improve on this solution by moving the topology init at
> >>> the first PHY insertion and clearing it at netdev destruction.
> >>>
> >>> Maxime
> >>>
> >>>  drivers/net/phy/phy_link_topology.c | 10 +++++++++-
> >>>  include/linux/phy_link_topology.h   |  7 ++++++-
> >>>  2 files changed, 15 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> >>> index 985941c5c558..0f3973f07fac 100644
> >>> --- a/drivers/net/phy/phy_link_topology.c
> >>> +++ b/drivers/net/phy/phy_link_topology.c
> >>> @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
> >>>  	struct phy_device_node *pdn;
> >>>  	int ret;
> >>>  
> >>> +	if (!topo)
> >>> +		return 0;
> >>> +
> >>>  	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> >>>  	if (!pdn)
> >>>  		return -ENOMEM;
> >>> @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
> >>>  void phy_link_topo_del_phy(struct phy_link_topology *topo,
> >>>  			   struct phy_device *phy)
> >>>  {
> >>> -	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
> >>> +	struct phy_device_node *pdn;
> >>> +
> >>> +	if (!topo)
> >>> +		return;
> >>> +
> >>> +	pdn = xa_erase(&topo->phys, phy->phyindex);
> >>>  
> >>>  	/* We delete the PHY from the topology, however we don't re-set the
> >>>  	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
> >>> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> >>> index 6b79feb607e7..21ca78127d0f 100644
> >>> --- a/include/linux/phy_link_topology.h
> >>> +++ b/include/linux/phy_link_topology.h
> >>> @@ -40,7 +40,12 @@ struct phy_link_topology {
> >>>  static inline struct phy_device *
> >>>  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> >>>  {
> >>> -	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
> >>> +	struct phy_device_node *pdn;
> >>> +
> >>> +	if (!topo)
> >>> +		return NULL;
> >>> +
> >>> +	pdn = xa_load(&topo->phys, phyindex);
> >>>  
> >>>  	if (pdn)
> >>>  		return pdn->phy;    
> >>  
> >   
> 


