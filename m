Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50CF78157E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjHRWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjHRWpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:45:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922064215
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:44:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589a89598ecso17489747b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692398699; x=1693003499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0yIaLrfprkYOudGbsE5ssGGGSQHn95w53fiIFwE4ps=;
        b=hWw9AbKzdxPQvghrM+Gde/ZZ0ptrm4kwXQe0yfMCekQOx01RZK/qOnO2HocOon1lHt
         u2OyE7GQ1n+MAr3VaNsnPPUdsDsxzYJspDSks8KX1sfZ7shAr3a29kRXirszojblnq/V
         UB+gP5sHdYMGsessvmlRZQ1WooZ91IsMsO+v2UySUXsw+QUSRkbw0/tmxdHGR4QLsWOA
         GcK8kJBSlIPbePEyz0zujaWgq98AdBoQfWEnyorO9Tbmg65mDLr8sNt79LVsYlXhXvfG
         ERLCSA0OovmXlcuU9082R9AoDFgZAwxwD/Y+y5Q4G2Po3gyE6rluAC1LTVpH0bBiFs62
         CGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692398699; x=1693003499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0yIaLrfprkYOudGbsE5ssGGGSQHn95w53fiIFwE4ps=;
        b=feQaQej5Wt1jAzVKnHdiaCJxCUvX+S5KIMSFOfpF3Aqj8zMo7KT5hYEf/fwGGtubz4
         epWaz8uyjnZ6+AcnBk+HE16NQFmZ2VmfDn6PNt9svCBPIYs3RqxHKWez5Ja+HhpaQrXa
         JxinGcjBYD7UgV4EieoimR8veGM2LLtSktxB3rFRX2ymSy4wz31fOKjiJ3xAjmIg0pok
         cmmcCPnKoxU79xcchxO+iJK/LKNQYfD2XmOiiwTbuiilUjTYB38RLTC0V6tvfGpN4ik+
         JQBAQCYeviTCSGJJviLDCoVQATW8YYuG5RGE8IyZn4JwUnVhBSonWuMSGAubIGfJ8l42
         HUPQ==
X-Gm-Message-State: AOJu0YwFBeUB143qUPA18aQZWtnaluSRWLwttMGX0EJwggQxgMUsJfTC
        oR/di05Pbbfa8DYafsZExbNeBowBasc=
X-Google-Smtp-Source: AGHT+IEaJZvHkdOPE3MxKuwc1z8+0s4BKNu0HXRVPvzaGNsRdvJOmeFduY0mAdxUCpm4bP8O3LFPDR6fanY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:440c:0:b0:565:9bee:22e0 with SMTP id
 r12-20020a81440c000000b005659bee22e0mr6650ywa.0.1692398698818; Fri, 18 Aug
 2023 15:44:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 15:44:57 -0700
In-Reply-To: <52c6a8a6-3a0a-83ba-173d-0833e16b64fd@amd.com>
Mime-Version: 1.0
References: <cover.1692119201.git.isaku.yamahata@intel.com>
 <b37fb13a9aeb8683d5fdd5351cdc5034639eb2bb.1692119201.git.isaku.yamahata@intel.com>
 <ZN+whX3/lSBcZKUj@google.com> <52c6a8a6-3a0a-83ba-173d-0833e16b64fd@amd.com>
Message-ID: <ZN/0aefp2gw5wDXk@google.com>
Subject: Re: [PATCH 4/8] KVM: gmem: protect kvm_mmu_invalidate_end()
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Quentin Perret <qperret@google.com>, wei.w.wang@intel.com,
        Fuad Tabba <tabba@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mingwei to correct me if I'm wrong

On Fri, Aug 18, 2023, Ashish Kalra wrote:
> 
> On 8/18/2023 12:55 PM, Sean Christopherson wrote:
> > On Tue, Aug 15, 2023, isaku.yamahata@intel.com wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > 
> > > kvm_mmu_invalidate_end() updates struct kvm::mmu_invalidate_in_progress
> > > and it's protected by kvm::mmu_lock.  call kvm_mmu_invalidate_end() before
> > > unlocking it. Not after the unlock.
> > > 
> > > Fixes: 8e9009ca6d14 ("KVM: Introduce per-page memory attributes")
> > 
> > This fixes is wrong.  It won't matter in the long run, but it makes my life that
> > much harder.
> > 
> > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > ---
> > >   virt/kvm/kvm_main.c | 15 ++++++++++++++-
> > >   1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 8bfeb615fc4d..49380cd62367 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -535,6 +535,7 @@ struct kvm_mmu_notifier_range {
> > >   	} arg;
> > >   	gfn_handler_t handler;
> > >   	on_lock_fn_t on_lock;
> > > +	on_unlock_fn_t before_unlock;
> > >   	on_unlock_fn_t on_unlock;
> > 
> > Ugh, shame on my past me.  Having on_lock and on_unlock be asymmetrical with respect
> > to the lock is nasty.
> > 
> > I would much rather we either (a) be explicit, e.g. before_(un)lock and after_(un)lock,
> > or (b) have just on_(un)lock, make them symetrical, and handle the SEV mess a
> > different way.
> > 
> > The SEV hook doesn't actually care about running immediately after unlock, it just
> > wants to know if there was an overlapping memslot.  It can run after SRCU is dropped,
> > because even if we make the behavior more precise (right now it blasts WBINVD),
> > just having a reference to memslots isn't sufficient, the code needs to guarantee
> > memslots are *stable*.  And that is already guaranteed by the notifier code, i.e.
> > the SEV code could just reacquire SRCU.
> 
> On a separate note here, the SEV hook blasting WBINVD is still causing
> serious performance degradation issues with SNP triggered via
> AutoNUMA/numad/KSM, etc. With reference to previous discussions related to
> it, we have plans to replace WBINVD with CLFLUSHOPT.

Isn't the flush unnecessary when freeing shared memory?  My recollection is that
the problematic scenario is when encrypted memory is freed back to the host,
because KVM already flushes when potentially encrypted mapping memory into the
guest.

With SNP+guest_memfd, private/encrypted memory should be unreachabled via the
hva-based mmu_notifiers.  gmem should have full control of the page lifecycles,
i.e. can get the kernel virtual address as appropriated, and so it SNP shouldn't
need the nuclear option.

E.g. something like this?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 07756b7348ae..1c6828ae391d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2328,7 +2328,7 @@ static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
 
 void sev_guest_memory_reclaimed(struct kvm *kvm)
 {
-       if (!sev_guest(kvm))
+       if (!sev_guest(kvm) || sev_snp_guest(kvm))
                return;
 
        wbinvd_on_all_cpus();
