Return-Path: <linux-kernel+bounces-147193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962D8A70CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4091C21BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718013329F;
	Tue, 16 Apr 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wg/HhgsP"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F013175E;
	Tue, 16 Apr 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283266; cv=none; b=HQs/KIgn42xKbdgKvQK2jwFCEZSyJ9gI3eNjjAnsOMDkvTrF8ndHzU9vue+dgKHMmtStuX/O4d0iE1cGzble+CM9iuYXhwJgMaKrJfL7sjcouTIp754ASKsmjP97JYkcA4agLYPdtXCCON3JleK3gaZfYSDOkpLmtz65oYoi6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283266; c=relaxed/simple;
	bh=DhO5h+b7vIc6jbIsUWA7z1iTfKMcBvd2Dz5vJhvMzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1CubdqeDx8sn/GJ9rGY56SqYpfiRGf3nBUdZsR6cgq5kpBx9eYi16WDsa9ebg4iRRaLabO1d+p9rLuCP9VAwk92yhK5vpthKVdGM3Ly4WCh/KzAgqTawPJITIwNy32LIkIxlGFSsJTNiof5CkU0mj9rJzrmbVyNNN2pTSE1dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wg/HhgsP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xeBMrRqxBEZ22eqTgIxs2B4bjpNxoQ68pH+OW+DIVMQ=; b=wg/HhgsPYE6YyJZQVYTCS/CrYE
	+Uhyf2Cn4T3O5dFfSP+jCgrPe9F6/099JdqxRqP+Haa1VP1hbHEg+Zi99y6VPbGfEHd0mlM4Vb3gd
	Epqw1r3yPo43uot0cs2K93+BzqJB8EZ/syBaZhrFSvC1fW5yLF1Ae8DRqHiBL/OSujAQP4P9dlDcF
	vXn8OjaYYHzUfisd0Jmyr1KlEg7H6tLn6YjvoZdtLnexRqbSqP1Lxli6A3HC/xZ2Guxr3o1IwSpXs
	O8ZLiXs7qYU9B6Yau36kPMHxe4EIOIly4MB0k6MLvTGK2sdFHy6ILqE5peqeeMWfyIau1YiAKoV8S
	iYVYZmfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwlEm-0000cR-1Y;
	Tue, 16 Apr 2024 17:00:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwlEm-0004xr-Bh; Tue, 16 Apr 2024 17:00:48 +0100
Date: Tue, 16 Apr 2024 17:00:48 +0100
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
Message-ID: <Zh6gsHqOM+ienmzE@shell.armlinux.org.uk>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <Zh6d0VKVFK7JJWAf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6d0VKVFK7JJWAf@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 04:48:34PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> > Hi Andrew,
> > 
> > Thanks a lot for the feedback.
> > 
> > On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > > Add a new device tree property to disable SGMII autonegotiation and
> > > > instead use the option to match the SGMII speed to what was negotiated
> > > > on the twisted pair interface (tpi).
> > > 
> > > Could you explain this is more detail.
> > > 
> > > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > > the symbols 100 times when running at 10Mbs, and 10 times when running
> > > at 100Mbps.
> > 
> > Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> > 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> > Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> > the controller. This will work for all three speed settings. However, if
> > we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> > disable SGMII autonegotiation in gpy_update_interface. This is not
> > supported by this Ethernet controller because in-band-status is still
> > enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> > the SGMII link will not go into a working state.
> 
> I have been working on a phylink/phylib patch set to address this. As
> I've been busy with health-based appointments during last week and this
> week, I haven't been able to spend enough time to get that to a point
> that I'm happy to publish it yet.

You can find the experimental patches at:

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=0c2fb62db211312ad2f5695997694908b54e9a17

and the three parents to that patch.

It's buried in:

http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

