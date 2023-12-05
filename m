Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1274804FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346554AbjLEKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjLEKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA285BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOubTR6+i/dKgMYOWRW6MbbKL5pk1rIVNxgsZdiME4Q=;
        b=K3Z70TB9oPtfO6Ujpq34/1rFM6+nUUDHaXIpXfzN+E0WUA1mJDAAwiWsvf2lNbfCz7oYkq
        /Q+RhuVvE9+nr3Z8ghqeCq4pge7wQHH9lJyyk3L374NsX6N8TKkKNgvz7Jpbl8Ep0f1yu4
        jqJB5rovjTgj8fEZozerQ0NYU7YtwGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-FUndPm7POtKCYQX_HryjcA-1; Tue, 05 Dec 2023 05:04:34 -0500
X-MC-Unique: FUndPm7POtKCYQX_HryjcA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b349b9711so47284905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770673; x=1702375473;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOubTR6+i/dKgMYOWRW6MbbKL5pk1rIVNxgsZdiME4Q=;
        b=XxUSvDwmelPIeK/DMv9aFgGLiqTDUESnA7uN4W9XiYnldmyP00cIdIWG7BTM9vXL1S
         dqc4FGYZaXWBmok3/XHYMjn+4/TVy/WUUK3RhyVIZGKxZjPx1QytmhVymOLr5meP7KS8
         tRL0HBEF74tfVKYzPpzp1pA5BeI8CutiJjjdcyo/Boq7XXVCAWodNiq2rghttP1EGi+J
         zjAAuejuSBrk+qmwyytOg5zwGnkknzTheJOnM6ApR5GWnQXyQdhg3TmFHUWdu7CeeAE+
         ASRbGpqMJs+CxKF4AJvtUvC9amnfZ0cqwPcFn7/2HUdQwpAVB9ktW7BaijOwQhB3MtT0
         WkTQ==
X-Gm-Message-State: AOJu0YywcUNmosiFupHIpb1ejz6ZxbLXexHyyA5a3b1VJ4RA6Z3mKCLH
        OtKrmzXmdofSt6YJYNEqXiyZU/tqk8WXcktVMTfLXNy+PDARxPvqaNPXEPLvow7qVNmPPQyz8h/
        Xz8fN4Cy7iWCfHgFpBGbd7uZ//EW5t1nz
X-Received: by 2002:a05:600c:a383:b0:409:1841:3f42 with SMTP id hn3-20020a05600ca38300b0040918413f42mr325122wmb.13.1701770673114;
        Tue, 05 Dec 2023 02:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7ol268sBRFByr05mv0n0XJD0kcfH6hr9SRiFHI8BNFQb5oJ5ZyfY+vheXrGVvEARQMSuhcw==
X-Received: by 2002:a05:600c:a383:b0:409:1841:3f42 with SMTP id hn3-20020a05600ca38300b0040918413f42mr325116wmb.13.1701770672753;
        Tue, 05 Dec 2023 02:04:32 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id c8-20020adfe708000000b003332aa97101sm12883419wrm.38.2023.12.05.02.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:04:32 -0800 (PST)
Message-ID: <1ca09d771a72b5644bab81723b2952896a74194a.camel@redhat.com>
Subject: Re: [PATCH v7 22/26] KVM: VMX: Set up interception for CET MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 05 Dec 2023 12:04:30 +0200
In-Reply-To: <ZWl+K55yUaCLCtqw@chao-email>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-23-weijiang.yang@intel.com>
         <393d82243b7f44731439717be82b20fbeda45c77.camel@redhat.com>
         <ZWl+K55yUaCLCtqw@chao-email>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 14:33 +0800, Chao Gao wrote:
> On Thu, Nov 30, 2023 at 07:44:45PM +0200, Maxim Levitsky wrote:
> > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > Enable/disable CET MSRs interception per associated feature configuration.
> > > Shadow Stack feature requires all CET MSRs passed through to guest to make
> > > it supported in user and supervisor mode while IBT feature only depends on
> > > MSR_IA32_{U,S}_CETS_CET to enable user and supervisor IBT.
> > > 
> > > Note, this MSR design introduced an architectural limitation of SHSTK and
> > > IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> > > to guest from architectual perspective since IBT relies on subset of SHSTK
> > > relevant MSRs.
> > > 
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 554f665e59c3..e484333eddb0 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -699,6 +699,10 @@ static bool is_valid_passthrough_msr(u32 msr)
> > >  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
> > >  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> > >  		return true;
> > > +	case MSR_IA32_U_CET:
> > > +	case MSR_IA32_S_CET:
> > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> > > +		return true;
> > >  	}
> > >  
> > >  	r = possible_passthrough_msr_slot(msr) != -ENOENT;
> > > @@ -7766,6 +7770,42 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> > >  		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
> > >  }
> > >  
> > > +static void vmx_update_intercept_for_cet_msr(struct kvm_vcpu *vcpu)
> > > +{
> > > +	bool incpt;
> > > +
> > > +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> > > +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
> > > +
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> > > +			vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
> > > +						  MSR_TYPE_RW, incpt);
> > > +		if (!incpt)
> > > +			return;
> > > +	}
> > > +
> > > +	if (kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> > > +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_IBT);
> > > +
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +	}
> > > +}
> > > +
> > >  static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >  {
> > >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > > @@ -7843,6 +7883,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >  
> > >  	/* Refresh #PF interception to account for MAXPHYADDR changes. */
> > >  	vmx_update_exception_bitmap(vcpu);
> > > +
> > > +	vmx_update_intercept_for_cet_msr(vcpu);
> > >  }
> > >  
> > >  static u64 vmx_get_perf_capabilities(void)
> > 
> > My review feedback from the previous patch still applies as well,
> > 
> > I still think that we should either try a best effort approach to plug
> > this virtualization hole, or we at least should fail guest creation
> > if the virtualization hole is present as I said:
> > 
> > "Another, much simpler option is to fail the guest creation if the shadow stack + indirect branch tracking
> > state differs between host and the guest, unless both are disabled in the guest.
> > (in essence don't let the guest be created if (2) or (3) happen)"
> 
> Enforcing a "none" or "all" policy is a temporary solution. in future, if some
> reserved bits in S/U_CET MSRs are extended for new features, there will be:
> 
> 	platform A supports SS + IBT
> 	platform B supports SS + IBT + new feature
> 
> Guests running on B inevitably have the same virtualization hole. and if kvm
> continues enforcing the policy on B, then VM migration from A to B would be
> impossible.
> 
> To me, intercepting S/U_CET MSR and CET_S/U xsave components is intricate and
> yields marginal benefits. And I also doubt any reasonable OS implementation
> would depend on #GP of WRMSR to S/U_CET MSRs for functionalities. So, I vote
> to leave the patch as-is.

To some extent I do agree with you but this can become a huge mess in the future.
I think we need at least to tell Intel/AMD about this to ensure that they don't make this thing worse
than it already is.

Also the very least we can do if we opt to keep things as is, 
is to document this virtualization hole - we have Documentation/virt/kvm/x86/errata.rst for that.

Best regards,
	Maxim Levitsky

> 
> > Please at least tell me what do you think about this.
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 




