Return-Path: <linux-kernel+bounces-71655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6793D85A880
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F37B224D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4A3C467;
	Mon, 19 Feb 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cmkEG0Ey"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8093B786
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359411; cv=none; b=VeX+PUlz0DWrvj1g7eQC1vZ0E0Avd8nHNJyWq3RxHQHKumxWf9UfEIuvtxXtZYVXtvvAVxHQpyPXTjfBaotzfUudO83WAcDPJcLma+3Uc9nwlcUXdaIsoix2tvxYtn85BoaWQ9wAPvXA1h7Tieni9BLXz1CrwLSf+zAWYCwWUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359411; c=relaxed/simple;
	bh=6nn3K815Mey3LKTMBUWQ3fZc5Zl9O70qnUfSd484W0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJLAjCvYpxl+T8XlsMGnt1HC12axh4rBdr27rFlOOI+g3q06NsFi92AAou5JTLbnKAoccwA0Bi/Jcp+P974vxn5iHIL9xGGiNRLH1sAMxsNujx54e3Jykek0o61GYDHAdoPhOUZ6NTYdvgbUT0EkOI7JVXCEFsgN8qx0QKrWY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cmkEG0Ey; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B55140E01A9;
	Mon, 19 Feb 2024 16:16:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0KBv4i3D13kl; Mon, 19 Feb 2024 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708359400; bh=8bfKgpkM2ZU7GQv7OHjtlB1tdOdFbp91Xx8Zhw7et7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmkEG0EyCgjzFPz6vtODHnDoPQ66oNgg2zu43jcXSeQ9H4x/B9fVGRyhuxluwIHvm
	 Nwgq7QMDy2G2nRIgNFoOwhHKOLmylJ3BNtulnau6rbIa/xGQer5Jqfsqnp5C1fdec8
	 BpOpVBbUSJLag+XBr0Ws4oZ+Ux42he5iOjXYQm70RMqeCHHwUMjPk7EgjzOwiI7C/W
	 ktH4K89IE1Lm7PijNgGIwilJY8UoSbJ63pAme85hmg/PKuxgttsAsAgxgaKz6Q6bwH
	 CHVDR+OxJxdvLHBQMyx5FgtrxfLgYhrq1LbOmN+czWcyl40T52thhJTzO2ZZp2Scfd
	 s3EwnFlpO1kJeJAfti1iLSX5P4iOxyNHYYmdJSl9s4q8k4tyzeaC2NW+a254aMdvgj
	 LV432EdOX6B+5PYN7fyBvdsB1C5Jfs6sROLYr07tSpLsUJNnFnRxv1YIQh5zEk24Yi
	 CIhAk6qOCg+hzEFOetuAxcEb73Z7BxzM3L927fwOnzgrUzMMV1r6sCDMBGDkNhbJkg
	 STgqMzwu5Rm36IF39dK1zBzd3h6ZptsWHCRb46xH/5BAF9VJ94YFfoxLlTohmZDPdE
	 1sh1SDS/lmIlRgivyzrm/yRDAiUDJEliqYw28YFMqQVBVo7dFuYIxwBl0U9hUMz/6q
	 rvgWgHndImKd9X1XgTPuCySg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F2ED40E016C;
	Mon, 19 Feb 2024 16:16:25 +0000 (UTC)
Date: Mon, 19 Feb 2024 17:16:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, thomas.lendacky@amd.com, chao.gao@intel.com,
	bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>

On Wed, Jan 31, 2024 at 11:31:53AM +0000, Huang, Kai wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> Currently on AMD SME platforms, during kexec() caches are flushed
> manually before jumping to the new kernel due to memory encryption.
> Intel TDX needs to flush cachelines of TDX private memory before
> jumping to the second kernel too, otherwise they may silently corrupt
> the new kernel.
> 
> Instead of sprinkling both AMD and Intel's specific checks around,
> introduce a new CC_ATTR_HOST_MEM_INCOHERENT attribute to unify both
> Intel and AMD, and simplify the logic:
> 
> 	Could the old kernel leave incoherent caches around?

	"Is it possible that the kernel could leave caches in incoherent state?"

> 	If so, do WBINVD.
> 
> Convert the AMD SME to use this new CC attribute.

> A later patch will
> utilize this new attribute for Intel TDX too.

Yeah, once those are all in git, the concept of "subsequent patch"
becomes ambiguous depending on how you're sorting them. So try to read
that commit message out of the context of all those "subsequent patches"
and see if it still makes sense.

IOW, you should strive for your commit messages to make sense on their
own, without referencing other patches.

In this particular case, that "later patch" can go.

> Specifically, AMD SME flushes caches at two places: 1) stop_this_cpu();
> 2) relocate_kernel().  stop_this_cpu() checks the CPUID directly to do
> WBINVD for the reason that the current kernel's SME enabling status may
> not match the new kernel's choice.  However the relocate_kernel() only
> does the WBINVD when the current kernel has enabled SME for the reason
> that the new kernel is always placed in an "unencrypted" area.
> 
> To simplify the logic, for AMD SME change to always use the way that is
> done in stop_this_cpu().  This will cause an additional WBINVD in
> relocate_kernel() when the current kernel hasn't enabled SME (e.g.,
> disabled by kernel command line), but this is acceptable for the sake of
> having less complicated code (see [1] for the relevant discussion).
> 
> Note currently the kernel only advertises CC vendor for AMD SME when SME
> is actually enabled by the kernel.  To always advertise the new
> CC_ATTR_HOST_MEM_INCOHERENT regardless of the kernel's SME enabling
> status, change to set CC vendor as long as the hardware has enabled SME.
> 
> Note "advertising CC_ATTR_HOST_MEM_INCOHERENT when the hardware has
> enabled SME" is still different from "checking the CPUID" (the way that
> is done in stop_this_cpu()), but technically the former also serves the
> purpose and is actually more accurate.
> 
> Such change allows sme_me_mask to be 0 while CC vendor reports as AMD.
> But this doesn't impact other CC attributes on AMD platforms, nor does
> it impact the cc_mkdec()/cc_mkenc().
> 
> [1] https://lore.kernel.org/lkml/cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com/
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/coco/core.c               | 13 +++++++++++++
>  arch/x86/kernel/machine_kexec_64.c |  2 +-
>  arch/x86/kernel/process.c          | 14 +++-----------
>  arch/x86/mm/mem_encrypt_identity.c | 11 ++++++++++-
>  include/linux/cc_platform.h        | 15 +++++++++++++++
>  5 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..8d6d727e6e18 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -72,6 +72,19 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>  	case CC_ATTR_HOST_MEM_ENCRYPT:
>  		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
>  
> +	case CC_ATTR_HOST_MEM_INCOHERENT:
> +		/*
> +		 * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME has
> +		 * enabled on the platform regardless whether the kernel
> +		 * has actually enabled the SME.
> +

"represents whether SME has [been] enabled ... regardless whether the
kernel has enabled SME"?!?

I think this needs to be:

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d07be9d05cd0..e3653465e532 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -67,6 +67,13 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 
        switch (attr) {
        case CC_ATTR_MEM_ENCRYPT:
+
+               /*
+                * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME has
+                * enabled on the platform regardless whether the kernel
+                * has actually enabled the SME.
+                */
+       case CC_ATTR_HOST_MEM_INCOHERENT:
                return sme_me_mask;
 
        case CC_ATTR_HOST_MEM_ENCRYPT:


> +		return !(sev_status & MSR_AMD64_SEV_ENABLED);
> +
> +	/*
> +	 * For all CC_ATTR_GUEST_* there's no need to check sme_me_mask
> +	 * as it must be true when there's any SEV enable bit set in
> +	 * sev_status.
> +	 */

Superfluous comment.

>  	case CC_ATTR_GUEST_MEM_ENCRYPT:
>  		return sev_status & MSR_AMD64_SEV_ENABLED;
>  
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index bc0a5348b4a6..c9c6974e2e9c 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
>  				       (unsigned long)page_list,
>  				       image->start,
>  				       image->preserve_context,
> -				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
> +				       cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT));
>  
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (image->preserve_context)
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ab49ade31b0d..2c7e8d9889c0 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,18 +813,10 @@ void __noreturn stop_this_cpu(void *dummy)
>  	mcheck_cpu_clear(c);
>  
>  	/*
> -	 * Use wbinvd on processors that support SME. This provides support
> -	 * for performing a successful kexec when going from SME inactive
> -	 * to SME active (or vice-versa). The cache must be cleared so that
> -	 * if there are entries with the same physical address, both with and
> -	 * without the encryption bit, they don't race each other when flushed
> -	 * and potentially end up with the wrong entry being committed to
> -	 * memory.
> -	 *
> -	 * Test the CPUID bit directly because the machine might've cleared
> -	 * X86_FEATURE_SME due to cmdline options.
> +	 * Use wbinvd on processors that the first kernel *could*
> +	 * potentially leave incoherent cachelines.

No need for that comment anymore - people can grep for
CC_ATTR_HOST_MEM_INCOHERENT's definition simply.

>  	 */
> -	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT))
>  		native_wbinvd();
>  
>  	/*
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 7f72472a34d6..87e4fddab770 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -570,9 +570,19 @@ void __init sme_enable(struct boot_params *bp)
>  		msr = __rdmsr(MSR_AMD64_SYSCFG);
>  		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
>  			return;
> +
> +		/*
> +		 * Always set CC vendor when the platform has SME enabled
> +		 * regardless whether the kernel will actually activates the
> +		 * SME or not.  This reports the CC_ATTR_HOST_MEM_INCOHERENT
> +		 * being true as long as the platform has SME enabled so that
> +		 * stop_this_cpu() can do necessary WBINVD during kexec().
> +		 */
> +		cc_vendor = CC_VENDOR_AMD;
>  	} else {
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
> +		cc_vendor = CC_VENDOR_AMD;
>  		goto out;
>  	}
>  

So you can't put it before the if - just slap it in both branches. Geez!

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780cc..1e4566cc233f 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -549,6 +549,8 @@ void __init sme_enable(struct boot_params *bp)
        if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
                snp_abort();
 
+       cc_vendor = CC_VENDOR_AMD;
+
        /* Check if memory encryption is enabled */
        if (feature_mask == AMD_SME_BIT) {
                /*
@@ -597,6 +599,5 @@ void __init sme_enable(struct boot_params *bp)
 out:
        RIP_REL_REF(sme_me_mask) = me_mask;
        physical_mask &= ~me_mask;
-       cc_vendor = CC_VENDOR_AMD;
        cc_set_mask(me_mask);
 }

Btw, pls do your patches ontop of tip/master as other patches in there
are touching this file.

> @@ -608,7 +618,6 @@ void __init sme_enable(struct boot_params *bp)
>  out:
>  	if (sme_me_mask) {
>  		physical_mask &= ~sme_me_mask;
> -		cc_vendor = CC_VENDOR_AMD;
>  		cc_set_mask(sme_me_mask);
>  	}
>  }
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd1c12f..2f7273596102 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -42,6 +42,21 @@ enum cc_attr {
>  	 */
>  	CC_ATTR_HOST_MEM_ENCRYPT,
>  

This goes to the end of the enum.

> +	/**
> +	 * @CC_ATTR_HOST_MEM_INCOHERENT: Host memory encryption can be
> +	 * incoherent

"...can leave caches in an incoherent state."

> +	 *
> +	 * The platform/OS is running as a bare-metal system or a hypervisor.
> +	 * The memory encryption engine might have left non-cache-coherent
> +	 * data in the caches that needs to be flushed.
> +	 *
> +	 * Use this in places where the cache coherency of the memory matters
> +	 * but the encryption status does not.
> +	 *
> +	 * Includes all systems that set CC_ATTR_HOST_MEM_ENCRYPT.

If that is the case, why do you even need a new CC_ATTR define?

Might as well do:

	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
		native_wbinvd();

?

> +	 */
> +	CC_ATTR_HOST_MEM_INCOHERENT,
> +


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

