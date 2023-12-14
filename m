Return-Path: <linux-kernel+bounces-262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB4813E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698E0B21C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD932C6AD;
	Thu, 14 Dec 2023 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cql5vmFx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E196C6F1;
	Thu, 14 Dec 2023 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AGhWCo3kebEsFhbGunIR4r1yUG3IKZL5BCf/J4dBVOQ=; b=Cql5vmFxeviq3QAIJKNd8I3mxr
	NrqSPnVL6vLMh91+DwSjADq0qrXQhRM2LLdgcPEnlQQ0fIUbcrpauHxf2yELgwE89CjqyrvFkAGA5
	8dtazzKrPvBCPtowDPdgoieulYKJeO4lsxY82qYOzYAKXKP+iL4gpyFAaZBRVDWNnrzoe3vl44lqz
	UaHO0O2kThTU01YlF3j4MxV8z3CYqVmf9urD6g1hMJcFGyqPGpJtfJMRJaUrVBidsPMEKy8locyid
	XxLjaK+o0yvAwqIMBAEWo/MuJ/boMvjc97shseIqZF+qpgH6XoRgVgY5zaaqZiowbr4sZS/wTsaQg
	hZGbL4Dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDvX8-00022X-2X;
	Thu, 14 Dec 2023 23:54:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDvX8-0002zR-2g; Thu, 14 Dec 2023 23:54:26 +0000
Date: Thu, 14 Dec 2023 23:54:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <ZXuVsotg1DV596lV@shell.armlinux.org.uk>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-3-ansuelsmth@gmail.com>
 <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>
 <657b921d.5d0a0220.7815b.87dd@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657b921d.5d0a0220.7815b.87dd@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 05:54:51PM +0100, Christian Marangi wrote:
> What I don't like is the wrap check.
> 
> But I wonder... Isn't it easier to have 
> 
> unsigned int addr = shared->base_addr + addr_offset;
> 
> and check if >= PHY_MAC_ADDR?
> 
> Everything is unsigned (so no negative case) and wrap is not possible as
> nothing is downcasted.

I'm afraid that I LOL'd at "wrap is not possible" ! Of course it's
possible. Here's an example:

	shared->base_addr is 20
	addr_offset is ~0 (or -1 casted to an unsigned int)
	addr becomes 19

How about:

	if (addr_offset >= PHY_MAX_ADDR)
		return -EIO;

	addr = shared->base_addr + addr_offset;
	if (addr >= PHY_MAX_ADDR)
		return -EIO;

and then we could keep 'addr' as u8.

Honestly, I have wondered why the mdio bus address is a signed int, but
never decided to do anything about it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

