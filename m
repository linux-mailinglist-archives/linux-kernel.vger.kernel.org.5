Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39F7E2A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKFQjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:39:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640FE1BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:39:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b0c27d504fso32457537b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699288777; x=1699893577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6GJqjPyHEWJBt2NqwShpg4qNSCTYad7QEEr5EefJZo=;
        b=JX7NAUCpiEM67qqL3gJDF7pnWLvohEjUq8tKurjUCCzjqmcjLSGWr95PQ3sY7zinEs
         F0UoHKaje/uy8AvKQGe0h8I0uB/I22CfoQkqTprQXXpBaN9YR1ulmi+ZWly75TtFCgpx
         RJak0HR94aZeY03pkGTbzwBUkTC7SICthPSi2JgzTrdXbjo4A6DpuDMwDwhepTgP1Fvp
         OKJ9MmNKuCN7nqyQYfP4wG7uiQfBQ+Ui8XfQXf+U/mk6qyfTuuwjwRTzd12laGVgiXuX
         Ainr92BlkiCmWil3bdlnn9C2eWVaBKjozR63WzZgMIJ3iRNgvaWcydhn6/0uKDp1OQsb
         blqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288777; x=1699893577;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s6GJqjPyHEWJBt2NqwShpg4qNSCTYad7QEEr5EefJZo=;
        b=qd/v4tsswEa4cf7khYLzNbZsZf1ioBR8T04SOGZMDvzNv/tvnGnFssFD5XUuhlyhM9
         xVgH1gHSlmEGylS7MhK9Y7Ef9jP39FsIUMZa9d/OHUB2sLEvOuxsuiJm+nmutwVS6CtO
         KJh8Lab4YeP5lFK5OTczXwNdAeyD9/Fvq9mrdmFiGxRVaRhb0oy2hRpYC2JWOnTobz4j
         XFwZpXLUo/iTNA0G07/iKEjcVHnKzvU1/ahsqsSb2gwL9bxeo2T7vZaEm8AA19goOKVL
         VuCnSL1snLVQrlRZaHlzoic2j6qYPD/RSt8msz3fLzu7d4bHDWdignRCwPNHGIy/t3IZ
         ES1Q==
X-Gm-Message-State: AOJu0Yx+RfjBDI9JEvuaymWpuKkjgoT/JuicUFldeH2jXtpUDnSYoLlx
        phQm7M4/hkv0APUncy3FuBl10b/OiZo=
X-Google-Smtp-Source: AGHT+IHRkognXfPOdvQjyBzJ2BOeuuKhNfK1lGzPPKxyDcA2UY/godTNSWjPuOih8XOxcrUfx8DLuuZjasg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b64a:0:b0:5a7:d45d:1223 with SMTP id
 h10-20020a81b64a000000b005a7d45d1223mr243215ywk.3.1699288777668; Mon, 06 Nov
 2023 08:39:37 -0800 (PST)
Date:   Mon, 6 Nov 2023 08:39:36 -0800
In-Reply-To: <CALMp9eRzvj_Ach=QySHgpkKO6z=42OJmC4DPU=tCTxcioFvZEw@mail.gmail.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-12-seanjc@google.com>
 <CALMp9eRzvj_Ach=QySHgpkKO6z=42OJmC4DPU=tCTxcioFvZEw@mail.gmail.com>
Message-ID: <ZUkWyNBeaKiQrhiw@google.com>
Subject: Re: [PATCH v6 11/20] KVM: selftests: Test Intel PMU architectural
 events on fixed counters
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:03=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >  static void guest_test_arch_event(uint8_t idx)
> >  {
> >         const struct {
> >                 struct kvm_x86_pmu_feature gp_event;
> > +               struct kvm_x86_pmu_feature fixed_event;
> >         } intel_event_to_feature[] =3D {
> > -               [INTEL_ARCH_CPU_CYCLES]            =3D { X86_PMU_FEATUR=
E_CPU_CYCLES },
> > -               [INTEL_ARCH_INSTRUCTIONS_RETIRED]  =3D { X86_PMU_FEATUR=
E_INSNS_RETIRED },
> > -               [INTEL_ARCH_REFERENCE_CYCLES]      =3D { X86_PMU_FEATUR=
E_REFERENCE_CYCLES },
> > -               [INTEL_ARCH_LLC_REFERENCES]        =3D { X86_PMU_FEATUR=
E_LLC_REFERENCES },
> > -               [INTEL_ARCH_LLC_MISSES]            =3D { X86_PMU_FEATUR=
E_LLC_MISSES },
> > -               [INTEL_ARCH_BRANCHES_RETIRED]      =3D { X86_PMU_FEATUR=
E_BRANCH_INSNS_RETIRED },
> > -               [INTEL_ARCH_BRANCHES_MISPREDICTED] =3D { X86_PMU_FEATUR=
E_BRANCHES_MISPREDICTED },
> > +               [INTEL_ARCH_CPU_CYCLES]            =3D { X86_PMU_FEATUR=
E_CPU_CYCLES, X86_PMU_FEATURE_CPU_CYCLES_FIXED },
> > +               [INTEL_ARCH_INSTRUCTIONS_RETIRED]  =3D { X86_PMU_FEATUR=
E_INSNS_RETIRED, X86_PMU_FEATURE_INSNS_RETIRED_FIXED },
> > +               /*
> > +                * Note, the fixed counter for reference cycles is NOT =
the same
> > +                * as the general purpose architectural event (because =
the GP
> > +                * event is garbage).  The fixed counter explicitly cou=
nts at
> > +                * the same frequency as the TSC, whereas the GP event =
counts
> > +                * at a fixed, but uarch specific, frequency.  Bundle t=
hem here
> > +                * for simplicity.
> > +                */
>=20
> Implementation-specific is not necessarily garbage, though it would be
> nice if there was a way to query the frequency rather than calibrating
> against another clock.

Heh, I'll drop the editorial commentry, though I still think an architectur=
al event
with implementation-specific behavior is garbage :-)
