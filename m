Return-Path: <linux-kernel+bounces-23343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA582AB61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3CCB21F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C8125B5;
	Thu, 11 Jan 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IpU5IN+B"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F311722;
	Thu, 11 Jan 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EgiHrGWYBA6aL4HOR5JD3n9X8Y9twX1PfVqPn+eiAKA=; b=IpU5IN+B34WDy0CdImrjCB5WZe
	OHDlJQaJKmKSVHc2w2Nh09yX4A+VhlZ9fwiWHxwOcL1G0tF3VMReE0HxmMDgNZpHTAojewAc2A/Sk
	XNYSABtgl+5qpYwKsAHCN2OsOgA4OQ2/fwFMiktkuoFJUmItKYSKmHQw/eq9J/2DvkJH56s6Uh9ka
	HxF2fqLpJOsUMyFWEByfyhCExC/8evs5UiBE3ipBoP0s9M91B0YguVS30aGydIXhZPgYFqOp0svMI
	3u2sryub2gSy2g5+betsApN85KWVayl+YMFRJb3hZtJ5M/ECsNey1MOBCke7lVpdn0ORhrXWPWkap
	fS5FdDjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNrm2-0006Li-2J;
	Thu, 11 Jan 2024 09:54:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNrm2-0006Fz-K2; Thu, 11 Jan 2024 09:54:54 +0000
Date: Thu, 11 Jan 2024 09:54:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Voon, Weifeng" <weifeng.voon@intel.com>,
	"Song, Yoong Siang" <yoong.siang.song@intel.com>,
	"Choong, Yong Liang" <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v3 1/1] net: phylink: Add module_exit()
Message-ID: <ZZ+67poJKiNsVmKw@shell.armlinux.org.uk>
References: <20240104101255.3056090-1-yi.fang.gan@intel.com>
 <fb1cc3a4-8615-4cee-8fe7-29966c4cb7c7@lunn.ch>
 <MW6PR11MB8310698247DD950C5EBF5F2CB9682@MW6PR11MB8310.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR11MB8310698247DD950C5EBF5F2CB9682@MW6PR11MB8310.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 11, 2024 at 06:38:58AM +0000, Gan, Yi Fang wrote:
> Hi Andrew,
> 
> Regarding the justification on why it is safe to remove phylink, 
> we had done some memory leak check when unloading the phylink module.
>  
> root@localhost:~# lsmod | grep "phylink"
> phylink               73728  0
> root@localhost:~# rmmod phylink
> root@localhost:~# echo scan > /sys/kernel/debug/kmemleak
> root@localhost:~# cat /sys/kernel/debug/kmemleak
> root@localhost:~#
>  
> So far, we didn't observe any memory leaking happened when unloading
> phylink module. Is it sufficient or do you have any other suggestions to check 
> on whether the module is safe to remove?

I have no idea why one would think that memory leaks are in some way
related to whether a module can be removed or not. To me at least they
are two separate issues.

I'll continue waiting for the justification...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

