Return-Path: <linux-kernel+bounces-16658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA28241FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64C11F21B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42B22303;
	Thu,  4 Jan 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EWeESRwm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AC219FC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5570bef7cb8so407682a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704372186; x=1704976986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dSQx9QRDMQgMq2yHL+yy/8AmXFdHgPgzOIo1vsfuUU=;
        b=EWeESRwmJjX7wma4+o27yY2YI/1akDoQDATG5kdxnslhvbtMN+NyAJGUPt6Z3fvEFa
         Y/cEqpLZZHnRW8scVs5el+cB4wEeuYZyfZykD+2oidIp6hSU//HO5OVNUWxGLIaR3BOP
         V6LVqY5dtLVpRLE7Z6ixOetQtcLp2nqaUeSWIsJ3I246yFCN0UwPioAi+OiOGQxMRd1I
         ZboIZzLtzSxGu8G98RUbaSDms/Q02yMtY6XaXIVOiYROT/ASbGZz2G0V9r+OnmELWzk6
         S2NyZdQ35R1S6gbbvIiprgSNYnw/SG6pAl3z3yIFxdIB9uCbDpslZGtjT/ipdm9JZ3Pz
         yCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372186; x=1704976986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dSQx9QRDMQgMq2yHL+yy/8AmXFdHgPgzOIo1vsfuUU=;
        b=MxGbdMPIzzJddytkxMLEsGP3De5YfAnMuFNz9BhzAkMZFdwRLw6fFCm+fZHj1K8Lz6
         HKQk6kWEtyhqp6gIXt2R2wbcE1LB1XWRbF0E5npw0lJrt/zGQxCZhNMs8pJc09/FOVNU
         pI7kzkd/9CeHvMdEPWn6vG/Y8JXd/HtEAECH07U1msLlbIJhLHFJKTZFOl8n3xP9iIC3
         FnRD08vsOzj6j8rQg3HSEbhRngztRctvL073B1ZTH+WrdMGR0aqWuTpjm1GKQmCKQZRI
         LalIBsVn98uBJSs47JQFqZ9mTCsVKo74VY/B2bX7kKtqRJvK8fi7OqAOJ7XuGshiYaBQ
         mLjg==
X-Gm-Message-State: AOJu0Yy1AgmP6SxCTFPBRkoPqSDA8fart0iMnl9KBiSM3Co5i36fzkf5
	5vOAjYwQZ+tqzJEmmTrEuc3b4rv8zRlto24AoseUzYLqpQjFU3DKKVqMFMISxWk=
X-Google-Smtp-Source: AGHT+IGzNSA3TCDxL27scTROGs8Y4tvcclkYiXTrM5eUj0GjUWYmmvD17vNpJVXJzc/mg9PyWPWOFePUgd0YlvTpIno=
X-Received: by 2002:a17:906:7f0f:b0:a28:abf8:9bb5 with SMTP id
 d15-20020a1709067f0f00b00a28abf89bb5mr273455ejr.21.1704372186518; Thu, 04 Jan
 2024 04:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-10-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-10-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:42:55 +0100
Message-ID: <CAHVXubg1=BuA+_BxPb_Q4B1hnN_DvVJ8wyJ_4KmFkU9qNQkWCw@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] riscv: mm: Use a fixed layout for the MM context ID
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Currently, the size of the ASID field in the MM context ID dynamically
> depends on the number of hardware-supported ASID bits. This requires
> reading a global variable to extract either field from the context ID.
> Instead, allocate the maximum possible number of bits to the ASID field,
> so the layout of the context ID is known at compile-time.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/include/asm/mmu.h      | 4 ++--
>  arch/riscv/include/asm/tlbflush.h | 2 --
>  arch/riscv/mm/context.c           | 6 ++----
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index a550fbf770be..dc0273f7905f 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -26,8 +26,8 @@ typedef struct {
>  #endif
>  } mm_context_t;
>
> -#define cntx2asid(cntx)                ((cntx) & asid_mask)
> -#define cntx2version(cntx)     ((cntx) & ~asid_mask)
> +#define cntx2asid(cntx)                ((cntx) & SATP_ASID_MASK)
> +#define cntx2version(cntx)     ((cntx) & ~SATP_ASID_MASK)
>
>  void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa=
,
>                                phys_addr_t sz, pgprot_t prot);
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index d9913590f82e..5bfd37cfd8c3 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -15,8 +15,6 @@
>  #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
>
>  #ifdef CONFIG_MMU
> -extern unsigned long asid_mask;
> -
>  static inline void local_flush_tlb_all(void)
>  {
>         __asm__ __volatile__ ("sfence.vma" : : : "memory");
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 43d005f63253..b5170ac1b742 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,6 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -unsigned long asid_mask;
>
>  static atomic_long_t current_version;
>
> @@ -128,7 +127,7 @@ static unsigned long __new_context(struct mm_struct *=
mm)
>                 goto set_asid;
>
>         /* We're out of ASIDs, so increment current_version */
> -       ver =3D atomic_long_add_return_relaxed(num_asids, &current_versio=
n);
> +       ver =3D atomic_long_add_return_relaxed(BIT(SATP_ASID_BITS), &curr=
ent_version);
>
>         /* Flush everything  */
>         __flush_context();
> @@ -247,7 +246,6 @@ static int __init asids_init(void)
>         /* Pre-compute ASID details */
>         if (asid_bits) {
>                 num_asids =3D 1 << asid_bits;
> -               asid_mask =3D num_asids - 1;
>         }
>
>         /*
> @@ -255,7 +253,7 @@ static int __init asids_init(void)
>          * at-least twice more than CPUs
>          */
>         if (num_asids > (2 * num_possible_cpus())) {
> -               atomic_long_set(&current_version, num_asids);
> +               atomic_long_set(&current_version, BIT(SATP_ASID_BITS));
>
>                 context_asid_map =3D bitmap_zalloc(num_asids, GFP_KERNEL)=
;
>                 if (!context_asid_map)
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

