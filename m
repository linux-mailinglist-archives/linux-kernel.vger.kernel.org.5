Return-Path: <linux-kernel+bounces-133438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8389A3B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB011F25C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0153171E56;
	Fri,  5 Apr 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Axped4Ai"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C516C858
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339431; cv=none; b=H72IFtvE6bKswa7jCG6JqH77vY+lu/gD9322iNAB7RqTcoqk01lUmrEvQ0XdmPQW6u0orEqgU3fJRnH9pDDoXWriFYo7rkU51pFO0xuD/8AoK8HnhCP7+BHP96iKmW+Q2cncCGuaHbXa10u1afkApQk1voBD3nEXB9ZXOSoCZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339431; c=relaxed/simple;
	bh=7RIALOu/9x3WkNZWuR9Q1oMuZZ5fYMMxEPUf9ifsfx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQxI0v4PeWsmL9h5ocUw7r+gQic293k1yh74B03NihoqWI/21lWRlkNZD8LlGJTiH8bxcAh53RAkwlVOWKYd+YSkJ2bMxMmdAB/aJz2DxYgaAIyKyuFRTq+mYHKASWGbp5b2pwckggYUtcG28LFV4VEb1Ic4m7VzPEoTN6gZlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Axped4Ai; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4263240E0202;
	Fri,  5 Apr 2024 17:50:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id meQO34YTxU0p; Fri,  5 Apr 2024 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712339421; bh=b9seBZkpFcoCbEKoVKjpSGEbjYI77Tgb7NCZi1WVnB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Axped4Ai+cR6DjAs4HmoxBVlcfGH/8mOBJP5kaAQaTWTMwO4XUoMrtTJkhUzEDY+N
	 52eRhL0RSzybX39CzhI3N3uKRgQx389896DUQ4dF5lFyFKO05hvckpE2lkdRtDBG4l
	 qkBXJE5OACjUa5ecGA5GDBV/vur11IZT/coC1JjmE85ExpNg7MY/ZQ80qJI4ywk91g
	 LtEVe1M+ly+v1Lbt4v4TSL8OYfkRNrvoPtsnBfOkVgE6COVdKZeeFlXasdBG13ilVI
	 7a4sD/gCIaOj/vNXb4x5bkb1//71SUg8BrUHihYNHhyeuQZW5KVvYZHyBV8ixlwCVk
	 7MXRg4yRVeq3yQKoiWuYXlbnKMJpvR0ZDTBk+7G5ioAfxDhYZEhn/BrerzyJjzoOra
	 19zOhMuXBLuEOBdkvh9EK9gT5OweK82JnxcTPg07mu13CKoYkx0GM/6q899vfYs6wk
	 u7p8u7hGw/Ffjt1DuQS1r0Q2/wLjto6Fk78SAzJZnx9VnrpxHfqIrH66eHYcB7d5oj
	 +1BM/MAxJYQxWbQT3kUMm8ODg9TNJuCR6Xyz/3aVWNSzfBWIuTAdsR6mY2+7rfNk++
	 zWKYZwS50Avy2gRFSNEZ56dWyP23Th/VxOynzCdCqLzbKf6sObnZ7t0x7Ve9SpXx49
	 nCY+2wQ6F0OJBt7MhBKvjb7A=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 266DF40E0192;
	Fri,  5 Apr 2024 17:50:18 +0000 (UTC)
Date: Fri, 5 Apr 2024 19:50:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: bp@kernel.org
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/retpoline: Add NOENDBR annotation to the SRSO dummy
 return thunk
Message-ID: <20240405175017.GFZhA52eQFEWrHPxV3@fat_crate.local>
References: <20240405144637.17908-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405144637.17908-1-bp@kernel.org>

On Fri, Apr 05, 2024 at 04:46:37PM +0200, bp@kernel.org wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> It is special code even if it is a dummy which is called in the !SRSO
> case so annotate it like its real counterpart to address:
> 
>   vmlinux.o: warning: objtool: .export_symbol+0x2b290: data relocation to !ENDBR: srso_alias_untrain_ret+0x0
> 

Fixes: 4535e1a4174c ("x86/bugs: Fix the SRSO mitigation on Zen3/4")

> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/lib/retpoline.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 0795b3464058..e674ccf720b9 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -229,6 +229,7 @@ SYM_CODE_END(srso_return_thunk)
>  /* Dummy for the alternative in CALL_UNTRAIN_RET. */
>  SYM_CODE_START(srso_alias_untrain_ret)
>  	ANNOTATE_UNRET_SAFE
> +	ANNOTATE_NOENDBR
>  	ret
>  	int3
>  SYM_FUNC_END(srso_alias_untrain_ret)
> -- 
> 2.43.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

