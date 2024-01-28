Return-Path: <linux-kernel+bounces-41657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8B83F5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61792841E3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81123748;
	Sun, 28 Jan 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wJantIl5"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019E1F945;
	Sun, 28 Jan 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706453013; cv=none; b=jbrdoNsZNWqzct4wLDsJHhPDPXS+q2pfwMTICiebVr2TcDkZ6DT7YgbL05GXnp4rJMKHQBVm64fhMZuYMAMOpZPidKOHPu/P0FLhPlX6DYiSkcre55NHqdJSEcpawSU4DfqWcCitilhURZeUNEC/C4naGEuuhx4f9UTafVSogOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706453013; c=relaxed/simple;
	bh=+xjFfqDulSs1wGep8xJY/QGUORdPxl+vbGCgXgcsiBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVmJe2JHhYhE6HDollP8i9azGGuBbUydqsQdSFpkhydMVMBpvz+UDMO6R3OaXZWFWi2vM0Iwaaeguqn+t8ueifsN6RpiMM2iCLhxeWltl5d7uSLEjKojxicTV1/zhyjFT+Z0fuucevPnuz4kCxcj6MWo2jFKDyxSmdj/yp93n3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wJantIl5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gkEf+vrMzqJaJuEK/A+kR0aXQ1S0zUGd9Qk76t4n0j8=; b=wJantIl5dpdzsGf5H9dGi0UkPU
	HdVFAaAMDFXpd6OnQ5OSJCBIKgj+S6Z9aY4bsCrn2csKe0jfT3o5ABImoW2YECXRgIjHgcwSJ57/O
	RcxPsTrP76rJGFlhC86jtxEjSf4LWnHZj7EFemR+69YZDsShl6V+poswx4MSFGf5fd41RPpyVMNd+
	btklV1idJHCz36h199AwVSjArUm3OPSo7DSLVjvsezG2V2YmJBpuue/oQ9h44J+yiMqx+0RnY6oq4
	RyYeYbxW1YAowUrHInQ+WnJkF3ZL74BqCSDD7K1xWwicRvuzWd0G33fhGZfaehb+pNvwI+dtPlh9b
	8khhL/eA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59352)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rU6NZ-0007tg-2J;
	Sun, 28 Jan 2024 14:43:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rU6NY-0003iF-AK; Sun, 28 Jan 2024 14:43:24 +0000
Date: Sun, 28 Jan 2024 14:43:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for ODI DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZbZoDIPR3O/iei5z@shell.armlinux.org.uk>
References: <AS1PR03MB81893D69344708C98EE2B470827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB81893D69344708C98EE2B470827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Oh, a second repost. What's different from the first repost?

On Sun, Jan 28, 2024 at 03:23:06PM +0100, Sergio Palumbo wrote:
>      DFP-34X-2C2 is a GPON spf module working at both 1000baseX
>      and 2500baseX.
>      Setting the module to LAN_SDS_MODE=6 the module is working
>      at 2500baseX with auto negotiation see at
>      https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
>      Unfortunatly the module's PHY is accessible at 1000baseX only.
>      ethtool returning:
>      Supported ports: [ Fibre ]
>      Supported link modes: 1000baseX/Full
> 
>      After applying the quirk:
>      Supported ports: [ Fibre ]
>      Supported link modes: 1000baseX/Full
>                            2500baseX/Full
>      Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
>      Tested on sfp to ethernet Media Converter.
>      Autonegotiating 1000baseX or 2500baseX according to the
>      connected host speed.
> 
>      This module is existing in 2 versions:
>      Vendor = "ODI"
>      Vendor = "OEM"
>      This is the patch for vendor "ODI"
> 
>      Patch has been inserted keeping the list in alphabetical order
>      first by vendor first and then by part string.
> 
> Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
> ---
>  drivers/net/phy/sfp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 3c0028a4af92..410375bc6b94 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	// 2500MBd NRZ in their EEPROM
>  	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
>  
> +	// ODI DFP-34X-2C2 GPON ONU support 2500base-X
> +	SFP_QUIRK_M("ODI", "DFP-34X-2C2", sfp_quirk_2500basex),
> +
>  	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
>  
>  	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

