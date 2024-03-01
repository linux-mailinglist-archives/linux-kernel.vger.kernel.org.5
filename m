Return-Path: <linux-kernel+bounces-88586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC486E3C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86953B22EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AB3A8EB;
	Fri,  1 Mar 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tx+ZUBH7"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF93A8CD;
	Fri,  1 Mar 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304792; cv=none; b=BVwJdlKL6nIGHV3k0LuxRw7qkNLaWPH6BRPSIN9e9Hb/y0DeGCpL6W9Yu93cHwukEL+1YZYD34YYBIRb6jQc494qNu9hyJZFICAJp4TZRjZ32B2fhTIzEvuxPFwp9kjKe2AAcIqMfRpE4ac0SPagu1yDTUgiWaZnRFNE+MORmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304792; c=relaxed/simple;
	bh=0rqGQ/mRJgX9xBzI0NJWqEosNzR6bw1GqPDwNMKQOaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEwcUMhWKfGYXFeT8uQgpf1VrgWFUVw64p4xuiFl9nlvFC8bVy8jfObdUt3BT5yzncXrkdgH78aStohVKVBDtk1haW4haX02IVnzHjsUvCN3Yj4eSPOa7tVh9MwTLrCw1giBFdbPE1Gr70GTyDcgBi3TmxqQoHojX6mXpB/q5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tx+ZUBH7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AT6eJ8FbJZluUkWHSqnmRN5cAns9tdGhp7LuFi8TsNQ=; b=Tx+ZUBH7Yrwr3nkLWDaTULDEJ3
	ICj4TMORGivcz/D+6rFRv5mH5+pZsJVWjKSi5ZPeIcRFRHmYaLc+JzlCMZrOrlB3fjOJjUkhB8B/t
	4Ia2B54fKKGPXCUbg+S+KtQfXYxCVeqlX/u+C/XSSrbCyLCS8F5OVkEqqT8zK/qZPBLgAOQLg87ow
	Z+S536rHtuUMoKK/WlknGstZu/xZlOfdpLWHVhfVDFD3jBPasQ8BmYHdUadVSP1B/TivhV+g6F3bC
	QNpfCRso7XT9B6QB5nFN4fLMsNWefbIsWTMmgBgso9/EMjj+MJErx+ngaTpu/MLwKlKYrWUhLiDHk
	nGA4riYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51756)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rg4Fv-0001jG-2K;
	Fri, 01 Mar 2024 14:52:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rg4Fu-0001pG-Ac; Fri, 01 Mar 2024 14:52:58 +0000
Date: Fri, 1 Mar 2024 14:52:58 +0000
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
Subject: Re: [PATCH net-next v3 4/9] net: dsa: mt7530: get rid of useless
 error returns on phylink code path
Message-ID: <ZeHrykYQd1SWJIN/@shell.armlinux.org.uk>
References: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
 <20240301-for-netnext-mt7530-improvements-3-v3-4-449f4f166454@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-for-netnext-mt7530-improvements-3-v3-4-449f4f166454@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 01, 2024 at 12:43:00PM +0200, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Remove error returns on the cases where they are already handled with the
> function the mac_port_get_caps member in mt753x_table points to.
> 
> mt7531_mac_config() is also called from mt7531_cpu_port_config() outside of
> phylink but the port and interface modes are already handled there.
> 
> Change the functions and the mac_port_config function pointer to void now
> that there're no error returns anymore.
> 
> Remove mt753x_is_mac_port() that used to help the said error returns.
> 
> On mt7531_mac_config(), switch to if statements to simplify the code.
> 
> Remove internal phy cases from mt753x_phylink_mac_config(), there is no
> need to check the interface mode as that's already handled with the
> function the mac_port_get_caps member in mt753x_table points to.
> 
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

