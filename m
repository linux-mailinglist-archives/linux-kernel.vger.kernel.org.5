Return-Path: <linux-kernel+bounces-15438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C10822C03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636DEB22734
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81118EB6;
	Wed,  3 Jan 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1LwAzpg5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED818E39;
	Wed,  3 Jan 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qP4o6WoadvxoWxPxLI1uV5qkWBeO6DZ9IGfpq4QrUwM=; b=1LwAzpg5o164Q7dDM9h0kCLQRX
	ZhFvB8bNZsY3zVtUr7dvjrBjTSqUhd8wZ4s7pqfkeibfWzX3VFLCnCO8Ec4qwC66yYOro862n8TFs
	TDL87PYZmwdXOdrqCcOSkCUVkD4UQf2xQ7/zZDbdOejlH6DwOg52wqHAJc7CPzqYMtbeTKFgQocgu
	8Ocad2nSaAHjGXrShQiez8wRD3wGLAnEIZbayKMcr10ayRC47M29rxd8VJ4Qe+APZmx6jFAtAkFSH
	mXFCi3bwVL1PxZvInDR8mwawQy2e4u+143EjF2aEQef1ElZX4W0d9MZQmzxO77hFOq8IyAh+LDXH3
	YrfzIrEw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46830)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKzI6-0007NQ-0R;
	Wed, 03 Jan 2024 11:20:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKzI6-0006Ji-05; Wed, 03 Jan 2024 11:20:06 +0000
Date: Wed, 3 Jan 2024 11:20:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Woudstra <ericwouds@gmail.com>, Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix
 mtk_pcs_lynxi_get_state() for 2500base-x
Message-ID: <ZZVC5ThEmikwiVfM@shell.armlinux.org.uk>
References: <20240102074408.1049203-1-ericwouds@gmail.com>
 <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
 <92190426-3614-4774-9E9F-18F121622788@gmail.com>
 <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com>
 <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
 <6666EB36-984E-4898-A41A-2D9713DE4DB0@gmail.com>
 <ZZSX_oNUIQr6R9FU@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZSX_oNUIQr6R9FU@pidgin.makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 12:10:54AM +0100, Daniel Golle wrote:
> On Tue, Jan 02, 2024 at 11:13:58PM +0100, Eric Woudstra wrote:
> > I believe the general idea is that phylink should be aware wether to use inband or outband negotiation in order to setup the hardware correctly. Speaking of a situation where there is a PHY attached.
> 
> Well, SGMII speed/duplex AN is not defined for 2500Base-X by any
> standard and not supported by the hardware (unlike e.g. RealTek
> which came up with their own proprietary extension called HiSGMII).

I give up trying to work out whether people are abusing the SGMII term
or not. SGMII *IS NOT ANY* BASE-X.

SGMII is Cisco SGMII, defined to operate at 10, 100 and 1000M speeds
over a single serdes lane operating at 1.25GBaud.

2500Base-X was many proprietary standards (called by many different
names like HiSGMII, HS-SGMII, 2500base-X etc) that eventually got IEEE
acceptance in one form as 2500base-X.

``PHY_INTERFACE_MODE_2500BASEX``
    This defines a variant of 1000BASE-X which is clocked 2.5 times as fast
    as the 802.3 standard, giving a fixed bit rate of 3.125Gbaud.

Note: not "SGMII upclocked by 2.5 times".

We do have devices that _do_ use 802.3z (NOT SGMII) negotiation over
2500base-X - not for speed or duplex, but for the pause modes, and
we have devices where it is specified that when operating in BASE-X
mode, inband AN *must* be enabled - which means upclocking 1000base-X
to 2500base-X requires inband AN for these devices.

Simply hacking PCS to do whatever they care for 2500BASE-X is not
acceptable. We need a *proper* solution to this, and we need to stop
fart arsing about over this, and we need to stop fart arsing around
calling things stuff that they are not, perpetuating the confusion
in the wider industry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

