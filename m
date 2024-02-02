Return-Path: <linux-kernel+bounces-50236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898F84761F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF8E1C28ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB114C582;
	Fri,  2 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0AwoUNqs"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91B14AD0E;
	Fri,  2 Feb 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895038; cv=none; b=M8Exid2i1sA1sz+nBfphsYssCvNqwp58QUrWGCXCEZdgMAVVpy3rM4hdW05c43yuAiHUsOQLByHYzdLmTN+yXMyF9wTZ+nGapfxnQeFvl+74VTDgPM+oMOtrjfP//khG9kG2qbArSn+UnCKQxI+aWpDvYrqZ5iMiJDiy08c3t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895038; c=relaxed/simple;
	bh=BlIMjuEgLbBMCBsdwCAz1BdgaPd0WZtrspP0SKES5qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMFLskLzp2jBJsBrTlS3387YvysmFpKmziwAjaXJdDWqeQRMV/W+KXjn7X/NNqlbfwAJAeBZrM678t8nX9cm0QN+Fi05KsYnE1YXQoqNjNa8IC+hn9Trun9SeX79e3T1sq+XVi9FfvSSWDlIzGo4AbqwB8BTCNfn03DlIqTXIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0AwoUNqs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SrWGzRDXFcq0Pr0rVOE+6OznEblUBFj2izYzbtEY5sc=; b=0AwoUNqsmMIvSNZVVt2Ksny2HI
	2B5XEYr2LYd/flO3suuyWPhfyFHs2cxroDQtly9R9OOcgLEjCK1+R5EKBmxZoCxDAWIvGNK0+Uy4g
	V+4GFZnOLkDF3m2cW4wWtYvZUuk8/vrdCJK9Na+dg0S4YTkHkF0CDS8JRqYGD+z5B7NKSYdsBG06h
	LYxKRw4uSybfu8NTu8NtIKnzKM4LPbH1SQ11PT8llc8Mohx7qRcsmU2YFRbQfK3qtNfdkViOVBP77
	JBqp6ThbzqdM8m5CH+4n54DACeQhzIOainmjNQO0o8N5GbRVmhtbgepEO0kUPZ1bWj39QOEEcBkbO
	KNNFVdbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVxMw-0006Gu-03;
	Fri, 02 Feb 2024 17:30:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVxMt-0008U5-Nw; Fri, 02 Feb 2024 17:30:23 +0000
Date: Fri, 2 Feb 2024 17:30:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
Message-ID: <Zb0mryS0CGfkolbO@shell.armlinux.org.uk>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
 <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
 <8bbff46a-f316-49b7-82f8-44dbdd452b0d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbff46a-f316-49b7-82f8-44dbdd452b0d@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 06:08:33PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 05:40:21PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > > > +
> > > > +			phydev->drv->led_brightness_set = NULL;
> > > > +			phydev->drv->led_blink_set = NULL;
> > > > +			phydev->drv->led_hw_is_supported = NULL;
> > > > +			phydev->drv->led_hw_control_set = NULL;
> > > > +			phydev->drv->led_hw_control_get = NULL;
> > > 
> > > I don't see how that works. You have multiple PHYs using this
> > > driver. Some might have LEDs, some might have GPOs. But if you modify
> > > the driver structure like this, you prevent all PHYs from having LEDs,
> > > and maybe cause a Opps if a PHY device has already registered its
> > > LEDs?
> > >
> > 
> > God you are right! Off-topic but given the effects this may cause, why
> > the thing is not const?
> 
> I would like it to be, but its not easy. There are fields in the
> driver structure that phylib needs to modify. e.g. mdiodrv.driver gets
> passed to the driver core when registering the driver, and it modifies
> it. mdiodrv.flags is also manipulated. So we cannot make the whole
> structure const.

We can make phy_device's drv pointer const though, which would have the
effect of catching code such as the above. That doesn't impact the
driver model nor the mdio layer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

