Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6922580DD47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjLKVdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbjLKVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:33:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778D710E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:33:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso959a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702330425; x=1702935225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX1Wg/mW222hGnVKsBmQT/O39fFEc/bGrsBIuqYGAfk=;
        b=vOYCnctuQc9LLVQrGdohewlBDupxI+Bq/so9cC0p/M3+ompdeyTicvMkwhg3tC8mDK
         KiucCEWOKzslulBnPb73EMu30aIE2HfeR5OeGmEKE3w+TRTWIXPNhjA2sDyN3XpIsPfn
         M3NR3pUhxsM6+VdrYEGwOpAsAVbZMSAxlMKMT8a57MmgzOXgB40wzU0Eu+Du+qsdUGJV
         Av/JwwpNCfBRZQi8dVigjARYAgeWyKbSiIqZY4NIuMnaxrEFQ64oEsm86Io5avsdn3qZ
         1riG43e5QjHCvS668RC7dvjfS6/W/a/QPYqI/l6q5oRBSqE8uuzEZFRzcrPnbUTu9yXO
         TUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330425; x=1702935225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX1Wg/mW222hGnVKsBmQT/O39fFEc/bGrsBIuqYGAfk=;
        b=unLZPq/Mx/BtTbNgV3bgz3DEOoV4IKJ5PyUs+1uu0we47REWPNMVOwlqCkb2U/Q5Pg
         2YXTlT1EzlDeuiSOz30aflBzqZs7Zva5Hv4rnnvIL4Z/WmAjWPrCMn4D4lBb+DbkxWyY
         UV4VzaJ0fHir+6pKxDxYMbfU6DTStEd+rqneiqiguzY6iSIRXuWFvMvObCrBOq5opXnv
         QfejuBniFVyu9PVqCtpQXufX3W4y9ku9PPG0m3gS0FwfyR4EJUdR3vW9GfUPkF3Pgx/B
         2SO2HWImpKB8+RoDrsPAn6+wI35JEqiRNCWCsYWvLJmsJ+8AG9eCQ4Abye4GaOAzziA2
         maTg==
X-Gm-Message-State: AOJu0Yy46uP5Apo3BLgROadrAYO1U/vzo+cuYdVpB/cpD6lTvPM/AfNY
        MIa8+K78tUPh37h65jbS0kz0q5UR0aBKADFhpyaJlA==
X-Google-Smtp-Source: AGHT+IFxUR+AniAakqZJs6LHOZ5HHncY1lSRn0n7ycwr2O3ucSipTIDQ5WPG8MJFSZNwRcrapZec0wEMxglB9kj//s4=
X-Received: by 2002:a50:c35d:0:b0:544:466b:3b20 with SMTP id
 q29-20020a50c35d000000b00544466b3b20mr308625edb.5.1702330424693; Mon, 11 Dec
 2023 13:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com> <20231202000417.922113-11-seanjc@google.com>
 <b45efe2f-1b99-4596-b33f-d491726ed34d@linux.intel.com>
In-Reply-To: <b45efe2f-1b99-4596-b33f-d491726ed34d@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 11 Dec 2023 13:33:29 -0800
Message-ID: <CALMp9eSp_9J9t3ByfHfnirXf=uxvWVWVtLWO5KPoO0nDFJ-gtw@mail.gmail.com>
Subject: Re: [PATCH v9 10/28] KVM: x86/pmu: Explicitly check for RDPMC of
 unsupported Intel PMC types
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 10:26=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 12/2/2023 8:03 AM, Sean Christopherson wrote:
> > Explicitly check for attempts to read unsupported PMC types instead of
> > letting the bounds check fail.  Functionally, letting the check fail is
> > ok, but it's unnecessarily subtle and does a poor job of documenting th=
e
> > architectural behavior that KVM is emulating.
> >
> > Opportunistically add macros for the type vs. index to further document
> > what is going on.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/vmx/pmu_intel.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.=
c
> > index 644de27bd48a..bd4f4bdf5419 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -23,6 +23,9 @@
> >   /* Perf's "BASE" is wildly misleading, this is a single-bit flag, not=
 a base. */
> >   #define INTEL_RDPMC_FIXED   INTEL_PMC_FIXED_RDPMC_BASE
> >
> > +#define INTEL_RDPMC_TYPE_MASK        GENMASK(31, 16)
> > +#define INTEL_RDPMC_INDEX_MASK       GENMASK(15, 0)
> > +
> >   #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR=
0)
> >
> >   static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
> > @@ -82,9 +85,13 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct=
 kvm_vcpu *vcpu,
> >       /*
> >        * Fixed PMCs are supported on all architectural PMUs.  Note, KVM=
 only
> >        * emulates fixed PMCs for PMU v2+, but the flag itself is still =
valid,
> > -      * i.e. let RDPMC fail due to accessing a non-existent counter.
> > +      * i.e. let RDPMC fail due to accessing a non-existent counter.  =
Reject
> > +      * attempts to read all other types, which are unknown/unsupporte=
d.
> >        */
> > -     idx &=3D ~INTEL_RDPMC_FIXED;
> > +     if (idx & INTEL_RDPMC_TYPE_MASK & ~INTEL_RDPMC_FIXED)

You know how I hate to be pedantic (ROFL), but the SDM only says:

If the processor does support architectural performance monitoring
(CPUID.0AH:EAX[7:0] =E2=89=A0 0), ECX[31:16] specifies type of PMC while
ECX[15:0] specifies the index of the PMC to be read within that type.

It does not say that the types are bitwise-exclusive.

Yes, the types defined thus far are bitwise-exclusive, but who knows
what tomorrow may bring?

> > +             return NULL;
> > +
> > +     idx &=3D INTEL_RDPMC_INDEX_MASK;
> >       if (fixed) {
> >               counters =3D pmu->fixed_counters;
> >               num_counters =3D pmu->nr_arch_fixed_counters;
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
