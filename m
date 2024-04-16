Return-Path: <linux-kernel+bounces-147151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B48A7026
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989571F22175
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107AD13173F;
	Tue, 16 Apr 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vNe6/Btr"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0B130A76;
	Tue, 16 Apr 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282534; cv=none; b=qFmDIJIrdoXd01HEIEqGmX1YfgaHkVcgtE4l7c/5EbUtZG3hzN2gIRYjTHaTf9OdQQvdwRTNBPvm7ENo1CjC9O/sX68v+EZXsuHuLu3qQVED5CBw2keppocc98cQJOswFlwzhmG9uwonBuaLpH0mYnSHCKuqTE2Of64xXAzQLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282534; c=relaxed/simple;
	bh=7LiuzRlYvi/96BvFLIFohrkKwHGDfivoCdvdPYQ/DZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4/KldMongEJZfFMW67fBnmc3FrxG1HlptFxN8sY4dxSm5LpM5F8Sg5/zsbiXG5zEvsGK5uKcWfV+4EGixnAgMW0gELQnmovnP0ZuW/3SKAzwY4QaNA2+fLHTWNsdeP+7iuVvwkXeyCcGFoCIZtROXLWcnQ+wCdK/YYKE2kIuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vNe6/Btr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NVCA4wyFU9exr9tcOuCRXVzr7IFOkRpJTnTyMwRKb/Y=; b=vNe6/BtrCFUChNdBAmAQtdF7m0
	klnwkXW067VvhjKBRYUQgr1B6eJRvKht/6EGx0Y9LDHmRbZMeLK228Rp6lRRGOWockUxHFUscjygL
	zzvzW9kd/04HGMjrbUG+KQo7IB5aLjkZzdLz+ty8oW/bPnfLTQ0iDg4UDWhKrZ5job7vEcQWVzP0h
	sjAJYRLWYf1X8ZmY27oniyalobcuHJ/LmiPQX9S5xwBXiVcPkRGljVBcgX0OeQuPJuuk5HbbldzZv
	+UmlLldaRskCEp6514Leom7uLjtNOljjr3UzQJm/f0SX5a9gpBBIrXZIupn6c6e5BQsILo/o+IOjn
	4SCq10EA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53342)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwl2y-0000Zt-0V;
	Tue, 16 Apr 2024 16:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwl2v-0004xT-TS; Tue, 16 Apr 2024 16:48:33 +0100
Date: Tue, 16 Apr 2024 16:48:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zh6d0VKVFK7JJWAf@shell.armlinux.org.uk>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6clAtI3NO+nMEi@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> Hi Andrew,
> 
> Thanks a lot for the feedback.
> 
> On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > Add a new device tree property to disable SGMII autonegotiation and
> > > instead use the option to match the SGMII speed to what was negotiated
> > > on the twisted pair interface (tpi).
> > 
> > Could you explain this is more detail.
> > 
> > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > the symbols 100 times when running at 10Mbs, and 10 times when running
> > at 100Mbps.
> 
> Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> the controller. This will work for all three speed settings. However, if
> we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> disable SGMII autonegotiation in gpy_update_interface. This is not
> supported by this Ethernet controller because in-band-status is still
> enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> the SGMII link will not go into a working state.

I have been working on a phylink/phylib patch set to address this. As
I've been busy with health-based appointments during last week and this
week, I haven't been able to spend enough time to get that to a point
that I'm happy to publish it yet.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

