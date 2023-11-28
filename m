Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478D7FAF34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjK1Ann (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1Anl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:43:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46411B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:43:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb92becbf6so73101927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701132227; x=1701737027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtTNWHQr6JsZpzzdQO0pOMuuw3cl8zP4tz9k1AzI5bE=;
        b=GWBB4P9euSf2PsqBgmptV/iKxCZAc0B6rN4VZE2kxSEKpeqXCXZGLkzx0A2rXO+wIO
         WsWPXw+Q1aGQqVParwqKkhAdlHKh/RJu0Q8IQzCypugJASVoE/L2l5womAft5DQ9BFI/
         EcesBjCL36ES7czM00JNO0AdLMUQACkLsViiZ1KW+rvZMHWHSIgHn7Cp+v5wtEMQTkgg
         hMZmtAAhDUPPzJbgyFlyXkI5xyTO70E1LnRLASmn1W1HxGsQPXEwdqJBKBsJ6DMSuC2k
         kpsu18S6UnKGAEl+N29jQCnheaJjBCLnsNEbvcklqjg/AsZfiBFH1+mMVNATAZwz9hWL
         AO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701132227; x=1701737027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtTNWHQr6JsZpzzdQO0pOMuuw3cl8zP4tz9k1AzI5bE=;
        b=E+aoGNT0r+S6viMCs+z+xVhMEhTLLd2tcBEtFTGepEa4NfA9KR0NmF2zLfEYDddMOJ
         6ykVHJ1t1jjokNCXERWIA+n+WZ7jXxg5crga3SgkiC9gGwluB4ndAsFFvKdTjCkF5WDo
         bnWRMvY0mob7P3g9DO9zhWaGM8eLkBFyCuLE2IChQBpB+pA0cmmwo3/pWyekMxwvYFCG
         DKh42hMPv88eUrIsbJsL9Zc5UjRvK3dD1+cEX3DpATwN1Vz8SRecLhCtaJBBa8AANVsF
         PJywDXYJY7VX3iVfMl72AnUlrGaovBFY3nC2yt7my130G1lFCyJjEDY1zo4cs/XFxqc2
         sDpA==
X-Gm-Message-State: AOJu0YwJgx7DxU2WAMLp0MFKnoRJXsPqmrbIT2btUEeYhHkAbGhx4udW
        Xo41Iutu8HJmmIOOLZegX9jr7PyMlbk=
X-Google-Smtp-Source: AGHT+IESjIQv6/ICyS8yn8B9IgsMw0DggQwsK7hRc4UEvPR3TCet9e6B3QXr+ibINHgZvZ05JzvqN9k3GGM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fcd:b0:5ca:fea0:a798 with SMTP id
 dg13-20020a05690c0fcd00b005cafea0a798mr585155ywb.6.1701132226944; Mon, 27 Nov
 2023 16:43:46 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:43:45 -0800
In-Reply-To: <ZWBDsOJpdi7hWaYV@yilunxu-OptiPlex-7050>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com> <20231110235528.1561679-7-seanjc@google.com>
 <4484647425e2dbf92c76a173b7b14e346f60362d.camel@redhat.com> <ZWBDsOJpdi7hWaYV@yilunxu-OptiPlex-7050>
Message-ID: <ZWU3wTElmiEOUg-I@google.com>
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From:   Sean Christopherson <seanjc@google.com>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Nov 24, 2023, Xu Yilun wrote:
> On Sun, Nov 19, 2023 at 07:35:30PM +0200, Maxim Levitsky wrote:
> > On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> > >  static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
> > >  				       int nent)
> > >  {
> > >  	struct kvm_cpuid_entry2 *best;
> > > +	struct kvm_vcpu *caps = vcpu;
> > > +
> > > +	/*
> > > +	 * Don't update vCPU capabilities if KVM is updating CPUID entries that
> > > +	 * are coming in from userspace!
> > > +	 */
> > > +	if (entries != vcpu->arch.cpuid_entries)
> > > +		caps = NULL;
> > 
> > I think that this should be decided by the caller. Just a boolean will suffice.

I strongly disagree.  The _only_ time the caps should be updated is if
entries == vcpu->arch.cpuid_entries, and if entries == cpuid_entires than the caps
should _always_ be updated.

> kvm_set_cpuid() calls this function only to validate/adjust the temporary
> "entries" variable. While kvm_update_cpuid_runtime() calls it to do system
> level changes.
> 
> So I kind of agree to make the caller fully awared, how about adding a
> newly named wrapper for kvm_set_cpuid(), like:
> 
> 
>   static void kvm_adjust_cpuid_entry(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
> 				     int nent)
> 
>   {
> 	WARN_ON(entries == vcpu->arch.cpuid_entries);
> 	__kvm_update_cpuid_runtime(vcpu, entries, nent);

But taking it a step further, we end up with

	WARN_ON_ONCE(update_caps != (entries == vcpu->arch.cpuid_entries));

which is silly since any bugs that would result in the WARN firing can be avoided
by doing:

	update_caps = entries == vcpu->arch.cpuid_entries;

which eventually distils down to the code I posted.

> > Or even better: since the userspace CPUID update is really not important in
> > terms of performance, why to special case it? 
> > 
> > Even if these guest caps are later overwritten, I don't see why we need to
> > avoid updating them, and in fact introduce a small risk of them not being
> > consistent
> 
> IIUC, for kvm_set_cpuid() case, KVM may then fail the userspace cpuid setting,
> so we can't change guest caps at this phase.

> Or even better: since the userspace CPUID update is really not important in
> terms of performance, why to special case it? 

Yep, and sadly __kvm_update_cpuid_runtime() *must* be invoked before kvm_set_cpuid()
is guaranteed to succeed because the whole point is to massage guest CPUID before
checking for divergences.

> > With this we can avoid having the 'cap' variable which is *very* confusing as well.

I agree the "caps" variable is confusing, but it's the least awful option I see.
The alternatives I can think of are:

  1. Update a dummy caps array
  2. Take a snapshot of the caps and restore them
  3. Have separate paths for updated guest CPUID versus guest caps

#1 would require passing a "u32 *" to guest_cpu_cap_change() (or an equivalent),
which I really, really don't want to do.  It' also a waste of cycles, and I'm
skeptical that it would be any less confusing than the proposed code.

#2 increases the complexity of kvm_set_cpuid() by introducing recovery paths, i.e.
adds more things that can break, and again is wasteful (though copying ~100 bytes
or so in a slow path isn't a big deal).

#3 would create unnecessary maintenance burden as we'd have to ensure any changes
hit both paths.
