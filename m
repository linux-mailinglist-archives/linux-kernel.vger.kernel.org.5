Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390947DDE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjKAJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjKAJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:04:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E4124
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:04:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4901652a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829480; x=1699434280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T97XsuQPDMRDtHy08B+rqECq/pabjxSIR/W6V7wvFWM=;
        b=wDR/u07J09wey+Tzfc9wT2uc3JDwIYuShLiN2TlGprBgCfFRjfv8xR8r3Lo8t9BrG+
         yI0fYEEM/bfAH1gvXNxhC+vF9g7sQWRyi8uqH1tvhxh2H93ZKtVIb4Fr2bHJpulosKeK
         qHoTqaDYKKD7OwXWnTBMIqqQ2hvoHbV2rTXhQheMKWZFHN+Q248QE2pMr6WXL5wUjgnr
         YLM1BHjvcEOgUcrX1Qxwnalb4WSq2uQUOR/nCghOSD50HRCED/4tq17cPGP/lSKa1QZn
         Q9rGJ7lGWoqmub44HKvLQDahlLIyix6jZ1uCMhfpewTfcspqAJkzbQP+dvjqfu1c/lZT
         /WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829480; x=1699434280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T97XsuQPDMRDtHy08B+rqECq/pabjxSIR/W6V7wvFWM=;
        b=pImOjT70ec0LT9viAJ2qfOap4IAL/FBQmB40OCIYlf0S2WcHwkOUAAtgDcANf7gkq2
         g9mF3DkyxQxvNSdBM06r9mIPfqBNPxW1IDrwaTCEwV85nyM5q1F9y50nMG44PgDsi9FJ
         YnbIAopVw+BAwh2tucW4sO5yDuUvb+l17uXMtMk+zJtgTgqgjXaBFG0P8QABZjq4wsNn
         od6KmBx6RTxME+5AAnCHV19aFpnzccrUBqyi8eZQXMOaBu1s5tvdhbCAhH0kF6ANmMc6
         +FgJ7zi5J55krif2/NaPeK/ieJlKO/PxwW/r6q9Bpi6jlifXXQ5K7uzh8aZ358AjoEIV
         d/Tg==
X-Gm-Message-State: AOJu0YzKlxLQN8EssoVlvFrbHr55at0bww1BuvJd4Y3SH3ZYYyNqKTr+
        eAljI4+JiC8tlLgk8fuC9ezakWk40XPT9BZQegP7QQ==
X-Google-Smtp-Source: AGHT+IE3lvIVL/RqHctY3lvCHB1fhOmc51H/phVezjStkLmOqrn9OaDOQHPPmsK4zrwvjKKx4RwmqYLMKXfHu3BQP9o=
X-Received: by 2002:a05:6a20:4327:b0:16b:b4a0:e06b with SMTP id
 h39-20020a056a20432700b0016bb4a0e06bmr14390989pzk.43.1698829479791; Wed, 01
 Nov 2023 02:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-8-vincent.guittot@linaro.org> <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
In-Reply-To: <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Nov 2023 10:04:27 +0100
Message-ID: <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64/amu: use capacity_ref_freq to set AMU ratio
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beata,

On Wed, 1 Nov 2023 at 00:59, Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Fri, Oct 27, 2023 at 10:04:00AM +0200, Vincent Guittot wrote:
> > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > computing the arch_scale_freq_capacity().
> > This helps to keep everything aligned using the same reference for
> > computing CPUs capacity.
> >

[..]

> > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> >       }
> >
> >       for_each_possible_cpu(cpu) {
> > +             freq_inv_set_max_ratio(cpu,
> > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > +
> The capacity_ref_freq set earlier will still lead to units mismatch,
> as at the point of calling topology_init_cpu_capacity_cppc the lowest & nominal
> frequencies will be provided in MHz (unless I have missed smth).

I don't get your point:
the unit of per_cpu(capacity_freq_ref, cpu) is Khz

For cppc, we have
per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps,
raw_capacity[cpu]);

freq_inv_set_max_ratio() uses
arch_timer_get_rate() which returns a freq in Hz
and
per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ. to get a freq in Hz too.

> This means that use of both, the capacity_ref_freq and the arch_freq_scale
> will generate unexpected results, so I guess this should get amended in the
> preceding patch (?) [1]
>
> ---
> BR
> B.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20231027080400.56703-4-vincent.guittot@linaro.org/T/#m42daa167097edc190b1cfc05382c385ed801d909
>
> >               capacity = raw_capacity[cpu];
> >               capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> >                                    capacity_scale);
> > @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >
> >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> >
> > -     for_each_cpu(cpu, policy->related_cpus)
> > +     for_each_cpu(cpu, policy->related_cpus) {
> >               per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> > +             freq_inv_set_max_ratio(cpu,
> > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > +     }
> >
> >       if (cpumask_empty(cpus_to_visit)) {
> >               topology_normalize_cpu_scale();
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 38ca6c76af56..ffdf0b7c55fa 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> >  void remove_cpu_topology(unsigned int cpuid);
> >  void reset_cpu_topology(void);
> >  int parse_acpi_topology(void);
> > +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
> >  #endif
> >
> >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > --
> > 2.34.1
> >
