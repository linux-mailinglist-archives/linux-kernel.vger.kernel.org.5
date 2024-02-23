Return-Path: <linux-kernel+bounces-78153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36061860F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB51C1F2877B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF77EEE5;
	Fri, 23 Feb 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I+Y0fxKd"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862D7E772;
	Fri, 23 Feb 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684722; cv=none; b=EzJ22EYaiWhTMPOCzsvWlu4EzJP/W9gFrXnh3b1uG5OOqCVntNFPtJGvH5Pv92yUzSJ9ZAXZkRbCuTBP54LG3lnhSOodYkl6NAh63tVwpCdgpiTxGW5dVJsSAWQE/DWAHTOM/4tFH76h+XIZKNUbsNk6Qv6EJS3Xij+9WWuNon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684722; c=relaxed/simple;
	bh=O3IrUyblnuX/5xQB5jaQ38QXY1p+GizHIVBUKzOy3jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcvG7LRJ8f11pm8aUWcuQUh5L+Y2MxatdINadMAXyQxPvROsQ4e3QVgOV/UGAPVhDMfMRnmaujlghxl6eW6RWkiNjihwngIxs3aT9y4xgZE+KvWCcHMbS4x6bemd7ycFrgJhNH+P8Lc9c3GVU5xEJ6lSkZrd2l1s/ykr7k1NbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I+Y0fxKd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=STbccEumsUwS1x3Lag48jXHMfPCnA9k9jkVStMkjKiE=; b=I+Y0fxKdZ0Sd2vE+QThwFWzwIQ
	GIC3VHV/kqid/e+7zPewniD1+fDQYmK7Kto6z2uVk+91xhO+qLhJ8hLLJGjbseZ4/hrzWeJne84Wn
	RJR0NE2jiV1YANZNlnIF3uaNRWttSvCl6XFm77qKYuiuD519Y2CY7dqGANuet0/qD7Nk8wyNDlwJd
	p0dPUqB5NtWAnOmjAB9rcDkxn64ALbRU5GnA5vgxVHGnLp2RVAVFTVuz9JpSDeTxGVMfF1Vj2MTQK
	fJ4m2QbZ+0XnePYFaHkrrb4nErWbbfogTtSDUrugzQAG7tJG914q0SEJImRSbmk3YYJ2TwaAP6COC
	LhkXiVYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46402)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdSwi-0007Tj-0G;
	Fri, 23 Feb 2024 10:38:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdSwe-0003Y7-Lq; Fri, 23 Feb 2024 10:38:20 +0000
Date: Fri, 23 Feb 2024 10:38:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223094425.691209-6-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> +				      struct ethtool_keee *data)
> +{
> +	if (phydev->eee_cfg.tx_lpi_enabled !=
> +	    data->tx_lpi_enabled) {
> +		eee_to_eeecfg(data, &phydev->eee_cfg);
> +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> +		if (phydev->link)
> +			phy_link_up(phydev);

I'm not convinced this is a good idea. Hasn't phylib previously had
the guarantee that the link will go down between two link-up events?
So calling phy_link_up() may result in either the MAC driver ignoring
it, or modifying registers that are only supposed to be modified while
the MAC side is down.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

