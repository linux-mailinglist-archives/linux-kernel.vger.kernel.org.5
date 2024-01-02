Return-Path: <linux-kernel+bounces-14300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35D821B11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F11F21B88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2FDEAD9;
	Tue,  2 Jan 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nyt5iZ81"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A1EAC0;
	Tue,  2 Jan 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0zuMAw5hy4EWFGm1n9NKAOVIvTy+R2ps+YCTy6ULtmI=; b=Nyt5iZ81xR1esYL/XWDhQdufVm
	St+PtX31GbwLgODgDQyUaTDhGzIHZl+ZnWl+MXC8de9F315zJcjH5is1I/ESXbSIayGWLewny0Qj8
	EbneUncfP6AyTxeO7raA6d6kBVLcrU6JDrHTW2MVdfRdWBr76nJ+sfZzRTizfHH0xxo5IViSiTLB9
	MWXYgeGiD0zomDMrNjQalDmMTgjscMBPvI/OqfDHZD1OD92fxbHcteDDZSHGWdAyzgxUnhm1FvQls
	FSNDgPMLNPyKm+Ln8nSCAv8UpMJsF/zg2tAoZmm8qoh2sTPT2mA85PiOoGkf2o/CqeCAlEFbzUAqz
	LJfO3z6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKd4e-0006Tt-2U;
	Tue, 02 Jan 2024 11:36:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKd4h-0005Ez-6w; Tue, 02 Jan 2024 11:36:47 +0000
Date: Tue, 2 Jan 2024 11:36:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <ZZP1T7gJPAsEzeas@shell.armlinux.org.uk>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
 <ZYRCDTWgHbM2qAom@eichest-laptop>
 <20231221141636.GA122124@debian>
 <59fed161-6c08-4537-b02d-19e67e342dd8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59fed161-6c08-4537-b02d-19e67e342dd8@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 21, 2023 at 03:25:56PM +0100, Andrew Lunn wrote:
> > Without setting the master-slave option it didn't work. I think its
> > mandatory.
> 
> I don't think it is. The PHY should have a default setting for
> master-slave. Often its based on the typical use case. If its
> typically inside a switch, then it should default to prefer-master. If
> its typically in an end system, then it should be prefer-slave.

However, master/slave needs autoneg, and if autoneg is disabled, then
that may not be resolvable, and it may need manual configuration.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

