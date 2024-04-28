Return-Path: <linux-kernel+bounces-161353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E828B4B10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98811F21631
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388356477;
	Sun, 28 Apr 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GmK7mhrS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0158119;
	Sun, 28 Apr 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298074; cv=none; b=uFpTpL1IbOoDr84tAF1yGr2jphO0iHkXD+nyczqBS/gyWChJ2IGsScAHO9RqzWXYnBKbJaWpFqJedLDUmWdzu/acZyepldnXzfgbUw35/bMmbSnQklhd9LQ1BOWFYAlQRZe6mpUneoPovt2VDYUg+SJM+yA+GpKW7gOOcbhuhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298074; c=relaxed/simple;
	bh=ZKEooElUNK3TkVRIspPkZo1HoG4K7qCTaSSjuc4fCYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njJUJB7Acl3NhXzX7B2hLV3cwlvJsZcse4f0XM0XmE9FVISMMGURP85A5wXcZ0zPUtNa2Zs0gu1ROEpunevZf3dOSBo01pfqqSApWSaszZESrCpvTJxViTRvgohrKA+f3oJ4KgPQhQr9EXpQs39LkgL/PKkMk43XB+dvV3XSduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GmK7mhrS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6962F40E0249;
	Sun, 28 Apr 2024 09:54:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3htPu7eUVqiK; Sun, 28 Apr 2024 09:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714298063; bh=QAK+F1n6YdN369aP1zf89r+8yaJQmtbbGPXiaMt5ELs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmK7mhrSsZBpkV+ab9wViW9V16BnUrWOEC7YO+apnie+WJek9EflrygCI+tj7f6Fv
	 8RbUbmILO9Vl5HFT0pjaM0fioHkcJy8J/yCvfb5i/fxHoWF6UI5msEFdNOdSRYUmBt
	 a41tce2npDjJqWjmeT+OV/Y3nrzLkzwwu+IR9fYMDkFVjKfAw4F5wAGig8epmZXUVK
	 MTNteNq7XVeBVYTQdBPTZzHquWghccYIU8FBYE0DWTC5mlWE/1HM3dt4JWMc1Jh+/v
	 nlyKvwse1gh9EKbVgFMsABJeFW8SR0YcIeRJfLQE/k7Rc9ogFNiDG5iJlBJ2M4yBoi
	 NKZfUYs0t1Hj3enL3AuGveuswS7anf0dZLJcsCfCshiflBrv5f0fVZk4k6owEW0zbV
	 gSiFTAaUpNh3ygusQE3imuqS7v9CChtpPl02V6LShskxUwVToljDE9fLdHjN+ebOZR
	 yuVFWOM3JAmXbBXbs24XkrWmA6584iloHPU7MjocglWFlle3hXGwTc1aw3qSfnJ5lx
	 Fsloi7jr/ajPIy8AzNw/PcnzUSb5vOqIwqQTspRk2Fv0A6TAps3TfDEQVqh1j94RQC
	 cU+oacjEfbT5gv5rPjkykM8i/nT5KSb06YmNyd74rvJ5+vzgWq/n7CaBE97QUnCgWp
	 nsqCcBYd9lvZGMuvIws/I5Jg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F19440E016B;
	Sun, 28 Apr 2024 09:54:16 +0000 (UTC)
Date: Sun, 28 Apr 2024 11:54:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: linux-pm@vger.kernel.org, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, ray.huang@amd.com, Perry.Yuan@amd.com,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Message-ID: <20240428095409.GAZi4cwYxRwQGW_WFq@fat_crate.local>
References: <20240428091133.592333-1-Xiaojian.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240428091133.592333-1-Xiaojian.Du@amd.com>

+ lkml

On Sun, Apr 28, 2024 at 05:11:32PM +0800, Xiaojian Du wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Some AMD Zen 4 processors support a new feature FAST CPPC which
> allows for a faster CPPC loop due to internal architectual
> enhancements. The goal of this faster loop is higher performance
> at the same power consumption.
> 
> Reference:
> Page 99 of PPR for AMD Family 19h Model 61h rev.B1
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/56713-B1_3_05.zip

This should say "See the PPR for AMD Family 19h Model 61h rev.B1, docID
56713" so that people can actually find it.

The URLs are flaky and change regularly so can't use them.

> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)

Always use ./scripts/get_maintainer.pl when sending a patch to know who
to Cc.

Also, have a look at those to get an idea how the process works:

https://kernel.org/doc/html/latest/process/development-process.html
https://kernel.org/doc/html/latest/process/submitting-patches.html

> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..6c128d463a14 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -470,6 +470,7 @@
>  #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
> +#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index af5aa2c754c2..9c273c231f56 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
>  

With the above addressed:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

