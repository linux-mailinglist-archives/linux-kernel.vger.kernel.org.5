Return-Path: <linux-kernel+bounces-150871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF58AA612
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180AA284041
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF39C8E2;
	Fri, 19 Apr 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjJYeR+k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCAC383;
	Fri, 19 Apr 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713484883; cv=none; b=nFrcNABv8QlDM2xJZYkWGExuUZ1iZt0lBK+P9JmCzez36x2vqJ0qolvB1XuSQVUDYPx9oRWd4VFkD7qJsMkwxYvwsQCPe8GR++2GPXc2kQ/0lfWetTnyNPCxGWosFW2/6aj6XUBkb7GyQEuUMPmYAKw0mP50G5Q34Vh4acuXdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713484883; c=relaxed/simple;
	bh=GsOSqG+d+aXsocNGZFqAyduRtmrcvJZHq3i0NoxMLzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCX7/TlVKwWz1CY9f6alIBm3cd/xZf2Y7EAbxjOCeGMDy8Nd3k3t0tS8yLSmy//4nlFjuV/VNoQfZe4eMwCRHN61Se/WN9rVUSFZl9g17psBtRzzs8m6tAC4RwU2JMRBRqO4JNW/AaMkaMdYLdNzHtZSNdNdedFYxQ4Gg+9xK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjJYeR+k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713484881; x=1745020881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GsOSqG+d+aXsocNGZFqAyduRtmrcvJZHq3i0NoxMLzU=;
  b=GjJYeR+ko3qv9eZaawPGWEfc42fHLTiOyFlptTpVruw94bzwKX0wCtqT
   GssXFEClAmJ5BI8PO9WZsbOTgeOWUcDGYSgBIf3G8cqXobIbLiGgFAMjM
   kE/joN2OAnN+j8aoYVqLean9H5WyEKz0VKsWP2D2jqdg3UBR0hND5LWo9
   yl4sjCObgPX2Qm/DO84xosRPcUqKXZG0SjXsDgCyMZ2FhfW4Q/kK1DRoX
   WA8E00UCDWojLYxczKR+Rahm3bAqgtLXgibqSR8gu2ZQxF+n4UGEYkima
   141wCZQvXF1EHsDJw3B3fchFEE5tGVlP+xC7Y1pRwfZlvD6Av/j43CiP2
   w==;
X-CSE-ConnectionGUID: 0pYJJFxRRWuPaEMAGbLjWQ==
X-CSE-MsgGUID: prOzMG2DR8qZ/vKTLCdsoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12849715"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12849715"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:01:21 -0700
X-CSE-ConnectionGUID: vJCVfeBZTWeqsSA1+nqNOg==
X-CSE-MsgGUID: cfDaxB79Q32WiYnyfnM73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60588307"
Received: from sferrell-mobl2.amr.corp.intel.com (HELO desk) ([10.209.93.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:01:21 -0700
Date: Thu, 18 Apr 2024 17:01:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	ebiggers@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
	tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, x86@kernel.org,
	herbert@gondor.apana.org.au, ardb@kernel.org, elliott@hpe.com,
	dan.j.williams@intel.com, bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v9a 10/14] x86/cpu/keylocker: Check Gather Data Sampling
 mitigation
Message-ID: <20240419000113.2tjvyigx7nlyymrw@desk>
References: <20240329065742.fc5of75e776y2g4b@desk>
 <20240407230432.912290-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407230432.912290-1-chang.seok.bae@intel.com>

On Sun, Apr 07, 2024 at 04:04:32PM -0700, Chang S. Bae wrote:
> Gather Data Sampling is a transient execution side channel issue in some
> CPU models. The stale data in registers is not guaranteed as secure when
> this vulnerability is not addressed.
> 
> In the Key Locker usage during AES transformations, the temporary storage
> of the original key in registers poses a risk. The key material can be
> staled in some implementations, leading to susceptibility to leakage of
> the AES key.
> 
> To mitigate this vulnerability, a qualified microcode image must be
> applied. Add code to ensure that the mitigation is installed and securely
> locked. Disable the feature, otherwise.
> 
> Expand gds_ucode_mitigated() to examine the lock state.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> Changes from v9:
> * Removed MSR reads and utilized the helper function. (Pawan Gupta)
> 
> Alternatively, 'gds_mitigation' can be exported and referenced directly.
> Using 'gds_mitigation == GDS_MITIGATION_FULL_LOCKED' may also be
> readable. However, it was opted to expand gds_ucode_mitigated() for
> consistency, as it is already established.
> 
> Note that this approach aligns with Intel's guidance, as the bugs.c code
> checks the following MSR bits:
>   "Intel recommends that system software does not enable Key Locker (by
>    setting CR4.KL) unless the GDS mitigation is enabled
>    (IA32_MCU_OPT_CTRL[GDS_MITG_DIS] (bit 4) is 0) and locked
>    (IA32_MCU_OPT_CTRL [GDS_MITG_LOCK](bit 5) is 1)."
> 
> For more information, refer to Intel's technical documentation on Gather
> Data Sampling:
>   https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/gather-data-sampling.html
> ---
>  arch/x86/include/asm/processor.h |  7 ++++++-
>  arch/x86/kernel/cpu/bugs.c       |  5 ++++-
>  arch/x86/kernel/keylocker.c      | 12 ++++++++++++
>  arch/x86/kvm/x86.c               |  2 +-
>  4 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..74eaa3a2b85b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -721,7 +721,12 @@ enum mds_mitigations {
>  	MDS_MITIGATION_VMWERV,
>  };
>  
> -extern bool gds_ucode_mitigated(void);
> +enum mitigation_info {
> +	MITG_FULL,
> +	MITG_LOCKED,
> +};
> +
> +extern bool gds_ucode_mitigated(enum mitigation_info mitg);
>  
>  /*
>   * Make previous memory operations globally visible before
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index e7ba936d798b..80f6e70619cb 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -752,8 +752,11 @@ static const char * const gds_strings[] = {
>  	[GDS_MITIGATION_HYPERVISOR]	= "Unknown: Dependent on hypervisor status",
>  };
>  
> -bool gds_ucode_mitigated(void)
> +bool gds_ucode_mitigated(enum mitigation_info mitg)
>  {
> +	if (mitg == MITG_LOCKED)
> +		return gds_mitigation == GDS_MITIGATION_FULL_LOCKED;
> +
>  	return (gds_mitigation == GDS_MITIGATION_FULL ||
>  		gds_mitigation == GDS_MITIGATION_FULL_LOCKED);
>  }
> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> index 1e81d0704eea..23cf4a235f11 100644
> --- a/arch/x86/kernel/keylocker.c
> +++ b/arch/x86/kernel/keylocker.c
> @@ -113,6 +113,15 @@ void restore_keylocker(void)
>  	valid_wrapping_key = false;
>  }
>  
> +/* Check if Key Locker is secure enough to be used. */
> +static bool __init secure_keylocker(void)
> +{
> +	if (boot_cpu_has_bug(X86_BUG_GDS) && !gds_ucode_mitigated(MITG_LOCKED))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int __init init_keylocker(void)
>  {
>  	u32 eax, ebx, ecx, edx;
> @@ -126,6 +135,9 @@ static int __init init_keylocker(void)
>  		goto clear_cap;
>  	}
>  
> +	if (!secure_keylocker())
> +		goto clear_cap;
> +
>  	cr4_set_bits(X86_CR4_KEYLOCKER);
>  
>  	/* AESKLE depends on CR4.KEYLOCKER */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 47d9f03b7778..4ab50e95fdb5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1675,7 +1675,7 @@ static u64 kvm_get_arch_capabilities(void)
>  		 */
>  	}
>  
> -	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
> +	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated(MITG_FULL))
>  		data |= ARCH_CAP_GDS_NO;
>  
>  	return data;

Repurposing gds_ucode_mitigated() to check for the locked state is
adding a bit of a churn. We can introduce gds_mitigation_locked()
instead.

Is below looking okay:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..8ba96e8a8754 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -722,6 +722,7 @@ enum mds_mitigations {
 };
 
 extern bool gds_ucode_mitigated(void);
+extern bool gds_mitigation_locked(void);
 
 /*
  * Make previous memory operations globally visible before
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ca295b0c1eee..a7ec26988ddb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -753,6 +753,11 @@ bool gds_ucode_mitigated(void)
 }
 EXPORT_SYMBOL_GPL(gds_ucode_mitigated);
 
+bool gds_mitigation_locked(void)
+{
+	return gds_mitigation == GDS_MITIGATION_FULL_LOCKED;
+}
+
 void update_gds_msr(void)
 {
 	u64 mcu_ctrl_after;
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 1b57e11d93ad..c40e72f482b1 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -112,6 +112,15 @@ void restore_keylocker(void)
 	valid_wrapping_key = false;
 }
 
+/* Check if Key Locker is secure enough to be used. */
+static bool __init secure_keylocker(void)
+{
+	if (boot_cpu_has_bug(X86_BUG_GDS) && !gds_mitigation_locked())
+		return false;
+
+	return true;
+}
+
 static int __init init_keylocker(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -125,6 +134,9 @@ static int __init init_keylocker(void)
 		goto clear_cap;
 	}
 
+	if (!secure_keylocker())
+		goto clear_cap;
+
 	cr4_set_bits(X86_CR4_KEYLOCKER);
 
 	/* AESKLE depends on CR4.KEYLOCKER */

