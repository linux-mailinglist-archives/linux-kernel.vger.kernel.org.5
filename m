Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEF7E2D36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjKFTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:50:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6CD69
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:50:39 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc2be064b8so32219595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699300238; x=1699905038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wGNMs0oca0tadm30CfndT39i7CYhn3JaOLDgl0WWCo=;
        b=nznY5cUaK3YO/LDtRTDeCM4++MJJJLahvX+4ZX3Xil4ytS4BXlHvXR+yt9zqaugOWe
         o5QsZZZ4cldqjfOx4HX1QoIhJa+DkdQRaTULC6i2fLmhe9gTJBhyqjt8w2ZmpVO4c93J
         WKZrufd/AAGUiWaku4J8m1Jb7oyp540Ir6d5kYFV7a08g+xaM4mshGzV01hKOq1XM4NJ
         z99VUa/n1d944HT8PzuIl5TI5ABIPk/VQrAZFwC3D3db1pjHx8G1IvWx+KuUMKkGOUh0
         PJ3Wf8AYXbxFwedGQZs7LytTabfj2azT5xB5JTHHfVWKXoI5RhNQkPSCT2oWI0iJkGkW
         CpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699300238; x=1699905038;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0wGNMs0oca0tadm30CfndT39i7CYhn3JaOLDgl0WWCo=;
        b=iGk9clopRqiMd2QjGbXQXxzAjwKZD8AFKfZKiuGPO2XSwX7lmV33YDWmENvbLBCScC
         fHPU0oaVAnHUgfLNwDTE0rNd279bv53GXI04gRLUFvb3QVoQcrTdoMUO7Jn9bnjlbKqu
         m6zaX2SSyt9vhqyHNjxQBv0Te+W3J5xiQ0dgbykcvIHXBfnMq8WtRSj1KuSKZbQ4RUk/
         c0/Bk6GWcAiPFkYbuVy5PZRBnUegmBsws6+n5F9oOCCfPoVMrBzhNiGCTKam+CmP70ed
         NIub93mNTynNsZlziV+0x6sphqfqWSDuBwOdPAS+YEVZn65xw+ewC4/zLkLBzd6sxSkl
         yX1w==
X-Gm-Message-State: AOJu0YyhameohEEIso/LjSieToUyPCQtJk6u7JaiTh8ofMDVtCjAFTwt
        PyY2d8uBM1ssdFW7HJ6BChNEeFSSILU=
X-Google-Smtp-Source: AGHT+IFzKia81UldM1nmPaylTTUDc2KKAjSeNKt0eO7uRRZeqHXqZvnJgK+QHuithDc6gGaD4UvO9kB48y0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:bd85:b0:1c9:bdc5:c34a with SMTP id
 q5-20020a170902bd8500b001c9bdc5c34amr14265pls.0.1699300238578; Mon, 06 Nov
 2023 11:50:38 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:50:37 -0800
In-Reply-To: <CALMp9eR2jWM3_4EPWS+EXY=7b-hJyZGg2nh1sq0iaVd0kDFjZg@mail.gmail.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-9-seanjc@google.com>
 <CALMp9eR2jWM3_4EPWS+EXY=7b-hJyZGg2nh1sq0iaVd0kDFjZg@mail.gmail.com>
Message-ID: <ZUlDjTos7rnVZVgt@google.com>
Subject: Re: [PATCH v6 08/20] KVM: selftests: Extend {kvm,this}_pmu_has() to
 support fixed counters
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > +#define        KVM_X86_PMU_FEATURE(__reg, __bit)                      =
         \
> > +({                                                                    =
 \
> > +       struct kvm_x86_pmu_feature feature =3D {                       =
   \
> > +               .f =3D KVM_X86_CPU_FEATURE(0xa, 0, __reg, __bit),      =
   \
> > +       };                                                             =
 \
> > +                                                                      =
 \
> > +       kvm_static_assert(KVM_CPUID_##__reg =3D=3D KVM_CPUID_EBX ||    =
     \
> > +                         KVM_CPUID_##__reg =3D=3D KVM_CPUID_ECX);     =
     \
> > +       feature;                                                       =
 \
> >  })
> >
> > -#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED   KVM_X86_PMU_FEATURE(5)
> > +#define X86_PMU_FEATURE_CPU_CYCLES             KVM_X86_PMU_FEATURE(EBX=
, 0)
> > +#define X86_PMU_FEATURE_INSNS_RETIRED          KVM_X86_PMU_FEATURE(EBX=
, 1)
> > +#define X86_PMU_FEATURE_REFERENCE_CYCLES       KVM_X86_PMU_FEATURE(EBX=
, 2)
> > +#define X86_PMU_FEATURE_LLC_REFERENCES         KVM_X86_PMU_FEATURE(EBX=
, 3)
> > +#define X86_PMU_FEATURE_LLC_MISSES             KVM_X86_PMU_FEATURE(EBX=
, 4)
> > +#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED   KVM_X86_PMU_FEATURE(EBX=
, 5)
> > +#define X86_PMU_FEATURE_BRANCHES_MISPREDICTED  KVM_X86_PMU_FEATURE(EBX=
, 6)
>=20
> Why not add top down slots now?

Laziness? =20

> > +#define X86_PMU_FEATURE_INSNS_RETIRED_FIXED    KVM_X86_PMU_FEATURE(ECX=
, 0)
> > +#define X86_PMU_FEATURE_CPU_CYCLES_FIXED       KVM_X86_PMU_FEATURE(ECX=
, 1)
> > +#define X86_PMU_FEATURE_REFERENCE_CYCLES_FIXED KVM_X86_PMU_FEATURE(ECX=
, 2)
>=20
> Perhaps toss 'TSC' between CYCLES and FIXED?

I think X86_PMU_FEATURE_REFERENCE_TSC_CYCLES_FIXED is more aligned with how=
 the
SDM (and English in general) talks about reference cycles.

> And add top down slots now>

Ya.
