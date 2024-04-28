Return-Path: <linux-kernel+bounces-161515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B079F8B4D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E47FB20F23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2A73177;
	Sun, 28 Apr 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OEd67HJ5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46C7317F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324316; cv=none; b=RvIssW6kd/c5DTmYqqlGONAfCXIVFOWRyPPZuXZ80UezF564klYh4jaGXS07i5Df89xTSP080urx1oVPQrLJU4k36RFDfJ+rSSrkQJ9/Bz76aDtd/SX3+lFBIRjuu1fFNikIJ4xfV858aO/hSI2cvQFgqOfRol3euYnxJnh2n4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324316; c=relaxed/simple;
	bh=soAszFChPlMcM9VoBX48/9L1ray/WQw+xMt6+fPLTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJv1LA609C9c+ZRyObbDeMIM2fMwKEjWAe2CYk04ODfhjN9dhRqOaAQwyZHme3iQUbf+a8+fBbUAJWE+AcTC2zyqwEE8NlcFgW1DrbPBr/nc1VhvJ392ly+uz1SUGhtxxbSy1pxxYvKNm6/nCdnkR3rl5WtMNgFxROPEZG4gbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OEd67HJ5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C013740E0249;
	Sun, 28 Apr 2024 17:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yIWMf0eQpAjz; Sun, 28 Apr 2024 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714324298; bh=n8m7VXqiGZAmEpF7qkKdr35cuC1UAhOwozx/1g8c2jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEd67HJ5UVpQXs5da0WESrtXPALlwXqhQUZVrGi/DN2KQPq2S4s0rzWAcMxM6tvwh
	 aDIrwaJgOlRGte14D1XMVisCGkRcKu+qX6y8tLPvbrDrArXnX1vuZj0eZBeS3M5ie7
	 72J7Ap+1GwM+7cXqDSl5/6qYqGsopbzneEJxb0YjmjwdySkz4NsXLzSV3NkjCQYR2q
	 1+rUxb7c2dJrc9EP55qviYpGBeHQ0QEL5fu4Pb0uZi4paMuPjEgWsvSS/RL8gXvFH8
	 qseBvfEGKaXeJZ2DCDWQ8+rM3tWOG9vYnb/Af70Wx/BtN1VUxB/jd0tucRfH+ka62A
	 PifqcmfludHTau0He03VHNKdVNxeNnvv2zH6GdL42FhZmW34stYowBvA4w3vn4Xfhh
	 xxWgAAv0L6rvZhWK7J0Y7B+g7QYCQbwkrQ9MwaO+9NU0TfaAADAkuyD8A6E3FHmRy6
	 PmkS3+EQskYjoyB1GXcQ3KwYQMaxEWeSnkYsZvmGWHznhg/rSaU3hqAATxt6R0+v0r
	 s650kgJTqWduNcZP3XbzBnAfqqeMbq7J/hrjagXD8BmYLUG9r3KhLCu+5Yz/BXRv+T
	 VHwTyr0McN1lwd/vO8BaHa0+J2AdJf9FknPSidkXCUJp2Dn8FY9gb8iyDRxNhK4xft
	 mzfV13P/ErHlTuZN6kcbGw8A=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A991240E016B;
	Sun, 28 Apr 2024 17:11:17 +0000 (UTC)
Date: Sun, 28 Apr 2024 19:11:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>

On Tue, Apr 09, 2024 at 06:26:05PM +0300, Kirill A. Shutemov wrote:
> From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Fri, 10 Feb 2023 12:53:11 +0300
> Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> 
> Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> Attempt to clear it leads to #VE.
> 
> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.

This is all fine and dandy but nothing explains *why* TDX needs this
special dance.

Why can't TDX do the usual CR4.MCE diddling like the normal kernel
during init and needs to do that here immediately?

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..90246d544eb1 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
>  #include <asm/processor-flags.h>
> @@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  
>  	/*
>  	 * Set cr4 to a known state:
> -	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.

			 ... might not be allowed ...

> +	 *  - physical address extension enabled
>  	 */
> -	movl	$X86_CR4_PAE, %eax
> -	testq	$X86_CR4_LA57, %r13
> -	jz	1f
> -	orl	$X86_CR4_LA57, %eax
> -1:
> +	movl	$X86_CR4_LA57, %eax
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> +	andl	%r13d, %eax

%r13 needs a comment here that it contains %cr4 read above in
relocate_kernel()

> +	orl	$X86_CR4_PAE, %eax
>  	movq	%rax, %cr4
>  
>  	jmp 1f
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

