Return-Path: <linux-kernel+bounces-157588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B5F8B133F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593A01C2280D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861D20DF7;
	Wed, 24 Apr 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JUCvmZrw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0C1CD24;
	Wed, 24 Apr 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985639; cv=none; b=N/B58iJf1a3rIu76t4s+GW9tPziPO0ulQbu1VpkUUze/Ir7Nq44mnHV9eiHICnvR2HgK431fQfCZyNLEuQBonZrqIb9iWzR+laLXOTDmGSLwS6XyWPe1RzIWUEQpRAxjb9Js8KoUPJkNkdISZGDacUj0Q5XMcL+WL9D5W+Xqn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985639; c=relaxed/simple;
	bh=URHwfcZ2dvJLtTkhWQROx4aAwctdwvwLAfIwr0/k4Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS/u9WUnZjRgPaBq/LMnRUoSy0nQkSOhQRXJkLA5ux3zkyGFe7nvtJTNc2gEP5tWLVw2KStqvDEeJYG7qFJFUInrest4ID3GGzBElAJBHalK/ybXey5ZtSLhYs+mpzVyzqiwL61kDLAN4kRFRsIpF/nPZ7j6Gnmclpdm2yvmTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JUCvmZrw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADC3440E0192;
	Wed, 24 Apr 2024 19:07:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RsixhrfbRsJC; Wed, 24 Apr 2024 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713985632; bh=QjOQvZjxGr+HZwRAXiop9IEkjMTXSpDO12auOhbpb2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUCvmZrwBh9PA8yQmaliGzMFwck50yT5yE3WmZbz427mrhUyN1oW2P+b8nMXnfYet
	 +dVIeg+VAiZ7aYITPnp3krR4Z7MMurddjoqhF7RS1oNChbXT/ZBb3CQ+5Z6QXEPjZ/
	 1Kh1sl++lIqHkrUUJfcoSgZ6PDTMQbR8mE0aXfzyG0SbFGHh4GgN1kc6ozR/Zh4PP8
	 J6WQaxqUC4p4PFHZKJINYVpTxhyA0ny8NV2vlqyn6oAhKaUeRvSxDg5BxRJKaglPzL
	 LSz4+rR6uggHp2GOKuMfWRAZZ3FGLSj6Uk9+IwQG//gTDvpuWdMnE9m7pYqW8sJCgn
	 2+/XBbNlmzn1hN7Iz4Sm9V2HDhgxo/e4qZRBSvvtiJYsWsTbNoLFVqIQTYvqHpgdfa
	 NheF8icbFaZ4YWMbXQ//G1jXEvHLqq7M5lY9azRUJH8pdCYpsEfibYCIXWaxQy9vXf
	 wtPo4x6u0Zt4Wg6gVFSho47ot3TLsqEU1XKRKK3aHLmQXirNBmbSw7xwCmN+Ce9pl1
	 wTVq0/QZvBC+GUxsO9CplB6MUVXTdQiGrhoyq/X16so2wYnlz1j0ou7q15M5MG2+q4
	 Gbm++b1L/jsE3WpK3T5hZZuDZ5wX+blIi7meX4DrcDEeE9Yte9jgYCEhWBanrO0bjS
	 yHYWHNNVJozXIiAK9RU3d+cU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D571C40E01C5;
	Wed, 24 Apr 2024 19:07:04 +0000 (UTC)
Date: Wed, 24 Apr 2024 21:06:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-8-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:50AM -0500, Yazen Ghannam wrote:
> AMD systems with the SUCCOR feature can send an APIC LVT interrupt for
> deferred errors. The LVT offset is 0x2 by convention, i.e. this is the
> default as listed in hardware documentation.
> 
> However, the MCA registers may list a different LVT offset for this
> interrupt. The kernel should honor the value from the hardware.

There's this "may" thing again.

Is this enablement for some future hw too or do you really trust the
value in MSR_CU_DEF_ERR is programmed correctly in all cases?

> Simplify the enable flow by using the hardware-provided value. Any
> conflicts will be caught by setup_APIC_eilvt(). Conflicts on production
> systems can be handled as quirks, if needed.

Well, which systems support succor?

I'd like to test this on them before we face all the quirkery. :)

That area has been plagued by hw snafus if you look at
setup_APIC_eilvt() and talk to uncle Robert. :-P

> @@ -595,17 +584,15 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>  	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
>  		return;
>  
> +	/*
> +	 * Trust the value from hardware.
> +	 * If there's a conflict, then setup_APIC_eilvt() will throw an error.
> +	 */
>  	def_new = (low & MASK_DEF_LVTOFF) >> 4;
> -	if (!(low & MASK_DEF_LVTOFF)) {
> -		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
> -		def_new = DEF_LVT_OFF;
> -		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
> -	}
> +	if (setup_APIC_eilvt(def_new, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
> +		return;
>  
> -	def_offset = setup_APIC_deferred_error(def_offset, def_new);
> -	if ((def_offset == def_new) &&
> -	    (deferred_error_int_vector != amd_deferred_error_interrupt))
> -		deferred_error_int_vector = amd_deferred_error_interrupt;

There was a reason for that - deferred_error_int_vector is a global var
and you're calling enable_deferred_error_interrupt() on each CPU.

> +	deferred_error_int_vector = amd_deferred_error_interrupt;
>  
>  	if (!mce_flags.smca)
>  		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

