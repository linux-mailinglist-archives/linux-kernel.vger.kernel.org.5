Return-Path: <linux-kernel+bounces-158907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AED8B2689
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196591C232FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B014E2FB;
	Thu, 25 Apr 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uiaDC9Ge"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E414D6FF;
	Thu, 25 Apr 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062671; cv=none; b=Mb5sahTjJ6VvISI/vTIjTvrt5nns+I386b+TMHEO/p1FS9Xfo6Vn12RQ3haCIKHdIqVhzky8iY5oxRnuEkQ5Qo2k0QNXg5Qy6p9Sx+1f/0HPRErgDx6Q9bDknMDqf3mJirzdt1WqyI0p4CcjgPeMdX2EZmHg4ypwF2bFZlJMXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062671; c=relaxed/simple;
	bh=poIxmZ0PRqfCzsMp3CR4zO6lhQO4pLpx1NaDDgLiP90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A95T3N7vRmVuhdVr30hcG6UKjO7mAk18yzFi8GEsDcL9WJj9wgMUZiVSCPfI5q+CWHFWS5kbITw21+Bt11uRqmjbCNs2a4aTLdYRMD5nKkzcH3tEnj8JoX5Uox1fCx81ui6bVAfOsyAVJTzPNrgQr08Ne6Xt7apCqzl6D/zOk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uiaDC9Ge; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8b1+faWGm5mpwKSaivBGykN20LEXfiYZflA8Z7Z08nc=; b=uiaDC9GeRFp3VmXg0uq3g+yLXO
	dSI7fejWAgSCohZ1o8+LFjsqFL6fRYd14pTH47ELwpgj/vlKVqSgA6z9/mgKSHl4vFv0hI5U5BAGw
	nUnMfsl1TO03Nc7+X6Nc9BY1T5bAkB9XhzgzSOpO1FjikkbRxe0JA2dp/JRYIxh/GTEeC5xG9ne8r
	pgv7eu4/qzQX00jwYXo2fP/rEsQ9k4yp+qqEZ4eQvKVXuGAL3gUmUNVV5cxNFch1iolQY1tM8SVMz
	V54VDnWeFYWGGHci1+Wexd+PaICF5ogtyqDHBs+DH5PFtNasmJ/aRFAC3Rmt3EarqJLoCDilAHYDA
	ax7sDDYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s01zo-0007f3-1A;
	Thu, 25 Apr 2024 17:30:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s01zm-0005j9-PF; Thu, 25 Apr 2024 17:30:50 +0100
Date: Thu, 25 Apr 2024 17:30:50 +0100
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
Message-ID: <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
References: <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zip8Hd/ozP3R8ASS@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 25, 2024 at 05:51:57PM +0200, Stefan Eichenberger wrote:
> On Thu, Apr 25, 2024 at 03:30:52PM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 25, 2024 at 01:24:51PM +0200, Stefan Eichenberger wrote:
> > > I think it should also work for mvneta, at least
> > > the code looks almost the same. I get the following for the Port
> > > Auto-Negotiation Configuration Register:
> > > 
> > > For 1Gbit/s it switches to SGMII and enables inband AN:
> > > Memory mapped at address 0xffffa0112000.
> > > Value at address 0xF2132E0C (0xffffa0112e0c): 0xB0C6
> > 
> > So here the link is forced up which is wrong for inband, because then
> > we have no way to detect the link going down.
> 
> Yes I also saw this and didn't understand it. When I clear the force bit
> it will be set back to 1 again when AN is enabled. I thought this might
> be a bug of the controller.

No it isn't, the hardware never changes the value in this register.
The difference will be because of what I explained previously.

Because the mvneta and mvpp2 hardware is "weird" in that these two
registers provide both PCS and MAC functions, we have to deal with
them in a way that is split between the phylink PCS and MAC
operations.

This code was written at a time when all we had was MLO_AN_* and
none of the PHYLINK_PCS_NEG_* stuff. PCSes got passed the MLO_AN_*
constants which were the same as what was passed via the MAC
operations. This made the implementation entirely consistent.

However, that lead PCS implementers to go off and do their own
things, so we ended up with a range of different PCS behaviours
depending on the implementation (because the way people interpreted
MLO_AN_INBAND, interface mode, and the Autoneg bit in the advertising
mask was all different.

So to bring some consistency, I changed the PCS interface to what we
have now, in the belief that it would later allow us to solve the
2500base-X problem.

However, I'd forgotten about the mvneta/mvpp2 details, but that was
fine at the time of this change because everything was still
consistent - we would only ever use PHYLINK_PCS_NEG_OUTBAND or
PHYLINK_PCS_NEG_NONE for non-MLO_AN_INBAND modes, and
PHYLINK_PCS_NEG_INBAND_* for interface modes that support inband
when using MLO_AN_INBAND.

Now, when trying to solve the 2500base-X problem which needs us to
use PHYLINK_PCS_NEG_OUTBAND in some situations, this means we can
end up with MLO_AN_INBAND + PHYLINK_PCS_NEG_OUTBAND, and this is
what is causing me problems (the link isn't forced up.)

Conversely, I suspect you have the situation where you have MLO_AN_PHY
or MLO_AN_FIXED being passed to the mac_config() and mac_link_up()
operations, but the PCS is being configured for a different mode.

I am wondering whether we should at the very least move the
configuration of the control register 0 and 2 to the pcs_config()
method so at least that's consistent with the PHYLINK_PCS_NEG_*
value passed to the PCS and thus the values programmed into the
autoneg config register. However, that still leaves a big hole in
how we handle the link forcing - which is necessary if inband AN
is disabled (in other words, if we need to read the link status
from the PHY as is done in MLO_AN_PHY mode.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

