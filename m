Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D17D39C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjJWOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJWOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6A19A3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56f75e70190so1764782a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698072052; x=1698676852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOIO+H7vBCJRfyqao5vTRDK/ZnUXqp5753SeNzy629c=;
        b=icPSHz+UroMs95NxI4XfLTvL65qkzFMyB76dWy3dX7FOfk3GeCmT3+tlFRpq2ALk0B
         QQ2isgkhaL0kdWIlxrQ/9JzlXpfArq2tQlzMhOYN2KJRc1FfEMc+CthNH5BsZWDRVh70
         d0qfTJQv71x5Zpi1ppXjrTMFbqFQ9c+//sDxqh0BNrCVmf1S7REZJ598uQ9/rjXrNCbC
         HgB4vPsH8F4yB9y2A1E3QiFezAXVyYzyXPtuXY5AwSICpUJfmwG/bsEOLxTcHx7pLv5o
         DqP8f5onetS06vqym3kjlmotfIesRYyQJp4wrHLIVrDGKept/baSWzMMJxruB0WNe3J6
         PhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072052; x=1698676852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOIO+H7vBCJRfyqao5vTRDK/ZnUXqp5753SeNzy629c=;
        b=Flldu+ZocTaI1+/qdrR/ertuXpu/zNtli+tK8axfarqXnJM+SJYmHaM3qZfu5Zd8bF
         h7TbmMzH2cMDFwGHQZQHGedMhsPFn+v55M+NhrAc0H1nc0RGFgpCmeLos7OtckTb70qv
         mPOxw/x/DT/6vvjeOUBcu3G2v2h6SOyemZ5FR/SAqQX08W3ZNc7+54P2wMQMUuCduZcU
         y46ZqMCflmn2pepTI7G4nQyGPJq8x2R3CsMlPeW0fky1MtaNt+zvpfQW1VwAjy7CVn9A
         A1jkRHhex3x/0bpCTEO6jKTpW5rXYIs0G8oZXw1HFWzESaMZPlse2PSbNmTenhKCEpmC
         gwUQ==
X-Gm-Message-State: AOJu0YylD3fWQydCaIcpUUg1OINRR/PeEGvqwYtWBv6JrMpJTwGbhnZe
        ZEPJQZOGL/1X9YfKia+2IGIareGjxZI=
X-Google-Smtp-Source: AGHT+IExAuTTDvPv+uDKpzbze6eiqwdc7PLWiowzJWFsT1Fls/h45TIz/DhVhP8uEFt0TqXIZLj2MgO8bn8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e551:0:b0:584:dd94:24c1 with SMTP id
 z17-20020a63e551000000b00584dd9424c1mr155269pgj.11.1698072052492; Mon, 23 Oct
 2023 07:40:52 -0700 (PDT)
Date:   Mon, 23 Oct 2023 07:40:50 -0700
In-Reply-To: <87r0ll4thx.fsf@redhat.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com> <87wmvh47zb.fsf@redhat.com>
 <ZTKg9XMxeBQ36f5L@google.com> <87r0ll4thx.fsf@redhat.com>
Message-ID: <ZTaF8n9WM5BQ3rYS@google.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
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

On Mon, Oct 23, 2023, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
> >> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> >> index b8ab9ee5896c..1ee49c98e70a 100644
> >> --- a/arch/x86/kernel/kvm.c
> >> +++ b/arch/x86/kernel/kvm.c
> >> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
> >>         kvm_pv_disable_apf();
> >>         if (!shutdown)
> >>                 apf_task_wake_all();
> >> -       kvmclock_disable();
> >> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
> >> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
> >> +               kvmclock_disable();
> >>  }
> >
> > That would result in an unnecessray WRMSR in the case where kvmclock is disabled
> > on the command line.  It _should_ be benign given how the code is written, but
> > it's not impossible to imagine a scenario where someone disabled kvmclock in the
> > guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
> > MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
> > kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
> > kvmclock_disable().
> 
> True but we don't have such module params to disable other PV features so
> e.g. KVM_FEATURE_PV_EOI/KVM_FEATURE_MIGRATION_CONTROL are written to
> unconditionally. Wouldn't it be better to handle parameters like
> 'no-kvmclock' by clearing the feature bit in kvm_arch_para_features()'s
> return value so all kvm_para_has_feature() calls for it just return
> 'false'? We can even do an umbreall "no-kvm-features=<mask>" to cover
> all possible debug cases.

I don't know that it's worth the effort, or that it'd even be a net positive.

Today, kvm_para_has_feature() goes through to CPUID every time, e.g. we'd have
to add a small bit of infrastructure to snapshot and clear bits, or rework things
to let kvm_para_has_feature peek at kvmclock.

And things like KVM_FEATURE_PV_TLB_FLUSH would be quite weird, e.g. we either end
up leaving the feature bit set while returning "false" for pv_tlb_flush_supported(),
or we'd clear the feature bit for a rather large number of conditions that don't
really have anything to do with KVM_FEATURE_PV_TLB_FLUSH being available.

  static bool pv_tlb_flush_supported(void)
  {
	return (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
		!boot_cpu_has(X86_FEATURE_MWAIT) &&
		(num_possible_cpus() != 1));
  }
