Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14C7E5E13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjKHTDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjKHTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:02:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E8384F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:01:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1482a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699470069; x=1700074869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJZpA9CDSK+45MhiTVPDXFQjZA8yRQfl63XxmQ2VvEE=;
        b=F8Puvzy/oNZBo4w+pCyMsJEL6rLpqWRP0MT5lJNyuO3gX5YaaKFFj4uRlY6l8cO9AH
         FcIpmNUUH8yo4GICBJa6bryeyhYM78QAq0028kvGFGZORNpJS5qOovOXhJY4tpji8dg7
         E8r+4eK7FlDJtyO/fbo4fb6IXFxxAVVvDnXal9NuQ4L4FvjYQqu1Z7uN4lAsxRtaWC5/
         n66ljk7rMOuIZaHK6GVn0Rm3oJIHzRhj7DtHTMxe+Vy4eu/ovAsTwbXfKSrOI9t717QD
         EXpW0cHVEnxs39P78pdJ5uUbu5H6h4qFd50lMy4Qv/KFdeA/mURepNJpUSPyCwpsMXtp
         wGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470069; x=1700074869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJZpA9CDSK+45MhiTVPDXFQjZA8yRQfl63XxmQ2VvEE=;
        b=UP6vUOvIP8RVP87r8g8+suaM3ryr+7NF7v9mt7qkfgX/57WWEZrt8kwpS4R9314uQS
         8jR8PKnZpF1cobsgTScu2BRfgHNGObBNplpOhv0Q2q5Pqbe2vEJVDsf7IV5MqGd6TMKy
         c2eE+iT5InS7I1P/A0G2F2Xy8+oaZFvqIPqlGKTRauSVWR+xsBOGdc0FweiQKQ+2fhTM
         IqhpHEa4n0dyZJacjyP6y6mKmbblq2d093lqmPU30jjQkMM2SG4jXuGXuQCoCye6NOz5
         dBXxFRDYRBoa6peBGjlal3obLU1tjukj+/7YLkHNv1ZC0uZpqO9ZH3aF3KaGnWy8s0Th
         /NZA==
X-Gm-Message-State: AOJu0YzEp507rUCjcpN/ZMJZlh+aT/sb3jSYXYwSJ7MQmIU/sOWQE8qW
        QAxzGPso0iQmaGUWs+z7aF9qRxSGoLkPgM8oUkyxxg==
X-Google-Smtp-Source: AGHT+IHaGxwjDjRLguAoxgQyYzJ0shkMop8/hxiYJ4ds/RwpcujkxajDth7+cZfkYdPmPiwKPyLwZwZ99rXTDiL7WJE=
X-Received: by 2002:aa7:c996:0:b0:544:e249:be8f with SMTP id
 c22-20020aa7c996000000b00544e249be8fmr7879edt.1.1699470069134; Wed, 08 Nov
 2023 11:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-5-seanjc@google.com>
 <CALMp9eRcBi19yGS3+t+Hm0fLSB5+ESDGAygjwE_CYs-jWtU9Cg@mail.gmail.com> <ZUudoEyqtf5ZPtPp@google.com>
In-Reply-To: <ZUudoEyqtf5ZPtPp@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Nov 2023 11:00:53 -0800
Message-ID: <CALMp9eR5hb3Z6n4kTiciKg0ZgNYpaFSKErE3vKnCFUExUERTWw@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] KVM: x86/pmu: Setup fixed counters' eventsel
 during PMU initialization
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 6:39=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Nov 07, 2023, Jim Mattson wrote:
> > On Tue, Nov 7, 2023 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > Set the eventsel for all fixed counters during PMU initialization, th=
e
> > > eventsel is hardcoded and consumed if and only if the counter is supp=
orted,
> > > i.e. there is no reason to redo the setup every time the PMU is refre=
shed.
> > >
> > > Configuring all KVM-supported fixed counter also eliminates a potenti=
al
> > > pitfall if/when KVM supports discontiguous fixed counters, in which c=
ase
> > > configuring only nr_arch_fixed_counters will be insufficient (ignorin=
g the
> > > fact that KVM will need many other changes to support discontiguous f=
ixed
> > > counters).
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_inte=
l.c
> > > index c4f2c6a268e7..5fc5a62af428 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -409,7 +409,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcp=
u, struct msr_data *msr_info)
> > >   * Note, reference cycles is counted using a perf-defined "psuedo-en=
coding",
> > >   * as there is no architectural general purpose encoding for referen=
ce cycles.
> > >   */
> > > -static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
> > > +static u64 intel_get_fixed_pmc_eventsel(int index)
> > >  {
> > >         const struct {
> > >                 u8 eventsel;
> > > @@ -419,17 +419,11 @@ static void setup_fixed_pmc_eventsel(struct kvm=
_pmu *pmu)
> > >                 [1] =3D { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_=
CPU_CYCLES. */
> > >                 [2] =3D { 0x00, 0x03 }, /* Reference Cycles / PERF_CO=
UNT_HW_REF_CPU_CYCLES*/
> > >         };
> > > -       int i;
> > >
> > >         BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) !=3D KVM_PMC_MAX_FI=
XED);
> > >
> > > -       for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
> > > -               int index =3D array_index_nospec(i, KVM_PMC_MAX_FIXED=
);
> > > -               struct kvm_pmc *pmc =3D &pmu->fixed_counters[index];
> > > -
> > > -               pmc->eventsel =3D (fixed_pmc_events[index].unit_mask =
<< 8) |
> > > -                                fixed_pmc_events[index].eventsel;
> > > -       }
> > > +       return (fixed_pmc_events[index].unit_mask << 8) |
> > > +               fixed_pmc_events[index].eventsel;
> >
> > Can I just say that it's really confusing that the value returned by
> > intel_get_fixed_pmc_eventsel() is the concatenation of an 8-bit "unit
> > mask" and an 8-bit "eventsel"?
>
> Heh, blame the SDM for having an "event select" field in "event select" M=
SRs.
>
> Is this better?
>
>         const struct {
>                 u8 event;
>                 u8 unit_mask;
>         } fixed_pmc_events[] =3D {
>                 [0] =3D { 0xc0, 0x00 }, /* Instruction Retired / PERF_COU=
NT_HW_INSTRUCTIONS. */
>                 [1] =3D { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_=
CYCLES. */
>                 [2] =3D { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_=
HW_REF_CPU_CYCLES*/
>         };

Better. Thank you.
