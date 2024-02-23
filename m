Return-Path: <linux-kernel+bounces-78207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA141861040
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8172870E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E9763F0;
	Fri, 23 Feb 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="guQOBZjs"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BD604D0;
	Fri, 23 Feb 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687310; cv=none; b=h2UMyXpQ/eVE6Ok1E1/P4hQKYI89K83FZSzd/A1vxe6s219vu+Qb40SEoZAoHCTydMDNdFwPJ7NTNIHrFooIYrFYuY2ToTlgfM1I4RPT08fpP3JMCjE34dqQKbJ7nC7ydD6SbpSX99r+AVknbgCvjzRLrEBQ2Ipc8absopVBLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687310; c=relaxed/simple;
	bh=peReEDJGy04XpZdGr/L1b7dThSp0Y81LgLaHw20Wg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek9UHVAD4I1HizDiHgdghtZFvczxCITMI+BTcwF+9ORyrm7WzGKsFWCn17rI0UcmRktbz2UQeIwHj/LuVWZWlsqJhU3xQnTojYMc6zQiaBEamzLl3WK9s33fsz1qetOHr7Fny36jQCz2u9Ohz+no6EZx4ei5/p3xgMNoMz1pto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=guQOBZjs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eOoP1B49M2U+RuY8cj+gGulW+f80SLlRYJjbhFcwxtU=; b=guQOBZjsMDgz0rR25wfeUMMD0Q
	oIWDKOtbyY9hY0VpWCFzndeMPwNC68VJ3dIRDuErL4jWsyltBrDmfgPSkl5CeQ8SjJ6dIAj0UXE8j
	ZLQLEOWecfcIabJYcDuw6IzzL9g12yG61NBEA3VLhEvkn75TOiGRJBChDetpMwURtsFmW0MckMge6
	Xq4mi8i38/XQ28lSLxjq64H16PnpAtdErD+Pe85WRdiMKDsgPLTpbo/ia839+z6IPc7+Ym+RuCa4/
	aAd8AjFqBH8+lnF1IBr+gjnovXnuiAEmMep/hFRWMoCjIUzr0fRBrd9KNCiBwKYzY+++8yKxapygk
	oXtE8Zbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdTcZ-0007cn-0A;
	Fri, 23 Feb 2024 11:21:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdTcW-0003a8-PX; Fri, 23 Feb 2024 11:21:36 +0000
Date: Fri, 23 Feb 2024 11:21:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v5 6/8] net: phy: Add phy_support_eee()
 indicating MAC support EEE
Message-ID: <Zdh/wGsR96cQ0xsQ@shell.armlinux.org.uk>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-7-o.rempel@pengutronix.de>
 <9e37a9e9-7722-407c-a2a5-b8c04b68f594@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e37a9e9-7722-407c-a2a5-b8c04b68f594@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 22, 2024 at 08:52:25PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > 
> > In order for EEE to operate, both the MAC and the PHY need to support
> > it, similar to how pause works.
> 
> Kinda, a number of PHYs have added support for SmartEEE or AutoGrEEEn in
> order to provide some EEE-like power savings with non-EEE capable MACs.
> 
> Oleksij  did not you have a patch series at some point that introduced a
> smarteee field in the phy_device structure to reflect that? I thought that
> had been accepted, but maybe not.

I have some similar hacks for the Atheros SmartEEE in my tree that I've
never published.

For SmartEEE, we need two things to happen:

1) MAC drivers must not fail set_eee()/get_eee() just because they
themselves do not support EEE.
2) MAC drivers must not attempt to modify the EEE parameters passed
to phylib.

Whether a MAC driver should be configuring the hardware in set_eee()
at all is another question - because in the case of using SmartEEE
the MAC side is irrelevant. So maybe phylib should have a callback to
set the EEE TX LPI parameters? In phylink, my model was to add two
new functions (one to enable and another to disable TX LPI) and the
enable function always gets passed the TX LPI timeout.

If we did the same in phylib, we would eliminate the need for MAC
drivers to conditionalise based on SmartEEE - that could be handled
entirely within phylib.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

