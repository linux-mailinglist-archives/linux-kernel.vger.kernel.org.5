Return-Path: <linux-kernel+bounces-142704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45F8A2F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F94A1F22839
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75267E69;
	Fri, 12 Apr 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lT+dK4IB"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67666B57;
	Fri, 12 Apr 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927815; cv=none; b=mBBMR6Lq5zVpv5aviejGaKEhnAGiYhJ2JD3PeamEi5j3+CpyR5P9nM/nbXrh32YRKuvVWxQfJ7LEFvMKZxo4NDfNuZ/+0Wmj50i3epfMKlgAAYoCYemfNOUl/Y7VlJZzccbzlEbI258J1WgKxMrnW6u/Tms1B7gqvuN9QEXceWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927815; c=relaxed/simple;
	bh=USOM0XCZ0/wu4cKnQkzgmul4MrjCVr2FMP7oVZE2duc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK0Mk5x2Qnob7xE4loO3u0djxEo6/5O6YMIT77ltKc7vW0Nxc8q2dg9FTQdeKM9Xc0qIW8WbbctNrhrJgQnaVZOIAggDV6db5nTVUD0+ecobObvOsOJlLnq0KBec3DA5Z7EpRPLb7JknN7XTmR/vb2zMsTXpqXd9WQTVTl+5sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lT+dK4IB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3A03240004;
	Fri, 12 Apr 2024 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712927811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5+3+rElzUNybXHG/ZwL7fFM6Iw46bn7txCnEsQ1q2w=;
	b=lT+dK4IBl81ohQ/NsUOa/zq3G805EZLYGAN0wFqWK2ljT7vjQaRpWC3Qc03ndnkG3TgUpm
	y5JxQB8JVB0AWSxNHLhB5+9J4mEX3PQHvJKATw9N02+A1o6CzbVSlRScL+Vvw4fEzSikpl
	Ar+zsj31zbD3D8pmx1BOjkGhR27phYPcPmg5VPaBym1oM8z2jNl5tRBaCzSEBBKeFseFry
	cllGgnhW1ZjimKFdazfcL24xB0XWJE/p0ext0rfJE3JAPM06bwiaJOyBbVXewadjWe/xwk
	pCmfiIrcTavpUHqLfiguFM7YV/WI8W9/qJe/FGcWsa2fYLeJkyaFrnrc8r+T2w==
Date: Fri, 12 Apr 2024 15:16:48 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Antoine Tenart <atenart@kernel.org>
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
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL
 topologies
Message-ID: <20240412151648.653d41be@device-28.home>
In-Reply-To: <171292699033.4917.4025686054785818967@kwain>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
	<171292699033.4917.4025686054785818967@kwain>
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

Hi Antoine,

On Fri, 12 Apr 2024 15:03:10 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> Hi Maxime,
> 
> Quoting Maxime Chevallier (2024-04-12 12:46:14)
> > 
> > This patch fixes a commit that is in net-next, hence the net-next tag and the
> > lack of "Fixes" tag.  
> 
> You can use Fixes: on net-next, that still helps to identify which
> commit is being fixed (eg. for reviews, while looking at the history,
> etc).

Won't the tag become invalid when the commit gets merged into an -rc
release then ?

> 
> > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> > index 985941c5c558..0f3973f07fac 100644
> > --- a/drivers/net/phy/phy_link_topology.c
> > +++ b/drivers/net/phy/phy_link_topology.c
> > @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
> >         struct phy_device_node *pdn;
> >         int ret;
> >  
> > +       if (!topo)
> > +               return 0;
> > +  
> 
> With that phy_sfp_connect_phy does not need to check the topo validity
> before calling phy_link_topo_add_phy. The other way around is fine too.
> 
> > @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
> >  void phy_link_topo_del_phy(struct phy_link_topology *topo,
> >                            struct phy_device *phy)
> >  {
> > -       struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
> > +       struct phy_device_node *pdn;
> > +
> > +       if (!topo)
> > +               return;
> > +
> > +       pdn = xa_erase(&topo->phys, phy->phyindex);  
> 
> Same here with phy_sfp_disconnect_phy.

Ah right, well spotted, thanks !

Maxime

> 
> Thanks!
> Antoine


