Return-Path: <linux-kernel+bounces-49782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60A846F55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7D81C22413
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62713DBA8;
	Fri,  2 Feb 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pnwl8EWW"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5C168AB;
	Fri,  2 Feb 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874357; cv=none; b=X0TQlqCAwlY2DyjGa1PLFVThuf1VwF4ZS51KQ0RY8UoYzcuyyNnVwcIIMTmINqZbBs0YLyGK7zBKG6J8bFxORp6DgMkbsY6AjfI++T7bTLi1WJuwhqWTdCQP9U2iyznb4Gay1er7MVK/ItyShqaBiMZM69oHZrilI6h36T9nWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874357; c=relaxed/simple;
	bh=g2szF7J/Fir+UwcF5d5yrjX6PLRvsscIcyAHZXVyz3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObXkPjtDUhx+rlHxOusvQmon9aEE/Z3GwWdr0F2gHudhVvOksT8UOUo/kdh4x7e9pa/e4E97G7Flrk0fB5oGYIWaPyr+cwMpINjCn9slHNZzZ7SYWYrDTuEkpHcFA/zAhekdJyXBMhHWc9t8rawnW7VzWFJpIGRxxYN0v6JNYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pnwl8EWW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NMzyKXLvD5bCWLAnSG7LQUc76KmbvEK7xMGWqLkAp84=; b=pnwl8EWWJP/EPh7oo8FzwwNZnV
	eNLhuPMQ8WmVsruBxONkcOgm51ooQq6kt45NBEt6yUTqPxMTsq6L6uzcYrnmK8VejdcyK9Q455ojJ
	0uKdTi5/RuNOyShPkwARm1u5fz8kEQH+LOXXz8XM5Z6+BIDiI3dRE/vwpe8sQgC3tuRCGmvDn4oJG
	LKjp4GbvbwHqhCSV2iYUiUxg7A7zexwby7NHHdYu1wnOkn1nOj+pzsYuoR/PDLk++f/YXo8g6ae6I
	24CTDvu62YfX7ZS5loprhXgCANYrEItsU9ghPg5YMxjdgVCGtfxsMaoyNuJZ8QOdSh5exi/vcOqFd
	kisPK1Mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46388)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVrzM-0005tt-0k;
	Fri, 02 Feb 2024 11:45:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVrzJ-0008Hw-2O; Fri, 02 Feb 2024 11:45:41 +0000
Date: Fri, 2 Feb 2024 11:45:40 +0000
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
Subject: Re: [PATCH net-next v3 2/7] net: dsa: mt7530: call port 6 setup from
 mt7530_mac_config()
Message-ID: <ZbzV5Ly9rv6IsmVl@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-2-63d5adae99ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202-for-netnext-mt7530-improvements-2-v3-2-63d5adae99ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 12:19:08PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> mt7530_pad_clk_setup() is called if port 6 is enabled. It used to do more
> things than setting up port 6. That part was moved to more appropriate
> locations, mt7530_setup() and mt7530_pll_setup().
> 
> Now that all it does is set up port 6, rename it to mt7530_setup_port6(),
> and move it to a more appropriate location, under mt7530_mac_config().
> 
> Leave an empty mt7530_pad_clk_setup() to satisfy the pad_setup function
> pointer.
> 
> This is the code path for setting up the ports before:
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
> -> mt753x_pad_setup()
>    -> mt7530_pad_clk_setup()
> 
> This is after:
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
>       -> mt7530_setup_port6()
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I hope that the "default" case in mt7530_setup_port6() is effectively
unreachable - as long as mt7530_mac_port_get_caps() is paired with this
and only sets the interface modes in supported_interfaces that
mt7530_setup_port6() handles, then that will be fine.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

