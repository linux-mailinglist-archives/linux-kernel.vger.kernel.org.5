Return-Path: <linux-kernel+bounces-164346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2338B7C99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012EA284764
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE5178CC9;
	Tue, 30 Apr 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYELY9v5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC55171E67;
	Tue, 30 Apr 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493822; cv=none; b=ICABMbDEu20tTd3efQRPoWsfmeGYK3fH6u42sG/4qojXQV9oeMSzsQtu1itJhZow7dvp4lvRd2lGdHg/w6OrHPjPKPdvJ7kU8h3oTcdvNeA7yaZMLypNdCSmyD0FsITOABglmhmqGLFWNsDjvj54duelBISZP7yhzIjo2frycmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493822; c=relaxed/simple;
	bh=1qwQ48ujsS+2RxTaGVXW7u4aedmWyxR5OPDCZx+e8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnDva0G77hcQU2cyLzxGf88OZYGQyw6QMDmpEQsRW3fsOZ/sQyma/D/v47L1xlLOCYO71KrHJb0tV7ule2QGSqJvUg75ePjrYm2DPXL4Qa7t72PfvPttpKx9aE3uqmh298H8OmRIFJfdniPJ4kwGrD7jp0dGOwt3YY6o/aZj8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYELY9v5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714493820; x=1746029820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qwQ48ujsS+2RxTaGVXW7u4aedmWyxR5OPDCZx+e8zM=;
  b=jYELY9v5wCDQ9IPmlVjFvsEX0/6BmVdrUorHnZH8edgnOmhDC7hpSB1c
   0BPF8eHyaCZpFFh4LPh84IEFP9KOvpHV9w0+m51ExXhl1/sag+2sf6/Hm
   qLnwoRA+M7s+QezjUi/fzu52P3iVNIwJtERwLj/SgwI/dtB/8nEx1IpGh
   GqOMZyLwkoHgyZfV2Azq/gUelSD31FKI13ak/Y4BKQk4YlrQ2LzRbdlZ/
   6I172GwdyIrAIaS8uQ5u/vir6SYA/po3M/JHN4OkHK00j/gydOEHdIJs3
   UynOOBeCxW0sVpJkDnbUT2ndH6RPrAFT0iJAU98/CO27dt58qtagET5VB
   w==;
X-CSE-ConnectionGUID: OSQ0fk8ETyGcRwg19Hu5yg==
X-CSE-MsgGUID: ot/FQCQ0SDGhxJKrlB6/AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20758875"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20758875"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:17:00 -0700
X-CSE-ConnectionGUID: n+gfSvm4Qm+Clh9r5FdG9g==
X-CSE-MsgGUID: 7O5zTyLrT66BykzoSABAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26473821"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:16:57 -0700
Date: Tue, 30 Apr 2024 09:16:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZjEZeHOlCSUMvMoD@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-2-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:54AM +0200, Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> SRAT lookup fails then because an existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> Fix this by making numa_fill_memblks() always available regardless of
> NUMA_KEEP_MEMINFO.
> 
> The fix also removes numa_fill_memblks() from sparsemem.h using
> __weak.
> 
> From Dan:
> 
> """
> It just feels like numa_fill_memblks() has absolutely no business being
> defined in arch/x86/include/asm/sparsemem.h.
> 
> The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> applied to memory ranges hot-onlined by the CXL driver.
> 
> It belongs right next to numa_add_memblk(), and I suspect
> arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> what to do about the fact that linux/numa.h does not include asm/numa.h
> and that all implementations either provide numa_add_memblk() or select
> the generic implementation.
> 
> So I would prefer that this do the proper fix and get
> numa_fill_memblks() completely out of the sparsemem.h path.
> 
> Something like the following which boots for me.
> """
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too, a message is seen then in the logs:
> 
>  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 

For the commit log above -
Perhaps the Dan quote can be reduced to a note about the implementation
choice. Folks can look up the Lore thread if history is needed.

For the code -
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> Authorship can be changed to Dan's if he wants to but that needs his
> Signed-off-by.
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/include/asm/sparsemem.h | 2 --
>  arch/x86/mm/numa.c               | 4 ++--
>  drivers/acpi/numa/srat.c         | 5 +++++
>  include/linux/numa.h             | 7 +------
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..64df897c0ee3 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> -extern int numa_fill_memblks(u64 start, u64 end);
> -#define numa_fill_memblks numa_fill_memblks
>  #endif
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 65e9a6e391c0..ce84ba86e69e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +#endif
> +
>  static int __init cmp_memblk(const void *a, const void *b)
>  {
>  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	}
>  	return 0;
>  }
> -
> -#endif
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e45e64993c50..3b09fd39eeb4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -208,6 +208,11 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> +__weak int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	return NUMA_NO_MEMBLK;
> +}
> +
>  #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 915033a75731..1d43371fafd2 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -36,12 +36,7 @@ int memory_add_physaddr_to_nid(u64 start);
>  int phys_to_target_node(u64 start);
>  #endif
>  
> -#ifndef numa_fill_memblks
> -static inline int __init numa_fill_memblks(u64 start, u64 end)
> -{
> -	return NUMA_NO_MEMBLK;
> -}
> -#endif
> +int numa_fill_memblks(u64 start, u64 end);
>  
>  #else /* !CONFIG_NUMA */
>  static inline int numa_nearest_node(int node, unsigned int state)
> -- 
> 2.39.2
> 

