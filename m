Return-Path: <linux-kernel+bounces-133380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79089A307
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB3E288D16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3AE171659;
	Fri,  5 Apr 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+Z8/UQ2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6116FF49
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336598; cv=none; b=HIuS05fb3aqNJuYySUY2d3iK31SlUxCkNuOIGJn5FC18izj9iGWOKop5ktG8DDuszm7OUXXEUqENvLLIvLv2FYKswKTeC6mRGDU9840E1eYvYFkenuo3tZ/eNiq7YZDLI/GFS1JDSVSmIxIbq932/hZAJVCFWXUnzJcz89nqtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336598; c=relaxed/simple;
	bh=A2gJT9MPNiiRXZ3I1nDIIjh5qrMf6fMPCrzE1goQE7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUa7PxeO1wTEfu1G4P56hS7pTqSP+SPyjieGUzHirviwdUs5n/xPnuuswvDIfoumxQcm+gdDvXhcUH2FyBXxAg/F0JgKF2l4CXbm1thT4NXLge5OamUpJIQ0jBpnWwwBnf0JVHSmn/tvg16vKmtd6qHPbrM0aszW/kgNzSTkUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+Z8/UQ2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336597; x=1743872597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2gJT9MPNiiRXZ3I1nDIIjh5qrMf6fMPCrzE1goQE7g=;
  b=L+Z8/UQ2QJ3h2s9a0bybRlZrhJKUJ8lppTlamJui3RbGN760oP0ARIDC
   tfeVRDwSzz3qkm9QCsOyrw18pvR+/EZDO11VnNRhnpj1yyk1Jm8dztghJ
   r2Eaj4U8CG4IbCc51zuYGObwPR8xMmXcsUE4z4K5llS+IXvbFN75kiFFj
   xgkNvNK7pzlJaUiefKcjbvCU32UC4EE31Fzx10wdLiH3/TsVohTobiEJi
   pfOtMlY6ZXOgr0yx8Pj0JYAkOeSo4U24sY1+dA90DmTcBUPO94NwoooyB
   z5sltL95/Fu7jlz8cvKJ4o06GWI6r4Hep1WKDww5LKAfFkbHaVDYjx9WN
   A==;
X-CSE-ConnectionGUID: beVtw9pnQPq+r/ujRLWHKA==
X-CSE-MsgGUID: FTmVuDvhS+SS2uyy4XOcsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="33075457"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="33075457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:03:16 -0700
X-CSE-ConnectionGUID: FR0NuFbmTRaj/tKSyh8wNA==
X-CSE-MsgGUID: 4MeI8IxHSqy4FTP2KXFNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23941500"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:03:15 -0700
Message-ID: <9322f040-d2f9-4bdc-a85a-edf0082aea46@linux.intel.com>
Date: Fri, 5 Apr 2024 10:03:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] x86/sev: add sev_es_enabled() function.
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <cover.1712270975.git.ashish.kalra@amd.com>
 <e14edff1b22705de6b66f4cbde5df3dc68eb10c1.1712270976.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e14edff1b22705de6b66f4cbde5df3dc68eb10c1.1712270976.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 4:11 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Add sev_es_enabled() function to detect if SEV-ES
> support is enabled.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/boot/compressed/sev.c | 5 +++++
>  arch/x86/boot/compressed/sev.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index ec71846d28c9..4ae4cc51e6b8 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -134,6 +134,11 @@ bool sev_snp_enabled(void)
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }
>  
> +bool sev_es_enabled(void)
> +{
> +	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> +}
> +
>  static void __page_state_change(unsigned long paddr, enum psc_op op)
>  {
>  	u64 val;
> diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
> index fc725a981b09..5008c80e66e6 100644
> --- a/arch/x86/boot/compressed/sev.h
> +++ b/arch/x86/boot/compressed/sev.h
> @@ -11,11 +11,13 @@
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  bool sev_snp_enabled(void);
> +bool sev_es_enabled(void);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  
>  #else
>  
>  static inline bool sev_snp_enabled(void) { return false; }
> +static inline bool sev_es_enabled(void) { return false; }
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  
>  #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


