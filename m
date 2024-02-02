Return-Path: <linux-kernel+bounces-50287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB738476FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8CB1C26B68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89B14C59D;
	Fri,  2 Feb 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jqGmbV+Q"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7D1474C5;
	Fri,  2 Feb 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897005; cv=none; b=PQSN7WMG6AaK9HsamtQf++mHCqjFL1z/3qfRuOiaufMQ5fZfTCX4OtvjUyfaVKqYZ3yX0FZ1D3bmU5YMunLPdjK7akOQjCZxMfB6XgocABlAxVM/vswozT9f+4iAzX+ZxK/RpdtaSWY4oGik8I/vgD6HMM8OXln963I0ss/LVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897005; c=relaxed/simple;
	bh=Uup5FZMCcfCZOBIUv6G2Fi/wsqkNSTdL09LNTQwRP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9jueDsoKwZAEE+j4Xt65rR5gEv6Mbrpp1XD2O3qoKQd3UU+0Ogb0Ojs8LUwd4ja/eBWK6I5TDbjNEketBmiAjkMXyvyjfzga1tSrUCYqZSR8FrbbU8aOFctI1fYdHmlHg4XCVDzFj/8hkJQGHZpRfL3o14cf+UmOcsJOVejr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jqGmbV+Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qW6erQdXZh/wex5Ipty9iKt5f/CAhi5xgAqgpkUZTXE=; b=jqGmbV+Q1QaVQdi2aLgWcgAdoB
	aSdWAty4d+FolwETOQNX57ObHIwrXEVvpY7/ORK8jpChvDNRv+Cc4SLhJqw7g1IzilwXF9S1WJWiF
	agLfa4ntaPuZdC9+NJl9JPwTTLJFwABGpyG6Fl40FdRfkxbzezkornZ9aubEFUnHZWc1VhEoOBIHz
	AOHTY4cg+kXDUth76QIHTUSN90EtNCU8ej7CsZ50Lid51NlTyWHfUIwFzBWGaFNvCRS+2qqG5rEAu
	CC6kKNcawpRX3WnKxgNcsKsR0tY0tkx97z4KFlyzthfOEqMxWooyHOrgQN/js7g9TTLAfuG7dcyza
	cm7uPp7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVxsj-0006KR-1y;
	Fri, 02 Feb 2024 18:03:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVxsh-0008VD-Sk; Fri, 02 Feb 2024 18:03:15 +0000
Date: Fri, 2 Feb 2024 18:03:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for ODI DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <Zb0uYyxaKIMHQbQW@shell.armlinux.org.uk>
References: <AS1PR03MB81893D69344708C98EE2B470827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZoDIPR3O/iei5z@shell.armlinux.org.uk>
 <AS1PR03MB818918BC313CC8A59E288FF082422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB818918BC313CC8A59E288FF082422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

All the concerns with the OEM version of this patch apply to this one
as well.

On Fri, Feb 02, 2024 at 06:44:32PM +0100, Sergio Palumbo wrote:
> Hello Russell,
> this is the pach for the vendor "ODI".
> Same hardware but different vendor.
> I explained it in the description.
> Hope this clarifies.
> 
> Thanks and regards
> 
> Sergio Palumbo
> 
> Il 28/01/2024 15:43, Russell King (Oracle) ha scritto:
> > Oh, a second repost. What's different from the first repost?
> > 
> > On Sun, Jan 28, 2024 at 03:23:06PM +0100, Sergio Palumbo wrote:
> > >       DFP-34X-2C2 is a GPON spf module working at both 1000baseX
> > >       and 2500baseX.
> > >       Setting the module to LAN_SDS_MODE=6 the module is working
> > >       at 2500baseX with auto negotiation see at
> > >       https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
> > >       Unfortunatly the module's PHY is accessible at 1000baseX only.
> > >       ethtool returning:
> > >       Supported ports: [ Fibre ]
> > >       Supported link modes: 1000baseX/Full
> > > 
> > >       After applying the quirk:
> > >       Supported ports: [ Fibre ]
> > >       Supported link modes: 1000baseX/Full
> > >                             2500baseX/Full
> > >       Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
> > >       Tested on sfp to ethernet Media Converter.
> > >       Autonegotiating 1000baseX or 2500baseX according to the
> > >       connected host speed.
> > > 
> > >       This module is existing in 2 versions:
> > >       Vendor = "ODI"
> > >       Vendor = "OEM"
> > >       This is the patch for vendor "ODI"
> > > 
> > >       Patch has been inserted keeping the list in alphabetical order
> > >       first by vendor first and then by part string.
> > > 
> > > Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
> > > ---
> > >   drivers/net/phy/sfp.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> > > index 3c0028a4af92..410375bc6b94 100644
> > > --- a/drivers/net/phy/sfp.c
> > > +++ b/drivers/net/phy/sfp.c
> > > @@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
> > >   	// 2500MBd NRZ in their EEPROM
> > >   	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
> > > +	// ODI DFP-34X-2C2 GPON ONU support 2500base-X
> > > +	SFP_QUIRK_M("ODI", "DFP-34X-2C2", sfp_quirk_2500basex),
> > > +
> > >   	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
> > >   	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

