Return-Path: <linux-kernel+bounces-76715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271085FB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21E22894AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AD7137C29;
	Thu, 22 Feb 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vkvo9Rsh"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CF3E498
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612715; cv=none; b=Zdl5Br4ipa/AmreF2SIp2TY7kmo6tgXwbgPJcEfBH1vtmL2tOLc+SN4ITp2uzoV84O1A3QzifzeYpy0nclIwWtNu65wtfJoQKCh7i96KJEUCgUNz1YXhIjlZJxov/5L8jR7NLdYZJyEVb77NSp38Zu0E3ZgdN1cSWTiwdo7YUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612715; c=relaxed/simple;
	bh=F5KPSxrA0sctIZZTx87oKxMDdEw3rleqhFEeyYe2U84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYAlIhHqCR2/3QNP90YuZyLPzeLUxdWJEvI2wP+UJ/achwxoF4Z6P/Kdls0HNACakJcxCxgrOZISeFQ9RPadJYtniEAmwYabIt+Bb5Zwjt8F/rscfejN7Bu8Vq4vA/ufd9ZQgKZn8sI9CGBiwo/1n5eiV/WP1NnVF0kjhJIwHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vkvo9Rsh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/BpwflssP4PEcOh2KY7CL2xY3MWt2dcjH3m2gAzNsSA=; b=Vkvo9RshqfAZdKMtoyFloVV32X
	mR0Pt1219LAa/ebdd07k9hT7PoHVxy0+YeuxZpdRdnVmRABhrkVB/8y3w3rYsLaMaTcLAgBfRypnw
	EMYha8BhK3SS8yFXNMwdEJWWmdnXXWPNQFxGF0yTVEhkltjtVy5hhVAtO4YOset5dSUljPtp/cf7w
	baxj1JAg7toQ0Ixg0j3pPJZVO615mt1o0iYaxidcalBLVqFs/Pw7deExQngqdWzEPBQCmULfKdX35
	+fXfOFED0VNNM6qucD2YTI+vt8B4qRVHbPjEfT82MWZzN8qJoPUA04866ivowbPKuz5GVc7BCoG37
	SG+OU7pg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdAD8-0003ll-2Q;
	Thu, 22 Feb 2024 14:38:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdAD4-0002l7-0Y; Thu, 22 Feb 2024 14:38:02 +0000
Date: Thu, 22 Feb 2024 14:38:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>,
	linux-arm-kernel@lists.infradead.org, yanaijie@huawei.com,
	zhangxiaoxu5@huawei.com, sunnanyong@huawei.com, rppt@linux.ibm.com,
	linux-kernel@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
	m.szyprowski@samsung.com, willy@infradead.org
Subject: Re: [PATCH] arm: flush: check if the folio is reserved for IMO
 addresses
Message-ID: <ZddcSai76/KWxlMc@shell.armlinux.org.uk>
References: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
 <f795228c-9795-4449-abcb-b7ff0cb486fb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f795228c-9795-4449-abcb-b7ff0cb486fb@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 22, 2024 at 10:06:04PM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/2/22 22:01, Yongqiang Liu wrote:
> > Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
> > freed memory map alignment") changes the semantics of pfn_valid() to check
> > presence of the memory map for a PFN. A valid page for an address which
> > is reserved but not mapped by the kernel[1].In Some uio case we will get
> > a crash on a system with the following memory layout:
> > 
> >   node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
> >   node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
> >   the uio layout is：0xc0900000, 0x100000
> > 
> > the crash backtrace like:
> > 
> >    Unable to handle kernel paging request at virtual address bff00000
> >    [...]
> >    CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
> >    Hardware name: Generic DT based system
> >    PC is at b15_flush_kern_dcache_area+0x24/0x3c
> >    LR is at __sync_icache_dcache+0x6c/0x98
> >    [...]
> >     (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
> >     (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
> >     (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
> >     (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
> >     (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
> >     (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
> >     (__do_mmap_mm) from (do_mmap+0x50/0x58)
> >     (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
> >     (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
> >     (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
> >    Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
> >    ---[ end trace 09cf0734c3805d52 ]---
> >    Kernel panic - not syncing: Fatal exception
> > 
> > So check if PG_reserved was set to solve this issue.
> > 
> > [1]: https://lore.kernel.org/lkml/Zbtdue57RO0QScJM@linux.ibm.com/
> > 
> > Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > ---
> >   arch/arm/mm/flush.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index d19d140a10c7..f2b99223a0ab 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -15,6 +15,7 @@
> >   #include <asm/smp_plat.h>
> >   #include <asm/tlbflush.h>
> >   #include <linux/hugetlb.h>
> > +#include <linux/memblock.h>
> 这个删掉吧然后发出去

Speak English so that everyone knows what you are saying. You are
participating in an international community where English is the
language that we use to communicate between ourselves.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

