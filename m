Return-Path: <linux-kernel+bounces-162010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C88B54A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964EE1F222B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E12C197;
	Mon, 29 Apr 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p5EYPf74"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B328DB7;
	Mon, 29 Apr 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384768; cv=none; b=EnhyFwaSfrhHw/U2nHCv3axMM4jxYC5WfSbrysYlJzhKY1Fngp7TTYgXLwrc9ViWOpgY8IybVMHhz6V3ImPWjcYWUM7LsvWSNBYkgJsPZ8m9GUJ8Dai/Q7h6H4IOweXtVSCIw280FmvE9QyR9o+RYU+cPbqagqAteEPRQQ7GOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384768; c=relaxed/simple;
	bh=Bg5LgVVCLyCGDSs7jt8knuEqjx+2qSWUIhIO0QMZ4jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1MKHX0XRXlVA5SGIa3u4/Vfsz2Am/JlkSYbbq3gh2fK7td4QcMUi1uig7eDb6rLFVMDXICevxXZiSC9b7tRzUFRmp9L+u6Mn4YmKLoqi1/g+SlMeduZ2VZEdsBj1CtBzzy3WW6doFBiMpVzksihm7BMeFaDgRa4mIUNxfkOspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p5EYPf74; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QE951D5l0qilZ1o07jWbnkqCMRoquuXb8OIu85XME+o=; b=p5EYPf74YgHv7kaeBx9L4VBEF+
	U2XaPUgsI9DOvLi94YdpzE0PrgDBkECABKoxA5Me/SCplKBpJ6C9B5vznmACi4V5DbWG14ny4IoCa
	nrZs9qPBV004sFNc4N5TjhtGghTiIlrOLevPRWVpKxdg3bpmmtKMxxb30ba/Yxngda0V9OEQh+CoT
	i6mKk8in0zO/IrMBo9sFkRwpyg+2QPcPwXt+q8ZHd41ee8eFR7lyDSFFGRUz68m7OVJDnfLXmv6VY
	/x6m257IwvUwIgdKIcuaf77m07ujtdz3F2UUhvn73lRL5tvS6eXJKDxihnAYJcutNA05ctShVOnie
	e6ZMjGOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38050)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1Nmn-0002wf-2K;
	Mon, 29 Apr 2024 10:59:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1Nmi-0000kp-VR; Mon, 29 Apr 2024 10:58:57 +0100
Date: Mon, 29 Apr 2024 10:58:56 +0100
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
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: detect PHY muxing when PHY is
 defined on switch MDIO bus
Message-ID: <Zi9vYLwgekd0Pmzn@shell.armlinux.org.uk>
References: <20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v1-1-1f775983e155@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v1-1-1f775983e155@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 29, 2024 at 12:46:43PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
> direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
> bus the switch listens on. The PHY muxing feature makes use of this.
> 
> This is problematic as the PHY may be probed before the switch is
> initialised, in which case attaching the PHY will fail.
> 
> Since commit 91374ba537bd ("net: dsa: mt7530: support OF-based registration
> of switch MDIO bus"), we can describe the switch PHYs on the MDIO bus of
> the switch on the device tree. Extend the check to detect PHY muxing when
> the PHY is defined on the MDIO bus of the switch on the device tree.
> 
> When the PHY is described this way, the switch will be initialised first,
> then the switch MDIO bus will be registered. Only after these steps, the
> PHY will be probed.

Looking at the commit description and the patch, I'm not sure whether
you really mean "probed" or whether you mean "attached".

PHY drivers will bind to PHY devices when they are detected on the MDIO
bus (either by scanning or instantiating firmware description) and the
devices are registered. As each device is registered, the drivers for
the bus type are scanned and any matches will have their probe function
called. This happens outside of any control of the DSA driver if the
DSA device is on the same MDIO bus.

This is separate from the process of looking up a PHY and attaching the
PHY.

So, I think there is probably a terminology issue with the patch
description. I suspect you don't mean "probing" as in phy_probe() being
called. Looking at the code, it looks like the driver is making
decisions based on how PHYs are connected to the ethernet MACs in the
device tree, and you're making decisions based on that. I wouldn't call
that "probing" a PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

