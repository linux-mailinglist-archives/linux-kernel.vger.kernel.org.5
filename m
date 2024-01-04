Return-Path: <linux-kernel+bounces-16646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAC8241DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599E11F24DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F42137E;
	Thu,  4 Jan 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KWWVr+ot"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306C2111E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28bd9ca247so48861966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704371808; x=1704976608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rbdo4C/X6bEIX/A1ZdBX4InlDHJmGdJuXNskE1V/Lk=;
        b=KWWVr+otSCFrIjJ5IAAYiDUw23+7hTLRq7+8i+85YqYjzmHgFrkP9dR0mBNlR+tYPA
         OqjHfvHxMZQAfDaLd9hASLQk1lgnHqtH6t9V/4hjwLcK/ZEE8rinqZJSGsPCTA5ucO1X
         n0mAHZ7qJpuwbzIduPpcEiblqbYaXuHHesUjFJQ8k0Mn3hpV6/D07VdsfCPpFlm8LHZY
         sIEUev7RHRlH5A+Ltz9YX4JpQOE5qfTBG6WUUbI2ksK83bplNm3/r8HsXd8MtDyfd1X2
         j+nFIEEgokJd/M+uU6jYYnBz96RYuPxXcYcmmdNAtnZg6M3cjcHM4LHqyJ2B9gyklcSh
         ZWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371808; x=1704976608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rbdo4C/X6bEIX/A1ZdBX4InlDHJmGdJuXNskE1V/Lk=;
        b=Uh30sFknFHaAApwNhE7cpJx67NMeVuMHRnv3MqhgRVTdeTDxBnkQ7PQe2BbH85QG4E
         lnHuD95kzZmOodcdAVILI8U1Ljpe1yFd1zAXun7/LRfNSPdMZ4sSHdJLrmRvBVTbuxc/
         90TA6c+gXyCmOvkhRTux+lUe3Zuwtoj+EOGQrRal+XJqddouAPtM0haqwvOwlLCymxwq
         +7yLsH3dVYrrL7JQn9/DxRa4/CJafRMp9HybQw0y2ise5h1yAQpNtBV9M/q52i1cgGlH
         k4xZgVe6ANshgGvEIpLyfyIJahE+pLHxWZL1OBsUn5KLkVCdehzKDVNQhGg0UgnaJvJ1
         myPQ==
X-Gm-Message-State: AOJu0YxVPByP7Dm7Su3DmtiHwvny8Ur5r1exTRKqZHsSjv+kzdQ+T71t
	80m0mXpjCgPvHnjXFczK47yfocxkQpf8APBhtmo6/bhW3CPtDw==
X-Google-Smtp-Source: AGHT+IGrAlcRpWxucvqwsc1/ERZuXk0N2sSJ8gsatbwcwVv03z9oBwqPMxWY/LDrXUnQbg+z7RR2d1qVfgbCtNvd/Cc=
X-Received: by 2002:a17:906:58d:b0:a28:893:64a8 with SMTP id
 13-20020a170906058d00b00a28089364a8mr336250ejn.85.1704371808415; Thu, 04 Jan
 2024 04:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-6-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-6-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:36:37 +0100
Message-ID: <CAHVXubi5C=Dt2ACsEYt68AeCSCVO49Udaks=0pf1+cK0igNOoQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] riscv: mm: Combine the SMP and UP TLB flush code
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> In SMP configurations, all TLB flushing narrower than flush_tlb_all()
> goes through __flush_tlb_range(). Do the same in UP configurations.
>
> This allows UP configurations to take advantage of recent improvements
> to the code in tlbflush.c, such as support for huge pages and flushing
> multiple-page ranges.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - Merge the two copies of __flush_tlb_range() and rely on the compiler
>    to optimize out the broadcast path (both clang and gcc do this)
>  - Merge the two copies of flush_tlb_all() and rely on constant folding
>
> Changes in v2:
>  - Move the SMP/UP merge earlier in the series to avoid build issues
>  - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
>  - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)
>
>  arch/riscv/include/asm/tlbflush.h | 29 +++--------------------------
>  arch/riscv/mm/Makefile            |  5 +----
>  2 files changed, 4 insertions(+), 30 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 8f3418c5f172..7712ffe2f6c4 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -27,12 +27,7 @@ static inline void local_flush_tlb_page(unsigned long =
addr)
>  {
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" =
(addr) : "memory"));
>  }
> -#else /* CONFIG_MMU */
> -#define local_flush_tlb_all()                  do { } while (0)
> -#define local_flush_tlb_page(addr)             do { } while (0)
> -#endif /* CONFIG_MMU */
>
> -#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> @@ -46,26 +41,8 @@ void flush_tlb_kernel_range(unsigned long start, unsig=
ned long end);
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
>                         unsigned long end);
>  #endif
> -#else /* CONFIG_SMP && CONFIG_MMU */
> -
> -#define flush_tlb_all() local_flush_tlb_all()
> -#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
> -
> -static inline void flush_tlb_range(struct vm_area_struct *vma,
> -               unsigned long start, unsigned long end)
> -{
> -       local_flush_tlb_all();
> -}
> -
> -/* Flush a range of kernel pages */
> -static inline void flush_tlb_kernel_range(unsigned long start,
> -       unsigned long end)
> -{
> -       local_flush_tlb_all();
> -}
> -
> -#define flush_tlb_mm(mm) flush_tlb_all()
> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> +#else /* CONFIG_MMU */
> +#define local_flush_tlb_all()                  do { } while (0)
> +#endif /* CONFIG_MMU */
>
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 3a4dfc8babcf..96e65c571ce8 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -13,15 +13,12 @@ endif
>  KCOV_INSTRUMENT_init.o :=3D n
>
>  obj-y +=3D init.o
> -obj-$(CONFIG_MMU) +=3D extable.o fault.o pageattr.o
> +obj-$(CONFIG_MMU) +=3D extable.o fault.o pageattr.o tlbflush.o
>  obj-y +=3D cacheflush.o
>  obj-y +=3D context.o
>  obj-y +=3D pgtable.o
>  obj-y +=3D pmem.o
>
> -ifeq ($(CONFIG_MMU),y)
> -obj-$(CONFIG_SMP) +=3D tlbflush.o
> -endif
>  obj-$(CONFIG_HUGETLB_PAGE) +=3D hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE) +=3D ptdump.o
>  obj-$(CONFIG_KASAN)   +=3D kasan_init.o
> --
> 2.42.0
>

Nice one, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

