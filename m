Return-Path: <linux-kernel+bounces-86910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FDE86CCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89B11F230A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499E13DBA4;
	Thu, 29 Feb 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5/qgKzt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A8137747
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219837; cv=none; b=IKEvsmzofmyt7CpTkeNdKHBatthHFHV0chLK7rpPtiOoAmkanPz2G8b8mIcrV2xZ3N7j8ERnaqS0HhTkBA93uL6WyNuzfXHGX2gVvwvYsWoEPYEBSfGSWtyfxFUbu88awDAN2B9KtqWxZXMm7Ncw5daRa6f0KJcvDVZ9CeaUIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219837; c=relaxed/simple;
	bh=uFHYH7ceJetLeMFHgvQpNiSJVH/0Wrd6rRiObMSDPUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X9Q92f1cSnsFqThbugqPJ6KrrlwOCagzyxmFYD4HShPYeCNA22OAVUylPvnpwucQiPyWfFzxcJEscthAJ76lTZrj8WsWwTQp0w12f6zfYk7/zzjAHyyP0Vk9umTts/CoKiH6lqzluHbjMHUEkNRxQ5Ctyzw5EEFd5ExvzOBeTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5/qgKzt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dbddee3694so605887a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709219835; x=1709824635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKUcD0IqjAO2harfuOVsFwWz5y0XpGWsLVWiyn3/0W0=;
        b=i5/qgKztbOlzgDtM/R+ndDnOnyZn5tW5KDgqOT0seDWV5Sf+nCrghX7Q4DYOJ019V3
         AjMOWLic/mUU34wEQE4RC3g++F+2rrct/hPoLdg9AXISZt+11M1fn8wdWKJ2XQMPCVr1
         Gl2gwI3Trpa2U+0x8XHRUoUvh+nEpXFDPYHIO1Tuhb6jcaIzl0PBr0RoxXrI0AlKSeC0
         eghMhSqDOUxX9gVtPApbIMVEjtK3Ih7K7kTSmwZvV2BgFdNNtHSwlRMOWJlfcLp6lE/7
         oitLzNR5JHjK15oq+4nfJH7ThHouDCOWP0AjcAIsClpQNTRQHTrHtg1jRVCKuWe+gr1e
         Jn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219835; x=1709824635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKUcD0IqjAO2harfuOVsFwWz5y0XpGWsLVWiyn3/0W0=;
        b=wGO7sVy+zO10aCmco76YF4WE17vyTUgiJwmugI5sz4RzJU3nT55cZcSeAfesHNxamn
         b23+K3ryvdDSH+vA/5NmGFbT0VGaFKOwqg6o6sO7EtGQq5fgPOSQ3tHfnwkPkPUrgxjU
         Nmg/5EE34vOaMSBy+STaLIu3MxXwYzvCLjq0Y2G7ix9Q0SL0lGW7ITKiY5hArVH35Rw5
         5Tmnj6IhqsFmb/+uTdxqNAKBUQetY/3fbExA01s9UNbUqLAlK1WtX6idwCw4p7rRMBWq
         wrWF98BQcuiG8JV5NVOdF3Kc+XkAQz2OgiG6vyltSGJv7tsAUI85J/xugK9Mo0Rhz3ZP
         K1vA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXaAQlsRlI+qzuGIXvYsAHgB60UHKEi9bMyFFRWMwBKik3hU+AQcjLssu1xfHV0dN/DWZ+0iMOM736NfYufqU49HKsfFMt9xkgFiM
X-Gm-Message-State: AOJu0YyDsakA+PeN/yF//r4635cEhOpUziab/cFbTVoydybQ3SZxoYNb
	dCTR26B5/A5d7vWWOM1FWa1Smovd9MzwHwbzL+wKH0F/Wxlne5uJ2u/3yc7XdeRy0qM92nrfccB
	x6g==
X-Google-Smtp-Source: AGHT+IGjd/wZeQUhZLyTS0Xx1LwVv3UAkSQJSyzs5lVC5PbTqHzOKCCE7HCzaV0S5Lrgz5YAgiEzWE4t4tM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3908:b0:29b:a22:5bc2 with SMTP id
 ob8-20020a17090b390800b0029b0a225bc2mr92471pjb.1.1709219835396; Thu, 29 Feb
 2024 07:17:15 -0800 (PST)
Date: Thu, 29 Feb 2024 07:17:14 -0800
In-Reply-To: <063aa825af395439cc1b3669fb326c395bd6fe42.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-6-seanjc@google.com>
 <063aa825af395439cc1b3669fb326c395bd6fe42.camel@intel.com>
Message-ID: <ZeCf-sJIyR7vuMtD@google.com>
Subject: Re: [PATCH 05/16] KVM: x86/mmu: Use synthetic page fault error code
 to indicate private faults
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tabba@google.com" <tabba@google.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"dmatlack@google.com" <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 29, 2024, Kai Huang wrote:
> 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 408969ac1291..7807bdcd87e8 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5839,19 +5839,31 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
> >  	bool direct = vcpu->arch.mmu->root_role.direct;
> >  
> >  	/*
> > -	 * IMPLICIT_ACCESS is a KVM-defined flag used to correctly perform SMAP
> > -	 * checks when emulating instructions that triggers implicit access.
> >  	 * WARN if hardware generates a fault with an error code that collides
> > -	 * with the KVM-defined value.  Clear the flag and continue on, i.e.
> > -	 * don't terminate the VM, as KVM can't possibly be relying on a flag
> > -	 * that KVM doesn't know about.
> > +	 * with KVM-defined sythentic flags.  Clear the flags and continue on,
> > +	 * i.e. don't terminate the VM, as KVM can't possibly be relying on a
> > +	 * flag that KVM doesn't know about.
> >  	 */
> > -	if (WARN_ON_ONCE(error_code & PFERR_IMPLICIT_ACCESS))
> > -		error_code &= ~PFERR_IMPLICIT_ACCESS;
> > +	if (WARN_ON_ONCE(error_code & PFERR_SYNTHETIC_MASK))
> > +		error_code &= ~PFERR_SYNTHETIC_MASK;
> >  
> 
> Hmm.. I thought for TDX the caller -- handle_ept_violation() -- should
> explicitly set the PFERR_PRIVATE_ACCESS so that here the fault handler can
> figure out the fault is private.
> 
> Now it seems the caller should never pass PFERR_PRIVATE_ACCESS, then ...
> 
> >  	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
> >  		return RET_PF_RETRY;
> >  
> > +	/*
> > +	 * Except for reserved faults (emulated MMIO is shared-only), set the
> > +	 * private flag for software-protected VMs based on the gfn's current
> > +	 * attributes, which are the source of truth for such VMs.  Note, this
> > +	 * wrong for nested MMUs as the GPA is an L2 GPA, but KVM doesn't
> > +	 * currently supported nested virtualization (among many other things)
> > +	 * for software-protected VMs.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) &&
> > +	    !(error_code & PFERR_RSVD_MASK) &&
> > +	    vcpu->kvm->arch.vm_type == KVM_X86_SW_PROTECTED_VM &&
> > +	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
> > +		error_code |= PFERR_PRIVATE_ACCESS;
> > +
> > 
> 
> ... I am wondering how we figure out whether a fault is private for TDX?

Read the next few patches :-)

The sanity check gets moved to the legacy #PF handler (any error code with bits
63:32!=0 yells) and SVM's #NPF handler (error code with synthetic bits set yells),
leaving VMX free and clear to stuff PFERR_PRIVATE_ACCESS as appropriate.

