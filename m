Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DF7E0B24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbjKCW0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjKCW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:26:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71023D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:26:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc3130ba31so20740065ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699050406; x=1699655206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qz3lxpTjwV7uKrVt1pa7AdPIpFhmvNL57r88OWBGAs=;
        b=IQwxyHfCAuD/AEJWllqin+xq06mvClt7YSuq/rtrDGScuqZ/cRhZf/YNCrTxSxp/Cd
         VRNhPgV/zK4OCWwX4WXXorxDGZ7g/wt+ggwKbEdUn+4VRXSnc7i+3BtRk20pmUzFKGQC
         rvx4jcb3bJkmq/zfWner9cNaB0au79HMXmDDmDkpiQBTfs1eGElp6TqTdYpxET0nw/2c
         pN+LrmSGPjK1BPXKhvrm4wMdxK7l/rqhk2GxTOVA3Dkv4gsbAcFoi0jOvuuaUXx2CcXf
         6QkZklFSyA1OIRXbBU1EVCqqBY4D7kT1LMlKt3XOhe+HHQGTYxJYFnPmFEXaJhDOH6TL
         a+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050406; x=1699655206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qz3lxpTjwV7uKrVt1pa7AdPIpFhmvNL57r88OWBGAs=;
        b=lQjoJXRBLDXY2mh3JLH3XPRxkV9/ApzQ+WC8nE6gZUe74es2nnb4h6LGxCEMyEPn5U
         FOus4DhuSML9v/fhexpIMdsgTCQsx1XoYPoHb905zcTuDXsp5rLB0K3wVfizzuVgNerW
         ROe4ZOgYSOhK3/1S4DcY5gwc3EoaFkvTVCNVlJ6GtAsDSApMbd4NaqO0TMk+L4DOCLA3
         she+8HQcLt0and4eIhJWG+4VkyF907wj6RXhq1abSF9AMsGUhm3l5o4JOu38mPVe2Ond
         SY3t73vCQ+tnQkmc599Km9qRSC4NPsqkT8+VsY4KTWsuo5uf/uh+6UIojOSY3BKrIgyf
         jOOg==
X-Gm-Message-State: AOJu0YxrpifDmKsqO7K40cU0PLV3M+VEVWc/iw2Y567gWXWGnbP17t42
        o9t4wqr6r+D7z2Wb1Nfsnf6bJtMzkFk=
X-Google-Smtp-Source: AGHT+IFeq7cdSJcWPrN+bNFUJYmnJmsZZZr44kVjASAIEmkPN7hPLrgXLlkfdFkrHpJgynav7YkKwmOhOvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7293:b0:1ca:8e79:53b7 with SMTP id
 d19-20020a170902729300b001ca8e7953b7mr386188pll.9.1699050405789; Fri, 03 Nov
 2023 15:26:45 -0700 (PDT)
Date:   Fri, 3 Nov 2023 15:26:44 -0700
In-Reply-To: <d1166177-c0ab-a8a5-94a6-e4e7ebdeb1c0@intel.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-20-weijiang.yang@intel.com> <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
 <ZUJ9fDuQUNe9BLUA@google.com> <d1166177-c0ab-a8a5-94a6-e4e7ebdeb1c0@intel.com>
Message-ID: <ZUVzpM465isag2bj@google.com>
Subject: Re: [PATCH v6 19/25] KVM: VMX: Emulate read and write to CET MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023, Weijiang Yang wrote:
> On 11/2/2023 12:31 AM, Sean Christopherson wrote:
> > On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > > Add emulation interface for CET MSR access. The emulation code is split
> > > > into common part and vendor specific part. The former does common check
> > > > for MSRs and reads/writes directly from/to XSAVE-managed MSRs via the
> > > > helpers while the latter accesses the MSRs linked to VMCS fields.
> > > > 
> > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > ---
> > ...
> > 
> > > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > > > +	case MSR_KVM_SSP:
> > > > +		if (host_msr_reset && kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> > > > +			break;
> > > > +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > > > +			return 1;
> > > > +		if (index == MSR_KVM_SSP && !host_initiated)
> > > > +			return 1;
> > > > +		if (is_noncanonical_address(data, vcpu))
> > > > +			return 1;
> > > > +		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
> > > > +			return 1;
> > > > +		break;
> > > Once again I'll prefer to have an ioctl for setting/getting SSP, this will
> > > make the above code simpler (e.g there will be no need to check that write
> > > comes from the host/etc).
> > I don't think an ioctl() would be simpler overall, especially when factoring in
> > userspace.  With a synthetic MSR, we get the following quite cheaply:
> > 
> >   1. Enumerating support to userspace.
> >   2. Save/restore of the value, e.g. for live migration.
> >   3. Vendor hooks for propagating values to/from the VMCS/VMCB.
> > 
> > For an ioctl(), #1 would require a capability, #2 (and #1 to some extent) would
> > require new userspace flows, and #3 would require new kvm_x86_ops hooks.
> > 
> > The synthetic MSR adds a small amount of messiness, as does bundling
> > MSR_IA32_INT_SSP_TAB with the other shadow stack MSRs.  The bulk of the mess comes
> > from the need to allow userspace to write '0' when KVM enumerated supported to
> > userspace.
> > 
> > If we isolate MSR_IA32_INT_SSP_TAB, that'll help with the synthetic MSR and with
> > MSR_IA32_INT_SSP_TAB.  For the unfortunate "host reset" behavior, the best idea I
> > came up with is to add a helper.  It's still a bit ugly, but the ugliness is
> > contained in a helper and IMO makes it much easier to follow the case statements.
> 
> Frankly speaking, existing code is not hard to understand to me :-), the
> handling for MSR_KVM_SSP and MSR_IA32_INT_SSP_TAB is straightforward if
> audiences read the related spec.

I don't necessarily disagree, but I 100% agree with Maxim that host_msr_reset is
a confusing name.  As Maxim pointed out, '0' isn't necessarily the RESET value.
And host_msr_reset implies that userspace is emulating a RESET, which may not
actually be true, e.g. a naive userspace could be restoring '0' as part of live
migration.

> But I'll take your advice and enclose below changes. Thanks!

Definitely feel free to propose an alternative.  My goal with the suggested change
is eliminate host_msr_reset without creating creating unwieldy case statements.
Isolating MSR_IA32_INT_SSP_TAB was (obviously) the best solution I came up with.

> > get:
> > 
> > 	case MSR_IA32_INT_SSP_TAB:
> > 		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) ||
> > 		    !guest_cpuid_has(vcpu, X86_FEATURE_LM))
> > 			return 1;
> > 		break;
> > 	case MSR_KVM_SSP:
> > 		if (!host_initiated)
> > 			return 1;
> > 		fallthrough;
> > 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > 		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > 			return 1;
> > 		break;
> > 
> > static bool is_set_cet_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u64 data,
> > 				   bool host_initiated)
> > {
> > 	bool any_cet = index == MSR_IA32_S_CET || index == MSR_IA32_U_CET;
> > 
> > 	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > 		return true;
> > 
> > 	if (any_cet && guest_can_use(vcpu, X86_FEATURE_IBT))
> > 		return true;
> > 
> > 	/*
> > 	 * If KVM supports the MSR, i.e. has enumerated the MSR existence to
> > 	 * userspace, then userspace is allowed to write '0' irrespective of
> > 	 * whether or not the MSR is exposed to the guest.
> > 	 */
> > 	if (!host_initiated || data)
> > 		return false;
> > 	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> > 		return true;
> > 
> > 	return any_cet && kvm_cpu_cap_has(X86_FEATURE_IBT);
> > }
> > 
> > set:
> > 	case MSR_IA32_U_CET:
> > 	case MSR_IA32_S_CET:
> > 		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
> > 			return 1;
> > 		if (data & CET_US_RESERVED_BITS)
> > 			return 1;
> > 		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) &&
> > 		    (data & CET_US_SHSTK_MASK_BITS))
> > 			return 1;
> > 		if (!guest_can_use(vcpu, X86_FEATURE_IBT) &&
> > 		    (data & CET_US_IBT_MASK_BITS))
> > 			return 1;
> > 		if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
> > 			return 1;
> > 
> > 		/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
> > 		if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
> > 			return 1;
> > 		break;
> > 	case MSR_IA32_INT_SSP_TAB:
> > 		if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
> > 			return 1;

Doh, I think this should be:

		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated) ||
		    !guest_cpuid_has(vcpu, X86_FEATURE_LM))
			return 1;
> > 
> > 		if (is_noncanonical_address(data, vcpu))
> > 			return 1;
> > 		break;
> > 	case MSR_KVM_SSP:
> > 		if (!host_initiated)
> > 			return 1;
> > 		fallthrough;
> > 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > 		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
> > 			return 1;
> > 		if (is_noncanonical_address(data, vcpu))
> > 			return 1;
> > 		if (!IS_ALIGNED(data, 4))
> > 			return 1;
> > 		break;
> > 	}
> 
