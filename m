Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC276798B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjIHRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjIHRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:44:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8B1FC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:44:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68a3de043b7so3153061b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195050; x=1694799850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8BaUmZq1KIIbHh6jQ/eqkqlx2kpzlXIs+ljmWToQkE=;
        b=JAiRdSm/YbCb/bAyLp3YDKgz/+n1Mi1fQCuLdwLABm0Agz9WLdHuyeHH1ZMXBIirdm
         894V9YLWLzK6vtxoYB7MY369XVfpFaQOMJgvqyV7hdLA3Q3GAcbi1Ht16Q8dC9csoo9V
         HR/5JOMfj3t61C/WfUQVzBNDk43Lo6QY98vAFO5dFs9AzO+6a5iY9TXIagATtKrUulaC
         tcOIEasjlNLroJSZtPl1blqZaiwh+yATMri2X7QjTr04c5zzJFdwISvSZydk1JnkHHt7
         aDdWgBsyLhtb45ZMe/qEVcUU18DzTyNxbXuJoAWhV+X1kMDOfoKSIdYgL+roEx8oq5g7
         elbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195050; x=1694799850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8BaUmZq1KIIbHh6jQ/eqkqlx2kpzlXIs+ljmWToQkE=;
        b=SXVJy3HsU5Y+kiUhKD+nfEDohxXlWZRXJxHoaoVdd7Hs+J247ik9jAMF9Mh/ykSQ5t
         WAN6VP3/E7gXxcmOPbOJBU1Ua+E2qktWFd1vD0UqdglhbJcdlAFDl3s7j5oqA7h5sUCc
         g6qxs/tuIq0UtlKdu6rhTp6yYSedxgTJ2UPgqS0LcIPCTrE4Dd6yf9/Evl9zoftHwG2P
         COMptLLCU8LXccZB3chAA3nR3gcberdTfHUMAYwabE7VntF6S5Kddi3aFKz7RMFjKNrR
         Eb6fHoyPkpyClve0SjLWh1qjRxr5M/G4XmxGw+L2KS/zo2CTZRcaGkjugjzLuY4Cqpud
         s9ww==
X-Gm-Message-State: AOJu0YzvkgwsbTJt6Pg2RSEhzOkI2Y81RHuKw2XDXDSnqZG5o5iFXilW
        7NTUzbfAcrtK17zF/QdnkUoTbBlZGGA=
X-Google-Smtp-Source: AGHT+IFHcKRM//BDjQJBST0CslAfnpkDkEg1Kau6x3HdIGdGYKw85V55n+UquHcEQj37wS07LPFWB7bfLlI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:cc3:b0:68a:3762:72c3 with SMTP id
 b3-20020a056a000cc300b0068a376272c3mr1214187pfv.0.1694195050076; Fri, 08 Sep
 2023 10:44:10 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:44:08 -0700
In-Reply-To: <87v8cns3ex.fsf@redhat.com>
Mime-Version: 1.0
References: <20230815153537.113861-1-kyle.meyer@hpe.com> <ZNuxtU7kxnv1L88H@google.com>
 <87v8cns3ex.fsf@redhat.com>
Message-ID: <ZPtdaN/CuLyBPPuu@google.com>
Subject: Re: [PATCH] KVM: x86: Increase KVM_MAX_VCPUS to 4096
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hasen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmatlack@google.com, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Aug 15, 2023, Kyle Meyer wrote:
> >> Increase KVM_MAX_VCPUS to 4096 when MAXSMP is enabled.
> >> 
> >> Notable changes (when MAXSMP is enabled):
> >> 
> >> * KMV_MAX_VCPUS will increase from 1024 to 4096.
> >> * KVM_MAX_VCPU_IDS will increase from 4096 to 16384.
> >> * KVM_HV_MAX_SPARSE_VCPU_SET_BITS will increase from 16 to 64.
> >> * CPUID[HYPERV_CPUID_IMPLEMENT_LIMITS (0x40000005)].EAX will now be 4096.
> >> 
> >> * struct kvm will increase from 39408 B to 39792 B.
> >> * struct kvm_ioapic will increase from 5240 B to 19064 B.
> >> 
> >> * The following (on-stack) bitmaps will increase from 128 B to 512 B:
> >> 	* dest_vcpu_bitmap in kvm_irq_delivery_to_apic.
> >> 	* vcpu_mask in kvm_hv_flush_tlb.
> >> 	* vcpu_bitmap in ioapic_write_indirect.
> >> 	* vp_bitmap in sparse_set_to_vcpu_mask.
> >> 
> >> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> >> ---
> >> Virtual machines with 4096 virtual CPUs have been created on 32 socket
> >> Cascade Lake and Sapphire Rapids systems.
> >> 
> >> 4096 is the current maximum value because of the Hyper-V TLFS. See
> >> BUILD_BUG_ON in arch/x86/kvm/hyperv.c, commit 79661c3, and Vitaly's
> >> comment on https://lore.kernel.org/all/87r136shcc.fsf@redhat.com.
> >
> > Mostly out of curiosity, do you care about Hyper-V support?   If not, at some
> > point it'd probably be worth exploring a CONFIG_KVM_HYPERV option to allow
> > disabling KVM's Hyper-V support at compile time so that we're not bound by the
> > restrictions of the TLFS.
> >
> 
> (sorry for necroposting)

There's a big difference between mostly dead and all dead.  Mostly dead is slightly
alive. ;-)

> While adding CONFIG_KVM_HYPERV to disable all-things-Hyper-V may make
> sense for some deployments (and as we already have CONFIG_KVM_XEN), I
> don't think we should forbid KVM_MAX_VCPUS > 4096 when it is enabled:
> 'general purpose' (distro) kernels are used both for hosting large Linux
> guests and Windows guests. Instead, I'd suggest we define
> KVM_MAX_HV_VCPUS as MIN(KVM_MAX_VCPUS, 4096) and then e.g. fail
> KVM_SET_CPUID[,2] if we already have > 4096 vCPUs + fail
> kvm_arch_vcpu_create() if we already have something-hyperv enabled on
> the already created vCPUs.

Ah, bummer.  I'd still like to add CONFIG_KVM_HYPERV at some point, but I agree
it should be orthogonal to KVM_MAX_VCPUS.
