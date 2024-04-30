Return-Path: <linux-kernel+bounces-164305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA38B7C18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2226B2296D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63709172BD5;
	Tue, 30 Apr 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Alt3MrFS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD0173359;
	Tue, 30 Apr 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492197; cv=none; b=PQhxX2m1c32TgGD/M6UF4VnFLUcbJEqi68u4UYbDcgg4yG0FoE7tW56N1lT6jG+kIV6qFb3y1zgNEqkO+iEuuKFivR6ZcD4dYOdOXrtOSwbMjYOn9sGl11od+XBlzs4ecwUBwS4fklONz9DybAC9QSHqGWF3QHAGc9Fd33Sm/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492197; c=relaxed/simple;
	bh=DIzesGh2roiGWEHGWPtLfOY92kVqmfuIinVegaspor0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd5PVhd+l1zDbpba0JJ9g774HPfjjOZCl/PIYmFSXHKKulddfKpDZuEqFQinIxTWMSQsl6Q5yaeTROYcDEVBxS4Iw9/XE7Uofwb/0EnqlYTSUB7TByiDg8sMQocK4TSZzO5yn7iidr4iue8eNZ+eMu0l6I1eBvrd7UV2j5AF5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Alt3MrFS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492196; x=1746028196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIzesGh2roiGWEHGWPtLfOY92kVqmfuIinVegaspor0=;
  b=Alt3MrFShDDAKdTyfA6Dxiejhn8wbcWtISsjtmPoyQGgdUHjERfo8MQn
   y5X9YwASIhC3mytinddIY+wvVMETWHlcH3oB0bnrChIPa4pPWjfntM/z+
   NxeXgJcYfiAW7SE0WA4LRylxdzaoUe5GM3Hzx5ecNpeCDLWVpvR60TjH5
   QTse19t5iIlNgM/iUmH7bD4HE8e/Q4hKLK2uDgXmAZ3a4+aCSJOdaJ7EX
   ucoWx9SwNtCGU0THQkovTYli6Wn+PtD5qXkZAvQ1bzfk9K5Zsf1LMQmVm
   LrKtT/uDnGKChanmCjUqSUvaEmYKwaBoxSRXHs/fJ9i1oA/FceE1kRNSp
   Q==;
X-CSE-ConnectionGUID: Ddmemf79Q5enX04UntmPCA==
X-CSE-MsgGUID: x8KvHZjzSLyTiCwGzhy7ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14033220"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="14033220"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:49:56 -0700
X-CSE-ConnectionGUID: DXmM3eFxSiiqtBly7KNEog==
X-CSE-MsgGUID: u0gtpmB4T0S/qCepwvi6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="63987709"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:49:55 -0700
Date: Tue, 30 Apr 2024 08:49:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <ZjETISx1g72Bft26@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-7-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-7-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:59AM +0200, Robert Richter wrote:
> Adding a pr_info() when successfully adding a CFMWS memory range.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 76b39a6d3aef..34ecf2dc912f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -339,8 +339,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * window.
>  	 */
>  	modified = numa_fill_memblks(start, end);
> -	if (modified != NUMA_NO_MEMBLK)
> +	if (modified != NUMA_NO_MEMBLK) {
> +		if (modified)
> +			pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +				(unsigned long long) start, (unsigned long long) end - 1);
>  		return 0;
> +	}
>  
>  	/* No SRAT description. Create a new node. */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
> @@ -355,8 +359,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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
> -- 
> 2.39.2
> 

