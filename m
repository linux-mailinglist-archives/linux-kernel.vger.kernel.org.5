Return-Path: <linux-kernel+bounces-85123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0786B0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD99B1C22423
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C014D44A;
	Wed, 28 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OymBZv5q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65773508
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127926; cv=none; b=gAKsAo/I2ROYtl4ThpDTCWyqTAdFkxFzyXpOAwva/AO8j5M3HDhMKVm7ot/J6EvU8PCzJ71jMpNOSJHrT7V0PRVae4ZxxtFkL6J3A8kZbqFHEAia2EETiolTr2hN9UXyJ3QEv5fPllKtPjwLMCDHHOBKkD4daq93g6OQtYEE7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127926; c=relaxed/simple;
	bh=7VmebPJtBPFwDRFWwrsAwULy02yCG8ypW1U2mmCpG8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS43vnkqNo9OXQBXYfbS8r2Je/4kObqXpmh2jUHEErM8v3WMBl01yAOieiF5uKbX+bk3WGzfDog6641Kp4OiFxOAgM7fExYFrZNm11ebnPTb4U8Wrdz/W84B0YZn94AZ+UGeemXRM3Tjws00BArjvTOw794qhaBecS8UKUCmiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OymBZv5q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0FBE40E019B;
	Wed, 28 Feb 2024 13:45:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 26pDk6jWIfLp; Wed, 28 Feb 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709127917; bh=ataY2XHE0jBLrOe8cHYNXNn3jD+yyqpZSTu2eZh9ilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OymBZv5qF/RcUHF4rzLH+vGKjfnXdUX92Aor5E+d3TsnSjBlkmHUGT4q56RG1Ae3d
	 SC5mMJyOB76DTOGAwtGg94DD8K27MMI5V8tmGfQeTJDnFnPeUcMABGodtvX8AfIDiN
	 TG7QIXnPKriJLIXzZaAAZAsJLDhvHwqaLThomGcYrVwF71kyl6qZkm4bc6EYvSpn6z
	 /lblaRu/P8pU0bjue4RGNZ5NPGXsXXdXg/j61C9/GpEw82x9kvmKGIZy+W8a9hu8/M
	 OsgxHHe/T0fLWdmB88ftqMcwWvYay2D/vmSaVoGi9WqVVhg8lFmuCCT1mxekW+9brR
	 P5G4aF6Fa7fjLjfI4VSiCYXyfK83M8ka+nr02sBvG+MHCMglrIlmgzpghAy9mNgpkr
	 HAzYsu5w68Xz2Nfz0EkGZwB+Jr5M/KOvsrIGI0tMMHjxHqGk2MFvFlwqSZQHxwvPc7
	 EfXKLlbSW3zwX9shGz6auM9LXfpSMz50dt5ebpPi8nqeD2ShYiCTVF/lcE/BPgM78F
	 JFxNGkkROHinfl+GLJAmpC89L+q325w300ctaVZ39yVclwsPzgJS+6TqwHqU4HMdHP
	 GNE4OBN8T4sCwaM9hD6hPaJtbvtTjGXJlGvXhEqRZmgphPjxbH9yu9ghaHBKy2paAE
	 r72gjzLAwvb6mjcs3RIQCAXM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83C9840E0196;
	Wed, 28 Feb 2024 13:45:06 +0000 (UTC)
Date: Wed, 28 Feb 2024 14:45:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 1/9] x86/startup_64: Simplify CR4 handling in startup
 code
Message-ID: <20240228134500.GHZd843I43EccJD1Ak@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-12-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:09PM +0100, Ard Biesheuvel wrote:
> +	/*
> +	 * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
> +	 * global 1:1 translations from the TLBs.

Brian raised this question when exactly global entries get flushed and
I was looking for the exact definition in the SDM, here's what I'll do
ontop:

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2d8762887c6a..24df91535062 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -186,8 +186,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 1:
 
 	/*
-	 * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
+	 * Create a mask of CR4 bits to preserve. Omit PGE in order to flush
 	 * global 1:1 translations from the TLBs.
+	 *
+	 * From the SDM:
+	 * "If CR4.PGE is changing from 0 to 1, there were no global TLB
+	 *  entries before the execution; if CR4.PGE is changing from 1 to 0,
+	 *  there will be no global TLB entries after the execution."
 	 */
 	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
---

And how it is perfectly clear.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

