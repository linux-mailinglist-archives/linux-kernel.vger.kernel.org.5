Return-Path: <linux-kernel+bounces-166547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952338B9C22
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B171C219D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D08913C80A;
	Thu,  2 May 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="So0Vbqp8"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2E12DDBF;
	Thu,  2 May 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659273; cv=none; b=M8t0HqaTTI7Q9jYelJxl7p985XRFD7fs5dtxp4BBhVYZAAPcX3GNY4lVzMy/ZarOy1sUPxIVZBBBON7vzWMLlZZdlnFR9qkzevOG8TQsZdCey4cOnylPcexSGCB28SACLptQ9wBvpXDWMO2sriQWDKdZ1TBNAQsmF4s8zsYJ0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659273; c=relaxed/simple;
	bh=TqGPQfv5cuk6T1XGFYZfEGJtd5vUUufArvfOG8WA+bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTjh5RkpDKChZZJSIlo4tyFuFJVglEqEWwngo8pAR91R4NQS4bbJEGjoG/G7Qp/UA5J1pTxSrIw5An6h/jpNrkehecOYsUKN+vR0Xw7lNsSftPgwf2uixhMEDg0wV1p42njWs5Lu9bTI6lX+dzx9JIbAw4dkcwuu54xp0jhNZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=So0Vbqp8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/l18ESN+CGYoapWjh3HxNbj/XMovUs4b0G9wlX7P+3c=; b=So0Vbqp8qMueIWyjz6YJtlM1lU
	uelnWzp88m6gGS1Ft8TAqTi9Uvcl8S++BJwu/q32Dg0hY4s7wu4LEta3rzw+c5dJWn5zvPANXk136
	92zAq5NIYe+7xgaba3TMoKYW+9AgYRT2ygHgD0p9SqX+M4PFAzOjtlk/gENIOiVQf0iDihkoOG42q
	UHQe79XI7teRc+uS1bQ+v0H82YTwr1LoTPpnanstLiz9QAZ0+UE5OOy21zXvhwapdRTA6aK5VP3bd
	g1HfOqnaB7OVWuV+6K3NtAvyth+YsQfSI4lUbLds2In47jjJptrbdyGw9zJ3KSAfGjshM4ltqKjFt
	8DYE8VdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2XCQ-0007N8-1b;
	Thu, 02 May 2024 15:14:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2XCP-0003i3-J2; Thu, 02 May 2024 15:14:13 +0100
Date: Thu, 2 May 2024 15:14:13 +0100
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
Message-ID: <ZjOftdnoToSSsVJ1@shell.armlinux.org.uk>
References: <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
 <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
 <ZjOYuP5ypnH8GJWd@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjOYuP5ypnH8GJWd@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 02, 2024 at 03:44:24PM +0200, Stefan Eichenberger wrote:
> Hi Russell,
> 
> Sorry for the late reply but I wanted to give you some update after
> testing with the latest version of your patches on net-queue.

I've also been randomly distracted, and I've been meaning to ping you
to test some of the updates.

http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

The current set begins with:

"net: sfp-bus: constify link_modes to sfp_select_interface()" which is
now in net-next, then the patches between and including:

"net: phylink: validate sfp_select_interface() returned interface" to
"net: phylink: clean up phylink_resolve()"

That should get enough together for the PCS "neg" mode to be consistent
with what the MAC driver sees.

The remaining bits that I still need to sort out is the contents of
phylink_pcs_neg_mode() for the 802.3z mode with PHY, and also working
out some way of handling the SGMII case where the PHY and PCS disagree
(one only supporting inband the other not supporting inband.)

I'm not sure when I'll be able to get to that - things are getting
fairly chaotic again, meaning I have again less time to spend on
mainline... and I'd like to take some vacation time very soon (I really
need some time off!)

> I think I see the problem you are describing.
> 
> When the driver starts it will negotiate MLO_AN_PHY based on the
> capabilities of the PHY and of the PCS. However when I switch to 1GBit/s
> it should switch to MLO_AN_INBAND but this does not work. Here the
> output of phylink:

I'm designing this to work the other way - inband being able to fall
back to PHY (out of band) mode rather than PHY mode being able to fall
forwards to inband mode.

> The problem is that the PCS continues to be in phy mode but the PHY
> driver currently only supports LINK_INBAND_ENABLE and SGMII for 1GBit/s.
> 
> What I'm wondering is if it wouldn't make sense to adapt the phy driver
> to support MLO_AN_PHY in SGMII/1000BASE-X mode.

PHYs have no idea about MLO_AN_xxx at all, neither should they. This
is not part of phylib's API, and I don't think PHYs should ever know
about MLO_AN_xxx stuff (which is something purely between phylink and
the MAC driver.) The structure here is:

      MAC            PCS                   PHY
       ^              ^                    ^ ^-----.
       v              v                    v       |
   MAC driver <-> PCS driver <-------> PHY driver  |
       ^           ^                    ^          |
       |           |                    |          |
  MLO_AN_xxx  PHYLINK_PCS_NEG_xxx       |          |
       `           '                    |          |
        \         /                     v          |
          phylink <----------------> phylib <------'

MLO_AN_xxx is far beyond the PHY, and more or less defines the overall
"system" operating mode. PHYLINK_PCS_NEG_xxx defines the properties
used for the PCS link to the next device towards the media. This is
more of relevance to what the PHY should be using on its MAC-facing
interface.

> Currently the mxl-gpy phy driver can only support:
> 10/100/1000 MBit/s: SGMII with MLO_AN_INBAND
> 2500MBit/s          2500Base-X with MLO_AN_PHY
> 
> However, the PHY would also support the following mode:
> 10/100/1000 MBit/s: SGMII with MLO_AN_PHY

The problem with this is some PHYs will not pass data _unless_ their
SGMII control frame to the PCS has been acknowledged by the PCS - in
other words, inband has to be used. However, that can be coped with,
because such a PHY driver should be saying that it only supports
LINK_INBAND_ENABLE in SGMII mode... and firmware must tell phylink
that it wants to use inband mode (as that's exactly what firmware
must do today in this situation.)

> I just don't know how the PHY driver could know about what it should
> configure.

Currently, I haven't added an interface to cope with the case where
a PHY says LINK_INBAND_ENABLE | LINK_INBAND_DISABLE to allow it to be
configured in that case... that's something that will eventually be
needed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

