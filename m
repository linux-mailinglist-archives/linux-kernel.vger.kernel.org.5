Return-Path: <linux-kernel+bounces-85152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9386B12D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523BF28AFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF277157E8E;
	Wed, 28 Feb 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mUrQbNBY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A18153513;
	Wed, 28 Feb 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128945; cv=none; b=rI8pvoWeims4bursWCxZTodNWkoaF3nX/NxbWnGghmR/u8e6dN0HAiM/o44KgMjeQFJyNovLyL8U8qKuN/a8kHv40ooAIfoizpI8zSVIJ8B0ntmoaHYh6+w6rZPhUhCs3q1vrbrEdJXpCuVqh3WNKOK/Bub/ERLeKwLFbdQn2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128945; c=relaxed/simple;
	bh=WdXypY2ZESI6ACy57WRtQ1GL13gJ87ahK2ngODFXcu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOA4eDo2oi1ZtTS23QZDNxHfP0cuFzyyK8DCpL59uv+KbwE1MubFBfJaEnZX1nkaCIzBmhI3I0ycY5hBEuyklrwMVeRWbg54pgi781nLR2QijG28TF3AGBJNo3U2WIdKNuShAcDeVMBe0hUNwZqFCIUB/yVlEcvx5H4Xm2Ue/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mUrQbNBY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709128943; x=1740664943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WdXypY2ZESI6ACy57WRtQ1GL13gJ87ahK2ngODFXcu4=;
  b=mUrQbNBYaG1g2ffVkIgusJ5ax1ZQEcuVlPRi/dYDfV4FW+SMrV6Ra96r
   bfYRsoc0Vc4fbKjb4d+nuYUKXXs+iu2KMPTrZRXlOzi/KOapH55VG8h/0
   2+sT4KNrak2TfRaEOnZHmf2B6d0fDRTEyqrl+vntrjwInkZ9YRobtS8eL
   GHZL5A30Vdix8Ruv2RQfsjATwEff1+5izzS5G1V/McKU8YVjRNUB0wosr
   RdRNE8KY92ER+kRHqy4Latfme2u8R62kcNZlPaF79dd5JkeYjoZNwoPL7
   B/E+QPQW8WuZNdonR9aps8krjnfNaVaCoJRSawbpRqos1IzyirWl8qSAX
   A==;
X-CSE-ConnectionGUID: NNZI3UdGTamRyI3/+iKe5g==
X-CSE-MsgGUID: Q/U1NwXmRwWY4O6IuTIWgA==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="247703922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 07:02:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 07:02:07 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 28 Feb 2024 07:02:07 -0700
Date: Wed, 28 Feb 2024 15:02:06 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: lan8814 cable improvement
 errata
Message-ID: <20240228140206.fm46zgjlhfwlkavh@DEN-DL-M31836.microchip.com>
References: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
 <20240228062813.1007138-3-horatiu.vultur@microchip.com>
 <62ee2e75-72d5-43bf-a37f-948692a0e551@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <62ee2e75-72d5-43bf-a37f-948692a0e551@intel.com>

The 02/28/2024 11:03, Wojciech Drewek wrote:

Hi Wojciech,

> 
> On 28.02.2024 07:28, Horatiu Vultur wrote:
> > When the length of the cable is more than 100m and the lan8814 is
> > configured to run in 1000Base-T Slave then the register of the device
> > needs to be optimized.
> >
> > Workaround this by setting the measure time to a value of 0xb. This
> > value can be set regardless of the configuration.
> >
> > This issue is described in 'LAN8814 Silicon Errata and Data Sheet
> > Clarification' and according to that, this will not be corrected in a
> > future silicon revision.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/phy/micrel.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 5a0cc89eaebdd..1e3b0436e161e 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -117,6 +117,10 @@
> >  #define LAN8814_EEE_STATE                    0x38
> >  #define LAN8814_EEE_STATE_MASK2P5P           BIT(10)
> >
> > +#define LAN8814_PD_CONTROLS                  0x9d
> > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_       GENMASK(3, 0)
> > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_        0xb
> > +
> >  /* Represents 1ppm adjustment in 2^32 format with
> >   * each nsec contains 4 clock cycles.
> >   * The value is calculated as following: (1/1000000)/((2^-32)/4)
> > @@ -3302,6 +3306,12 @@ static void lan8814_errata_fixes(struct phy_device *phydev)
> >       val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
> >       val &= ~LAN8814_EEE_STATE_MASK2P5P;
> >       lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
> > +
> > +     /* Improve cable reach beyond 100m */
> > +     val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
> > +     val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_;
> > +     val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_;
> > +     lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);
> 
> Ok, now I see that the second fix is also in lan8814_errata_fixes.
> I'd suggest to split both fixes to separate functions and name them
> in more descriptive way.

Yes, I can do that. Then I will create a separate function for each
errata fix and I will do the same also for future erratas.

> 
> >  }
> >
> >  static int lan8814_probe(struct phy_device *phydev)

-- 
/Horatiu

