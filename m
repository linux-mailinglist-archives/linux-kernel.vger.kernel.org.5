Return-Path: <linux-kernel+bounces-167472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099E8BAA02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5342A1C216FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68514F9E2;
	Fri,  3 May 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pL50x3O3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5714F113;
	Fri,  3 May 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729250; cv=none; b=BXX1IgMpQ6hPJj3ll9ZbMN1IklOOn6FlVK7Zq1HkC6j8bOCjxadHExP4nJxga6s5YAaOkwROU9t+tH3UpWh6Wyw0x7BPvB++jrxVeG47pW6CUyurhQkx/1wFZ0sPPc8I8CEOljmq4yqmeXsNKvb7Y5JQ6dLHS28lCUumm/aX9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729250; c=relaxed/simple;
	bh=f+L7mTCSRybSvFROrdfW8LntJl7i3UmEP3ZMl7K/m44=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykrtpk6eimBrgGkJLEOAhodCHbKTJmrpLFpMXJRgZv1pyrE4hzR60yqj6HLKSiMOtk9JAGuh78X6NTpQWrZf8Anf9nSxa8RZHnpWJhGVx0T1Hj3+19V2HHtUs3ydfiEWJEQAIKPCHsdI+2sRl+HczWwSuE0c2iE+ZVO5bgvyomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pL50x3O3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714729248; x=1746265248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+L7mTCSRybSvFROrdfW8LntJl7i3UmEP3ZMl7K/m44=;
  b=pL50x3O38MeafsyrA5XGyHle6VIB3e2j+SsDQTsQ3N/92aE4FnDp2f39
   PF/oichL6NflgE6qU4EH7Lb5nQEhPIaDiSVjIdBZwT4pBtcOYZr44tgem
   liTa05JLH7DllEgzvR7FoVE0mZzKp+oEJ80cKoXVQc+Q/Rm+8Xo/QcmVe
   dGf+rJCettdjt0zzNhoTVStDHH0jYHAG7w+SCwaL+Ji1b8NIJDGFfc3mK
   5UMbB0avfWEAfJ3UdbmmovbfgNYD7Ft21SWWyld8GJ3T/C8MHr+4ieYc3
   134ZmrXsfBGWnYgwJmDbb/Hpx3ZpPEfB6T2N7MxrWAyvA/w5o2vhc2R8H
   A==;
X-CSE-ConnectionGUID: bbg/IDqlTRajfoIJVPCGSg==
X-CSE-MsgGUID: JYFz59PQRziij8+7tAJupQ==
X-IronPort-AV: E=Sophos;i="6.07,251,1708412400"; 
   d="scan'208";a="24058447"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2024 02:40:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 02:39:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 02:39:56 -0700
Date: Fri, 3 May 2024 15:07:34 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<lxu@maxlinear.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjSwXghk/lsT6Ndo@HYD-DK-UNGSW21.microchip.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>

Hi Andrew,

Thank you for review comments.

The 05/02/2024 16:51, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Apr 30, 2024 at 10:36:35AM +0530, Raju Lakkaraju wrote:
> > Introduce a new member named 'wolopts' to the 'phy_device' structure to
> > store the user-specified Wake-on-LAN (WOL) settings. Update this member
> > within the phy driver's 'set_wol()' function whenever the WOL configuration
> > is modified by the user.
> >
> > Currently, when the system resumes from sleep, the 'phy_init_hw()' function
> > resets the PHY's configuration and interrupts, which leads to problems upon
> > subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
> > we can ensure that the PHY's WOL configuration is correctly reapplied
> > through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
> > the issue
> 
> Sorry it took a white to review this.
> 

Based on your review comments, I will update this.

> >
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> >  drivers/net/phy/mxl-gpy.c    | 5 +++++
> >  drivers/net/phy/phy_device.c | 5 +++++
> >  include/linux/phy.h          | 2 ++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> > index b2d36a3a96f1..6edb29a1d77e 100644
> > --- a/drivers/net/phy/mxl-gpy.c
> > +++ b/drivers/net/phy/mxl-gpy.c
> > @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
> >       struct net_device *attach_dev = phydev->attached_dev;
> >       int ret;
> >
> > +     phydev->wolopts = 0;
> 
> Is this specific to mlx-gpy?
> 

Currently I have GPY211C PHY along with PCI11414 chip hardware. That's reason
I add these changes for GPY211C PHY.
I test the changes on my board.

> You should be trying to solve the problem for all PHYs which support
> WoL. So i expect the core to be doing most of the work. In fact, i
> don't think there is any need for driver specific code.

Ok. I will change.

> 
> phy_ethtool_set_wol() can set phydev->wolopts after calling
> phydev->drv->set_wol(). If it returns an error, including -ENOTSUPP,
> set phydev->wolopts to 0, otherwise set it to wolopts.
> 

Ok.
One quick question.
some of the options (ex. WAKE_PHY, WAKE_MAGIC etc) support on PHY and other
options (ex. WAKE_UCAST, WAKE_MAGICSECURE etc) on MAC of Ethernet device.

Suppose, user configure the combination (i.e. wol gu) option,
Is PHY flag should hold combination option or only PHY supported option ?
Ex:
$ sudo ethtool -s enp5s0 wol gu

Output of phydev's wolopts flag values should be 0x00000022 or 0x00000020 ?
In this case, PHY support WAKE_MAGIC and MAC support WAKE_UCAST

Anyhow, even phy's wolopts holds the user configuration value, get_wol( )
function read from PHY register and display only "g" 

> > @@ -2038,6 +2038,11 @@ int phy_suspend(struct phy_device *phydev)
> >       if (phydev->suspended)
> >               return 0;
> >
> > +     if (phydev->wolopts) {
> > +             wol.wolopts = phydev->wolopts;
> > +             phy_ethtool_set_wol(phydev, &wol);
> > +     }
> 
> Why on suspend? I would expect it to be on resume, after the PHY has
> been reset.

Ok. I will change.
May be in phy_init_hw( ) function is better place to re-config the WOL

> 
> I also think you need to save sopass[] in phydev, since some PHYs
> support WAKE_MAGICSECURE. Just because mlx-gpy does not need the
> password does not mean we should ignore it in general. I also think it
> is safe to store in memory. Its is not a highly confidential
> password. I would not be too surprised if some PHYs have the registers
> read/write rather than write only.

Ok. I will add sopass[] also.

> 
>         Andrew

-- 
Thanks,                                                                         
Raju

