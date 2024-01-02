Return-Path: <linux-kernel+bounces-14308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63F1821B27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3225B218C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F5EAE5;
	Tue,  2 Jan 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZdOQTpa0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEFEAC2;
	Tue,  2 Jan 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UklajQ9JTXYubmhmdHvvtB1U0jcrFHuCHpiOoKk95LQ=; b=ZdOQTpa00hDTiVvIqU4tks9+c7
	/FHOBxaNXJJpQD1EGgZx6nfIlvksPzg/sy3fpbWsr2VC0Qj9elsV4KVFVMtrfUnteJuUKfzNcDfwc
	Y/jtbbudJ0UnY7NNWz5A+guAXFf/kWRVMli5aQRy9J1j1HKQhorA25WWj/RhjDToHkB+2m22G+1Iv
	xq3Vd4uJ9/4K3yPr8gi6KUgeMNA5pP9zb36etoM3D6ukmUfnp7jd6tXBU/mX+o3a/d8ZAVWNHf55D
	QcKnQ2tPJ1t4UYf86rIPupkcdmNsMyFT2P/dhkKNnCXE0Oy4p0KbdkUuDNdfQjxdRkFancp3XZxDR
	4nbGC6uA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKdCg-0006Ul-0x;
	Tue, 02 Jan 2024 11:45:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKdCi-0005G8-OG; Tue, 02 Jan 2024 11:45:04 +0000
Date: Tue, 2 Jan 2024 11:45:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: linux/phy.h: fix Excess kernel-doc description
 warning
Message-ID: <ZZP3QHTfUUmBve6w@shell.armlinux.org.uk>
References: <20231223050613.13978-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223050613.13978-1-rdunlap@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 22, 2023 at 09:06:13PM -0800, Randy Dunlap wrote:
> Remove the @phy_timer: line to prevent the kernel-doc warning:
> 
> include/linux/phy.h:768: warning: Excess struct member 'phy_timer' description in 'phy_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: netdev@vger.kernel.org
> ---

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

