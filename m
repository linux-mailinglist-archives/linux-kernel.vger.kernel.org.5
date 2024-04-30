Return-Path: <linux-kernel+bounces-164333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89028B7C72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627D02811F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97E177980;
	Tue, 30 Apr 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnA10ALa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4E143737;
	Tue, 30 Apr 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492893; cv=none; b=Q5K7bgVFqDbVik19PS0ZkwrUIwVUVFDX/fUeW/0yyZ1b5ZB4zzxH2LDVMx7Hl7+b+J4UlCeuvIGAxxt/G5SVE9iaP8BfN3b2yFQZb+Ffbff3MlalKjVQFujdrpwGkyQTVlGzPO48p//CGy2/wLPmTp8ty6AGa6APLc/nh8bMnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492893; c=relaxed/simple;
	bh=pKyWEYsbQ9NofCKNs5jRrUhRqFrwHx7S3miXllop53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idFOo+h12ciMlbWBEF4Q0PHqaZv3ct1dGzgZ5LF2PxggYN6uSIHx5PJpRxJO8kly17B/X/VMZAwgOLrV16rFAmWMJ+eUe6eupTyFLTDDIt1IM0LGVMSzOioWGiMymVeIE9UJmxAk4KTAeBS4H6rHjOu8Um7QCzW2Ov+DKvJdsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnA10ALa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492892; x=1746028892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKyWEYsbQ9NofCKNs5jRrUhRqFrwHx7S3miXllop53g=;
  b=CnA10ALaMqcADXKTECBSFtZQMsuCZoundBhJMHTy01Yc0B4ytyNbEwY6
   ctqLABQcPLMWsp3D3Mqg1EFAy5oj+ruYSzKFo7T/rI3wjI0L5fNmAHQR+
   zK/KEEo7gSiOmOUYn5QDp6dqY6FOF75wXe3e7+kZuE8DC7zvXBrJbYFV5
   kbPbWh1aASGPV+r56ur5YPfQRKrT+3aHAkx6Jo8pyL06Qf17iLfIFrH6z
   V8Bl39LdY/+6TfOcqK0wLi47y0sFRaK8VO/ygK07WW6X5lSAUYwgJGsDU
   6XZ3Lv8c1Pnskg/ILgAsaey5ZYRRhEXzNcMpzEWIi/PHWUfa/3er6gnKf
   w==;
X-CSE-ConnectionGUID: eiZpjZrrT8OGgYwzGZmB3w==
X-CSE-MsgGUID: 4hadta3UQJSu8K59ge1e7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10333568"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10333568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:30 -0700
X-CSE-ConnectionGUID: hOkCNw6dRieiRb9vDAWkOw==
X-CSE-MsgGUID: FPpA8TqZRuSs8UyFiBch7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26593450"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:30 -0700
Date: Tue, 30 Apr 2024 09:01:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 3/7] ACPI/NUMA: Squash acpi_numa_slit_init() into
 acpi_parse_slit()
Message-ID: <ZjEV16eaKKHI18qi@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-4-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:56AM +0200, Robert Richter wrote:
> After removing architectural code the helper function
> acpi_numa_slit_init() is no longer needed. Squash it into
> acpi_parse_slit(). No functional changes intended.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e4d53e3660fd..430ddcfb8312 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -218,10 +218,16 @@ __weak int __init numa_fill_memblks(u64 start, u64 end)
>   * I/O localities since SRAT does not list them.  I/O localities are
>   * not supported at this point.
>   */
> -static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> +static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
> +	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
>  	int i, j;
>  
> +	if (!slit_valid(slit)) {
> +		pr_info("SLIT table looks invalid. Not used.\n");
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < slit->locality_count; i++) {
>  		const int from_node = pxm_to_node(i);
>  
> @@ -238,6 +244,8 @@ static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  				slit->entry[slit->locality_count * i + j]);
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int __init
> @@ -341,19 +349,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> -static int __init acpi_parse_slit(struct acpi_table_header *table)
> -{
> -	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
> -
> -	if (!slit_valid(slit)) {
> -		pr_info("SLIT table looks invalid. Not used.\n");
> -		return -EINVAL;
> -	}
> -	acpi_numa_slit_init(slit);
> -
> -	return 0;
> -}
> -
>  void __init __weak
>  acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
>  {
> -- 
> 2.39.2
> 

