Return-Path: <linux-kernel+bounces-46997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E88447AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3299A1F22D38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8F3611B;
	Wed, 31 Jan 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h0kgfmPj"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976432135C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727671; cv=none; b=AkI3N5ohw2DS9dimVw/VGqIEGphdaVrDZk9qflD8XvCsSc45wqjxHy1tiv0ELS9sKYdHEGI69Cnc9DjriTyQhL3MJYzRR3wiJFZHIYV1sA275+ABmLVHHaAIzBCNvK/WVsUfXaFhjwP2BTjA+BeOrKioWpZ0yuCwT6hfDX9to6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727671; c=relaxed/simple;
	bh=2FW+E70zb+jtCWw0vFT7rUSygY5hCC4TwbggVezxrqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQjROcVM0mEJM6fWB4jGe98vcCCmdzdaMCigPLEDMjC988pPNdyaBcAAo7k5Ji/rtjvcIHz7Y6IDkKYxiFKBNlecVPa+P6v3dHUM3OQqZXqHi1wDbY+kedwQh7pTh9DTDa/TRIKyF4iIK076RU98QUkuVqXaSxl3+PpOpjJxGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h0kgfmPj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FG9JknT4xvN8St/UMt7dRNO3f3FgC/mu2jaTaHknhkA=; b=h0kgfmPjm2TFnMUX3ri8gtEdlj
	lNRpeE3zmlaYgAMvpXL2Dz16o88PMRc5E6BEAqWsbx0//hEhgIhqgYwJxsR2CbMt/cmaZ5oBSA9s1
	mh8uP9oF7xpoAzVb4LEKMDDCtA4a26IVbZpggw0ozJzREtUhpp7sYlVoKki+5GZuGk30UQzRdcUjw
	eaROgzQ5WeLNuuna7SKO7qiVy79e2u5AOPhDGYCI4Lw5QRLSgXExaCsuYnWmjjBBdNM+dA2dkjevt
	tSBlYR+FAyrz2sJ316Mg0ZT7/q/j6HMQiaAqTUTTR/h9HMj0pZm6hFjaq6UZVWCepuqG2s3kx6ceZ
	txnCLQ8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVFpG-0003hm-2d;
	Wed, 31 Jan 2024 19:00:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVFp9-0006ds-E6; Wed, 31 Jan 2024 19:00:39 +0000
Date: Wed, 31 Jan 2024 19:00:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>,
	linux-arm-kernel@lists.infradead.org, yanaijie@huawei.com,
	zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com, rppt@linux.ibm.com,
	linux-kernel@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
	m.szyprowski@samsung.com, willy@infradead.org
Subject: Re: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is
 in RAM
Message-ID: <ZbqY12U/CXwAAu7A@shell.armlinux.org.uk>
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
 <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 31, 2024 at 06:39:31PM +0000, Robin Murphy wrote:
> On 31/01/2024 12:59 pm, Yongqiang Liu wrote:
> > @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
> >   		/* only flush non-aliasing VIPT caches for exec mappings */
> >   		return;
> >   	pfn = pte_pfn(pteval);
> > -	if (!pfn_valid(pfn))
> > +	if (!memblock_is_map_memory(PFN_PHYS(pfn)))
> >   		return;
> >   	folio = page_folio(pfn_to_page(pfn));
> 
> Hmm, it's a bit odd in context, since pfn_valid() obviously pairs with this
> pfn_to_page(), whereas it's not necessarily clear that
> memblock_is_map_memory() implies pfn_valid().
> 
> However, in this case we're starting from a PTE - rather than going off to
> do a slow scan of memblock to determine whether a round-trip through
> page_address() is going to give back a mapped VA, can we not trivially
> identify that from whether the PTE itself is valid?

Depends what you mean by "valid". If you're referring to pte_valid()
and L_PTE_VALID then no.

On 32-bit non-LPAE, the valid bit is the same as the present bit, and
needs to be set for the PTE to not fault. Any PTE that is mapping
something will be "valid" whether it is memory or not, whether it is
backed by a page or not.

pfn_valid() should be telling us whether the PFN is suitable to be
passed to pfn_to_page(), and if we have a situation where pfn_valid()
returns true, but pfn_to_page() returns an invalid page, then that in
itself is a bug that needs to be fixed and probably has far reaching
implications for the stability of the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

