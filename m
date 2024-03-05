Return-Path: <linux-kernel+bounces-92045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CAE871A31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E151C21282
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B731548E0;
	Tue,  5 Mar 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e85inlzv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1854668
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633208; cv=none; b=YN9xs79d4XEXKu5VuncpJ5IMg7VgULtXlUeMy5zkAhX7Dd/6r9iyG3PaOj3Ich+mD5SPHZOw7qssjRV7gx+OCk8EGSiLOEIUdXbbyGx5JSCCyfWXr16mNeOPkkFyexRVJ0njTwqd+4RKxqWB8k+Exfz+/lGUCjUtT8M0c9Wh2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633208; c=relaxed/simple;
	bh=eqlOESaV1bqezw30Ds+lV6xUhURyVUt9af977ahT1vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyPIZM8lOhlxkeCkzqzyTGZgIUCBrXN8yZqBJJV+RpX2ZVO1HJ5dzNnTgu5MMLTMpfpNEoExTs9qRYgF1RapkCkTEP9cfLs+zR5YEaun8wjm3Aif8luwS9PxIyjAcIFeGYpOIOJWo/et10JBy0qlhKd1Py0nOwlYKXsblf3ZkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=e85inlzv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4560664b5so4512496b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709633206; x=1710238006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZOKpEbQlChz7zOomD/vIt5nW6uNiNml3QCNdvLbLzM=;
        b=e85inlzv0fHOilikbYOWi4wF+5jIILh1Vv2nGO68iqwmX+UzOGwrSsoFa1wMBie3qc
         6MZSjzbAnN52eSu1aoDLCIrS9sq7Kj74huBjOgiQMhESqJkbq6Ydl4ACRR/ZKcKfQHAo
         NfGMT5oB3fheMG73tJd53sXKu9izz9BupDX23vfhB+hEfIqe1vF6gmUL75JMWysn6DmW
         Drxwgo7y49GQt2avbBQ+LlGqO9f4cvhMa8IAdBn0BCDnCqpP7QzQhLiS/kq4dzqfa3+W
         TNI6pOjR+8zuDwVv8BynI9geUk/4Xhi2lIIorqCjZtb91CWRgSG0VJ9/B7zHpz11mg1u
         +YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633206; x=1710238006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZOKpEbQlChz7zOomD/vIt5nW6uNiNml3QCNdvLbLzM=;
        b=GksfEsblsZrvqQPcmAsyOZpuf5/eSuZvjWnLwlfZKFhYUfZXGNm5QKB1HjuuuQrs4N
         9NiKObic/lbqlooU80eso9ITduiC80Fwky04RwpKNofgIz4huoawHZ0n6IbWbZgMkxQL
         zsH6L1GQ3gtSdZR8O1lONE8ZyuUepjq/042DgC42X7ew+ZC4qTbxnnDGoHNk3D+0v9tS
         6RJJ2zGw70OMWgdlf1mVyCQigf1lT6D4bOUFneZ3VjJC9oGsSepwbm85eDhR8UNnKhh2
         kObpgZDWZgnjNYYfmkS0owsRDD3FT/2nO41P3G7A8CkFNgzj2PM7kpa8C8ug2P3pnb8S
         SK4A==
X-Forwarded-Encrypted: i=1; AJvYcCWiAebtlG6hI14iyj3Od/kN0wlDgtauKS9OKUGnphipUTEy8edx2hyOWWsJJR19sZ0ETvyeIjHfqQLXJHdhfb3zLpBeMrPGUOaOwYRX
X-Gm-Message-State: AOJu0Yz1kj//YiNF7XdWIEjp8X4mgEMMS/7eQtYmAeO5J+3hONciZ/5x
	9300xN/bqXae5YTl4tzeO7OSLbXCuJ0jfiMIxjqF7ggG2TWvzJC8p+QYjs3iM2g=
X-Google-Smtp-Source: AGHT+IGjdBTC5zwV3+uOzO0FRsFfVU9zwOZKNxa40pniaFw+dSJeQQNn86lkd16UTmfTD8HYlgY+Ng==
X-Received: by 2002:a05:6a20:1aa4:b0:1a1:51b3:b1c4 with SMTP id ci36-20020a056a201aa400b001a151b3b1c4mr1057558pzb.56.1709633206019;
        Tue, 05 Mar 2024 02:06:46 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b006e612df4627sm3941333pfb.39.2024.03.05.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:06:45 -0800 (PST)
Date: Tue, 5 Mar 2024 15:36:32 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>, Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 3/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
Message-ID: <ZebuqDmz+dbC4N9C@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <799dcc07f41c2357328e9778fbbded7818af34a7.1706603678.git.haibo1.xu@intel.com>
 <ZeasjVWuyeiAlF8y@sunil-laptop>
 <CAJve8ok_J41e33UM+Umr6NNDRC_WtsLYuqioW4TWfL8PwXQOCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8ok_J41e33UM+Umr6NNDRC_WtsLYuqioW4TWfL8PwXQOCQ@mail.gmail.com>

On Tue, Mar 05, 2024 at 05:54:03PM +0800, Haibo Xu wrote:
> On Tue, Mar 5, 2024 at 1:24 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Wed, Jan 31, 2024 at 10:32:00AM +0800, Haibo Xu wrote:
> > > Add acpi_numa.c file to enable parse NUMA information from
> > > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > > memory nodes to proximity domain mapping, while SLIT table
> > > provide the distance metrics between proximity domains.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  15 +++-
> > >  arch/riscv/kernel/Makefile    |   1 +
> > >  arch/riscv/kernel/acpi.c      |   5 --
> > >  arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
> > >  arch/riscv/kernel/setup.c     |   4 +-
> > >  arch/riscv/kernel/smpboot.c   |   2 -
> > >  drivers/acpi/numa/srat.c      |   3 +-
> > >  include/linux/acpi.h          |   4 +
> > >  8 files changed, 156 insertions(+), 11 deletions(-)
> > >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> > >
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index 7dad0cf9d701..e0a1f84404f3 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > >
> > >  void acpi_init_rintc_map(void);
> > >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > -u32 get_acpi_id_for_cpu(int cpu);
> > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > +{
> > > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > +}
> > > +
> > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >                      unsigned int cpu, const char **isa);
> > >
> > > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> > >                            u32 *cboz_size, u32 *cbop_size);
> > >  #else
> > > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
> > >
> > >  #endif /* CONFIG_ACPI */
> > >
> > > +#ifdef CONFIG_ACPI_NUMA
> > > +int acpi_numa_get_nid(unsigned int cpu);
> > > +void acpi_map_cpus_to_nodes(void);
> > > +#else
> > > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > > +static inline void acpi_map_cpus_to_nodes(void) { }
> > > +#endif /* CONFIG_ACPI_NUMA */
> > > +
> > >  #endif /*_ASM_ACPI_H*/
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index f71910718053..5d3e9cf89b76 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)              += compat_vdso/
> > >
> > >  obj-$(CONFIG_64BIT)          += pi/
> > >  obj-$(CONFIG_ACPI)           += acpi.o
> > > +obj-$(CONFIG_ACPI_NUMA)      += acpi_numa.o
> > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > index e619edc8b0cc..040bdbfea2b4 100644
> > > --- a/arch/riscv/kernel/acpi.c
> > > +++ b/arch/riscv/kernel/acpi.c
> > > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > >       return &cpu_madt_rintc[cpu];
> > >  }
> > >
> > > -u32 get_acpi_id_for_cpu(int cpu)
> > > -{
> > > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > -}
> > > -
> > >  /*
> > >   * __acpi_map_table() will be called before paging_init(), so early_ioremap()
> > >   * or early_memremap() should be called here to for ACPI table mapping.
> > > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> > > new file mode 100644
> > > index 000000000000..493642a61457
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/acpi_numa.c
> > > @@ -0,0 +1,133 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ACPI 6.6 based NUMA setup for RISCV
> > > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > > + *
> > > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > > + * Copyright (C) 2013-2016, Linaro Ltd.
> > > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > > + * Copyright (C) 2024 Intel Corporation.
> > > + *
> > > + * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
> > > + *
> > > + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> > > + * Assumes all memory regions belonging to a single proximity domain
> > > + * are in one chunk. Holes between them will be included in the node.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/bitmap.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/memblock.h>
> > > +#include <linux/mmzone.h>
> > > +#include <linux/module.h>
> > > +#include <linux/topology.h>
> > > +
> > > +#include <asm/numa.h>
> > > +
> > > +static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> > > +
> > > +int __init acpi_numa_get_nid(unsigned int cpu)
> > > +{
> > > +     return acpi_early_node_map[cpu];
> > > +}
> > > +
> > > +static inline int get_cpu_for_acpi_id(u32 uid)
> > > +{
> > > +     int cpu;
> > > +
> > > +     for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> > > +             if (uid == get_acpi_id_for_cpu(cpu))
> > > +                     return cpu;
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *header,
> > > +                                   const unsigned long end)
> >
> > Please check alignment.
> >
> 
> Sure.
> 
> > > +{
> > > +     struct acpi_srat_rintc_affinity *pa;
> > > +     int cpu, pxm, node;
> > > +
> > > +     if (srat_disabled())
> > > +             return -EINVAL;
> > > +
> > > +     pa = (struct acpi_srat_rintc_affinity *)header;
> > > +     if (!pa)
> > > +             return -EINVAL;
> > > +
> > > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > > +             return 0;
> > > +
> > > +     pxm = pa->proximity_domain;
> > > +     node = pxm_to_node(pxm);
> > > +
> > > +     /*
> > > +      * If we can't map the UID to a logical cpu this
> > > +      * means that the UID is not part of possible cpus
> > > +      * so we do not need a NUMA mapping for it, skip
> > > +      * the SRAT entry and keep parsing.
> > > +      */
> > > +     cpu = get_cpu_for_acpi_id(pa->acpi_processor_uid);
> > > +     if (cpu < 0)
> > > +             return 0;
> > > +
> > > +     acpi_early_node_map[cpu] = node;
> > > +     pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
> > > +             cpuid_to_hartid_map(cpu), node);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +void __init acpi_map_cpus_to_nodes(void)
> > > +{
> > > +     int i;
> > > +
> > > +     /*
> > > +      * In ACPI, SMP and CPU NUMA information is provided in separate
> > > +      * static tables, namely the MADT and the SRAT.
> > > +      *
> > > +      * Thus, it is simpler to first create the cpu logical map through
> > > +      * an MADT walk and then map the logical cpus to their node ids
> > > +      * as separate steps.
> > > +      */
> > > +     acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
> > > +                                         ACPI_SRAT_TYPE_RINTC_AFFINITY,
> > > +                                         acpi_parse_rintc_pxm, 0);
> > > +
> > Alignment here as well.
> >
> 
> Sure.
> 
> > > +     for (i = 0; i < nr_cpu_ids; i++)
> > > +             early_map_cpu_to_node(i, acpi_numa_get_nid(i));
> > > +}
> > > +
> > > +/* Callback for Proximity Domain -> logical node ID mapping */
> > > +void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa)
> > > +{
> > > +     int pxm, node;
> > > +
> > > +     if (srat_disabled())
> > > +             return;
> > > +
> > > +     if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) {
> > > +             pr_err("SRAT: Invalid SRAT header length: %d\n",
> > > +                     pa->header.length);
> > Can we merge these into single line?
> >
> > > +             bad_srat();
> > > +             return;
> > > +     }
> > > +
> > > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > > +             return;
> > > +
> > > +     pxm = pa->proximity_domain;
> > > +     node = acpi_map_pxm_to_node(pxm);
> > > +
> > > +     if (node == NUMA_NO_NODE) {
> > > +             pr_err("SRAT: Too many proximity domains %d\n", pxm);
> > > +             bad_srat();
> > > +             return;
> > > +     }
> > > +
> > > +     node_set(node, numa_nodes_parsed);
> > > +}
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 4f73c0ae44b2..a2cde65b69e9 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
> > >       setup_smp();
> > >  #endif
> > >
> > > -     if (!acpi_disabled)
> > > +     if (!acpi_disabled) {
> > >               acpi_init_rintc_map();
> > > +             acpi_map_cpus_to_nodes();
> > Is it not possible to fill up both in single parsing of MADT?
> >
> 
> I think it's not possible to fill both in a single MADT parse since
> the NUMA info is provided in a separate SRAT table.
> 
Ahh, yes. My mistake. This looks good to me.

Thanks,
Sunil

