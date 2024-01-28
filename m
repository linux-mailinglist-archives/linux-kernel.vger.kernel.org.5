Return-Path: <linux-kernel+bounces-41652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774E83F5E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179291F21047
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032D820311;
	Sun, 28 Jan 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HluDOwDy"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AC24B2F;
	Sun, 28 Jan 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452747; cv=none; b=VttTkqJ4fJZ1PcgkKwIEMORD6Lr0UhvUFUAgw0GS3F21npce0cR+h+o2rqwD50RrmpBl8tBa10U/CJRZvLcpUSQasWgEjlDoFmSWyssnHBen7R7vBOpdwTWVJaqT8X+lzW5c0bTbF7cw0j1ZlcWVBjZK/ij7bR/0RaBC1w3xDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452747; c=relaxed/simple;
	bh=sV/0bpxeEL/BnlEZwiQ71DmUVVtyXCjgScFG4Hc36+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWS/rC9whZcZS/JyJj8qPiiRjWbnND38U/3pysmq0/bYcgYl761kPFZwuGonX4iFqY+M+SXUu4uUMGtaPtBCGEsjGmG+efT6l5u6UFd060XRDETf9GdVnU7FlE7BySn/gifjKIYDW+8rtHlizccyDCVfTsR/0qcpmzz8BH5Ju2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HluDOwDy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I6ACCzW+hTeTlC6/VsJEfVE51kt3bn3lOnBZatz2MfY=; b=HluDOwDynRcPVV+q5nbObZtpa0
	wo213oMK0Xig18pjoekaPd2i1EO1YqHdhpQ7Xw5os7VlLK/jk3C9f6JZVPTtnleJnIsqmyZC0vTuk
	NNXxNEroKb0EtFX4QXC1b8+zkM1MEagytzdOM1Aru39iKlRJ1h45jRkyHolv5d03qQ7asChTYrOCz
	otzJHzvFN116rdyf5Zn/v2vo+LgxcumeRYjycZuyjSmWyugS2QGg+XUqPYnQxFrHVSumt1spqrUjr
	Y/LRGniwhLSnRw7u008d/rFmRvKIgmIUEUbYKfyg4zV1qVlKUDy/tZ3Q+5qNuoaMFK9/Aaa16yBPo
	F4Z3hJ7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44260)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rU6J3-0007tF-3C;
	Sun, 28 Jan 2024 14:38:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rU6J0-0003hC-QL; Sun, 28 Jan 2024 14:38:42 +0000
Date: Sun, 28 Jan 2024 14:38:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP DFP-34X-2C2 is a GPON spf module working at both1000baseX and
 2500baseX. Setting the module to LAN_SDS_MODE=6 the module is working at
 2500baseX with auto negotiation see at
 https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/ Unfortunatly the module's
 PHY is accessible at 1000baseX only. ethtool returning: Supported ports:
 [Fibre ] Supported link modes: 1000baseX/Full
Message-ID: <ZbZm8jWM4pxR2tVm@shell.armlinux.org.uk>
References: <AS1PR03MB81897EB6C46BCC9514CB55C7827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB81897EB6C46BCC9514CB55C7827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Your subject line is way too long. Didn't look further because that
makes it difficult to read.

Please wait at least 24 hours for other review comments before
re-posting. Thanks.

On Sun, Jan 28, 2024 at 12:56:25PM +0100, Sergio Palumbo wrote:
>  After applying the quirk:
>  Supported ports: [ Fibre ]
>  Supported link modes: 1000baseX/Full
>                        2500baseX/Full
>  Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
>  Tested on sfp to ethernet Media Converter.
>  Autonegotiating 10001000baseX or 2500baseX according to the connected
>  host speed.
>  
>  This module is existing in 2 versions:
>  Vendor = "ODI"
>  Vendor = "OEM"
>  This is the patch for vendor "OEM"
>  
>  Patch has been inserted keeping the list in alphabetical order
>  first by vendor first and then by part string.
> 
> Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
> ---
>  drivers/net/phy/sfp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index f75c9eb3958e..260917488c77 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -502,6 +502,9 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
>  	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
>  
> +	// OEM FP-34X-2C2 GPON ONU support 2500base-X
> +	SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
> +
>  	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
>  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

