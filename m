Return-Path: <linux-kernel+bounces-164332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA708B7C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE6280D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1F179675;
	Tue, 30 Apr 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqDKC0U2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084A174EF1;
	Tue, 30 Apr 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492877; cv=none; b=eN0Q9QEj2yyK+bp9COp2YifiHwj7WiLrNqZWiSR20JbwLtKyavxxWSX83NMCtTlxS89LqohbcECac0F2FHsrYhaFq7z3eC7Hns7av8w7f6mSTtUQrxbAT2bFGepS6gCzesVZDCiEtvV2oXRcCrgaQOt96tWCI8nodZ5X136Wcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492877; c=relaxed/simple;
	bh=MutPWEGS5St0LFaWSGKhvbLM0WV+4s3ZN5wZOEiDUdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4G0VkHT1cCY/19BbZQ6JsWmJan6I7bNAJe/OAVq6SWhm4rz//XHFlSMN0tW6Q2V/dffZ/6yP8ZK9hrsYePXlhFgBhHLFN4qVp2SNbeicJhfVgmAOn8lx4O3iqNc1FyjUTFzeUo+icNy0/Xjye9Uf1yEUqiRmFcEQS3AL6gcqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqDKC0U2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492875; x=1746028875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MutPWEGS5St0LFaWSGKhvbLM0WV+4s3ZN5wZOEiDUdk=;
  b=SqDKC0U2x1YBOLnXwErBiU2M3XxcFe9hNe0KAEbCV3cDAa7OyMvCj/dk
   luSrg34bYK30ujI8q/++tbheH098NZs52joB+Cumqd8Os4tPocS6T2N3S
   7UAf4eXl39wQhVSULYMog1K3shOpIvQbze9PbPFSI6UgW9MV8SnsFUczG
   qWXNfs+JgZxilTQV5rco1T4kCmdMXgZNR1Wuk7KtFoDw/IMNmaYYHDoKa
   yoWuRUE9Pw3ACC2zD+vTRNgOv+wCNC3c03UPkEr8j6XHEwsoHEBfFiFHg
   jyx+PeYLjzxIhyveU4V8CpLsLPup8PEgVO0dTKWiZjdnhWX/gF+g57rPm
   g==;
X-CSE-ConnectionGUID: HaOnrDFgTA22XXB52TqgQw==
X-CSE-MsgGUID: FlK6r3ANRlytnggcEpfucg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10333418"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10333418"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:14 -0700
X-CSE-ConnectionGUID: 7HSioYnhS8iEBf9AwNJcPg==
X-CSE-MsgGUID: tzJqgvM5Rza2peDtpizCaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26593048"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:08 -0700
Date: Tue, 30 Apr 2024 09:01:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/7] ACPI/NUMA: Squash
 acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Message-ID: <ZjEVwrTO87OHXCZ5@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-5-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:57AM +0200, Robert Richter wrote:
> After removing architectural code the helper function
> acpi_numa_memory_affinity_init() is no longer needed. Squash it into
> acpi_parse_memory_affinity(). No functional changes intended.
> 
> While at it, fixing checkpatch complaints in code moved.
>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 430ddcfb8312..e3f26e71637a 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -248,22 +248,30 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
>  	return 0;
>  }
>  
> +static int parsed_numa_memblks __initdata;
> +
>  static int __init
> -acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> +acpi_parse_memory_affinity(union acpi_subtable_headers *header,
> +			   const unsigned long table_end)
>  {
> +	struct acpi_srat_mem_affinity *ma;
>  	u64 start, end;
>  	u32 hotpluggable;
>  	int node, pxm;
>  
> +	ma = (struct acpi_srat_mem_affinity *)header;
> +
> +	acpi_table_print_srat_entry(&header->common);
> +
>  	if (srat_disabled())
> -		goto out_err;
> +		return 0;
>  	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
>  		pr_err("SRAT: Unexpected header length: %d\n",
>  		       ma->header.length);
>  		goto out_err_bad_srat;
>  	}
>  	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
> -		goto out_err;
> +		return 0;
>  	hotpluggable = IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
>  		(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE);
>  
> @@ -301,11 +309,15 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  
>  	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
>  
> +	parsed_numa_memblks++;
> +
>  	return 0;
> +
>  out_err_bad_srat:
> +	/* Just disable SRAT, but do not fail and ignore errors. */
>  	bad_srat();
> -out_err:
> -	return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> @@ -438,24 +450,6 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
> -static int __initdata parsed_numa_memblks;
> -
> -static int __init
> -acpi_parse_memory_affinity(union acpi_subtable_headers * header,
> -			   const unsigned long end)
> -{
> -	struct acpi_srat_mem_affinity *memory_affinity;
> -
> -	memory_affinity = (struct acpi_srat_mem_affinity *)header;
> -
> -	acpi_table_print_srat_entry(&header->common);
> -
> -	/* let architecture-dependent part to do it */
> -	if (!acpi_numa_memory_affinity_init(memory_affinity))
> -		parsed_numa_memblks++;
> -	return 0;
> -}
> -
>  static int __init acpi_parse_srat(struct acpi_table_header *table)
>  {
>  	struct acpi_table_srat *srat = (struct acpi_table_srat *)table;
> -- 
> 2.39.2
> 

