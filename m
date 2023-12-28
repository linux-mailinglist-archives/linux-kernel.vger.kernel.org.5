Return-Path: <linux-kernel+bounces-12334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BB81F391
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC492821BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF41104;
	Thu, 28 Dec 2023 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcE6dSn3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED6ED8;
	Thu, 28 Dec 2023 01:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D20C433CA;
	Thu, 28 Dec 2023 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703726669;
	bh=xHv0G5x2J88Pxkc5+do8/plUomGlF6DSGjvbPx0NqpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CcE6dSn38KviQaoBTEb20h9ZVUMPTA2s8akbRkuOm26TEvOGVjXZneVUz4aJTlIKE
	 3Rhq6RVYaNuDFIzZl29dGop+46nsrNwLZvol7cFBwIQWjO4hkLXtJlIWzS4S/TQWKU
	 yuZWPfprwIX2/DIM0RntYaUhdSjrKNkgnfFrawW3fC715HmwiSf8Zehzdpl+BBFS2h
	 fiLx5r6hy+L3RXDIV8xYgjr5x5+G1O1RO3t6SFLsYrmLri6mHLesZg9H3e8vnE/TCK
	 ftZRtWKIu/aMmUD3HeUkRR3TekspNrGV3hsZgIKrfmi2sGDDhVl4ZVU9xkp5nJjoEl
	 etJCSIWlvOhqA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554cffbad2fso3017261a12.1;
        Wed, 27 Dec 2023 17:24:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwUxzKJqcVbJX1xiRn22mGKM3LP8ROts+ahWG8IZuOkyVgybeev
	eRnYJoPQbYrRKQCbqaz1CqPEhIF48yTxy/MUQ14=
X-Google-Smtp-Source: AGHT+IFNl2QaHwhfSPIRRVVE8SAHU4vy7JEojJZherbgfMXxrnWyDyJ1X3+yW1jGo2jOr7eOOx5vEbZdnvTi/z8LSnw=
X-Received: by 2002:a17:906:1688:b0:a23:665f:3981 with SMTP id
 s8-20020a170906168800b00a23665f3981mr2482371ejd.88.1703726667507; Wed, 27 Dec
 2023 17:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW4PR84MB3145344537A6C6629398DF7C819FA@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB3145344537A6C6629398DF7C819FA@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 28 Dec 2023 09:24:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+oCWSLcRi87LeOxJg84DdPe=5pcAvNwwDs-ucTTAm2g@mail.gmail.com>
Message-ID: <CAAhV-H7+oCWSLcRi87LeOxJg84DdPe=5pcAvNwwDs-ucTTAm2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] LoongArch: use generic interface to support crashkernel=X,[high,low]
To: Youling Tang <youling.tang@outlook.com>
Cc: Jonathan Corbet <corbet@lwn.net>, WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, 
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

I squashed the two patches and applied here:
https://github.com/chenhuacai/linux/commits/loongarch-next

You can verify whether everything works.

Huacai

On Wed, Dec 27, 2023 at 8:31=E2=80=AFPM Youling Tang <youling.tang@outlook.=
com> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> LoongArch already supports two crashkernel regions in kexec-tools, so we
> can directly use the common interface to support crashkernel=3DX,[hign,lo=
w]
> after commit 0ab97169aa05("crash_core: add generic function to do reserva=
tion").
>
> With the help of newly changed function parse_crashkernel() and generic
> reserve_crashkernel_generic(), crashkernel reservation can be simplified
> by steps:
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
> Recommended usage in general:
> 1) In the case of small memory: crashkernel=3D512M
> 2) In the case of large memory: crashkernel=3D1024M,high crashkernel=3D12=
8M,low
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
> v2:
> Submit information and format adjustments.
>
>  arch/loongarch/Kconfig                  |  3 ++
>  arch/loongarch/include/asm/crash_core.h | 11 ++++++
>  arch/loongarch/kernel/setup.c           | 46 ++++++-------------------
>  3 files changed, 25 insertions(+), 35 deletions(-)
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
> index d183a745fb85..189cd9575758 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -252,38 +252,23 @@ static void __init arch_reserve_vmcore(void)
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
> +                               &crash_size, &crash_base, &low_size, &hig=
h);
> +       if (ret)
>                 return;
> -       }
>
> -       crashk_res.start =3D crash_base;
> -       crashk_res.end   =3D crash_base + crash_size - 1;
> -#endif
> +       reserve_crashkernel_generic(cmdline, crash_size, crash_base, low_=
size, high);
>  }
>
>  static void __init fdt_setup(void)
> @@ -357,7 +342,7 @@ static void __init bootcmdline_init(char **cmdline_p)
>  void __init platform_init(void)
>  {
>         arch_reserve_vmcore();
> -       arch_parse_crashkernel();
> +       arch_reserve_crashkernel();
>
>  #ifdef CONFIG_ACPI_TABLE_UPGRADE
>         acpi_table_upgrade();
> @@ -467,15 +452,6 @@ static void __init resource_init(void)
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
>

