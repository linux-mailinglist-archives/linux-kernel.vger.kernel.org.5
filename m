Return-Path: <linux-kernel+bounces-98426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBC8779EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC61F21919
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7E1364;
	Mon, 11 Mar 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PIybsOHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYgk8EXR"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F8EDB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710126425; cv=none; b=rTq8Gu/vD8dLWlpGt0zBqkGaEoULEx+SjcotDWnwfw+6xuU/GiUFZ/N+IzujXMASf6I/WV4gbNgeRcUIahiz78nw6HKZiEWFeLk93b+ISgv1BtPi7eFcXpwB9t+JxoJ3sKclP2AxP+Yw6TShiA/uxcYOwJKJ3a5eKyluamTatj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710126425; c=relaxed/simple;
	bh=iyntksdlyn7EEcYkpMmudCgFaKAmQTyu9ojS1b8KkCI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HXMhDGrHQBhAk28LITt1jAm4K+89aMhhSQ5krzz7wdehX/+mj4W5RwKWbLtxeipTr4HWoooWqULluOJujOwiUmmYSsUBjs4ueLBMw6Ih7lYwjTDFEkifqAsYiYraXg/p4Q1RIu88h1+F7XHIAer0f0i/Tx1swXF+RG3M4ZF+o8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PIybsOHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYgk8EXR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 726AC114008E;
	Sun, 10 Mar 2024 23:07:02 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 10 Mar 2024 23:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710126422; x=1710212822; bh=O5M6nvFrUX
	durJlufzvKykPOM0SFgbJMl6kJtFomcZE=; b=PIybsOHk1FfZdRNhQFfvvtxphA
	LL/FidYvlR8T0OKcrjy5OL5KL+ZgG971AlMX4ifDh1FQduuiI0bVu8kbWTwVORjr
	vOkrWCNrrzf21YLWggFdbV/dW1IrUEW3yB1ZoyAxCppVWBdfMjKrw0WnYYhj8DUr
	dQnnz0oDYpYCfKo6jKMgC6hKcE4LvLNtnkscDcWGlIbF9z0NiThIG/gRk6kX0o8t
	SMTYNFTFWUrUEFcjluL9EGCSTNpLHrIWHRFfjygFj01u7RNbt1obis3Z2OwfuUtk
	VCESDcGLhOQKyKC2EZH5eWCrhP/Ip4sMi8YKzdQhibnSIRT/XEAORwrjOQpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710126422; x=1710212822; bh=O5M6nvFrUXdurJlufzvKykPOM0SF
	gbJMl6kJtFomcZE=; b=OYgk8EXRjqsazyh6FTvqjPYsBnForTuXapNTLnI1scOv
	YCKhmTqRVAwaE09LB2keJoMqV2bj6/fuZOPkQ+tNqTSRgzXVnY1GIWNm+zoXePPw
	l9ZZZwI3S8Wej19IIjIWUmAsrd7f/g3pmPXdiLXSqU/8a6/sm8WAl6MRgYJOiCSa
	L9DfyjA2owZxGrbL5Q8pwnAQLh4Vr/afuCPVGK1T5gui1Ob8KAIyNnDrRpMRPiDM
	KflsYmXPCVoYnAn2x9gWkeZENC19mowPCpxK4q7SxGnML7v1orPMor2UhXelyuHO
	3HVaJW9F1Y1qNwPr23pmMXGiXS9yFhwbVRGGqkQGgQ==
X-ME-Sender: <xms:VXXuZQ2fLthexGmRM4_v4dZqC4jSKZ4Q1LlWWQ-UjjNmPhZYBGbrAQ>
    <xme:VXXuZbGCsRwegp80xNT81_4DIeEbGR3nbxQs0QdPA8fOY8PuhIO7e1j3ZvtEBLykl
    aqRmHWD9il1a7nOtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VnXuZY4DjKOnnfrjYiT_v--bfevW6lMmLyr2-4BxypjzrgQxBPQFFw>
    <xmx:VnXuZZ2Dmh2yJLbWKc5seN0h4FdUWgOc7WIBjq2nrkJsiNz62QXsOg>
    <xmx:VnXuZTHcCCQO7oywWLnV69X4WbdW2R5CbbKpWL_-yThS9qZ6S6EIlQ>
    <xmx:VnXuZS0btTZaC6cvUqbweeSkmMdxqbx4sDJW4_oI2z3nljRQVySlBg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D8AA81700093; Sun, 10 Mar 2024 23:07:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10c4851d-a8d8-4289-a9f9-509c70a0ca22@app.fastmail.com>
In-Reply-To: <20240229232211.161961-4-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-4-samuel.holland@sifive.com>
Date: Sun, 10 Mar 2024 23:06:41 -0400
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Samuel Holland" <samuel.holland@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Jisheng Zhang" <jszhang@kernel.org>, "yunhui cui" <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v5 03/13] riscv: Use IPIs for remote cache/TLB flushes by default
Content-Type: text/plain

On Thu, Feb 29, 2024, at 6:21 PM, Samuel Holland wrote:
> An IPI backend is always required in an SMP configuration, but an SBI
> implementation is not. For example, SBI will be unavailable when the
> kernel runs in M mode.
>
> Generally, IPIs are assumed to be faster than SBI calls due to the SBI
> context switch overhead. However, when SBI is used as the IPI backend,
> then the context switch cost must be paid anyway, and performing the
> cache/TLB flush directly in the SBI implementation is more efficient
> than inserting an interrupt to the kernel. This is the only scenario
> where riscv_ipi_set_virq_range()'s use_for_rfence parameter is false.
>
> Thus, it makes sense for remote fences to use IPIs by default, and make
> the SBI remote fence extension the special case.

The historical intention of providing SBI calls for remote fences is that
it abstracts over hardware that allows for performing remote fences
_without an IPI at all_. The TH1520 is an example of such hardware, since
it can (at least according to the documentation) perform broadcast fence,
fence.i, and sfence.vma operations using bits in the mhint register.

T-Head's public opensbi repository doesn't actually use this feature, and
in general SBI remote fences come from a much more optimistic time about
how much we can successfully hide from supervisor software. But I don't
think we can generalize that an IPI will always do less work than a SBI
remote fence.

-s

> sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
> calls riscv_ipi_set_virq_range() when no other IPI device is available.
> So we can move the static key and drop the use_for_rfence parameter.
>
> Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI is
> enabled. Optherwise, IPIs must be used. Add a fallback definition of
> riscv_use_sbi_for_rfence() which handles this case and removes the need
> to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v5:
>  - Also switch to riscv_use_sbi_for_rfence() in asm/pgalloc.h
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/include/asm/pgalloc.h  |  7 ++++---
>  arch/riscv/include/asm/sbi.h      |  4 ++++
>  arch/riscv/include/asm/smp.h      | 15 ++-------------
>  arch/riscv/kernel/sbi-ipi.c       | 11 ++++++++++-
>  arch/riscv/kernel/smp.c           | 11 +----------
>  arch/riscv/mm/cacheflush.c        |  5 ++---
>  arch/riscv/mm/tlbflush.c          | 31 ++++++++++++++-----------------
>  drivers/clocksource/timer-clint.c |  2 +-
>  8 files changed, 38 insertions(+), 48 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 87468f67951a..6578054977ef 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -8,6 +8,7 @@
>  #define _ASM_RISCV_PGALLOC_H
> 
>  #include <linux/mm.h>
> +#include <asm/sbi.h>
>  #include <asm/tlb.h>
> 
>  #ifdef CONFIG_MMU
> @@ -90,10 +91,10 @@ static inline pud_t *pud_alloc_one(struct mm_struct 
> *mm, unsigned long addr)
> 
>  static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>  {
> -	if (riscv_use_ipi_for_rfence())
> -		tlb_remove_page_ptdesc(tlb, pt);
> -	else
> +	if (riscv_use_sbi_for_rfence())
>  		tlb_remove_ptdesc(tlb, pt);
> +	else
> +		tlb_remove_page_ptdesc(tlb, pt);
>  }
> 
>  #define pud_free pud_free
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..ea84392ca9d7 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -375,8 +375,12 @@ unsigned long riscv_cached_marchid(unsigned int cpu_id);
>  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> 
>  #if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
> +DECLARE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +#define riscv_use_sbi_for_rfence() \
> +	static_branch_unlikely(&riscv_sbi_for_rfence)
>  void sbi_ipi_init(void);
>  #else
> +static inline bool riscv_use_sbi_for_rfence(void) { return false; }
>  static inline void sbi_ipi_init(void) { }
>  #endif
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 0d555847cde6..7ac80e9f2288 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -49,12 +49,7 @@ void riscv_ipi_disable(void);
>  bool riscv_ipi_have_virq_range(void);
> 
>  /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
> -
> -/* Check if we can use IPIs for remote FENCEs */
> -DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -#define riscv_use_ipi_for_rfence() \
> -	static_branch_unlikely(&riscv_ipi_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr);
> 
>  /* Check other CPUs stop or not */
>  bool smp_crash_stop_failed(void);
> @@ -104,16 +99,10 @@ static inline bool riscv_ipi_have_virq_range(void)
>  	return false;
>  }
> 
> -static inline void riscv_ipi_set_virq_range(int virq, int nr,
> -					    bool use_for_rfence)
> +static inline void riscv_ipi_set_virq_range(int virq, int nr)
>  {
>  }
> 
> -static inline bool riscv_use_ipi_for_rfence(void)
> -{
> -	return false;
> -}
> -
>  #endif /* CONFIG_SMP */
> 
>  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index a4559695ce62..1026e22955cc 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -13,6 +13,9 @@
>  #include <linux/irqdomain.h>
>  #include <asm/sbi.h>
> 
> +DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> +
>  static int sbi_ipi_virq;
> 
>  static void sbi_ipi_handle(struct irq_desc *desc)
> @@ -72,6 +75,12 @@ void __init sbi_ipi_init(void)
>  			  "irqchip/sbi-ipi:starting",
>  			  sbi_ipi_starting_cpu, NULL);
> 
> -	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
> +	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
>  	pr_info("providing IPIs using SBI IPI extension\n");
> +
> +	/*
> +	 * Use the SBI remote fence extension to avoid
> +	 * the extra context switch needed to handle IPIs.
> +	 */
> +	static_branch_enable(&riscv_sbi_for_rfence);
>  }
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 45dd4035416e..8e6eb64459af 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -171,10 +171,7 @@ bool riscv_ipi_have_virq_range(void)
>  	return (ipi_virq_base) ? true : false;
>  }
> 
> -DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
> -
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr)
>  {
>  	int i, err;
> 
> @@ -197,12 +194,6 @@ void riscv_ipi_set_virq_range(int virq, int nr, 
> bool use_for_rfence)
> 
>  	/* Enabled IPIs for boot CPU immediately */
>  	riscv_ipi_enable();
> -
> -	/* Update RFENCE static key */
> -	if (use_for_rfence)
> -		static_branch_enable(&riscv_ipi_for_rfence);
> -	else
> -		static_branch_disable(&riscv_ipi_for_rfence);
>  }
> 
>  static const char * const ipi_names[] = {
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..47c485bc7df0 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,7 @@ void flush_icache_all(void)
>  {
>  	local_flush_icache_all();
> 
> -	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> +	if (riscv_use_sbi_for_rfence())
>  		sbi_remote_fence_i(NULL);
>  	else
>  		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> @@ -69,8 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  		 * with flush_icache_deferred().
>  		 */
>  		smp_mb();
> -	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> -		   !riscv_use_ipi_for_rfence()) {
> +	} else if (riscv_use_sbi_for_rfence()) {
>  		sbi_remote_fence_i(&others);
>  	} else {
>  		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8d12b26f5ac3..0373661bd1c4 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -78,10 +78,10 @@ static void __ipi_flush_tlb_all(void *info)
> 
>  void flush_tlb_all(void)
>  {
> -	if (riscv_use_ipi_for_rfence())
> -		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -	else
> +	if (riscv_use_sbi_for_rfence())
>  		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
> +	else
> +		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>  }
> 
>  struct flush_tlb_range_data {
> @@ -102,7 +102,6 @@ static void __flush_tlb_range(struct cpumask 
> *cmask, unsigned long asid,
>  			      unsigned long start, unsigned long size,
>  			      unsigned long stride)
>  {
> -	struct flush_tlb_range_data ftd;
>  	bool broadcast;
> 
>  	if (cpumask_empty(cmask))
> @@ -118,20 +117,18 @@ static void __flush_tlb_range(struct cpumask 
> *cmask, unsigned long asid,
>  		broadcast = true;
>  	}
> 
> -	if (broadcast) {
> -		if (riscv_use_ipi_for_rfence()) {
> -			ftd.asid = asid;
> -			ftd.start = start;
> -			ftd.size = size;
> -			ftd.stride = stride;
> -			on_each_cpu_mask(cmask,
> -					 __ipi_flush_tlb_range_asid,
> -					 &ftd, 1);
> -		} else
> -			sbi_remote_sfence_vma_asid(cmask,
> -						   start, size, asid);
> -	} else {
> +	if (!broadcast) {
>  		local_flush_tlb_range_asid(start, size, stride, asid);
> +	} else if (riscv_use_sbi_for_rfence()) {
> +		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> +	} else {
> +		struct flush_tlb_range_data ftd;
> +
> +		ftd.asid = asid;
> +		ftd.start = start;
> +		ftd.size = size;
> +		ftd.stride = stride;
> +		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
>  	}
> 
>  	if (cmask != cpu_online_mask)
> diff --git a/drivers/clocksource/timer-clint.c 
> b/drivers/clocksource/timer-clint.c
> index 09fd292eb83d..0bdd9d7ec545 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct 
> device_node *np)
>  	}
> 
>  	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
> -	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
> +	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
>  	clint_clear_ipi();
>  #endif
> 
> -- 
> 2.43.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

