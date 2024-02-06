Return-Path: <linux-kernel+bounces-55718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DE84C0BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E41F23E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534121CAB7;
	Tue,  6 Feb 2024 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="StElRlcS"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A41C29C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261504; cv=none; b=TPqomC+AYckfzjeEfQC2DXLehOlMW7yHVkNdFvzQyMBW2fX2SWtDIySepDbjkIA1FrpVWDVf+Y/2yotpABHxYBqCgXh6h3KvMcv0nv643wB3QT/4X222C2wWXU4PemH+YNedHKxzqqDyflVE/Ir2/SfC7jg4NVGx8CIm+TpxoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261504; c=relaxed/simple;
	bh=6k2/v7t4Lc7qS2f3uGGBR4lHof09wjKlY6e2xCdE8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQsnfVeIcGIwGyN4rJBk5t1r7VOI5hI2pTwobDeYmDYicdIV8Hk4f5RAHfLNIykm42zFWazXqBUS6pAC1HM1zF6SmC4BIw1/dbfNyQhtg0A91npL3bisQCAz00603/N5PcdCS1a9kjYWpQ2k2e/QneeSDD68HCleg6aNk6Qu89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=StElRlcS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKdDlBaoWLD1i+SswtNzDM+hpIQ9ywhkR3LkK9m+G3w=; b=StElRlcSH9oSxj07zjDse4KeZb
	JMadwTYZgV3Oekw3j3odYlubfWwU2FxbHxxfvbtmPerYRfD2Fdz/rT5qsS/cYwagrYJqiUP9rnG6/
	rRQnXey/kmQsTp1DUG7bi1vkNhSSGhbvkNmYGokw9mx12+pPUqUnMrLnZBFgzqIYXdZnfKAhL8isj
	2S2hCuTWe5Mdcd19mk4IR4l80NSKrjqvRUpXfIfHS32mg01WRGowqs7MZbVshbCqrHQp/84zuJiIh
	TN1VWOm++QJRkeafxPtYvXNZAvhNga5IGoksfC4ys0rskp+Wol5sb4EV+vpkHX2Nh6+EhptKuBUMq
	bVdXUw0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rXUhY-0002bh-1q;
	Tue, 06 Feb 2024 23:18:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rXUhS-00040V-VN; Tue, 06 Feb 2024 23:17:59 +0000
Date: Tue, 6 Feb 2024 23:17:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com
Subject: Re: [PATCH REPOST v2] ARM64: Dynamically allocate cpumasks and
 increase supported CPUs to 512
Message-ID: <ZcK+JmY2KRfkdQj4@shell.armlinux.org.uk>
References: <e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 06, 2024 at 10:09:59AM -0800, Christoph Lameter (Ampere) wrote:
> Can we get this merged for 6.9? The patch has been around for awhile now.
> 
> 
> 
> Ampere Computing develops high end ARM processor that support an ever
> increasing number of processors. The default 256 processors are
> not enough for our newer products. The default is used by
> distros and therefore our customers cannot use distro kernels because
> the number of processors is not supported.
> 
> One of the objections against earlier patches to increase the limit
> was that the memory use becomes too high. There is a feature called
> CPUMASK_OFFSTACK that configures the cpumasks in the kernel to be
> dynamically allocated. This was used in the X86 architecture in the
> past to enable support for larger CPU configurations up to 8k cpus.
> 
> With that is becomes possible to dynamically size the allocation of
> the cpu bitmaps depending on the quantity of processors detected on
> bootup.
> 
> This patch enables that logic if more than 256 processors
> are configured and increases the default to 512 processors.
> 
> Further increases may be needed if ARM processor vendors start
> supporting more processors. Given the current inflationary trends
> in core counts from multiple processor manufacturers this may occur.
> 
> Tested-by: Eric Mackay <eric.mackay@oracle.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

> Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

