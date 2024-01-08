Return-Path: <linux-kernel+bounces-19856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41622827578
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665A61C223FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35054657;
	Mon,  8 Jan 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kf1a7rEb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45954659
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hpDL3geeVavERvbj6ZVeXLDAzGdQqMx/x8b3ZX5IR8E=; b=Kf1a7rEbcNqrGNse8pI76Q6609
	0J/vNEPdd+FM+m+HfZDfRoPABltiUh+/3ks03tXgjTHuRQU7tLQ9ZcEx8gWRigC/OZQ+fTGJcQz/L
	Art7ICShz5S0PgTFosrIrtm3cZeY7lrMvgzyqG1JL5Jc50QQu8pYJqQOEq7Oi9/lZLNaNA1m6NlXH
	FrEk1B5tzgVtwxSMjAtCYtlfJw02YI7RHyzPusvwsD1q2ERsmvZS6DQEeLUrmuShMO90L2EkoZVs1
	5sHK48ALee8W+QmkpTFkvZoJNCaMu7dX7oGzyXJ9gvV1ngrjzMv7KZVkzX7UIsDNsgsmWTzuP5A/Q
	TTRkq5ZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53620)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMsdb-0003E6-2q;
	Mon, 08 Jan 2024 16:38:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMsde-0003Nt-Kx; Mon, 08 Jan 2024 16:38:10 +0000
Date: Mon, 8 Jan 2024 16:38:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] SHA-3 causes kmod 28 to segfault
Message-ID: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

When building 6.7 under Debian Oldstable with kmod 28, the installation
of modules fails during depmod with a SEGV.

Running under gdb:

Program received signal SIGSEGV, Segmentation fault.
__strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133

I have no further information as I can't remember how to get the debug
info for packages under Debian - and even if I could, it's probably a
bug in the kmod package that Debian will have absolutely no interest in
fixing (based on previous experience reporting bugs to Debian.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

