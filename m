Return-Path: <linux-kernel+bounces-164334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CE8B7C74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638641F24394
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A6E17556A;
	Tue, 30 Apr 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4As+Y9j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF3132C15;
	Tue, 30 Apr 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492923; cv=none; b=QYwqPRNe/IQ4eOVHmK6ZBlD0a+lGf82iSlRb8T5ITtlO3pWvGbFwmvtfbKXCt/TRheZ5f/zZqzRSr2lK1eq9GxdzPqH9aPoRiGtBlOOuHLRwU/2AIARtfSfb/Chc0v7xyakHSYyWANWAMWjNafaCdPF6HdhOWJ4Q8bJq4jFZWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492923; c=relaxed/simple;
	bh=Rvq8o5SOMZnV/X98JzqTV2YkrAzwlGrJT8jM3pq+kDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwhL+9MGMJEYVsRlpGfYrGRiu9FgBjTmtdSrWstpVPvMtG3SXk4QXv5s2bLeORDf+O6glvIeJfwBS3tk+5/3W/mspt3NAJWhAPvXPx1+0UXOXSIUnNZLSF8Bcuuf0PDEK8Kmdrj2hX3PxvTXcAGG4bIzO7GR97rC8GIJebNEZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4As+Y9j; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492922; x=1746028922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rvq8o5SOMZnV/X98JzqTV2YkrAzwlGrJT8jM3pq+kDE=;
  b=m4As+Y9j7WqAAcEvCkAhEx2Z7+8BjlPhGgURFSw1C2GfNs6QFQqdP7LS
   LxR5aOwsUk+RP1w6MN3YkdZNAxEki4TC1FioJ4WbsxCZlaaCXTlvv0Jny
   sa8azu2Yyq4OetTuiwS7SUqqyWMoCs3b4uZ6Z8JG3iG21uChdZIVHysnZ
   V00vs7VdSH8NsiplKzWx8s+GuolDQ2SdbUt3t5jXgtvk6Z3SNKLZHXJrK
   ruwvx7PTzTnZNRdtfYT6QFJo1UoqTs+/yZuYyHHqIWByJHE69n1vgnXUO
   4Ap5qukrgm1ZSZRV7oQp/OP8zaWR2jlKePdlXqV2S8yQPypdr8gOixoD7
   w==;
X-CSE-ConnectionGUID: 3Wh8IGiLRfS/LhpMI+uQmA==
X-CSE-MsgGUID: PSbmpVCLR2SOGHdDfSECCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10430370"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10430370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:02:01 -0700
X-CSE-ConnectionGUID: BdUsbocdSlergVihIA7U1g==
X-CSE-MsgGUID: Vv/XCU1aSzS+vXM61pxZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31322317"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:59 -0700
Date: Tue, 30 Apr 2024 09:01:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 2/7] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <ZjEV9YFDMRl3j6h6@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-3-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:55AM +0200, Robert Richter wrote:
> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too and make
> them static.
> 
> [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
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
> -- 
> 2.39.2
> 

