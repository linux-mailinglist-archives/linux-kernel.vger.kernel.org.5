Return-Path: <linux-kernel+bounces-112650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484E887C88
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A889E1C20AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B279D179AA;
	Sun, 24 Mar 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wpDcD+vY"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699246FB5;
	Sun, 24 Mar 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711280389; cv=none; b=qJ0rKQYL3BpxH/mKY2h7anNLd5qwU7um7pHjb3cTDHVhJEK5wYbmCbuTq2x0oRXZgZdiTCg9NtkfMBHPWZffx8v/x4N8gQy3XWimPbB7RLsxRw83ifaorjsXsUCnR3B++TC4sBXeaXhBUuSm/HzsmOyNroA3XZLjSr+wsSKzHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711280389; c=relaxed/simple;
	bh=3DAN+ZuR4BCK0R8mQkOH/01GQK1FQY2hVj9coW1xG4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksNQwmYojcfflDl1rOC2v0a6uKUfMwXMP1NHr7XivScvmCrokhPHhZ5A7K+o4Tgps5761R8uTEeAULnRhe1KN74lG/DRA1ptliWI0/aqsZtndJ2KFhl0zgSLMU18B19eJqZH6CDh8H3F4VrRrkhQQwZN53+6KaqRq567IniFEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wpDcD+vY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/pm71XqUg2Me/5kzVzyvAIWcLcizOGK383LNxU+r5/U=; b=wpDcD+vYSME5DYWATYlNDH/YEg
	/jTLStgE7PwCf0v4Whv7leAPkpSEkEs08V3YRE91IZ0qWmO7QOBStdHNfbEwxncMIqr4agFzSG94Z
	eC1i59HSLICUSu/PbGSGEnjt0s2ar/Upqey60Jd3DoTiAiIrbMNSBtEVRHEOAkXFEsGBvGZaVemYs
	9tb8rb+A2OBfdHY8c7uVIzCcQMLQorS6o26D9Dp67R48HrLs0Nf6ntIpYMENrpaELL/DW+qAcfWSr
	gyTYpakQ9VyLcSGyEoFS0wjOJ6Ja5eaXk9tf8zXSaPGi32wYs/rLH6VnAfGd+L75WSPgjlG7Fh7Lk
	dR4fLziA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59938)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1roMC7-0002Ei-1W;
	Sun, 24 Mar 2024 11:39:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1roMC0-0006UM-Tn; Sun, 24 Mar 2024 11:39:13 +0000
Date: Sun, 24 Mar 2024 11:39:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <ZgAQ4Ihsn6RCk7xx@shell.armlinux.org.uk>
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
 <Zfn1DxkEa3u-f7l2@makrotopia.org>
 <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
 <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
 <11b2a4d1-66d8-4bcf-b1a8-20a635b99cc4@gmail.com>
 <5a4c0436-cd78-419f-af14-9c4e0c0435e3@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a4c0436-cd78-419f-af14-9c4e0c0435e3@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 24, 2024 at 12:47:08PM +0300, Arınç ÜNAL wrote:
> On 21/03/2024 18:31, Florian Fainelli wrote:
> > On 3/21/24 09:09, Arınç ÜNAL wrote:
> > > I have started testing MT7531 with EEE enabled and immediately experienced
> > > frames that wouldn't egress the switch or improperly received on the link
> > > partner.
> > > 
> > > SoC MAC       <-EEE off-> MT7531 P6 MAC (acting as PHY)
> > > MT7531 P0 MAC <-EEE on -> MT7531 P0 PHY
> > > MT7531 P0 PHY <-EEE on -> Computer connected with twisted pair
> > 
> > OK, so this is intended to describe that the SoC's Ethernet MAC link to the integrated switch did not use EEE only the user-facing ports. That makes sense because it's all digital logic and you are not going to be seeing much power saving from having EEE enabled between the SoC's Ethernet MAC and CPU port of the switch, that said, however, I wonder if this has an impact on any form of flow control within the switch that is reacting to LPI and you need EEE to be enabled end-to-end?
> 
> I've tested pinging between my computers with EEE enabled interfaces. The
> behaviour is identical.
> 
> > 
> > > 
> > > I've tested pinging from the SoC's CPU. Packet capturing on the twisted
> > > pair computer showed very few frames were being received.
> > > 
> > > # ping 192.168.2.2
> > > PING 192.168.2.2 (192.168.2.2): 56 data bytes
> > > 64 bytes from 192.168.2.2: seq=36 ttl=64 time=0.486 ms
> > > ^C
> > > --- 192.168.2.2 ping statistics ---
> > > 64 packets transmitted, 1 packets received, 98% packet loss
> > > round-trip min/avg/max = 0.486/0.486/0.486 ms
> > > 
> > > It seems there's less loss when frames are passed more frequently.
> > 
> > That would point to an issue getting in and out of LPI, do you see these packet losses even with different LPI timeouts?
> 
> The NICs on my computers don't seem to allow changing the tx-lpi and
> tx-timer options.
> 
> Computer 1 (Intel I219-V, driver: e1000e):
> 
> $ sudo ethtool --set-eee eno1 tx-timer 15
> netlink error: Invalid argument
> 
> $ sudo ethtool --show-eee eno1
> EEE settings for eno1:
> 	EEE status: enabled - active
> 	Tx LPI: 17 (us)
> 	Supported EEE link modes:  100baseT/Full
> 	                           1000baseT/Full
> 	Advertised EEE link modes:  100baseT/Full
> 	                            1000baseT/Full
> 	Link partner advertised EEE link modes:  100baseT/Full
> 	                                         1000baseT/Full
> 
> Computer 2 (Realtek RTL8111H, driver: r8169):
> 
> $ sudo ethtool --set-eee eno1 tx-lpi on
> 
> $ sudo ethtool --show-eee eno1
> EEE settings for eno1:
> 	EEE status: enabled - active
> 	Tx LPI: disabled
> 	Supported EEE link modes:  100baseT/Full
> 	                           1000baseT/Full
> 	Advertised EEE link modes:  100baseT/Full
> 	                            1000baseT/Full
> 	Link partner advertised EEE link modes:  100baseT/Full
> 	                                         1000baseT/Full
> 
> I've tested with switch ports interfaces' tx-timer from 0 to 40, same
> tx-timer for both interfaces. Loss is still there.

EEE implementations tend to be a mess in the way drivers implement the
API, so one can't at the moment rely on what ethtool says about the
status. Sadly, this is what happens when driver authors are left to
their own ends. :(

> I suppose the MT7531 switch PHYs need calibration for EEE that is currently
> missing from the mediatek-ge driver.

EEE is quite simple from the software point of view. There is software
negotiation of the modules that EEE supports, and then there is are
one or more timers that affect the behaviour of EEE. The LPI timer is
"how long the link needs to be idle for before _this_ end signals that
it _can_ enter low power state". The link only enters low power state
when *both* ends of the link signal that they can enter low power
state.

What calibration would be necessary?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

