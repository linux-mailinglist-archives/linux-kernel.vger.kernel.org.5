Return-Path: <linux-kernel+bounces-109417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CB8818D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6B1F22140
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631E8593E;
	Wed, 20 Mar 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jQptVRca"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F784481C0;
	Wed, 20 Mar 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968056; cv=none; b=P6n029BXkgQiO3QcoOz/wGV14iBk97/S7H+x2YG2zHR5bkmD0j5uByoREhKNStmomtPSIMffNTIpeD6w2yQH1pyc9DPQxGVK6DonvnwqBW1VrgrzlCjtoxiPUlg7pKe6PNw8TCYZR/2clUj2kECwTq+ZsVYbKew2oxzIi7nhDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968056; c=relaxed/simple;
	bh=pF/xOd23yYrYMplKbbxbwQmPeh9HgaZeB0PVlGdg90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt+LPd0RvwTOhWXg1HiYAW54x6PHqikqsKfRckHRw8EPMtvUyKtIBAuTHxG0mQoDAWckvPEX+z6UcqGMyzIgDJcglu2ARcMPokJOtf6AarkhGJD7bO146/z3c+5rQ4HHYQOT9LyKJJhZC7fhl2TD9w89wBafmRGEPfutdXhBmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jQptVRca; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m3hah0VF3NuI3zxNyk+AIvcTPzt/CGCx8sXbYOztIEc=; b=jQptVRcaF1M/OvF8SdX5NTowuO
	dpufXaBGQkvFQQB8JCvtzPsaXmwTLiKNVCH8bdDvzjeFmUcGL3iDaG3U2O0wAMtlxxECD1jWS260Z
	0ECiVcRX/NaNtrxetJ5rQX59JtTUeJqpagHqsGp2MELPl7CwRfmlX354xeYzCMPbz72Qt9MsCjKh8
	9VEFD+OlOIHAm5BSC1cPqgeqQwQw+GTWmV9CJo5RfyOCEzq339X4mIK5mREBXr5s64nf6aOhz6F0w
	YlY0soxifFXkqVm3z7ghTXGHJfwiW/bkqeyXZCmWefkRD46GDcch/bI+dIvFof3lYDaTSJvNQYDQu
	r7b6PKfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55412)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rn2wa-0006uN-0N;
	Wed, 20 Mar 2024 20:53:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rn2wU-0002yT-JV; Wed, 20 Mar 2024 20:53:46 +0000
Date: Wed, 20 Mar 2024 20:53:46 +0000
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
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] net: phy: mediatek-ge: do not disable EEE
 advertisement
Message-ID: <ZftM2vDYQ2+5nSRV@shell.armlinux.org.uk>
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-3-3f17226344e8@arinc9.com>
 <3698b522-d6dc-46c1-bab2-d5ee3bed1fce@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3698b522-d6dc-46c1-bab2-d5ee3bed1fce@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 11:40:56PM +0300, Arınç ÜNAL wrote:
> On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
> > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > 
> > There's no need to disable Energy-Efficient Ethernet (EEE) advertisement on
> > the MT7530 and MT7531 switch PHYs. EEE works fine on MT7530 and MT7531
> > switch PHYs. Remove the code where EEE advertisement is disabled.
> > 
> > This is a bugfix because there's a possible race condition where the
> > mediatek-ge driver would kick in after the MT7530 DSA subdriver which would
> > have EEE disabled until manually enabled.
> 
> Can I get an opinion on this? Is it actually possible that the PHY driver
> would start probing after the DSA subdriver? On the console logs for the
> DSA subdriver, I can see that the name of the PHY driver will appear, which
> makes me believe the PHY driver would actually never probe after the DSA
> subdriver.
> 
> [    4.402641] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    4.420392] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    4.437791] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    4.455096] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    4.472422] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)
> 
> I don't want to submit a bugfix to the net tree if the bug won't ever
> happen in real life.

It would be really great if you could tell us which bug fixes you're
submitting are for a real problem that you or a user have encountered,
and which are down to essentially code inspection and things that
"aren't correct". Basically, don't do this.

It isn't true that the PHY specific driver will be probed before DSA
initialises - consider the case where the DSA driver is built-in but
the PHY specific driver is modular and on the not-yet-mounted rootfs.
That would result in the generic PHY driver being used even when the
PHY specific driver were to be loaded later - and thus only basic
standard 802.3 PHY behaviour will be supported.

That's not specific to mt7530, it applies to everything that uses
phylib. It isn't something that really warrants "bug fixing" in each
and every driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

