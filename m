Return-Path: <linux-kernel+bounces-49794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DA846F78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C7D1F23919
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3613E215;
	Fri,  2 Feb 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aj0xf2f5"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC113D4F7;
	Fri,  2 Feb 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874744; cv=none; b=Y4wIAfRpFoGjzybxKWhssmDN19kwji4V3dM8G8mMuS0RgIrGy03lus/8KC9nSoTUMUB0tqC2LznZXaiA4IX7gYYqijfSol1iwN5o+XMQ5iCdHCJXWcQVKeBNupKRPVHgEzghvWqK5abawmtyKiPc01gtS+z6V8TQX9nxgKzCJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874744; c=relaxed/simple;
	bh=WWpj7IIOmpVjFPX3K3o71FGW0pD4t4+22/QypjCBsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1cT47qZDd2NSSvkDarK4mLCnpspKXCVsttG/l8rS3JpK0zGzGeCAxC57WnHJ2nERqzH/R+2lMZwc+fRRl94OtfJdJGXnsRA4/SlLqYR85p7r34SzFARRi/q5iuNuQtFpFbPha46c0gE2rSyTSfLGlFig+pDnuW6Lql07uQ57cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aj0xf2f5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bdMRNfuOlYWXCZSbX3qtLpZ6mLae9pQYUL0x6nsWQvA=; b=aj0xf2f5Jf2gkGwMowWngx4HiC
	veb5AYlQO/gjHSyzr2p8XpEQgkWsB0lsh3TM5rAP/Mpdht38o6EWIGmXnsUz/PqYitIR5wzPJAEbC
	toUWEczWTq0ZuJqe2A7aqJ3i16YHPbXjue1LuKpi5i+F4ob58eYNaoO1QzEsmJuFHu46xx3BVAHv6
	DmF9DdS6Pa26OxbI131SJYNL0nCcWks/SWrdJv4J5wFc3jtLYlk6bdwiR3LtHvG0gc8MiNaorp+n7
	/ehLDkav139ssUKFj79VIyRJwYmGjvVrVHM5mdAPsc4R7e6t9dMKIJU4m5Y2LKkJMHzL1E8GfQYET
	JG72R3CQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34052)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVs5d-0005vu-2u;
	Fri, 02 Feb 2024 11:52:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVs5b-0008IR-Tm; Fri, 02 Feb 2024 11:52:11 +0000
Date: Fri, 2 Feb 2024 11:52:11 +0000
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
Subject: Re: [PATCH net-next v3 7/7] net: dsa: mt7530: do not clear
 config->supported_interfaces
Message-ID: <ZbzXayWoRv37zFvp@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-7-63d5adae99ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202-for-netnext-mt7530-improvements-2-v3-7-63d5adae99ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 12:19:13PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> There's no need to clear the config->supported_interfaces bitmap before
> reporting the supported interfaces as all bits in the bitmap will already
> be initialized to zero when the phylink_config structure is allocated. The
> "config" pointer points to &dp->phylink_config, and "dp" is allocated by
> dsa_port_touch() with kzalloc(), so all its fields are filled with zeroes.
> 
> There's no code that would change the bitmap beforehand. Remove it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

