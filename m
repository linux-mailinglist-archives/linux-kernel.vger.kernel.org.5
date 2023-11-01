Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA717DE5D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbjKASFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjKASFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:05:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF6C10E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:05:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso1145917b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861945; x=1699466745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rL6PypGT2hlmINXu9QUwfJHSqDzRPjLPXVa5ioHlgmM=;
        b=cV0KYCn8U3gEavG+eISSGQWUwGWiGyKlJz0hIyUcqRq3sOyBpI1UF5gxACX7Lg9om9
         Wln6PNazQdGp0Qcz52443Ku6hXwMpIBpPU2WgwOqMt75SmIkiAMAk4JIFBkDPe58XTfu
         PzbS1uacqXACACPptXq697KyQTYD3J0eDPkOy5VbzTBJsAOJOg3Ol7sfhcASrTuD73Qv
         00XhjtsSKaXZQBCWOgyMtCCptnxr1erS2LhZBaN4w0ofwZxs7EIxpBUen5YhxPrfpotO
         1CcoOPcDUPBliOvsQTV50V/hBxv7j/pAPSCVIYOdmDbfmfmLQMNLuhElBxPM6IwQtp8R
         2zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861945; x=1699466745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL6PypGT2hlmINXu9QUwfJHSqDzRPjLPXVa5ioHlgmM=;
        b=QopwYZNf0usL3/FrPiAKD5HMALytatkGS5KCKV/W6Vc1Z53Q502HG/HI4gZ+n8a5Gg
         S9QL56lP+u8Bz9PD2b1W3PFh/epNbzXVO7jZtHW19bZb/g5xoQNNp+U+vDJ1ouVfyHeX
         EAHtiY75KLXjg59Fuyh5+tusmbanCIiSK//R1W+pCSO0aRWvsEHg/aZasSveR/YO8SJh
         UXjOShW9JqEinQNXkrzN7NsPub2nLmA2FmXKylTJUHiakUvXSLJMiU/+aee5J2ZnpF41
         H3KMajtPxSWq/UjWHRCTtzk3Ljg1u7uC9EyF3kbWCYC8tII1EmCszScKLKkhHeRKQ4TT
         3Mkw==
X-Gm-Message-State: AOJu0Yzx0OICloay6R6sQsIco/42qGUXhDRSYUEwF0jUYfha8OHWqXco
        aSKcSmVLF6TcG7BRO7Usu19lQX6fJWc=
X-Google-Smtp-Source: AGHT+IF0EJWzD90tR3Yra+xB6XEurYAJXQJ9oQtDBrvYG4t2cwb5yIePSuJ/SeetUVaU4iSB2o0dFSo4ZJQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a14c:0:b0:59b:e97e:f7e2 with SMTP id
 y73-20020a81a14c000000b0059be97ef7e2mr351426ywg.4.1698861945136; Wed, 01 Nov
 2023 11:05:45 -0700 (PDT)
Date:   Wed, 1 Nov 2023 11:05:43 -0700
In-Reply-To: <2b1973ee44498039c97d4d11de3a93b0f3b1d2d8.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-15-weijiang.yang@intel.com> <2b1973ee44498039c97d4d11de3a93b0f3b1d2d8.camel@redhat.com>
Message-ID: <ZUKTd_a00fs1nyyk@google.com>
Subject: Re: [PATCH v6 14/25] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 66edbed25db8..a091764bf1d2 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -133,6 +133,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> >  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> >  
> >  static DEFINE_MUTEX(vendor_module_lock);
> > +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> > +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> > +
> >  struct kvm_x86_ops kvm_x86_ops __read_mostly;
> >  
> >  #define KVM_X86_OP(func)					     \
> > @@ -4372,6 +4375,22 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
> >  
> > +static const u32 xstate_msrs[] = {
> > +	MSR_IA32_U_CET, MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP,
> > +	MSR_IA32_PL2_SSP, MSR_IA32_PL3_SSP,
> > +};
> > +
> > +static bool is_xstate_msr(u32 index)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(xstate_msrs); i++) {
> > +		if (index == xstate_msrs[i])
> > +			return true;
> > +	}
> > +	return false;
> > +}
> 
> The name 'xstate_msr' IMHO is not clear.
> 
> How about naming it 'guest_fpu_state_msrs', together with adding a comment like that:

Maybe xstate_managed_msrs?  I'd prefer not to include "guest" because the behavior
is more a property of the architecture and/or the host kernel.  I understand where
you're coming from, but it's the MSR *values* are part of guest state, whereas the
check is a query on how KVM manages the MSR value, if that makes sense.

And I really don't like "FPU".  I get why the the kernel uses the "FPU" terminology,
but for this check in particular I want to tie the behavior back to the architecture,
i.e. provide the hint that the reason why these MSRs are special is because Intel
defined them to be context switched via XSTATE.

Actually, this is unnecesary bikeshedding to some extent, using an array is silly.
It's easier and likely far more performant (not that that matters in this case)
to use a switch statement.

Is this better?

/*
 * Returns true if the MSR in question is managed via XSTATE, i.e. is context
 * switched with the rest of guest FPU state.
 */
static bool is_xstate_managed_msr(u32 index)
{
	switch (index) {
	case MSR_IA32_U_CET:
	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
		return true;
	default:
		return false;
	}
}

/*
 * Read or write a bunch of msrs. All parameters are kernel addresses.
 *
 * @return number of msrs set successfully.
 */
static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
		    struct kvm_msr_entry *entries,
		    int (*do_msr)(struct kvm_vcpu *vcpu,
				  unsigned index, u64 *data))
{
	bool fpu_loaded = false;
	int i;

	for (i = 0; i < msrs->nmsrs; ++i) {
		/*
	 	 * If userspace is accessing one or more XSTATE-managed MSRs,
		 * temporarily load the guest's FPU state so that the guest's
		 * MSR value(s) is resident in hardware, i.e. so that KVM can
		 * get/set the MSR via RDMSR/WRMSR.
	 	 */
		if (vcpu && !fpu_loaded && kvm_caps.supported_xss &&
		    is_xstate_managed_msr(entries[i].index)) {
			kvm_load_guest_fpu(vcpu);
			fpu_loaded = true;
		}
		if (do_msr(vcpu, entries[i].index, &entries[i].data))
			break;
	}
	if (fpu_loaded)
		kvm_put_guest_fpu(vcpu);

	return i;
}
