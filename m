Return-Path: <linux-kernel+bounces-166367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3878B9993
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24910B21178
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06615FDA6;
	Thu,  2 May 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVXEveIN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B473657AE;
	Thu,  2 May 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647619; cv=none; b=EpiPrJ/cXb56VCKm8oWbZeRjPu7tcFXlLrOqq/CxFKTAeh9HBVPcnhlhls+s2vBDHQXFgoTsnCce+VLW4KP6Bc9Fz77o81/jqCp7v/wSedTYRfLCEdBY3YsSAlJzsZ6f4pNfO48fCGrRU77hw4GvmY8fy/Eq5rdyuouJ+n6yAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647619; c=relaxed/simple;
	bh=lmtz+epT2zQrOYIcCikEEH5WfUpPn0LSP4C6ZySsU/s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KLyGzkNb6RW51Drh30+4u2QljsdKUiZ4TuiikW9AZLYXZqviG27Ne7C7MKEthryz3sE8eTpTsKKxPeHHcPf8KQxqno1U6W/Ind4beB3r2ZN70lQmp8F91ZVnhpqRR2vpXxwq7I4YCTrB8tM/gZt0U4H/NBdjQG/DT9IQ7cgLd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVXEveIN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647618; x=1746183618;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lmtz+epT2zQrOYIcCikEEH5WfUpPn0LSP4C6ZySsU/s=;
  b=TVXEveIN46K1TNXzGPw7wjN9rzVqvMuxOh3buIPrRRFldloewctBZjLM
   vNFMWW23774bVymHP3fzEjOJxYCaX53MP8UcSUnwlpxD89swGwZQxlqzE
   9eDHtJYlxHdeE9lfAZyzmdo6JDjVLbe/h+uEwi6+PHj9Jy3RAEtDn3KBb
   lXtMAhbMkWaEUDsy66Ws/KF5+akznHxY0QepeGd2tXRH4RQFaDsS2zzTs
   FmhxxriGOPFMLH3m+f6O2VdC8thaBfk6km3N7O7O4J5dU/SmqnRS0NCtl
   0JJLuQBooTriyby8QGzWSQvvxy+4+gRO6ngBwaMlQS+FXYNkZV92TjrV/
   A==;
X-CSE-ConnectionGUID: lPJvOzWaTQCj2oGSe7RdXw==
X-CSE-MsgGUID: V2t4EWf3RhSnlovzuVpGYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10265956"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10265956"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 04:00:17 -0700
X-CSE-ConnectionGUID: DCbRcM49RX6PpE8SItRZNw==
X-CSE-MsgGUID: cik+Sa9/R0OVu95UN4wpKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27693417"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.54])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 04:00:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 May 2024 14:00:06 +0300 (EEST)
To: "Chang S. Bae" <chang.seok.bae@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
    platform-driver-x86@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, tony.luck@intel.com, 
    ashok.raj@intel.com, jithu.joseph@intel.com
Subject: Re: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for
 the scan test
In-Reply-To: <20240430212508.105117-3-chang.seok.bae@intel.com>
Message-ID: <f97d4275-11b1-4b98-9491-ff6c5f117eee@linux.intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com> <20240430212508.105117-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Apr 2024, Chang S. Bae wrote:

> The scan test does not start when the AMX state remains active and is not
> re-initialized. With the extension of kernel_fpu_begin_mask(), the driver
> code can now initialize the state properly.
> 
> Introduce custom FPU handling wrappers to ensure compliant with the
> established FPU API semantics, as kernel_fpu_begin() exclusively sets
> legacy states. This follows the EFI case from commit b0dc553cfc9d
> ("x86/fpu: Make the EFI FPU calling convention explicit").
> 
> Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
> minimize the critical section. To prevent unnecessary delays, invoke
> ifs_fpu_begin() before entering the rendezvous loop.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
> Tested-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 56b9f3e3cf76..71d8b50854b2 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -325,4 +325,18 @@ int do_core_test(int cpu, struct device *dev);
>  extern struct attribute *plat_ifs_attrs[];
>  extern struct attribute *plat_ifs_array_attrs[];
>  
> +static inline void ifs_fpu_begin(void)
> +{
> +	/*
> +	 * The AMX state must be initialized prior to executing In-Field
> +	 * Scan tests, according to Intel SDM.
> +	 */
> +	kernel_fpu_begin_mask(KFPU_AMX);
> +}
> +
> +static inline void ifs_fpu_end(void)
> +{
> +	kernel_fpu_end();
> +}
> +
>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 95b4b71fab53..a35eac7c0b44 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -188,6 +188,9 @@ static int doscan(void *data)
>  	/* Only the first logical CPU on a core reports result */
>  	first = cpumask_first(cpu_smt_mask(cpu));
>  
> +	/* Prepare FPU state before entering the rendezvous loop*/

Missing space

-- 
 i.


