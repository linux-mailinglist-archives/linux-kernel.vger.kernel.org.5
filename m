Return-Path: <linux-kernel+bounces-122079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F36188F19A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0729F522
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872CC15359D;
	Wed, 27 Mar 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WKOkK7ii"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80553371;
	Wed, 27 Mar 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577148; cv=none; b=XgHAoWKHzSiWuOd4KsE17rGerZ27AT7q4Hx1lg6xAbwXvLrC22unV3aN7nBA0QlgnBT97zlNX8xssuzmhrURJKO/QMbD1tYqhfaTpNlbdrHIyMHJqhUK6BGzNLjG8rMFRW9Za75sC1T2wvilyQLDsCTKU1+O1sE+aPkLDa/hsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577148; c=relaxed/simple;
	bh=YzILXHjFa/ZXKRdkR8oHCfg7TLj7bpLAR4UQ4xtKTPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMje1sneSTKK1OK/TI3wbwoSsSlr5sY4bC2R1dInBFBledy6rVSe/lLWKkrfJ7NtuZyGTWRH+OhSmNBGn2ce0JQwJGLl61kRThBzfDB7aFf0VOX3ohnsg1syYsLZYCasUT5tMedCVJtamAxR8I1lvubWt8M9hVA+Q6cInoPySWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WKOkK7ii; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E34340E0028;
	Wed, 27 Mar 2024 22:05:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 47E9gBI1hb46; Wed, 27 Mar 2024 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711577133; bh=KoJxz82rh44Frbd66xYyNWzi04WmMupxpevxjId6qHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKOkK7ii4Ke2PmfpcW4fTtRth0x2wqbPYy0T2/g0AePIWrL0ijNfGCQMhOy4ggVmv
	 7FkQ4gNmh5yWWWN1GqQfNXP4gKxTQXCcWv16r26kW05FeidVhTFLgL3JeQy4xOI/ez
	 xYYODcy4LUHITiNqwvqdl3IB9pstOEw4qlZYsovBuVMlrFrl3/QwUjWG7BLXuAY5Y5
	 nK/pVRWlIGyXLj4aV5B9KZqP5U4ylEAzjWQrSeux9PozwIxnnpVJNAKOjJKsFU7E+k
	 TlMuZLuCIIl+OKYLAPRD7FcIll6lMMKII2PfRP9vxoUZHHPiHHGw6To8/Ucg5rIY4R
	 X/8j6N75EfzSE2Yyn6beoQf9tPyuLEs7jdGfY+XHIME3FkmTJI7BYj9SC2gU/QDc9U
	 +sRvaz++T2ebH9SVOSE+L34J332JRMVKTQ9T5BlFhWapu7FJLllkKovwAzTgcMRF8P
	 g4gNWftA3ktaunoJNwMA69KQABrhtQCu0TBOgRBV02/uBvMB1GVsLR9TetvTUGE/7B
	 LcH9obvMZeDt5SwoboFInoCYz01dABzeOwI1BvMW6NfEUK9FhlAMYd5dRxOe88IatV
	 WbkwWgH0JUktFfP9T8t84mY53q2juJt3imJpkDyei3L8k8NReb3oqZcq2SBtI0ra+8
	 O8bzYKzEwwnJ3bJkpg8QUYVU=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8811E40E016C;
	Wed, 27 Mar 2024 22:05:17 +0000 (UTC)
Date: Wed, 27 Mar 2024 23:05:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for
 DEFAULT_MCE_SAFE exception
Message-ID: <20240327220511.GCZgSYF6lJ3U1CaKV0@fat_crate.local>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
 <20240204082627.3892816-3-tongtiangen@huawei.com>
 <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
 <100198dd-320f-68e6-9c09-210620940a74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <100198dd-320f-68e6-9c09-210620940a74@huawei.com>

On Sun, Feb 18, 2024 at 06:08:14PM +0800, Tong Tiangen wrote:
> 1. The copy_mc_to_kernel() is used in the coredump, KSM, and COW
> scenarios, in these scenarios, the src mem stores the user data and the
> kernel use kernel address to access the src mem(using kmap()).
> 
> 2. the src mem of copy_mc_to_user() is currently only used by the DAX:

You mean just because it currently is used somewhere which probably is
ok - no clue what DAX does - and even if the source address is still
*kernel* memory and even at the danger that someone else might use it in
the future and think the handling on a potential #MC is ok, you're still
arguing that this is the right thing to do perhaps because it fits your
use case?!

Sorry Tiangen, not gonna happen.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

