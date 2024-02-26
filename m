Return-Path: <linux-kernel+bounces-82106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CE867F58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDDF1F2B606
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24712EBC1;
	Mon, 26 Feb 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jRI2fyrP"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB212DD9B;
	Mon, 26 Feb 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970031; cv=none; b=TiNAujRF+9Fe4Lx0HuhZRoS/bRN4y9+85cj/6emYyKb0TIBimPUNjQ4b7UWO4IMI1EMhGU1bYkpPHiue3JVj7RVjyTnWhKHKXYgOjRWg/A7hnEibhjNqicBRrBNFLvLbZPMSXXiSlcX+9L3xNiI/gAOtybncFpQtaE3/UfKxgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970031; c=relaxed/simple;
	bh=6fa34faceJzMXzcYCnRXGvqxI3/PFGNUCWHcn+SeQZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCGx1wL0cvOxDOyrRVzf1RoftPLgcL5yEmq7348ccPcZpB62YeCH/HI+BQLW2MiViHux4e9XtE2ueM9NJepDC1ec229NhfOMv/eh1ARNQwtWU+Uq+R1yZnhoUC1n9hgAlGSdvSfSZHlMHIiQainJaAO0qz79ZcAw7pBxO/JwC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jRI2fyrP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1p1DkU003gUsxt6igF3+hBD3UuLE8cg1CfVd//JadfU=; b=jRI2fyrPeFscsV9g9f+myW5X2z
	hdyGQwdM2T8fz2FQw7aITmvRPFIwHyNUzWdCi70QGWjYTZZuQquWYgXY/3rmX/7+P7g53P+JJssDU
	vV5PExCJxuco9vKsedkgIKHdJYmtIlNDBcJtzOAZvE0xvZSKAUTyqqvExhVD6vQukWs5A7hvPnwJh
	kd67N4mO74vp5jRmBNWieIkt5d87lhrFw+bb0H6E0fZhfJKF9N1+gtjhBgpr37wVp81OrqrvPNHYz
	B5CcciKj4X1e4QZZRgwmbpdllbxLHCxh79oLwe1JEJgVY1+FdsrgfnAykQcsuRzJMgmvvfb6lS1q9
	dN2gPVJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48730)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1refAV-0004Y9-35;
	Mon, 26 Feb 2024 17:53:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1refAR-0006cv-9Z; Mon, 26 Feb 2024 17:53:31 +0000
Date: Mon, 26 Feb 2024 17:53:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
	Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <ZdzQG6t2slqEyH0m@shell.armlinux.org.uk>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
 <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
 <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 09:50:02AM -0800, Florian Fainelli wrote:
> This is the source of the concern, we don't know which MAC drivers we might
> end-up breaking by calling adjust_link(link == 1) twice in a row, hopefully
> none, because they should be well written to only update the parameters that
> need updating, but who knows?

Just quickly... There are some (I went through a bunch.) They don't
support EEE. I haven't been through all though, so there could be
some which support EEE and where adjust_link() with phydev->link=true
twice in a row could result in badness.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

