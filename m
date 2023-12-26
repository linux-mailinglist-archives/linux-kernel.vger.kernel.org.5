Return-Path: <linux-kernel+bounces-11481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9A81E703
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BFB1C21EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83154E1B6;
	Tue, 26 Dec 2023 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyNboUkH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11224E1A5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E373C433CB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703588202;
	bh=7yAih3GoOhZJptIFU6wbb/T3rDQVto1u3wtn6V99Q58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UyNboUkHZ3yp9xrDbz26+3eqXg7xEPDTtbnO8//0pDVKSe9ALYoaLvSXxwPJidaka
	 KwCK4cbQGkPzbt7e6SZlfSwv4to5uaBvFA3nsQY67sdf1uBcrJpU9s1Ed29mqIzAzh
	 wJxN/4wnI2mt45YRCHCCQ1UYtE4PXJSkecD0kFSQdFKrJ1Zn7+a5IDC7dRnt74LZJa
	 TlsN1KAJ5ZWZyxCaCl/pGMo8/WDrrPdkkplgIVOpS9C6UfKm1uIIN3SZgDEWq+TDMh
	 l35CIiSBVx8my3MP6YTAaCZI3cO0vc7qz6XYhL4nzVUw9uGO48pfTo03W5/6WB4TV0
	 SgWRp+RWCHqoA==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33674f60184so4436042f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:56:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yxf1wAtcNwhceWGLiXoMcNlP6cFDogtgE9YD/Y6TwV2udN8B8vi
	LUb2Fju0YDpgAdp5eVwto/iYHlc07dkdnQIaVHc=
X-Google-Smtp-Source: AGHT+IHbqb3vaam+q4gKQoE0NvNshSmdiO+YiLKGmFfOA2Ah2IFBS74FiRRzitBz3c94Q+t3Z6zHJDT4hl2RRHLRNbY=
X-Received: by 2002:a05:600c:198a:b0:40d:5358:8d77 with SMTP id
 t10-20020a05600c198a00b0040d53588d77mr1900602wmq.80.1703588200833; Tue, 26
 Dec 2023 02:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW4PR84MB3145311E8DE893E89119FAFA8199A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB3145311E8DE893E89119FAFA8199A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Dec 2023 18:56:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Qka0yNMRwtk5aFOqBQchU__myZgH4EzNnKBwur86oDg@mail.gmail.com>
Message-ID: <CAAhV-H6Qka0yNMRwtk5aFOqBQchU__myZgH4EzNnKBwur86oDg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: use generic interface to support crashkernel=X,[high,low]
To: Youling Tang <youling.tang@outlook.com>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

On Mon, Dec 25, 2023 at 10:18=E2=80=AFPM Youling Tang <youling.tang@outlook=
.com> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> LoongArch already supports two crashkernel regions in kexec-tools, so we
> can directly use the common interface to support crashkernel=3DX,[hign,lo=
w].
>
> With the help of newly changed function parse_crashkernel() and generic
> reserve_crashkernel_generic(), crashkernel reservation can be simplified
> by steps:
It is better to refer the commits introduce those changes.

>
> 1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
>    DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;
>
> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>    reserve_crashkernel_generic();
>
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/loongarch/Kconfig.
>
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=3DX,high"; or reserve a memory range
> below 4G with "crashkernel=3DX,low". Besides, there are few rules need
> to take notice:
>
> 1) "crashkernel=3DX,[high,low]" will be ignored if "crashkernel=3Dsize"
>    is specified.
> 2) "crashkernel=3DX,low" is valid only when "crashkernel=3DX,high" is pas=
sed
>    and there is enough memory to be allocated under 4G.
> 3) When allocating crashkernel above 4G and no "crashkernel=3DX,low" is
>    specified, a 128M low memory will be allocated automatically for
>    swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
>
> Following test cases have been performed as expected:
It is better to group them into "Recommended use cases", "Valid use
cases (not recommended)" and "Invalid use cases".

> 1) crashkernel=3D256M                          //low=3D256M
> 2) crashkernel=3D1G                            //low=3D1G
> 3) crashkernel=3D4G                            //high=3D4G, low=3D128M(de=
fault)
> 4) crashkernel=3D4G crashkernel=3D256M,high      //high=3D4G, low=3D128M(=
default), high is ignored
> 5) crashkernel=3D4G crashkernel=3D256M,low       //high=3D4G, low=3D128M(=
default), low is ignored
> 6) crashkernel=3D4G,high                       //high=3D4G, low=3D128M(de=
fault)
> 7) crashkernel=3D256M,low                      //low=3D0M, invalid
> 8) crashkernel=3D4G,high crashkernel=3D256M,low  //high=3D4G, low=3D256M
> 9) crashkernel=3D4G,high crashkernel=3D4G,low    //high=3D0M, low=3D0M, i=
nvalid
> 10) crashkernel=3D512M@2560M                   //low=3D512M
> 11) crashkernel=3D1G,high crashkernel=3D0M,low   //high=3D1G, low=3D0M
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                  |  3 ++
>  arch/loongarch/include/asm/crash_core.h | 11 ++++++
>  arch/loongarch/kernel/setup.c           | 48 +++++++------------------
>  3 files changed, 27 insertions(+), 35 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/crash_core.h
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ee123820a476..02060b2ac3f2 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -575,6 +575,9 @@ config ARCH_SELECTS_CRASH_DUMP
>         depends on CRASH_DUMP
>         select RELOCATABLE
>
> +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +       def_bool CRASH_CORE
> +
>  config RELOCATABLE
>         bool "Relocatable kernel"
>         help
> diff --git a/arch/loongarch/include/asm/crash_core.h b/arch/loongarch/inc=
lude/asm/crash_core.h
> new file mode 100644
> index 000000000000..1f7040d8ed0f
> --- /dev/null
> +++ b/arch/loongarch/include/asm/crash_core.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LOONGARCH_CRASH_CORE_H
> +#define _LOONGARCH_CRASH_CORE_H
> +
> +#define CRASH_ALIGN                    SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX             SZ_4G
> +#define CRASH_ADDR_HIGH_MAX            memblock_end_of_DRAM()
> +
> +extern phys_addr_t memblock_end_of_DRAM(void);
> +#endif
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index d183a745fb85..2a69a36419da 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -252,38 +252,25 @@ static void __init arch_reserve_vmcore(void)
>  #endif
>  }
>
> -/* 2MB alignment for crash kernel regions */
> -#define CRASH_ALIGN    SZ_2M
> -#define CRASH_ADDR_MAX SZ_4G
> -
> -static void __init arch_parse_crashkernel(void)
> +static void __init arch_reserve_crashkernel(void)
>  {
> -#ifdef CONFIG_KEXEC
> -       int ret;
> -       unsigned long long total_mem;
> +       unsigned long long low_size =3D 0;
>         unsigned long long crash_base, crash_size;
> +       char *cmdline =3D boot_command_line;
> +       bool high =3D false;
> +       int ret;
>
> -       total_mem =3D memblock_phys_mem_size();
> -       ret =3D parse_crashkernel(boot_command_line, total_mem,
> -                               &crash_size, &crash_base,
> -                               NULL, NULL);
> -       if (ret < 0 || crash_size <=3D 0)
> +       if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>                 return;
>
> -       if (crash_base <=3D 0) {
> -               crash_base =3D memblock_phys_alloc_range(crash_size, CRAS=
H_ALIGN, CRASH_ALIGN, CRASH_ADDR_MAX);
> -               if (!crash_base) {
> -                       pr_warn("crashkernel reservation failed - No suit=
able area found.\n");
> -                       return;
> -               }
> -       } else if (!memblock_phys_alloc_range(crash_size, CRASH_ALIGN, cr=
ash_base, crash_base + crash_size)) {
> -               pr_warn("Invalid memory region reserved for crash kernel\=
n");
> +       ret =3D parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +                               &crash_size, &crash_base,
> +                               &low_size, &high);
This line can be merged with its above line.

> +       if (ret)
>                 return;
> -       }
>
> -       crashk_res.start =3D crash_base;
> -       crashk_res.end   =3D crash_base + crash_size - 1;
> -#endif
> +       reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> +                                   low_size, high);
They can be in one line.

Huacai
>  }
>
>  static void __init fdt_setup(void)
> @@ -357,7 +344,7 @@ static void __init bootcmdline_init(char **cmdline_p)
>  void __init platform_init(void)
>  {
>         arch_reserve_vmcore();
> -       arch_parse_crashkernel();
> +       arch_reserve_crashkernel();
>
>  #ifdef CONFIG_ACPI_TABLE_UPGRADE
>         acpi_table_upgrade();
> @@ -467,15 +454,6 @@ static void __init resource_init(void)
>                 request_resource(res, &data_resource);
>                 request_resource(res, &bss_resource);
>         }
> -
> -#ifdef CONFIG_KEXEC
> -       if (crashk_res.start < crashk_res.end) {
> -               insert_resource(&iomem_resource, &crashk_res);
> -               pr_info("Reserving %ldMB of memory at %ldMB for crashkern=
el\n",
> -                       (unsigned long)((crashk_res.end - crashk_res.star=
t + 1) >> 20),
> -                       (unsigned long)(crashk_res.start  >> 20));
> -       }
> -#endif
>  }
>
>  static int __init add_legacy_isa_io(struct fwnode_handle *fwnode,
> --
> 2.40.0
>

