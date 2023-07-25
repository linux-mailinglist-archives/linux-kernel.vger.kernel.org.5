Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23FA761DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGYPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjGYPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:53:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37C211F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:53:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58378ae25bfso69450627b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690300401; x=1690905201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Scueap2IZpdX9UCxn1uYzjWNK2BxMuQi6j4Q/ANLPdI=;
        b=gGWLslz3j9CuQ5hanKDPJnXuxJ+NhdMEVZm6GQOlauPYsyeglUfFrXgOCxLUZyN9Wd
         YtKYPrJmHXRPvugJw2Fn8YCh6MnDV8jzdWP9AWOIsIyAlX8YDdD5kCIfwVSkhF8mjUT9
         5MLvRFN8zQoCcChukIaoUq5H2EtGkty9mSKihqM2Yh6ClolGDPFwNy5DhUBFhB/RscPJ
         /tvXepVSOMBMO6G9GdJ/M2Z3LrfsMHObbqOH0nElV2uTHe6eN/bjICPiyEz6OfQ7SUM/
         jIY5/gQ6hb1g9e9O1hhy1PmvFatJulxXYvyQdcjdbWlgm5b3YwT2PnWn1fLz7PJL7/Mr
         aqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300401; x=1690905201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Scueap2IZpdX9UCxn1uYzjWNK2BxMuQi6j4Q/ANLPdI=;
        b=YRs3g6QQ79Qjx2wf2HOUvhCSibYw5GZDduy+kRny/qpPZyk8nbSRgFAlL21VNFGRrQ
         APaY0adfpB2JITnZN162MrD6O6nviMMJiFZpd+m6hN0FAYTUE51qH9YcKCwERhoYWAtB
         dddgWRPXsv0TKcZMx58b6ogmF18iGkAowUtKceY/EdHZ3dvKyc1oPSCzCEtnNDmTFIIU
         0kjBH6STSALnW4vjJM/N2w2hsgKpAGpwQEyWDa1QUmghbDMRVpEKO4zNlz8x1Atyg+Vb
         mtHYgkb4xJ/VbHeTsFO5RbMGADEtBfaIOAPGbTnb6Bd7XTktUFc5xz+aQksa/60GJyY1
         O/7g==
X-Gm-Message-State: ABy/qLb/v8whHDKLMy+78GnvldPNB/v+FB9kNioOOdD8IVODVRsj1zHw
        TuZVAh1XXHN2X+GJqBNHrVnf6HSqZxs=
X-Google-Smtp-Source: APBJJlGu8xDz4xF7wXNqoN3D0fucjT9BY/aT/Rr+ORbZIfzNXsJr16w4uu3GLJN8e8roFrKS/P9sxV8fvvc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3402:0:b0:d1a:4d0e:c11c with SMTP id
 b2-20020a253402000000b00d1a4d0ec11cmr6834yba.11.1690300401143; Tue, 25 Jul
 2023 08:53:21 -0700 (PDT)
Date:   Tue, 25 Jul 2023 08:53:19 -0700
In-Reply-To: <20230725113628.z7vzxk5g6zdqlftg@linux.intel.com>
Mime-Version: 1.0
References: <20230722012350.2371049-1-seanjc@google.com> <20230722012350.2371049-6-seanjc@google.com>
 <20230725113628.z7vzxk5g6zdqlftg@linux.intel.com>
Message-ID: <ZL/v7xDEllr5rU6W@google.com>
Subject: Re: [PATCH 5/5] KVM: x86/mmu: Use dummy root, backed by zero page,
 for !visible guest roots
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>
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

On Tue, Jul 25, 2023, Yu Zhang wrote:
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > index 122bfc0124d3..e9d4d7b66111 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -646,6 +646,17 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
> >  		goto out_gpte_changed;
> >  
> > +	/*
> > +	 * Load a new root and retry the faulting instruction in the extremely
> > +	 * unlikely scenario that the guest root gfn became visible between
> > +	 * loading a dummy root and handling the resulting page fault, e.g. if
> > +	 * userspace create a memslot in the interim.
> > +	 */
> > +	if (unlikely(kvm_mmu_is_dummy_root(vcpu->arch.mmu->root.hpa))) {
> > +		kvm_mmu_unload(vcpu);
> 
> Do we really need a kvm_mmu_unload()? Could we just set
> vcpu->arch.mmu->root.hpa to INVALID_PAGE here?

Oof, yeah.  Not only is a full unload overkill, if this code were hit it would
lead to deadlock because kvm_mmu_free_roots() expects to be called *without*
mmu_lock held.

Hmm, but I don't love the idea of open coding a free/reset of the current root.
I'm leaning toward

		kvm_make_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu);

since it's conceptually similar to KVM unloading roots when a memslot is deleted
or moved, just reversed.  That would obviously tie this code to KVM's handling of
the dummy root just as much as manually invalidating root.hpa (probably more so),
but that might actually be a good thing because then the rule for the dummy root
is that it's always considered obsolete (when checked), and that could be
explicitly documented in is_obsolete_root().
