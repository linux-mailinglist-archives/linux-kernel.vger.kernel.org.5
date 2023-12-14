Return-Path: <linux-kernel+bounces-256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB54813E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624501C21FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094F32C6AD;
	Thu, 14 Dec 2023 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDdTi3GF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E162DB79;
	Thu, 14 Dec 2023 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso62960f8f.0;
        Thu, 14 Dec 2023 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702597150; x=1703201950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KaAHlm+HSdz5rpNR+CgBxGChQ0hnWO14UQuggvpy/cw=;
        b=DDdTi3GFLTIRxOxfvxUp8lHYi9q55zRIIBRl/ttOAFjWEO+QyAYnnXG3MtrHhT8JLj
         vEo4fYhSmWkKfXT9w4DXC67uQGKJdeV4Qq0rg2ptXmDlszBjxSRWBr5ZATPbhfYkrzbZ
         8pFI4pT9Y50t+m9VdzGYx5ByErhOoJ3K3ewqY4wLrtHkeslx9a/r+KPy+0UJczFyz+kH
         zih+L/TxeqAZ8vItaQFFAVOEAF/lfwY3zMSwquA8v7wpzQu+SsJ8wxKXh7/r13Wk9X9v
         7EdnjkecdBaBm4N7EBRvmzq5bpT5/ph1FJ9HCUL47MTaNwK3IZ9vcIENTSdXWMqebLNi
         3amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702597150; x=1703201950;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaAHlm+HSdz5rpNR+CgBxGChQ0hnWO14UQuggvpy/cw=;
        b=FP9rN9vuR5p8FjBnfmcWHUpclEsAYiPu9Fqqmbr521EiIoHl31PPfGn5EhRj06dYES
         3UPnLPSVCWAVsOvDVe/W4qfmtA142t9KwftD90J6Fr4Wzo6PCGqU1sucIxegR4Mc2KTw
         QWdM0n2KgmP7IIJLcVvpZ0KidY3uWPfWinokRsdEFTWsTFl+UPFktd6FX/rYqhUdeTeB
         YurAMuFlKeLD0WXNt/OaXQQFY4kht+SLvUSk6bWfENc8Dy1yTsBX/2pgqGhB+KzSqi5r
         Mqln3ucssok76Dp1mWWJSBSIvPrKcq6JmnAE3N5dbe/95D5vKzTpCa70DNFZBzLmrqk3
         0VSQ==
X-Gm-Message-State: AOJu0YyX2uk3lpVxyd+CvcQJouSa0l7pbK/wvcwXhOEem3Hf7f2P2y0l
	ot7kJhSNmxqgegM7yrk/f4Q=
X-Google-Smtp-Source: AGHT+IFlVZ4kyRnZpnjhiVd15iyzFe0K21ph94UW7wfDB4R38x5Ef3UrzFd4ZyiaLe3RdDgHauUYDw==
X-Received: by 2002:adf:e309:0:b0:336:984:6b2c with SMTP id b9-20020adfe309000000b0033609846b2cmr4969197wrj.8.1702597149727;
        Thu, 14 Dec 2023 15:39:09 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d46ca000000b003364a398398sm2337615wrs.9.2023.12.14.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 15:39:09 -0800 (PST)
Message-ID: <657b921d.5d0a0220.7815b.87dd@mx.google.com>
X-Google-Original-Message-ID: <ZXszWxEuzGBadp6Z@Ansuel-xps.>
Date: Thu, 14 Dec 2023 17:54:51 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 2/4] net: phy: extend PHY package API to
 support multiple global address
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-3-ansuelsmth@gmail.com>
 <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>

On Thu, Dec 14, 2023 at 05:05:39PM +0000, Russell King (Oracle) wrote:
> On Thu, Dec 14, 2023 at 01:10:24PM +0100, Christian Marangi wrote:
> > @@ -1998,46 +1999,54 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
> >  		       struct kernel_hwtstamp_config *config,
> >  		       struct netlink_ext_ack *extack);
> >  
> > -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> > +static inline int phy_package_read(struct phy_device *phydev,
> > +				   unsigned int addr_offset, u32 regnum)
> >  {
> >  	struct phy_package_shared *shared = phydev->shared;
> > +	u8 addr = shared->base_addr + addr_offset;
> >  
> > -	if (!shared)
> > +	if (addr >= PHY_MAX_ADDR)
> >  		return -EIO;
> 
> I did notice that you're using u8 in patch 1 as well - and while it's
> fine in patch 1 (because we validate the range of the value we will
> assign to that variable) that is not the case here.
> 
> Yes, shared->base_addr is a u8, but addr_offset is an unsigned int,
> and this is implicitly cast-down to a u8 in the calculation of addr,
> chopping off the bits above bit 7.
> 
> How about this approach:
> 
> static int phy_package_address(struct phy_device *phydev,
> 			       unsigned int addr_offset)
> {
> 	struct phy_package_shared *shared = phydev->shared;
> 	unsigned int addr = shared->addr + addr_offset;
> 
> 	/* detect wrap */
> 	if (addr < addr_offset)
> 		return -EIO;
> 
> 	/* detect invalid address */
> 	if (addr >= PHY_ADDR_MAX)
> 		return -EIO;
> 
> 	/* we know that addr will be in the range 0..31 and thus the
> 	 * implicit cast to a signed int is not a problem.
> 	 */
> 	return addr;
> }
> 
> and then these functions all become:
> 
> 	int addr = phy_package_address(phydev, addr_offset);
> 
> 	if (addr < 0)
> 		return addr;
> 
> I'll give you that this is belt and braces, but it avoids problems
> should a negative errno value be passed in as addr_offset (which will
> be cast to a very large positive integer.)

I also feel an helper is needed (since as you pointed out in the mmd
function we would have duplicated logic)

What I don't like is the wrap check.

But I wonder... Isn't it easier to have 

unsigned int addr = shared->base_addr + addr_offset;

and check if >= PHY_MAC_ADDR?

Everything is unsigned (so no negative case) and wrap is not possible as
nothing is downcasted.

After the check value is O.K. and can be trated as an int in
mdiobus_read (as we are sure it's in the limits and positive)

If this is correct, and the thing is a simple condition I think the
helper is not needed (or should we use it anyway for consistency in each
function?)

> 
> Andrew, any opinions on how far this should be taken?
> 

-- 
	Ansuel

