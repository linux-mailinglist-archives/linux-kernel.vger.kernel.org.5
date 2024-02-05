Return-Path: <linux-kernel+bounces-54068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A784AA44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC859B22A63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4483CF58;
	Mon,  5 Feb 2024 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RfYn9sDJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44218482F5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174565; cv=none; b=H22D8YaB0xq5CcVjsQiyjbvTCqrJFkVP4a8qHQh45rkmpFBxhItmaN52hnDg9LZVRfYgpNP26rNWB0mmnAOiICtuOm9DzNQryCY6rUHDS51Yhz/O9WCIdL7xZcLS0PNo4FsJnf6U6XNL6v+7/FNqOnF6pvL5q9zthqSKhGcRDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174565; c=relaxed/simple;
	bh=vq9o4EymX13PyuQHF9HrAPC/1CRoCrWY/UyL7qmMYvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc2qzVceLJvW8eCItWSEkz4SuBmGPuchwWh02NvbT7YZX4MYo3EvrbrFivCK1JtHD82F3ZetfYk1MzVsrxlU5+u8wzcSZXgy7nanbaUZcDopySfcPeFqLVdlmnOExiVAxksW/jNHMSuWs5Am/5Vd7DbEmiIBRY6yfFfpfzyGGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RfYn9sDJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d72f71f222so40080995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707174561; x=1707779361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSwq0kqDcJFU0BRDFanOctiB1Z+4ozxhyzWWA6dFk0s=;
        b=RfYn9sDJMntUBNe11BmNLnStA10fBGzH8xGTgHO8RdbAnItx0ykuBun3uuGjK/M/N2
         9X+YeiF37NOVeW/R4EEnlJIEaaAavfqSRaER9kF4v99t3grHtJQjpD+chypvZCnWaDI+
         L2YYm8uvftXxmeVrcz3XnEHLso6WKXF7i4iu6mKT+pPO+qL+LZM12zzv8Ks9uZN/PMDs
         iI94J2jCzzi1D/vDIp3UM64rwwte2RyGX7gTeXxilH22L2ySRZWgKJ+pUhkNOR83G/zE
         mkmo67zIYkNif/+N1OtS5QoJzamBK/G/oEp0U3rK9vlSGI7xKMVE4fsnQW3Zg/He5/02
         gkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174561; x=1707779361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSwq0kqDcJFU0BRDFanOctiB1Z+4ozxhyzWWA6dFk0s=;
        b=KffI4IjlSHm+kasV6XisvbI1HjVuAOjTt/oZ4fQE4nmCBF+0l8hD02e+ozBbX1mG+a
         8CXMhW2UucaHgkHZjcdk8wH60AtiHlbfka5/B6pjWmG/eAsO6smGBlH7gtv4+mAe93/M
         EkLen+/+A5pbu8+xLUoKVra6xc3h0TQUIa2uoYMiJoTL0DeoLOM9f6EO+HbwYMySZ5tB
         kf1nMbSlQUXjfFNlK5BSCFefhp/16KZmlguetAsShZi3XI6QyWXptj/RddwqB0jOiNPw
         lYeCdxShXJhMIiGoIMpL/f+rGmcCWAi+H993r+RuDNmUxIHhSCy8IV060cgJVJtr6dns
         d3SQ==
X-Gm-Message-State: AOJu0YyX6xvqF7RbGUDcLahqVS/CDyAOKAwoZkDw+W0invt2MJ6qAfZ7
	kmPa//euREwLpcSwoXBSQuWdNYur0FpF6XLxQ0M6KdopVwZg/50uyySkospFHWA=
X-Google-Smtp-Source: AGHT+IGWMSVP4g1RkkGppscPVtyZNu/IY0rg2dbT54+40Cs+tkHyOIqM7on6+FJVjo9rViYIkkpgsA==
X-Received: by 2002:a17:902:bc45:b0:1d9:8cd8:acff with SMTP id t5-20020a170902bc4500b001d98cd8acffmr941573plz.62.1707174561185;
        Mon, 05 Feb 2024 15:09:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKI30Vl6WZduHvlKzCNdPAifq8CEQxrTFOAWDyKxPHczXy/jrjnvAi+a6hMW/JpVitKZhL3OZkYjKA4oJYZnkRPmTKAGO7uDO8PM5lxtZUnPutBFCx7p6POaymKGn15culFuICFPYwWXseNLX+iqzD3goBLbH5ucc/HKkn7i5suEOdspDOg7mi9mvFEDjsizrroAECI7dLzw==
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902744600b001d93bb0c9c8sm414955plt.85.2024.02.05.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:09:20 -0800 (PST)
Date: Mon, 5 Feb 2024 15:09:18 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
Message-ID: <ZcFqnm5/odPzQoHK@ghost>
References: <20240202124711.256146-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202124711.256146-1-alexghiti@rivosinc.com>

On Fri, Feb 02, 2024 at 01:47:11PM +0100, Alexandre Ghiti wrote:
> We used to emit a flush_icache_all() whenever a dirty executable
> mapping is set in the page table but we can instead call
> flush_icache_mm() which will only send IPIs to cores that currently run
> this mm and add a deferred icache flush to the others.
> 
> The number of calls to sbi_remote_fence_i() (tested without IPI
> support):
> 
> With a simple buildroot rootfs:
> * Before: ~5k
> * After :  4 (!)
> 
> Tested on HW, the boot to login is ~4.5% faster.
> 
> With an ubuntu rootfs:
> * Before: ~24k
> * After : ~13k
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 14 +++++++-------
>  arch/riscv/mm/cacheflush.c       |  4 ++--
>  arch/riscv/mm/pgtable.c          |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 0c94260b5d0c..058cfa89dd29 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -513,12 +513,12 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	WRITE_ONCE(*ptep, pteval);
>  }
>  
> -void flush_icache_pte(pte_t pte);
> +void flush_icache_pte(struct mm_struct *mm, pte_t pte);
>  
> -static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
> +static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
>  {
>  	if (pte_present(pteval) && pte_exec(pteval))
> -		flush_icache_pte(pteval);
> +		flush_icache_pte(mm, pteval);
>  
>  	set_pte(ptep, pteval);
>  }
> @@ -529,7 +529,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	page_table_check_ptes_set(mm, ptep, pteval, nr);
>  
>  	for (;;) {
> -		__set_pte_at(ptep, pteval);
> +		__set_pte_at(mm, ptep, pteval);
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> @@ -541,7 +541,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  static inline void pte_clear(struct mm_struct *mm,
>  	unsigned long addr, pte_t *ptep)
>  {
> -	__set_pte_at(ptep, __pte(0));
> +	__set_pte_at(mm, ptep, __pte(0));
>  }
>  
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
> @@ -707,14 +707,14 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  				pmd_t *pmdp, pmd_t pmd)
>  {
>  	page_table_check_pmd_set(mm, pmdp, pmd);
> -	return __set_pte_at((pte_t *)pmdp, pmd_pte(pmd));
> +	return __set_pte_at(mm, (pte_t *)pmdp, pmd_pte(pmd));
>  }
>  
>  static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>  				pud_t *pudp, pud_t pud)
>  {
>  	page_table_check_pud_set(mm, pudp, pud);
> -	return __set_pte_at((pte_t *)pudp, pud_pte(pud));
> +	return __set_pte_at(mm, (pte_t *)pudp, pud_pte(pud));
>  }
>  
>  #ifdef CONFIG_PAGE_TABLE_CHECK
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index b0774993c0f3..3e234e95d952 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -85,12 +85,12 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_MMU
> -void flush_icache_pte(pte_t pte)
> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
>  {
>  	struct folio *folio = page_folio(pte_page(pte));
>  
>  	if (!test_bit(PG_dcache_clean, &folio->flags)) {
> -		flush_icache_all();
> +		flush_icache_mm(mm, false);
>  		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index ef887efcb679..533ec9055fa0 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -10,7 +10,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  			  pte_t entry, int dirty)
>  {
>  	if (!pte_same(ptep_get(ptep), entry))
> -		__set_pte_at(ptep, entry);
> +		__set_pte_at(vma->vm_mm, ptep, entry);
>  	/*
>  	 * update_mmu_cache will unconditionally execute, handling both
>  	 * the case that the PTE changed and the spurious fault case.
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


