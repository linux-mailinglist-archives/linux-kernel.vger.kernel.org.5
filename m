Return-Path: <linux-kernel+bounces-90247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A086FC68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C401C21B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346D1B7F3;
	Mon,  4 Mar 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O/Yv4jjW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF61B5BA;
	Mon,  4 Mar 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542120; cv=none; b=Bd7pxvdRIaWCnWUOAAZLgf0Fa9kzReiCs5fCkZc/b8H3WsJ7e/IHFF2jE95X+mHnEFKZ0CmMvxNaGjGM5m+ysfQggg0Iqd5i5zUYLxCWS2OZ2sfH3dr5pU25I1R+RORdt1gF/iZrlIP8MWjhE8c77ptAS5LY6kxkQJF/IwtMH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542120; c=relaxed/simple;
	bh=aDaQk+e4RDumn7Yg8P8fB6cB9SWjCDIX6AqVX7ZpLi8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB7bgJgnzoR8uMN40OBOqlNX6uDWPto5FR7BFw8cKy94XOk5I73MptjavEnKhpBUOXmVh6dt6FCghKzbBXtcCz04XZZBebePpjzArLm8mfcnuyaUSiGxAOYfk6oYKqIp6iJNbE9C1BnfBP/ee5/MSNrvzgb4FuHx3mIcrpW6waU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O/Yv4jjW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709542118; x=1741078118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDaQk+e4RDumn7Yg8P8fB6cB9SWjCDIX6AqVX7ZpLi8=;
  b=O/Yv4jjWM3j7Ab1ri19x9aDilLd10h7eCQgUnUmRh6V3tcUtGTmA7f/+
   Jnb/jGzXhJ85YPCWfknPFu/9EWltUpaG5wvEKX1Sm9nZNXlEZN3eIx90E
   7zrDMfO/wZTl7GYWYYWivttev/QG27C0eHeC2/F6d/S6/Wageh6h64iAi
   RVhtVXsp2lvgS0hC0Gj8O+3Rhe+cBJz/Uh/eTmqwvEv7TJ9dj5P2MWps4
   di3IlEGToRGc8XwgFRPcGVKgVvI+QinkKEz6X0MD4ypVqr1HyroQz93py
   Xu1GwCnAmsKVt2e+EYvYtxgM7P9nen+oujDIS3dCZLtKS74ytzCLVFM7v
   w==;
X-CSE-ConnectionGUID: YdiFYxKvQ4qBuHr5LrHuig==
X-CSE-MsgGUID: fvjNirW4QnitNI0pcGiNgw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="247913449"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 01:48:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 01:48:25 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 01:48:25 -0700
Date: Mon, 4 Mar 2024 09:48:24 +0100
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "wojciech.drewek@intel.com"
	<wojciech.drewek@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, UNGLinuxDriver
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Message-ID: <20240304084824.y42djaciaeq5gqz3@DEN-DL-M31836.microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
 <20240229195220.2673049-3-horatiu.vultur@microchip.com>
 <80bea3ec2ec86d2e75002f849da174f50e0b846b.camel@microchip.com>
 <20240301072757.t36qqf47erk4jygr@DEN-DL-M31836.microchip.com>
 <20240302194041.5d8f8fad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240302194041.5d8f8fad@kernel.org>

The 03/02/2024 19:40, Jakub Kicinski wrote:
> 
> On Fri, 1 Mar 2024 08:27:57 +0100 Horatiu Vultur - M31836 wrote:
> > > > +#define LAN8814_PD_CONTROLS                      0x9d
> > > > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_   GENMASK(3, 0)
> > > > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_    0xb
> > >
> > > nitpick: TIME_VAL macro is very generic if it can end with specific
> > > like TIME_VAL_100M or something similar will gives more readability.
> >
> > Actually I prefer to keep it like this the name if it is possible..
> > Because the VAL_ represents the value and MASK_ represents the mask
> > value. Therefore the actual bits name of the register is
> > LAN8814_PD_CONTROLS_PD_MEAS_TIME.
> >
> > I am trying to have a naming convetion about how to define names in this
> > file:
> > <TARGET>_<REG_NAME>_<REG_BITS_NAME>
> 
> Why the trailing underscores, tho?

That is not really needed. I will update this in the next version.

> 

-- 
/Horatiu

