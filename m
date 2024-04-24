Return-Path: <linux-kernel+bounces-157122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A98B0D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88B1C239E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2215E209;
	Wed, 24 Apr 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K+2PY5Ta"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6815ECF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970129; cv=none; b=PsDyWzF+hW8kgjHuQMjGA5tTBAzyBtigVOHTndz3P8kR0gj+5kLQgFlLLI3RuTUfLJQAvX0jfj0U2MHTzibWw65WQFbSNtAfbv81j5k5rustI5dtD2wXsw+394pxrtvku7i8+4+EbhuOPL3b75IAg2U7C9vS8nbKe5W29cNvtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970129; c=relaxed/simple;
	bh=QDKMvg5hEI/fwo+OsrNHAcKc7/OGvbxe8UpFit+SzT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkGUi3DIrLhBC53dryUvK1oDpT0z8zp4Bm4pNEcspOODsxGmAQuc6KOSI3LQd0MB4wePr3q0wKNKpSpXc33gn844+1ZuqezXq85XVn/TYm+WoptSmp9/hIa0j1riAM9QZQqByr8kXazZEi+Q1XusaEgKeP6dwkV1NIw9/jicyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K+2PY5Ta; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 772CD40E01C5;
	Wed, 24 Apr 2024 14:48:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XLd7nMXK0Fye; Wed, 24 Apr 2024 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713970119; bh=tjC6kbIr72reDuf9fcXqQKN7h4mHTtbXsy/eWk74eZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+2PY5Ta+lHyRxxNJSlJwQ5urkqTd4H+Hr14nUq7gG+spBXAIVklTASyiwNcNHHAk
	 hdvzGpzTi6fY607KTQkumCruYGuepitchzLYsJVP0iG2e5BIzSLjImAQsptoM9P7qD
	 ZZH1FwH3sNCWtRUHK9XngiJHLXJU8pzfzxn6CEmB2mAilIXVz/rmLtygdgpUhrLLn9
	 WAwH1nLzdr83Ekqoe8dh7Bdgj3OPLJG/auiRjmkHUi8krWxJQknvcJNgoxoJLGRl0w
	 KBGGmVg4Qo11IojdDN8IouZBxnwxJ0K8n3xJRDm1A6y91MFR4BAsEa0PR4ANHmccB4
	 qz6Q52ZCQanT3MrUhBby47H+bGLO2wXPgpgXzx944Zol/REKGHjSW9DChi4vmVelOk
	 zFY/x7Gdubv3jwge6uVxvIqJVP3b5GKE0wvhl+yYKanqVfAgER77XJ2fP2mmVH8dXC
	 DGjcKcinJFeMp8yJisGBWki9dt7nrVAuB46xtomsxGRdOOmMebZsjjPqc9e2EYj5Rf
	 +uc6GCylVDXWN4ndTKv/m0/aPBnibzcWRDFIMz3Zi70j4fGqv7Vo4FbAwZrUQ72DuL
	 D82uM0aOTgfsxyLZzN20teZOzI2tWnbtfuja3yp8Fm99pswovFg9T6NoQvm9+eHvbn
	 p9qAzvoW8BesW0V7EghQrTww=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD91D40E016B;
	Wed, 24 Apr 2024 14:48:12 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:48:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>

On Mon, Apr 15, 2024 at 11:22:58PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.

Please use this or similar scheme when formulating your commit messages.
This above is too laconic.

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec.

That sentence needs sanitization.

> kexec_enter_virtual_mode() during late init will remap the efi_memmap
> physical pages allocated in efi_arch_mem_reserve() via memblock & then

s/&/and/

This is not code. Please take a greater care when writing commit
messages - they're not write-only.

> subsequently cause random EFI memmap corruption once memblock is
> freed/teared-down.

"torn down"

> Suggested-by: Dave Young <dyoung@redhat.com>
> [Dave Young: checking the md attribute instead of checking the efi_setup]
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..982f5e50a4b3 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,12 +258,28 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> -	if (efi_mem_desc_lookup(addr, &md) ||
> -	    md.type != EFI_BOOT_SERVICES_DATA) {
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first

Make all your text impersonal - no "we", "I", etc.

> +	 * kernel via setup data, so we need to skip this.

What exactly do we need to skip?

If the EFI memory descriptor lookup fails?

> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
> +	 */

Why is that comment here and what is its relevance to the line it is
above of?

> +	if (efi_mem_desc_lookup(addr, &md)) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>  		return;
>  	}
>  
> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
> +		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);

What is this pr_err() useful for?

> +		return;
> +	}
> +
> +	/* Kexec copied the efi memmap from the first kernel, thus skip the case */

kexec? This is a generic function - what does it have to do with kexec?

The subject of this patch is:

Subject: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec

and yet, nothing skips this function - it adds a bunch of checks,
printks and early returns with the intent that those early returns
happen on kexec and thus the actual memremap doesn't happen there.

So it is some sort of: let's check things which will be true in
a kexec-ed kernel and thus avoid the function by returning early.

But I have no clue.

It sounds to me like you need to go back up, to the 10000ft view and
explain how exactly this efi_mem_reserve() causes trouble for the
kexec-ed kernel so that we can think of a proper solution, not some
random hackery.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

