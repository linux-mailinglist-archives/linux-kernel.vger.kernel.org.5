Return-Path: <linux-kernel+bounces-88584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D686E3BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0DB1F254FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412013A1DD;
	Fri,  1 Mar 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tUADbGwv"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF63987D;
	Fri,  1 Mar 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304604; cv=none; b=iVc/ytKW9p5rTr2wXrEsRBhF5C1KtmWXXHUTvWmPJ/V3IzUxoxYMnym/zNaFFX4TB/bHO4IoMHX2P8T5lHC9j7+fmjhBmDuQJd4ggn1gzanYSrvuQ2XKiq15a2MnklBTFRH0XS68twIyDKkzNT6xzlxIm9ZktzfKsGZ4djrYNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304604; c=relaxed/simple;
	bh=PDHQCj4dKUL8VGBu7R8FZ4rplBEM7DCMytyrNrWGZ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLRvMxKTviw1P/+9mz9E8Bb197crJhihjS53rW1ry+etNeWzIb51quy7bcyfVau2rrkzQlDFih1nM8heNo9WfeXxx5t7S6cKUkiFr6Tj96OwwO5AWGEJHpjSQzgqcOSChU7wk+grGCyj9Chotpr9G3vfh22LaFravvcZBw2g17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tUADbGwv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yYU2P/XionBukymtyfAivEvDMyJYX93BV07iZlCfOYE=; b=tUADbGwvT+bsqxHHRHjijlFIck
	/MxOPOG46qCY9h2+BenQw2uzIhrLdYBDgLxjbu8yWYH7flCOABA55iFsEg9N7dxj1gxDw59UDU9r8
	tpqrWyKZV+yEY4ka3CG07cwSmMkGzDPsTgzkpHKtgWR+Y8lFiTbSGPB0p7OpjA9uwLcjTIUElDlks
	ja7yEhTbbw+CbXM14OppCextPo810gFu2NaEQ4z/wCi/q2sXlu6fcoA+6HJjhcx78eVS5akivlXgA
	zxJ8PntBaP2UA2YMn5sWKulvyHNYylCYIl7lcOiwUkvMT+PrbAOxz2jt8n+ke4U0TaQWDMmgriaer
	3WJOsdqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rg4Cj-0001iq-1A;
	Fri, 01 Mar 2024 14:49:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rg4Cc-0001p9-1m; Fri, 01 Mar 2024 14:49:34 +0000
Date: Fri, 1 Mar 2024 14:49:33 +0000
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
Subject: Re: [PATCH net-next v3 1/9] net: dsa: mt7530: remove
 .mac_port_config for MT7988 and make it optional
Message-ID: <ZeHq/ZoVqMD9BojD@shell.armlinux.org.uk>
References: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
 <20240301-for-netnext-mt7530-improvements-3-v3-1-449f4f166454@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-for-netnext-mt7530-improvements-3-v3-1-449f4f166454@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 01, 2024 at 12:42:57PM +0200, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> For the switch on the MT7988 SoC, the mac_port_config member for ID_MT7988
> in mt753x_table is not needed as the interfaces of all MACs are already
> handled on mt7988_mac_port_get_caps().
> 
> Therefore, remove the mac_port_config member from ID_MT7988 in
> mt753x_table. Before calling priv->info->mac_port_config(), if there's no
> mac_port_config member in mt753x_table, exit mt753x_mac_config()
> successfully.
> 
> Remove calling priv->info->mac_port_config() from the sanity check as the
> sanity check requires a pointer to a mac_port_config function to be
> non-NULL. This will fail for MT7988 as mac_port_config won't be a member of
> its info table.
> 
> Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

