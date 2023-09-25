Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1988D7ADF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjIYTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjIYTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:34:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04580107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:34:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b179b9baeso10010256d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695670463; x=1696275263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fmgf2gQ/swm4Nxw1H65fys4tXrr/aZSzb+qRx0CMW0=;
        b=Msr0c0tPb26iAavkBmsWxmIgflapT8QmH8VFR1U5eUtXKZUJ/5Qn9A96wbOv0jmJXK
         FzxTnUKdHbG9/gJDZsRXRD3tcLFtHRCq7TPJ+3rqsMfCnp+jKbBKzGSOCtyrQAtc8CSr
         VDImr/PBkxuMty5lgzLyx/oMUQbVcm+4IRTW0ynEg/WmDx4V5447bIpygwPjW3SqRojK
         YHjG+dCK/FTSbvkz47L0xSjucGR67nbsyuUMVqdv+tbFXDfOAmvzPKoH6ufwegyvJpyN
         0l0heGnaLhpGPuvJjBdL5EdLM9qmKBQN6A5zh062JnLWyYHTClYGPTathVAHS3oC192E
         ONlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695670463; x=1696275263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fmgf2gQ/swm4Nxw1H65fys4tXrr/aZSzb+qRx0CMW0=;
        b=R2L+4UmF2XGxrAZBPvqTdGX8HWKIkrlXrYaibPlLr/YHpv3rc0cPVWAD/YXHsHXkyz
         PvXEKWsmoQ9AbwR0oUEt6nZ5u9ZrQEn/OaqYmJLqcAQBND3mblOzreSX09O2/vnCj3PI
         Cdcsvws3prbnmDG7rgmYHCdz23vJZ0+qLc8jiPe4M+dSaDRPc/0MKkiUhrc48uEz8Vni
         zx6YHzx6XlNVg23KHCniuaACz6b5EeNCOUP6OX43D8jd5lOrUFM0MjOIhsmoyo3T8jnt
         PEV0cFbFf/1oz5Lu1fZZQXxHCJH0d63jL1Z97I1EYuI0ikvna3xPcJvBjAwgnK7SAGbh
         g5SQ==
X-Gm-Message-State: AOJu0Yy2lYDEwIz+08b6gWj9d5Y1NFyk/0viX1CKYO/4txpHhk4pOVWw
        vjot4kdY/mWwUVlI5xWBWi3SBoY6aqGaGL+cuoVzUQ==
X-Google-Smtp-Source: AGHT+IFy77IozmuzoIETfXqPTevBy12STCpp81ZoYY5O0nwBH+8t6d4No22oMNKw4YFBbp6qBgZcO4peb4w3MQLO1lo=
X-Received: by 2002:a0c:cc03:0:b0:65b:21f2:5573 with SMTP id
 r3-20020a0ccc03000000b0065b21f25573mr746644qvk.58.1695670462945; Mon, 25 Sep
 2023 12:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230925173448.3518223-1-mizhang@google.com> <20230925173448.3518223-2-mizhang@google.com>
 <ZRHKcW6hvujNIYS5@google.com>
In-Reply-To: <ZRHKcW6hvujNIYS5@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 25 Sep 2023 12:33:47 -0700
Message-ID: <CAL715WJgFg=c0-nT6n8Gy=wxh39MyKa7r04oDi-bwHCiNy=9JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Synthesize at most one PMI per VM-exit
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:59=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Sep 25, 2023, Mingwei Zhang wrote:
> > From: Jim Mattson <jmattson@google.com>
> >
> > When the irq_work callback, kvm_pmi_trigger_fn(), is invoked during a
> > VM-exit that also invokes __kvm_perf_overflow() as a result of
> > instruction emulation, kvm_pmu_deliver_pmi() will be called twice
> > before the next VM-entry.
> >
> > That shouldn't be a problem. The local APIC is supposed to
> > automatically set the mask flag in LVTPC when it handles a PMI, so the
> > second PMI should be inhibited. However, KVM's local APIC emulation
> > fails to set the mask flag in LVTPC when it handles a PMI, so two PMIs
> > are delivered via the local APIC. In the common case, where LVTPC is
> > configured to deliver an NMI, the first NMI is vectored through the
> > guest IDT, and the second one is held pending. When the NMI handler
> > returns, the second NMI is vectored through the IDT. For Linux guests,
> > this results in the "dazed and confused" spurious NMI message.
> >
> > Though the obvious fix is to set the mask flag in LVTPC when handling
> > a PMI, KVM's logic around synthesizing a PMI is unnecessarily
> > convoluted.
>
> Unless Jim outright objects, I strongly prefer placing this patch second,=
 with
> the above two paragraphs replaced with my suggestion (or something simila=
r):
>
>   Calling kvm_pmu_deliver_pmi() twice is unlikely to be problematic now t=
hat
>   KVM sets the LVTPC mask bit when delivering a PMI.  But using IRQ work =
to
>   trigger the PMI is still broken, albeit very theoretically.
>
>   E.g. if the self-IPI to trigger IRQ work is be delayed long enough for =
the
>   vCPU to be migrated to a different pCPU, then it's possible for
>   kvm_pmi_trigger_fn() to race with the kvm_pmu_deliver_pmi() from
>   KVM_REQ_PMI and still generate two PMIs.
>
>   KVM could set the mask bit using an atomic operation, but that'd just b=
e
>   piling on unnecessary code to workaround what is effectively a hack.  T=
he
>   *only* reason KVM uses IRQ work is to ensure the PMI is treated as a wa=
ke
>   event, e.g. if the vCPU just executed HLT.
>
> I understand Jim's desire for the patch to be more obviously valuable, bu=
t the
> people that need convincing are already convinced that the patch is worth=
 taking.
>
> > Remove the irq_work callback for synthesizing a PMI, and all of the
> > logic for invoking it. Instead, to prevent a vcpu from leaving C0 with
> > a PMI pending, add a check for KVM_REQ_PMI to kvm_vcpu_has_events().
> >
> > Fixes: 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions=
")
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > Tested-by: Mingwei Zhang <mizhang@google.com>
> > Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Needs your SoB

Signed-off-by: Mingwei Zhang <mizhang@google.com>
