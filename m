Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB97FAF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjK1BYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1BYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:24:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD5E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:24:18 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5bd18d54a48so4991135a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701134658; x=1701739458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccfuuY9Lz/COE9I6k14m7srCwypVDjwLLZgJ5DupFSA=;
        b=OzMAYvxfy4t5tQroSUPHGiip+9tnKC82tO4jUuxNfDoJb27HQap7nRF0hVH7Rzr3Qq
         zLSXvuGcrqr5X7UWPKosBY9NwenTXWMAb2imAq75bhsy+NsxcYRS4JJycLybcpOsuiiZ
         tnZAKJU9QvpAh6dI95BFQeyb6foIIxkPvsOekspPdn5keGdS3FTDKgkGPpAsMziiw0FT
         xA5tsvPwGKnjdZF7uh+WGj6DCRAJ2tphFkKcT1OxjplqtS0/iI729MYN9Nybk4uEaEAO
         WVKLTylI7to+is7qDsB3J/crim961eUFnAYzjSrOutNQbMAZ0F+N3DEuYiqCoxBQvASr
         d1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701134658; x=1701739458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccfuuY9Lz/COE9I6k14m7srCwypVDjwLLZgJ5DupFSA=;
        b=MK5ivThMvC+2x4Xsf8Lqg3QF/y+MPvgZehBp5UxRIQ4kCc1/j/30rugE8um4MbOhqD
         h6XO162DDdwHrW6rEAB37gfogMINfWRGQKvx/UG55GJCadNMcP6TtZM0kL6Fo5AevjiE
         xL+AihyLepr3550fiY7E99ZRUnAYps9TBUd4NQVFhIwtO8ei/LOenWx30qNUXLOmiZE+
         PEMsabeaTJ9NIYkRzr7DOT6c4nftIqkV41miqBr8E3kkLKy60EMWdBuRoatl/o3k2cKp
         I88mHbBfrP9xZIHE0+0T47BNkXMzK5QpRRduWI/8Kr0Pwdw8eFdtFOgOCUPk+XdgI+h1
         GvTQ==
X-Gm-Message-State: AOJu0YyPk9Ny1Qs/gPqlFGZcHGrNXKFkpu5g/YDTPcNusS2rhnX4MbvX
        pWl3oVNuuRpoV6bTCWM2cKfoETNlkD4=
X-Google-Smtp-Source: AGHT+IGgTsSqDSRzspJot6Wq5LGYVHgmFwA+F770d+kNJgqhCjlA/9XgQZuTMJuYkXuMnbM/7RL4uRFRX9U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8341:b0:1cf:de4e:f8de with SMTP id
 z1-20020a170902834100b001cfde4ef8demr513394pln.12.1701134658042; Mon, 27 Nov
 2023 17:24:18 -0800 (PST)
Date:   Mon, 27 Nov 2023 17:24:16 -0800
In-Reply-To: <c38adc1dc0a7df1c902b8ffbc82076d6da527e2a.camel@redhat.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com> <20231110235528.1561679-3-seanjc@google.com>
 <c38adc1dc0a7df1c902b8ffbc82076d6da527e2a.camel@redhat.com>
Message-ID: <ZWVBQPjwG7gOcA66@google.com>
Subject: Re: [PATCH 2/9] KVM: x86: Replace guts of "goverened" features with
 comprehensive cpu_caps
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023, Maxim Levitsky wrote:
> On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> > @@ -840,23 +856,15 @@ struct kvm_vcpu_arch {
> >  	struct kvm_hypervisor_cpuid kvm_cpuid;
> >  
> >  	/*
> > -	 * FIXME: Drop this macro and use KVM_NR_GOVERNED_FEATURES directly
> > -	 * when "struct kvm_vcpu_arch" is no longer defined in an
> > -	 * arch/x86/include/asm header.  The max is mostly arbitrary, i.e.
> > -	 * can be increased as necessary.
> > +	 * Track the effective guest capabilities, i.e. the features the vCPU
> > +	 * is allowed to use.  Typically, but not always, features can be used
> > +	 * by the guest if and only if both KVM and userspace want to expose
> > +	 * the feature to the guest.  A common exception is for virtualization
> > +	 * holes, i.e. when KVM can't prevent the guest from using a feature,
> > +	 * in which case the vCPU "has" the feature regardless of what KVM or
> > +	 * userspace desires.
> >  	 */
> > -#define KVM_MAX_NR_GOVERNED_FEATURES BITS_PER_LONG
> > -
> > -	/*
> > -	 * Track whether or not the guest is allowed to use features that are
> > -	 * governed by KVM, where "governed" means KVM needs to manage state
> > -	 * and/or explicitly enable the feature in hardware.  Typically, but
> > -	 * not always, governed features can be used by the guest if and only
> > -	 * if both KVM and userspace want to expose the feature to the guest.
> > -	 */
> > -	struct {
> > -		DECLARE_BITMAP(enabled, KVM_MAX_NR_GOVERNED_FEATURES);
> > -	} governed_features;
> > +	u32 cpu_caps[NR_KVM_CPU_CAPS];
> 
> Won't it be better to call this 'effective_cpu_caps' or something like that,
> to put emphasis on the fact that these are not exactly the cpu caps that
> userspace wants.  Although probably any name will still be somewhat
> confusing.

I'd prefer to keep 'cpu_caps' so that the name is aligned with the APIs, e.g. I
think having "effective" in the field but not e.g. guest_cpu_cap_set() would be
even more confusing.

Also, looking at this again, "effective" isn't strictly correct (my comment about
is also wrong), as virtualization holes that neither userspace nor KVM cares about
aren't reflected in CPUID caps.  E.g. things like MOVBE and POPCNT have a CPUID
flag but no way to prevent the guest from using them.

So a truly accurate name would have to be something like
effective_cpu_caps_that_kvm_cares_about.  :-)

> >  	u64 reserved_gpa_bits;
> >  	int maxphyaddr;
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 4f464187b063..4bf3c2d4dc7c 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -327,9 +327,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  	struct kvm_cpuid_entry2 *best;
> >  	bool allow_gbpages;
> >  
> > -	BUILD_BUG_ON(KVM_NR_GOVERNED_FEATURES > KVM_MAX_NR_GOVERNED_FEATURES);
> > -	bitmap_zero(vcpu->arch.governed_features.enabled,
> > -		    KVM_MAX_NR_GOVERNED_FEATURES);
> > +	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
> >  
> >  	/*
> >  	 * If TDP is enabled, let the guest use GBPAGES if they're supported in
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 245416ffa34c..9f18c4395b71 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -255,12 +255,12 @@ static __always_inline bool kvm_is_governed_feature(unsigned int x86_feature)
> >  }
> >  
> >  static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
> > -						     unsigned int x86_feature)
> > +					      unsigned int x86_feature)
> >  {
> > -	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
> > +	unsigned int x86_leaf = __feature_leaf(x86_feature);
> >  
> > -	__set_bit(kvm_governed_feature_index(x86_feature),
> > -		  vcpu->arch.governed_features.enabled);
> > +	reverse_cpuid_check(x86_leaf);
> > +	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
> >  }
> >  
> >  static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
> > @@ -273,10 +273,10 @@ static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
> >  static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
> >  					      unsigned int x86_feature)
> >  {
> > -	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
> > +	unsigned int x86_leaf = __feature_leaf(x86_feature);
> >  
> > -	return test_bit(kvm_governed_feature_index(x86_feature),
> > -			vcpu->arch.governed_features.enabled);
> > +	reverse_cpuid_check(x86_leaf);
> > +	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
> >  }
> 
> It might make sense to think about extracting the common code between
> kvm_cpu_cap* and guest_cpu_cap*.
> 
> The whole notion of reverse cpuid, KVM only leaves, and other nice things
> that it has is already very confusing, but as I understand there is
> no better way of doing it.
> But there must be a way to avoid at least duplicating this logic.

Yeah, that thought crossed my mind too, but de-duplicating the interesting bits
would require macros, which I think would be a net negative for this code.  I
could definitely be convinced otherwise though, I do love me some macros :-)

Something easy I can, should, and will do regardless is to move reverse_cpuid_check()
into __feature_leaf().  It's already in __feature_bit(), and that would cut down
the copy+paste at least a little bit even if we do/don't use macros.

> Also speaking of this logic, it would be nice to document it.
> E.g for 'kvm_only_cpuid_leafs' it would be nice to have an explanation
> for each entry on why it is needed.

As in, which bits KVM cares about?  That's guaranteed to become stale, and the
high level answer is always "because KVM needs it, but the kernel does not".  The
actual bits are kinda sorta documented by KVM_X86_FEATURE() usage, and any
conflicts with the kernel's cpufeatures.h should result in a build error due to
KVM trying to redefined a macro.

> Just curious: I wonder why Intel called them leaves?
> CPUID leaves are just table entries, I don't see any tree there.

LOL, I suppose a tree without branches can still have leaves?
 
> Finally isn't plural of "leaf" is "leaves"?

Heh, yes, "leaves" is the more standar plural form of "leaf".  And looking at the
SDM, "leafs" is used mostly for GETSEC and ENCL{S,U} "leafs".  I spent a lot of
my formative x86 years doing SMX stuff, and then way to much time on SGX, so I
guess "leafs" just stuck with me.
