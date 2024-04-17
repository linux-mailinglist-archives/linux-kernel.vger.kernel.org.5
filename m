Return-Path: <linux-kernel+bounces-149237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F1A8A8D81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093EA1F228AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD234AEDB;
	Wed, 17 Apr 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kK0azEzb"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A58F4A;
	Wed, 17 Apr 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388177; cv=none; b=GDyMO6E0tO0iqxUy5TkMi4PwZoYt7bie8cGy3Zs91k4xSUL1rzt8tvJzreMH20jQNUMF2T555DS8tELfFcccXWtztWOGMMlWObGLRM/T3X15jlRS6gbVBN5Jg9wMp9Wtt4sM5volf/Xb7Tr+MqId/9jpZsHqBjUDWq/hqb5JSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388177; c=relaxed/simple;
	bh=f1rNUKMi/2p7FcIFAowLHzuCp8mNU610ACgQqvx2LUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+TA81y5PBFMA5Zb9VlM0as3VuhiegmiSkF+ch6WbwvjF8ITqfGcXEaR09GiG29punm9yZSwtaJAepnuA5kamxF0SGhqD6gYbKMlilZPqpqyePdZNi9o8PZ1BFYevMQbkenkvtzYQBIAKy9jErFwOV4wi7VJfxCcaDymRCXtseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kK0azEzb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81C3CE0002;
	Wed, 17 Apr 2024 21:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713388172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2m8pR1pCbDPDT8QEV6rLd8e1/9F0K8J7acfuqFf7QA=;
	b=kK0azEzbFnTcYp++AYAcjqBoyE8TnPGCbJAfTbtuRI20udyuLFdbvG1CBUKlAuDGpaG2Kt
	zg63AxtFeeVgPhYzLL5gG5uv3PZLMLqokImt9vTn8Za2vY/8ByTJ3aPiqrF6rp3H0qGLsc
	6q/XTnohHTblzYoauX2Bfr1Py7DIMZCWDjFyH4poEMHZ83FctP7+Hoh5ewNJaam4Sut+Lv
	AvSvOp2Z1TpJvrXkPMc0wcpSfQadLq6Mwr80gLu78ieEG45l4rTSt3sUmGWv1+Xr61QS1p
	oM8ddfBZBBtASlEi8SlnjZC/E8UpusTmgJGiPem6H8cmHf6dwPt7B7Fb5eK90w==
Date: Wed, 17 Apr 2024 23:09:20 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next] net: phy: link_topology: Don't stub-away the
 topology creation
Message-ID: <20240417230920.054d8803@fedora>
In-Reply-To: <20240417180721.GA3212605@dev-arch.thelio-3990X>
References: <20240417142707.2082523-1-maxime.chevallier@bootlin.com>
	<20240417180721.GA3212605@dev-arch.thelio-3990X>
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

Hello Nathan,

On Wed, 17 Apr 2024 11:07:21 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Maxime,
> 
> On Wed, Apr 17, 2024 at 04:27:05PM +0200, Maxime Chevallier wrote:
> > Some of the phy_link_topology operations are protected by IS_REACHABLE,
> > which can lead to scenarios where the consumer, built as modules, sees the topology
> > unstubbed, whereas the initialization didn't occur.
> > 
> > Don't stub away the creation of the topology, it has no dependency on
> > any other parts like phylib, so we can make it always available.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> > Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> > ---
> > Hi Nathan, Heiner,
> > 
> > I'm currently at EOSS, so I'm sending this patch without having been
> > able to properly test it (build-tested only), but as this addresses an
> > issue for people using -next, I'm sending this anyway, sorry about that.  
> 
> No worries, thanks for continuing to take a look. Unfortunately, this
> patch fails to build during the linking stage for me with my
> configuration:
> 
> x86_64-linux-ld: vmlinux.o: in function `free_netdev':
> net/core/dev.c:11060:(.text+0xb14030): undefined reference to `phy_link_topo_destroy'
> x86_64-linux-ld: vmlinux.o: in function `alloc_netdev_mqs':
> net/core/dev.c:10966:(.text+0xb142d6): undefined reference to `phy_link_topo_create'

Heh serves me well for trying to go too fast :) phy_link_topo_create
then need to compile unconditionally, so I'm indeed missing some bits
here.

Thanks a lot for testing,

Maxime

> 
> > Hopefully it can address the issue for now, I haven't given-up on your
> > idea to introduce a config option Heiner :)
> > 
> > Thanks,
> > 
> > Maxime
> > 
> >  include/linux/phy_link_topology_core.h | 15 ---------------
> >  1 file changed, 15 deletions(-)
> > 
> > diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
> > index 0a6479055745..61e2592f24ac 100644
> > --- a/include/linux/phy_link_topology_core.h
> > +++ b/include/linux/phy_link_topology_core.h
> > @@ -4,22 +4,7 @@
> >  
> >  struct phy_link_topology;
> >  
> > -#if IS_REACHABLE(CONFIG_PHYLIB)
> > -
> >  struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
> >  void phy_link_topo_destroy(struct phy_link_topology *topo);
> >  
> > -#else
> > -
> > -static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> > -{
> > -	return NULL;
> > -}
> > -
> > -static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> > -{
> > -}
> > -
> > -#endif
> > -
> >  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
> > -- 
> > 2.44.0
> >   


