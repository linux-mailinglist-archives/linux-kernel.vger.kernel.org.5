Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7868A7925F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjIEQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354652AbjIENQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:16:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405C19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:16:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so2161797a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693919788; x=1694524588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erXQ5eudf2h+mjM/A19CSPwgUL1mwzyKAy3jWj8M0MM=;
        b=XWsWJg081nHdWv6JyHOaoF5ZkS2G3bqqb8eGT6rPe1Xwxq/tq+v1M5uCE5hVitDGUC
         MNfUUSJ5N7N6zcN9ngAa5Jt771hheivn4ZSqMmo2OFEgIHHs3LcMafC+SiHPYEOwspsd
         1ItP1VEPrvEcNhiQXu9GqpAMGEVw3hHdsbzSUe+VI6A98xx+JZkhBIo9g7jBeRD7Y1Q5
         8vCb13Jy0AtxvgTUYlQrHKdBtnqmu26G3aQ2rm/fSfTaoaxzjUX7aDtjs/m+XZH4rXbK
         LPAU/i2VWeA4GFlcNh0GCrALAp+2CvvGVrXg+iyMXR9qoJpDu2ucn6tlS807wawCStI9
         6CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919788; x=1694524588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erXQ5eudf2h+mjM/A19CSPwgUL1mwzyKAy3jWj8M0MM=;
        b=LltcrtochDR/PI9HjXALm7w8aMuHUHrg+XJg3wsn06JMV0U5PQxrSIxuTdM7lA5XTy
         cLsidzAk/9rBawgOWq9QyVb9EavDSF4IA2LhpmAsfsUkpKWnD51VbMBfSMT+5vAnVqcJ
         XQTVwYCFBuocEuszIk/lSIRIyGnap+4zSGvZhxlQABujO5X8cWP+jOQ12C2mWg0bkZZM
         4K8xXJ7K+XJFF/zbNMG3Wcxgvtfw12kTGzfFYjvifNUOGGz+zrZkf9zOJ+7YtN5tB/Eh
         F5LA95fuAYiKU6ij0nEL96LAe+8srl/3Z3yGI3+6ulef9CudeLHI6eEAhD0atuQazKH6
         9GKQ==
X-Gm-Message-State: AOJu0YwI+fGjO9Y5pXi+zrqmBpZva1Jbxi+bHgvZKacWR++GVinRQwK5
        5vOW1G29TIIgzp90l7Ku4QC+Lvw5ns2IXa+JjU2UoA==
X-Google-Smtp-Source: AGHT+IH1+9ZesuntgXO1B0Qubf+cgwm+/rcpVm2vlet/G3P2qMbSrDGXHFpqTkVoBj6UAQFNduQDgqruyYM7xIaeg9o=
X-Received: by 2002:a17:90a:6089:b0:26d:609a:74cd with SMTP id
 z9-20020a17090a608900b0026d609a74cdmr14918486pji.24.1693919788583; Tue, 05
 Sep 2023 06:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org> <cd795543-53db-ed14-e9dd-b5738a4f3b9d@arm.com>
In-Reply-To: <cd795543-53db-ed14-e9dd-b5738a4f3b9d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 Sep 2023 15:16:17 +0200
Message-ID: <CAKfTPtA2uWNFm+zqZODvjkNDy0joUKzRTnChEOppgi-eXBm+DQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 12:05, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
> I tried the patch-set on a platform using cppc_cpufreq and that has boosting
> frequencies,
>
> 1-
> On such platform, the CPU capacity comes from the CPPC highest_frequency
> field. The CPU capacity is set to the capacity of the boosting frequency.
> This behaviour is different from DT platforms where the CPU capacity is
> updated whenever the boosting mode is enabled (it seems).

ok, I haven't noticed that cppc_cpufreq would be impacted by this
change in arch_topology. I'm going to check how to fix that

>
> Wouldn't it be better to have CPU max capacities set to their boosting
> capacity as for CPPC base platforms ? It seems the max frequency is always
> available somehow for all the cpufreq drivers with boosting available, i.e.
> acpi-cpufreq, amd-pstate, cppc_cpufreq.

Some platforms will never enable boost or  boost is only temporarily
available before being capped. As a result some prefer to use a more
sustainable freq for their max capacity. That's why we can't always
use the max/boost freq

>
>
> 2-
> On the CPPC based platforms, the per_cpu freq_factor is not used/updated,
> meaning that we have:
> arch_scale_freq_ref_em()
> \-arch_scale_freq_ref()
>    \-topology_get_freq_ref()
>      \-per_cpu(freq_factor, cpu) (set to the default value: 1)
> and em_cpu_energy()'s ref_freq variable is then set to 1 instead of the max
> frequency (leading to a 0 energy computation).

IIUC, cppc uses the default cpu capacity of arch_topology and then
never updates it  and it creates an EM for this SMP system.
ok, so you have an EM sets with ACPI and SMP.

I'm going to check where we could set this reference frequency for your case.

>
> 3-
> Also just in case, arch_scale_freq_ref_policy() and cpufreq_get_hw_max_freq()
> seem to have close (but not identical) purpose,
>
> Regards,
> Pierre
>
> On 9/1/23 15:03, Vincent Guittot wrote:
> > The last item of a performance domain is not always the performance point
> > that has been used to compute CPU's capacity. This can lead to different
> > target frequency compared with other part of the system like schedutil and
> > would result in wrong energy estimation.
> >
> > a new arch_scale_freq_ref() is available to return a fixed and coherent
> > frequency reference that can be used when computing the CPU's frequency
> > for an level of utilization. Use this function when available or fallback
> > to the last performance domain item otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   include/linux/energy_model.h | 20 +++++++++++++++++---
> >   1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index b9caa01dfac4..7ee07be6928e 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -204,6 +204,20 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> >       return ps;
> >   }
> >
> > +#ifdef arch_scale_freq_ref
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
> > +{
> > +     return arch_scale_freq_ref(cpu);
> > +}
> > +#else
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
> > +{
> > +     return pd->table[pd->nr_perf_states - 1].frequency;
> > +}
> > +#endif
> > +
> >   /**
> >    * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
> >    *          performance domain
> > @@ -224,7 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> >                               unsigned long max_util, unsigned long sum_util,
> >                               unsigned long allowed_cpu_cap)
> >   {
> > -     unsigned long freq, scale_cpu;
> > +     unsigned long freq, ref_freq, scale_cpu;
> >       struct em_perf_state *ps;
> >       int cpu;
> >
> > @@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> >        */
> >       cpu = cpumask_first(to_cpumask(pd->cpus));
> >       scale_cpu = arch_scale_cpu_capacity(cpu);
> > -     ps = &pd->table[pd->nr_perf_states - 1];
> > +     ref_freq = arch_scale_freq_ref_em(cpu, pd);
> >
> >       max_util = map_util_perf(max_util);
> >       max_util = min(max_util, allowed_cpu_cap);
> > -     freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> > +     freq = map_util_freq(max_util, ref_freq, scale_cpu);
> >
> >       /*
> >        * Find the lowest performance state of the Energy Model above the
