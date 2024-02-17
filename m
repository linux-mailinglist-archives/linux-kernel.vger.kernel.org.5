Return-Path: <linux-kernel+bounces-69800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C6858EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E888C1C20EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586C2CCD6;
	Sat, 17 Feb 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tYWLhEQh"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449D2C6A4;
	Sat, 17 Feb 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165724; cv=none; b=LdzMbAJ7BPVKWCBdQiak2wJBFjW6nniFCg5dAk3Nhix8j8Edy09B/K2Rb/mtj9NGl5nL6l+Dz5GgHmFjOTqfYzr6UvlRqfNvm9M8RUW7q96WG8K+6Skb/NtLA3R4hCgWV1Nq8dI5aQ5ocoXtDGtw+HIJ5ntpzcLDglInKpT026g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165724; c=relaxed/simple;
	bh=sDT0IZg/T72E+ZZXyLdjzueUeralMw/ejE2pyoF2J1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvDKL/R60SGwPbTv0H2P+6MLtQl6QF5RG1L3fKZUGTMjb+02NzM52QWRlEevxYANQR3npiyMawk0oYzjYpYyLLTDMIImpJl978zwxAhTeH+dCMakk4z4+XZD2cnE341Kye4O/zcMEkTyg36WMfIoX9slMBJ1BH/HsPN2ZSpujDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tYWLhEQh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zW6/SWxGJHOFLV38kHr7ZjS0MYE8Rz8g0t7ofw+Cuo8=; b=tYWLhEQhTmPqy7/y0Sb//DKRCG
	PXCxOnCm00wXSxEHj8mpcRlVyUSIjbT4fp1GyW357yq3YM5ib91HHpY0qH6P21EQFoDllZphCzEVC
	013abUoqZ8VPLUBODiRsK1PSHCIpsEm1N0VkH1ahkdj1+5HljScGM6g2SqC2OcVaRs9hPuyNO/5H2
	Haxf/38GIBK5LL7aEGPdzLXszuyyF5H7bSGm2iR2+Aw2EgeGMb/BXL0Ct2146ikCAjW4UAiVBE20O
	lhmZ6lPNg3H6bMudelIGsl44Lg0YjgpAhjHrfdG2+wP/+yvmPqWQlMhR4hCtV9OW1fl/La4Kwipvj
	kmR56c2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbHvj-0007CE-1N;
	Sat, 17 Feb 2024 10:28:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbHvg-0006Ry-IO; Sat, 17 Feb 2024 10:28:20 +0000
Date: Sat, 17 Feb 2024 10:28:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZdCKRIJfRWkDCs/n@shell.armlinux.org.uk>
References: <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
 <AS1PR03MB8189ADFF1A475AE7DB281BE782532@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189ADFF1A475AE7DB281BE782532@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 17, 2024 at 11:13:14AM +0100, Sergio Palumbo wrote:
> [   15.459629] sfp sfp-1: module OEM              DFP-34X-2C2      rev      sn XPONxxxxxxxx     dc 230912
> [   15.469121] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 0000000,00000200,0000e440
> [   15.509967] sfp sfp-2: module                                   rev 1.0  sn 2307210038       dc 230721
> [   15.519434] mt7530-mdio mdio-bus:1f sfp2: requesting link mode inband/2500base-x with support 0000000,00000000,0000e440
> [   24.360320] mt7530-mdio mdio-bus:1f sfp2: configuring for inband/2500base-x link mode
> [   24.368145] mt7530-mdio mdio-bus:1f sfp2: major config 2500base-x
> [   24.374258] mt7530-mdio mdio-bus:1f sfp2: phylink_mac_config: mode=inband/2500base-x/Unknown/Unknown adv=0000000,00000000,0000e440 pause=04 link=0 an=1
> [   24.389679] br-lan: port 5(sfp2) entered blocking state
> [   24.394948] br-lan: port 5(sfp2) entered disabled state
> [   24.402405] device sfp2 entered promiscuous mode

This shows that the interface has been configured for 2500base-X.
However, there is no link report.

> A stated by you the system is still connecting at 2500base-X even if the
> module is set for 1000base-X, as far as I can see, without any error.

Right, because, as I've said many times, the kernel has *no* idea that
the module internals has been configured to operate at 1000base-X.

> My assumption that the module could have forced the speed down to
> 1000base-X was completely wrong.

Correct - considering that I wrote all this code, it is insulting to
have to go to this extent to get the point across.

So now that we have agreement that the kernel is trying to use
2500base-X, you now need to get off your high horse and accept that
it isn't working because there is _no_ _link_ with the module.

In other words, you need to accept that I'm right and you're wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

