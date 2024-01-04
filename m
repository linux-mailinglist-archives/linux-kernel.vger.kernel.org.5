Return-Path: <linux-kernel+bounces-16672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAF82422B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27311C23CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BDF22314;
	Thu,  4 Jan 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OBP2tchA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602922313
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a277339dcf4so53111766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704373311; x=1704978111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9OiB6Zr2X3JWx8/EcNzOysEraumuG0RSKA4yvIy1vs=;
        b=OBP2tchA7eqlftKEe+yssQUdkFMNvpE5MyqZ9mLlC1foecl0GUqlgg9d3B8NpgF0Q4
         r2peT0SHRZOHpsOrUJFy8oR+prZ8JkUmjef2Y30qEnjWUGDtI/S6pgiMgxqVHm44d/FF
         2NRVtFVG39kImE/YeZshdxEyXHS3nz+8KTFzjoiOnWBgEQbm1XkySHAIDICjmXqNQA3U
         KBM5jVrkD34B4VmMx8ver8vO/A31jl8ys9NLil31IHuQAOf4eh31p5APBw9b6UO4G0G2
         nEnAsmWe4RSvnMvLcHAwmiEW3v1VfIFkPWW9wPTD6jyGur9V4F1z/nT8sLuTM4MrWT7h
         il6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373311; x=1704978111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9OiB6Zr2X3JWx8/EcNzOysEraumuG0RSKA4yvIy1vs=;
        b=OZvd2hdGaxlvuUjJvtwd7JCEhXJFsdwKi1e/XhpUdXXYOVpMVZL2Bvh4sPKd4FrT/8
         E0rkAnKeBy6+cMIHx2Y1j5GI2eLilcMpDpb4EMwdzoLbOyech3sfhnGGUPQK/yhXzSfG
         uTJBN/PHK/jmjiDKxERrnkxFRXsV/tf+uclaulR4e3O7K7GIv7lhvn+UjIFOF22D75Z1
         5OgdgDRMEYdxiL5snHmHaMPifE4tEwUJkysXoP88g0uOKcUH6hW5x6HDwXbShg1jQBPP
         jDEo0BPVpjvGhjcmwGa4EuinRzp0kNORmZIQar1EWfOSeR1L3D0JSg0LsGxhL7O8lWj+
         oHLw==
X-Gm-Message-State: AOJu0YzsGldweaPLPrLCNUiIFhzg/FDlURNQAKtS+x8hiVDf8ymFtQ7c
	eaxSdWQouVgUtllyU9Nvm3FGxQMtgBI91o6SuZj1A+djMHdgvkZMMrQKYNUrg7c=
X-Google-Smtp-Source: AGHT+IGv4Nd1O7QiBVZ3icJngtwYGoUCGkSaR0BhUpZqYDOqHIhgeGA1hyWSfztxKwIkK4DFZEIwm3bDuFwwIzHa8xc=
X-Received: by 2002:a17:907:76ac:b0:a28:b9b8:2f8c with SMTP id
 jw12-20020a17090776ac00b00a28b9b82f8cmr268278ejc.152.1704373311541; Thu, 04
 Jan 2024 05:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-13-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-13-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 14:01:40 +0100
Message-ID: <CAHVXubit8obRHkW9Uw+Ah=1y7cg-_y_8Ho=kzonjLFmeGYZwqQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] riscv: mm: Always use an ASID to flush mm contexts
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Even if multiple ASIDs are not supported, using the single-ASID variant
> of the sfence.vma instruction preserves TLB entries for global (kernel)
> pages. So it is always more efficient to use the single-ASID code path.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - There is now only one copy of __flush_tlb_range()
>
> Changes in v2:
>  - Update both copies of __flush_tlb_range()
>
>  arch/riscv/include/asm/mmu_context.h | 2 --
>  arch/riscv/mm/context.c              | 3 +--
>  arch/riscv/mm/tlbflush.c             | 3 +--
>  3 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
> index 7030837adc1a..b0659413a080 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *=
tsk,
>         return 0;
>  }
>
> -DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> -
>  #include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 3ca9b653df7d..20057085ab8a 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -18,8 +18,7 @@
>
>  #ifdef CONFIG_MMU
>
> -DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> -
> +static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>  static unsigned long num_asids;
>
>  static atomic_long_t current_version;
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 5ec621545c69..39d80f56d292 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -84,8 +84,7 @@ static void __flush_tlb_range(struct mm_struct *mm, uns=
igned long start,
>                 if (cpumask_empty(cmask))
>                         return;
>
> -               if (static_branch_unlikely(&use_asid_allocator))
> -                       asid =3D cntx2asid(atomic_long_read(&mm->context.=
id));
> +               asid =3D cntx2asid(atomic_long_read(&mm->context.id));
>         } else {
>                 cmask =3D cpu_online_mask;
>         }
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex

