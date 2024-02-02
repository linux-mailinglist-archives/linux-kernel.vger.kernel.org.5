Return-Path: <linux-kernel+bounces-50200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843418475C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BFB2B5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675B14C5A7;
	Fri,  2 Feb 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NtuLNXu5"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5C14AD3B;
	Fri,  2 Feb 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893480; cv=none; b=bTOotnaPtZOfepWcZvpVIdcY2iJpDsplbcAcneZg9ZAZEVz9iy2q24xU1FoB0iYDgMdfEuMxxOlWXgILZpEXV7uvj7E3roXfH9Sps7ndPxgt1uPZwHQymOzgVbGEqDUSCVF/BD0DomZgnSyg2/Ui0XsFkin6bHo+u8qTFcPE/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893480; c=relaxed/simple;
	bh=lvs9fHcrGg2OPMpdrPeH/OkjYfW05zd3QXvR1LMSlQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfGiXj90p4hEWclnT0DnZmRegJ7/pJZicEFVxLFNwlzZjAYDgAAzKYiijbQ9TeRW+zVJ1/qygLf0NSEIVX0TpUNrWuePx+Wrd2ll5bNMDYKRTl9r4Sngufn2r+4H52sHUZt8+/BlsRzemLGrGRu/BVvqL/2j7IGuAVrHt/pdilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NtuLNXu5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gP1Igi6tDOQ8064ZzeRS81oPRpXVLjhChGAEqcyWoFQ=; b=NtuLNXu5uyZVZexMYXOA7cgX/A
	IMbBwyXMxpvArMnzStfNdQPbZ2YMp/LPgTd9hCmdVdPm9cQrz43RPGn45CsqAZcWda7x+IwIXv8tQ
	ITyeHi1X2gWpzwvAaUu5nsGEgbqo1jDc1JlPC3xH8lh9dVtEBJIwKeft6OL2BM6y1vufeLTDdwsm5
	DuF+w2pt00feJa3O3Fm5H8kBC3wRrxw1OEGj70M9HcSJzc10KZsD6/HxUbJOEESHLX+VtcrreEU3X
	BsInpboJ9HaD1GIzgitauMThDXLlpIkoJUIwbS2nJJksnSOKeCbCwdA7jb4/V2lr/PpV4imMvPko2
	8aj4TaEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVwxm-0006FD-1e;
	Fri, 02 Feb 2024 17:04:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVwxj-0008T0-4x; Fri, 02 Feb 2024 17:04:23 +0000
Date: Fri, 2 Feb 2024 17:04:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <Zb0glzoHmgN5iHl7@shell.armlinux.org.uk>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
 <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 05:40:21PM +0100, Christian Marangi wrote:
> On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > > +
> > > +			phydev->drv->led_brightness_set = NULL;
> > > +			phydev->drv->led_blink_set = NULL;
> > > +			phydev->drv->led_hw_is_supported = NULL;
> > > +			phydev->drv->led_hw_control_set = NULL;
> > > +			phydev->drv->led_hw_control_get = NULL;
> > 
> > I don't see how that works. You have multiple PHYs using this
> > driver. Some might have LEDs, some might have GPOs. But if you modify
> > the driver structure like this, you prevent all PHYs from having LEDs,
> > and maybe cause a Opps if a PHY device has already registered its
> > LEDs?
> >
> 
> God you are right! Off-topic but given the effects this may cause, why
> the thing is not const? I assume it wouldn't make sense to add OPS based
> on the detected feature since it would have side effect on other PHYs
> that use the same driver.

Maybe phydev->drv should be const to avoid this kind of thing. It
doesn't look like it would be hard to do, and importantly doesn't
require casting away the const-ness anywhere. PHY drivers themselves
can't be const because the driver model needs to be able to modify
the embedded device_driver struct (e.g. see bus_add_driver().)

 drivers/net/phy/phy.c               | 3 +--
 drivers/net/phy/phy_device.c        | 4 ++--
 drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
 include/linux/phy.h                 | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

Just build-testing it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

