Return-Path: <linux-kernel+bounces-167913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA398BB0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC151C2108E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF11EB2C;
	Fri,  3 May 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bggbXbvK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AA155720;
	Fri,  3 May 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754159; cv=none; b=rDTZ457O2wbmcrlFQZCmBmuSxgoD0+UD/OukFlFDVkCmjecuBVYO+eekznI2j0qyEY3ISngjIUIsOfLV2kweUPiSPVpoYVaOt80ZtwH1qql6P3sM36KzXW31oGVRvmJaw8hjlQhX8+PWQOKuzOraTymnRMFZAVz8026JLYzuLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754159; c=relaxed/simple;
	bh=itHJG9tSNY08yPf01HomJqoPbcctZxmRW7AaqmrZ8No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrIYfTgh4xcCeo+tjRoA7/PocFlIB0dvJMChgRTrsLWIF7UXTCOfamrmmYUAbR16irSJOTu2v63vHR73Am5jdDmD30EafHazpgyOIeBS9bh9KovTXQ/uka7GWGiVUTSqJRE36OqoptMpi7RQIN7LOTHCrcBPAUqCXY+GIcGyym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bggbXbvK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso50899555e9.3;
        Fri, 03 May 2024 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714754156; x=1715358956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMSNs/yXkvcx2buPf2uUzDn+c44TugURiBV0aKinOek=;
        b=bggbXbvKbYrgZXbe86iBROqQ2gTeNqLqBFnBXP1TiYPZYZNiRAAZ6sMLg5luchOK58
         uDeuotN30Qqbwi6ABrcMXJFliDfiPVTmPO9WpiHnoJ7QXgAWTF3/eURDg1tZYpC8CHOq
         MnOtRln07BTyPntfudWcCWAvgTkPs/E3XzwKeSl3V81Dsw0tbTXi8xIXJv88dTrfLlWq
         NxDcSh5wr4FXsIA0wyTvglI0g0bKXunvKG1fchUOh0xe2eP8kmDpla8t9rbt6VEr4uFp
         gpaOK45kjC9B5jNQBb7ruIWqNgMVDEC6RiDxDqpnoeUkawbOTmDvgJ83xIRhPTRtJYfU
         wI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754156; x=1715358956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMSNs/yXkvcx2buPf2uUzDn+c44TugURiBV0aKinOek=;
        b=p8Bh9g1rxT+5q++/Lf5qgcYbp7scuF/Hlsit2pU/qJErA+Wf8/znO3L48ERc+B1PDL
         WTBctE9Of3l1ThaEUtH2kELHr612zAXfOxw7EFfBMPP7rnXD4uSoURCn23tvrQfEDstJ
         2dVRbTeaIDoEx9rzDjRdtDRzSoRbGmwztooaruBmZXag172EeIA7Vvo64wQCgd/P6YoJ
         jhTRdzva0Si25LNYY6LtPZhAEzqIBU5eW1a3CH8H7sMyJwwgr7XjMRGKXSs0bzATfSh0
         39Lmt4Cu6hV1PwAPzBZbURt+9eg1dkaR0f08g5TUcoSFHht7h/95+1dfno8Dk4TZrSeX
         buPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0+Eo1RWsqste/s+l0ctVkVZsA/eLUt1dKycqPcsYtwKDIYcdp0xnbXvlaYBISIS6DcUdHZAGNoK095YKH1RXHOhB/q2/hRWxai5hRfI5JzYo8VL+PO2jdBjtcXbLwLnJFtEykDNkCEx2q9TF24wXEObKclaPifz/sSMLkjbq/Lg==
X-Gm-Message-State: AOJu0YxvPc122Pp2dXx+aAh2JOKQ7xe13k6qcjom/LeQb9ERHCvzT/o3
	hi24bIYKHdh+SixCV5H2STjcpvWajPYiQHElerkkR9u3vmQTiCxO
X-Google-Smtp-Source: AGHT+IFuZ+tSv4X7tXLEHCB+C/syW8wazUNy3WGDNExXdDZdwQSk4MclkvHvKD0Ej058rFi4Phix7g==
X-Received: by 2002:a05:600c:3586:b0:41c:b44:f917 with SMTP id p6-20020a05600c358600b0041c0b44f917mr3396016wmq.22.1714754155667;
        Fri, 03 May 2024 09:35:55 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:e07c:3aba:545b:ac2f])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d59a3000000b0034def22f93csm4154175wrr.69.2024.05.03.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:35:55 -0700 (PDT)
Date: Fri, 3 May 2024 18:35:53 +0200
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
Message-ID: <ZjUSaVqkmt7+ihTA@eichest-laptop>
References: <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
 <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
 <ZjOYuP5ypnH8GJWd@eichest-laptop>
 <ZjOftdnoToSSsVJ1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjOftdnoToSSsVJ1@shell.armlinux.org.uk>

On Thu, May 02, 2024 at 03:14:13PM +0100, Russell King (Oracle) wrote:
> On Thu, May 02, 2024 at 03:44:24PM +0200, Stefan Eichenberger wrote:
> > Hi Russell,
> > 
> > Sorry for the late reply but I wanted to give you some update after
> > testing with the latest version of your patches on net-queue.
> 
> I've also been randomly distracted, and I've been meaning to ping you
> to test some of the updates.
> 
> http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> 
> The current set begins with:
> 
> "net: sfp-bus: constify link_modes to sfp_select_interface()" which is
> now in net-next, then the patches between and including:
> 
> "net: phylink: validate sfp_select_interface() returned interface" to
> "net: phylink: clean up phylink_resolve()"
> 
> That should get enough together for the PCS "neg" mode to be consistent
> with what the MAC driver sees.
> 
> The remaining bits that I still need to sort out is the contents of
> phylink_pcs_neg_mode() for the 802.3z mode with PHY, and also working
> out some way of handling the SGMII case where the PHY and PCS disagree
> (one only supporting inband the other not supporting inband.)
> 
> I'm not sure when I'll be able to get to that - things are getting
> fairly chaotic again, meaning I have again less time to spend on
> mainline... and I'd like to take some vacation time very soon (I really
> need some time off!)

No problem, I'm also quite busy at the moment and I have the workaround
to test the hardware, so it is nothing urgent for me.

> > I think I see the problem you are describing.
> > 
> > When the driver starts it will negotiate MLO_AN_PHY based on the
> > capabilities of the PHY and of the PCS. However when I switch to 1GBit/s
> > it should switch to MLO_AN_INBAND but this does not work. Here the
> > output of phylink:
> 
> I'm designing this to work the other way - inband being able to fall
> back to PHY (out of band) mode rather than PHY mode being able to fall
> forwards to inband mode.

I tested again with 89e0a87ef79db9f3ce879e9d977429ba89ca8229 and I think
in my setup the problem is that it doesn't fall back to PHY mode but
takes it as default mode. Here what happens when I have the mxl-gpy PHY
connected to a 1000 GBit/s port:
[    9.331179] mvpp2 f2000000.ethernet eth1: Using firmware node mac address 00:51:82:11:22:02
[   14.674836] mvpp2 f2000000.ethernet eth1: PHY f212a600.mdio-mii:11 doesn't supply possible interfaces
[   14.674853] mvpp2 f2000000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6,13-14
[   14.674864] mvpp2 f2000000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-6,13-14
[   14.674871] mvpp2 f2000000.ethernet eth1:  interface 9 (rgmii) rate match none supports 0-3,5-6,13-14
[   14.674877] mvpp2 f2000000.ethernet eth1:  interface 10 (rgmii-id) rate match none supports 0-3,5-6,13-14
[   14.674883] mvpp2 f2000000.ethernet eth1:  interface 11 (rgmii-rxid) rate match none supports 0-3,5-6,13-14
[   14.674889] mvpp2 f2000000.ethernet eth1:  interface 12 (rgmii-txid) rate match none supports 0-3,5-6,13-14
[   14.674895] mvpp2 f2000000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-6,13-14
[   14.674900] mvpp2 f2000000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6,13-14,47
[   14.674907] mvpp2 f2000000.ethernet eth1: PHY [f212a600.mdio-mii:11] driver [Maxlinear Ethernet GPY215C] (irq=POLL)
[   14.685444] mvpp2 f2000000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,0000606f advertising 00,00000000,00008000,0000606f
[   14.686635] mvpp2 f2000000.ethernet eth1: configuring for phy/2500base-x link mode
[   14.694263] mvpp2 f2000000.ethernet eth1: major config, requested phy/2500base-x
[   14.700402] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/2500base-x
[   14.700408] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=00,00000000,00000000,00000000 pause=00
[   14.702726] mvpp2 f2000000.ethernet eth1: phy link down 2500base-x/1Gbps/Full/none/off
[   17.768349] mvpp2 f2000000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/rx/tx
[   17.768370] mvpp2 f2000000.ethernet eth1: major config, requested phy/sgmii
[   17.774602] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband
[   17.782976] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/sgmii
[   17.784200] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00,00000000,00000000,00000000 pause=03
[   17.784278] mvpp2 f2000000.ethernet eth1: pcs link up
[   17.784485] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, active
[   17.784504] mvpp2 f2000000.ethernet eth1: enabling tx_lpi, timer 250us
[   17.784543] mvpp2 f2000000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx

It agrees on PHY mode when starting, which then sets MLO_AN_PHY.
However, when it sees a 1 GBit/s link it will just print the error
message "firmware wants phy mode, but PHY requires inband". After "Link
is Up" is shown the link will not work becuse of the missmatch between
the PCS and the PHY.
 
> > The problem is that the PCS continues to be in phy mode but the PHY
> > driver currently only supports LINK_INBAND_ENABLE and SGMII for 1GBit/s.
> > 
> > What I'm wondering is if it wouldn't make sense to adapt the phy driver
> > to support MLO_AN_PHY in SGMII/1000BASE-X mode.
> 
> PHYs have no idea about MLO_AN_xxx at all, neither should they. This
> is not part of phylib's API, and I don't think PHYs should ever know
> about MLO_AN_xxx stuff (which is something purely between phylink and
> the MAC driver.) The structure here is:
> 
>       MAC            PCS                   PHY
>        ^              ^                    ^ ^-----.
>        v              v                    v       |
>    MAC driver <-> PCS driver <-------> PHY driver  |
>        ^           ^                    ^          |
>        |           |                    |          |
>   MLO_AN_xxx  PHYLINK_PCS_NEG_xxx       |          |
>        `           '                    |          |
>         \         /                     v          |
>           phylink <----------------> phylib <------'
> 
> MLO_AN_xxx is far beyond the PHY, and more or less defines the overall
> "system" operating mode. PHYLINK_PCS_NEG_xxx defines the properties
> used for the PCS link to the next device towards the media. This is
> more of relevance to what the PHY should be using on its MAC-facing
> interface.

Okay this makes sense. I more thought about if the PHY e.g. would
signalise it can do inband/outband and the PCS can only do outband.
Basically exactly what you write in the last comment.

> > Currently the mxl-gpy phy driver can only support:
> > 10/100/1000 MBit/s: SGMII with MLO_AN_INBAND
> > 2500MBit/s          2500Base-X with MLO_AN_PHY
> > 
> > However, the PHY would also support the following mode:
> > 10/100/1000 MBit/s: SGMII with MLO_AN_PHY
> 
> The problem with this is some PHYs will not pass data _unless_ their
> SGMII control frame to the PCS has been acknowledged by the PCS - in
> other words, inband has to be used. However, that can be coped with,
> because such a PHY driver should be saying that it only supports
> LINK_INBAND_ENABLE in SGMII mode... and firmware must tell phylink
> that it wants to use inband mode (as that's exactly what firmware
> must do today in this situation.)
> 
> > I just don't know how the PHY driver could know about what it should
> > configure.
> 
> Currently, I haven't added an interface to cope with the case where
> a PHY says LINK_INBAND_ENABLE | LINK_INBAND_DISABLE to allow it to be
> configured in that case... that's something that will eventually be
> needed.

Thanks a lot for the work and help so far.

Regards,
Stefan

