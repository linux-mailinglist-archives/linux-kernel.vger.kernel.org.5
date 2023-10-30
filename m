Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7597DC30A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjJ3XR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3XRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:17:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA9E8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:17:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c5708ddbeso4913395276.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698707872; x=1699312672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Csx+TsEcocBEQ6kz2m3CofW0FivmcdzPkNL/+8GkZMU=;
        b=wulmNnMEVs3z1tDVSYYaowkPOqPUAn0OwUr0Yxt0sNaGoWkFzIS5lxPZsuZTFxmzqz
         K3k0qwnP4rd0aFYKs+dSrkrCkaacN0asJ9V56YnPOXvkt5ior2H2ik4wM9SBvFBn9NVt
         0DV9a5aefavweNuYu/yfkIH8hLgoBBMDTDUb79Gzvzfu7TowIU2Ese6EwlEEYufCjz5o
         ou/V2xRPnTIacxCxE9hBkPaeifWvMZWG8R+k5DajFwO7+XScAzAQdu2nUuxxmAPSlqML
         4USw3SHoBdA4IxouKgvqvBqdhA5HEJGJNbEKMTPBrdn9s0EKu0NniVjx6cRZ/D9sLwLV
         gFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707872; x=1699312672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Csx+TsEcocBEQ6kz2m3CofW0FivmcdzPkNL/+8GkZMU=;
        b=lxPxp+eyw+9unvmojeeV1dscpbljDJVBUn/VVKCy6KwjOOuvBOZF7RyKRGQ2DDOkDY
         LQEIsBh7o+3wCsNeoHfv9Yks9cvkuetMHdSh3v7ZcPLBsNbWQi354jtZRUVZv2fKLtt9
         t23hyDWwkE3NvvQ8w1p0+J52b1WL0JH4Gc0SUc+Ffx+H6/Mg6KyNDZZ0BEUTW6tK+ceO
         MDHT1kHzCwi3MzNvEi7Dg/8wk6f+s9etfSQillJYF4dMS4/ueHLCtEwuouolRpZvc1Q0
         do+Z8a3eAYnrwFDwefVDV2Eon9wumUBipSdkeZDmwxG1vGye0jpKbKt2hJwAXMnVlTQz
         SEIw==
X-Gm-Message-State: AOJu0Yxlz0Mj/lROKJM9N6VF0h2VMmt2WMjMoJ3K6VqfCrYNIi0fLxi9
        +yehPnVF987QOzu8S4YnEt+5sCPBu3w=
X-Google-Smtp-Source: AGHT+IHcWu2teE0w4erdqneJsvHZS2M1ee6fdESgDAEOW+IWBnZCh53mWv/aUqxFdZ3MsAoLbwB56oaCH0o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aa04:0:b0:d9c:2a58:b905 with SMTP id
 s4-20020a25aa04000000b00d9c2a58b905mr210703ybi.9.1698707872051; Mon, 30 Oct
 2023 16:17:52 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:17:50 -0700
In-Reply-To: <47c9a8f1-0098-4543-ac98-e210ca6b0d34@intel.com>
Mime-Version: 1.0
References: <20231025055914.1201792-1-xiaoyao.li@intel.com>
 <20231025055914.1201792-2-xiaoyao.li@intel.com> <87a5s73w53.fsf@redhat.com>
 <ZTkkmgs_oCnDCGvd@google.com> <47c9a8f1-0098-4543-ac98-e210ca6b0d34@intel.com>
Message-ID: <ZUA5nnAV3CxOX9lB@google.com>
Subject: Re: [PATCH v2 1/2] x86/kvm/async_pf: Use separate percpu variable to
 track the enabling of asyncpf
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Oct 30, 2023, Xiaoyao Li wrote:
> On 10/25/2023 10:22 PM, Sean Christopherson wrote:
> > On Wed, Oct 25, 2023, Vitaly Kuznetsov wrote:
> > > Xiaoyao Li <xiaoyao.li@intel.com> writes:
> > > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > > index b8ab9ee5896c..388a3fdd3cad 100644
> > > > --- a/arch/x86/kernel/kvm.c
> > > > +++ b/arch/x86/kernel/kvm.c
> > > > @@ -65,6 +65,7 @@ static int __init parse_no_stealacc(char *arg)
> > > >   early_param("no-steal-acc", parse_no_stealacc);
> > > > +static DEFINE_PER_CPU_READ_MOSTLY(bool, async_pf_enabled);
> > > 
> > > Would it make a difference is we replace this with a cpumask? I realize
> > > that we need to access it on all CPUs from hotpaths but this mask will
> > > rarely change so maybe there's no real perfomance hit?
> > 
> > FWIW, I personally prefer per-CPU booleans from a readability perspective.  I
> > doubt there is a meaningful performance difference for a bitmap vs. individual
> > booleans, the check is already gated by a static key, i.e. kernels that are NOT
> > running as KVM guests don't care.
> 
> I agree with it.
> 
> > Actually, if there's performance gains to be had, optimizing kvm_read_and_reset_apf_flags()
> > to read the "enabled" flag if and only if it's necessary is a more likely candidate.
> > Assuming the host isn't being malicious/stupid, then apf_reason.flags will be '0'
> > if PV async #PFs are disabled.  The only question is whether or not apf_reason.flags
> > is predictable enough for the CPU.
> > 
> > Aha!  In practice, the CPU already needs to resolve a branch based on apf_reason.flags,
> > it's just "hidden" up in __kvm_handle_async_pf().
> > 
> > If we really want to micro-optimize, provide an __always_inline inner helper so
> > that __kvm_handle_async_pf() doesn't need to make a CALL just to read the flags.
> > Then in the common case where a #PF isn't due to the host swapping out a page,
> > the paravirt happy path doesn't need a taken branch and never reads the enabled
> > variable.  E.g. the below generates:
> 
> If this is wanted. It can be a separate patch, irrelevant with this series,
> I think.

Yes, it's definitely beyond the scope of this series.
