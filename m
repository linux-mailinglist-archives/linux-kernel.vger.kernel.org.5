Return-Path: <linux-kernel+bounces-153749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F368AD2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD7E285D28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ECA153830;
	Mon, 22 Apr 2024 16:49:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72B2EB11;
	Mon, 22 Apr 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804540; cv=none; b=UzZbNiujSBQH4EMp75vhcCC4oKc8H2JjzIWKay9ECCI6Wb3l4+Ldw2zCL0smV51V+waqdSJw7xo/bsEwgtsTNHDSk1vjuKSsgknaKxy3+KSzlCJ8/0xxjogEC3O7Mbj+hy3wGDgZMUWtrz+Qd/a3iFTnPMOqLzi8zhFukcKvSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804540; c=relaxed/simple;
	bh=uRXRWRGIv34HbQQJzH5g6nrOYt+hPQK2/gXQaQGm4Ms=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzhsYW2YkalXhKFffHiuouXWLmfb8mcfHy17RxGCcsc117yzuY2G5XBWc8RuJefX0DkGEDJcZTRkIPHq4W5vvLOmNvUTRO+6VPqoVLEHuKHeTOZJL8niajwPTkIbashM3m29+F7jBpqRtiaG4H8ihBzAsQMC4O8Vfk4bEj4zYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWNt5Pskz6K69V;
	Tue, 23 Apr 2024 00:46:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD84140736;
	Tue, 23 Apr 2024 00:48:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 17:48:54 +0100
Date: Mon, 22 Apr 2024 17:48:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v3 3/5] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <20240422174853.0000168c@Huawei.com>
In-Reply-To: <20240419140203.1996635-4-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
	<20240419140203.1996635-4-rrichter@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 19 Apr 2024 16:02:01 +0200
Robert Richter <rrichter@amd.com> wrote:

> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too an make
> them static.
> 
> [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

The slit change is fine, but what about the cfmws function in here
where a stub was removed as well. Looks sensible as it relied on the
implementation details of acpi_numa_memory_affinity_init() but
should probably call it out in the description and say why it no
longer needs to be protected like this.

Jonathan

> ---
>  drivers/acpi/numa/srat.c | 17 ++---------------
>  include/linux/acpi.h     |  5 -----
>  2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 43417b4920da..bd0e2d342ba2 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -208,13 +208,12 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
>   * not supported at this point.
>   */
> -void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> +static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  {
>  	int i, j;
>  
> @@ -236,11 +235,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
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
> @@ -456,14 +451,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static inline void acpi_table_print_cedt(void) {}
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


