Return-Path: <linux-kernel+bounces-68899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9448581A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4E3B2552B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418612F5AA;
	Fri, 16 Feb 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i8bUIEw0"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDC12BF03;
	Fri, 16 Feb 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098243; cv=none; b=UEJFavedJKlCOV/KoVMxWhVei+UO0qJs0lbk67mxHfeLVFgHXmsZ6IcZI9kMXgLHEyPbZs2YtuRKTfm1Rj4P0vhC0XaKCQ+EzjkKbCoWrxBztp0fZJ4aoax5S3y6BNWZkI1toE1u3LYrGqASDkGVSCCgp++KiuhjzNoAKQb9ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098243; c=relaxed/simple;
	bh=F+QVlPQi+jHUwVgrFftfh61LcSMs2H+6H2+hUGJpckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nii9mnHDBzZNZxojhiYLB5CnB5oBgNhnkcLv3B5jyBwepOkM5zh+QJmLRttS71b6AfOn5n/yigvRziP9mJi3SR8KIO0HnDot7+6NgwQBYgo5gYPWZJ19LCqkNyPfsVTk32Qyi6JkD2FRqpa1yHG70Amg9s6ACs0vxpk7vC/GyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i8bUIEw0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mW8V17MsmL7VEwiMKsJzk5HQ8Z5PWc1CNNBk+B48w+A=; b=i8bUIEw0N70QsZY2kDWJw1w4Tm
	6gzsJwmiUQN3C2NpHmyiXWkKt28KIwMPjgnx/9xrlHwCJES6JRmoQUaZD5nEIt36e+f5uo8g2HT+h
	H9kX4R3NSAGfSw30WE6TPGAnrQuOP6x4LSxQDqyzuQe/C0mnUkingYlhy9lGC5TMIaGaD2na7FwjS
	jjbeVQl9EJEasTrVJfdyFYsvW/WjFuOOD99gweBMdJUso+9N2a2jpUlnRvn9qyRUxdAgWkkNNnr6j
	B5GhiKYPFc28873AR+zyIPUs5iEmpUBKFzjpvnOEVolxujCmlSijC2qYYPmuU0ewkbcaE518+DQ5N
	r7G6PVoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rb0NH-0005ns-1X;
	Fri, 16 Feb 2024 15:43:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rb0N8-0005jP-NS; Fri, 16 Feb 2024 15:43:30 +0000
Date: Fri, 16 Feb 2024 15:43:30 +0000
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
Subject: Re: [PATCH netnext 8/8] net: dsa: mt7530: simplify link operations
 and force link down on all ports
Message-ID: <Zc+ConfebmQdpCOF@shell.armlinux.org.uk>
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
 <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 08, 2024 at 08:51:36AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, the link operations for switch MACs are scattered across
> port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
> phylink_mac_link_down.
> 
> port_enable and port_disable clears the link settings. Move that to
> mt7530_setup() and mt7531_setup_common() which set up the switches. This
> way, the link settings are cleared on all ports at setup, and then only
> once with phylink_mac_link_down() when a link goes down.
> 
> Enable force mode at setup to apply the force part of the link settings.
> This ensures that only active ports will have their link up.

I think we may have a different interpretation of what phylink's
mac_link_down() and mac_link_up() are supposed to be doing here.
Of course, you have read the documentation of these methods so are
fully aware of what they're supposed to do. So you are aware that
when inband mode is being used, forcing the link down may be
counter-productive depending on how the hardware works.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

