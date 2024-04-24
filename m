Return-Path: <linux-kernel+bounces-157531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF558B1269
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0129D1F21A55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C816F0DE;
	Wed, 24 Apr 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVBLRUKJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F316E88D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983344; cv=none; b=tGlJjjOMrtOZubyFt0PApRwtFovnVE2vyy7DnrVS5+GfXj2yPIeoV03q0F96sDEbtyJAZyDCDgGDGhw2LZLHQJIUabZMNdNPRYqFqkKARqGx3Pid4dZPs4hm4p9TMc0mVxJjQhkuuAyU13Rb1A5vr6au3rjKp8aXe/jhcMLuRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983344; c=relaxed/simple;
	bh=pASzK77Ts5o9D6W8WLMngPM+cJJgwLwJRtv7XzJUBB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz6dHU8nHEPFQ+OY1xOh+tfQxHeVMjANXwwIE2JjHevjiLU2LTbPxn6UeEPTDjOy1E3/zatiS11AxFOQAWAf4bfWkl2qhnz9IkZKu8d0qjC8N24pK0xoKI6wzwHSYF3BkRgFt4lXKARu3+o0HQaR+fOWCcMdvpBXU5WPulPs1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVBLRUKJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713983342; x=1745519342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pASzK77Ts5o9D6W8WLMngPM+cJJgwLwJRtv7XzJUBB8=;
  b=VVBLRUKJP7LV9YHY07xvBaGrnHqget7U86GO26yrr3l8qvEC8OV/+224
   YnUzcRJIY31LMVCL+zWhTQDGhviwpms+TqOo2lpeKRmsk8L1N4MvBN3/g
   fyC7ZFbC0ddJpfgOORzMC97tD1aoS7t4ZIRNbTD/aYfRceyNk90Ksrue2
   LR7w2Ja8YzBNClHx0zctvZ/3NAT8l32wnCTtS5+WhaQK4viRCnNkwCDB2
   rL7rwxJNttRQEOzUE70gt+J42BATQ3JdpYlX9tRDMdbLWGUoOwEKdWxQj
   LP8PxAFR5mwiaZIRpVXJ+V3Sd5TCDmjxzRvOCDDcn2EDzQrOi2yPesc37
   Q==;
X-CSE-ConnectionGUID: UJBoWP9PRjaa+eb8Kb2n/A==
X-CSE-MsgGUID: bO/1cwnmTD6hPLI0ky32pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9484415"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9484415"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:29:02 -0700
X-CSE-ConnectionGUID: Y7/V9fycQUujaQesoicONQ==
X-CSE-MsgGUID: i2Iqc/leRD2m1alGQZimZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29453681"
Received: from ttiasha-mobl1.amr.corp.intel.com (HELO [10.209.122.5]) ([10.209.122.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:29:01 -0700
Message-ID: <7eb992f3-ddc0-41d3-98e3-e9020eb90cb0@intel.com>
Date: Wed, 24 Apr 2024 11:29:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] x86/tdx: Handle PENDING_EPT_VIOLATION_V2
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, hpa@zytor.com,
 seanjc@google.com, elena.reshetova@intel.com, rick.p.edgecombe@intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <20240325104607.2653307-4-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240325104607.2653307-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 03:46, Kirill A. Shutemov wrote:
> PENDING_EPT_VIOLATION_V2 allows TD to control whether access to
> a pending page triggers #VE.
> 
> Kernel doesn't want to see any #VEs on accesses to private memory:
> disable such #VEs.

This is really a bare bones changelog.  The connection between "pending"
and "private" goes unmentioned.  It's not obvious when the kernel might
be exposed to one of these #VE's.

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 08e2bb462ce8..860bfdd5a11d 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -77,6 +77,17 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
>  
> +static inline u64 tdg_vm_rd(u64 field)
> +{
> +	struct tdx_module_args args = {
> +		.rdx = field,
> +	};
> +
> +	tdcall(TDG_VM_RD, &args);
> +
> +	return args.r8;
> +}
> +
>  static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
>  {
>  	struct tdx_module_args args = {
> @@ -91,6 +102,28 @@ static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
>  	return args.r8;
>  }
>  
> +static inline u64 tdg_sys_rd(u64 field)
> +{
> +	struct tdx_module_args args = {
> +		.rdx = field,
> +	};
> +
> +	tdcall(TDG_SYS_RD, &args);
> +
> +	return args.r8;
> +}

I scratched my head for a minute on why these two identical functions
were introduced.  Then I realized that they're different TDCALLs.

Please break them out into a separate patch where you can mention this.
Also, the least we can do is a one-line comment about what they do:

/* Read metadata about how *this* VM is configured. */
static inline u64 tdg_vm_rd(u64 field)
..

/* Read metadata about the TDX system as whole. */
static inline u64 tdg_sys_rd(u64 field)

> +static bool tdcs_ctls_set(u64 mask)
> +{
> +	struct tdx_module_args args = {
> +		.rdx = TDCS_TD_CTLS,
> +		.r8 = mask,
> +		.r9 = mask,
> +	};
> +
> +	return __tdcall(TDG_VM_WR, &args) == TDX_SUCCESS;
> +}

This is acronym soup.  It's made worse by "TDCS_TD_CTLS" being
ungoogleable and not literally present in the first three TDX PDFs that
I dug in.

It's also not clear logically how this differs from tdg_vm_wr().

>  /**
>   * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
>   *                           subtype 0) using TDG.MR.REPORT TDCALL.
> @@ -185,7 +218,8 @@ static void tdx_setup(u64 *cc_mask)
>  {
>  	struct tdx_module_args args = {};
>  	unsigned int gpa_width;
> -	u64 td_attr;
> +	u64 td_attr, features;
> +	bool sept_ve_disabled;
>  
>  	/*
>  	 * TDINFO TDX module call is used to get the TD execution environment
> @@ -206,19 +240,50 @@ static void tdx_setup(u64 *cc_mask)
>  	gpa_width = args.rcx & GENMASK(5, 0);
>  	*cc_mask = BIT_ULL(gpa_width - 1);
>  
> +	td_attr = args.rdx;
> +
>  	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
>  	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>  
> +	features = tdg_sys_rd(TDCS_TDX_FEATURES0);
> +
>  	/*
>  	 * The kernel can not handle #VE's when accessing normal kernel
>  	 * memory.  Ensure that no #VE will be delivered for accesses to
>  	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> +	 *
> +	 * Check if the TD is created with SEPT #VE disabled.
>  	 */
> -	td_attr = args.rdx;
> -	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> -		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> +	sept_ve_disabled = td_attr & ATTR_SEPT_VE_DISABLE;
>  
> -		/* Relax SEPT_VE_DISABLE check for debug TD. */
> +	/*
> +	 * Check if flexible control of SEPT #VE is supported.
> +	 *
> +	 * The check consists of verifying if the feature is supported by the
> +	 * TDX module (the TDX_FEATURES0 check) and if the feature is enabled
> +	 * for this TD (CONFIG_FLAGS check).
> +	 *
> +	 * If flexible control is supported, disable SEPT #VE.
> +	 *
> +	 * Disable SEPT #VE regardless of ATTR_SEPT_VE_DISABLE status as
> +	 * flexible control allows software running before the kernel to
> +	 * enable it.
> +	 *
> +	 * Skip SEPT disabling for debug TD. SEPT #VE is unsafe but can be
> +	 * useful for debugging to produce a stack trace. Known to be useful
> +	 * for debugging unaccepted memory problems.
> +	 */
> +	if (features & TDX_FEATURES0_PENDING_EPT_VIOLATION_V2 &&
> +	    (tdg_vm_rd(TDCS_CONFIG_FLAGS) & TDCS_CONFIG_FLEXIBLE_PENDING_VE) &&

Can't we just check TDCS_CONFIG_FLEXIBLE_PENDING_VE alone?  Surely that
flag can't get set if !TDX_FEATURES0_PENDING_EPT_VIOLATION_V2.

In any case, this is, um, kinda messy.  Look at what a helper could do:

/*
 * Private memory #VE's are bad because the kernel has no way of
 * recovering from them and can only die. Newer TDX modules can
 * configured to inflict fewer #VE's on guests.  Do it when available.
 */
static inline int try_disable_sept_ve(td_addr)
{
	/* Does the TDX module support the #VE reduction feature? */
	if (!(features & TDX_FEATURES0_PENDING_EPT_VIOLATION_V2))
		return -ENOTSUP;

	/* Is this TD allowed to use the feature? */
	if (!(tdg_vm_rd(TDCS_CONFIG_FLAGS) &
	     TDCS_CONFIG_FLEXIBLE_PENDING_VE)))
		return -ENOTSUP;

	/* Keep #VE's enabled for splats in debugging environments: */
	if (td_attr & ATTR_DEBUG)
		return -ENOTSUP;

	if (!tdcs_ctls_set(TD_CTLS_PENDING_VE_DISABLE))
		return -ENOTSUP;

	return 0;
}

Then the code becomes:
	
	if (!try_disable_sept_ve(td_addr))
		sept_ve_disabled = true;
	else
		sept_ve_disabled = td_attr & ATTR_SEPT_VE_DISABLE;

See how it sets the state in *ONE* easy-to-understand place?

Oh, 'sept_ve_disabled' either gets disabled dynamically if it can, or it
gets read from the static state if not.

Oh, and if you ever have a comment that long with a bunch of
explanations of individual if() conditions, *PLEASE* try to break it up
in some way.  Otherwise readers just spent all their time trying to
match up the comment to the code.  It's not a fun game.

> +	    !(td_attr & ATTR_DEBUG)) {
> +		if (tdcs_ctls_set(TD_CTLS_PENDING_VE_DISABLE))
> +			sept_ve_disabled = true;
> +	}
> +
> +	if (!sept_ve_disabled) {
> +		const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
> +
> +		/* Relax SEPT #VE disable check for debug TD. */
>  		if (td_attr & ATTR_DEBUG)
>  			pr_warn("%s\n", msg);
>  		else
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index fdfd41511b02..29a61c72e4dd 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -16,11 +16,27 @@
>  #define TDG_VP_VEINFO_GET		3
>  #define TDG_MR_REPORT			4
>  #define TDG_MEM_PAGE_ACCEPT		6
> +#define TDG_VM_RD			7
>  #define TDG_VM_WR			8
> +#define TDG_SYS_RD			11
>  
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX Global Metadata. To be used by TDG.SYS.RD */
> +#define TDCS_TDX_FEATURES0		0x0A00000300000008
> +
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>  
> +/* TDCS_TDX_FEATURES0 bits */
> +#define TDX_FEATURES0_PENDING_EPT_VIOLATION_V2	BIT_ULL(16)
> +
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
>  #define TDVMCALL_GET_QUOTE		0x10002


