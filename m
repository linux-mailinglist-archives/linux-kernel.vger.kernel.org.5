Return-Path: <linux-kernel+bounces-164326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EAD8B7C57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE651C22F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750A174EFA;
	Tue, 30 Apr 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAQVv/yB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A3770F2;
	Tue, 30 Apr 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492560; cv=none; b=HrYtUwku9GjXoG5u/y2bq0Wzf11L+xpBUIRYiHIHTC2DvOZJZf9wEOE4ISeY56+hPHK11XGFg/QiaGnxCA+EvC7CxZFXfcMRFCrTV+QjOumzKRXRw/BK2+NnVtZmgQ08iFhC7FhO/58hlVGy+EV2NRTx/ErAmUL18aSE5AfiUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492560; c=relaxed/simple;
	bh=06vg5hqAWXs2ObK4lZQwv+TlSa8oT1+STphjUJYsuD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBUEYejLEg//FP1uRzcOgPtuw1HTULQryzNAxNX7/x4+X8X3wLkgSwutURJE/6nM1eYhwMisK3ds7x+MluoBDLl3zy2xmyMkBeHE1kTy3k7DFe/N5j/l93nT9PGq49C6K2ihYV/j08vcsyLq44nATjndPQ8CpgsglMbijeYQjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAQVv/yB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492558; x=1746028558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=06vg5hqAWXs2ObK4lZQwv+TlSa8oT1+STphjUJYsuD4=;
  b=oAQVv/yBrExVONu+6gg5LZKg8OYbXkxXsxBAPeJYgZ17x+lMAlMrb78z
   dPjebjQJkVCaJN+hitTQ/BcVrenpqZ7kBgIBC9XCa308z9EhgZyMhaZI8
   sNFOjfw7drt1aeayZi/dMDQILuHmix2Y8zOX+dEJsnHA9k0HspRdIPPGk
   bB5ZuKtmQvTAMEURPUuX6T4olGj6a8SP8G+PFM9PI1Fvo3K9q8cE5sAr9
   LyGTQQPoskhOiETl6CmssCW7bfWZjaagn2IwJL+fDx6wy/Wfu9/8MIm/a
   T6K6Ad+S2rjOIVLkDKzp4VY2tzLqZkwfTKjxyMwSWm3nsd0N8n47El5lS
   w==;
X-CSE-ConnectionGUID: gozQ3UhFR8mBLDr4UqMqQA==
X-CSE-MsgGUID: GCs3ixI8RIeqC3CmjJZZiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10137553"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10137553"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:55:52 -0700
X-CSE-ConnectionGUID: xC5bkiKpRT2AL/x9hRu/wg==
X-CSE-MsgGUID: qZ26jGc4QVy3nOFE8y71rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26589723"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:55:52 -0700
Date: Tue, 30 Apr 2024 08:55:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 7/7] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <ZjEUhUZdcV4ZQCt6@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-8-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-8-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:22:00AM +0200, Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 111 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 34ecf2dc912f..fa21d4d5fccf 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -320,6 +320,114 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +static int __init
> +__acpi_table_print_cedt_entry(union acpi_subtable_headers *__header,
> +			      void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_header *header = (struct acpi_cedt_header *)__header;
> +
> +	switch (header->type) {
> +	case ACPI_CEDT_TYPE_CHBS:
> +		{
> +			struct acpi_cedt_chbs *p =
> +				(struct acpi_cedt_chbs *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_chbs)) {
> +				pr_warn("CEDT: unsupported CHBS entry: size %d\n",
> +					 header->length);
> +				break;
> +			}
> +
> +			pr_debug("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
> +				(unsigned long long)p->base,
> +				(unsigned long long)p->length,
> +				(unsigned long)p->uid,
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
> +				"cxl11" :
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
> +				"cxl20" :
> +				"unsupported version",
> +				p->cxl_version);
> +		}
> +		break;
> +	case ACPI_CEDT_TYPE_CFMWS:
> +		{
> +			struct acpi_cedt_cfmws *p =
> +				(struct acpi_cedt_cfmws *)header;
> +			int eiw_to_ways[] = {1, 2, 4, 8, 16, 3, 6, 12};
> +			int targets = -1;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cfmws)) {
> +				pr_warn("CEDT: unsupported CFMWS entry: size %d\n",
> +					header->length);
> +				break;
> +			}
> +
> +			if (p->interleave_ways < ARRAY_SIZE(eiw_to_ways))
> +				targets = eiw_to_ways[p->interleave_ways];
> +			if (header->length < struct_size(
> +					p, interleave_targets, targets))
> +				targets = -1;
> +
> +			pr_debug("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
> +				(unsigned long long)p->base_hpa,
> +				(unsigned long long)p->window_size,
> +				targets, targets > 1 ? "s" : "");
> +			for (int i = 0; i < targets; i++)
> +				pr_cont("%s%lu", i ? ", " : " (",
> +					(unsigned long)p->interleave_targets[i]);
> +			pr_cont("%s%s%s%s%s%s\n",
> +				targets > 0 ? ")" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ?
> +				" type2" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ?
> +				" type3" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ?
> +				" volatile" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ?
> +				" pmem" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ?
> +				" fixed" : "");
> +		}
> +		break;
> +	case ACPI_CEDT_TYPE_CXIMS:
> +		{
> +			struct acpi_cedt_cxims *p =
> +				(struct acpi_cedt_cxims *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cxims)) {
> +				pr_warn("CEDT: unsupported CXIMS entry: size %d\n",
> +					header->length);
> +				break;
> +			}
> +
> +			pr_debug("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
> +				(unsigned int)p->hbig,
> +				(unsigned int)p->nr_xormaps);
> +		}
> +		break;
> +	default:
> +		pr_warn("CEDT: Found unsupported entry (type = 0x%x)\n",
> +			header->type);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __init acpi_table_print_cedt_entry(enum acpi_cedt_type id)
> +{
> +	acpi_table_parse_cedt(id, __acpi_table_print_cedt_entry, NULL);
> +}
> +
> +static void __init acpi_table_print_cedt(void)
> +{
> +	/* Print only implemented CEDT types */
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CHBS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CFMWS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CXIMS);
> +}
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -518,6 +626,9 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/* CEDT: CXL Early Discovery Table */
> +	acpi_table_print_cedt();
> +
>  	/*
>  	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
>  	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
> -- 
> 2.39.2
> 

