Return-Path: <linux-kernel+bounces-97901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84E877158
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92941C20A0C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC93BBE4;
	Sat,  9 Mar 2024 13:24:32 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429C36AF9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990672; cv=none; b=iu2GJc1N3fvyMEMmkMVdXkgwmW/UOjnVmZbengzmHAW4EgsDJUlSlaPUIaB98n1fk2LHXowopLT5i/k8lI4tQg2brcj5w9/s6t7Gk262xKtrEhh+45mJKj9Z/hd4Aj+FkjMrB2FhIOXfKDjbwEHjyhvnHQAl72jjGdLx1LoNKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990672; c=relaxed/simple;
	bh=DZAXdDJegZdcErY4U3Wlr5RwaMFdtP3+j0WDzDiIPzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NsE4kpq1DqZ7oeFqFSUqsA0SxkvyLTXWySuD6cMjEU316S6oFBtFU4abHnSM4Bj53agNhYbumULuFMKmwDGI2uSvlNy8sbmuWjko+pvZBHHOqXFZ1ichgYcGVDTdthk1QXfAMf01uB2URqNg3974Z3CmJozftk6pgS30hjnvK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TsNz50hyKz3F0D3;
	Sat,  9 Mar 2024 21:23:45 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id A42571A016C;
	Sat,  9 Mar 2024 21:24:26 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 21:24:26 +0800
Message-ID: <346e15e5-49e9-4a7f-b163-c3316225baab@huawei.com>
Date: Sat, 9 Mar 2024 21:24:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Fangrui
 Song <maskray@google.com>
CC: Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
	<llvm@lists.linux.dev>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
 <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/9 16:20, Arnd Bergmann wrote:
> On Sat, Mar 9, 2024, at 07:14, liuyuntao (F) wrote:
>> On 2024/3/8 21:15, Arnd Bergmann wrote:
>>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>>
>> Thanks for the tests, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and
>> CONFIG_TRIM_UNUSED_KSYMS do indeed result in a significant improvement.
>> I found that arm32 still doesn't support CONFIG_LTO_CLANG. I've done
>> some work on it, but without success. I'd like to learn more about the
>> CONFIG_LTO_CLANG patch. Do you have any relevant links?
> 
> I did not try to get it to boot and gave up when I did not see
> any size improvement. I think there were previous attempts to
> do it elsewhere, which I did not try to find.
> 

I tested this patch, the size improvement was only about one 
ten-thousandth, and the compilation time had increased by about a quarter,
and the kernel did not boot.

Strangely, LTO has actually increased the compilation time 
significantly, which seems contrary to its purpose.

           +          +trim      +dce       +trim+dce
no lto    5995384    5858720    5841024    5299032
lto       5990040    5854544    5839992    5289576
shrink    8.9‱     7.1‱     1.7‱     17.8‱


           +          +trim      +dce       +trim+dce
no lto    34.616     33.03      36.093     32.211
lto       46.881     45.324     47.247     43.246
increase  26.20%     27.10%     23.60%     25.50%



> The patch below makes it build, but it still requires disabling
> CONFIG_THUMB2_KERNEL, which totally defeats the purpose of shrinking
> the kernel as it adds some 40% size overhead in the vmlinux.
> There are probably also runtime bugs that get introduced by this.
> 
>       Arnd
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index de78ceb821df..7ebfda4839e8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2,6 +2,8 @@
>   config ARM
>   	bool
>   	default y
> +	select ARCH_SUPPORTS_LTO_CLANG
> +	select ARCH_SUPPORTS_LTO_CLANG_THIN
>   	select ARCH_32BIT_OFF_T
>   	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
>   	select ARCH_HAS_BINFMT_FLAT
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 726ecabcef09..f2ddce451ab9 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -9,6 +9,8 @@ OBJS		=
>   
>   HEAD	= head.o
>   OBJS	+= misc.o decompress.o
> +CFLAGS_REMOVE_misc.o += $(CC_FLAGS_LTO)
> +CFLAGS_REMOVE_decompress.o += $(CC_FLAGS_LTO)

Wow, I've encountered this issue before and didn't think to solve it in 
this way. You really have a thorough understanding of these parameters. 
On a side note, if CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, but 
only a few rodata sections are removed and no functions are eliminated, 
are there any compiler or linker options that can control this behavior?
thanks.

>   ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
>   OBJS	+= debug.o
>   AFLAGS_head.o += -DDEBUG
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index d19d140a10c7..aee9e13023a8 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -38,15 +38,14 @@ EXPORT_SYMBOL(arm_heavy_mb);
>   static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
>   {
>   	unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
> -	const int zero = 0;
>   
>   	set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
>   
> -	asm(	"mcrr	p15, 0, %1, %0, c14\n"
> -	"	mcr	p15, 0, %2, c7, c10, 4"
> +	asm("mcrr	p15, 0, %1, %0, c14"
>   	    :
> -	    : "r" (to), "r" (to + PAGE_SIZE - 1), "r" (zero)
> +	    : "r" (to), "r" (to + PAGE_SIZE - 1)
>   	    : "cc");
> +	dsb();
>   }
>   
>   static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned long len)
> @@ -68,11 +67,11 @@ void flush_cache_mm(struct mm_struct *mm)
>   	}
>   
>   	if (cache_is_vipt_aliasing()) {
> -		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
> -		"	mcr	p15, 0, %0, c7, c10, 4"
> +		asm("mcr	p15, 0, %0, c7, c14, 0"
>   		    :
>   		    : "r" (0)
>   		    : "cc");
> +		dsb();
>   	}
>   }
>   
> @@ -84,11 +83,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
>   	}
>   
>   	if (cache_is_vipt_aliasing()) {
> -		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
> -		"	mcr	p15, 0, %0, c7, c10, 4"
> +		asm("mcr	p15, 0, %0, c7, c14, 0"
>   		    :
>   		    : "r" (0)
>   		    : "cc");
> +		dsb();
>   	}
>   
>   	if (vma->vm_flags & VM_EXEC)

