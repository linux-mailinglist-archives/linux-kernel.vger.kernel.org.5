Return-Path: <linux-kernel+bounces-92033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1670871A02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020C61C20FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915453387;
	Tue,  5 Mar 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRZsWrOl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581324CB58;
	Tue,  5 Mar 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632459; cv=none; b=raAfTgIFj3LsqKaoLT8AnamVKoLZWjkSa6wdoPG42bCw/Ls718tNssm9m/LZTDbrsvV0wF6zIKqoLX0/nHuF2tUGai2kOoecIjeaDLy6Yn/sY99j4CHb7ozpOiu91MmSV2o0hYGbutmO3QDrVnwe0FVm7qWjUpftb7e2sRusSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632459; c=relaxed/simple;
	bh=jNKTZwm/zMfNHRVTfXkmKdJ1UALCfxs1UkH3Gqlh3T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV6sZzUk5QwX+olNk8kSDRrQDqdRHbNkFBlPR5OjTV0vZG17ddezstvsAb+aA9pAYi4l3sotCa1DzHRBhL+swWc2rZjKYSif1gYbGwlvII2N61CAV5WmZvsHRjy2RkM27eU9Xh3Wn3ajptjvUK4f58whDXCRIuhK/z8fAtYGVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRZsWrOl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d3f8f7a68dso202831fa.0;
        Tue, 05 Mar 2024 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709632455; x=1710237255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhM0d+kE3plPStk/1c/yuQp6Ohx1jtFSVotBp1VMtT0=;
        b=aRZsWrOlG3f1LLdZ3UPKm05OlR/jhzfLuNvBQYnR47UmIYlnc+JpqkCGkxwbQO9Qs+
         zij0aC6NsdtFNBcAZ+HVph+b7x1SS+9vUaQBSQH5KYhHhgMPlUH5lRfdbdRLuF3hccBf
         a9Nrh51Ih4fd4qNJgeYsr3H+FL8RirT8qacOQ61iSxHeqUMsHWRmjwhrz1tWjypD2F6B
         LLSxa3YzK3IYQfpju0pPH1OuJnNsUEvbEt1fSOB0T02rxst72bREJFAXATA/502MR8uh
         2QyE1yG2dKRkNdMFva505qFc9GnIS9KByD10nsgKO2cYV8kCcg4dKQiGHGUJ80VTsmfw
         /heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632455; x=1710237255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhM0d+kE3plPStk/1c/yuQp6Ohx1jtFSVotBp1VMtT0=;
        b=ho9JA3QoH3q+Q7kjiTGgL51Ud3cH1wXC0LM/d0FLWzYUAj4ZbrHikCvo9csRML4rcU
         oM1C8MgANazYW98wHLnx445l+Rby2nyS4z4MkXyFm8GVbkzy8TeKVaFiOhvLWB8sTQ3z
         ghO0Mvj/sWfjO5iyElnaL9wnvS2BtMPICWJA8roCEYOCN0bwP0lt7n1vonDnRsGFjSIK
         x5H1ib+GJhTTJE6tnLKZM0cU8deQCd/nsqJqm6GYQ2RIBSyP1iZBkTYwtm8PSSBX5KN8
         1V7AV1Hp1t6c5frlpzElTCciungJLGBdd6VU0jlEq/grKgzcI6ZkGUTqHPCG1Po5mYob
         5rvw==
X-Forwarded-Encrypted: i=1; AJvYcCXEkklNy/U58xjMr/SNiWcuykk482MFDUVifTA3tmnGfrkWYsZsaB6JkdczHy8S5A5qcHKuG+b+A834FeTc/QDqat/3oSsVYL0KjEuVGyDBxzG31/QxxaDLf9aq9zu2kDMqGdzevUwJew==
X-Gm-Message-State: AOJu0YznctvleavSgOV8hM+zY1irmm9udu0cA7wzBxKg7r0BE2GIE6mT
	xDgKKudsFGG18fqCOpdzv2/NzBpxT8i3I3rujnhdXcCIgrf+ooRyHVfK9AASIj/MR63Nek1MlOA
	nSwSrUESalYQ8GtceASsUHC6C69k=
X-Google-Smtp-Source: AGHT+IH1y9jM5ofau5NwHul6UpdGMvJwJR/Hnp3eSxZzRLtAunZCfh8YQZeZqH/2FRZAHfwcwFqRRstPSKvzL71iuUQ=
X-Received: by 2002:a2e:9252:0:b0:2d3:e6ce:75cc with SMTP id
 v18-20020a2e9252000000b002d3e6ce75ccmr602516ljg.18.1709632455055; Tue, 05 Mar
 2024 01:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <799dcc07f41c2357328e9778fbbded7818af34a7.1706603678.git.haibo1.xu@intel.com>
 <ZeasjVWuyeiAlF8y@sunil-laptop>
In-Reply-To: <ZeasjVWuyeiAlF8y@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 17:54:03 +0800
Message-ID: <CAJve8ok_J41e33UM+Umr6NNDRC_WtsLYuqioW4TWfL8PwXQOCQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Baoquan He <bhe@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:24=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 10:32:00AM +0800, Haibo Xu wrote:
> > Add acpi_numa.c file to enable parse NUMA information from
> > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > memory nodes to proximity domain mapping, while SLIT table
> > provide the distance metrics between proximity domains.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  drivers/acpi/numa/srat.c      |   3 +-
> >  include/linux/acpi.h          |   4 +
> >  8 files changed, 156 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> >
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index 7dad0cf9d701..e0a1f84404f3 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num=
, u32 slot) { }
> >
> >  void acpi_init_rintc_map(void);
> >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > -u32 get_acpi_id_for_cpu(int cpu);
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > +}
> > +
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >                      unsigned int cpu, const char **isa);
> >
> > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbo=
m_size,
> >                            u32 *cboz_size, u32 *cbop_size);
> >  #else
> > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct ac=
pi_table_header *table,
> >
> >  #endif /* CONFIG_ACPI */
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_numa_get_nid(unsigned int cpu);
> > +void acpi_map_cpus_to_nodes(void);
> > +#else
> > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> > +static inline void acpi_map_cpus_to_nodes(void) { }
> > +#endif /* CONFIG_ACPI_NUMA */
> > +
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f71910718053..5d3e9cf89b76 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)              +=3D compat_vdso/
> >
> >  obj-$(CONFIG_64BIT)          +=3D pi/
> >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> > +obj-$(CONFIG_ACPI_NUMA)      +=3D acpi_numa.o
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index e619edc8b0cc..040bdbfea2b4 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(in=
t cpu)
> >       return &cpu_madt_rintc[cpu];
> >  }
> >
> > -u32 get_acpi_id_for_cpu(int cpu)
> > -{
> > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > -}
> > -
> >  /*
> >   * __acpi_map_table() will be called before paging_init(), so early_io=
remap()
> >   * or early_memremap() should be called here to for ACPI table mapping=
.
> > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_num=
a.c
> > new file mode 100644
> > index 000000000000..493642a61457
> > --- /dev/null
> > +++ b/arch/riscv/kernel/acpi_numa.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI 6.6 based NUMA setup for RISCV
> > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > + *
> > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > + * Copyright (C) 2013-2016, Linaro Ltd.
> > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > + * Copyright (C) 2024 Intel Corporation.
> > + *
> > + * Reads the ACPI SRAT table to figure out what memory belongs to whic=
h CPUs.
> > + *
> > + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> > + * Assumes all memory regions belonging to a single proximity domain
> > + * are in one chunk. Holes between them will be included in the node.
> > + */
> > +
> > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/memblock.h>
> > +#include <linux/mmzone.h>
> > +#include <linux/module.h>
> > +#include <linux/topology.h>
> > +
> > +#include <asm/numa.h>
> > +
> > +static int acpi_early_node_map[NR_CPUS] __initdata =3D { NUMA_NO_NODE =
};
> > +
> > +int __init acpi_numa_get_nid(unsigned int cpu)
> > +{
> > +     return acpi_early_node_map[cpu];
> > +}
> > +
> > +static inline int get_cpu_for_acpi_id(u32 uid)
> > +{
> > +     int cpu;
> > +
> > +     for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
> > +             if (uid =3D=3D get_acpi_id_for_cpu(cpu))
> > +                     return cpu;
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *he=
ader,
> > +                                   const unsigned long end)
>
> Please check alignment.
>

Sure.

> > +{
> > +     struct acpi_srat_rintc_affinity *pa;
> > +     int cpu, pxm, node;
> > +
> > +     if (srat_disabled())
> > +             return -EINVAL;
> > +
> > +     pa =3D (struct acpi_srat_rintc_affinity *)header;
> > +     if (!pa)
> > +             return -EINVAL;
> > +
> > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > +             return 0;
> > +
> > +     pxm =3D pa->proximity_domain;
> > +     node =3D pxm_to_node(pxm);
> > +
> > +     /*
> > +      * If we can't map the UID to a logical cpu this
> > +      * means that the UID is not part of possible cpus
> > +      * so we do not need a NUMA mapping for it, skip
> > +      * the SRAT entry and keep parsing.
> > +      */
> > +     cpu =3D get_cpu_for_acpi_id(pa->acpi_processor_uid);
> > +     if (cpu < 0)
> > +             return 0;
> > +
> > +     acpi_early_node_map[cpu] =3D node;
> > +     pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
> > +             cpuid_to_hartid_map(cpu), node);
> > +
> > +     return 0;
> > +}
> > +
> > +void __init acpi_map_cpus_to_nodes(void)
> > +{
> > +     int i;
> > +
> > +     /*
> > +      * In ACPI, SMP and CPU NUMA information is provided in separate
> > +      * static tables, namely the MADT and the SRAT.
> > +      *
> > +      * Thus, it is simpler to first create the cpu logical map throug=
h
> > +      * an MADT walk and then map the logical cpus to their node ids
> > +      * as separate steps.
> > +      */
> > +     acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_=
srat),
> > +                                         ACPI_SRAT_TYPE_RINTC_AFFINITY=
,
> > +                                         acpi_parse_rintc_pxm, 0);
> > +
> Alignment here as well.
>

Sure.

> > +     for (i =3D 0; i < nr_cpu_ids; i++)
> > +             early_map_cpu_to_node(i, acpi_numa_get_nid(i));
> > +}
> > +
> > +/* Callback for Proximity Domain -> logical node ID mapping */
> > +void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affin=
ity *pa)
> > +{
> > +     int pxm, node;
> > +
> > +     if (srat_disabled())
> > +             return;
> > +
> > +     if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) =
{
> > +             pr_err("SRAT: Invalid SRAT header length: %d\n",
> > +                     pa->header.length);
> Can we merge these into single line?
>
> > +             bad_srat();
> > +             return;
> > +     }
> > +
> > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > +             return;
> > +
> > +     pxm =3D pa->proximity_domain;
> > +     node =3D acpi_map_pxm_to_node(pxm);
> > +
> > +     if (node =3D=3D NUMA_NO_NODE) {
> > +             pr_err("SRAT: Too many proximity domains %d\n", pxm);
> > +             bad_srat();
> > +             return;
> > +     }
> > +
> > +     node_set(node, numa_nodes_parsed);
> > +}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 4f73c0ae44b2..a2cde65b69e9 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
> >       setup_smp();
> >  #endif
> >
> > -     if (!acpi_disabled)
> > +     if (!acpi_disabled) {
> >               acpi_init_rintc_map();
> > +             acpi_map_cpus_to_nodes();
> Is it not possible to fill up both in single parsing of MADT?
>

I think it's not possible to fill both in a single MADT parse since
the NUMA info is provided in a separate SRAT table.

For RISC-V, currently we parsed 2 times of the MADT.
FIrst one in setup_smp()->acpi_parse_and_init_cpus() call to build up
cpuid_to_hartid_map.
Second one in acpi_init_rintc_map call to build the cpu_madt_rintc[]
cache structure.

Since the first one depends on the CONFIG_SMP, I am not sure whether
it's possible to combine
these two parts into one.

> > +     }
> >
> >       riscv_init_cbo_blocksizes();
> >       riscv_fill_hwcap();
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 519b6bd946e5..b188d83d1ec4 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -101,7 +101,6 @@ static int __init acpi_parse_rintc(union acpi_subta=
ble_headers *header, const un
> >       if (hart =3D=3D cpuid_to_hartid_map(0)) {
> >               BUG_ON(found_boot_cpu);
> >               found_boot_cpu =3D true;
> > -             early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> >               return 0;
> >       }
> >
> > @@ -111,7 +110,6 @@ static int __init acpi_parse_rintc(union acpi_subta=
ble_headers *header, const un
> >       }
> >
> >       cpuid_to_hartid_map(cpu_count) =3D hart;
> > -     early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
> >       cpu_count++;
> >
> >       return 0;
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 503abcf6125d..1f0462cef47c 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -219,7 +219,8 @@ int __init srat_disabled(void)
> >       return acpi_numa < 0;
> >  }
> >
> > -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOO=
NGARCH)
> > +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOO=
NGARCH) || \
> > +     defined(CONFIG_RISCV)
> Please check alignment. Or make it single line if fits in 100 chars.
> Also, it looks it covers most of the architectures now. Is it possible
> to simplify / remove the condition? I hope IA64 is removed now?
>

Good catch!

Since IA64 support was removed in commit
cf8e8658100d4(https://lwn.net/Articles/923376/).
I think it's possible to remove the condition. Will fix it in v2.

Thanks,
Haibo

> May be you need to update the comment at #endif too.
>
> Thanks
> Sunil
>
> >  /*
> >   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> >   * I/O localities since SRAT does not list them.  I/O localities are
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index a65273db55c6..be78a9d28927 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -269,8 +269,12 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc=
_affinity *pa) { }
> >
> >  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma)=
;
> >
> > +#ifdef CONFIG_RISCV
> > +void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa=
);
> > +#else
> >  static inline void
> >  acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> > +#endif
> >
> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> > --
> > 2.34.1
> >

