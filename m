Return-Path: <linux-kernel+bounces-164202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74268B7AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4640A1F20FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0F7710A;
	Tue, 30 Apr 2024 14:53:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBB770F6;
	Tue, 30 Apr 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488825; cv=none; b=jX5lmmihccs6cdGyQblduQZ6PvfW1fGvxoP8F/RYOGP85ppft2lbB2tcA4asHok0Wf6YYZwHmFaxuyC0aOn/KLzXryN7xmPiTjn+10IIXSS0Hy7u8HGuUjVDj3klXFhf/kkKVz6ic7Msb2wxkfuT91yL44kYQ5YikMXef9gXF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488825; c=relaxed/simple;
	bh=L5mon1Yu+E8bjEo2vY62s8u5PvtYfuTOVJM9FG3z8cw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k46vUKCXv7DwaVuHlkDlhl2hUIySEaVNTsaJChiKgO/moltScBuAdiX0k3gmW4yvynGDRGCV2Ous+OsDh2nqCYHgfeeF0Z77Cqz6311AUZVDnGnz1O5ecJL7SAGeXVJlmYemR5tVVLw2gydT8/KmMMtQrh6gpGW97Dwnel6o0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNRp0dvDz6GD56;
	Tue, 30 Apr 2024 22:51:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 65191140A87;
	Tue, 30 Apr 2024 22:53:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 15:53:38 +0100
Date: Tue, 30 Apr 2024 15:53:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 2/7] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <20240430155337.00007a28@Huawei.com>
In-Reply-To: <20240430092200.2335887-3-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-3-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:21:55 +0200
Robert Richter <rrichter@amd.com> wrote:

> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too and make
> them static.
> 
> [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/numa/srat.c | 16 ++--------------
>  include/linux/acpi.h     |  5 -----
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 3b09fd39eeb4..e4d53e3660fd 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -213,13 +213,12 @@ __weak int __init numa_fill_memblks(u64 start, u64 end)
>  	return NUMA_NO_MEMBLK;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for

Doesn't like like a callback to me. It's just a normal function.

>   * I/O localities since SRAT does not list them.  I/O localities are
>   * not supported at this point.
>   */
> -void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> +static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  {
>  	int i, j;
>  
> @@ -241,11 +240,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  	}
>  }
>  
> -/*
> - * Default callback for parsing of the Proximity Domain <-> Memory
> - * Area mappings
> - */
> -int __init
> +static int __init
>  acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  {
>  	u64 start, end;
> @@ -345,13 +340,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> -				   void *arg, const unsigned long table_end)
> -{
> -	return 0;
> -}
> -#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..2c227b61a452 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -242,9 +242,6 @@ static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
>  	return gicc->flags & ACPI_MADT_ENABLED;
>  }
>  
> -/* the following numa functions are architecture-dependent */
> -void acpi_numa_slit_init (struct acpi_table_slit *slit);
> -
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
>  #else
> @@ -267,8 +264,6 @@ static inline void
>  acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>  #endif
>  
> -int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> -
>  #ifndef PHYS_CPUID_INVALID
>  typedef u32 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)


