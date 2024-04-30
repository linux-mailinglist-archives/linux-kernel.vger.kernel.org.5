Return-Path: <linux-kernel+bounces-163897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580368B756C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3261C20CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8113D605;
	Tue, 30 Apr 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xqDDyV7K"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C911168A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478915; cv=none; b=fUxkkweY/11MwVj6I++Xw22Ah5rbfnDNCnBGmZsF4BXYhfOo/D4Y7KpTIdEIVUZd+2y0f/gz+/wQcDc7W7/6VCuKOtc4SH2dm+NR58+IxiDtO02aeD8b/h/ygpmXKvNAsv+/Ji2T4cJ58zv3YOny25Jl8pIlZDxQK8cfO0IFUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478915; c=relaxed/simple;
	bh=UuAs5+rAMFuL0jXovFYLWPJDlHrisC0vR9SYYX7VI6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D943/4Y1ccWjUr4bFy3h0Nk3n5bl8vT4nWWEIwQBhsh8ZdkDl68ey2QRfrjRrq1lJyKALgtBWkG1rds54RZIE7yXvOQHIgR8nCqXO0QomckzmRLlEqhSbYY/ggTDuBg7eC4o8dPw4J4ZC115viyr5A8AWJIUAJZ3Szpkj/8m9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xqDDyV7K; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51d62b0ecb7so4268343e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714478909; x=1715083709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ6Nx9wmrtsMuP80/pZf8GuWEM5x1xcyjgdg3VGy0uM=;
        b=xqDDyV7KLuUEnEquIMz/EI+QvuiwnC6JuIFJFNpLQehhooynihyhXgGBOOlOfHh9EK
         eWnJXsRIsvCJh0oOxwO9hcgxaL6WdEmJEA4/P9Jo7W3a1CmQuC8lH0gif2Y+MqJiwFGV
         W++MIJ7Fipb7qK0vzQ3fdkWOqxV5HRYERST/g+DAX4i2dS90u0IaicJ8VvFRbYE9ENGN
         85HRi+9xKSva0uP05npK/dyLZ/a+/Gh4XIt2ZY0sm1CygMxVdwX42jbxzIOAlUYu6E2l
         6o3mWkbmYH3Wr88rpwK/2R5qx1d2ieNj9zh8NaGSZ0d7LN/ZqKfcDwKRVXT69mRa5dlz
         4aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478909; x=1715083709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ6Nx9wmrtsMuP80/pZf8GuWEM5x1xcyjgdg3VGy0uM=;
        b=DGWV1EJX/EuNbJyM/wTizlVO+AqE37WCGIS0u464J6+AWfso6mojuXXJtY8iIClf5v
         6IOTwSkJ+e9mOKYpXx9w5wYeF1kAMudlCFONZkewkHhlEK4cZHkucsuB5IXc/fL9VqSW
         X0QxA8/eCNz1atFK8dUa1RPViInOeMxl7bV47XEyAQjxVeFjQgDetCaUXoniNZzpRB3X
         7LVJbPXOR4YnDRKAYwnHuwkOSry60mHWSddcLNzr8KmivnZZi8eCOtkiv8LXiQE3mCQb
         p/XO8XXz3RblnT06yvv1xngVTRcTYm6vFSTsT37elOpbo6w3QQ2K6w3ajhaIoGvqGHz7
         APEA==
X-Forwarded-Encrypted: i=1; AJvYcCU3u0iWaY+McacH4cZjaUpcjrDzLHwqn14Ta7+3I8q/4fkcHM2DorzKvPuoVpqG1UXlkZOX5Xh6++LJRRPgzvsVxPQUltAVDlaHH57n
X-Gm-Message-State: AOJu0YwRi2iXVcM7RI7TgUE1Rf/PJFaPwDdvtJG7SLAXN638CZpDz5Zd
	PEpjcfXwYO+tW5wpHrBWGkHlp7b0JEF3wLTRUIxZp4VqLHZbBdruCeK0X5bwEY5hLAKrDLOzDmA
	F5jVwxf6EQyTj51LxWJ1qjG3AGGz9Y2//bvzlqA==
X-Google-Smtp-Source: AGHT+IHD6m1WFymzB3FxzKHLfG3Gat7aDGcy2yMdj4XhSl/dAkvo4Sowq5pD7oXAc65G9I4/G5acxpPrfr2NdHiVPeM=
X-Received: by 2002:ac2:44cf:0:b0:51d:9aa7:23e with SMTP id
 d15-20020ac244cf000000b0051d9aa7023emr4848635lfm.65.1714478909224; Tue, 30
 Apr 2024 05:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430092211.26269-1-gaoshanliukou@163.com>
In-Reply-To: <20240430092211.26269-1-gaoshanliukou@163.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 30 Apr 2024 14:08:18 +0200
Message-ID: <CAHVXubg0u9tj4w=gUkPiZWfAKNo_frRErQHS2TqzOR8yeUdBjA@mail.gmail.com>
Subject: Re: [PATCH V1] riscv: mm: Support > 1GB kernel image size when
 creating early page table
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	akpm@linux-foundation.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alex@ghiti.fr, 
	"yang.zhang" <yang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Tue, Apr 30, 2024 at 11:24=E2=80=AFAM yang.zhang <gaoshanliukou@163.com>=
 wrote:
>
> From: "yang.zhang" <yang.zhang@hexintek.com>
>
> By default, when creating early page table, only one PMD page table, but
> if kernel image size exceeds 1GB, it need two PMD page table, otherwise,
> it would BUG_ON in create_kernel_page_table.
>
> In addition, if trap earlier, trap vector doesn't yet set properly, curre=
nt
> value maybe set by previous firmwire, typically it's the _start of kernel=
,
> it's confused and difficult to debuge, so set it earlier.

Totally agree with that, I'm used to debugging this part of the code
and I know stvec points to __start and not handle_exception at this
point...But that deserves a fix indeed, it's confusing. I don't see
this fix in the patch below though?

> ---
> I'm not sure whether hugesize kernel is reasonable, if not, ignore this p=
atch.

Unless you have a good use case for this, I don't think that's
necessary, we never encountered such situations so I'd rather not
complicate this code even more.

Thanks,

Alex

> This issue can be reproduced simpily by changing '_end' in vmlinux.lds.S
> such as _end =3D . + 0x40000000=EF=BC=9B
>
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> ---
>  arch/riscv/mm/init.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fe8e159394d8..094b39f920d3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -386,11 +386,13 @@ static void __init create_pte_mapping(pte_t *ptep,
>  static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> +static pmd_t early_pmd2[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  #ifdef CONFIG_XIP_KERNEL
>  #define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
>  #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
>  #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
> +#define early_pmd2      ((pmd_t *)XIP_FIXUP(early_pmd2))
>  #endif /* CONFIG_XIP_KERNEL */
>
>  static p4d_t trampoline_p4d[PTRS_PER_P4D] __page_aligned_bss;
> @@ -432,9 +434,14 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t p=
a)
>
>  static phys_addr_t __init alloc_pmd_early(uintptr_t va)
>  {
> -       BUG_ON((va - kernel_map.virt_addr) >> PUD_SHIFT);
> +       uintptr_t end_pud_idx =3D pud_index(kernel_map.virt_addr + kernel=
_map.size - 1);
> +       uintptr_t current_pud_idx =3D pud_index(va);
>
> -       return (uintptr_t)early_pmd;
> +       BUG_ON(current_pud_idx > end_pud_idx);
> +       if (current_pud_idx =3D=3D end_pud_idx)
> +               return (uintptr_t)early_pmd2;
> +       else
> +               return (uintptr_t)early_pmd;
>  }
>
>  static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
> @@ -769,6 +776,18 @@ static void __init set_mmap_rnd_bits_max(void)
>         mmap_rnd_bits_max =3D MMAP_VA_BITS - PAGE_SHIFT - 3;
>  }
>
> +static pmd_t *__init select_pmd_early(uintptr_t pa)
> +{
> +       uintptr_t end_pud_idx =3D pud_index(kernel_map.phys_addr + kernel=
_map.size - 1);
> +       uintptr_t current_pud_idx =3D pud_index(pa);
> +
> +       BUG_ON(current_pud_idx > end_pud_idx);
> +       if (current_pud_idx =3D=3D end_pud_idx)
> +               return early_pmd2;
> +       else
> +               return early_pmd;
> +}
> +
>  /*
>   * There is a simple way to determine if 4-level is supported by the
>   * underlying hardware: establish 1:1 mapping in 4-level page table mode
> @@ -780,6 +799,7 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>         u64 identity_satp, hw_satp;
>         uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & =
PMD_MASK;
>         u64 satp_mode_cmdline =3D __pi_set_satp_mode_from_cmdline(dtb_pa)=
;
> +       pmd_t *target_pmd, *target_pmd2;
>
>         if (satp_mode_cmdline =3D=3D SATP_MODE_57) {
>                 disable_pgtable_l5();
> @@ -789,17 +809,24 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>                 return;
>         }
>
> +       target_pmd =3D select_pmd_early(set_satp_mode_pmd);
> +       target_pmd2 =3D select_pmd_early(set_satp_mode_pmd + PMD_SIZE);
>         create_p4d_mapping(early_p4d,
>                         set_satp_mode_pmd, (uintptr_t)early_pud,
>                         P4D_SIZE, PAGE_TABLE);
>         create_pud_mapping(early_pud,
> -                          set_satp_mode_pmd, (uintptr_t)early_pmd,
> +                          set_satp_mode_pmd, (uintptr_t)target_pmd,
> +                          PUD_SIZE, PAGE_TABLE);
> +       /* Handle the case where set_satp_mode straddles 2 PUDs */
> +       if (target_pmd2 !=3D target_pmd)
> +               create_pud_mapping(early_pud,
> +                          set_satp_mode_pmd + PMD_SIZE, (uintptr_t)targe=
t_pmd2,
>                            PUD_SIZE, PAGE_TABLE);
>         /* Handle the case where set_satp_mode straddles 2 PMDs */
> -       create_pmd_mapping(early_pmd,
> +       create_pmd_mapping(target_pmd,
>                            set_satp_mode_pmd, set_satp_mode_pmd,
>                            PMD_SIZE, PAGE_KERNEL_EXEC);
> -       create_pmd_mapping(early_pmd,
> +       create_pmd_mapping(target_pmd2,
>                            set_satp_mode_pmd + PMD_SIZE,
>                            set_satp_mode_pmd + PMD_SIZE,
>                            PMD_SIZE, PAGE_KERNEL_EXEC);
> @@ -829,7 +856,9 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>         memset(early_pg_dir, 0, PAGE_SIZE);
>         memset(early_p4d, 0, PAGE_SIZE);
>         memset(early_pud, 0, PAGE_SIZE);
> -       memset(early_pmd, 0, PAGE_SIZE);
> +       memset(target_pmd, 0, PAGE_SIZE);
> +       if (target_pmd2 !=3D target_pmd)
> +               memset(target_pmd2, 0, PAGE_SIZE);
>  }
>  #endif
>
> --
> 2.25.1
>

