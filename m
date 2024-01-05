Return-Path: <linux-kernel+bounces-17604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02A82500B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124551F23BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5811E21A18;
	Fri,  5 Jan 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bk8VwQGY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BF208BD;
	Fri,  5 Jan 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D578C40005;
	Fri,  5 Jan 2024 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704443541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyYmzVm/qP7CoTti/7/1uH5HNF3/IzXKxXhez/kx98=;
	b=bk8VwQGYlzu3Ebd+X3+nP4+BE4bFXE9ZGZCBQp/VY0+vekrlAvi1sqnw9zBzxXbJwSy9ap
	kbNxKxAMlcat2ng9Dhx/oacFdFEiMzhduDajPQ7sjNcsFiK4SuyMSsAiTQR2H4iPTF04rV
	XDv9Qc5Wx1LeHhGJuoQi9NOsdk/SjX8/WwBPh7aGVZkn5QhJBrJ5Tq01tAn5noNEtcjlY9
	i+/wW5+5O1caAfCHluzAKSugHz/+jMpTyGpYXNJBjPIeJsBJOgOg5TNHqQOKtsTHKYtOV4
	7UnPxsS7wojv9FfAlzELNdVPF60uDafpV75k0D7e+zXGN5Qq+3V3iTfUpDPgWw==
Date: Fri, 5 Jan 2024 10:29:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240105102918.24398552@device-28.home>
In-Reply-To: <20240104151242.52fa8cb4@kernel.org>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-2-maxime.chevallier@bootlin.com>
	<20240104151242.52fa8cb4@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Thu, 4 Jan 2024 15:12:42 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 21 Dec 2023 19:00:34 +0100 Maxime Chevallier wrote:
> > @@ -2441,6 +2442,7 @@ struct net_device {
> >  #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
> >  	struct netprio_map __rcu *priomap;
> >  #endif
> > +	struct phy_link_topology	link_topo;  
> 
> Perhaps others would disagree but can we make this a pointer instead?
> Only allocate it on demand, when first PHY gets attached?
> Both saves space and netdevice.h will no longer need to know the
> definition of the struct.
>
> Complete noob question but I thought PHYs get attached at ndo_open
> time for drivers, don't they? We shouldn't want to re-ID in that case.

I'll give it a try, it could be doable to try to keep the index for
_some_ PHYs. I had a first try at this in the very first iteration, but
that was lost when converting to xarray for the index management. Since
the phy_device keeps track of its own index, we can try to re-use it,
but I can see it becoming difficult if we destroy the topology when all
PHYs are detached (after ndo_close).

When re-creating the xarray at the next ndo_open, we would need to know
what was the previous next_index, and we can't know that until PHYs are
all re-attached.

For now it would work because in most cases, we only have one PHY
behind the MAC we can guarantee won't go away, but there are devices
out-there with 2 PHYs connected to the same MAC with a MUX in the
middle (that's one thing this series prepares for), and here it would
be more complex to re-allocate the topology while knowing what's the
next unused index. Hope that makes sense :)

To summarize, I don't think we can easily both dynamically
allocate/destroy the topology based only on the presence of at least
one PHY, and try to keep the PHY index the same for non-hot-pluggable
PHYs.

> 
> >  	struct phy_device	*phydev;
> >  	struct sfp_bus		*sfp_bus;
> >  	struct lock_class_key	*qdisc_tx_busylock;  
> 
> > @@ -10872,6 +10873,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  #ifdef CONFIG_NET_SCHED
> >  	hash_init(dev->qdisc_hash);
> >  #endif
> > +	phy_link_topo_init(&dev->link_topo);
> > +
> >  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> >  	setup(dev);
> >    
> 
> I think you're missing a call to xa_destroy() somewhere, no?

Arg you're right... I was under the false assumption that because the
xarray wasn't dynamically allocated, we didn't need to perform any
cleanup, thanks for spotting this.

Maxime

