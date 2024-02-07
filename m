Return-Path: <linux-kernel+bounces-56485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E584CABB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8641F281BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47D171A4;
	Wed,  7 Feb 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dc/tUaMI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EF31755;
	Wed,  7 Feb 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309018; cv=none; b=FguwPBmtXhFspsgHmDrzuQqihWP19KHrzMLQDyeTePkdLEXKsFo0jzfGSfEIMX2egmt3lS6nqyf3pZmecC/9V+FDr7GXwO0JbouLFpd0PaKmaIywa311q3+u4rDYqffFoQq3Ta5TKVoCpqL/oJ93Lq2MGx6eJSFexj7EKL2Gy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309018; c=relaxed/simple;
	bh=l/I1R6TO971Rm9gzs/Zx8mjrl1tpZ9fmPkTQ0MQ2jl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOEylE+pf85SCkzElXuAhYKowZoDTut2+Lqbgs34DivHhDoEnMk4vmcCSq7+i5vbGDWPiDxpIXX04BQ/y2bWgBWLSOFD9qsXpqu27XTL9smJp24AjWF9e0J/r0QDm1eEdkvDdRtEwXfRoniEXykoW1DgUNQSNz/B47TtCsbl0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Dc/tUaMI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F5FF40E01F7;
	Wed,  7 Feb 2024 12:30:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gZmVZCS8ja_O; Wed,  7 Feb 2024 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707309004; bh=neMQamQmFqij5v0x/QfM0vgH5KoHFOe0tPCa7WZMvKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc/tUaMIs8BJJUfjfyuOd0jAsrzUmCNX7vTfH8INBqThEFBdRfp5f5FcU0nCscJxH
	 ciR/3tvkZUGI5BWmwxEc/K+uShPxQ1U8pwyVn5LSGjEivfTjNvv6c7QOMozVhPziGc
	 zR5+UOUkPQemarw5nTASgLR2JuIBf7on3fcZUyFVrBJNffgNHceVAN6pcfnofgcZ1d
	 3ch7oPx5Qh9qEIHLbTJcKVJoO4ZXXqIKOgjhk0nsiryImy9mUnDJNgFCwmnL47XiBJ
	 kTnlUYyS6++th3sY3V6XMzp2hy7qaloJw1l5ttaD1PdhaFrRfA80a6l0bJwsQXwrKi
	 7d5VTwmh5bn4GNqA+YZ/mmKPFvVaLxjtzy7rEBcQreSXBRYgbitCE2cGvUnsxz6N/e
	 1RPD48m+EJWxpGdzphhMrMDme0Zq4drsSweBQpe9+n5LsBISgcN6SYw6/T8gWiWnr9
	 TM+x5zL43AjvXCDV5T8Ygl2lBvImHEyquGayu91mRWEHu1ZCxdY6k2z+Vnark5yAI5
	 u/B/iWVCE9BxvNREe+g+TejekTIGYHSMFbGfe8hEqsB7S9cbAO5nSVEnom+MZIpHlF
	 NQ+U9RzjChZNdOiT/2BoQ5ZxCoUxNPaNLCF+nfPOe1xE+TQnlzU5ezMtF9Ujz/+mGC
	 RaSl75FL3SvjkWhxJlkYDvbU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB74B40E016D;
	Wed,  7 Feb 2024 12:29:47 +0000 (UTC)
Date: Wed, 7 Feb 2024 13:29:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for
 DEFAULT_MCE_SAFE exception
Message-ID: <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
 <20240204082627.3892816-3-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204082627.3892816-3-tongtiangen@huawei.com>

On Sun, Feb 04, 2024 at 04:26:26PM +0800, Tong Tiangen wrote:
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index bca780fa5e57..b2cce1b6c96d 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	case EX_TYPE_UACCESS:
>  		if (!copy_user)
>  			return IN_KERNEL;
> +		fallthrough;
> +	case EX_TYPE_DEFAULT_MCE_SAFE:
>  		m->kflags |= MCE_IN_KERNEL_COPYIN;
>  		fallthrough;

I knew something was still bugging me here and this is still wrong.

Let's imagine this flow:

copy_mc_to_user() - note *src is kernel memory
|-> copy_mc_enhanced_fast_string or copy_mc_fragile - it's the same thing
  |-> -#MC, exception type EX_TYPE_DEFAULT_MCE_SAFE
    |-> error_context():
       case EX_TYPE_DEFAULT_MCE_SAFE:
                m->kflags |= MCE_IN_KERNEL_COPYIN;

MCE_IN_KERNEL_COPYIN does kill_me_never():

	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);

but that's reading from kernel memory!

IOW, I *think* that switch statement should be this:

	switch (fixup_type) {
	case EX_TYPE_UACCESS:
	case EX_TYPE_DEFAULT_MCE_SAFE:
		if (!copy_user)
			return IN_KERNEL;

		m->kflags |= MCE_IN_KERNEL_COPYIN;
		fallthrough;

	case EX_TYPE_FAULT_MCE_SAFE:
		m->kflags |= MCE_IN_KERNEL_RECOV;
		return IN_KERNEL_RECOV;

	default:
		return IN_KERNEL;
	}

Provided I'm not missing a case and provided is_copy_from_user() really
detects all cases properly.

And then patch 3 is wrong because we only can handle "copy in" - not
just any copy.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

