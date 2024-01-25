Return-Path: <linux-kernel+bounces-39428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF583D103
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790061F24BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E571199BE;
	Thu, 25 Jan 2024 23:57:37 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53818C38;
	Thu, 25 Jan 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227056; cv=none; b=KKWPfYuLYtEj/0rvnSEVrqYHfF1WzujPQY8L8J9BsmAzF4qr7zPbiBjkSnPB88EKPDoMtv3CyPyr98ha+TrasUPw8tkDGoMzGRChykd16obPiER0sK2D4hXSsxvs4uvrEHu9xMKqTR2yoK6VGGHO67c9gLOJ0zkBj0zCXw8CYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227056; c=relaxed/simple;
	bh=HVwNsG4ex09BIiqCIlusj2ZhDSWkoJndoDRFh/vuS4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/qsBRoe31+4qgrRPXCNDhYpj7V7/NDt7DSpvupOQDv2e/vHKUHDYNXrleT0iAV8oL5XRs5VjJ120EoRgYdtGggWhepKmRTl3qoHtnxBgis8dEQMTyKCf3rPkyx/gIY/KaJBseRg7TJ8tdLOV9RW3W19wQh3AL8k7mx4+s7GmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rT9ax-0005RZ-26;
	Thu, 25 Jan 2024 23:57:19 +0000
Date: Thu, 25 Jan 2024 23:57:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Message-ID: <ZbL1VEcH3RgHZKsq@makrotopia.org>
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
 <accda24c-9f12-4cfe-b532-a9c60ec97fca@arinc9.com>
 <ZbKJv84vGXInRIo1@makrotopia.org>
 <99a038f3-18d2-44ca-8135-1faf7a37892a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a038f3-18d2-44ca-8135-1faf7a37892a@arinc9.com>

On Fri, Jan 26, 2024 at 01:44:57AM +0300, Arınç ÜNAL wrote:
> On 25.01.2024 19:18, Daniel Golle wrote:
> > On Thu, Jan 25, 2024 at 12:49:19PM +0300, Arınç ÜNAL wrote:
> > > On 24/01/2024 08:17, Daniel Golle wrote:
> > > > Setup PMCR port register for actual speed and duplex on internally
> > > > connected PHYs of the MT7988 built-in switch. This fixes links with
> > > > speeds other than 1000M.
> > > > 
> > > > Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > 
> > > Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > 
> > > I'm wondering why we manually set speed and duplex for these interface
> > > modes in the first place. I don't how it works for
> > > PHY_INTERFACE_MODE_INTERNAL but, at least for PHY_INTERFACE_MODE_TRGMII and
> > > 802.3z interfaces, phylink should already supply proper speed and duplex.
> > 
> > It's true that duplex should always be set to full-duplex already by
> > phylink. However, speed could be 2500MBit/s (2500Base-X) or 2000MBit/s
> > (?, TRGMII) and we yet need to program the PCR like if it was
> > 1000MBit/s.
> > 
> > Regarding the INTERNAL case: it was added by mistake. In case of
> > MT7988, all ports of the switch are connected via INTERNAL links,
> > however, the PHYs still need adjustment of the PCR register just like
> > on all other MT753x switches and the CPU port is setup elsewhere
> > anyway.
> 
> It's not necessarily PHYs needing adjustment of the port MAC control
> register.

It's not the PHYs which need adjustment but the MAC PMCR register which
does.

> After reset, speed, duplex mode, etc. will be determined by polling
> the PHY connected to the switch MAC.

Yes, but as it is a DSA driver we don't use **hardware** PHY polling
and keep that off. Instead, PHY interrupts or software PHY polling is
used to have Linux determine the link properties.
We're then forcing these properties on the MAC port of the switch.

> on the PMCR because we're also configuring switch MACs that are not
> connected to PHYs, meaning the switch cannot determine these properties by
> polling a PHY.

The switch **never** determines these properties itself when using the
DSA driver. It has a facility to do so, and yes, when accessing
Ethernet in U-Boot or when using the 'swconfig'-based driver then this
facility is used. But, I repeat, when using DSA we do not use hardware
PHY polling. We poll (or rather: react to interrupts) in software
instead.

> 
> From what I understand, this code block is for overriding the speed and
> duplex variables to make the operations on the PMCR below work. It seems
> that this is actually only useful for PHY_INTERFACE_MODE_2500BASEX.
> PHY_INTERFACE_MODE_TRGMII is given SPEED_1000 by
> drivers/net/phy/phylink.c:phylink_interface_max_speed().
> PHY_INTERFACE_MODE_2500BASEX is given SPEED_2500. Overriding the duplex
> variable looks unnecessary.
> 
> Your patch here doesn't affect CPU ports because MT7531 and MT7988 PMCRs

This patch does not intend to affect the CPU port. As I've already
said in my previous reply "[...] the CPU port is setup elsewhere
anyway."

Maybe it wasn't clear, but I meant that the CPU port settings are
intentionally unaffected by this patch.

It is intended to affect user ports which with phy-mode = "internal";
set in DTS -- here we **do** need to set PMCR according the external
link speed and duplex.


> are configured with cpu_port_config before mt753x_phylink_mac_link_up(),
> and PHY_INTERFACE_MODE_INTERNAL is not used for MT7530 which, for MT7530,
> PMCRs will be set only on mt753x_phylink_mac_link_up().
> 
> PMCR_FORCE_SPEED_1000 is set on cpu_port_config. If someone were to get rid
> of cpu_port_config because of its utter uselessness, PMCR_FORCE_SPEED_1000
> would not be set, causing the link between port 6 MAC and SoC MAC to break.
> 
> In conclusion, I will add "case SPEED_10000:" to the operations where the
> speed and EEE bits are set on my patch for getting rid of cpu_port_config.

PMCR needs to be set according to actual link speed for built-in TP
PHYs. This is true for all mt7530 variants including MT7988.

Maybe the confusion here is that on MT7988 we use 'internal' phy-mode
for both, the switch CPU port's link to mtk_eth_soc gmac0 as well as
the links to the 4 built-in 1GE switch PHYs.

The latter were affected by wrongly overriding speed and duplex in
case phy-mode is set to "internal", which should not have been put
there (by me) in first place.

Let's just remove it, ok?

