Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448837E3AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjKGLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjKGLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:18:35 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C634F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:18:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so3684760a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699355911; x=1699960711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7i6s0OZZc7pGu3HMoCBp0zLvXEyl8tx7Cy8jxttMkE=;
        b=URyuh3UvBbTOFtlhoDnYXCzqtJiU0somt+naMJEh3zwDQQB0KMBToZF7aUnwcRW1/Q
         BhCCPaWtoSagclIFd5oCOzQcnx1hpk1watoJS8kFD7POUE02cxQEQCRtesUUA7J6TmR4
         BS6WDi3iO097ZdElvN32P+K2Bb0v6q2OKpXMvlpWL2LY1+VvC84TmoZ9rQrwZcTBPHpM
         UTbKurnlS5zRW5JbEKAepF/kX7j1Q5vStgxq/DD/IXcocmfcwgpaSyosuIQ5lIoG422q
         3B/KT7s66RgAu7ESYkGduc5c2dWe448ctgb3qhplyyfBq99oyCvHtJXLkm0AsqY7z4LR
         +5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355911; x=1699960711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7i6s0OZZc7pGu3HMoCBp0zLvXEyl8tx7Cy8jxttMkE=;
        b=ZrBXmR7a8oGLT4I77Z6Bx+YN88/8wxF0h3r1ThHHJ87P2AnHq1s5IDZmj0LZSqnM9s
         kimjYnsQLzT14iCpH7gQ4Am3ELyY89B/9sCmab0s2DP8WE1lcVElyNh6AAD3vwFKu+fG
         pfhaDuQQr1XKPWWnXm+rfUE3ulGOpX6kT6mH00wc4+X1C+EIfNqEu4jFAai28dozOerd
         qYBgmlMlcxxWkCMqNyh/1GUqQBo4lVAyimM/UfraJ3Qeef9PHbIw7Ae5P8glMbIVmy4H
         yJPYgf1zUV9TAjlP/2J+ieTq3HKNIwQunlwHssGCodXUYpkTfEW4oCldz/S9QaYA2+Hu
         BuJg==
X-Gm-Message-State: AOJu0Yx813HuSDtLe+lWWhi0ETgCCrcieXFhGubOSk+NF0BcfPFJjQGz
        OcsP39ZFJIpFD/nojh6ltjScbGhxLKHFJEtCZ1SLyA==
X-Google-Smtp-Source: AGHT+IGJj6RQ2bUmWbYz8C93NA6gwg7kx/UtAq/bIX3BLPtMUeDBrcW8Nh1OuYUSHQFDcz9fDgHm15AgzSezenWlJi0=
X-Received: by 2002:a05:6a21:3393:b0:137:23f1:4281 with SMTP id
 yy19-20020a056a21339300b0013723f14281mr31891943pzb.12.1699355911510; Tue, 07
 Nov 2023 03:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
 <20231104105907.1365392-8-vincent.guittot@linaro.org> <20231107103808.GF18944@willie-the-truck>
In-Reply-To: <20231107103808.GF18944@willie-the-truck>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Nov 2023 12:18:20 +0100
Message-ID: <CAKfTPtBb+qea61OH-B0L=MHJWnQMLL80EBR-nSHZtoWTbYeHhw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
To:     Will Deacon <will@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, beata.michalska@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 11:38, Will Deacon <will@kernel.org> wrote:
>
> On Sat, Nov 04, 2023 at 11:59:07AM +0100, Vincent Guittot wrote:
> > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > computing the arch_scale_freq_capacity().
> > This helps to keep everything aligned using the same reference for
> > computing CPUs capacity.
> >
> > The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
> > ensures that arch_scale_freq_capacity() returns max capacity until it i=
s
> > set to its correct value with the cpu capacity and capacity_ref_freq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c  | 26 ++++++++++++++------------
> >  drivers/base/arch_topology.c  | 12 +++++++++++-
> >  include/linux/arch_topology.h |  1 +
> >  3 files changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.=
c
> > index 817d788cd866..615c1a20129f 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
> >  #undef pr_fmt
> >  #define pr_fmt(fmt) "AMU: " fmt
> >
> > -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> > +/*
> > + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE =
until
> > + * the CPU capacity and its associated frequency have been correctly
> > + * initialized.
> > + */
> > +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =
=3D  1UL << (2 * SCHED_CAPACITY_SHIFT);
>
> This doesn't seem to match the comment? SCHED_CAPACITY_SCALE doesn't have
> the '2 *' multiplier.

The comment in freq_inv_set_max_ratio() says:

* We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE=C2=B2
* in order to ensure a good resolution for arch_max_freq_scale for
* very low reference frequencies (down to the KHz range which should
* be unlikely).

Then there is a  "  * arch_max_freq_scale) >> SCHED_CAPACITY_SHIFT"
when computing the scale which brings the result back to
SCHED_CAPACITY_SHIFT

>
> >  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> >  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> >  static cpumask_var_t amu_fie_cpus;
> > @@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cpu)
> >       return true;
> >  }
> >
> > -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> > +void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> >  {
> > -     u64 ratio;
> > +     u64 ratio, ref_rate =3D arch_timer_get_rate();
> >
> >       if (unlikely(!max_rate || !ref_rate)) {
> > -             pr_debug("CPU%d: invalid maximum or reference frequency.\=
n",
> > +             WARN_ONCE(1, "CPU%d: invalid maximum or reference frequen=
cy.\n",
> >                        cpu);
> > -             return -EINVAL;
> > +             return;
> >       }
> >
> >       /*
> > @@ -139,12 +144,12 @@ static int freq_inv_set_max_ratio(int cpu, u64 ma=
x_rate, u64 ref_rate)
> >       ratio =3D div64_u64(ratio, max_rate);
> >       if (!ratio) {
> >               WARN_ONCE(1, "Reference frequency too low.\n");
> > -             return -EINVAL;
> > +             return;
> >       }
> >
> > -     per_cpu(arch_max_freq_scale, cpu) =3D (unsigned long)ratio;
> > +     WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)rati=
o);
>
> Why is WRITE_ONCE() now needed?

the tick can already use it. We want to make sure to use either the
old or the new one but not an intermediate value

>
> > -     return 0;
> > +     return;
>
> Pointless 'return;' statement.

fair enough

>
> Will
