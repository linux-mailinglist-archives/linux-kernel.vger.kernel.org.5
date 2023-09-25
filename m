Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7537AE0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjIYV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjIYV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:28:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697AB11B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:28:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1d352a86dso20352597b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695677302; x=1696282102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gduy8ABBWRcIZ6Nsk8bBDlRqu/MEicJSudL4Sfih2Ds=;
        b=C7ensMbe9mQG6kdqSlIuCX6z+QWIjBJt9BCclgLqOF5ibWXFgO6dT9M20Kuz3dWM65
         Fl2gGaF39fHJALOuC86Q+vjwZmJOpRbw0v0Ol1CMZt6GbAxezCgZWbfwM/vSOGWP1+ZE
         hvYYOvy6HcHQhWZah6QupkAnT9+XKHD/Arfy5TTY6HeqZZLp7rx6cQaa1SbMHx/CkkMN
         bl3DCTr1F59UKUPBc7f62D4zDCsc7/fy4YVNUS5TR76jBb8ZLzEzCRu49hCkBfQvZf2m
         eNOUAElab//HOB9Iyis4E7dyya20cRM8wNagPmQSD2FMbtwur5ehM3ywGWfayoj/QdUz
         jcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695677302; x=1696282102;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gduy8ABBWRcIZ6Nsk8bBDlRqu/MEicJSudL4Sfih2Ds=;
        b=UC8u/lXgiG6wpw6y35NTmHM26iv78Ey1s8s4kJQjEvp+M0HkcNQTAO+/P57S7dWrIk
         fPo5qR45NC5T0zr1m/yUASBkFZW6XRCJyjXJA/RjlJ+aVIs9IPZuyWhNJe5D2FbuFzro
         Pivca+lR8CIfdQWjvv15HI+dET5KxbXaazdJS2GPGMfFfViOZtc8NSDhuKohrF2XnQEV
         NghaAJMfPb4/j9h6rFFUbWZ+BOb2mqAqTcjEGk8ci2kDTkl/jrJZhOW9++PT4gry/vEJ
         8Qygm6vEfqQY9v39C7zW6TijrE8f8jXdM18jPowjvW4n+qOSaqMHtmaPKXJElnibHMn1
         HU7Q==
X-Gm-Message-State: AOJu0YyC6kiJLISTJqcZ/dt2ZRmJVoLOo/ci0M7Ezudhx9yb+1e6eqq5
        k8hk8L1knH0LPR9nVGGKLcFi96Fu2V0=
X-Google-Smtp-Source: AGHT+IEOxdH0jzy8O+dLcLi/qH6f0AEbzXT0DlDHzirh2t6UTMGO4/yY906GPDmQ4qPLsSt/49ThzdIADnA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac56:0:b0:59b:ee27:bbe8 with SMTP id
 z22-20020a81ac56000000b0059bee27bbe8mr91467ywj.7.1695677302634; Mon, 25 Sep
 2023 14:28:22 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:28:21 -0700
In-Reply-To: <CAL715WJgFg=c0-nT6n8Gy=wxh39MyKa7r04oDi-bwHCiNy=9JQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230925173448.3518223-1-mizhang@google.com> <20230925173448.3518223-2-mizhang@google.com>
 <ZRHKcW6hvujNIYS5@google.com> <CAL715WJgFg=c0-nT6n8Gy=wxh39MyKa7r04oDi-bwHCiNy=9JQ@mail.gmail.com>
Message-ID: <ZRH7dQmVCKOPh3uh@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Synthesize at most one PMI per VM-exit
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023, Mingwei Zhang wrote:
> On Mon, Sep 25, 2023 at 10:59=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Mon, Sep 25, 2023, Mingwei Zhang wrote:
> > > From: Jim Mattson <jmattson@google.com>
> > >
> > > When the irq_work callback, kvm_pmi_trigger_fn(), is invoked during a
> > > VM-exit that also invokes __kvm_perf_overflow() as a result of
> > > instruction emulation, kvm_pmu_deliver_pmi() will be called twice
> > > before the next VM-entry.
> > >
> > > That shouldn't be a problem. The local APIC is supposed to
> > > automatically set the mask flag in LVTPC when it handles a PMI, so th=
e
> > > second PMI should be inhibited. However, KVM's local APIC emulation
> > > fails to set the mask flag in LVTPC when it handles a PMI, so two PMI=
s
> > > are delivered via the local APIC. In the common case, where LVTPC is
> > > configured to deliver an NMI, the first NMI is vectored through the
> > > guest IDT, and the second one is held pending. When the NMI handler
> > > returns, the second NMI is vectored through the IDT. For Linux guests=
,
> > > this results in the "dazed and confused" spurious NMI message.
> > >
> > > Though the obvious fix is to set the mask flag in LVTPC when handling
> > > a PMI, KVM's logic around synthesizing a PMI is unnecessarily
> > > convoluted.
> >
> > Unless Jim outright objects, I strongly prefer placing this patch secon=
d, with
> > the above two paragraphs replaced with my suggestion (or something simi=
lar):
> >
> >   Calling kvm_pmu_deliver_pmi() twice is unlikely to be problematic now=
 that
> >   KVM sets the LVTPC mask bit when delivering a PMI.  But using IRQ wor=
k to
> >   trigger the PMI is still broken, albeit very theoretically.
> >
> >   E.g. if the self-IPI to trigger IRQ work is be delayed long enough fo=
r the
> >   vCPU to be migrated to a different pCPU, then it's possible for
> >   kvm_pmi_trigger_fn() to race with the kvm_pmu_deliver_pmi() from
> >   KVM_REQ_PMI and still generate two PMIs.
> >
> >   KVM could set the mask bit using an atomic operation, but that'd just=
 be
> >   piling on unnecessary code to workaround what is effectively a hack. =
 The
> >   *only* reason KVM uses IRQ work is to ensure the PMI is treated as a =
wake
> >   event, e.g. if the vCPU just executed HLT.
> >
> > I understand Jim's desire for the patch to be more obviously valuable, =
but the
> > people that need convincing are already convinced that the patch is wor=
th taking.
> >
> > > Remove the irq_work callback for synthesizing a PMI, and all of the
> > > logic for invoking it. Instead, to prevent a vcpu from leaving C0 wit=
h
> > > a PMI pending, add a check for KVM_REQ_PMI to kvm_vcpu_has_events().
> > >
> > > Fixes: 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructio=
ns")
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > Tested-by: Mingwei Zhang <mizhang@google.com>
> > > Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >
> > Needs your SoB
>=20
> Signed-off-by: Mingwei Zhang <mizhang@google.com>

Thanks!

Jim gave his blessing off-list for swapping the order, I'll do that and mas=
sage
the changelogs when applying, i.e. no need for a v3.
