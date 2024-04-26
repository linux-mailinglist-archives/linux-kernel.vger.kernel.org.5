Return-Path: <linux-kernel+bounces-159504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA25B8B2F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16131C21DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48418139D10;
	Fri, 26 Apr 2024 04:40:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608896A8BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106437; cv=none; b=iWU5giyWcZo6p6i6r2Z3ZkkfRWXff7qyNJRihwHBBmv7LtJiG41OwkEstyCVpSLAlYvmUuUyXdAQQlOLNhYuwrbFRXolkNs0wxmKu2A+CbwlGxca+aC1J0pXRsifdQw5mQIXFK9vL9Uwsf4IOQQhN5b7zkpC0iJYvgRRYbcjD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106437; c=relaxed/simple;
	bh=LKzAAoMk7CnCMTXuFyijTnjUoxKHqGLXRu1RWK05HS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmyxa+g24JPuvW+gJsTccSQjV3+FbrrmP5X7K15FW6YQGCaNVKwqsZDYvNTxicbhdgapQ+5GL/5cKCL7oRNgWuEwHQSwsYgdFVF+X0s1+eNCEXRSj0DE0z/QFoRqfegRBhGTQzpJwSh1ZFi2wa36p/qi+qpWXO5ge3NNuefdRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-12-662b30387bbf
Date: Fri, 26 Apr 2024 13:40:18 +0900
From: Byungchul Park <byungchul@sk.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	jbohac@suse.cz, dyoung@redhat.com
Cc: kernel_team@skhynix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving
 memory using boot_params
Message-ID: <20240426044018.GA24557@system.software.com>
References: <20240423102320.GA47818@system.software.com>
 <20240424010313.25264-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424010313.25264-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXC9ZZnoa6FgXaaQcMCEYvPG/6xWbzY0M5o
	0TCxgcVi2kZxixsHN7NZXN41h83i0oEFTBabN01ltvix4TGrA6fH99Y+Fo9NqzrZPN6dO8fu
	Me9koMf7fVfZPM4sOMLu8XmTnMeJli+sARxRXDYpqTmZZalF+nYJXBlnLtxlL9itVrF2tlMD
	4xO5LkZODgkBE4mVj6Yyw9hdd/+zgdgsAqoSHS8OMILYbALqEjdu/ASq4eIQEZjJKLHpwREW
	kASzgKXEvFvHmLoYOTiEBdIkZs7kAAnzClhIvGxoBesVEkiR+P1qOTNEXFDi5MwnUK1aEjf+
	vQRrZRaQllj+D6yVU8BMYu6mTWAniAooSxzYdpwJZK2EwBk2iRlPLzNC3CkpcXDFDZYJjAKz
	kIydhWTsLISxCxiZVzEKZeaV5SZm5pjoZVTmZVboJefnbmIExsGy2j/ROxg/XQg+xCjAwajE
	w/siQytNiDWxrLgy9xCjBAezkgjvzY8aaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJ
	pCeWpGanphakFsFkmTg4pRoYe3i0inawf9HSWLKiez/3ZJk8f37npSdO3n3ML+YV4bqee6JT
	csOcal2JXVw/uQ8dX3/2/pXXaQ+uJH5kvKfStHHLviwFx2jmnNlZFrLTZhm+SphpnSO3wP3F
	/OIDMpYsLBt+/7/S+edvpOSe8w6Wvxm1j6c9m/Bepo7XvJBDs+GFCXuU309TJZbijERDLeai
	4kQA+H+qZ38CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC5WfdrGthoJ1msH8Hp8XnDf/YLF5saGe0
	aJjYwGIxbaO4xY2Dm9ksDs89yWpxedccNotLBxYwWWzeNJXZ4seGx6wOXB7fW/tYPDat6mTz
	eHfuHLvHvJOBHu/3XWXzWPziA5PHmQVH2D0+b5LzONHyhTWAM4rLJiU1J7MstUjfLoEr48yF
	u+wFu9Uq1s52amB8ItfFyMkhIWAi0XX3PxuIzSKgKtHx4gAjiM0moC5x48ZP5i5GLg4RgZmM
	EpseHGEBSTALWErMu3WMqYuRg0NYIE1i5kwOkDCvgIXEy4ZWsF4hgRSJ36+WM0PEBSVOznwC
	1aolcePfS7BWZgFpieX/wFo5Bcwk5m7aBHaCqICyxIFtx5kmMPLOQtI9C0n3LITuBYzMqxhF
	MvPKchMzc0z1irMzKvMyK/SS83M3MQKDelntn4k7GL9cdj/EKMDBqMTD+yJDK02INbGsuDL3
	EKMEB7OSCO/NjxppQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJM
	HJxSDYyypXbhhawRDFfXPbjRp+DxaUlj9639mk+TIv5Vn4r/ctBn9v5vt6tZny08tdC5KoWf
	58C6mWs+LpH+2vH1ZElXVeI3H0uPrNxgj/PLHMslZvyq/Pmv5b//mV/9srtfaU7eUuS++6Vt
	7XTmHebXPgfcbxRbk7fTb/ruDhFNfvUXE9y3pP/uap2pxFKckWioxVxUnAgACEcMP2YCAAA=
X-CFilter-Loop: Reflected

On Wed, Apr 24, 2024 at 10:03:13AM +0900, Byungchul Park wrote:
> I might miss something.  Please lemme know if I go wrong.  Thanks.

I started to work on it since I wanted to limit memory boundary using
'mem=' boot command but it doesn't work.  However, while looking around
the code in more detail, I found the issue is about which one should
have higher priority between:

   1. boot command limiting memory boundary e.g. 'mem=',
   2. setup data of memory map from bootloader, boot_params.

Based on the current code, setup data from bootloader has higher
priority than boot command so the setup data can overwrite the user
defined limit specified in boot command.  Is it inteded?

   If yes, I should stop posting.
   If not, I will keep posting with the following - v3.

	Byungchul

---

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..3bc593235b76 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -879,6 +879,7 @@ static void __init early_panic(char *msg)
 }
 
 static int userdef __initdata;
+static u64 userdef_mem_limit;
 
 /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
 static int __init parse_memopt(char *p)
@@ -905,7 +906,10 @@ static int __init parse_memopt(char *p)
 	if (mem_size == 0)
 		return -EINVAL;
 
-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+	if (userdef_mem_limit)
+		userdef_mem_limit = min(userdef_mem_limit, mem_size);
+	else
+		userdef_mem_limit = mem_size;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 	max_mem_size = mem_size;
@@ -966,7 +970,10 @@ static int __init parse_memmap_one(char *p)
 		else
 			e820__range_remove(start_at, mem_size, 0, 0);
 	} else {
-		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+		if (userdef_mem_limit)
+			userdef_mem_limit = min(userdef_mem_limit, mem_size);
+		else
+			userdef_mem_limit = mem_size;
 	}
 
 	return *p == '\0' ? 0 : -EINVAL;
@@ -1050,6 +1057,11 @@ void __init e820__reserve_setup_data(void)
 void __init e820__finish_early_params(void)
 {
 	if (userdef) {
+		if (userdef_mem_limit)
+			e820__range_remove(userdef_mem_limit,
+					ULLONG_MAX - userdef_mem_limit,
+					E820_TYPE_RAM, 1);
+
 		if (e820__update_table(e820_table) < 0)
 			early_panic("Invalid user supplied memory map");
 
---
> 	Byungchul
> 
> Changes from v1
> 	1. before - handle boot_mem_limit assuming the default is U64_MAX.
> 	   after  - handle boot_mem_limit assuming the default is 0.
> 
> --->8---
> >From e8bf247d6024b35af5300914dcff9135df9c1d66 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Wed, 24 Apr 2024 09:55:25 +0900
> Subject: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving memory using boot_params
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
>  arch/x86/kernel/e820.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 6f1b379e3b38..e3f716128caf 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
>  
>  static int userdef __initdata;
>  
> +static u64 boot_mem_limit;
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
> @@ -1036,6 +1036,9 @@ void __init e820__reserve_setup_data(void)
>  		early_memunmap(data, len);
>  	}
>  
> +	if (boot_mem_limit)
> +		e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
> +				E820_TYPE_RESERVED_KERN, 1);
>  	e820__update_table(e820_table);
>  
>  	pr_info("extended physical RAM map:\n");
> -- 
> 2.17.1

