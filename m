Return-Path: <linux-kernel+bounces-16630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55B824173
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82941282F40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6332137C;
	Thu,  4 Jan 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qYg227Hf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55C22306
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28ac851523so53323866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704370518; x=1704975318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+6JCj5wYflPgWTMV3PjMKTTuzLUTwn0VcjXquQfIU=;
        b=qYg227HfYuTHHx/pY6YoFhRxMIAz6zv5CzOHaV+r2hjw9WcfNAW2rnjzEy//J6PT+q
         IMtMenrLToUSdFuqk+mmwumKm6ur0BPJsVjz6hlK/Ir0dGYd497U4DgDj7L0qRhV5HPI
         aVAWWUqs8c+LIOiBCUfmeG3nkmsZbax0ai9Um+Uzjc5iZ5bJhGLhGwxedighPnRL7j70
         fiziX5eY5H6YfW7q64ZeaZeJPmzyq1l25wOlX20Qvcjf9LNftaXxMt1mSgVObX6ru2Ya
         StqVKOrqRJLGA9I4cn1M51Y5myzdNoQs9BBxg5R2T8Xg+PhmCiUnt2shNbyvinUlv6jN
         saEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704370518; x=1704975318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+6JCj5wYflPgWTMV3PjMKTTuzLUTwn0VcjXquQfIU=;
        b=rrOj5VZoiPbvR5WNkrZeI7+ba8PzS+qFkMyStN5aT+gwdISsX3aS8dRQ4JSK1Pri1x
         RaYF1EaZV3TW0h11OWjDzqqBmX3hEUS2ry5Dsaow+bj1GUlyUiBTJuePtNpPjuaSFf6f
         URtnxVwX0TwvV7LXhS5NRSW0pZcRTJHnaLsx1cK+V90aVRwVWPZvOc9JnCZ+bbnihYJi
         PYwB8zpPEWmV5Ebx89092xBGMUseCZMc4uwQM+kunt2NtE/Z5FGqOv4qWJzMI1gNvpSV
         RmJKZuH8n3HPY/xMMjB/BBlEhvgrAdFqE/XqMTKduQ+2+kWRFkupDvdkV2UBqTjrnJFu
         msDg==
X-Gm-Message-State: AOJu0YxiihHuNgV+BHO08g9p9v4O4rs4Qa1nuyVvaAVLX+HUI4bNNncB
	wcOS6+tWDcihiQJEdXgIrOWRizbyRc/DwdLPmtXMc7rK9XzKaw==
X-Google-Smtp-Source: AGHT+IF9Amr8wIXPEypRo0GIvsDglsBnqIGOchyL8FhWSlxQUjRa7UeZ2A4lWZZ/ocajCTpC9tPfEgqs7RAQB3z4QPc=
X-Received: by 2002:a17:906:f807:b0:a23:7332:9258 with SMTP id
 kh7-20020a170906f80700b00a2373329258mr273790ejb.119.1704370517784; Thu, 04
 Jan 2024 04:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-4-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-4-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:15:06 +0100
Message-ID: <CAHVXubjv58osbweO8AtyubLq=Zd7GW5aaeO6qFdb-QLTKrzT4g@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] riscv: mm: Broadcast kernel TLB flushes only
 when needed
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> __flush_tlb_range() avoids broadcasting TLB flushes when an mm context
> is only active on the local CPU. Apply this same optimization to TLB
> flushes of kernel memory when only one CPU is online. This check can be
> constant-folded when SMP is disabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/mm/tlbflush.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 09b03bf71e6a..2f18fe6fc4f3 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -98,27 +98,23 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>  {
>         const struct cpumask *cmask;
>         unsigned long asid =3D FLUSH_TLB_NO_ASID;
> -       bool broadcast;
> +       unsigned int cpu;
>
>         if (mm) {
> -               unsigned int cpuid;
> -
>                 cmask =3D mm_cpumask(mm);
>                 if (cpumask_empty(cmask))
>                         return;
>
> -               cpuid =3D get_cpu();
> -               /* check if the tlbflush needs to be sent to other CPUs *=
/
> -               broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> -
>                 if (static_branch_unlikely(&use_asid_allocator))
>                         asid =3D atomic_long_read(&mm->context.id) & asid=
_mask;
>         } else {
>                 cmask =3D cpu_online_mask;
> -               broadcast =3D true;
>         }
>
> -       if (!broadcast) {
> +       cpu =3D get_cpu();
> +
> +       /* Check if the TLB flush needs to be sent to other CPUs. */
> +       if (cpumask_any_but(cmask, cpu) >=3D nr_cpu_ids) {
>                 local_flush_tlb_range_asid(start, size, stride, asid);
>         } else if (riscv_use_sbi_for_rfence()) {
>                 sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> @@ -132,8 +128,7 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>                 on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd,=
 1);
>         }
>
> -       if (mm)
> -               put_cpu();
> +       put_cpu();
>  }
>
>  void flush_tlb_mm(struct mm_struct *mm)
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

