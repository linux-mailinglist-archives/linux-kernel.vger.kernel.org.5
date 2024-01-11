Return-Path: <linux-kernel+bounces-23814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433582B219
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015BB285FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F84F20F;
	Thu, 11 Jan 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p8TWB1u4"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B824CDE9;
	Thu, 11 Jan 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SXSMgPvMG1CFS/vVmNC+AEGMC+mPoePNedwOvprq5p4=; b=p8TWB1u4BW/lAVnu4oUzzYpbM6
	+aSgn62SfVcrxtWrnRiH1ZBBIYTxVpREw2RrtEUsrYKEIsi/RvOU+ErhrhEH7Z9yUljXDS/e5ZX4n
	nm5edQpJTeUukcYcvt/8fTCOUlH+KUAImWdnjmriYOaQ31etZENvjMSItVpt62HAFV9jE40K/2B8y
	VnEJ1X76NkH8oixaGE2kGB04MNbSxqVcFPt2OMBJtvGLaTUlRc+Y/z3kw0MlGj4q/suNyK9gOnv+r
	Tap60Wah3r675cvaQKJhXJbKUsV2SygULeIqwjOpUlbBqo/NB1SH6ImsDbAOlsjw019g/ktd4loWG
	nT3CfRlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNxJS-0006iZ-32;
	Thu, 11 Jan 2024 15:49:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNxJP-0006Ts-R5; Thu, 11 Jan 2024 15:49:44 +0000
Date: Thu, 11 Jan 2024 15:49:43 +0000
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
Message-ID: <ZaAOF/esan+HnufM@shell.armlinux.org.uk>
References: <20240109075656.2656359-1-arnd@kernel.org>
 <ZZ0TdiIDE2lqHE+8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ0TdiIDE2lqHE+8@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 09, 2024 at 09:35:50AM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 09, 2024 at 08:56:21AM +0100, Arnd Bergmann wrote:
> > diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
> > index 23cd610bd376..46630f05d8dd 100644
> > --- a/drivers/net/ethernet/wangxun/Kconfig
> > +++ b/drivers/net/ethernet/wangxun/Kconfig
> > @@ -26,6 +26,7 @@ config NGBE
> >  	tristate "Wangxun(R) GbE PCI Express adapters support"
> >  	depends on PCI
> >  	select LIBWX
> > +	select PHYLINK
> >  	select PHYLIB
> 
> You can drop PHYLIB when adding PHYLINK.

Arnd,

There are repeated complaints from the kernel build bot about this, and
it would be good to get it solved. Could we have an updated patch
submitted to netdev please? This is in net-next only at the moment,
so I think that means it needs to be submitted with:

	[PATCH net-next ...]

and please make it clear that it is a fix for code only in net-next.
(However, netdev folk may request it to be referred until net-next is
merged and then against the net tree...)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

