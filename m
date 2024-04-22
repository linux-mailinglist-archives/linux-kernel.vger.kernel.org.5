Return-Path: <linux-kernel+bounces-154019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E178AD62F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E131B21905
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBB1C68D;
	Mon, 22 Apr 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmH78KZU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15C1BC53;
	Mon, 22 Apr 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819365; cv=none; b=EciNMVDDCpsOFSvOSzgwjXKB9jao58QHgZfoztGDJkRAgOKleSieHPQzs2s1PfBHFvMei8Q8qPObccHGRSF7tBrHVDqwOjt1RAO08FX96Uxjvr7KMfmwA+4+6XC4T/lSrmPaU0Pvf5SjRTLJPXc5t/ti2yRVH/+dK6xFSvAZPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819365; c=relaxed/simple;
	bh=6ICFHFR3301cJ5QGUKwTHJ3g0vce37SC2W2seX+taAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Foqe1M8r06wlCwLX3jb7xk52w+Pt4K5QIrAvCgs/1RLYXwEXjIKY4iAZXbNvshj8alzTljgUupUC5lZp4tAV6UtY9K5UV8xQysvPlGS6GOoRYGPrASz2TiFnCzvgR8mcq1QO1FFSB2PevteAQD3Pel7QEA0c81tdkI3T8mOjflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmH78KZU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713819364; x=1745355364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ICFHFR3301cJ5QGUKwTHJ3g0vce37SC2W2seX+taAA=;
  b=TmH78KZUFits2hzS1imr65xxV001lsXaiZcUixzvLgMfP2vmFSwq4Rt3
   pUUoUhNXcI38Jrryqe5M20mQS2bsI0qMVI7IPIvXA69orQtRk3yqQSV9t
   v4PENldn5Fbj4atYl/AkgpM0GPt/a19ecnxjDPNJZytmOV1ACKeFn5aut
   em3rVmOFUm2LXp9r7TAURocczaa+dudcmpyMNSXblaFBPyh0frH31JXNv
   cmnZYtpU+IlpyyUKiIFJoJ+bTcNRQ7mxwaxSvBj0tXFxf3LKiAfOxzjBx
   WlweBP5H9nqe1CyVTQN3VDDEQttXrUa0zLeXuJKE4dmBCe7WpV293CYE3
   g==;
X-CSE-ConnectionGUID: uAWyIN7uTMGHWSPbr2WHOw==
X-CSE-MsgGUID: GFhL40M/RC2TE8KlAugacA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9236228"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9236228"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:56:03 -0700
X-CSE-ConnectionGUID: 0KXYQTRzQS6FxpZuFe+fzA==
X-CSE-MsgGUID: rzDqJw0bTI+ISPHzb6XKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24755783"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.73.120])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:56:02 -0700
Date: Mon, 22 Apr 2024 13:56:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 2/5] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <ZibO4C7bGb4tsXuJ@aschofie-mobl2>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-3-rrichter@amd.com>

On Fri, Apr 19, 2024 at 04:02:00PM +0200, Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.
> 
> Adding also a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com> # CEDT node info

Ah, I see you annotated the Suggested-by. I did suggest the pr_info
when we extend or add a node during CFMWS parsing.

There is an update in acpitools for CEDT decode and dump[1] offering
pretty dumps of this info. Is this printing for convenience or for
something else?

[1] https://github.com/acpica/acpica/pull/939

-- Alison

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 122 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e45e64993c50..43417b4920da 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,114 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  	return -EINVAL;
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
> @@ -318,8 +426,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * found for any portion of the window to cover the entire
>  	 * window.
>  	 */
> -	if (!numa_fill_memblks(start, end))
> +	if (!numa_fill_memblks(start, end)) {
> +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +			(unsigned long long) start, (unsigned long long) end - 1);
>  		return 0;
> +	}
>  
>  	/* No SRAT description. Create a new node. */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
> @@ -334,13 +445,19 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +
>  	node_set(node, numa_nodes_parsed);
>  
> +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> +		node, *fake_pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1);
> +
>  	/* Set the next available fake_pxm value */
>  	(*fake_pxm)++;
>  	return 0;
>  }
>  #else
> +static inline void acpi_table_print_cedt(void) {}
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -526,6 +643,9 @@ int __init acpi_numa_init(void)
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

