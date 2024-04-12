Return-Path: <linux-kernel+bounces-141914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800068A2511
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F891C20F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351518044;
	Fri, 12 Apr 2024 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUtBk9Kt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41621F5FF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895483; cv=none; b=cetJuOCXQPc2fpZKyY1OQPKaHK5tMUfe31IkEQS5IoMe57Vb5qAs+AGyLhBhep7TFzMgSMhU8Tp2yGQ/RwLC+IvlZshULce7ERdazF7Y5NXV7bKQn3oUQPNAbxKrmQoa1g5pLuB0gYgiqlHkqHupcoiIa3a3gB1nXsQUxogGX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895483; c=relaxed/simple;
	bh=Rs6KpGntHCw4Yqslf2bcFsD9oUEkwjTy3lZ29ZNks2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8UUqaH1P4cF+Lw9tJ8DsAktg1FiXI9pO612zbaKmeZfuOmyy2GIMQGAYZL27reNkMO4dtjGttAJZL71LpgiimPfdKQmLpTf3tSnQQTJgNjMMYHxj1ak1LlMZkjLRrlrRqh2t04Y04jd0mjTK3+I71Sn2OrDm0IrMwzmx7QKMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUtBk9Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F0C4AF08
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712895482;
	bh=Rs6KpGntHCw4Yqslf2bcFsD9oUEkwjTy3lZ29ZNks2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUtBk9KtFqJI+UQlt0ApruN5aBNHlZbvkbOckd8ziZLXDZfNVgF7uC9qVaPnxLn2Y
	 8ehodt8dWSY+IoOUo2uUHnRuoVi1MD68nR8aLjRAJXYVp+Fhyrb7CBKz1GxtWkVrWW
	 04GtGTS+mcJLpoeCU5EcQk0d0kxMftVRHtXGyTOyUIeOzC0ZYFgCr22RmnsEwWc3lg
	 CD+p4AvTR7rWmM7QEWVeRKzQ7VUboGq1QxICzqIfO0sTjGv4IH04HRtMJQdIRf96dR
	 Y0dCiVMtbY4vAGZAt7YtZEV5TiPSZ88h1a6qk4DMCXT6yInwztRQiNyxFvjrJ/1rCn
	 dmOKx0pA8uLDQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a52223e004dso43867966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:18:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgH6nq8F4k8Ovubptfop1fxO7gMa+xNxs0/F1G5XDNMSOA+CF1DUFYQgyOGpc3ZSqStbiUR8gUDb6MkmrkwHjQaYAog7p8OKg/EBal
X-Gm-Message-State: AOJu0YxicFzPt6Fd/75akB/BXp1igCYrPSed2EWuV5Kgj36y2iwILpic
	xBme5VzLCPC7CDRxeMnOpfg1OzVfPOWbleNeEuJQ4A6HkpyR2numOltOCXnu/7uX6t71fYGbFL4
	hIRzMospoTKnJazS1ioCaFjCpXLk=
X-Google-Smtp-Source: AGHT+IFYR5HCm3SSxFDMVvvI/UdaA9zyJSKqVqwbLkJcA88e9XoV146pitINbiUotL67uHM+pps74EmDPuIAgZou5nU=
X-Received: by 2002:a17:906:80c7:b0:a52:1a78:e3ca with SMTP id
 a7-20020a17090680c700b00a521a78e3camr1209261ejx.6.1712895480760; Thu, 11 Apr
 2024 21:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411010510.22135-1-yangtiezhu@loongson.cn> <20240411010510.22135-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240411010510.22135-3-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Apr 2024 12:17:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73d5hVM+anfHhTFHjWDmVtC2TJdxU9hANJvQgm-E3g6w@mail.gmail.com>
Message-ID: <CAAhV-H73d5hVM+anfHhTFHjWDmVtC2TJdxU9hANJvQgm-E3g6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] LoongArch: Refactor get_acpi_id_for_cpu() related code
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Thu, Apr 11, 2024 at 9:05=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, cpu_logical_map(cpu) is defined as __cpu_logical_map[cpu]
> in arch/loongarch/include/asm/smp.h and __cpu_logical_map[] is defined
> in arch/loongarch/kernel/smp.c, that is to say, cpu_logical_map(cpu) is
> vaild only under CONFIG_SMP, the implementation of get_acpi_id_for_cpu()
> which calls cpu_logical_map(cpu) is not suitable for the case of non-SMP,
> so refactor get_acpi_id_for_cpu() related code to make it work well for
> both SMP and non-SMP.
But you implement cpu_logical_map(cpu) for non-SMP in the 4th patch, right?

Huacai
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/acpi.h | 7 ++++++-
>  arch/loongarch/kernel/acpi.c      | 9 ++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 49e29b29996f..a4ad3f75bd60 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -39,9 +39,14 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_COR=
E_PIC];
>
>  extern int __init parse_acpi_topology(void);
>
> +static inline struct acpi_madt_core_pic *acpi_cpu_get_core_pic(int cpu)
> +{
> +       return &acpi_core_pic[cpu];
> +}
> +
>  static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>  {
> -       return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
> +       return acpi_cpu_get_core_pic(cpu)->processor_id;
>  }
>
>  #endif /* !CONFIG_ACPI */
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 5cf59c617126..ccfa90faf0ea 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -98,8 +98,15 @@ acpi_parse_processor(union acpi_subtable_headers *head=
er, const unsigned long en
>                 return -EINVAL;
>
>         acpi_table_print_madt_entry(&header->common);
> +
> +       /*
> +        * When CONFIG_SMP is disabled, mapping won't be created for all =
cpus.
> +        * CPUs more than num_possible_cpus will be ignored.
> +        */
> +       if (processor->core_id >=3D 0 && processor->core_id < num_possibl=
e_cpus())
> +               acpi_core_pic[processor->core_id] =3D *processor;
> +
>  #ifdef CONFIG_SMP
> -       acpi_core_pic[processor->core_id] =3D *processor;
>         set_processor_mask(processor->core_id, processor->flags);
>  #endif
>
> --
> 2.42.0
>

