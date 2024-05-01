Return-Path: <linux-kernel+bounces-165796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC85E8B91C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D218AB21504
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8B168AE2;
	Wed,  1 May 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRUKb/kc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CD2EB11
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603817; cv=none; b=pmfUGVuRZSItox9+ztLJFsKXpxYP5gkHvCMgVNTF/zfHwOhM67boxIH5TvsbE0XkbP9ehId5gujIFwaIuCKHJ6mogJDnt15wanKbNoGLW+lPFBvFlmXQHoxyaiQrDrYZW0ntkmJNGiRGyQjrbZkMuBfmg5iBEMUQQL6fwt+1H/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603817; c=relaxed/simple;
	bh=YNNf0XLM+4ChwsAjeHwf7iXcDfwaWcrjgejEJs7VaII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UMoW+7qCMpvgexd8E52ysFqrjEqCHma30uCcCa3PwP9jbuFafiPmcspUpruIo/fDQ++uPkT3Ul3oOCFtAIpJ4ivf9FjqCpkngamAfUJ3tO1yMqAsjgWxtYgKe+aTFhkV2uohu86WrQGCqY0v9bxWAwQkaPFBfnlN8wnJ7Vq8m74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRUKb/kc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be452c62bso52768377b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714603813; x=1715208613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P/Mv3chyaRaiyKE52xANGAdVdVRLjPvU/jVzwzR+Xg=;
        b=kRUKb/kcIS6ExXDqVIfmC8J5dFc9ZnH2bTKtfdDklUQFp8+UZrkhyAQBUW6I8pIjDK
         iGnSUY91tdSuEwsfELYmKwtjEQ3mB1q35MRLjedsHzvB/s88mgBiHYS7ikBTr7/g6bXo
         BgBtyYwsDbuVSw7y4vNzB0GdyCJSDrLv4zJ41/bYhxAU/UUtASo+/RMLjDIAAzzQvgts
         q/eIE8tRHExiVHo59CPgzKoyxtLK8ZvmpfJhhL4Gmsyqy4kx44c99MlO69NHFvGOJhrn
         b6pCCcDcpVSr0cUvymVl6qBDtzOAFT5SVdPRiS5JuuLB/H0Gukvs6zj08gooMu9tc6u+
         JcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714603813; x=1715208613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P/Mv3chyaRaiyKE52xANGAdVdVRLjPvU/jVzwzR+Xg=;
        b=tKHXtDSqhAsPuS9aKWYcicYEfI10pt1fuyGwJ2AlpIuRssD0+yjW2o6PHLwJVJCcx0
         PwCgmg3oPCJYNGlZDfcRoSpc5ebqdQkBhZF1Eiu5QWzwLC3HrG724hS09Uh2RkX068Mk
         HyQiZlfhk6uq9vlj0U76ZLTR6DlO18tR2s7G2f+vjuWVbLz7PU6wa0aYL23NS6gPhccB
         copHDDZgmAFTlX/ZSrHUT9zZd96Q1GcFHmFwj+ng23mMsTuPfu5xf+p6Cr19Qb3hKuIR
         daO6XzbESsLDKGKzcNpCY9KsCiyNiBr0b+WCp1WI8w805E1W7XQxrfR1AyhHResTQQWr
         qhAA==
X-Forwarded-Encrypted: i=1; AJvYcCXYd3SiSKubXszoJDjvQGt9HTpFzRG+dwnW8q2QQdWUw4HoxT3KBiJmC+N5bQbagO5V4y/3GaSx79m7nqpLuy19Z74APIGlSRtTMCof
X-Gm-Message-State: AOJu0YzAg44S20mUZVEp+DGXQOfsKWaUUI5VHE/JgK2ikcaTG6GNAJJh
	52zhiEIbkRBZRr0hc2hkCQ0aMygNTo1+SkCNRRGSkeLXDuh579c4mkS9pOanHgOmqtNcBH/mV5N
	G5Q==
X-Google-Smtp-Source: AGHT+IGGSDrCekYrtHmH/SUMWADT9s1mekgVLLzvXNmpTp7v+CLKPhTEfnQLviQEEbNCoM8euzGOr0ZzVnQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1243:b0:dc6:b813:5813 with SMTP id
 t3-20020a056902124300b00dc6b8135813mr321284ybu.9.1714603813461; Wed, 01 May
 2024 15:50:13 -0700 (PDT)
Date: Wed, 1 May 2024 15:50:11 -0700
In-Reply-To: <20240219074733.122080-22-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-22-weijiang.yang@intel.com>
Message-ID: <ZjLHIwCsLoatrxQ4@google.com>
Subject: Re: [PATCH v10 21/27] KVM: x86: Save and reload SSP to/from SMRAM
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> Save CET SSP to SMRAM on SMI and reload it on RSM. KVM emulates HW arch
> behavior when guest enters/leaves SMM mode,i.e., save registers to SMRAM
> at the entry of SMM and reload them at the exit to SMM. Per SDM, SSP is
> one of such registers on 64-bit Arch, and add the support for SSP. Note,
> on 32-bit Arch, SSP is not defined in SMRAM, so fail 32-bit CET guest
> launch.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 11 +++++++++++
>  arch/x86/kvm/smm.c   |  8 ++++++++
>  arch/x86/kvm/smm.h   |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2bb1931103ad..c0e13040e35b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -149,6 +149,17 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
>  		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0)
>  			return -EINVAL;
>  	}
> +	/*
> +	 * Prevent 32-bit guest launch if shadow stack is exposed as SSP
> +	 * state is not defined for 32-bit SMRAM.

Why?  Lack of save/restore for SSP on 32-bit guests is a gap in Intel's
architecture, I don't see why KVM should diverge from hardware.  I.e. just do
nothing for SSP on SMI/RSM, because that's exactly what the architecture says
will happen.

> +	 */
> +	best = cpuid_entry2_find(entries, nent, 0x80000001,
> +				 KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> +	if (best && !(best->edx & F(LM))) {
> +		best = cpuid_entry2_find(entries, nent, 0x7, 0);
> +		if (best && (best->ecx & F(SHSTK)))
> +			return -EINVAL;
> +	}
>  
>  	/*
>  	 * Exposing dynamic xfeatures to the guest requires additional
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 45c855389ea7..7aac9c54c353 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -275,6 +275,10 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
>  	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
>  
>  	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_read(vcpu, MSR_KVM_SSP, &smram->ssp),
> +			   vcpu->kvm);
>  }
>  #endif
>  
> @@ -564,6 +568,10 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
>  	ctxt->interruptibility = (u8)smstate->int_shadow;
>  
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_write(vcpu, MSR_KVM_SSP, smstate->ssp),
> +			   vcpu->kvm);


This should synthesize triple-fault, not WARN and kill the VM, as the value to
be restored is guest controlled (the guest can scribble SMRAM from within the
SMI handler).

At that point, I would just synthesize triple-fault for the read path too.

