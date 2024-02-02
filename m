Return-Path: <linux-kernel+bounces-49780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E07846F47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41DD29612F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EE140788;
	Fri,  2 Feb 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jGp8goMJ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A01468FA;
	Fri,  2 Feb 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874045; cv=none; b=FBtODa/GTKOMqOdfT6UBWKOxDBcOWyOJDNBZ/tIpXnSEibdSTRak6+Q2ThWmcUGwCmlhskBQ5nw3xlSIM2phAacNsc6bLRrqSg5A+evFSgaqYNm2dAt6oBsOsD3RuCRBzxRrfTedymVU5JdmaNuGOoLHMbbrLhMs5pkYQ//3AYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874045; c=relaxed/simple;
	bh=THNcitwNvcPDGnnPmti91/QSPozPaK3v1G+mw5I964g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2H5RJ1SjgrqfcY2vp0Nf0Fh5YUNsQqVAqQRXUD2c2flezWtZvJqkX6vgivTJ4ch7ttEVxzQyKuctYplo+cjCfDQJDhWCBHXGfVYazC8B540OUNRH0mEgjfBcd7sgaadX79lqjvq6xs5uw2eeGEgnD+cuLIEsQBkoapN6HKnUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jGp8goMJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UslJPsc9OxqAKRDemcvqM9t/waIR2GXs7pcOUZ0/ORQ=; b=jGp8goMJO/MxQ0XCJBfcTUrVlZ
	xZigOzTQl82Q8t4B92czFeAdsOazhcWc0byV/RMFxvtxNPdRsd3Pd/98g/123aQIqSzg4BJd0zKA7
	6b9U2pyFIZBoaXbM0oZtq2p/jhjv81jjqAZsffVCIDl4f+Sy9SaVHMznBIgycpw28JXHyheJskcv2
	qTf7ClI1YPceYNXMX9UidY/M0X7H0n314C0JuZeE3P17Q47bP5/hXk2TB+Gw/GeVKdjTU3PhlOX1x
	E8Ttl6pFzqH+aFIBCh8R+VXlHO6FuMM7EuhKoVzYtIGVkrGrjIm3aPaWBTEwf2ZDGCO6265lnP52l
	6Qlaix/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46710)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVruE-0005tL-1l;
	Fri, 02 Feb 2024 11:40:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVru6-0008Hm-Un; Fri, 02 Feb 2024 11:40:18 +0000
Date: Fri, 2 Feb 2024 11:40:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Message-ID: <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 12:19:07PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> There're two code paths for setting up port 5:
> 
> mt7530_setup()
> -> mt7530_setup_port5()
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
> 
> On the first code path, priv->p5_intf_sel is either set to
> P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4 when mt7530_setup_port5() is run.
> 
> On the second code path, priv->p5_intf_sel is set to P5_INTF_SEL_GMAC5 when
> mt7530_setup_port5() is run.
> 
> Empty the default case which will never run but is needed nonetheless to
> handle all the remaining enumeration values.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

While reviewing this change, but not related to it, I notice that this
function sets the TX delay based on the RGMII interface mode. This isn't
correct. I've explained why this is this many times in the past, but
essentially it comes down to the model:


phy-mode in NIC node	Network driver	PCB		PHY
rgmii			no delays	delays		no delays
rgmii-id		no delays	no delays	tx/rx delays
rgmii-txid		no delays	no delays	tx delays
rgmii-rxid		no delays	no delays	rx delays

Then we have rx-internal-delay-ps and tx-internal-delay-ps in the NIC
node which define the RGMII delays at the local end and similar
properties for the PHY node.


So, if we take the view that, when a switch is connected to a NIC in
RGMII mode, then the phy-mode specified delays still should not impact
the local NIC.

Now, for the switch, we specify the phy-mode in the port node as well.
Consider the case of a switch port connected to a RGMII PHY. This has
to operate in exactly the same way as a normal NIC - that is, the
RGMII delays at the port should be ignored as it's the responsibility
of a PHY.

The final scenario to examine is the case of a RGMII switch port
connected to a NIC. The NIC's phy-mode has no way to be communicated
to DSA or vice versa, so neither phy-mode can impact the other side
of the RGMII link, but should only place the link into RGMII mode.
Given everything I've said above, the only way to configure RGMII
delays is via the rx-internal-delay-ps and tx-internal-delay-ps
properties. So, DSA drivers should _not_ be configuring their ports
with RGMII delays based on the RGMII phy interface mode.

The above is my purely logically reasoned point of view on this
subject. Others may have other (to me completely illogical)
interpretations that can only lead to interoperability issues.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

