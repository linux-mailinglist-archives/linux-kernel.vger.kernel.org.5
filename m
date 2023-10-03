Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D859A7B62A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbjJCHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJCHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:42:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8143C90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:42:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso895559a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696318922; x=1696923722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EarP/K2+7ngez1EJdI5nUP41kOhzqNXkW1CqtE7G6xA=;
        b=WkFKAGXMhEgVW2r1eL+M6C9ygLffm2SxcrWzXSASgvwbrnEq3HLxh1BB2LAvEwfJKr
         Ly5JJeoW1oqQQY1D2AtuPi4a+jsh5QYG6W0Gw2BzU/JX9fzkO2G5C270H7lhLTHVFWyt
         fW4Bp2AimKKm5jt0dzjvucpUZtvf3Qb9JSYheZlBcVJcf1YNg9xXPN/dLPURi0jltmY6
         7LrJnpT/g3mKUuDXMEGxRNgEfexz/YpTvGxXm3mwotfkk29+X57FWzC0WYhc9XURQXhF
         zulAaLwVk+AnHG5ctC1vKcuEgYv7ASBu6OVZtfteqvo7Q2sSiuN21x9zyM5qedm+3uBC
         CazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318922; x=1696923722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EarP/K2+7ngez1EJdI5nUP41kOhzqNXkW1CqtE7G6xA=;
        b=wcqVsly7rvWVUBUbXROGJEYqJeh2lyRkGwYEvS2/Gy9ad4Nc2DYCH/8OUwopSsQPGw
         CMKtTTy8CLsXy/iFDvem5CxRIwBrJeIS8Lg5bIjuPirkcdW0U2rlInergM8+U6tvwF2d
         NkbzpJNsrS3TJCIlJYUQG6i34zCBlxAqZVvzkSzgQEzgk3XD//X2WWoYLrB1PiVgJa9o
         cB4zbUxkWelK4Jh3ltueNA1CPzHIlKicZiEjRPCYXmw5pYrD/ZqA8TYSiA/HglfVSERg
         OXeUG3BdJyJbcl60hZvaxEzSkNUeeBODLTgtvovpTeRpygsaxE3diDWXU4LG3Khd8JhN
         aPAg==
X-Gm-Message-State: AOJu0Yz48osU+Ioxk5anCET8QJ95lA2lJ/D8QkK/4cC/vjN/Nh/G3nu3
        AftTR89vi1TDacGNziiT/CefsA==
X-Google-Smtp-Source: AGHT+IG1N2+LCXuxOd0Vv82Jtne0d7kp6cgoSOTpGsutcsoXHxeibNyA9BF+dcEU1nuk7EPT5XbNLg==
X-Received: by 2002:aa7:d90f:0:b0:531:5126:cd5e with SMTP id a15-20020aa7d90f000000b005315126cd5emr11963080edr.34.1696318921994;
        Tue, 03 Oct 2023 00:42:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7d65a000000b0053495596f42sm419143edr.30.2023.10.03.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:42:01 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:42:00 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT
 mappings when a swap entry is set
Message-ID: <20231003-555f517e872d4d53ff8d2b02@orel>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <20230928151846.8229-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151846.8229-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:18:46PM +0200, Alexandre Ghiti wrote:
> We used to determine the number of page table entries to set for a NAPOT
> hugepage by using the pte value which actually fails when the pte to set is
> a swap entry.
> 
> So take advantage of a recent fix for arm64 reported in [1] which
> introduces the size of the mapping as an argument of set_huge_pte_at(): we
> can then use this size to compute the number of page table entries to set
> for a NAPOT region.
> 
> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index e4a2ace92dbe..b52f0210481f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -183,15 +183,22 @@ void set_huge_pte_at(struct mm_struct *mm,
>  		     pte_t pte,
>  		     unsigned long sz)
>  {
> +	unsigned long hugepage_shift;
>  	int i, pte_num;
>  
> -	if (!pte_napot(pte)) {
> -		set_pte_at(mm, addr, ptep, pte);
> -		return;
> -	}
> +	if (sz >= PGDIR_SIZE)
> +		hugepage_shift = PGDIR_SHIFT;
> +	else if (sz >= P4D_SIZE)
> +		hugepage_shift = P4D_SHIFT;
> +	else if (sz >= PUD_SIZE)
> +		hugepage_shift = PUD_SHIFT;
> +	else if (sz >= PMD_SIZE)
> +		hugepage_shift = PMD_SHIFT;
> +	else
> +		hugepage_shift = PAGE_SHIFT;
>  
> -	pte_num = napot_pte_num(napot_cont_order(pte));
> -	for (i = 0; i < pte_num; i++, ptep++, addr += PAGE_SIZE)
> +	pte_num = sz >> hugepage_shift;
> +	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
>  		set_pte_at(mm, addr, ptep, pte);
>  }
>

So a 64k napot, for example, will fall into the PAGE_SHIFT arm, but then
we'll calculate 16 for pte_num. Looks good to me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
