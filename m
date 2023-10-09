Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608617BE8BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbjJIRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjJIRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:53:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F4C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:53:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7741c2fae49so318486585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696874026; x=1697478826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5YUwrppm/AoYHUPSKvRLI3OIQ5ZsMP8vebRQ0LmXCY=;
        b=DEsgq4bCSpn6QYrMRn1iL2MelRde9Sdwl4y6DRp9x7fl5c5LL9yvDvHtpoVhY5MWDI
         fAXj5+vKCej8/JSqIklOO6ga+nQppZ0i+QQzaypYevORPW9jhePNtE2LBJUHh21U6uIr
         8qnZtY97/HJr1+x4nC/2ium3efbjVztn5z8gZghobiZ/buirr5r4SZSJGrFq9PeImTzQ
         IUPGXNClcvwbs2aPIkfOl2EJ/jbYigBji5c2RdoEGO31He5bFb72GIH8JB3qQGJUtf6R
         RBCmv9+2Ydx3LdmCpfbguQ8kYSO0GOWhcxEKWkNo2tAaYPFS8k7Q0hw7bYHDnMZv82Y8
         IR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696874026; x=1697478826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5YUwrppm/AoYHUPSKvRLI3OIQ5ZsMP8vebRQ0LmXCY=;
        b=XbvjSMINl5x2vNslMIxxsJ2zvHBBrR6DVUPmkDuLmB+HLOaxep/zKWkiku/w3FDwvP
         +5enokP8RPytmGyn/VS6C6KRf+Fw5IKn79B+PVdI4VuRX+uXDGEMBtVKX8ivL3PLau31
         Dw8JZEbW60kK92qU2enxEkzqzLZ0P2oTWIhaZUDJ63T0BqAkXUx+3Wdr+Wggg3ff+Xu0
         Y/PnfSfmnsepi/bLLETcZLCQiVRWLkvmDk7+C57VBDEQP+S1x6P/Hgo2BQt38++CZPg9
         a8AHFVoWchiw0lek8f//n0O3hG0BIwU5Vl70YuuhrlQ7R8egJu8plUv62ZyB/QQ3mldQ
         X+pQ==
X-Gm-Message-State: AOJu0Yyfk8yyw0BSYKf7MzfOrs4lwIHEcLOtmEzfZEmgEnDmU0WJPRXK
        fhqMKxRmJy1Fjxlbi5tVrX0q4A==
X-Google-Smtp-Source: AGHT+IHn3G7dp7w4ELGf7mKo4hz5o3p9FIlRvSczI8R7BrW5KIzLNolaRTbPbsB8nhk7K2CpQZp1tA==
X-Received: by 2002:a05:620a:1a89:b0:773:a83f:413c with SMTP id bl9-20020a05620a1a8900b00773a83f413cmr21902058qkb.30.1696874025984;
        Mon, 09 Oct 2023 10:53:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:41c4:1832:a984:34e2? ([2600:1700:2000:b002:41c4:1832:a984:34e2])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b007659935ce64sm3681308qkk.71.2023.10.09.10.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 10:53:45 -0700 (PDT)
Message-ID: <79d8ca23-478d-4f88-afb3-343a85ed0fe6@sifive.com>
Date:   Mon, 9 Oct 2023 12:53:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-3-alexghiti@rivosinc.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230911131224.61924-3-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2023-09-11 8:12 AM, Alexandre Ghiti wrote:
> flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
> when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
> whole tlb: so set a stride of the size of the hugetlb mapping in order to
> only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
> all PTEs that constitute this mapping must be invalidated, so the stride
> size must actually be the size of the PTE.
> 
> Note that THPs are directly handled by flush_pmd_tlb_range().
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/mm/tlbflush.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index fa03289853d8..5bda6d4fed90 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -3,6 +3,7 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/sched.h>
> +#include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
>  
> @@ -147,7 +148,43 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
> -	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +	unsigned long stride_size;
> +
> +	stride_size = is_vm_hugetlb_page(vma) ?
> +				huge_page_size(hstate_vma(vma)) :
> +				PAGE_SIZE;
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	/*
> +	 * As stated in the privileged specification, every PTE in a NAPOT
> +	 * region must be invalidated, so reset the stride in that case.
> +	 */
> +	if (has_svnapot()) {

This whole block should probably go inside the is_vm_hugetlb_page(vma) check,
since we have to perform that check anyway.

> +		unsigned long order, napot_size;
> +
> +		for_each_napot_order(order) {
> +			napot_size = napot_cont_size(order);
> +
> +			if (stride_size != napot_size)
> +				continue;
> +
> +			if (napot_size >= PGDIR_SIZE)

Can you check stride_size here directly, and drop the loop? We should be able to
assume that the huge page size is valid. Non-NAPOT hugepages will hit one of the
equal-to cases below, which is fine.

Regards,
Samuel

> +				stride_size = PGDIR_SIZE;
> +			else if (napot_size >= P4D_SIZE)
> +				stride_size = P4D_SIZE;
> +			else if (napot_size >= PUD_SIZE)
> +				stride_size = PUD_SIZE;
> +			else if (napot_size >= PMD_SIZE)
> +				stride_size = PMD_SIZE;
> +			else
> +				stride_size = PAGE_SIZE;
> +
> +			break;
> +		}
> +	}
> +#endif
> +
> +	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,

