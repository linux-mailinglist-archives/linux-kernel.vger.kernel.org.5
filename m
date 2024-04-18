Return-Path: <linux-kernel+bounces-150359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E928A9DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382F5285AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65B16C44E;
	Thu, 18 Apr 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pItwYMi4"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB99168B00;
	Thu, 18 Apr 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452553; cv=none; b=k18t+DEyab0zWSezr+2fYVCTLlYb4wccObvDh7qdQLqGYSKwQ92yFkGNNYD0k9wQt5j3rpCkXJqdvyTAumbVyDDgKWdRiGsogzPedugrkhk0ltaQOj5JWTBokbUHP2ck6rWdUNJY1IxegrA85ippYKmCLuwsV4Q+KXbtonso7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452553; c=relaxed/simple;
	bh=7OrWGR7uUGj5WD8ukNtQAAEgG5TyYDvXmdcs72e53PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nytoFN/LYv4wklvm42DSn2Gg/SXHTPK/l98fUCxBCwjmeOdYOKW3b3luIDYIupeuOt9JbXqDY41r+1gHiLe0IUU0js8PgfsErH/JgI/Th8ycS0Y0XuH7o0aazKplf4w2JNVqJZJUTd+2BNhpCLQkAHj4tgEDtRXbuBcAN2YLKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pItwYMi4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K5JziYjNp24S2C0b51bJopK9Dezy2DYDvLSOH+g4vyY=; b=pItwYMi4HEGWpIZtNXTAJZ8iZH
	xHKWnszJf9A+JKlX+rFnscAot3yj24A56YN6dMc4XSfveGqy/zf4LpPdd2F926ouKNSyxtwj7J63h
	4Yhk7kBv6VcNESf+p+EyFWnNC+uwaCGDZ6DF6D1qRHAm83ODc/MJaetfVva14NYvRbC/oJGbvgrWL
	dqngS+JaEIEvLs8d4lrB+enRbw87uBtJSmOsY+YFfSU5u6OjqElo3OvYNa0ZVKY9ovZ3udfFRgMMa
	mbQlO4m5wvTpXvAS/DB+lwnytLrOmRD3XWcTYOKP/OZlsrLAQwr6oVm+tTPGTW0SWsDD2qhHyAPyo
	TepeYzCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rxTH0-0006PF-0X;
	Thu, 18 Apr 2024 16:02:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rxTGx-00070y-Er; Thu, 18 Apr 2024 16:01:59 +0100
Date: Thu, 18 Apr 2024 16:01:59 +0100
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
Message-ID: <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh94yqo2EHRq8eEq@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 17, 2024 at 09:22:50AM +0200, Stefan Eichenberger wrote:
> On Tue, Apr 16, 2024 at 07:12:49PM +0100, Russell King (Oracle) wrote:
> > On Tue, Apr 16, 2024 at 07:23:03PM +0200, Stefan Eichenberger wrote:
> > > Hi Russell and Andrew,
> > > 
> > > On Tue, Apr 16, 2024 at 05:24:02PM +0100, Russell King (Oracle) wrote:
> > > > On Tue, Apr 16, 2024 at 06:02:08PM +0200, Andrew Lunn wrote:
> > > > > On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> > > > > > Hi Andrew,
> > > > > > 
> > > > > > Thanks a lot for the feedback.
> > > > > > 
> > > > > > On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > > > > > > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > > > > > > Add a new device tree property to disable SGMII autonegotiation and
> > > > > > > > instead use the option to match the SGMII speed to what was negotiated
> > > > > > > > on the twisted pair interface (tpi).
> > > > > > > 
> > > > > > > Could you explain this is more detail.
> > > > > > > 
> > > > > > > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > > > > > > the symbols 100 times when running at 10Mbs, and 10 times when running
> > > > > > > at 100Mbps.
> > > > > > 
> > > > > > Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> > > > > > 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> > > > > > Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> > > > > > the controller. This will work for all three speed settings. However, if
> > > > > > we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> > > > > > disable SGMII autonegotiation in gpy_update_interface. This is not
> > > > > > supported by this Ethernet controller because in-band-status is still
> > > > > > enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> > > > > > the SGMII link will not go into a working state.
> > > > > 
> > > > > This is where i expect Russel to point out that SGMII does not support
> > > > > 2.5G. What you actually mean is that the PHY swaps to 2500BaseX. And
> > > > > 2500BaseX does not perform speed negotiation, since it only supports
> > > > > 2500. So you also need the MAC to swap to 2500BaseX.
> > > > 
> > > > Yes, absolutely true that SGMII does not support 2.5G... and when
> > > > operating faster, than 2500base-X is normally used.
> > > > 
> > > > How, 2500base-X was slow to be standardised, and consequently different
> > > > manufacturers came up with different ideas. The common theme is that
> > > > it's 1000base-X up-clocked by 2.5x. Where the ideas differ is whether
> > > > in-band negotiation is supported or not. This has been a pain point for
> > > > a while now.
> > > > 
> > > > As I mentioned in my previous two messages, I have an experimental
> > > > patch series that helps to address this.
> > > > 
> > > > The issue is that implementations mix manufacturers, so we need to
> > > > know the capabilities of the PHY and the capabilities of the PCS, and
> > > > then hope that we can find some common ground between their
> > > > requirements.
> > > > 
> > > > There is then the issue that if you're not using phylink, then...
> > > > guess what... you either need to convert to use phylink or implement
> > > > the logic in your own MAC driver to detect what the PHY is doing
> > > > and what its capabilities are - but I think from what you've said,
> > > > you are using phylink.
> > > 
> > > Thanks for the patch series and the explanation. In our use case we have
> > > the mismatch between the PHY and the mvpp2 driver in 2500BaseX mode.
> > 
> > Ah, mvpp2. This is one of those cases where I think you have a
> > disagreement between manufacturers over 2500base-X.
> > 
> > Marvell's documentation clearly states that when operating in 1000base-X
> > mode, AN _must_ be enabled. Since programming 2500base-X is programming
> > the mvpp2 hardware for 1000base-X and then configuring the COMPHY to
> > clock faster, AN must also be enabled when operating at 2500base-X.
> > 
> > It seems you've coupled it with the mxl-gpy PHY which doesn't apparently
> > support AN when in 2500base-X.
> > 
> > Welcome to the mess of 2500base-X, and sadly we finally have the
> > situation that I've feared for years: one end of a 2500base-X link
> > that's documented as requiring AN, and the other end not providing it.
> > 
> > Sigh. If only the IEEE 802.3 committee had been more pro-active and
> > standardised 2500base-X _before_ manufacturers went off and did their
> > own different things.
> 
> I also checked the datasheet and you are right about the 1000base-X mode
> and in-band AN. What worked for us so far was to use SGMII mode even for
> 2.5Gbps and disable in-band AN (which is possible for SGMII). I think
> this works because as you wrote, the genphy just multiplies the clock by
> 2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
> might even be able to use in-band autonegoation for 10,100 and 1000Mbps
> and then just disable it for 2.5Gbps. I need to test it, but I have hope
> that this should work.

There is another way we could address this. If the querying support
had a means to identify that the endpoint supports bypass mode, we
could then have phylink identify that, and arrange to program the
mvpp2 end to be in 1000base-X + x2.5 clock + AN bypass, which would
mean it wouldn't require the inband 16-bit word to be present.

I haven't fully thought it through yet - for example, I haven't
considered how we should indicate to the PCS that AN bypass mode
should be enabled or disabled via the pcs_config() method.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

