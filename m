Return-Path: <linux-kernel+bounces-61202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6D850EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04361C215FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101E12E56;
	Mon, 12 Feb 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jWu/Kfa2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87812B72;
	Mon, 12 Feb 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726776; cv=none; b=OdQX5cIj7tJlGuIRDMcKXHgWXFKlEm72PvpzyEE+vGDhf6pQkWyPQrcgnGMLLbQdCaBSrlBAQaVHrLZBjNFLEO9cpfHQbmaPe8EEatmRJGYcDOX+WN9fHTQJ7gVDkE290dA3NOsk5/jVAQtQTk7WESAWNc6Po4BSNhNESxUSrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726776; c=relaxed/simple;
	bh=qyTPvECMMD7PLdsPw5g/Hi+5zh4RU30ugtOCwlCVVbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ7Hfmi/fAZlyf+ao8dgf/YEbePz1Vcxszt5oLn8AjKyXxMTOGAcI0zBh/c9ilNQq2DrAa+O9fAxl0E3aEKEtTKWa6Gc0khc130qw94P1m1q8EofI+o5mgCKJaXgnYeuirg6EnOJVsCn7lLayXrGV4IMEeFOBuJYmOZA4d7Mg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jWu/Kfa2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707726775; x=1739262775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyTPvECMMD7PLdsPw5g/Hi+5zh4RU30ugtOCwlCVVbo=;
  b=jWu/Kfa2bzl4XCNFUUNYTjGCnTsaxoXT7zG/8LyYQdKSFqyKIzvQDMxz
   vL+/0bfn+jFVuIt15fv8XbArIQxOxeTkdIdlRBWWXmAwqQR2Av8FZ6lgd
   iIAsQ7/8IPbWy2+WTXgeUgsKyCUTIIoB82MurLmaXAjX8n0LcS3ltRbrQ
   0WFSbxKuD5r4kKu7Ut8HfB3v4WBukg0E3QwhKOwkkd7ENpVWVttIPj0FD
   ZrGmQ3oV7v0BPBUj/uBsUzixrNmtD/cUqWIR1TQP+meCl7AKHP+BK98rh
   vkogiXilIE+/8jpi3qBFeuZ7ffglLgcijHovEzYwETO+qDXIYxGqy9SUl
   A==;
X-CSE-ConnectionGUID: PJUI358zS2+N2ZPOQUlDBQ==
X-CSE-MsgGUID: xVXDTiaMRkeK5P1qOSM6sQ==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="scan'208";a="16619492"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:32:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:32:30 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:32:30 -0700
Date: Mon, 12 Feb 2024 09:32:29 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] lan966x: Fix crash when adding interface under a
 lag
Message-ID: <20240212083229.tg3cabp4iee3p6tq@DEN-DL-M31836.microchip.com>
References: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
 <20240209135220.42e670d4@kernel.org>
 <20240212081038.cbsb2exfmcxxntzq@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240212081038.cbsb2exfmcxxntzq@DEN-DL-M31836.microchip.com>

The 02/12/2024 09:10, Horatiu Vultur wrote:
> The 02/09/2024 13:52, Jakub Kicinski wrote:
> 
> Hi Jakub,
> 
> > 
> > On Tue, 6 Feb 2024 13:30:54 +0100 Horatiu Vultur wrote:
> > >       for (lag = 0; lag < lan966x->num_phys_ports; ++lag) {
> > > -             struct net_device *bond = lan966x->ports[lag]->bond;
> > > +             struct lan966x_port *port = lan966x->ports[lag];
> > >               int num_active_ports = 0;
> > > +             struct net_device *bond;
> > >               unsigned long bond_mask;
> > >               u8 aggr_idx[16];
> > >
> > > -             if (!bond || (visited & BIT(lag)))
> > > +             if (!port || !port->bond || (visited & BIT(lag)))
> > >                       continue;
> > >
> > > +             bond = port->bond;
> > >               bond_mask = lan966x_lag_get_mask(lan966x, bond);
> > >
> > >               for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
> > >                       struct lan966x_port *port = lan966x->ports[p];
> > >
> > > +                     if (!port)
> > > +                             continue;
> > 
> > Why would lan966x_lag_get_mask() set a bit for a port that doesn't
> > exist? Earlier check makes sense. This one seems too defensive.
> 
> You are right, the lan966x_lag_get_mask() will not set a bit for a port
> that doesn't exist[1]. Therefore this check is not needed.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c#L354

While trying to rebase on net, the next version of this patch, I have seen that
actually this version was accepted even though it was marked as "Changes
Requested".
The commit sha is: 15faa1f67ab405d47789d4702f587ec7df7ef03e

How do you prefer to go forward from here?
- do you want to revert this and then I will send a new version?
- should I send a patch that just removes this unneeded check?
- any other suggestion?

> 
> > --
> > pw-bot: cr
> 
> -- 
> /Horatiu

-- 
/Horatiu

