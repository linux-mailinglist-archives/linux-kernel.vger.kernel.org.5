Return-Path: <linux-kernel+bounces-64368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E3853D86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5CB28E18F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9BA627EA;
	Tue, 13 Feb 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="alttmcfd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61661665
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860637; cv=none; b=GqNBOuT/Wfb5JPkr6c6LigK6DNpnHuK8T0YzR1FOrrJxF5Utnh1knE6g0xxLi174eSNjfjSYUxmg0sjUQEl4xKVN+qO5mEP4iZ6KSjIQNUOaZRJsPg2mmOay1grt2QZDKc8VplWF6yKUPrkp8cxsMDkQB+AuCn/KPbrAMaPzo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860637; c=relaxed/simple;
	bh=RBg+DZGEzKhBzC+b6W4hC2L17srPsKeF1ONugi+riqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byn6PCoHD7mcULa3g7TAQiLXNf15xhP/9gIinD8etSFwf2zmDC7a+lIHTUr9znX2pe/Dhj+glccxZceGw7KFDsGoIn/ftAWl7xtauUzgX6/0WgDe4WkkwFpIKXHZTFLEebDiBxOT9npT/KJuqs4AQiFXG8/yaEHqC8c/oTGiWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=alttmcfd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F60340E00B2;
	Tue, 13 Feb 2024 21:43:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KURqn1H70NoE; Tue, 13 Feb 2024 21:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707860630; bh=ljvbJFQu5+LqT67HWv+N0HOEeBfcGHMuo51YPcwIvAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alttmcfd1LdLeENcj4b6U1WoAoMQMioObTJYUIQE4/SJmZ8qZHDJI8n4c4AMthKIs
	 PseH+noV74O/rvtaoigOg1VjOMdXnxa1RbaV/ME4aoafWpsiui+iVCHzXdsqq11hjs
	 4zvEXMLy0sZwkpgrutndBSmwOotjcylxgz3YJMBr+LqjIGDNedAO2LYnNejDwxQmNd
	 Tfr16Liv8/ZBThf+6KY8nOPjG4LHh27ZCX4If4nydON7vHq/ckL51HwRAEeGfO2GIB
	 tRmYEKLEb2/NdJRBYfaQ+3pssNfOBD4r6bHMxKP9wOeTuU8b8LyzEbeGWd9J5Fq7Ks
	 Ja8rmbjlzkn3GLdf50BGT1iF6w5RYtPEJt5TvYG4cTKLULwqOIcUg7muCUMsdreBrX
	 gDHmhLFoqfAR+UmXqM6UmIiyHiBuZdl5NSqCenZ6JqiLba337qHeWGUJpRhJrYiY5Q
	 aU7iDuWlKbFChkBRXByChaHm8EjX4KnqR9NJsFybkriU9bIRA63bURyGzEvKruK5lq
	 Zw7pMzTdin7LuAoVio/yyrzwFC9iBuO9rSnlCeUBEF02sBUrh7Zxw2pZubhqiyKjQC
	 1uTOFtJU4jrWjj9PlwIuoMABXRnJx+Mj/irPoO0qsFpdhIadX6efomXyyM4q911BS6
	 ZnB8vLAH83WIYEdoLOUALkrs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 235D040E0192;
	Tue, 13 Feb 2024 21:43:43 +0000 (UTC)
Date: Tue, 13 Feb 2024 22:43:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v2] x86/usercopy: fix kernel-doc function param name
Message-ID: <20240213214342.GFZcvijhGJ0b1y3wAg@fat_crate.local>
References: <20240211062501.16428-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240211062501.16428-1-rdunlap@infradead.org>

On Sat, Feb 10, 2024 at 10:25:01PM -0800, Randy Dunlap wrote:
> Correct the function parameter name in clean_cache_range() to prevent
> kernel-doc warnings:
> 
> usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
> usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v2: add Rev-by: Sohil Mehta
> 
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH v2] x86/usercopy: fix kernel-doc function param name
> 
> Correct the function parameter name in clean_cache_range() to prevent
> kernel-doc warnings:
> 
> usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
> usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v2: add Rev-by: Sohil Mehta
> 
>  arch/x86/lib/usercopy_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -18,7 +18,7 @@
>  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
>  /**
>   * clean_cache_range - write back a cache range with CLWB
> - * @vaddr:	virtual start address
> + * @addr:	virtual start address
>   * @size:	number of bytes to write back
>   *
>   * Write back a cache range using the CLWB (cache line write back)
>  arch/x86/lib/usercopy_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -18,7 +18,7 @@
>  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
>  /**
>   * clean_cache_range - write back a cache range with CLWB
> - * @vaddr:	virtual start address
> + * @addr:	virtual start address
>   * @size:	number of bytes to write back
>   *
>   * Write back a cache range using the CLWB (cache line write back)

What happened here? :)

Commit message and patch diff appear twice.

Once not enough huh?

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

