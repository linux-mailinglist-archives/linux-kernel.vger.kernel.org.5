Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA4E7DD5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376598AbjJaR6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347034AbjJaR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980310C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698775055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7n7rXDGzxGY+sVfqZD7hZH4pq+bUwf/MwnmwG8VpUM0=;
        b=cAoHSQak+WHwZdZBNp7QooG+SmHFfyi6ch6DLfLtrSY1vyyX3MQE1SSFjzwdq8J+lMZSLx
        L7HC4Xl1geHje2USRbPOTLAaMYWnYT3M1EwCkzFWcAwDwHJ2pCmV1bRLKAF2r4wLmH6DBP
        k3rC1P3NY1OE8dLPrLvVDwZ8H3/iM6k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-2g1tMtLXPkWq2ITADJw3_A-1; Tue, 31 Oct 2023 13:57:34 -0400
X-MC-Unique: 2g1tMtLXPkWq2ITADJw3_A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c53c85e482so61609691fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775053; x=1699379853;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7n7rXDGzxGY+sVfqZD7hZH4pq+bUwf/MwnmwG8VpUM0=;
        b=Af5p0SZEggAUm+CpzWPFsXBxlC+5H0Zjk0DhHRTQ5ug64n2UYKJIYfCe8d+ui4e69i
         P1fBWeaA8O4/4qEAwC5TMrKA66RGqbxOmZq71EybHPxWla5LZYZFmJyVYB71Q3C7mKUh
         qk9hntkCaZmiHTZ0QKbQCb1rq/3EmsrOq1t9vTwW3ypcnXDTIuW++7JcPsZswL+82gGW
         +ytpwnpNMA7PTipDcq+D+ySFeFevZjVuD+jzEX2CvoRuK/9pOfPaIKZbzQCTOEIuzQgd
         oS92JuBVe7msBGa7Y7GIGAA5q355W0mGqBD6twS0roZVGepOs90kP6RMY2IcD5LnMzPj
         uQeQ==
X-Gm-Message-State: AOJu0YzSekDDduJjuy+dTSSRdxaBp+R9nGw4dskGpN/6CgDg2RzHRekj
        AcKrYdfOPtQUk33BJC5o+fsJEfXXBQrjthyqqbO8Tf7OAwu5GYDsuncV7kUPMAhviLAgFt4o+0/
        dYNAPDwd2Nw+hF6vvg/b8fbjR
X-Received: by 2002:a2e:b5b0:0:b0:2c5:2813:5534 with SMTP id f16-20020a2eb5b0000000b002c528135534mr9397962ljn.51.1698775052952;
        Tue, 31 Oct 2023 10:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVdpBfYfpVLVmgvKt7Q4HkOn/pNoHPKERPEZBCIF+t2sG69OdwnvjwKBc+6CANAxCrlgRlzA==
X-Received: by 2002:a2e:b5b0:0:b0:2c5:2813:5534 with SMTP id f16-20020a2eb5b0000000b002c528135534mr9397955ljn.51.1698775052723;
        Tue, 31 Oct 2023 10:57:32 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b0032f7fab0712sm2051940wrn.52.2023.10.31.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:57:32 -0700 (PDT)
Message-ID: <f0ab3a69307069f39e6b9ce4da9fe2ee46e38d86.camel@redhat.com>
Subject: Re: [PATCH v6 25/25] KVM: nVMX: Enable CET support for nested guest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:57:30 +0200
In-Reply-To: <20230914063325.85503-26-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-26-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Set up CET MSRs, related VM_ENTRY/EXIT control bits and fixed CR4 setting
> to enable CET for nested VM.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 27 +++++++++++++++++++++++++--
>  arch/x86/kvm/vmx/vmcs12.c |  6 ++++++
>  arch/x86/kvm/vmx/vmcs12.h | 14 +++++++++++++-
>  arch/x86/kvm/vmx/vmx.c    |  2 ++
>  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 78a3be394d00..2c4ff13fddb0 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -660,6 +660,28 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
> @@ -6794,7 +6816,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>  		VM_EXIT_HOST_ADDR_SPACE_SIZE |
>  #endif
>  		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> -		VM_EXIT_CLEAR_BNDCFGS;
> +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
>  	msrs->exit_ctls_high |=
>  		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>  		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> @@ -6816,7 +6838,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
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
> index f0dea8ecd0c6..2c43f1088d77 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7731,6 +7731,8 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
>  	cr4_fixed1_update(X86_CR4_PKE,        ecx, feature_bit(PKU));
>  	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
>  	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
> +	cr4_fixed1_update(X86_CR4_CET,	      ecx, feature_bit(SHSTK));
> +	cr4_fixed1_update(X86_CR4_CET,	      edx, feature_bit(IBT));
>  
>  #undef cr4_fixed1_update
>  }


It is surprising how little needs to be done to support the nested mode, but it does look correct.
I might have missed something though, can't be 100% sure in this case.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky






