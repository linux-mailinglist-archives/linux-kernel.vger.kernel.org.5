Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E27E75CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjKJASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbjKJAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:17:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099725B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:17:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so17740a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699575475; x=1700180275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7AINGqD+uDcyCkNAuvVhFQmI+fmLnwrj5VTd+39JmM=;
        b=d6U7dGrhdVKm3vluVOlW4tjLENLDM9DxAksFjh1MLjLYARi5EnMQ1DA4RYMB0y9pSh
         /rJ5REA5IOYCnqpmIrkJS+s1h6mNYdS/5QYhiEZcf0pu1OZgGysR7oAHZEuRL4Bf071k
         sTtUek3xFuDt0FWgdjjJ4nTwGXa7u6ouAeKWwLj3NoGzHHMK+Bybg0ocgo9I75Eq3vGi
         8W/dx8pigk2V+skY77uI3RXN66HBdoq/6shwsSWsl22Gh/5CXCVwAnbrisEWwuv4mVhZ
         cOUEqYaFItFiW46OUfyrUutjC4BMN7krCBBMo/1mTy8QzH/5aX+Q/jy9fv8pzp4/wAQi
         PVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575475; x=1700180275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7AINGqD+uDcyCkNAuvVhFQmI+fmLnwrj5VTd+39JmM=;
        b=YwmvJvgsTp7SRMSV9YEsZjLpix/2iDrz2ESGt2FI78CCq6N3NxzSo2BeawDNnrTVrS
         WjmYtn9qcUnHBdCV/CdPgRAM53dydepDCOfWfIItL+w5SyssnY49BSJO2aobx3U2t5SR
         FmJZPTFBDt898yP8TpVYAgbQhhFzLcKV77kBtjP/QuFD1UO/Icp2yWEJ0H4an0p+yYbI
         vohOGbsvT7mIJuZy7T64yBvHxnI//dvjqZCbAjFEe4Ga0r3Lo7qaPWK1ki+PaQPFB9bU
         MnqRcezTp2KZK98ciY+CfnQDL6GhTFxukdCCyL7bd46dfehY1KKv7xSJwYJJBi2qti/R
         0Ktw==
X-Gm-Message-State: AOJu0Yzz3yV3fagvD45HoavQ2LRxSCM36qmDPyfMPNwJCxYIx6/s7I7n
        G4j2N0O4unQW26I24mrYbJCLZzRukx0l/0q38Sz1lA==
X-Google-Smtp-Source: AGHT+IESBd3cjsgylAurSqxlZheyZNpWVoWe6LpJQP2lCpStZcRcvuTY5HGrez1TCDbrh4u/T6jREH2S+kHpCTq7UXk=
X-Received: by 2002:a05:6402:3709:b0:544:4762:608 with SMTP id
 ek9-20020a056402370900b0054447620608mr262760edb.2.1699575475098; Thu, 09 Nov
 2023 16:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
 <CALMp9eQGqqo66fQGwFJMc3y+9XdUrL7ageE8kvoAOV6NJGfJpw@mail.gmail.com> <ZU1ua1mHDZFTmkHX@google.com>
In-Reply-To: <ZU1ua1mHDZFTmkHX@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Nov 2023 16:17:40 -0800
Message-ID: <CALMp9eTqdg32KGh38wQYW-fvyrjrc7VQAsA1wnHhoCn-tLwyYg@mail.gmail.com>
Subject: Re: [PATCH 0/1] KVM: x86/vPMU: Speed up vmexit for AMD Zen 4 CPUs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 3:42=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Nov 09, 2023, Jim Mattson wrote:
> > On Thu, Nov 9, 2023 at 10:24=E2=80=AFAM Konstantin Khorenko
> > <khorenko@virtuozzo.com> wrote:
> > >
> > > We have detected significant performance drop of our atomic test whic=
h
> > > checks the rate of CPUID instructions rate inside an L1 VM on an AMD
> > > node.
> > >
> > > Investigation led to 2 mainstream patches which have introduced extra
> > > events accounting:
> > >
> > >    018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instruc=
tions")
> > >    9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
> > >
> > > And on an AMD Zen 3 CPU that resulted in immediate 43% drop in the CP=
UID
> > > rate.
> > >
> > > Checking latest mainsteam kernel the performance difference is much l=
ess
> > > but still quite noticeable: 13.4% and shows up on AMD CPUs only.
> > >
> > > Looks like iteration over all PMCs in kvm_pmu_trigger_event() is chea=
p
> > > on Intel and expensive on AMD CPUs.
> > >
> > > So the idea behind this patch is to skip iterations over PMCs at all =
in
> > > case PMU is disabled for a VM completely or PMU is enabled for a VM, =
but
> > > there are no active PMCs at all.
> >
> > A better solution may be to maintain two bitmaps of general purpose
> > counters that need to be incremented, one for instructions retired and
> > one for branch instructions retired. Set or clear these bits whenever
> > the PerfEvtSelN MSRs are written. I think I would keep the PGC bits
> > separate, on those microarchitectures that support PGC. Then,
> > kvm_pmu_trigger_event() need only consult the appropriate bitmap (or
> > the logical and of that bitmap with PGC). In most cases, the value
> > will be zero, and the function can simply return.
> >
> > This would work even for AMD microarchitectures that don't support PGC.
>
> Yeah.  There are multiple lower-hanging fruits to be picked though, most =
of which
> won't conflict with using dedicated per-event bitmaps, or at worst are tr=
ivial
> to resolve.
>
>  1. Don't call into perf to get the eventsel (which generates an indirect=
 call)
>     on every invocation, let alone every iteration.
>
>  2. Avoid getting the CPL when it's irrelevant.
>
>  3. Check the eventsel before querying the event filter.
>
>  4. Mask out PMCs that aren't globally enabled from the get-go (masking o=
ut
>     PMCs based on eventsel would essentially be the same as per-event bit=
maps).

The code below only looks at PGC. Even on CPUs that support PGC, some
PMU clients still use the enable bits in the PerfEvtSelN. Linux perf,
for instance, can't seem to make up its mind whether to use PGC or
PerfEvtSelN.EN.

> I'm definitely not opposed to per-event bitmaps, but it'd be nice to avoi=
d them,
> e.g. if we can eke out 99% of the performance just by doing a few obvious
> optimizations.
>
> This is the end result of what I'm testing and will (hopefully) post shor=
tly:
>
> static inline bool pmc_is_eventsel_match(struct kvm_pmc *pmc, u64 eventse=
l)
> {
>         return !((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB);
> }

The top nybble of AMD's 3-nybble event select collides with Intel's
IN_TX and IN_TXCP bits. I think we can assert that the vCPU can't be
in a transaction if KVM is emulating an instruction, but this probably
merits a comment. The function name should also be more descriptive,
so that it doesn't get misused out of context. :)

> static inline bool cpl_is_matched(struct kvm_pmc *pmc)
> {
>         bool select_os, select_user;
>         u64 config;
>
>         if (pmc_is_gp(pmc)) {
>                 config =3D pmc->eventsel;
>                 select_os =3D config & ARCH_PERFMON_EVENTSEL_OS;
>                 select_user =3D config & ARCH_PERFMON_EVENTSEL_USR;
>         } else {
>                 config =3D fixed_ctrl_field(pmc_to_pmu(pmc)->fixed_ctr_ct=
rl,
>                                           pmc->idx - KVM_FIXED_PMC_BASE_I=
DX);
>                 select_os =3D config & 0x1;
>                 select_user =3D config & 0x2;
>         }
>
>         /*
>          * Skip the CPL lookup, which isn't free on Intel, if the result =
will
>          * be the same regardless of the CPL.
>          */
>         if (select_os =3D=3D select_user)
>                 return select_os;
>
>         return (static_call(kvm_x86_get_cpl)(pmc->vcpu) =3D=3D 0) ? selec=
t_os : select_user;
> }
>
> void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
> {
>         DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>         struct kvm_pmc *pmc;
>         int i;
>
>         BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE !=3D X86_PM=
C_IDX_MAX);
>
>         if (!kvm_pmu_has_perf_global_ctrl(pmu))
>                 bitmap_copy(bitmap, pmu->all_valid_pmc_idx, X86_PMC_IDX_M=
AX);
>         else if (!bitmap_and(bitmap, pmu->all_valid_pmc_idx,
>                              (unsigned long *)&pmu->global_ctrl, X86_PMC_=
IDX_MAX))
>                 return;
>
>         kvm_for_each_pmc(pmu, pmc, i, bitmap) {
>                 /* Ignore checks for edge detect, pin control, invert and=
 CMASK bits */
>                 if (!pmc_is_eventsel_match(pmc, eventsel) ||
>                     !pmc_event_is_allowed(pmc) || !cpl_is_matched(pmc))
>                         continue;
>
>                 kvm_pmu_incr_counter(pmc);
>         }
> }
