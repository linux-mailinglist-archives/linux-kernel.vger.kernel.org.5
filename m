Return-Path: <linux-kernel+bounces-50657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC2847C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC541C23531
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66478592F;
	Fri,  2 Feb 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jFDFX3UJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD82839F2;
	Fri,  2 Feb 2024 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912570; cv=none; b=Xaq1HcL3SugLLQYsTnZq6caqkfwqvZqv7ZpcO7W39fSrEzIW1nvAbizAC1G65OfrsO7Om9sN/oWCZoHxtUYWMdQsG8W/H1p7jLIV/jcRWw4n95DrGH+WPRWefzwNDvu8Syc1L1kPK/8D0AOGD/TJdw+hNEDRj2BoOjb+wE+qYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912570; c=relaxed/simple;
	bh=4PZhvHo6uDCpPEVMml9xvzWJSuoXozqaUH+5H4e84BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrtDIx1ybBg0nfwp3PWuT7yfFGTLrPnBJf/A/7jQ1fIZu4fxzpjrP6VBoJl93W7BInBF/D40A47Wj6PiPqDV7kelQ5X2dvzJx649PNADwaO4pvVk9nPhU1qHPSc2I0VZnXDxoBD//0m28PBAw4/TnK9ogvheGNTLJSDk0EMH2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jFDFX3UJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B031B40E01A9;
	Fri,  2 Feb 2024 22:22:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ZSY74Yz66Xt; Fri,  2 Feb 2024 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706912562; bh=sNyqIbKGi0aGVOVLD44ssIoLe6QNqeVe9459dcb6Bvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFDFX3UJ3LdDOh3U9RxCfy+dLlli8OwkPJl6vDX+UDne+orVAQ2kB/SsYbVG0l+CH
	 iuM3/2vkYvZJjy4BUuriq1obO1sW2lDqM/wHIMxtdPdPhZyd5NIySH7J5FRIoAnUOi
	 3fTdZBufBCgpT7V4zin4UVfiHBKpak6dUTTWgL0VT1dqRTTbYEvXcWlWW4dXoHDuko
	 PUBhNg8KfqZJ8Z/PAZtZQkWwEbPPE0g+ZZDtbfOgpFsZgx/tY9rd3oC7F4wA5tymuP
	 Alsw8hkdgkmOCE2BU+TV5ZxhvO7Wm42+4zxg62zmBDE7FUaPoVhBjE7LwGOHh1Weq8
	 rTX/TlZUsQOtJFZkdQrAkGp6MXNQUpshH8ZBUHjDGiNy4gCiUl2Ij11bIi71a5MpCh
	 RP3kFmYrJS7ECjhILLBivwgh/fhJOfqqyFVG4A7lzUR8+HGDvK5gck2/UhBY83YSYu
	 6hIrqOeGmOHZ7bRoF1BvxBp8ODlzW+0O3Sh8rEslLATqbJlpNE0N83b5Cmxls2a0Ko
	 2xsjfW+p85wOQI0ZalJsCsj6r1wkZe0nsPzn90nrC3FCvlFTvqYhsn21vnAv88YV4T
	 5W0eM2fSxn++NnQyQ110Kg1fzh1orPW2Gf76lfBpTq/sFx/jB+iGZrjapP7fRiJOaX
	 6r9jrEyyWrMFnpjA0sf7xu7c=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1080040E00C5;
	Fri,  2 Feb 2024 22:22:26 +0000 (UTC)
Date: Fri, 2 Feb 2024 23:22:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
 <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Feb 02, 2024 at 09:36:27PM +0000, Luck, Tony wrote:
> There are two places in the pipeline where poison is significant.
> 
> 1) When the memory controller gets a request to fetch some data. If the ECC
> check on the bits returned from the DIMMs the memory controller will log
> a "UCNA" signature error to a machine check bank for the memory channel
> where the DIMMs live. If CMCI is enabled for that bank, then a CMCI is
> sent to all logical CPUs that are in the scope of that bank (generally a
> CPU socket). The data is marked with a POISON signature and passed
> to the entity that requested it. Caches support this POISON signature
> and preserve it as data is moved between caches, or written back to
> memory. This may have been a prefetch or a speculative read. In these
> cases there won't be a machine check. Linux uc_decode_notifier() will
> try to offline pages when it sees UCNA signatures.

Yap, deferred errors.

> 2) When a CPU core tries to retire an instruction that consumes poison
> data, or needs to retire a poisoned instruction. These log an SRAR signature
> into a core scoped bank (on most Xeons to date bank 0 for poisoned instructions,
> bank 1 for poisoned data consumption). Then they signal a machine check.

And that is the #MC on a poison data load thing. FWIW, the other vendor
does it very similarly.

> Partial cacheline stores to data marked as POISON in the cache maintain
> the poison status. Full cacheline writes (certainly with MOVDIR64B instruction,
> possibly with some AVX512 instructions) can clear the POISON status (since
> you have all new data). A sequence of partial cache line stores that overwrite
> all data in a cache line will NOT clear the POISON status.

That's interesting - partial stores don't clear poison data.

> Nothing is logged or signaled when updating data in the cache.

Ok, no #MC on writing to poisoned cachelines.

Ok, so long story short, #MC only on loads. Good.

Now, since you're explaining things today :) pls explain to me what this
patchset is all about? You having reviewed patch 3 and all?

Why is this pattern:

	if (copy_mc_user_highpage(dst, src, addr, vma)) {
		memory_failure_queue(page_to_pfn(src), 0);

not good anymore?

Or is the goal here to poison straight from the #MC handler and not
waste time and potentially get another #MC while memory_failure_queue()
on the source address is done?

Or something completely different?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

