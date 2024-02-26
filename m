Return-Path: <linux-kernel+bounces-81206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900A8671FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A13E1F25F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD21CD32;
	Mon, 26 Feb 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g6HOrIAM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD41C6B5;
	Mon, 26 Feb 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944419; cv=none; b=JkcJKh3yQ/1DWnxmmymW++abKZivKszT/sTqTGdR1B8YVsYMt9iSJ2vMObGOMamoF402s2OJnMeVy8mIoJ0/bb6u9av/euqOTcIH7hNfUTnQIqU9V3qoz4jwVxSplcVG4SXha3wwQAJeNZo0Ov64///1sqZPaviDK91FaHEgcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944419; c=relaxed/simple;
	bh=h0CHJQF50KwK8mIjEWCRDsj1eq3eD3C/obvTaUXkT3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn1UOFl/EIHyqk4UYIPgqJ9HWWTmKEUfvobplzOkR32/NHTSfeihTZ+B3FIsjOQ4w8VllkwYDoPDbK3ZL1VaDpaD2HfrORYk4Ja+cchziUsNAXhtqGe+0rdez4R1CoGOOg07Y8jXBnbuT09mjgIwYzVMIo3P3h04/4kUEqdubCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g6HOrIAM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F4E240E00B2;
	Mon, 26 Feb 2024 10:46:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U7uW1zKRoeoK; Mon, 26 Feb 2024 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708944411; bh=0CUdEbnigVU9mXxGYVPNrIQnBDNCqMVq2aXpPsduCD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6HOrIAMBI/QdrQCHnh6KLtisQeavnbe4CIRbk5nJQZFObd2N2xPrKOGuXqYMg2t6
	 P4Dmj/wJwv1rYMqLn+i4zxnBWaBG9Cebrj+lVhkKl9vyQj4rZ4RpjExeUQsEgNqwER
	 2PLB98axkXAIPxgZ/CW5yxyV3w7usK4m/N4N82rR1SPvO3mJsmJ17Y44w5CGu4wEeq
	 c/schnPIPTJrw3nOlbFi53BoJXIKJLmF/0L6NWbCMn0lZV7LkHJqla5KSSPh+Ke8Qz
	 rdBfvZoNA1H+jP0+DXhiI+9iRBWMEuUMPl/eBi3ghQpJeRebfYNN9sPRZXoFyjZet5
	 HSTuZ57hFy4M0Ym+SYqOyeL030DoTjKmHdhiI5wH9RTGzz/Ai+E/Q6YIeAFAiTz/TB
	 +WvD6mlU5YujNYju/yyQfYjp/u+xLdEi8MV0NgOHozqGiHAd70X+cTrQxWco86YUZs
	 lTh4PKq+w3p16TNk2UPgqxUA4Q+zQ8w7VZ9xr8pVsZDI0Fg6+jfplM2ilB8u4VrBz9
	 ii9/B6ZZ0aoHI/ZVNJm/mh6g4lLPALdPmSoVPo+vLbMHiEhw3VSdleofAGMfkSVQhB
	 BsFAwm40e2IREa1nZCNfc28OgNKKSQ8a0g+2Ul+RVN8/fqPrLxe9cspumL6YxgnBRD
	 piQBTNX/Di/raOX/POmXs3HY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA82840E0196;
	Mon, 26 Feb 2024 10:46:18 +0000 (UTC)
Date: Mon, 26 Feb 2024 11:46:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v11 2/3] mm: memory-failure: move return value
 documentation to function declaration
Message-ID: <20240226104611.GCZdxr82q-Wcms7R3S@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204080144.7977-3-xueshuai@linux.alibaba.com>

On Sun, Feb 04, 2024 at 04:01:43PM +0800, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 9 +--------
>  mm/memory-failure.c            | 9 ++++++---
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index bc39252bc54f..822b21eb48ad 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1365,17 +1365,10 @@ static void kill_me_maybe(struct callback_head *cb)
>  		return;
>  	}
>  
> -	/*
> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
> -	 * to the current process with the proper error info,
> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
> -	 *
> -	 * In both cases, no further processing is required.
> -	 */
>  	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>  		return;
>  
> -	pr_err("Memory error not recovered");
> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");

Unrelated change.

>  	kill_me_now(cb);
>  }
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 636280d04008..d33729c48eff 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2175,9 +2175,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   * Must run in process context (e.g. a work queue) with interrupts
>   * enabled and no spinlocks held.
>   *
> - * Return: 0 for successfully handled the memory error,
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + * Return values:
> + *   0             - success
> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
> + *   -EHWPOISON    - sent SIGBUS to the current process with the proper
> + *                   error info by kill_accessing_process().

kill_accessing_process() is not the only one returning -EHWPOISON.

And if you look at the code, it should be:

	-EHWPOISON	- the page was already poisoned, potentially
			kill process

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

