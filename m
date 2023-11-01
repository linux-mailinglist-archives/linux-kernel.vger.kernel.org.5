Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D257DE655
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjKATTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjKATS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:18:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB3124
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:18:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so123142a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698866335; x=1699471135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYCNgLtP9T+m1wFzy1oumnbf2/vhCmVl2ynmQE81Q6s=;
        b=mMQGm4Gb0AMWF+5Dpd/SDLjuW9kXowdnKpGqK/Xms/F87iabysk5TO7elkYDhINmSj
         kgjs5o9rgwm1Svkh9pBMgt2ZaMotHNI6XVC3sUYV9GAfjwi8/zhr8DA1HPSf/VrxW41t
         Kw9zxU7smIRcm6DjplExMH7ubwws97UV65P2W6oJuHOyqrW0WrvOEED1lySHE/jxvp1p
         DuObOV1/9Veq3yKehJm44t33OSgzOnGTWqBcvGTvfXlPFyeX8nYhbFxboiVgvD/d0mIn
         Dn4SzvBpVsY2jzOMH2u3nM18M0EdGnLSripfMWc2hrbrrIbCCeJqoGrM5HGkutRtxw2d
         eQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698866335; x=1699471135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYCNgLtP9T+m1wFzy1oumnbf2/vhCmVl2ynmQE81Q6s=;
        b=hSlWyayCLk8FkIEHx1RAXTILSnJSgNOFI9tG9/OTIK4hnEDuuYEIlV9DVJ15Jpth8c
         b8Vy84891BSm18/rN9M0AXBcikKDxi+8i7M7VKg6r5f1jL6DTEfS3ZIwnnLu4u51Ca9W
         FBWxsQFA8eF1IDwPZVqmjgQJ/9wLvuSuzL1o1igjkKadWRL4BascTauD+TztUnlrSJRL
         /Dy4O9neifoaJ8A5KuHCf/+Rut7aaZ7bSBgcgMpI9pfldg4Loahv1+VHz7lbcdvM57FV
         I7tK5whSwVpy5Jhn8LobWIkjFA8jvkQMnRWYDbOzVhG/sTiERnugw+mcFU9nD6gbuw3n
         s+xw==
X-Gm-Message-State: AOJu0YwnUrJlYo01Xi+PzYXJZo952IF4kw69VkFPg1BBkhaHvVRnqy0t
        3JIuBiERFL9faGs2RmKFMcyREijbPaQ=
X-Google-Smtp-Source: AGHT+IFf7VebosCxcQV3YrMYYDgLbRkY1zY/Dq16ihBtHMGdVKGRZgR7MAtxcaj4+vwqMVFH2l0p7zXyEDo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:36c2:0:b0:5b9:803b:1fbc with SMTP id
 d185-20020a6336c2000000b005b9803b1fbcmr185420pga.12.1698866335230; Wed, 01
 Nov 2023 12:18:55 -0700 (PDT)
Date:   Wed, 1 Nov 2023 12:18:53 -0700
In-Reply-To: <e10fb116aa67509f7a63660a6b0731e28935c820.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-12-weijiang.yang@intel.com> <e10fb116aa67509f7a63660a6b0731e28935c820.camel@redhat.com>
Message-ID: <ZUKknZ7qEzzQ5Cgi@google.com>
Subject: Re: [PATCH v6 11/25] KVM: x86: Report XSS as to-be-saved if there are
 supported features
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
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

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Add MSR_IA32_XSS to list of MSRs reported to userspace if supported_xss
> > is non-zero, i.e. KVM supports at least one XSS based feature.
> 
> 
> I can't believe that CET is the first supervisor feature that KVM supports...
> 
> Ah, now I understand why:
> 
> 1. XSAVES on AMD can't really be intercepted (other than clearing CR4.OSXSAVE
>    bit, which isn't an option if you want to support AVX for example) On VMX
>    however you can intercept XSAVES and even intercept it only when it touches
>    specific bits of state that you don't want the guest to read/write freely.
> 
> 2. Even if it was possible to intercept it, guests use XSAVES on every
>    context switch if available and emulating it might be costly.
>
> 3. Emulating XSAVES is also not that easy to do correctly.
>
> However XSAVES touches various MSRs, thus letting the guest use it
> unintercepted means giving access to host MSRs, which might be wrong security
> wise in some cases.
>
> Thus I see that KVM hardcodes the IA32_XSS to 0, and that makes the XSAVES
> work exactly like XSAVE.
> 
> And for some features which would benefit from XSAVES state components,
> KVM likely won't even be able to do so due to this limitation.
> (this is allowed thankfully by the CPUID), forcing the guests to use
> rdmsr/wrmsr instead.

Sort of?  KVM doesn't (yet) virtualize PASID, HDC, HWP, or arch LBRs (wow,
there's a lot of stuff getting thrown into XSTATE), so naturally those aren't
supported in XSS.

KVM does virtualize Processor Trace (PT), but PT is a bit of a special snowflake.
E.g. the host kernel elects NOT to manage PT MSRs via XSTATE, but it would be
possible for KVM to the guest to manage PT MSRs via XSTATE.

I suspect the answer to PT is threefold:

 1. Exposing a feature that isn't "supported" by the host kernel is scary.
 2. No one has pushed for the support, e.g. Linux guests obviously don't complain
    about lack of XSS support for PT.
 3. Toggling PT MSR passthrough on XSAVES/XRSTORS accesses would be more complex
    and less performant than KVM's current approach.

Re: #3, KVM does passthrough PT MSRs, but only when the guest is actively using
PT.  PT is basically a super fancy PMU feature, and so KVM "needs" to load guest
state as late as possible before VM-Entry, and load host state as early as possible
after VM-Exit.  I.e. the context switch happens on *every* entry/exit pair.

By passing through PT MSRs only when needed, KVM avoids a rather large pile of
RDMSRs and WRMSRs on every entry/exit, as the host values can be kept resident in
hardware so long as the main enable bit is cleared in the guest's control MSR
(which is context switch via a dedicated VMCS field).

XSAVES isn't subject to MSR intercepts, but KVM could utilize VMX's XSS-exiting
bitmap to effectively intercept reads and writes to PT MSRs.  Except that as you
note, KVM would either need to emulate XSAVES (oof) or save/load PT MSRs much more
frequently.

So it's kind of an emulation thing, but I honestly doubt that emulating XSAVES
was ever seriously considered when KVM support for PT was added.

CET is different than PT because the MSRs that need to be context switched at
every entry/exit have dedicated VMCS fields.  The IA32_PLx_SSP MSRs don't have
VMCS fields, but they are consumed only in privelege level changes, i.e. can be
safely deferred until guest "FPU" state is put.

> However it is possible to enable IA32_XSS bits in case the msrs XSAVES
> reads/writes can't do harm to the host, and then KVM can context switch these
> MSRs when the guest exits and that is what is done here with CET.

This isn't really true.  It's not a safety or correctness issue so much as it's
a performance issue.  E.g. KVM could let the guest use XSS for any virtualized
feature, but it would effectively require context switching related state that
the host needs loaded "immediately" after VM-Exit.  And for MSRs, that gets
very expensive without dedicated VMCS fields.

I mean, yeah, it's a correctness thing to not consume guest state in the host
and vice versa, but that's not unique to XSS in any way.
