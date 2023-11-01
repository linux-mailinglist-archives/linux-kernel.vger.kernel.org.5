Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACB77DE395
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbjKAOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbjKAOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:42:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6518FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:41:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0737dcb26so7162855276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698849717; x=1699454517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vY+whK5XqbSYsbcvwYkxlvLDj7c4sWYoMlLiCl+8FOk=;
        b=LfDKBilu4NrSerjztc1lrZy8phroJv/F2apm3wn0KDjMa59lUkyl1NpYYdI9OvIEOL
         TClkgg2MVEVcDljIhz4wlqODduPTbjuizVIPoH3QQPtd/lSMvjumg8lvM4/Pxa29M+Ae
         zko2FcItwkGq8s9JuKbDRnHa6QAxZ0EVzEE2APspZVCuRY94vFxXYZNmWqzpjryecr0f
         ZnxW6RN7/QIrxuVswW+PWOU1FgonTqVmvrHspdovd7/FYt0t4F8sa3TEtceGlSdrlauA
         x/u8N7Y9K6fR1O/J7ML45OBqHD9dMqd11ZzYo05RWVtONBMCCTQ5H8OGYbJpdDm/DYLW
         TgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849717; x=1699454517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY+whK5XqbSYsbcvwYkxlvLDj7c4sWYoMlLiCl+8FOk=;
        b=LXHyvb0o0T2su+9de8u0zF22SkmhluxdlRVHTNwqwuAp5AmHXTod0fMPnqAw4sXpXZ
         SePnsN0XMFzTem16bwUi6Oj0wrIhtWsTdg3P/ijZc7AXr1WghGmPngGoQgfuWfxjArEw
         QIw/x0iEMX5ehpSQtOyYMl12bbDvA1Si+aFxUh2gujJD0KOi5xgqU3Wtg5QDyLIIa/0T
         DFCyMlpQfvKACJ9XAOySAyaycw94da1xd4uHYE4UiMRtumrOPi8ElzKK+INbRgRiGQtQ
         iE2jmKDaaKDMP7DClmSqkRr2LGAEqftXX9EJePod6VwRjXDLQpbbxPdHkEHGPIMkGwoB
         8KwA==
X-Gm-Message-State: AOJu0YydlxywFP/S2P/aTdw5Ja4cqo5LdRB0nG6WE9PEx3JEL7J0ETuS
        I4v5yTF5RiLkYtVJl/KeC58O1QaBDcM=
X-Google-Smtp-Source: AGHT+IGOo/h7yYknoNxH9zuetv1Jm66TgYYqm36QaUrElC5TUX1EIZWIQhjKSSLNgDJc5UoA6/jD+vUPb8Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:549:b0:da3:b96c:6c48 with SMTP id
 z9-20020a056902054900b00da3b96c6c48mr39857ybs.9.1698849717105; Wed, 01 Nov
 2023 07:41:57 -0700 (PDT)
Date:   Wed, 1 Nov 2023 07:41:55 -0700
In-Reply-To: <96c30a78fa95071e87045b7293c2cf796d4182a0.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-10-weijiang.yang@intel.com> <96c30a78fa95071e87045b7293c2cf796d4182a0.camel@redhat.com>
Message-ID: <ZUJjs2F-vD1-cZS4@google.com>
Subject: Re: [PATCH v6 09/25] KVM: x86: Rework cpuid_get_supported_xcr0() to
 operate on vCPU data
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU
> > state, i.e. on a vCPU's CPUID state.  Prior to commit 275a87244ec8 ("KVM:
> > x86: Don't adjust guest's CPUID.0x12.1 (allowed SGX enclave XFRM)"), KVM
> > incorrectly fudged guest CPUID at runtime,
> Can you explain how commit 275a87244ec8 relates to this patch?
>
> > which in turn necessitated massaging the incoming CPUID state for
> > KVM_SET_CPUID{2} so as not to run afoul of kvm_cpuid_check_equal().
> 
> Can you link the commit that added this 'massaging' and explain on how this
> relates to this patch?

It's commit 275a87244ec8, which is right above.  I think the missing part is an
explicit call out that the massaging used cpuid_get_supported_xcr0() with the
incoming "struct kvm_cpuid_entry2", i.e. without a "struct kvm_vcpu".

> Can you explain what is the problem that this patch is trying to solve?

Is this better?

--
Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU
state, i.e. on a vCPU's CPUID state, now that the only usage of the helper
is to retrieve a vCPU's already-set CPUID.

Prior to commit 275a87244ec8 ("KVM: x86: Don't adjust guest's CPUID.0x12.1
(allowed SGX enclave XFRM)"), KVM incorrectly fudged guest CPUID at
runtime, which in turn necessitated massaging the incoming CPUID state for
KVM_SET_CPUID{2} so as not to run afoul of kvm_cpuid_check_equal().  I.e.
KVM also invoked cpuid_get_supported_xcr0() with the incoming CPUID state,
and thus without an explicit vCPU object.
--

> Is it really allowed in x86 spec to have different supported mask of XCR0 bits
> on different CPUs (assuming all CPUs of the same type)?

Yes, nothing in the SDM explicitly states that all cores in have identical feature
sets.  And "assuming all CPUs of the same type" isn't really a valid constraint
because it's very doable to put different SKUs into a multi-socket system.

Intel even (somewhat inadvertantly) kinda sorta shipped such CPUs, as Alder Lake
P-cores support AVX512 but E-cores do not, and IIRC early (pre-production?) BIOS
didn't disable AVX512 on the P-Cores, i.e. software could observe cores with and
without AVX512.  That quickly got fixed because it confused software, but until
Intel squashed AVX512 entirely with a microcode update, disabling E-Cores in BIOS
would effectively enable AVX512 on the remaining P-Cores.

And it's not XCR0-related, but PMUs on Alder Lake (and all Intel hybrid CPUs) are
truly heterogenous.  It's a mess for virtualization, but concrete proof that there
are no architectural guarantees regarding homogeneity of feature sets.

> If true, does KVM supports it?

Yes.  Whether or not that's a good thing is definitely debatle, bug KVM's ABI for
a very long time has allowed userspace to expose whatever it wants via KVM_SET_CPUID.

Getting (guest) software to play nice is an entirely different matter, but exposing
heterogenous vCPUs isn't an architectural violation.
