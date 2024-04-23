Return-Path: <linux-kernel+bounces-155784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D408AF713
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8471F23A80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F913FD7C;
	Tue, 23 Apr 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VMxNgFE7"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8E1E49E;
	Tue, 23 Apr 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899683; cv=none; b=kB28G/8eIkltAjesDokvynwkCBW+BYSo+sBdeTuZFUlO3fw5XO8TUghZZW9T5qxfZWCK6+lozbMnOQs9LzkuRJ3CotvYSX0PEMvK2Sk2eN5c+4xdAF+XodKyySYnPEjMqco8Vtg9PwEtZeoJ02wPQiCFYIkdfyjVsS1uYq0fOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899683; c=relaxed/simple;
	bh=vHCfR07oU6jXib+D/KGYmjmEdexZMbpvXTHnBEU9KGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYS3QK+DUNGml2zV7f+UATgwGgx+Pv82ctthZ0No/NjgGi6iJCS0icQ2/D/O5OZbvcmFQWnayiW9Zxr4GFibxO+S+hrGq0k7s3y4x2y6p2ydmqTNMT1WhLE2ok4reYM4tf1mTi6f7rv9amCYwMQhs3mcuyKf9l5RGBqooJ3oCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VMxNgFE7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m/j47UCoCVDN051XsJvZ/Szrqafk0ETS8lvIj7OcbyY=; b=VMxNgFE7yJtbn8XCv0oN4WtWH3
	9Ay3zHGNLSUDat1mAimTbSPhdHD05TQAwG8VC91v1fktQzF0Ai5L2UdNWgZcjzq4QsrIshvn3l7Ib
	usqRHqFwqc75QdegQlnGPXUQntzUBPqzHd7XOHMyI6rRr4oB/KT//TMSWyVYmSDcZcSKF7V/ez1yW
	p0EYl1NDn+03AkfoSJKsI6BDurOuljFj+AA0KHC7yTLpJQ8hl3z9K1dQrNSkeGUs8mGMIKP5YdliM
	efJz2bSXQyDGcuXEbyPhoElMMqUyteZoymGxOCVWJC367AeRg25sWmY2GUTPaQd+FPwygxdYA3929
	n0mkUyHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rzLb1-0004xi-0L;
	Tue, 23 Apr 2024 20:14:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rzLb0-0003cf-4K; Tue, 23 Apr 2024 20:14:26 +0100
Date: Tue, 23 Apr 2024 20:14:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: Remove adjust_link
Message-ID: <ZigIkdr/FEmBZRLP@shell.armlinux.org.uk>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 23, 2024 at 11:33:31AM -0700, Florian Fainelli wrote:
> b53 is now the only remaining driver that uses both PHYLIB's adjust_link
> and PHYLINK's mac_ops callbacks, convert entirely to PHYLINK.
> 
> Florian Fainelli (8):
>   net: dsa: b53: Stop exporting b53_phylink_* routines
>   net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
>   net: dsa: b53: Introduce b53_adjust_5325_mii()
>   net: dsa: b53: Force flow control for BCM5301X CPU port(s)
>   net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
>   net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
>   net: dsa: b53: Remove b53_adjust_link()
>   net: dsa: b53: provide own phylink MAC operations

Read through the series, nothing obvious stands out, thanks for doing
this!

For the series:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

