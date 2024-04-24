Return-Path: <linux-kernel+bounces-157145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7788B0D66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B4D28B17D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8515F30A;
	Wed, 24 Apr 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="huFgtjX/"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0415EFC7;
	Wed, 24 Apr 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970704; cv=none; b=QzRVDq1D2BEiwDN1U2JNKpOhC+5JfAIna+fuQgQl6TTSpXXumnMw2rvuzGJW91+c8ZmmFg/3VjNF8m1mcfqYBo9CcIO7BHMXnxpDgkBqT/wtzEeOm7ojaV6iEkiOdPTwBZGYHcpHDWPGohF0nHArwPQ4dgSpVyRIbNqnFF/09xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970704; c=relaxed/simple;
	bh=x/ABSCkim9S0MeG/AzqNKvpbk54vNpeK5u4b7bC3YfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5sauUGNErg8WqTyVHMu1STqnVfTr3k37rwbCCo7qEmQ43RLHgDlt2//lzKON3QTj0rYXI4JOjcYKdon1++P8+byliCje0ty87ydOYr0oIN1QIgYBinx9mxMrifX6iqiPOt4BUXKh/syHAnM3wvy92h0lEZ9270Ol+dBGK8L7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=huFgtjX/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fzak5i6UEXrfZCHyTuoSWrRTPCwyT9tYF6PbbPFvEFg=; b=huFgtjX/EgWtocZIwmbY5+DXoU
	MjVxuqn3Sx2ZoV8nfypF8Sge2jSlpPWvPyfgDoarUG1du5Usx2gfJetiyI9MUu6hv7bVQYZWvJ6NO
	aaMwE5zawd5AaRVy30YOXW98BZaFHoqqeyqP3PRFi4R/s0LH+HruLIt7QVgeZTpn83MZpokIjf5bK
	hWS4vVSZH9NwvyZMjbZHtNKj6Xrv6/NMm3MjK+k+ROwjHElpkRnv78N6lBtAIcra89usohYpQLJOV
	GYZakpanBFv4g3ldCw9jhHsCWvjKC66T79c811qBX8gaZsx5b3UlB+VHwuLUEbc58lTSvo6vG3c7U
	Dfg9ZwXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54942)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rze4S-00068O-1H;
	Wed, 24 Apr 2024 15:58:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rze4O-0004k6-MP; Wed, 24 Apr 2024 15:58:00 +0100
Date: Wed, 24 Apr 2024 15:58:00 +0100
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
Message-ID: <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 18, 2024 at 04:01:59PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 17, 2024 at 09:22:50AM +0200, Stefan Eichenberger wrote:
> > I also checked the datasheet and you are right about the 1000base-X mode
> > and in-band AN. What worked for us so far was to use SGMII mode even for
> > 2.5Gbps and disable in-band AN (which is possible for SGMII). I think
> > this works because as you wrote, the genphy just multiplies the clock by
> > 2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
> > might even be able to use in-band autonegoation for 10,100 and 1000Mbps
> > and then just disable it for 2.5Gbps. I need to test it, but I have hope
> > that this should work.
> 
> There is another way we could address this. If the querying support
> had a means to identify that the endpoint supports bypass mode, we
> could then have phylink identify that, and arrange to program the
> mvpp2 end to be in 1000base-X + x2.5 clock + AN bypass, which would
> mean it wouldn't require the inband 16-bit word to be present.
> 
> I haven't fully thought it through yet - for example, I haven't
> considered how we should indicate to the PCS that AN bypass mode
> should be enabled or disabled via the pcs_config() method.

Okay, I've been trying to put more effort into this, but it's been slow
progress (sorry).

My thoughts from a design point of view were that we could just switch
to PHYLINK_PCS_NEG_OUTBAND instead of PHYLINK_PCS_NEG_INBAND_* and
everything at the PCS layer should be able to cope, but this is not the
case, especially with mvneta/mvpp2.

The problem is that mvneta/mvpp2 (and probably more) expect that

1) MLO_AN_INBAND means that the PCS will be using inband, and that
   means the link up/down state won't be forced. This basically implies
   that only PHYLINK_PCS_NEG_INBAND_* can be used can be used for the
   PCS.

2) !MLO_AN_INBAND means that an out-of-band mechanism will be used and
   that means that the link needs to be forced (since there's no way
   for the hardware to know whether the link should be up or down.)
   It's therefore expected that only PHYLINK_PCS_NEG_OUTBAND will be
   used for the PCS.

So, attempting to put a resolution of the PHY and PCS abilities into
phylink_pcs_neg_mode() and select the appropriate PHYLINK_PCS_NEG_*
mode alone just doesn't work. Yet... we need to do that in there when
considering whether inband can be enabled or not for non-PHY links.

Basically, it needs a re-think how to solve this...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

