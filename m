Return-Path: <linux-kernel+bounces-14944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAB8224CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622DB1C22D99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1081772D;
	Tue,  2 Jan 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2EGr0LV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A017725
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dz39R9pAkRItXAhKUr29BdCW8gCwDIwIhiTXdpehTI=;
	b=d2EGr0LV/me5t3Qiy8yRl/lSTFQHzQGwiYKefPQ1ZLOgrcqMd5UuMH9OCeUXHXl7MZQlH6
	bc2QznhOE1Va5TOQIYAGb3EYH7iXpVEI/iDQX8KpDrcOCAJq07SpnP4EAnsEx2m7ESQyzm
	E3iJhuo2Z1k8ezR+F0kCOBXs+B98cOI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-VUt3m1anNN663e3AMtmMdA-1; Tue, 02 Jan 2024 17:34:21 -0500
X-MC-Unique: VUt3m1anNN663e3AMtmMdA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-336953e0fe7so5761357f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234860; x=1704839660;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Dz39R9pAkRItXAhKUr29BdCW8gCwDIwIhiTXdpehTI=;
        b=Yt2uWoppEhw5KRebvcTrCYitlUQrKR/8M59lzIdcZKGHGI3lNBf6GfBemYyAnCIVdY
         mTWpxbRXfUzxDOUsNFSLQ6d38b5MHux/Rp970PC8xAEmAmttlaH1LPZ/sZd5y0brWiCR
         PuG5t6qlkTJmr/l9sLlAdOGT6SHR5cLUZx4BN5s+hmAwTnKDMQMEH/dVzcgYeqGPJBbE
         /8ApSclJHkYOYFwwisFtElKLEZtX0igI8N7NLgDnnFk1uQr2E9A6ziTJtcgYVhqWJQY3
         skQIhif6HUKDSQIPkZlhWjj0Dso8x8C9TGcZ0M9WnfSjEAN/Zemhx/M4ceeB7oXPs9Zh
         7tSg==
X-Gm-Message-State: AOJu0YwthUaW8NEKPvK46P1Km+dGZFSbO482pc/lWGJ2lCs22hfymiv8
	WXnvw2KzLOkRn8yzdXCDM3GsWfgP95dmtfuQsRYtM7FINaqkZeQ7mlnYK1FAFGoLy2nf0cFiP3B
	fEUPlsHxxni5z9zZ7NjwiSQCAE0tffdzy
X-Received: by 2002:a5d:598a:0:b0:337:161:6d81 with SMTP id n10-20020a5d598a000000b0033701616d81mr5680527wri.52.1704234860502;
        Tue, 02 Jan 2024 14:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwNcYpeTiMWaP9qxjWQSEmPItktNdEZFwRfWo0MNeTrtE4XPftazTB0jgG/v2KAfOFCyCKAg==
X-Received: by 2002:a5d:598a:0:b0:337:161:6d81 with SMTP id n10-20020a5d598a000000b0033701616d81mr5680521wri.52.1704234860177;
        Tue, 02 Jan 2024 14:34:20 -0800 (PST)
Received: from starship ([147.235.223.38])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe0c2000000b00337464bf723sm3155670wri.18.2024.01.02.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:34:19 -0800 (PST)
Message-ID: <eec6a93bbe35e55e1309db80159265d0177b5268.camel@redhat.com>
Subject: Re: [PATCH v8 21/26] KVM: x86: Save and reload SSP to/from SMRAM
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	john.allen@amd.com
Date: Wed, 03 Jan 2024 00:34:18 +0200
In-Reply-To: <20231221140239.4349-22-weijiang.yang@intel.com>
References: <20231221140239.4349-1-weijiang.yang@intel.com>
	 <20231221140239.4349-22-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2023-12-21 at 09:02 -0500, Yang Weijiang wrote:
> Save CET SSP to SMRAM on SMI and reload it on RSM. KVM emulates HW arch
> behavior when guest enters/leaves SMM mode,i.e., save registers to SMRAM
> at the entry of SMM and reload them at the exit to SMM. Per SDM, SSP is
> one of such registers on 64-bit Arch, and add the support for SSP. Note,
> on 32-bit Arch, SSP is not defined in SMRAM, so fail 32-bit CET guest
> launch.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 11 +++++++++++
>  arch/x86/kvm/smm.c   |  8 ++++++++
>  arch/x86/kvm/smm.h   |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3ab133530573..cfc0ac8ddb4a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -149,6 +149,17 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
>  		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0)
>  			return -EINVAL;
>  	}
> +	/*
> +	 * Prevent 32-bit guest from being launched if CET is exposed as SSP
> +	 * state is not defined for 32-bit SMRAM.
> +	 */
> +	best = cpuid_entry2_find(entries, nent, 0x80000001,
> +				 KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> +	if (best && !(best->edx & F(LM))) {
> +		best = cpuid_entry2_find(entries, nent, 0x7, 0);
> +		if (best && ((best->ecx & F(SHSTK)) || (best->edx & F(IBT))))
> +			return -EINVAL;
> +	}

I honestly prefer a check in enter_smm_save_state_32 because SMM might not even
be enabled/used for the guest, and for consistency with SVM check that I added,
but whatever.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

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
> +
>  	return X86EMUL_CONTINUE;
>  }
>  #endif
> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> index a1cf2ac5bd78..1e2a3e18207f 100644
> --- a/arch/x86/kvm/smm.h
> +++ b/arch/x86/kvm/smm.h
> @@ -116,8 +116,8 @@ struct kvm_smram_state_64 {
>  	u32 smbase;
>  	u32 reserved4[5];
>  
> -	/* ssp and svm_* fields below are not implemented by KVM */
>  	u64 ssp;
> +	/* svm_* fields below are not implemented by KVM */
>  	u64 svm_guest_pat;
>  	u64 svm_host_efer;
>  	u64 svm_host_cr4;


Best regards,
	Maxim Levitsky


