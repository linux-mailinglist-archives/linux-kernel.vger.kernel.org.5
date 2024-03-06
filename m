Return-Path: <linux-kernel+bounces-93530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BDA87310C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313CB1C25E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784F5D911;
	Wed,  6 Mar 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qISw/3ad"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CA5D8F6;
	Wed,  6 Mar 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714784; cv=none; b=OdP8o8Nw1f9ebEZdFKwpLRgMzOFnqHJoCuGmXzgmOj6QRCu4aVtkitX4/Yv7pwvwSl1hEJ0YL05yewZSIXcUzdnl50ZKCNYjj2WJOVrrp8itL9kUDlklRsvzn3lSpvH/4NTUXeEEXmK5QUez1XQbL+He09PFkTWoH0SK7gsRwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714784; c=relaxed/simple;
	bh=jWw78X3DY/9+clhBevnZkRan4xkZOYNHU+sMDaAu0Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoWBiMG+piATcYau2dlngJLF+rvHFiRr5H5Q5OUS2QJCrbPpevnLXDub0EkoVG+0fGF0fj/tB4pceeKAxBA5HArl34shrU3PBGs2uxWDuF7bhZeG5ammzgFyyh5cc3iBJmduLuegAcMuXEJ/jSj20WZ3L6nJY5M6PVXnx9z3g8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qISw/3ad; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YV684JLoXhEVSYW91JLAHlDvME2Fe6uLqObFzkEpzYo=; b=qISw/3ad6WY2+LQRr6DmXBbvwt
	4766JgZKEO0JYJtnwhRfu2dhLezVW4H91KLnlDjClrbL/UJMfr3WfBU7C2G2gJawz+dJk8BMB7M7T
	euJtpDOWE6HY4ixx/wCM58chLxdOTXSgf1T7wVydZn9xjCFFcaSyPIWjen8EhA/plsGOd7EdVDHOT
	PGaCtaR3/Hclrv8BujYT72JVCcatPRGc/ZGzFO20vFs57JPE3yCoNy/nQTLV2s12QKwRdHl8FuLjX
	7ok389xLhn0nPzehtZTNR/+zQDO+Q2s7AM8sNP+NSGZwQ0sROmCN6YfAUKxWKKRkc4xHLt7++VE/n
	Ux1MyaNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhmug-00086D-0l;
	Wed, 06 Mar 2024 08:46:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhmud-0006Dv-6L; Wed, 06 Mar 2024 08:46:07 +0000
Date: Wed, 6 Mar 2024 08:46:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/16] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <ZegtT6Rt7bGbn0sx@shell.armlinux.org.uk>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-3-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 01, 2024 at 11:16:24PM +0100, Pawel Dembicki wrote:
> This patch replaces the adjust_link api with the phylink apis that provide
> equivalent functionality.
> 
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
> 
> Removes:
> .adjust_link
> Adds:
> .phylink_mac_config
> .phylink_mac_link_up
> .phylink_mac_link_down
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

