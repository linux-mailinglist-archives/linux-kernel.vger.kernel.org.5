Return-Path: <linux-kernel+bounces-61189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED79850EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828AC1F21BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3238C8E2;
	Mon, 12 Feb 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U3EgxE6I"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D06FC9;
	Mon, 12 Feb 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725467; cv=none; b=gWX9rLQdBZIZBKA3yUNAjZ/A72GgCTnJDIq/zCbuHl4tcfGp1MaGOUE9A0NQfhqmYuj/4ap2wkjZCwhsEMSeUkBekhsNT1hvq34ovGDK65pTcUSJ/+pyMAyJX22qvciLm52R95bXBOmXQM7BrOeyP2dpVzC09E/aEGm8Zze0+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725467; c=relaxed/simple;
	bh=C9W/ZSoRVcS+jpTM839uXWcvK8NK8poAV8hVnEHO1dY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ldCeP/H5qGmkbf3+gvLZgDfJ1R5hu+UrHVjp+zQQDPHKwnDkdcojq+7j6F2h8q9vXv9gOWm3ArHCIoSRKlYuul1BdvIgyQFxrMVi8RjV87Rf1UZPiyXaw/5fXz+qhpwcH2e669R47+Sbdhkb+ui7pLxZ71HLAsiZ319GknpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U3EgxE6I; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707725461; x=1739261461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9W/ZSoRVcS+jpTM839uXWcvK8NK8poAV8hVnEHO1dY=;
  b=U3EgxE6IK/4wGbMmDiX93Uq2MVkuZLjRX1fpWmBRGCm4d3399E3/M4o8
   WPl/W1FZeqL0x0MsnQVpAvAYAvyWRctIpC2kYIyLv3YnhUJWTckcVKZlH
   IQgREykGNFpClShL0GBvrUoChRPEb+SW1kXJ2tn/3fEXX0lJH5GLhXA7d
   NafQr8/k/YpN7gBaE6CEdFpdxzIc2OkOwo21SR7z01A49knFH7sF5JmD1
   enwoVLPnyagfcvqm4ZE0i71XYbObl8jzI6dRqK+wdCjfVERcXwSqr/EXb
   HktRvA0kan86s5jDk47cL50OtlLB8VNOTvSqWByLGC54SGiuCtrOjuXFS
   Q==;
X-CSE-ConnectionGUID: YCdb6VMSRbST71PnuIIhLw==
X-CSE-MsgGUID: 0p19Xb9vQ9WyRUoPSQ9amQ==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="scan'208";a="16103773"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:10:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:10:39 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:10:39 -0700
Date: Mon, 12 Feb 2024 09:10:38 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] lan966x: Fix crash when adding interface under a
 lag
Message-ID: <20240212081038.cbsb2exfmcxxntzq@DEN-DL-M31836.microchip.com>
References: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
 <20240209135220.42e670d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240209135220.42e670d4@kernel.org>

The 02/09/2024 13:52, Jakub Kicinski wrote:

Hi Jakub,

> 
> On Tue, 6 Feb 2024 13:30:54 +0100 Horatiu Vultur wrote:
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
> > +             bond = port->bond;
> >               bond_mask = lan966x_lag_get_mask(lan966x, bond);
> >
> >               for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
> >                       struct lan966x_port *port = lan966x->ports[p];
> >
> > +                     if (!port)
> > +                             continue;
> 
> Why would lan966x_lag_get_mask() set a bit for a port that doesn't
> exist? Earlier check makes sense. This one seems too defensive.

You are right, the lan966x_lag_get_mask() will not set a bit for a port
that doesn't exist[1]. Therefore this check is not needed.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c#L354

> --
> pw-bot: cr

-- 
/Horatiu

