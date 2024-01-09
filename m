Return-Path: <linux-kernel+bounces-20671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193FD82834E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C1E1F236C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C634CFF;
	Tue,  9 Jan 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kY4Q7ANt"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1B2E650;
	Tue,  9 Jan 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OdqzZjfPihD8+HAjcrPs6VxIF0BP9O0oEYSSObMVmwM=; b=kY4Q7ANtAKQyWVEnwcsX8lvWjn
	RqXPViI3icGXcSBHCKEJV/DfpqSZV5LK3wTekFKqLNq2sEXp7AuifzqEvAnrlHx38e92b5KMSzMYO
	NM2uzOklo5iF+XPpcxy5pt8djMw57C5LxD1ih+v9P6zyc267spyPHzKDVBXlcg5D/OmADrlZex+yj
	nYsSyGjPIHC55rwONu/9cY6H3zt+bljipIoaGb8A8daCC+mSZCjPQeUoyVmdjb8piYtrXW/qSGTrF
	nlJpBLHmefxBdvjs0dD8/M7pxMS8z4/7qKq7kEZyN/R/WEbrseMI3G4SAjvFoLrpeMZvuAIxkIuoE
	VuDkr/Bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37974)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rN8WV-0003wa-24;
	Tue, 09 Jan 2024 09:35:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rN8WU-00049r-MQ; Tue, 09 Jan 2024 09:35:50 +0000
Date: Tue, 9 Jan 2024 09:35:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wangxunx: select CONFIG_PHYLINK where needed
Message-ID: <ZZ0TdiIDE2lqHE+8@shell.armlinux.org.uk>
References: <20240109075656.2656359-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109075656.2656359-1-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 09, 2024 at 08:56:21AM +0100, Arnd Bergmann wrote:
> diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
> index 23cd610bd376..46630f05d8dd 100644
> --- a/drivers/net/ethernet/wangxun/Kconfig
> +++ b/drivers/net/ethernet/wangxun/Kconfig
> @@ -26,6 +26,7 @@ config NGBE
>  	tristate "Wangxun(R) GbE PCI Express adapters support"
>  	depends on PCI
>  	select LIBWX
> +	select PHYLINK
>  	select PHYLIB

You can drop PHYLIB when adding PHYLINK.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

