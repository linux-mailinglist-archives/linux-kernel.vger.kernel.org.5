Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9145B766E99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjG1Nkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjG1Nkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:40:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB0A3590
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:40:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso2744612a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690551642; x=1691156442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOr1yk/G929iC/UP6Gxb6LGjnTgc9novxErxvxKlMFA=;
        b=IQ3Zqni+xYE1E5lTEQCioxb550A8Se+B6M1Ky+b3SqepfB3cIr/HCWGJX+F1OF9wFY
         Z4yeLGUnJ/oTaoCRLbn5dO6tb8bTXejCeBqLZ7/D40XmUa8r3M/Ybd47vGLBGzJPlPDF
         wythpCmiNF6GioB3CydtOcNhd+WykncVDXx47mMWaLhkYrxT2oNi3amn7v+9lDKXD4TX
         c3u12ZTfhWRCNqyovbhmli3c5z3wUupr6p/p3pgDv2ocqNMCb0yEFtAuhpPo3u4Jn6Xr
         VmnoMR+9E7F3gazk4FFRopYBoipA+G//nAndzJXlx57BZFwsVE/j/hlNPlJ5PE+YqjLL
         YOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551642; x=1691156442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOr1yk/G929iC/UP6Gxb6LGjnTgc9novxErxvxKlMFA=;
        b=AOdwqOHLbmeQCmB14hY1Yvh0cBmU9Fe2JdJt5ky9QRSaizkBwtEleFNYpGMyAPVuBV
         YRCQZU0EqcCgf8CFfptpJU7iAXVazGtQnM8zzRDWAlArUOF0v89UmY2Xq64igH3JeLCU
         JcSk3EdnnE4ju790J+0DjGxbexM3YjNsgg99sNmZSXar6P2ZkLIAfwLritF3B0vbA0Dh
         sM9c11Ehj4QeKDPpX9ABeWiInDHpZapiqtPxebEMRT1TRmmRzxTNkyjb+lTBdKKwsOrs
         K1gahhwGxJsTwrkwVKOne7V14fG4KQA9uS/fYuMNZRq9OsM3zT9Ll4RpipNmd/LY/FAN
         RqVg==
X-Gm-Message-State: ABy/qLZuWRNsNMTDBkP9vvcG1qnSoEHXAeWb/UW+9x0xIOTuOoJjri6j
        vcyj0xEBRm451eJ83rd6xM/0uTnydtbeYxxCnhc=
X-Google-Smtp-Source: APBJJlEYSSoWqY1AZEvMkgejX1YVuSwDTsDWEeWUKTMmJ78xen4aK3pxBR2H/MQNoqMbOAxqyZGevg==
X-Received: by 2002:a05:6402:1148:b0:51f:f1a4:edc6 with SMTP id g8-20020a056402114800b0051ff1a4edc6mr1701888edw.37.1690551641712;
        Fri, 28 Jul 2023 06:40:41 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c717000000b0051bed21a635sm1822857edq.74.2023.07.28.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:40:41 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:40:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Will Deacon <will@kernel.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Message-ID: <20230728-50d247a7253aaf9468cd8b3d@orel>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727185553.980262-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:55:51PM +0200, Alexandre Ghiti wrote:
> flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
> when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
> whole tlb: so set a stride of the size of the hugetlb mapping in order to
> only flush the hugetlb mapping.
> 
> Note that THPs are directly handled by flush_pmd_tlb_range().
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index fa03289853d8..3e4acef1f6bc 100644
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
> @@ -147,7 +148,14 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
> -	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +	unsigned long stride_shift;
> +
> +	stride_shift = is_vm_hugetlb_page(vma) ?
> +				huge_page_shift(hstate_vma(vma)) :
> +				PAGE_SHIFT;

We want the size below instead of the shift, so we can just use
huge_page_size() and PAGE_SIZE here.

> +
> +	__flush_tlb_range(vma->vm_mm,
> +			  start, end - start, 1 << stride_shift);

Shouldn't need to wrap this line.

>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> -- 
> 2.39.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
