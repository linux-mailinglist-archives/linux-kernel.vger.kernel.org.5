Return-Path: <linux-kernel+bounces-14948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027BA8224D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CB21F2094E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640918057;
	Tue,  2 Jan 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCavmdf2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEB18046
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3OEkrz4IvX0NKkV4zg/lLcvyiJ3B5f3cy/WTvXAT+A=;
	b=BCavmdf20ykMvq+DwLI1palg2FeV//qxEWPPUUNBGwpds4LpRp5b2BblbzzgGngSICzPHU
	hizNpbCn7PFwhIaW+mNXW5mZO3Rxie5uuduIJA8F1MYXel4YBiVcUjSUUuXAp99WVf4Znv
	vb3sm5ClesXqVewz8MuQoV8ZbVwO1LI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-JE4mYpXwO12y1KZqxaBNpQ-1; Tue, 02 Jan 2024 17:35:19 -0500
X-MC-Unique: JE4mYpXwO12y1KZqxaBNpQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698efbdso6407035f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234918; x=1704839718;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3OEkrz4IvX0NKkV4zg/lLcvyiJ3B5f3cy/WTvXAT+A=;
        b=C9+unmY+ksLZEs+uMlRu9YaSFyyXCiM2lyuEc5+X4pJsNhUBvnP5xH744mhzj1GIS1
         5sSsL8va7Ac8YWspNkfeh5wUQ54GCRuDG+29y8G/mMFYACnrraNneqtadmcUyzNGSkha
         IdnoWIX1xbHqxxXdsurFmqoekxoLzMhbKaWckXhcbRWycnWjeyP2VoAHO3CpXaNUKWG2
         qzuljvKcM55wwJBDjN3Zr35cLwg2dsWBIuB/tnbb6vRLDdhAlyxEgLq2WY/4nDvHYtVe
         wvI6uQZMyjh6YJ9GVfyG4XLp4u3+aGrSvMc1X66DsoeQ3jwrwE7NMzFTkj/tA9leZFJi
         J1Cg==
X-Gm-Message-State: AOJu0YytOvypp2Peg56IMZGifOUgT3Ut4BAB2skFF5vVmD1a3Vo1ozJq
	djhPRuIp7eGVNWIyMZm/N5AZJojG68nwmIVFBf7gyrKaS2gxoctSkyAd4HqhQgeIRkJsT154tnC
	mCL/NGwbCzEAaUr32QLjnOva+62ljVtuU
X-Received: by 2002:a5d:6151:0:b0:336:787c:6236 with SMTP id y17-20020a5d6151000000b00336787c6236mr10839899wrt.65.1704234918337;
        Tue, 02 Jan 2024 14:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa2Bn42ATClcSHQHaHWlswLGmU6vlJuomL8lxRoQ6rUKNOgj2EyMv+0Wdr4cIvaAbzbR2wIQ==
X-Received: by 2002:a5d:6151:0:b0:336:787c:6236 with SMTP id y17-20020a5d6151000000b00336787c6236mr10839888wrt.65.1704234918151;
        Tue, 02 Jan 2024 14:35:18 -0800 (PST)
Received: from starship ([147.235.223.38])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b00336471bc7ffsm29053887wrv.109.2024.01.02.14.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:35:17 -0800 (PST)
Message-ID: <780ccc2b6a08e54a69ec83f8120c1dddaee37ab7.camel@redhat.com>
Subject: Re: [PATCH v8 26/26] KVM: nVMX: Enable CET support for nested guest
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	john.allen@amd.com
Date: Wed, 03 Jan 2024 00:35:16 +0200
In-Reply-To: <20231221140239.4349-27-weijiang.yang@intel.com>
References: <20231221140239.4349-1-weijiang.yang@intel.com>
	 <20231221140239.4349-27-weijiang.yang@intel.com>
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
> Set up CET MSRs, related VM_ENTRY/EXIT control bits and fixed CR4 setting
> to enable CET for nested VM.
> 
> vmcs12 and vmcs02 needs to be synced when L2 exits to L1 or when L1 wants
> to resume L2, that way correct CET states can be observed by one another.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 57 +++++++++++++++++++++++++++++++++++++--
>  arch/x86/kvm/vmx/vmcs12.c |  6 +++++
>  arch/x86/kvm/vmx/vmcs12.h | 14 +++++++++-
>  arch/x86/kvm/vmx/vmx.c    |  2 ++
>  4 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 468a7cf75035..dee718c65255 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -691,6 +691,28 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
>  
> +	/* Pass CET MSRs to nested VM if L0 and L1 are set to pass-through. */
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_U_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_S_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL1_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL2_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> +
>  	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
>  
>  	vmx->nested.force_msr_bitmap_recalc = false;
> @@ -2506,6 +2528,17 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
>  		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
>  			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> +
> +		if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE) {
> +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> +				vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> +				vmcs_writel(GUEST_INTR_SSP_TABLE,
> +					    vmcs12->guest_ssp_tbl);
> +			}
> +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> +			    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT))
> +				vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> +		}
>  	}

Looks good.
>  
>  	if (nested_cpu_has_xsaves(vmcs12))
> @@ -4344,6 +4377,15 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
>  	vmcs12->guest_pending_dbg_exceptions =
>  		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
>  
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> +	    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT)) {
> +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> +	}
> +
>  	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
>  }

Looks good.

>  
> @@ -4569,6 +4611,16 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  	if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
>  		vmcs_write64(GUEST_BNDCFGS, 0);
>  
> +	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE) {
> +		if (guest_can_use(vcpu, X86_FEATURE_SHSTK)) {
> +			vmcs_writel(HOST_SSP, vmcs12->host_ssp);
> +			vmcs_writel(HOST_INTR_SSP_TABLE, vmcs12->host_ssp_tbl);
> +		}
> +		if (guest_can_use(vcpu, X86_FEATURE_SHSTK) ||
> +		    guest_can_use(vcpu, X86_FEATURE_IBT))
> +			vmcs_writel(HOST_S_CET, vmcs12->host_s_cet);
> +	}
> +

Looks good.

>  	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PAT) {
>  		vmcs_write64(GUEST_IA32_PAT, vmcs12->host_ia32_pat);
>  		vcpu->arch.pat = vmcs12->host_ia32_pat;
> @@ -6840,7 +6892,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>  		VM_EXIT_HOST_ADDR_SPACE_SIZE |
>  #endif
>  		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> -		VM_EXIT_CLEAR_BNDCFGS;
> +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
>  	msrs->exit_ctls_high |=
>  		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>  		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> @@ -6862,7 +6914,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
>  #ifdef CONFIG_X86_64
>  		VM_ENTRY_IA32E_MODE |
>  #endif
> -		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
> +		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> +		VM_ENTRY_LOAD_CET_STATE;
>  	msrs->entry_ctls_high |=
>  		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
>  		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 106a72c923ca..4233b5ca9461 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -139,6 +139,9 @@ const unsigned short vmcs12_field_offsets[] = {
>  	FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions),
>  	FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp),
>  	FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip),
> +	FIELD(GUEST_S_CET, guest_s_cet),
> +	FIELD(GUEST_SSP, guest_ssp),
> +	FIELD(GUEST_INTR_SSP_TABLE, guest_ssp_tbl),
>  	FIELD(HOST_CR0, host_cr0),
>  	FIELD(HOST_CR3, host_cr3),
>  	FIELD(HOST_CR4, host_cr4),
> @@ -151,5 +154,8 @@ const unsigned short vmcs12_field_offsets[] = {
>  	FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip),
>  	FIELD(HOST_RSP, host_rsp),
>  	FIELD(HOST_RIP, host_rip),
> +	FIELD(HOST_S_CET, host_s_cet),
> +	FIELD(HOST_SSP, host_ssp),
> +	FIELD(HOST_INTR_SSP_TABLE, host_ssp_tbl),
>  };
>  const unsigned int nr_vmcs12_fields = ARRAY_SIZE(vmcs12_field_offsets);
> diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
> index 01936013428b..3884489e7f7e 100644
> --- a/arch/x86/kvm/vmx/vmcs12.h
> +++ b/arch/x86/kvm/vmx/vmcs12.h
> @@ -117,7 +117,13 @@ struct __packed vmcs12 {
>  	natural_width host_ia32_sysenter_eip;
>  	natural_width host_rsp;
>  	natural_width host_rip;
> -	natural_width paddingl[8]; /* room for future expansion */
> +	natural_width host_s_cet;
> +	natural_width host_ssp;
> +	natural_width host_ssp_tbl;
> +	natural_width guest_s_cet;
> +	natural_width guest_ssp;
> +	natural_width guest_ssp_tbl;
> +	natural_width paddingl[2]; /* room for future expansion */
>  	u32 pin_based_vm_exec_control;
>  	u32 cpu_based_vm_exec_control;
>  	u32 exception_bitmap;
> @@ -292,6 +298,12 @@ static inline void vmx_check_vmcs12_offsets(void)
>  	CHECK_OFFSET(host_ia32_sysenter_eip, 656);
>  	CHECK_OFFSET(host_rsp, 664);
>  	CHECK_OFFSET(host_rip, 672);
> +	CHECK_OFFSET(host_s_cet, 680);
> +	CHECK_OFFSET(host_ssp, 688);
> +	CHECK_OFFSET(host_ssp_tbl, 696);
> +	CHECK_OFFSET(guest_s_cet, 704);
> +	CHECK_OFFSET(guest_ssp, 712);
> +	CHECK_OFFSET(guest_ssp_tbl, 720);
>  	CHECK_OFFSET(pin_based_vm_exec_control, 744);
>  	CHECK_OFFSET(cpu_based_vm_exec_control, 748);
>  	CHECK_OFFSET(exception_bitmap, 752);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c802e790c0d5..7ddd3f6fe8ab 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7732,6 +7732,8 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
>  	cr4_fixed1_update(X86_CR4_PKE,        ecx, feature_bit(PKU));
>  	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
>  	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
> +	cr4_fixed1_update(X86_CR4_CET,	      ecx, feature_bit(SHSTK));
> +	cr4_fixed1_update(X86_CR4_CET,	      edx, feature_bit(IBT));
>  
>  	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
>  	cr4_fixed1_update(X86_CR4_LAM_SUP,    eax, feature_bit(LAM));

Looks good to me, but I might have missed something. Nesting is always tricky to get right,
so this should be very well tested.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



