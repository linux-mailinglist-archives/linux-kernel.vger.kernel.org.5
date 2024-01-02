Return-Path: <linux-kernel+bounces-14945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C69F8224CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A496B1C208D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92A17734;
	Tue,  2 Jan 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNZkBkzO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589011772B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0ymMbFltWZ5pQNjAU9KkujHoH+I47LSiBpa1K2OeSM=;
	b=UNZkBkzOw5B6Ju7vRtD3t2xf5+RbotFJzQ4LsY0s3YVxLnoIz3zJXW5aVMyWM+soQy2DEP
	LJoE7FWpm2zyVSaHERfQXW+hQsHZxo/jvnWKnH5/L+8xCxPKszjKHL4yYviIDbnmzqzQp9
	nafT7OBiKuRa2kjEl1Xc7tenDp80ygM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-39LrWq7vNYmWgvv1M4G--w-1; Tue, 02 Jan 2024 17:34:42 -0500
X-MC-Unique: 39LrWq7vNYmWgvv1M4G--w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d45be1ce2so47172765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234881; x=1704839681;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0ymMbFltWZ5pQNjAU9KkujHoH+I47LSiBpa1K2OeSM=;
        b=LoB90kldpN+OgxyZEq9sB9dP8bNmUa5MyM7Rkc9ulF8SVSLvFA2iJ5uHZBkLhmmOJl
         tpBlaK9e4zhuVbLh7RuqEwKml1yBzC7PtS2bUGMP3bguaTGENBEz9Ju2WbpgAXN510tb
         Q5BqT3rq0+9tvNsuFK9VXBdu6W/f9eNOaa8YAMFgFcNIFr3VUSSh7wAcpBAPL2m5+Un3
         xKTZFipdkyN92qAAClDvcyQ+ReLaXCdqvlHlOmUK1PzmO5BNJo20OdUPg+PH/vMSNTlV
         m060l82X3Y34k91Y7Hu+ee4yiWAFCGZmNqeD8Kud8feQ3NPgVzNHT2oTF8vOC/5iylol
         hVFQ==
X-Gm-Message-State: AOJu0Yz9k8ZY+YdCUfXhhDIZnq3r8pdTeqDk46JUEKEIXD5xVxf6Gp/W
	/oGevPmPmDjgwodHocb9KbbtvPo5E1B4uRfGWMSRcwoXx3FWnpx9WsH+gvb54fUN3AxhA3N5vrF
	eJlDlOU8jKShujMQ+u5tm8796tW+PuviS
X-Received: by 2002:a05:600c:548e:b0:40d:1d1c:ffaa with SMTP id iv14-20020a05600c548e00b0040d1d1cffaamr51595wmb.169.1704234881427;
        Tue, 02 Jan 2024 14:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGamn3RuTsOpRu6QcfyYmmYsGfTC9bmPP/GTjRiXSTiCirude9eeHpwq3a5V6MEhrM6WpboXw==
X-Received: by 2002:a05:600c:548e:b0:40d:1d1c:ffaa with SMTP id iv14-20020a05600c548e00b0040d1d1cffaamr51585wmb.169.1704234881148;
        Tue, 02 Jan 2024 14:34:41 -0800 (PST)
Received: from starship ([147.235.223.38])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d4612000000b003367bb8898dsm29494717wrq.66.2024.01.02.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:34:40 -0800 (PST)
Message-ID: <2de1d89ba1aff043de8fdc5462e5d9c1ef2a0ef6.camel@redhat.com>
Subject: Re: [PATCH v8 22/26] KVM: VMX: Set up interception for CET MSRs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	john.allen@amd.com
Date: Wed, 03 Jan 2024 00:34:39 +0200
In-Reply-To: <20231221140239.4349-23-weijiang.yang@intel.com>
References: <20231221140239.4349-1-weijiang.yang@intel.com>
	 <20231221140239.4349-23-weijiang.yang@intel.com>
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
> Enable/disable CET MSRs interception per associated feature configuration.
> Shadow Stack feature requires all CET MSRs passed through to guest to make
> it supported in user and supervisor mode while IBT feature only depends on
> MSR_IA32_{U,S}_CETS_CET to enable user and supervisor IBT.
> 
> Note, this MSR design introduced an architectural limitation of SHSTK and
> IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> to guest from architectual perspective since IBT relies on subset of SHSTK
> relevant MSRs.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 064a5fe87948..08058b182893 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -692,6 +692,10 @@ static bool is_valid_passthrough_msr(u32 msr)
>  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
>  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
>  		return true;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> +		return true;
>  	}
>  
>  	r = possible_passthrough_msr_slot(msr) != -ENOENT;
> @@ -7767,6 +7771,42 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>  		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
>  }
>  
> +static void vmx_update_intercept_for_cet_msr(struct kvm_vcpu *vcpu)
> +{
> +	bool incpt;
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
> +
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> +			vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
> +						  MSR_TYPE_RW, incpt);
> +		if (!incpt)
> +			return;
> +	}
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_IBT);
> +
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> +					  MSR_TYPE_RW, incpt);
> +	}
> +}
> +
>  static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -7845,6 +7885,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  
>  	/* Refresh #PF interception to account for MAXPHYADDR changes. */
>  	vmx_update_exception_bitmap(vcpu);
> +
> +	vmx_update_intercept_for_cet_msr(vcpu);
>  }
>  
>  static u64 vmx_get_perf_capabilities(void)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


