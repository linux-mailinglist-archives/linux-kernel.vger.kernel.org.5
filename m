Return-Path: <linux-kernel+bounces-50291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3C84770D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBB1F233D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929114C5B1;
	Fri,  2 Feb 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ObLXNAjP"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5014C583;
	Fri,  2 Feb 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897164; cv=none; b=hNeKMDcs8m0I5YvlWD3R/FZmIPcbVJ1U7intaFYXt8Q09RdgcDg5WnI0gviODlthEON8dHmOdTQ9R6toKnM06dduzT8tLo7+gsgu8LBevXgyvlon3Tb30faTHWbFXgCwjddm/UdmvQfIXn9fTIRH2FBa6YOpt+RWveKiqLW1rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897164; c=relaxed/simple;
	bh=0+zBy9BxMtmgrUapuuE00XzrLUjsL9pi4V6VkVRtgQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXaG4UKtNVueO/ezoYbf9TniHFspnIhvoQInFK0mlQBtUkzMveXJnqoNFe8L9tl88KUMDyJNYvTh89a6VwzbRbqbUud4QVA1+0b1z/6ZbZL1snuPHwLFag0/TWMA/pBd7R8W0LQQvU9WrCylT0NK6ABRyrDsRxbNUyEjy4X5Qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ObLXNAjP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h2ATmObSzV4eeYzY6CoQyZq/5jRI5DOKZsLmwWQtw3M=; b=ObLXNAjPuveYNFk2FxXGhxn30h
	0eMSF4JCx6nTaY5ps/qixLTdCG9nttzdB4vmXGfi1dhc0Lm+mlwVLIWjISDlCqhO22LkaLGM8bRh/
	ZgYJoAqIqdCU+b140Zls+zIInP9AYeteqn0e438kukRymDf+y9BygXSO56Ns6K0YplJGZTdhFXtIC
	BS/gtnnwuIyYzoiBscjrIpTLWBj2/+4QkfR240j+qXMWhfZQ70gc8xr6EOfY1JO9UwgV5e8J0pJSu
	2qjd4ciq2AFp+ipZLyExm5XZlqn4LncSrUUE+8wnVh/el1JEDBepA1dxdRX4ycLyI1kQ/W8q0qDBu
	MhuO8W/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59614)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVxv3-0006Kg-2u;
	Fri, 02 Feb 2024 18:05:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVxuy-0008VK-P4; Fri, 02 Feb 2024 18:05:36 +0000
Date: Fri, 2 Feb 2024 18:05:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
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
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Message-ID: <Zb0u8NY0q6ay17j5@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
 <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
 <e3b4add6-425c-46ca-9da5-8713055fc422@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3b4add6-425c-46ca-9da5-8713055fc422@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 08:44:39PM +0300, Arınç ÜNAL wrote:
> On 2.02.2024 14:40, Russell King (Oracle) wrote:
> > While reviewing this change, but not related to it, I notice that this
> > function sets the TX delay based on the RGMII interface mode. This isn't
> > correct. I've explained why this is this many times in the past, but
> > essentially it comes down to the model:
> > 
> > 
> > phy-mode in NIC node	Network driver	PCB		PHY
> > rgmii			no delays	delays		no delays
> > rgmii-id		no delays	no delays	tx/rx delays
> > rgmii-txid		no delays	no delays	tx delays
> > rgmii-rxid		no delays	no delays	rx delays
> > 
> > Then we have rx-internal-delay-ps and tx-internal-delay-ps in the NIC
> > node which define the RGMII delays at the local end and similar
> > properties for the PHY node.
> > 
> > 
> > So, if we take the view that, when a switch is connected to a NIC in
> > RGMII mode, then the phy-mode specified delays still should not impact
> > the local NIC.
> > 
> > Now, for the switch, we specify the phy-mode in the port node as well.
> > Consider the case of a switch port connected to a RGMII PHY. This has
> > to operate in exactly the same way as a normal NIC - that is, the
> > RGMII delays at the port should be ignored as it's the responsibility
> > of a PHY.
> > 
> > The final scenario to examine is the case of a RGMII switch port
> > connected to a NIC. The NIC's phy-mode has no way to be communicated
> > to DSA or vice versa, so neither phy-mode can impact the other side
> > of the RGMII link, but should only place the link into RGMII mode.
> > Given everything I've said above, the only way to configure RGMII
> > delays is via the rx-internal-delay-ps and tx-internal-delay-ps
> > properties. So, DSA drivers should _not_ be configuring their ports
> > with RGMII delays based on the RGMII phy interface mode.
> > 
> > The above is my purely logically reasoned point of view on this
> > subject. Others may have other (to me completely illogical)
> > interpretations that can only lead to interoperability issues.
> 
> I will address this with the next patch series. Thank you for explaining it
> in detail.

This is a good time to point out not to rush with the next patch
series, as my email will _likely_ provoke some additional discussion
from Andrew and/or Vladimir. So please give it a few days (maybe
around the middle of next week) to give them time to consider my
email and respond.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

