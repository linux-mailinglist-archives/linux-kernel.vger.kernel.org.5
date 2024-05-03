Return-Path: <linux-kernel+bounces-167460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8C8BA9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00C6287148
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02E14F9C6;
	Fri,  3 May 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WQdh+Gho"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB414F121;
	Fri,  3 May 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728361; cv=none; b=Kshnjp//HIJj+fIZSZWenjQKby3bLCM4sUV2BbTdDrcKTBeGVwNz24ynDnrjgIOPe1XdYWuNGl1+eh72cIwoUmLHGC6Cq3kGzUBp3qrqG2QOOg6M6c/zXwpS3VBIJeDWX8f+zxRZKRBT2PpyLKtD7n8pJT8TT500jMUotTd+X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728361; c=relaxed/simple;
	bh=C42jwh62YhIOEUfzrCeStGfYKqLsoksaGYYiDrdm6hY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIh89rxSVyJ4P8VRXIGfVpEJAgjBYEH5Rv9hfEx9XNTvGWqS7PpvvtZL52Na99DlN3lTrjceuL6vE3e+0gg2fcW++IDYqq34f/NFYgeqTKJ9YLPz8/lIUUuh05DPBUnO9Qq/2Z3mF9JJbq/f4/y2yq4ta7ehnaeGM2nIY11uzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WQdh+Gho; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714728358; x=1746264358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C42jwh62YhIOEUfzrCeStGfYKqLsoksaGYYiDrdm6hY=;
  b=WQdh+Gho3t16BPFI/JhkBY24Zw6kl9iIYKFOrNkKY09gPI+ZmhI2scZl
   5NWeOGht0J7Hx9HYr87M6eqDw5S9QShoBgIC3P9QzouFRiIw1uffhuoTm
   Uc91tYBN+EIb0F2LnothLkhg6QA93qPkSlfoFMKjG7rts+Tns4ws5PHtp
   hfWUW8OgSfRX3WmPjndeVJgZHBQW5gdq6W75kYtbJ7f6oSx5hZEQmJAXF
   3q+w6D/Uv8cblOBTfmCjWS/BMZbH/FyAYmPBhPqItSSuu0hiyVEimyiDR
   vZPlw1gU1Pqe6avJG16D5ukisKzy5ovfqXPOrh1hyhFwBAyTfID0d/ei8
   A==;
X-CSE-ConnectionGUID: aYalchxHR+2BpTVuKX/c7A==
X-CSE-MsgGUID: AcWUS+V4QUazJYLAUlpsuQ==
X-IronPort-AV: E=Sophos;i="6.07,251,1708412400"; 
   d="scan'208";a="25631541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2024 02:25:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 02:25:11 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 02:25:11 -0700
Date: Fri, 3 May 2024 14:52:48 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<lxu@maxlinear.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjSs6JNb2WSmhHF5@HYD-DK-UNGSW21.microchip.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <d28a2bea1c7bb28dd1870116ddbdba78cf3817a4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d28a2bea1c7bb28dd1870116ddbdba78cf3817a4.camel@redhat.com>

Hi Paolo,

Thank you for review comments.

The 05/02/2024 15:49, Paolo Abeni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, 2024-04-30 at 10:36 +0530, Raju Lakkaraju wrote:
> > @@ -725,6 +726,8 @@ static int gpy_set_wol(struct phy_device *phydev,
> >               ret = phy_read(phydev, PHY_ISTAT);
> >               if (ret < 0)
> >                       return ret;
> > +
> > +             phydev->wolopts |= WAKE_MAGIC;
> 
> I'm wondering if 'phydev->wolopts' could/should be handled in the
> common code.

Ok. I will change.

> 
> >       } else {
> >               /* Disable magic packet matching */
> >               ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> > @@ -748,6 +751,8 @@ static int gpy_set_wol(struct phy_device *phydev,
> >               if (ret & (PHY_IMASK_MASK & ~PHY_IMASK_LSTC))
> >                       phy_trigger_machine(phydev);
> >
> > +             phydev->wolopts |= WAKE_PHY;
> > +
> >               return 0;
> >       }
> >
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 616bd7ba46cb..9740f08ad98e 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -2038,6 +2038,11 @@ int phy_suspend(struct phy_device *phydev)
> >       if (phydev->suspended)
> >               return 0;
> >
> > +     if (phydev->wolopts) {
> > +             wol.wolopts = phydev->wolopts;
> > +             phy_ethtool_set_wol(phydev, &wol);
> 
> The above will fail when the phy does not provide wol operations -
> should never happen when 'wolopts != 0', but possibly worth catching
> the error?

In another mail thread, Andrew gave different comment.
I will address that comment.

> 
> Thanks,
> 
> Paolo
> 

-- 
Thanks,                                                                         
Raju

