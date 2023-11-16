Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5797EE928
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjKPWTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:19:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0ABB2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:19:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so1163300276.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700173152; x=1700777952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl6pks/5nXHIxwnkpgKQp0jBSB1m9Szr34Vwe0okSLc=;
        b=lNO544ZyxyuljkS8Anwl0VfYeICczJBJk4fOhNyerjGF+q79/cGChsn+XdyL9jlwZr
         7QHvAWlBjEKVj//flGE3y8s3yzymPGeWLX0wMZhNiaOgF+8L5vWI090PrqRlHknuB4IW
         KdirP4xIjnM+0CIb/BgR2YRq9GMMDmZB6Y9HQKTU9u5Ofm6uclyL+4vCJHoHLDErGe6m
         HGZzvRVnq71XNdRRin/dfmTncjX3uFn0kcp5ko/PtKCSfGJ1yKH4VHBB9Ggf3lA+qLIS
         IJBIUiV/p0Q+XIKlZ7tOC5mDg9MljbTNDkGqVSau527ui8ER0J6roLEorDgeWzVMk9zj
         UdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173152; x=1700777952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl6pks/5nXHIxwnkpgKQp0jBSB1m9Szr34Vwe0okSLc=;
        b=IfZqDhgxs7ZJpt47EsW72Fxc9RlEkUK9lfok0yugidzF3cAdYnNrIluHUeychVFwbc
         WS/kFhPXeQ6jRQIutc1iRe4wvw39vLp1VilUNtm3KZrR0x0IWTfES1SWDA4yc3iEKcuj
         4XWLPxRRqAkx7+iEnS7lbVel7jIpz9t+Y0Ml4Vq6ki+UiWswZCNLi43akoL2lRoV3RJE
         TRcq2IWRxn6vglo3sGVL/fQGSZOb90WqFSCVcWkbLdbRGBhuxKbXl+bOytFBbBfszRjA
         3zshklI0cH5MiP4Ko6caFw6Ho6KZsPFNRtpGQcWytZHT17TTGtFrB/Ky/Fhfa7Atddwy
         hocg==
X-Gm-Message-State: AOJu0YwAlZPdudaSdg/IIlQSpzQvOh7SLhvRb/H/RdmO5Nee2+g3mxT2
        hQBMHPvhXlfvQhimvyMzkD9rBalTx9s=
X-Google-Smtp-Source: AGHT+IEqo0jiu8MtHkcdfWCPlttWfKv9BaFWX/gYTmABVC5zf10/TpE+l8r8f8rYCLUPVsOPCyTcKVQo0Do=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dcc3:0:b0:d9a:4fb2:16a2 with SMTP id
 y186-20020a25dcc3000000b00d9a4fb216a2mr400823ybe.12.1700173152181; Thu, 16
 Nov 2023 14:19:12 -0800 (PST)
Date:   Thu, 16 Nov 2023 14:19:10 -0800
In-Reply-To: <bc2534fe-ade3-496e-a1be-bb2196fb2003@intel.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com> <20231110235528.1561679-7-seanjc@google.com>
 <bc2534fe-ade3-496e-a1be-bb2196fb2003@intel.com>
Message-ID: <ZVaVXtKU1nxjFkrw@google.com>
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023, Weijiang Yang wrote:
> On 11/11/2023 7:55 AM, Sean Christopherson wrote:
> >   static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
> >   				       int nent)
> >   {
> >   	struct kvm_cpuid_entry2 *best;
> > +	struct kvm_vcpu *caps = vcpu;
> > +
> > +	/*
> > +	 * Don't update vCPU capabilities if KVM is updating CPUID entries that
> > +	 * are coming in from userspace!
> > +	 */
> > +	if (entries != vcpu->arch.cpuid_entries)
> > +		caps = NULL;
> 
> Nit, why here we use caps instead of vcpu? Looks a bit weird.

See my response to Robert: https://lore.kernel.org/all/9395d416-cc5c-536d-641e-ffd971b682d1@gmail.com

> >   	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> > -	if (best) {
> > -		/* Update OSXSAVE bit */
> > -		if (boot_cpu_has(X86_FEATURE_XSAVE))
> > -			cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
> > +
> > +	if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +		kvm_update_feature_runtime(caps, best, X86_FEATURE_OSXSAVE,
> >   					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
> > -		cpuid_entry_change(best, X86_FEATURE_APIC,
> > -			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> > +	kvm_update_feature_runtime(caps, best, X86_FEATURE_APIC,
> > +				   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> > -		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> > -			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> > -					   vcpu->arch.ia32_misc_enable_msr &
> > -					   MSR_IA32_MISC_ENABLE_MWAIT);
> > -	}
> > +	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> > +		kvm_update_feature_runtime(caps, best, X86_FEATURE_MWAIT,
> > +					   vcpu->arch.ia32_misc_enable_msr & MSR_IA32_MISC_ENABLE_MWAIT);
> 
> > 80 characters?

Hmm, yeah, I suppose.
