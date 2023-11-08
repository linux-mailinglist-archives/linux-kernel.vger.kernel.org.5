Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7077E5950
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjKHOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjKHOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:39:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECD1FCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:39:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so6597697b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699454369; x=1700059169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJbNnPajjokoZi+trDlI5nj+dX/8FMyM+8HOHunxhb4=;
        b=o2wC9CqeJsDHSdQ5E0CbB9gWiu1J3UYfKeoxt6uvTIUOxlz6PqMN+4ysTWK/SYHJSV
         FENAaVnZnydB66/A/KeQ5Y6YzwRBX1xop76a35dZrqhj4zAUOUUZLEStKq0hlzVqfyYx
         NvGwxHnCAv/jVdB11jid9jzyE6ydq9x2rj1MuQrfOOPVb5s7R61k7+tDF1Qrd1f6maoN
         Z7Pz3Pe+FFQzb/DIWO4Vx/MQwYQGFQ1JI9ltTi4s3vSBtTB+JMDXZO9Dmyl6FxlBxim7
         MuSaOMsYWbRcBUyOzoWXUFdklqAYl1DTN6S/DT5eI9Cwktq3h+yAjLf1he2q9RBhI2Kq
         5DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454369; x=1700059169;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJbNnPajjokoZi+trDlI5nj+dX/8FMyM+8HOHunxhb4=;
        b=EZxE+f1ttVjspYkHrwF9zKlwA2UcO4DyXmrXcIL50iLzYnurO8Z3CAj5DOQVJT2GT8
         hbIeoxScT5u+WYkrhIsCB8aWMVMYAUQUzfSUU1LwN6PpofrVIPKmYrflOtu8F/0FOuXl
         QvOVSjRhEOJuzghLWei1VGFPHFbVoItLzKM8uHMOO6mwlxd2Ai5l/R/JqnYkSLYsb+0v
         rMADObYsbRDr3ygp+/Cb8WYpy1kZzV86FR2DSTpbkW4l+H4oINW1yoCHi8m9ssPO9Nq1
         OBp7znkXdJi3x556mDAlZfcW2y2XuLbhMbpMOZTsfEQ85k6MwflVabTcL+QSXVjay7My
         oFTQ==
X-Gm-Message-State: AOJu0YwT831EBC2RmWl0eF/qct3/pR5kag8t+bbb1s38+xCfjx+UBk/2
        8RqTLZMQkY5W7eGi4OwsvdX/PLacpgI=
X-Google-Smtp-Source: AGHT+IEGOUAM6lrblcS31XPUoikg+vPg8XVBrcbYRDe8dMIFcTXwqPSRn4QNRed/6pKUIjZ9T95v5jnE62o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:93:b0:5be:baac:54e4 with SMTP id
 be19-20020a05690c009300b005bebaac54e4mr37620ywb.5.1699454369670; Wed, 08 Nov
 2023 06:39:29 -0800 (PST)
Date:   Wed, 8 Nov 2023 06:39:28 -0800
In-Reply-To: <CALMp9eRcBi19yGS3+t+Hm0fLSB5+ESDGAygjwE_CYs-jWtU9Cg@mail.gmail.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-5-seanjc@google.com>
 <CALMp9eRcBi19yGS3+t+Hm0fLSB5+ESDGAygjwE_CYs-jWtU9Cg@mail.gmail.com>
Message-ID: <ZUudoEyqtf5ZPtPp@google.com>
Subject: Re: [PATCH v7 04/19] KVM: x86/pmu: Setup fixed counters' eventsel
 during PMU initialization
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Jim Mattson wrote:
> On Tue, Nov 7, 2023 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Set the eventsel for all fixed counters during PMU initialization, the
> > eventsel is hardcoded and consumed if and only if the counter is suppor=
ted,
> > i.e. there is no reason to redo the setup every time the PMU is refresh=
ed.
> >
> > Configuring all KVM-supported fixed counter also eliminates a potential
> > pitfall if/when KVM supports discontiguous fixed counters, in which cas=
e
> > configuring only nr_arch_fixed_counters will be insufficient (ignoring =
the
> > fact that KVM will need many other changes to support discontiguous fix=
ed
> > counters).
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.=
c
> > index c4f2c6a268e7..5fc5a62af428 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -409,7 +409,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu,=
 struct msr_data *msr_info)
> >   * Note, reference cycles is counted using a perf-defined "psuedo-enco=
ding",
> >   * as there is no architectural general purpose encoding for reference=
 cycles.
> >   */
> > -static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
> > +static u64 intel_get_fixed_pmc_eventsel(int index)
> >  {
> >         const struct {
> >                 u8 eventsel;
> > @@ -419,17 +419,11 @@ static void setup_fixed_pmc_eventsel(struct kvm_p=
mu *pmu)
> >                 [1] =3D { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CP=
U_CYCLES. */
> >                 [2] =3D { 0x00, 0x03 }, /* Reference Cycles / PERF_COUN=
T_HW_REF_CPU_CYCLES*/
> >         };
> > -       int i;
> >
> >         BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) !=3D KVM_PMC_MAX_FIXE=
D);
> >
> > -       for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
> > -               int index =3D array_index_nospec(i, KVM_PMC_MAX_FIXED);
> > -               struct kvm_pmc *pmc =3D &pmu->fixed_counters[index];
> > -
> > -               pmc->eventsel =3D (fixed_pmc_events[index].unit_mask <<=
 8) |
> > -                                fixed_pmc_events[index].eventsel;
> > -       }
> > +       return (fixed_pmc_events[index].unit_mask << 8) |
> > +               fixed_pmc_events[index].eventsel;
>=20
> Can I just say that it's really confusing that the value returned by
> intel_get_fixed_pmc_eventsel() is the concatenation of an 8-bit "unit
> mask" and an 8-bit "eventsel"?

Heh, blame the SDM for having an "event select" field in "event select" MSR=
s.

Is this better?

	const struct {
		u8 event;
		u8 unit_mask;
	} fixed_pmc_events[] =3D {
		[0] =3D { 0xc0, 0x00 }, /* Instruction Retired / PERF_COUNT_HW_INSTRUCTIO=
NS. */
		[1] =3D { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_CYCLES. */
		[2] =3D { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_HW_REF_CPU_CYCLE=
S*/
	};

	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) !=3D KVM_PMC_MAX_FIXED);

	return (fixed_pmc_events[index].unit_mask << 8) |
		fixed_pmc_events[index].event;


Or are you complaining about the fact that they're split at all?  I'm open =
to any
format, though I personally found the seperate umask and event values helpf=
ul
when trying to understand what's going on.
