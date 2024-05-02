Return-Path: <linux-kernel+bounces-166520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9B8B9BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722A11F23053
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021013C683;
	Thu,  2 May 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/YYtvnA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F64776E;
	Thu,  2 May 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657475; cv=none; b=RCxkVTd0F7+PnaqGuCpcLk8CMbLZ0kxXHLsxIEBZltusTUu9FMfnnnm4iKsBs8mqOQqTdc9hBDQVOf3XzO0Q/7J0pTYQPD1JSsxx9VRqNod01WsdDebdTVhKwCkezWh1ioMtbr49Jh437cJXA5ZgdsSbtaFr9fn/G2/C1cckMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657475; c=relaxed/simple;
	bh=ldH3WJcsESf+IeVXSZPfa0F6Q5cV/nHg5sdZhsY/6RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb4kOhaEheNzZmpCT7P/gAnVQL+Uu/oE5DmqI+ZcvCsNqFCJlKSaH7kMosTJm//bBZ1KVOeKzWK8ZBXu3ckC7IgMDlXOES3I07Fs0SJ9cVpjY7NW+/3XxF1fJgsk0xTWFZkiATgfcmrkbQLESRjBolfpZlJ+VIvr5R+IHd5F8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/YYtvnA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso50575771fa.2;
        Thu, 02 May 2024 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714657468; x=1715262268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6qUXt3zlW6cCbfBmwMpfDIfgzsK86qd6FFakHRLkL8=;
        b=K/YYtvnA9s92NErMg9I7bZY2kK47BCODamkIbfdu1atDhQZ8mHuf0BXDsCU1BtV98c
         0QH7dI6nRDfErCzwbqHG59KFLuyfz+oCCPxDjZHnR/GEjyocBhoLwWw4bT1Yf2n1kjxF
         TAK4oNsL85ykcm3nOOnalD8cQ60IDI1OQMCQiji+BkR9Nq15go2DXO3+Odpbhgb7J3/d
         Ur2NuUnhdr0c/NQznnYXsm1YST8lKLobysWRwWrEVcBe25c4fw+7zbedc4KVUABO1v+4
         NnoZUfmMrSf+2ZRveHT8vLJkhiSkPPHAIfBOMEAvgu2vjVy1LN8nPkUwKIo76qnaimc6
         cubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657468; x=1715262268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6qUXt3zlW6cCbfBmwMpfDIfgzsK86qd6FFakHRLkL8=;
        b=gPfq8Ymt46GgvPAXWj6AYOGe0H3Kp2Etf9Mmd8MjE3e9tr5pFEWSGM3gXYUn2uXCL/
         UHRIINoZ14lQ6ecprd1PCg/oveCiDL+yp7ka4O72OiieNPvjM2SYxFSLf774N7aJnlE6
         to7c/pi4s20D16cQXe0Cj2Ja3OXjWYtb+tzvkMP9/KO+OC6bUitmrXWXMrV44fFpy5lC
         /VSH57leCSQ4uZUDgvHkIvwN/XdeGMkbpgNUK87+WFeCCYFoQE2LpoR/ItTPFO19U9zc
         hZNhUHycg0xlOwYiuu3vsJujG04NP42pWwbzfWWcryV9cPt5nkF7h0kd1JSNKl8MDVrO
         al8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk57aUbZK1ICO46SK5qBG4ej3sP3LoLfAE5se8Tqz8fP2ubTWedSvdgdBIQj+yVm6r8uAfhsYYKUawwuSUBrYh4xo6c89MW+2Cd3g3EhOpnEsnwM/bHCvIzzsC4VdIdfdMhZIoUP9FM2MP78s5L/5B7O7ulCovytQy2L9Zd94cCw==
X-Gm-Message-State: AOJu0YzthpEnwY6W9USnPEHgReuJyvq8Rkm91KmbWameJw9G9BQQiElu
	gwCwOfgi1qZkjq5d0Vl8hpTR+on2U+F79adLl9Imk5Li1VYOAyk9
X-Google-Smtp-Source: AGHT+IGFhI8/w5ejZ9jTQbVXmDyN7iAUKunwbBjxuxJ7XmYsjWKB6I0OEt2VLv/C55qScf0fXK9TjA==
X-Received: by 2002:a2e:2a45:0:b0:2e1:f253:152a with SMTP id q66-20020a2e2a45000000b002e1f253152amr1159262ljq.51.1714657467002;
        Thu, 02 May 2024 06:44:27 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:826c:5550:a523:3b31])
        by smtp.gmail.com with ESMTPSA id m18-20020adfa3d2000000b0034dfede0071sm1319818wrb.46.2024.05.02.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:44:26 -0700 (PDT)
Date: Thu, 2 May 2024 15:44:24 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <ZjOYuP5ypnH8GJWd@eichest-laptop>
References: <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
 <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>

Hi Russell,

Sorry for the late reply but I wanted to give you some update after
testing with the latest version of your patches on net-queue.

On Thu, Apr 25, 2024 at 09:15:54PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 25, 2024 at 07:33:59PM +0200, Stefan Eichenberger wrote:
> > Now I got it, thanks a lot for the explanation. So the issue is that
> > MLO_AN_INBAND + PHYLINK_PCS_NEG_OUTBAND is happening in my use case and
> > therefore the link is not forced up because for that MLO_AN_PHY would be
> > needed. I will also try to think about it.
> 
> Now that I've moved the setting of PortType and InBandAutoNegMode into
> the pcs_config() method, I now have (on mvneta):
> 
> Value at address 0xf1036c00: 0x00008bfd	- PortType = 0
> 					  (SGMII, necessary to be able
> 					   to set InBandAnEn=0 below)
> 
> Value at address 0xf1036c08: 0x0000c018 - InBandAutoNegMode = 0
> 					  (1000Base-X mode)
> 
> Value at address 0xf1036c0c: 0x00009240	- 1000M, FD, unforced link
> 					  InBandAnEn = 0
> 
> Value at address 0xf1036c10: 0x0000600a - Sync, 1000M, FD, but no link
> 
> The reason that the link isn't being forced is because
> mvneta_mac_link_up() is being called with mode = MLO_AN_INBAND
> which expects the link to be controlled as a result of autoneg,
> but we've configured autoneg to be off.
> 
> I'm wondering whether we need pl->cur_link_an_mode to be the desired
> mode for selecting the result from phylink_pcs_neg_mode(), but also
> maintain a separate pl->act_link_an_mode which phylink_pcs_neg_mode()
> chooses, dependent on whether the PCS is using inband or outband
> mode - and pl->act_link_an_mode is what gets passed to the MAC layer.
> That would at least keep the MAC MLO_AN_* consistent with what the
> PCS layer is using - and also has the advantage that it makes it
> clear that pl->act_link_an_mode only gets updated in the "major
> config" path.
> 
> A quick test of that... seems to work:
> 
> mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Broadcom BCM84881] (irq=POLL)
> mvneta f1034000.ethernet eno2: phy: 2500base-x setting supported 00,00000000,00008000,0000206c advertising 00,00000000,00008000,0000206c
> mvneta f1034000.ethernet eno2: major config 2500base-x
> mvneta f1034000.ethernet eno2: link modes: pcs=02 phy=01
> mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000206c pause=04
> mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
> mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
> mvneta f1034000.ethernet eno2: phy link down 2500base-x/Unknown/Unknown/none/off
> mvneta f1034000.ethernet eno2: phy link up sgmii/1Gbps/Full/none/off
> mvneta f1034000.ethernet eno2: major config sgmii
> mvneta f1034000.ethernet eno2: link modes: pcs=03 phy=01
> mvneta f1034000.ethernet eno2: phylink_mac_config: mode=phy/sgmii/none adv=00,00000000,00008000,0000206c pause=00
> mvneta f1034000.ethernet eno2: pcs link down
> mvneta f1034000.ethernet eno2: pcs link down
> mvneta f1034000.ethernet eno2: can LPI, EEE enabled, active
> mvneta f1034000.ethernet eno2: enabling tx_lpi, timer 250us
> mvneta f1034000.ethernet eno2: Link is Up - 1Gbps/Full - flow control off
> 
> Value at address 0xf1036c00: 0x00008bfd
> Value at address 0xf1036c08: 0x0000c018
> Value at address 0xf1036c0c: 0x00009242
> Value at address 0xf1036c10: 0x0000600b
> 
> So we can see in the two phylink_mac_config calls that the mode has
> switched from "inband" to "phy" with this PHY (BCM84881) which
> doesn't support inband in any interface modes.
> 
> However, there's still the issue with:
> 
> link modes: pcs=02 phy=01
> phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000206c pause=04
> 
> and this is because of the missing code in this part:
> 
> 	/* PHY present, inband mode depends on the capabilities
> 	 * of both.
> 	 */
> 
> but there's also the issue that the PCS and PHY capabilities like that
> are incompatible. In this case, we're saved by the fact that if we do
> this act_link_an_mode thing:
> 
>         pl->act_link_an_mode = pl->cur_link_an_mode;
>         if (pl->pcs_neg_mode == PHYLINK_PCS_NEG_OUTBAND &&
>             pl->act_link_an_mode == MLO_AN_INBAND)
>                 pl->act_link_an_mode = MLO_AN_PHY;
> 
> coupled with the new _behaviour_ of mvneta/mvpp2, we don't actually
> end up in the "1000base-X must have AN enabled" trap... but that is
> no basis to basing decisions at the phylink layer on.
> 
> So, I'm wondering whether we need to be a little more creative here.
> Instead of simply passing a few bits, maybe something like:
> 
> 	31-24: bitfield of "partner" capabilities that are supported
> 		for inband enabled mode
> 	23-16: bitfield of "partner" capabilities that are supported
> 		for inband disabled mode
> 	15-8: bitfield of "partner" capabilities that are supported
> 		for outband mode
> 	2: bypass mode supported
> 	1: inband enabled mode supported
> 	0: inband disabled mode supported
> 
> Now, a question will come up... what is different between inband
> disabled and outband mode?
> 
> Consider 1000base-X fibre. 1000base-X is the media interface, and we
> need to be able to configure autoneg there, enabling or disabling it.
> If we don't support disabling autoneg (as is the case with mvneta
> et.al. over fibre) then being able to use ethtool to disable autoneg
> can't be used. In both these modes, the 1000base-X is the media side.
> 
> However, 1000base-X can be used to connect to a PHY, and the PHY
> could do rate matching, so the we need to use an outband way to
> access the media side (we need to talk to the PHY.)
> 
> Hence why PCS have a distinction between OUTBAND and INBAND_DISABLED.
> 
> Now, with 2500base-X we run into the problem that e.g. mvneta
> operating in 1000base-X mode upclocked to 2.5G can only support
> INBAND_ENABLED and not INBAND_DISABLED (we can't just turn off the
> InBandAnEn bit). The change between INBAND_ENABLED and INBAND_DISABLED
> can happen with the link up.
> 
> However, it can support OUTBAND by disabling the PortType bit and then
> turning off InBandAnEn (which can only be done with the link *down*
> and that is only guaranteed during a "major config" not through the
> ethtool settings API - which is why pcs_config() can't do this for 
> INBAND_DISABLED.)
> 
> So, a little bit of progress but not at a usable solution yet.
> 
> I'm afraid my current tree is in a hacky mess at the moment, I'll see
> about updating the published patches as soon as I can.

I think I see the problem you are describing.

When the driver starts it will negotiate MLO_AN_PHY based on the
capabilities of the PHY and of the PCS. However when I switch to 1GBit/s
it should switch to MLO_AN_INBAND but this does not work. Here the
output of phylink:
[   14.695170] mvpp2 f2000000.ethernet eth1: PHY [f212a600.mdio-mii:11] driver [Maxlinear Ethernet GPY215C] (irq=POLL)
[   14.706541] mvpp2 f2000000.ethernet eth1: phy: sgmii setting supported 00,00000000,00008000,0000606f advertising 00,00000000,00008000,0000606f
[   14.707770] mvpp2 f2000000.ethernet eth1: configuring for phy/sgmii link mode
[   14.716437] mvpp2 f2000000.ethernet eth1: major config, requested phy/sgmii
[   14.723260] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband
[   14.731623] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/sgmii
[   14.731630] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00,00000000,00000000,00000000 pause=00
[   14.733905] mvpp2 f2000000.ethernet eth1: phy link down sgmii/2.5Gbps/Full/none/rx/tx
[   18.825056] mvpp2 f2000000.ethernet eth1: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx
[   18.825083] mvpp2 f2000000.ethernet eth1: major config, requested phy/2500base-x
[   18.831331] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/2500base-x
[   18.832568] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=00,00000000,00000000,00000000 pause=03
[   18.832638] mvpp2 f2000000.ethernet eth1: pcs link up
[   18.832905] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, inactive
[   18.832936] mvpp2 f2000000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control rx/tx
[   60.808001] mvpp2 f2000000.ethernet eth1: phy link down 2500base-x/Unknown/Full/none/rx/tx
[   60.808038] mvpp2 f2000000.ethernet eth1: deactivating EEE, was inactive
[   60.808090] mvpp2 f2000000.ethernet eth1: pcs link down
[   60.809075] mvpp2 f2000000.ethernet eth1: Link is Down
[   62.857142] mvpp2 f2000000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/rx/tx
[   62.857163] mvpp2 f2000000.ethernet eth1: major config, requested phy/sgmii
[   62.863412] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband
[   62.871786] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/sgmii
[   62.872987] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00,00000000,00000000,00000000 pause=03
[   62.873059] mvpp2 f2000000.ethernet eth1: pcs link up
[   62.873362] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, active
[   62.873379] mvpp2 f2000000.ethernet eth1: enabling tx_lpi, timer 250us
[   62.873414] mvpp2 f2000000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx

The problem is that the PCS continues to be in phy mode but the PHY
driver currently only supports LINK_INBAND_ENABLE and SGMII for 1GBit/s.

What I'm wondering is if it wouldn't make sense to adapt the phy driver
to support MLO_AN_PHY in SGMII/1000BASE-X mode. However, I don't know
how I could do this because I can't get the information in the PHY
driver (I can't use phylink_autoneg_inband to querry if inband should be
enabled or disabled). I know we would still have the problem you
described above. However, it would allow us to configure the phy to what
phylink decided works best. Maybe this would also solve other issues
where e.g. the PCS is not as flexible as it is for mvpp2 and mvneta?

Currently the mxl-gpy phy driver can only support:
10/100/1000 MBit/s: SGMII with MLO_AN_INBAND
2500MBit/s          2500Base-X with MLO_AN_PHY

However, the PHY would also support the following mode:
10/100/1000 MBit/s: SGMII with MLO_AN_PHY

I just don't know how the PHY driver could know about what it should
configure.

Regards,
Stefan

