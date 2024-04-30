Return-Path: <linux-kernel+bounces-164197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FF8B7A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DB21F21527
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB189770EF;
	Tue, 30 Apr 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7HekdCa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5EBE49
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488556; cv=none; b=eZ2Eyn0+Xbmdm3JzTR9CDnzQc/f+u29zfApuTa4SGBHn9pn8jOYCaiPFKTwFbc0QISMrCFwc1cnTTO4uQhTvF/ER1g4uP0dNdBk8MZ7hzsBdNE13eReTJUdWxuE45YBCMZXMd78ZJsPp++fKXKLdlnYmsWeArnn0Vj8F7kI4GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488556; c=relaxed/simple;
	bh=D8fOR3tKfUk/VedpB6Kp/qfPdRU/1bC9Ahf877NrOig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLdZ5C1lQSJ1Bmzajs3q/sPTShHFfDajYFBU7u82F/NPeIbanPutN8kqBkER/gxggZhfp8XqWA5tCOFevCoF0eeNe+4xkLvLipGMbfGUspGSaeoDpqS+RYjIqanCDuOH/MLKTc7UXavGNybZCY8m5/VRwkoDtPgi7cEf5rfNNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7HekdCa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488555; x=1746024555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D8fOR3tKfUk/VedpB6Kp/qfPdRU/1bC9Ahf877NrOig=;
  b=Z7HekdCalqrGaUJTwNqA0r5lCyoLDTsBr9dVSkaRUq/XXKG+iKz+tAD6
   8AIf5iVTQCXWGsf2asNLKaulXmulJxv6BMw0Z2SVloaPu9IEwEVJfNVyD
   maZzRv9gvPHar+BH/Gp+tuG0RDYwhj8mlLA+qMxpWNHIxmscfpvHZAwFu
   GN4k30yqrcbFYOrmJloXllM7dl3Izqwv/iLs3BLP1q2PWNX/ROUyeNYpe
   THv91dLgBf642LIpwpuBKLcdJmoBT8mtgS2nffWYe/aVfJeeQuOpoZTWy
   JM7aY/OuQFP1X8SiD/ZhjpYy0e6u/LWOEDNwhoAKWXjZ+lPtTXHsjWdKt
   g==;
X-CSE-ConnectionGUID: Wl8DFSGDSKybcxBtnI9JaQ==
X-CSE-MsgGUID: daf035PhQxGbQtnoTys0mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21350242"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21350242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:49:15 -0700
X-CSE-ConnectionGUID: cK5AUJaAQWiWfFZrIJ3DXA==
X-CSE-MsgGUID: JhJfI17xS8CacJcZ6ZtrSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31280904"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:49:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4FF831A1; Tue, 30 Apr 2024 17:49:08 +0300 (EEST)
Date: Tue, 30 Apr 2024 17:49:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>

On Tue, Apr 30, 2024 at 03:03:23PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:57PM +0300, Kirill A. Shutemov wrote:
> > +1:
> > +	testq	$X86_CR4_MCE, %r13
> > +	jz	1f
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> >  1:
> 
> Please add the below patch to your set. Those same-number labels are
> just abominable.
> 
> Thx.
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 30 Apr 2024 15:00:16 +0200
> Subject: [PATCH] x86/relocate_kernel: Use named labels for less confusion
> 
> That identity_mapped() function was loving that "1" label to the point
> of completely confusing its readers.
> 
> Use named labels in each place for clarity.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 8e2037d78a1f..0077c9e562a7 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -152,13 +152,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 */
>  	movl	$X86_CR4_PAE, %eax
>  	testq	$X86_CR4_LA57, %r13
> -	jz	1f
> +	jz	no_la57
>  	orl	$X86_CR4_LA57, %eax
> -1:
> +no_la57:

I assume all of these new labels have to be prefixed with ".L", right?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

