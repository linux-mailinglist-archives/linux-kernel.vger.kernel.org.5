Return-Path: <linux-kernel+bounces-154852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4328AE1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF40CB2223E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F960EC3;
	Tue, 23 Apr 2024 10:23:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB48612F5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867812; cv=none; b=nly0lx5oOiLdX6qwr3shkt2mtQa7ELFygPbTS53X9U05IhA6O68xNjqjFnqJxbMr2pfc5gGIb4xpiGlzSoRyf+eNhHTFEBSMBOGwA8o9GByWH3Fl9C8Y9Z4uOvOYnrOd2qegFzqyUM0kCi7dVf6TMo6+vWI8pZk8gDSIyO090bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867812; c=relaxed/simple;
	bh=ELRQr6RtqQYJFI/SFoM76BP3ioUCL9EocA03mTgdp08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7/3iXTz71PW7txPMIB6dF4GUOB/ZbGZAcaxDZBRKxunP0hd2qvIoGqOOeJ2+hPaduvb0M62h4/0U1YQt/Mmj/no7GVqWGFl07bBzF4VN/iqsvvMWkmlBHdls3LExxnb7cVBYTlICY0TTSkH1tVW2kbeRVNB1uaJg3YHOuOW91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-45-66278c1d8dc1
Date: Tue, 23 Apr 2024 19:23:20 +0900
From: Byungchul Park <byungchul@sk.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	jbohac@suse.cz, dyoung@redhat.com
Cc: kernel_team@skhynix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/e820: apply 'mem=' boot command while reserving
 memory using boot_params
Message-ID: <20240423102320.GA47818@system.software.com>
References: <20240423101323.40968-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423101323.40968-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnoa5sj3qawYWDyhafN/xjs3ixoZ3R
	omFiA4vFtI3iFjcObmazuLxrDpvFpQMLmCw2b5rKbPFjw2NWB06P7619LB6bVnWyebw7d47d
	Y97JQI/3+66yeZxZcITd4/MmOY8TLV9YAziiuGxSUnMyy1KL9O0SuDJmnZ3FWNAkWvGp+zZT
	A+M9gS5GTg4JAROJrjfH2WHsrfM+M4HYLAKqEi9m3GIFsdkE1CVu3PjJ3MXIxSEiMJNRYtOD
	IywgCWYBS4l5t46BNQgLJEus/DYZLM4rYCExd8MssLiQgKnE7XePGSHighInZz6B6tWSuPHv
	JVANB5AtLbH8HwdImFPATGLN1G6we0QFlCUObDvOBLJXQuAMm8TzSb9YIA6VlDi44gbLBEaB
	WUjGzkIydhbC2AWMzKsYhTLzynITM3NM9DIq8zIr9JLzczcxAmNhWe2f6B2Mny4EH2IU4GBU
	4uFl+KWWJsSaWFZcmXuIUYKDWUmE99cflTQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOE
	BNITS1KzU1MLUotgskwcnFINjPVHHv9Mn8l4KuusXKlp9I9nG+2TKiL+pnk03viyVX2Dkpem
	ReHW2f//P825Ls1VlDw56wWXwEmp723FXot4bO1m9U9avrpo6w7to++Mchc5R83d9+2N7g+v
	jYqPaq4+qPhQbHHxPoPr/r+VS66edhHeYrvpBcP7pZe+9LvkrdN9xvXh8opfIdeUWIozEg21
	mIuKEwElqnr0gQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrCvbo55msK9L2OLzhn9sFi82tDNa
	NExsYLGYtlHc4sbBzWwWh+eeZLW4vGsOm8WlAwuYLDZvmsps8WPDY1YHLo/vrX0sHptWdbJ5
	vDt3jt1j3slAj/f7rrJ5LH7xgcnjzIIj7B6fN8l5nGj5whrAGcVlk5Kak1mWWqRvl8CVMevs
	LMaCJtGKT923mRoY7wl0MXJySAiYSGyd95kJxGYRUJV4MeMWK4jNJqAucePGT+YuRi4OEYGZ
	jBKbHhxhAUkwC1hKzLt1DKxBWCBZYuW3yWBxXgELibkbZoHFhQRMJW6/e8wIEReUODnzCVSv
	lsSNfy+BajiAbGmJ5f84QMKcAmYSa6Z2s4PYogLKEge2HWeawMg7C0n3LCTdsxC6FzAyr2IU
	ycwry03MzDHVK87OqMzLrNBLzs/dxAgM7GW1fybuYPxy2f0QowAHoxIP749PamlCrIllxZW5
	hxglOJiVRHh//VFJE+JNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl
	4uCUamBU6ZrxSfuCYaxF2AZ2+TeGPD+LjP8ukldtdj99Z3v/6fXG+SwLxI7dr/I1t20s3bOs
	5O2K6iAPZYU1vW4a5c+DDio6yTh/mjj7zRlvvuPeZ6JKvheEFHgdO7H11vLn01dK87pWla16
	NWmpXkHw/5XxkVkhN/glal5kpZ9hV5rlECXr4LS7QUaJpTgj0VCLuag4EQDgnqKaaAIAAA==
X-CFilter-Loop: Reflected

On Tue, Apr 23, 2024 at 07:13:23PM +0900, Byungchul Park wrote:
> I might miss something.  Please lemme know if I go wrong.  Thanks.
> 
> 	Byungchul
> 
> --->8---
> >From 51f3b5b9bf9685aa431c00908771151edd702483 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 23 Apr 2024 18:54:48 +0900
> Subject: [PATCH] x86/e820: apply 'mem=' boot command while reserving memory
>  using boot_params
> 
> When a user specifies 'mem=' boot command, it's expected to limit the
> maximum address of usable memory for the kernel no matter what the
> memory map source is.  However, 'mem=' boot command doesn't work since
> it doesn't respect it when reserving memory using boot_params.
> 
> Applied the restriction when reserving memory using boot_params.  While
> at it, renamed mem_size to a more specific name, boot_mem_limit.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  arch/x86/kernel/e820.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 6f1b379e3b38..af9d1d95ef5a 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
>  
>  static int userdef __initdata;
>  
> +static u64 boot_mem_limit = U64_MAX;
> +
>  /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
>  static int __init parse_memopt(char *p)
>  {
> -	u64 mem_size;
> -
>  	if (!p)
>  		return -EINVAL;
>  
> @@ -899,16 +899,16 @@ static int __init parse_memopt(char *p)
>  	}
>  
>  	userdef = 1;
> -	mem_size = memparse(p, &p);
> +	boot_mem_limit = memparse(p, &p);
>  
>  	/* Don't remove all memory when getting "mem={invalid}" parameter: */
> -	if (mem_size == 0)
> +	if (boot_mem_limit == 0)

I should've handled the case that the return value is 0.  I will fix it.
Before going ahead, it'd be appreciated to tell if this approach is
correct. Thank you.

	Byungchul

>  		return -EINVAL;
>  
> -	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
> +	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit, E820_TYPE_RAM, 1);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -	max_mem_size = mem_size;
> +	max_mem_size = boot_mem_limit;
>  #endif
>  
>  	return 0;
> @@ -1036,6 +1036,8 @@ void __init e820__reserve_setup_data(void)
>  		early_memunmap(data, len);
>  	}
>  
> +	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
> +			E820_TYPE_RESERVED_KERN, 1);
>  	e820__update_table(e820_table);
>  
>  	pr_info("extended physical RAM map:\n");
> -- 
> 2.17.1

