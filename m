Return-Path: <linux-kernel+bounces-16654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90298241F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832B3286D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18D21A1B;
	Thu,  4 Jan 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q5/tUaq3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C1219EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a277339dcf4so50894666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704371971; x=1704976771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzvOTQrYsC64lRjX0Rt7BbitXgRl8QC6qZq6acvuD1g=;
        b=q5/tUaq30XHM3OWFF3UKTf1vU4Tvhlmb6HLtzdTo7SURp6qP4xAdD8r4vIIbwvrzld
         C5CSEmsEDpwnx2aml7Noy4ANWFjqAdq/zCBcdxVc5LLYI6U7B8qWLTrumKh0HP2kc6ES
         dxxvNlvmgZUEtUAEGC4NRqG/RRyNbM2eYkGlwtzZ1WD+4wmTNRr8Bg0hn2s3XuBMjW3S
         rlM7fLWtvx5Y2biaOSA4Gc31Z2lY2tAAO6DOlaTRg4kmOnZzBqYw8DG2xAqnFEHgRLve
         iJEBxGsfa8dRLP5zUabC7tKHg8PW9oPKlfIXk4/gkaEouKo2QjXZKpyy2Z9rGv84YGYD
         Lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371971; x=1704976771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzvOTQrYsC64lRjX0Rt7BbitXgRl8QC6qZq6acvuD1g=;
        b=gqz1jw3PRLHcN//RhDKvWNRp/kbMxlfBLrXZkDPqWp0yHHN4OtVGRI45q2ifvxYh66
         tQmyw8S1x8dRxpWcWs3nmtRo/ILgP1579JXxnH/F//nEbNEutgl92YJoa87+5BJG/3Zc
         1o1uib574GJ5ih7AdMAfEvOi8I3wPo+2JdubgqOlWbqzirp3ZeETcgcwIRG5sc8liT3Q
         Dr/wufN5VPObGTkfF/TA63otVc4RFpI2g5B12iwam7n8G1nYiAZbtg0NdwDZhiBinf1B
         K3wTXE/xGGtnEyrPr8gQ01XbVZmW7v55at1x/nhBsxeQL2dgnHP8p2WXD2c0EGBxtJmc
         WMKg==
X-Gm-Message-State: AOJu0YwemaEm2hhbtwEk/Br2EEgQcfWiePpJKhsf8OrT6gRctL43VoSH
	b9kksyCWqo8g+NyWoTuZglmBuiHOvOqNUuIJN5k1K5ou2URAWQ==
X-Google-Smtp-Source: AGHT+IEeRR4I3uWL5TxDjZ3qrupVtXYMaBZuKr0o+l32Kjda9sN5IKWIaRFz0g22rzETebnGyfVZeFTdsQogwR+pnjM=
X-Received: by 2002:a17:907:76a8:b0:a26:9916:a46b with SMTP id
 jw8-20020a17090776a800b00a269916a46bmr317729ejc.33.1704371971601; Thu, 04 Jan
 2024 04:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-9-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-9-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:39:20 +0100
Message-ID: <CAHVXubhKrC_7DEBXR_wCP9g7-KfWg9nuyim7+X1Ja2gh8s9+HA@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] riscv: mm: Introduce cntx2asid/cntx2version
 helper macros
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> When using the ASID allocator, the MM context ID contains two values:
> the ASID in the lower bits, and the allocator version number in the
> remaining bits. Use macros to make this separation more obvious.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/include/asm/mmu.h |  3 +++
>  arch/riscv/mm/context.c      | 12 ++++++------
>  arch/riscv/mm/tlbflush.c     |  2 +-
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 355504b37f8e..a550fbf770be 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -26,6 +26,9 @@ typedef struct {
>  #endif
>  } mm_context_t;
>
> +#define cntx2asid(cntx)                ((cntx) & asid_mask)
> +#define cntx2version(cntx)     ((cntx) & ~asid_mask)

Not a big fan of the naming, I would have something like
get_asid_from_context() and get_version_from_context() or something
like that, but up to you of course.

> +
>  void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa=
,
>                                phys_addr_t sz, pgprot_t prot);
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 217fd4de6134..43d005f63253 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -81,7 +81,7 @@ static void __flush_context(void)
>                 if (cntx =3D=3D 0)
>                         cntx =3D per_cpu(reserved_context, i);
>
> -               __set_bit(cntx & asid_mask, context_asid_map);
> +               __set_bit(cntx2asid(cntx), context_asid_map);
>                 per_cpu(reserved_context, i) =3D cntx;
>         }
>
> @@ -102,7 +102,7 @@ static unsigned long __new_context(struct mm_struct *=
mm)
>         lockdep_assert_held(&context_lock);
>
>         if (cntx !=3D 0) {
> -               unsigned long newcntx =3D ver | (cntx & asid_mask);
> +               unsigned long newcntx =3D ver | cntx2asid(cntx);
>
>                 /*
>                  * If our current CONTEXT was active during a rollover, w=
e
> @@ -115,7 +115,7 @@ static unsigned long __new_context(struct mm_struct *=
mm)
>                  * We had a valid CONTEXT in a previous life, so try to
>                  * re-use it if possible.
>                  */
> -               if (!__test_and_set_bit(cntx & asid_mask, context_asid_ma=
p))
> +               if (!__test_and_set_bit(cntx2asid(cntx), context_asid_map=
))
>                         return newcntx;
>         }
>
> @@ -168,7 +168,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigne=
d int cpu)
>          */
>         old_active_cntx =3D atomic_long_read(&per_cpu(active_context, cpu=
));
>         if (old_active_cntx &&
> -           ((cntx & ~asid_mask) =3D=3D atomic_long_read(&current_version=
)) &&
> +           (cntx2version(cntx) =3D=3D atomic_long_read(&current_version)=
) &&
>             atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
>                                         old_active_cntx, cntx))
>                 goto switch_mm_fast;
> @@ -177,7 +177,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigne=
d int cpu)
>
>         /* Check that our ASID belongs to the current_version. */
>         cntx =3D atomic_long_read(&mm->context.id);
> -       if ((cntx & ~asid_mask) !=3D atomic_long_read(&current_version)) =
{
> +       if (cntx2version(cntx) !=3D atomic_long_read(&current_version)) {
>                 cntx =3D __new_context(mm);
>                 atomic_long_set(&mm->context.id, cntx);
>         }
> @@ -191,7 +191,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigne=
d int cpu)
>
>  switch_mm_fast:
>         csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
> -                 ((cntx & asid_mask) << SATP_ASID_SHIFT) |
> +                 (cntx2asid(cntx) << SATP_ASID_SHIFT) |
>                   satp_mode);
>
>         if (need_flush_tlb)
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 76b24d4ed4ab..5ec621545c69 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -85,7 +85,7 @@ static void __flush_tlb_range(struct mm_struct *mm, uns=
igned long start,
>                         return;
>
>                 if (static_branch_unlikely(&use_asid_allocator))
> -                       asid =3D atomic_long_read(&mm->context.id) & asid=
_mask;
> +                       asid =3D cntx2asid(atomic_long_read(&mm->context.=
id));
>         } else {
>                 cmask =3D cpu_online_mask;
>         }
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

