Return-Path: <linux-kernel+bounces-44387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48E84215C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30611F26460
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AFA65BB0;
	Tue, 30 Jan 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UT9V2KKN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905465BA9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610914; cv=none; b=BeoNRECQJC+ygsaoRksQAQD0cO9dvmOOL/yucJ86rDIsHSQqW2K9v90tJEytGmlTxAmOfNUBv8MxYj+lYzV/TG/4zPa2ZTY6ngXH0lVnAX3sGuPPFnQdRjTJjN1YXPGkKGsksDq32xYXguxKaf63qNfeO7ILV+gmYSKb12ODrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610914; c=relaxed/simple;
	bh=G7bEbM+6G6zhv5LuuaLS4NxChHuaEq6KtsqwNawbqiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqxYCDOUcvGh+frqTpDKb7Mg1BPE18POhHsAjQEOfK34u+6LT1yODbGpEyycaOLC79vA9JMLLs2fFz0NNeKhHYNyVSMnd0LQ83lwZNjjiAlZ25XMi23GUrpeEO/eEnnzKEyqCND/SvKCsqrCPl7QOyhHYerZEK3QAS4RaUOtNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UT9V2KKN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9ABD540E016C;
	Tue, 30 Jan 2024 10:35:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EgdsOWZ6UCia; Tue, 30 Jan 2024 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706610900; bh=VAuQUnzM/72jSaj2tSW3pX+i7RKL9aWDv2EoU9nXZ1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UT9V2KKNtzpdgMYu3Fe2bWRugEVYzWtF0qmRhkIgyjEMqdwz5ze1TZfLYmCz+V+rY
	 gWjXKZtxMybZBzjtTHZDX0pJV35LBf6kwObdkhXtbo6q+naKqoUmMRBF0ol1uFBY0M
	 cruDe5trkJvmXW5PnkPUpL/wdQaESYxQ13kJWRZiUzktyuHRAuSc8fHq68kIeY1EcC
	 /gH+mswM/yRDtKCsbUdBkeycIhpussz54mpm0V+6iO0zSX92oviKERchyPK33I/521
	 /NIEbtUU5MSim4o6jYfpO9UNFY82AYjATREaNlsnyvlTz7i6k6bQctGvFGDc6uyLDH
	 ndRxBWWXCag34TFEYak2XarxZH0ELTLidIac5oytJ+WpebJyvDeeKF+JCfCJCZUzZG
	 YK9pgeC3C7Dw0IiSnljfB44LG4JU8287uTBNySYkS8Hy9xM78OyeE6aMIOm5KOywtq
	 k93E6aaCwMLVTKLkWC/jB1T0Jepn33b17pDhOdJ1UdMGQU5fVCLCcVW8uxpaZhhCit
	 YD97LYAWERq24ZRF6zXhELRSbOJ3HZm6enFCqoTGSATUyePKNDJRIcXx1a5wNXBS7N
	 x2GSK1oXioAiZVzwGtfzGc2XbrfBDi652qOuDBL0uLE8FZxZN712oqDTuic28OKP7n
	 XsdM+KHHv2BXPDJ+rBg31JUo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A73840E00C5;
	Tue, 30 Jan 2024 10:34:50 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:34:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, ravi.v.shankar@intel.com,
	andrew.cooper3@citrix.com
Subject: Re: [PATCH v1A 1/2] x86/fred: Fix build with clang
Message-ID: <20240130103445.GCZbjQxax5LqINdtf6@fat_crate.local>
References: <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
 <20240129064521.5168-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129064521.5168-1-xin3.li@intel.com>

On Sun, Jan 28, 2024 at 10:45:21PM -0800, Xin Li wrote:
> Remove the .fill statement that referneces asm_fred_entrypoint_kernel()
> before it's defined, which breaks clang build.
> 
> Use the .org directive instead to fill "int3" into the memory between
> asm_fred_entrypoint_user() and asm_fred_entrypoint_kernel().
> 
> Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/lkml/20240126100050.GAZbOC0g3Rlr6otZcT@fat_crate.local/
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
> 
> Change since v1:
> * Use ".org ..., 0xcc" to fill "int3" into memory (H. Peter Anvin).
> ---
>  arch/x86/entry/entry_64_fred.S | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index eedf98de7538..a02bc6f3d2e6 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -43,14 +43,12 @@ SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
>  	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
>  SYM_CODE_END(asm_fred_entrypoint_user)
>  
> -.fill asm_fred_entrypoint_kernel - ., 1, 0xcc
> -
>  /*
>   * The new RIP value that FRED event delivery establishes is
>   * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
>   * ring 0, i.e., asm_fred_entrypoint_user + 256.
>   */
> -	.org asm_fred_entrypoint_user + 256
> +	.org asm_fred_entrypoint_user + 256, 0xcc
>  SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
>  	FRED_ENTER
>  	call	fred_entry_from_kernel
> -- 

Considering how we're still very early in the game, I'm going to fold
those into the respective patches and rebase so that we have as clean
a branch as possible.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

