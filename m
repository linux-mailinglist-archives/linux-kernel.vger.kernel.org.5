Return-Path: <linux-kernel+bounces-70552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF62859917
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD301C21072
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DF71B3B;
	Sun, 18 Feb 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hlrl7vMg"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9832383A3;
	Sun, 18 Feb 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284947; cv=none; b=if+EdiR1Ps6P0fS8hXBd3d68Fw0tbOhr6PoRzejWSuMuD6bfkIA9ASeM6Ywp0Y1zlBmMWyXQLH6yvY8TtX+PIkff/q1vKJaW+IKms6/hRGOkSf84g66IBkvOoYq578imITWsv86UbBaqiRbKKRAyGLyCuBPy2yAvHvnLkFgk4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284947; c=relaxed/simple;
	bh=iCJNjC0YeEXkUS/DQGwV/OAvF2cLq0aBfrb0k5dMU/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1HcDnoK9drlgcwWixcNsUF9lBI8OQ2+BWXkHwVR3gNjrPoFBUqnjOuVwd3MIbkrOOans0V5MZSi4DbP4IavRzMiG6U5+x5VEOnB6pLbLaTu8A9rAU1j5nx91MLeiMF1uhQgTW/Ik5e+u6eiEvW6d4Vfe1lnXJMQSAA2obJFj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Hlrl7vMg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kP93Q1m5tjAZqLrYzqmBsZVmIXS8VDSyfvhf3lGrLcU=; b=Hlrl7vMgSWjf0d4k1EPg0rzsf9
	k/CQwX5IZgggyzwf2/FmkA+8o5WBQ7JfSPeAelJAi7WpAY8qCQOjvXsjKkux/n9xb4iHyB8j4kqQk
	41Q9CoWV57SuNTDLy5SNenxvo2FC2FYqOhAauY2wc3/WzOB/wJWlSvwuNu8BQKksa7oN4IA5BjHr1
	I2NZB/JKvLpiLVyWoj2qn1UtEZRBOZo0p9sI2eoETn0oOFQ+lBagpuqSLhkOmO0OqOGOwj7cWKvck
	+IHXXUj88j7XT5t1yEUQ9e5WKkmsBU2OpP17yIqoqVplBuQqMyR9e7smKOp8r9/6RCrzYqsYQVV7o
	dpPDMwjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58462)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbmwm-0003TZ-06;
	Sun, 18 Feb 2024 19:35:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbmwk-0007ec-Hp; Sun, 18 Feb 2024 19:35:30 +0000
Date: Sun, 18 Feb 2024 19:35:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 2/6] net: phy: fill phy_id with C45 PHY
Message-ID: <ZdJcArE5/hXb1xFe@shell.armlinux.org.uk>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218190034.15447-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 18, 2024 at 08:00:28PM +0100, Christian Marangi wrote:
> With C45 PHYs that provide PHY ID in C45 Package regs, PHY device
> .phy_id is not filled.

Intentionally so. Clause 45 PHYs don't have a single ID. Marvell
88X3310 is a case in point - there are at least two different vendor
IDs in this PHY.

Trying to squash Clause 45 PHY IDs down to a single identifier is
not sensible.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

