Return-Path: <linux-kernel+bounces-133536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D736989A531
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170E283C83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC2173355;
	Fri,  5 Apr 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="biWxvr8U"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3203172BA3;
	Fri,  5 Apr 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346393; cv=none; b=JKa7GL93HooZrmfS/O5ShCp8VzbPKmrW1HF0lcqWBeUVjHifElEPfBsnqmHNvltV7bJY+yfRh+9Z3rAc5dl0sXMFNaoafmjO6DIZKUzFKReUM9Q2PllnjVOZyqh2Aejqf3FcRIYJbTtBJbc7QAMqJ3sLbLPX6tJmPAE9b+Jr8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346393; c=relaxed/simple;
	bh=/PmtoA+LEViAKJ0fcog5saUVPgiPgx5ZMgX0tIQr6Ew=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJFcoUrZadAgcG2HbAR2LKpkxmdF8Hj3Mgh+dYilf6Wox/DVBZhaWNQ0vRye8+Oz5anY+PM77dn0DC4CBW1AU4+5Lft5WAguntptMUAUin1rnvXcHnS8UHhfkOzm2GnSSx1ovWNc0GKmtni2EOYYeIaAYFdW8qmtdZQujcmx3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=biWxvr8U; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712346390; x=1743882390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/PmtoA+LEViAKJ0fcog5saUVPgiPgx5ZMgX0tIQr6Ew=;
  b=biWxvr8U3qblss0NyZzyCvTWiZL+Uluj+7VmRQSYGN0IZROc4FZK9SsI
   p3VZlwe4IeK80uPENYe2gWmY4qHPhhq/+hT5DwzZaa1gQQETy69tXfXWh
   OpkGyi0Uk7L41Ft4MKMksPNFmht8yv7YYviuVEDMbG3EpVxRLP4WFvyZH
   oBPgy9lS4t1BXCzFRKlSytqBcZfSG2isYRqjDVmCh2XRA8jAgC42qbWld
   fZ+BxIPqWmIB9KrX9oXUhfozXS6CEjtiSr6otBWmd9JHu+rIfufIuQ6Nl
   AMRBL/5BB/P+GrEi4Y/ModxFFzkN9j2DOv70WEwChYD6U5aBBfipnm3il
   g==;
X-CSE-ConnectionGUID: xpLuj8wMSr2hyqqrVe0wTA==
X-CSE-MsgGUID: D4qVjqWhT9Wf7GT1Q4fnUQ==
X-IronPort-AV: E=Sophos;i="6.07,182,1708412400"; 
   d="scan'208";a="250502725"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 12:46:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 12:45:59 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 5 Apr 2024 12:45:57 -0700
Date: Fri, 5 Apr 2024 19:45:56 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: fix reconfiguration of PCS on link mode
 change
Message-ID: <20240405194556.ngto6ddgf5r2br33@DEN-DL-M70577>
References: <20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com>
 <Zg/Qf4P5gAzRUYuK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zg/Qf4P5gAzRUYuK@shell.armlinux.org.uk>

Hi Russel,

> > It was observed that the PCS would be misconfigured on link mode change,
> > if the negotiated link mode went from no-inband capabilities to in-band
> > capabilities. This bug appeared after the neg_mode change of phylink [1],
> > but is really due to the wrong config being used when reconfiguring the PCS.
> 
> I don't see how the change you point to could have changed the
> behaviour. Old code:
> 
>         conf.inband = phylink_autoneg_inband(mode);
>         conf.autoneg = phylink_test(advertising, Autoneg);
> 
> New code:
> 
>         conf.inband = neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED ||
>                       neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
>         conf.autoneg = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
> 
> where, for SGMII or 802.3z modes, neg_mode will be one of
> PHYLINK_PCS_NEG_INBAND_DISABLED or PHYLINK_PCS_NEG_INBAND_ENABLED if
> phylink_autoneg_inband(mode) is true, or PHYLINK_PCS_NEG_OUTBAND if
> not.

For inband/10GBase-R, conf.inband would be true, prior to the
phylink change. This is fine since conf.inband is only used when
configuring low speed devices.

After the change, conf.inband will be false when opting in through
phylink_pcs.net_mode = true. This causes the SGMII to be misconfigured,
since the inband parameter from the old config is used, and that
parameter is actually used for configuring SGMII..

TBH the commit description is inadequate at best. I will revise it in a
v2.

> 
> It does change conf.autoneg slightly in that this will always be true
> for SGMII, but will only be true for Autoneg + 802.3z modes.
> 
> As far as your code change goes, it looks correct to me, but I think
> it's fixing a bug that goes back long before the commit you have
> identified.

Just to be clear - by commit do you mean the phylink change or the commit
referenced in the fixes tag?

> 
> However, I think there's another issue here which is more relevant to
> the problem you describe in your commit message. If you look at
> port_conf_has_changed(), you will notice that it fails to compare
> conf.inband, and thus fails to notice any change in the setting of
> that configuration item. This will result in sparx5_port_pcs_set()
> not even being called if only conf.inband changes state.
> 
> Thus, changing from in-band to out-of-band or vice versa won't have
> any effect if this is the only change that occurs, and this also
> exists prior to my change.

Yes. I agree this is an issue that deserves a fix - separate from this
one I would think.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

