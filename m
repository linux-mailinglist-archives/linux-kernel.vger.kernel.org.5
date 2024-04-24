Return-Path: <linux-kernel+bounces-157591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CA8B134E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13136B26D38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65261DDC9;
	Wed, 24 Apr 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kx+kSCtF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0B7FF;
	Wed, 24 Apr 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985958; cv=none; b=mc1O1FCQrztBKUBm5smLs1JicnS7igtrE+4xMLHLV2ZwoSNLRGIKz7po23AQW9R0f8Ks36ltMYV8wUYcP0XO/YgyOBosSeFTU+I610KJ39Hn6jpz7ELK/1eFibcBgARuc5CaYfq5J2uf+uYl3noQ6oeX8/gLYiANyPRMzbN6Z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985958; c=relaxed/simple;
	bh=8sO7VvRJUWJCeIS/GiTcbcWoD3ZLuoqtz1clQCxgiKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkqOngeM1Kwvq0D8lCu+Gzb97Wlp+wQxVVpGQum6lwfmTN9AVqGuUJmidJrYorzROHw30ouFnN+chy7Q1ldB3GTR3a/WOguKAP7qPE4SArj0Y6A+s8TzcSvHaG5u8ZXfNQF/EaqyKtpPruZe8YH4hRrLqhfbYnoO+KnOdmU5zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kx+kSCtF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713985956; x=1745521956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sO7VvRJUWJCeIS/GiTcbcWoD3ZLuoqtz1clQCxgiKE=;
  b=Kx+kSCtFcpQLXVAbGr1AzyWABGY64Win52K5bjtU2hhqdFFiPfUoGhIj
   NdQWWK6j0Ss4dHJC060MChJQ9/tGLA3SglmeIigyL2bE53OyRZZV7y0PW
   A6Y1HCV/FolT91KLz09eLOl/XvULfmMwLBVSSk5tnHSNj9XBVfocdcjHE
   VCkYom4KTO3gpsnlIMA2exnBiq9gGKKqPG7uH1Jx4eIFKBcdWcO8Z4Bnu
   Aisr3n7I8K4xqYrSf5eJlzZj2cVg2MipXoMMux8NVFeeQeGsnCDkMZTvw
   viK9Cj2aUjzaprNY5bzpHURgrXH/xARp/ZTe939gEmQYMFDkO0QJSc2ma
   Q==;
X-CSE-ConnectionGUID: RoWAuDEJSWajuwZnxEnQcA==
X-CSE-MsgGUID: atNe8IIAQge5B1UnQCnu+g==
X-IronPort-AV: E=Sophos;i="6.07,227,1708412400"; 
   d="scan'208";a="189818174"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 12:12:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 12:12:05 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 12:12:05 -0700
Date: Wed, 24 Apr 2024 21:12:04 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
Message-ID: <20240424191204.h2jajp57kpgccaql@DEN-DL-M31836.microchip.com>
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
 <adf60fa5-052f-4135-acab-91a02a9aff61@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <adf60fa5-052f-4135-acab-91a02a9aff61@linux.dev>

The 04/24/2024 11:57, Vadim Fedorenko wrote:

Hi Vadim,

> 
> On 23/04/2024 20:57, Horatiu Vultur wrote:
> > Extend the PTP programmable gpios to implement also PTP_PF_EXTTS
> > function. The pins can be configured to capture both of rising
> > and falling edge. Once the event is seen, then an interrupt is
> > generated and the LTC is saved in the registers.
> > On lan8814 only GPIO 3 can be configured for this.
> > 
> > This was tested using:
> > ts2phc -m -l 7 -s generic -f ts2phc.cfg
> > 
> > Where the configuration was the following:
> > ---
> > [global]
> > ts2phc.pin_index  3
> > 
> > [eth0]
> > ---
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> I'm not sure what happened to (fac63186f116 net: phy: micrel: Add
> support for PTP_PF_EXTTS for lan8841), looks like this patch is the
> rework previous with the limit to GPIO 3 only. In this case comments
> below are applicable.

These are two different PHYs:
1. lan8814 which is a quad PHY and the patch is this PHY
2. lan8841 which is a single PHY. And the commit that you mention it was
   for that PHY.
So this commit is not rework of the commit that you mention.

..

> 
> > +static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
> > +                          struct ptp_clock_request *rq, int on)
> > +{
> > +     struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
> > +                                                       ptp_clock_info);
> > +     struct phy_device *phydev = shared->phydev;
> > +     int pin;
> > +
> > +     if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> > +                             PTP_EXTTS_EDGES |
> > +                             PTP_STRICT_FLAGS))
> > +             return -EOPNOTSUPP;
> > +
> > +     pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
> > +                        rq->extts.index);
> > +     if (pin == -1 || pin != LAN8814_PTP_EXTTS_NUM)
> > +             return -EINVAL;
> 
> I'm not sure how will enable request pass this check?
> In lan8814_ptp_probe_once pins are initialized with PTP_PF_NONE,
> and ptp_find_pin will always return -1, which will end up with
> -EINVAL here and never hit lan8814_ptp_extts_on/lan8814_ptp_extts_off
> 

Why ptp_find_pin will always return -1? Because we can set the function
of the pin.

..

 >       }
> > @@ -3148,6 +3263,10 @@ static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
> >               if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
> >                       return -1;
> >               break;
> > +     case PTP_PF_EXTTS:
> > +             if (pin != LAN8814_PTP_EXTTS_NUM)
> 
> Here the check states that exactly GPIO 3 can have EXTTS function, but
> later in the config...

..
> 
> > +                     return -1;
> > +             break;
> >       default:
> >               return -1;
> >       }
> > 
> > @@ -3541,7 +3721,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
> >       snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
> >       shared->ptp_clock_info.max_adj = 31249999;
> >       shared->ptp_clock_info.n_alarm = 0;
> > -     shared->ptp_clock_info.n_ext_ts = 0;
> > +     shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
> 
> Here ptp_clock is configured to have 3 pins supporting EXTTS.
> Looks like it should be n_ext_ts = 1;

Good point, let me have a look at this.


> 
> >       shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
> >       shared->ptp_clock_info.pps = 0;
> >       shared->ptp_clock_info.pin_config = shared->pin_config;
> 
> 

-- 
/Horatiu

