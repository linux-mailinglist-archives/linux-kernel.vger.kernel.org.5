Return-Path: <linux-kernel+bounces-152054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F208AB80C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F4281BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9546633;
	Sat, 20 Apr 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNbQVRCp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0F17C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571775; cv=none; b=abjSqaXRQa8rtdrRlzJ2d2JlaR2Tgk235KtfCtAd9vdgGWhJ7oWEIFwu1ndbIZIJwoDIG+logD882z+GfPMX3MVsKUs4+dEtPbsh0x3cdR3pQ0uJufMSmhnq5rOFaDIpRBRidKfiVGFvyCfG6tUsnhKMfHgXSPd4o+89KwlTiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571775; c=relaxed/simple;
	bh=BuLz/JHVB0gV5Hb4RmtjerjifU3c/PDa9CxmoO1LMKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yvo5HWotmbIuhODmwu/3avsnGD7MeyEVk4NPawhpDxW7gr/OLsFL3QsOgKUa5DNmSe3jQixKFwCptjVca2eHcnfIrfPTQf/xv5TezK6Qoei2kcfNS9I0nuJ5TAICTDTnoQGAesnYfnxeidJkErMNr4Tu+TmG7vFjT+KZ84G5WIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNbQVRCp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso2807643b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713571773; x=1714176573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ld8fmbXDb/pR3C8NsGTfnRCkO74P0Zyhqm1cvneZo0=;
        b=kNbQVRCpMV5VeXgXGLSIKXBRTlwwCq9tTZR2p95Gitte9w3371hjkCD3d5aMjUFJOK
         mW6q8gRv+qcb0ZSC8aXlyvUGL8yCEhU7aK/hP1aSxQJt7NRHOy/oisbpNhCgt77FmaBM
         Q600Y9o16KxCx6pAw3+Nkuyu2Mo+W+G0MbCyqyfOyeHOjhSkInsm6XI8fBBfmeGnC/jN
         eTMDeWcs8nBGBAcuQlqzEsuYF9vMusL/ER6n1fP/0NPoFnGR/o5IPW10ftZ2e21eL5Im
         m33n7s/yjrEBq9qpxcl3epRJHwYoaFDuVWHF+hCnM8Q0sSEnUTa4gNPXP6HA5iVe//Or
         QjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713571773; x=1714176573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ld8fmbXDb/pR3C8NsGTfnRCkO74P0Zyhqm1cvneZo0=;
        b=s/C97N7MCKH3piX61ptAoYgZ2eqyS9pBvHPQfdMJZVdcsKVR4Nv99683Axk4Q058GJ
         dWEo28B+w75NzMrBPHfS4hqJkuGXmJNApMtmgl2Fddceh9k0Qy7lxo6eZoLR4ghmxtmN
         C2EhsyHyzvD74GXXlXQd6d/KjWLJDE71+D770hM7Gcr/UMrVxd5waXVlXXa/heEIuHNt
         aj1/lbhNlYTUQKpGuM1wE64wxoHWct+TZE+9vLA9kApmLXK6Lb54AXbejw7hfHJBFt8R
         aTbN7DvMruvAhJEPXtg1sUTN+jX72wfsNUWuLAAo9ZI0kTdIy5zTBVp2qebft5eZuMcg
         yhTA==
X-Forwarded-Encrypted: i=1; AJvYcCXXYLHBEgZIz7rKCQ67B523gaLKxdqRtyiLjFq5u5w2q6OJU4aCOdsY7biEwWV4IW4xa83vI+gB/AMMkFcpBofSIHiErNMOEJ1QJkmM
X-Gm-Message-State: AOJu0YzCMSJUmtdy1dQcxWul2/mmKjxfxbej3L6RswVa3whJOErx1de8
	PIIt8a8gBD6UD9Y3mK/Wibo9nIemxUFkbIN6JL5uwlZ7geWTEBeGS3/nuvjspNvy9AANYw1+peW
	/jg==
X-Google-Smtp-Source: AGHT+IHwTv8i/Xa4qICUCSVJiPF3hjI6PjkCvwWYTaFUYjW4Iot7a/W9yROQinwM/wEEchhDdkuwgiv6J9Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:124a:b0:6eb:1d5:a3a with SMTP id
 u10-20020a056a00124a00b006eb01d50a3amr206560pfi.1.1713571772778; Fri, 19 Apr
 2024 17:09:32 -0700 (PDT)
Date: Fri, 19 Apr 2024 17:09:31 -0700
In-Reply-To: <9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1713559768.git.jpoimboe@kernel.org> <9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org>
Message-ID: <ZiMHu--agdvt4Rl1@google.com>
Subject: Re: [PATCH v4 2/5] cpu/speculation: Fix CPU mitigation defaults for !x86
From: Sean Christopherson <seanjc@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Josh Poimboeuf wrote:
> CPU speculative execution mitigations were inadvertently disabled on
> non-x86 arches by the following commit:
> 
>  f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> 
> Fix it by replacing CONFIG_SPECULATION_MITIGATIONS with a new generic
> CONFIG_CPU_MITIGATIONS option and moving the x86-specific mitigations to
> a separate menu which depends on CONFIG_CPU_MITIGATIONS.

Ah drat, I didn't check my mailbox until after Cc'ing Linus my own version[*].

I don't have a strong preference between the two, though I do think it's worth
nothing that this will (obvioulsy) allow disabling mitigations at compile time
on all architectures, which may or may not be desirable.

[*] https://lore.kernel.org/all/20240420000556.2645001-2-seanjc@google.com

> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig     | 10 ++++++++++
>  arch/x86/Kconfig | 15 +++------------
>  kernel/cpu.c     |  4 ++--
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9f066785bb71..5c96849eb957 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -11,6 +11,16 @@ source "arch/$(SRCARCH)/Kconfig"
>  
>  menu "General architecture-dependent options"
>  
> +config CPU_MITIGATIONS
> +	bool "Mitigations for CPU speculative execution vulnerabilities"
> +	default y
> +	help
> +	  Say Y here to enable mitigations for CPU speculative execution
> +	  vulnerabilities.
> +
> +	  If you say N, all mitigations will be disabled. You really
> +	  should know what you are doing to say so.

