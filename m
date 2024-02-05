Return-Path: <linux-kernel+bounces-52338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794728496E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F48F1F22036
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE912E45;
	Mon,  5 Feb 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l8cc5yIQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C712B7B;
	Mon,  5 Feb 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126280; cv=none; b=mPM+Br5Dbs+/tErqyRo53xFWFoYsHaXbVM2YQII2XNwX5NkwPHMoS/nlfpXGyCuj1rcIjzNNKNrWkxPmpNiMSWL5oGneGXPmZeINfcrY6xrqD58hSrflQMSgzMqwSpG9/qg6TuhKjw7TXThGl2l2li7XAQWNK7+sCVuNbg5Dc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126280; c=relaxed/simple;
	bh=euPXLBXAelqicw0lRQ0DJ1+zpHhfADEjeoo1RY5ExrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8LJIYrHldomXTn3pOZ5WlQOT+CYBtZgDr1XR/VX8i0Kgf3X3hbHBZACfVAWOYysT4mZh3UyXrpd3eZn/lPSTFx9sQ/1u+lNtQywf9ZwJhB8FPECi5QKcfJXnCSRtiBw+TSG16EoT2EKssnNSZsTkb43gb2usUZsT60Kjr2cOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l8cc5yIQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707126278; x=1738662278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=euPXLBXAelqicw0lRQ0DJ1+zpHhfADEjeoo1RY5ExrQ=;
  b=l8cc5yIQFb978FLMq0Yf1ajLboETyqIOekubxaS3/sIc7gZKw5asAuj7
   vGvRmI+XwFanPVABnAneNDX/0A3n7utQsaTYUfR94Y9lFY89BEPHjFN2P
   HSeJamU203wi//7PPU+aTwjjOJGXaxWenAvruZLXj8GjsLFUF7aP33YvY
   RtRzCuYJYFLLpyjQMQpBA0+iAOLb0s+gHM+NMHElzGcpee7Jt0xwfhoKz
   GWuMsvvu8UXwqKvqUbm1IIphLNIIZrGqgrRGo0G8EGIWjc1xpphVXLLdZ
   PMr49Odn/97IUsSZCyNU0MNvHs0GYUaQFKXANRgng6wPaNf+IEkpPco10
   A==;
X-CSE-ConnectionGUID: qD0EoaiPRPO89EswnZQLHA==
X-CSE-MsgGUID: 6+90ddOASOa2i4NaHuGhfA==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="246497384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 02:44:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 02:44:35 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 5 Feb 2024 02:44:34 -0700
Date: Mon, 5 Feb 2024 10:44:34 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] lan966x: Fix crash when adding interface under a lag
Message-ID: <20240205094434.bwhjufxtrnlkwbrf@DEN-DL-M31836.microchip.com>
References: <20240205080756.2134143-1-horatiu.vultur@microchip.com>
 <ZcCf4IGJHhY8uQQd@mev-dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZcCf4IGJHhY8uQQd@mev-dev>

The 02/05/2024 09:44, Michal Swiatkowski wrote:

Hi Michal,

> 
> On Mon, Feb 05, 2024 at 09:07:56AM +0100, Horatiu Vultur wrote:
> > There is a crash when adding one of the lan966x interfaces under a lag
> > interface. The issue can be reproduced like this:
> > ip link add name bond0 type bond miimon 100 mode balance-xor
> > ip link set dev eth0 master bond0
> >
> > The reason is because when adding a interface under the lag it would go
> > through all the ports and try to figure out which other ports are under
> > that lag interface. And the issue is that lan966x can have ports that are
> > NULL pointer as they are not probed. So then iterating over these ports
> > it would just crash as they are NULL pointers.
> > The fix consists in actually checking for NULL pointers before accessing
> > something from the ports. Like we do in other places.
> >
> > Fixes: cabc9d49333d ("net: lan966x: Add lag support for lan966x")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_lag.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > index 41fa2523d91d3..89a2c3176f1da 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > @@ -37,19 +37,24 @@ static void lan966x_lag_set_aggr_pgids(struct lan966x *lan966x)
> >
> >       /* Now, set PGIDs for each active LAG */
> >       for (lag = 0; lag < lan966x->num_phys_ports; ++lag) {
> > -             struct net_device *bond = lan966x->ports[lag]->bond;
> > +             struct lan966x_port *port = lan966x->ports[lag];
> >               int num_active_ports = 0;
> > +             struct net_device *bond;
> >               unsigned long bond_mask;
> >               u8 aggr_idx[16];
> >
> > -             if (!bond || (visited & BIT(lag)))
> > +             if (!port || !port->bond || (visited & BIT(lag)))
> >                       continue;
> >
> > +             bond = lan966x->ports[lag]->bond;
> Why not bond = port->bond?

That is also correct and more clear.
I think I just copy the line that I have removed and put it here. As it
has the same effect.
I can update this in the next version.

> 
> >               bond_mask = lan966x_lag_get_mask(lan966x, bond);
> >
> >               for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
> >                       struct lan966x_port *port = lan966x->ports[p];
> >
> > +                     if (!port)
> > +                             continue;
> > +
> >                       lan_wr(ANA_PGID_PGID_SET(bond_mask),
> >                              lan966x, ANA_PGID(p));
> >                       if (port->lag_tx_active)
> > --
> > 2.34.1
> >
> Only nit, otherwise:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Thanks,
> Michal

-- 
/Horatiu

