Return-Path: <linux-kernel+bounces-14928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E1822495
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713FA1C22BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4D1772C;
	Tue,  2 Jan 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M7NvOkhZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85117725
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso461084839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704233585; x=1704838385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZIPZDZt4oBEd0SnkIce+xeSPolQ5Jz9+CEZQYYyTK/Y=;
        b=M7NvOkhZndNiFWLZzca4jSWp9IWxNzMVjG3VSgj+0NEkre8ZF7i/TTbx8nwQc5t83Z
         GJOEMZaYJh2/1AHxIKz2/n4myoLbT6MZOfIHwUDc9+9ToCTlRNs7VUKe/qDi83p1OrXc
         JPNPU7kB2L8Lu/QekR2sRydd/bNWkWWwwmMn9SJUGFz+Qlq6SuS1Oi+SdKgVXKcSzgO7
         S5lfBVIB5EbnjdSS1IMfyFx5NWlIMLd2HPpje719FqKoXi3YZtFiXXWnGuzmq/6Yn/Wm
         BXdp9kbkq3rBS41M7XbLiYTD6HDqzh+fvWvStlWR25zw85VSUW0f9MF3FfXkYltFWnIp
         t3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233585; x=1704838385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIPZDZt4oBEd0SnkIce+xeSPolQ5Jz9+CEZQYYyTK/Y=;
        b=TJeYxbsXb+75Ze8VHsZkv5xLi9W42C/QAfm8ol8k0FPXgJBeNFIo6l2lnCISYhnpKL
         ZECShTc37N51AMxqH/do5BXC4og3GOjN2VunWDr+TWJs1uHiGgN0fXeNgCp8E0w5u0O+
         l4ZqvDa9OiYRzLf88YAqmEQdDnvxyRbqGg61UTlOa3WZzHaUSWpBYtZ3Yly5GOKUILpB
         Cho/n2/m4Ub0a06eYyuE57RslbK6tujkWzbQcDbmg7bytL+EyqSxFB3qv9pAgp+6wk9S
         7Rx7wPLFPmhoKFjtg3i7cqh2D+RdBCVQP631yrKDMAMu+Iwjs+aMd/nApZ3a/Q2Tw14/
         H4LQ==
X-Gm-Message-State: AOJu0Yzp4EtCWPSAV7zZZrQmD8dNB0Ww8L5Dusg1NnlVEjK57G9tOLHy
	GMpOItwDfgY+WW8ZPO8DQdRLKhRQ/2UmCgdlaniSHbLdvVY=
X-Google-Smtp-Source: AGHT+IF7xHbQKhOKiFpu7G+ldy8yhZ4y+CfLlr5t5QIvHMpys46zIJDC2W1uhpD5aAjANOWXWj5ZGg==
X-Received: by 2002:a6b:5802:0:b0:7ba:9b79:ab81 with SMTP id m2-20020a6b5802000000b007ba9b79ab81mr17054483iob.0.1704233584923;
        Tue, 02 Jan 2024 14:13:04 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:d426:c94f:f6fe:36b0? ([2605:a601:adae:4500:d426:c94f:f6fe:36b0])
        by smtp.gmail.com with ESMTPSA id t3-20020a02ab83000000b0046b15e4d5c7sm7011405jan.54.2024.01.02.14.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 14:13:04 -0800 (PST)
Message-ID: <9cd39ef1-9750-4e4d-9df1-3dad0a7ea015@sifive.com>
Date: Tue, 2 Jan 2024 16:13:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240102141851.105144-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240102141851.105144-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-01-02 8:18 AM, Alexandre Ghiti wrote:
> Allow to defer the flushing of the TLB when unmapping pges, which allows
> to reduce the numbers of IPI and the number of sfence.vma.
> 
> The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> batched/deferred tlb shootdown during page reclamation/migration") shows
> good performance improvement and perf reports an important decrease in
> time spent flushing the tlb (results come from qemu):
> 
> Before this patch:
> 
> real	2m1.135s
> user	0m0.980s
> sys	2m0.096s
> 
> 4.83%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range
> 
> After this patch:
> 
> real	1m0.543s
> user	0m1.059s
> sys	0m59.489s
> 
> 0.14%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range

That's a great improvement!

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/include/asm/tlbbatch.h | 15 +++++++
>  arch/riscv/include/asm/tlbflush.h | 10 +++++
>  arch/riscv/mm/tlbflush.c          | 71 ++++++++++++++++++++++---------
>  4 files changed, 77 insertions(+), 20 deletions(-)
>  create mode 100644 arch/riscv/include/asm/tlbbatch.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7603bd8ab333..aa07bd43b138 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -53,6 +53,7 @@ config RISCV
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_USES_CFI_TRAPS if CFI_CLANG
> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU

Is the SMP dependency because the batching is only useful with multiple CPUs, or
just because tlbflush.c is only compiled in SMP configurations (which is
resolved by [1])?

[1]:
https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holland@sifive.com/

>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> diff --git a/arch/riscv/include/asm/tlbbatch.h b/arch/riscv/include/asm/tlbbatch.h
> new file mode 100644
> index 000000000000..46014f70b9da
> --- /dev/null
> +++ b/arch/riscv/include/asm/tlbbatch.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +
> +#ifndef _ASM_RISCV_TLBBATCH_H
> +#define _ASM_RISCV_TLBBATCH_H
> +
> +#include <linux/cpumask.h>
> +
> +struct arch_tlbflush_unmap_batch {
> +	struct cpumask cpumask;
> +};
> +
> +#endif /* _ASM_RISCV_TLBBATCH_H */
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 8f3418c5f172..f0b731ccc0c2 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -46,6 +46,16 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end);
>  #endif
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +bool arch_tlbbatch_should_defer(struct mm_struct *mm);
> +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +			       struct mm_struct *mm,
> +			       unsigned long uaddr);
> +void arch_flush_tlb_batched_pending(struct mm_struct *mm);
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> +
>  #else /* CONFIG_SMP && CONFIG_MMU */
>  
>  #define flush_tlb_all() local_flush_tlb_all()
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index e6659d7368b3..bb623bca0a7d 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -93,29 +93,23 @@ static void __ipi_flush_tlb_range_asid(void *info)
>  	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>  }
>  
> -static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
> -			      unsigned long size, unsigned long stride)
> +static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +			      unsigned long start, unsigned long size,
> +			      unsigned long stride)
>  {
>  	struct flush_tlb_range_data ftd;
> -	const struct cpumask *cmask;
> -	unsigned long asid = FLUSH_TLB_NO_ASID;
>  	bool broadcast;
>  
> -	if (mm) {
> -		unsigned int cpuid;
> +	if (cpumask_empty(cmask))
> +		return;
>  
> -		cmask = mm_cpumask(mm);
> -		if (cpumask_empty(cmask))
> -			return;
> +	if (cmask != cpu_online_mask) {
> +		unsigned int cpuid;
>  
>  		cpuid = get_cpu();
>  		/* check if the tlbflush needs to be sent to other CPUs */
>  		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> -
> -		if (static_branch_unlikely(&use_asid_allocator))
> -			asid = atomic_long_read(&mm->context.id) & asid_mask;
>  	} else {
> -		cmask = cpu_online_mask;
>  		broadcast = true;
>  	}
>  
> @@ -135,25 +129,34 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  		local_flush_tlb_range_asid(start, size, stride, asid);
>  	}
>  
> -	if (mm)
> +	if (cmask != cpu_online_mask)
>  		put_cpu();
>  }
>  
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +	return static_branch_unlikely(&use_asid_allocator) ?
> +			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +}
> +
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> +			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>  }
>  
>  void flush_tlb_mm_range(struct mm_struct *mm,
>  			unsigned long start, unsigned long end,
>  			unsigned int page_size)
>  {
> -	__flush_tlb_range(mm, start, end - start, page_size);
> +	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> +			  start, end - start, page_size);
>  }
>  
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  addr, PAGE_SIZE, PAGE_SIZE);
>  }
>  
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> @@ -185,18 +188,46 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		}
>  	}
>  
> -	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  start, end - start, stride_size);
>  }
>  
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> +	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +			  start, end - start, PAGE_SIZE);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)
>  {
> -	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  start, end - start, PMD_SIZE);
>  }
>  #endif
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH

This condition is necessarily true if the file is being compiled.

> +bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	return true;
> +}
> +
> +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +			       struct mm_struct *mm,
> +			       unsigned long uaddr)
> +{
> +	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> +}
> +
> +void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> +{
> +	flush_tlb_mm(mm);
> +}
> +
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,

The batching appears to be limited to within a single mm, so we could save the
ASID inside struct arch_tlbflush_unmap_batch and use it here.

Regards,
Samuel

> +			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */


