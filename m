Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657927CC4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjJQNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjJQNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:42:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11841ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:42:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c88b467ef8so39178755ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697550131; x=1698154931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Ac8357kjZmBSEr1y0XOi4bAEg4bWoPEyPAdAtsLWE=;
        b=uIZXpQ0mzo5ICT44X+91sn4TITo33S0q2Gb/9YZCgL4xdJ+MU9q+SpcD0rsv+FKBqN
         IubQK/lvEyMLdsyt4WroaLTK/J6OfyssfPeaMnbWNosdAMrWvc647PS2RR0LwTA05Qm6
         V7/1d//K4+tgBQteHnik7kDsYFvCX8Ur9ufqAL5mXBr7BYNvnyWonGsxLkE5MXVK7Qra
         s4i6iadp3tGAioxhncScF5ViyCGSeO5ykXZQ0JNO5wVGRGsz2v6IoAvWpYdoOkWlBiPo
         NeDyVmkuzC+K6pwiC/yTvM0XHyUAfa+lKsW2oJO/Y1+E9jLU2RPIVmNS2OQ8Hi6H6BiV
         8t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550131; x=1698154931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4Ac8357kjZmBSEr1y0XOi4bAEg4bWoPEyPAdAtsLWE=;
        b=T+2OVGTP2svPsI2jiTynkd32gHSlMsda2rpQqi8KKNAa3xMF2o664uePIARSAAs/Hi
         UeDaRGxu3Ny2yJDSKpWdLzQYlptBg3IsQv1puSA+ySRHTrxvi5Xk31x8EBnb4wYAHZOU
         I1e/MRAtts6HiSOAWMD6nT3rPyqrI6w2zaUvC+hl8iDn/Xb0VEsAzKxRdckR1VAO/lst
         LgXXq5gOb3NIuU6Tl5Qb2lOc+9tO4Yl5oM9tnKbMSbJ/mEWLYkw4zcOiK4Syes6LD/SW
         mHnGvbcoqmpkCBmmSmvXS35gInY7qLYhRwBn7mLk2Q11T5I0GJ3po9iADZU+50WVwDD4
         nKGQ==
X-Gm-Message-State: AOJu0YybBvR6Gr1dRg1HneX86YBi+pJM7uOBHUTo057wdee86TS1hcIg
        uCZFtphjYUNNjICeESmBlNfDhwH06MLvt9HABZ53fw==
X-Google-Smtp-Source: AGHT+IHtFeoaUQqB6BbRSvNyCKcQArkdii6iyWxk/wLzPCeEtwyijjr9f1hjIT9Ej/YVkc3jHS7h3grHmlfjS3KThAE=
X-Received: by 2002:a17:90a:fb56:b0:27d:4eff:27ae with SMTP id
 iq22-20020a17090afb5600b0027d4eff27aemr2025710pjb.40.1697550131252; Tue, 17
 Oct 2023 06:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231009103621.374412-7-vincent.guittot@linaro.org>
 <ac8968b9-8463-4aa2-a38d-fc2b9137460d@arm.com> <CAKfTPtBhXRk_Y-xiHn9_jQ1C_ALzbr3-KdwzcTCyupzJ4Gru5g@mail.gmail.com>
 <ZS0oyhbVDtXO1p5b@arm.com> <CAKfTPtCg9aYnWsReT=xtznwkMMMEepj6j9z4J6_ST5oUv69aUA@mail.gmail.com>
 <ZS5NuK7rjVFM5tj8@arm.com>
In-Reply-To: <ZS5NuK7rjVFM5tj8@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Oct 2023 15:41:59 +0200
Message-ID: <CAKfTPtAXeKRESDEZJMai3KhgXcE_hpndTRfMtcoVbH0FQZQd2Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cpufreq/cppc: set the frequency used for capacity computation
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 11:02, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi,
>
> On Monday 16 Oct 2023 at 17:32:03 (+0200), Vincent Guittot wrote:
> > Hi Ionela,
> >
> > On Mon, 16 Oct 2023 at 14:13, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > Hi both,
> > >
> > > On Wednesday 11 Oct 2023 at 16:25:46 (+0200), Vincent Guittot wrote:
> > > > On Wed, 11 Oct 2023 at 12:27, Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > > >
> > > > > Hello Vincent,
> > > > >
> > > > > On 10/9/23 12:36, Vincent Guittot wrote:
> > > > > > cppc cpufreq driver can register an artificial energy model. In such case,
> > > > > > it also have to register the frequency that is used to define the CPU
> > > > > > capacity
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
> > > > > >   1 file changed, 18 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > > > > index fe08ca419b3d..24c6ba349f01 100644
> > > > > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > > > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > > > > @@ -636,6 +636,21 @@ static int populate_efficiency_class(void)
> > > > > >       return 0;
> > > > > >   }
> > > > > >
> > > > > > +
> > > > > > +static void cppc_cpufreq_set_capacity_ref_freq(struct cpufreq_policy *policy)
> > > > > > +{
> > > > > > +     struct cppc_perf_caps *perf_caps;
> > > > > > +     struct cppc_cpudata *cpu_data;
> > > > > > +     unsigned int ref_freq;
> > > > > > +
> > > > > > +     cpu_data = policy->driver_data;
> > > > > > +     perf_caps = &cpu_data->perf_caps;
> > > > > > +
> > > > > > +     ref_freq = cppc_cpufreq_perf_to_khz(cpu_data, perf_caps->highest_perf);
> > > > > > +
> > > > > > +     per_cpu(capacity_ref_freq, policy->cpu) = ref_freq;
> > > > >
> > > > > 'capacity_ref_freq' seems to be updated only if CONFIG_ENERGY_MODEL is set. However in
> > > > > [1], get_capacity_ref_freq() relies on 'capacity_ref_freq'. The cpufreq_schedutil governor
> > > > > should have a valid 'capacity_ref_freq' value set if the CPPC cpufreq driver is used
> > > > > without energy model I believe.
> > > >
> > > > we can disable it by setting capacity_ref_freq to 0 so it will
> > > > fallback on cpuinfo like intel and amd which uses default
> > > > SCHED_CAPACITY_SCALE capacity
> > > >
> > > > Could you provide me with more details about your platform ? I still
> > > > try to understand how the cpu compute capacity is set up on your
> > > > system. How do you set per_cpu cpu_scale variable ? we should set the
> > > > ref freq at the same time
> > > >
> > >
> > > Yes, the best place to set it would be in:
> > > drivers/base/arch_topology.c: topology_init_cpu_capacity_cppc()
> >
> > Thanks. I didn't notice it
> >
> > >
> > > But:
> > >  - That function reuses topology_normalize_cpu_scale() and when called
> > >    it needs to have capacity_ref_freq = 1. So either capacity_ref_freq
> > >    needs to be set for each CPU after topology_normalize_cpu_scale() is
> > >    called or we should not call topology_normalize_cpu_scale() here and
> > >    just unpack a CPPC specific version of it in
> > >    topology_init_cpu_capacity_cppc(). The latter is probably better as
> > >    we avoid iterating through all CPUs a couple of times.
> > >
> > >  - When set, capacity_ref_freq needs to be a "frequency" (at least
> > >    in reference to the reference frequencies provided by CPPC). So
> > >    cppc_cpufreq_khz_to_perf() and cppc_cpufreq_perf_to_khz() would need
> > >    to move to drivers/acpi/cppc_acpi.c. They don't have any dependency
> > >    on cpufreq (policies) so that should be alright.
> > >
> > > topology_init_cpu_capacity_cppc() is a better place to set
> > > capacity_ref_freq because one can do it for each CPU, and it not only
> >
> > I agree, topology_init_cpu_capacity_cppc() is the best place to set
> > capacity_ref_freq()
> >
> > > caters for the EAS case but also for frequency invariance, when
> > > arch_set_freq_scale() is called, if no counters are supported.
> > >
> > > When counters are supported, there are still two loose threads:
> > >  - amu_fie_setup(): Vincent, would you mind completely removing
> > >    cpufreq_get_hw_max_freq() and reusing arch_scale_freq_ref() here?
> >
> > I wonder if we can have a ordering dependency problem as both
> > init_cpu_capacity_notifier() and init_amu_fie_notifier() are
> > registered for the same CPUFREQ_POLICY_NOTIFIER event and I'm not sure
> >  it will happen in the right ordering
>
> Yes, you are right, this would be a problem for DT systems. With the
> implementation above, ACPI systems would obtain capacity_ref_freq on
> processor probe so it should be then available at policy creation when
> amu_fie_setup() would be called.

yes. the problem is only for DT

>
> Initially I thought the only solution might be to move
> freq_inv_set_max_ratio() in the arch topology driver to the same
> callback that initialises capacity, but that quickly becomes ugly with
> making it support both DT and ACPI systems. And then there's the
> question on whether it belongs there.

The goal would be to update the ratio while initializing everything
else. But this means that we must initialize the ratio in such a way
that amu will return by default SCHED_CAPACITY_SCALE until
arch_topology.c initializes it.

I will make it a try to check how ugly it will be

>
> But I think the better option is to wrap policy->cpuinfo.max_freq in
> another getter function which can be used in both amu_fie_setup() and
> init_cpu_capacity_callback(). This can be implemented in the
> arch topology driver and exposed to the architecture specific topology
> files.
>
> I'm not sure if this might be worth leaving for another patchset as
> well. Let us know if you'd like us to help on theses ones.
>
> Thanks,
> Ionela.
>
> >
> > >
> > >  - It would be nice if cppc_scale_freq_workfn() would use
> > >    arch_scale_freq_ref() as well, for consistency. But it would need
> > >    to be converted back to performance before use, so that would mean
> > >    extra work on the tick, which is not ideal.
> >
> > This once seems more complex as it implies other arch that are not
> > using arch_topology.c and would need more rework so I would prefer to
> > make it a separate patchset
> >
> > Thanks
> > Vincent
> >
> > >
> > > Basically it would be good if what gets used for capacity
> > > (arch_scale_freq_ref()) gets used for frequency invariance as well,
> > > in all locations.
> > >
> > > Thanks,
> > > Ionela.
> > >
> > > > >
> > > > > Also 'capacity_ref_freq' seems to be set only for 'policy->cpu'. I believe it should
> > > > > be set for the whole perf domain in case this 'policy->cpu' goes offline.
> > > > >
> > > > > Another thing, related my comment to [1] and to [2], for CPPC the max capacity matches
> > > > > the boosting frequency. We have:
> > > > >    'non-boosted max capacity' < 'boosted max capacity'.
> > > > > -
> > > > > If boosting is not enabled, the CPU utilization can still go above the 'non-boosted max
> > > > > capacity'. The overutilization of the system seems to be triggered by comparing the CPU
> > > > > util to the 'boosted max capacity'. So systems might not be detected as overutilized.
> > > >
> > > > As Peter mentioned, we have to decide what is the original compute
> > > > capacity of your CPUs which is usually the sustainable max compute
> > > > capacity, especially when using EAS and EM
> > > >
> > > > >
> > > > > For the EAS energy computation, em_cpu_energy() tries to predict the frequency that will
> > > > > be used. It is currently unknown to the function that the frequency request will be
> > > > > clamped by __resolve_freq():
> > > > > get_next_freq()
> > > > > \-cpufreq_driver_resolve_freq()
> > > > >    \-__resolve_freq()
> > > > > This means that the energy computation might use boosting frequencies, which are not
> > > > > available.
> > > > >
> > > > > Regards,
> > > > > Pierre
> > > > >
> > > > > [1]: [PATCH v2 4/6] cpufreq/schedutil: use a fixed reference frequency
> > > > > [2]: https://lore.kernel.org/lkml/20230905113308.GF28319@noisy.programming.kicks-ass.net/
> > > > >
> > > > > > +}
> > > > > > +
> > > > > >   static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> > > > > >   {
> > > > > >       struct cppc_cpudata *cpu_data;
> > > > > > @@ -643,6 +658,9 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> > > > > >               EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
> > > > > >
> > > > > >       cpu_data = policy->driver_data;
> > > > > > +
> > > > > > +     cppc_cpufreq_set_capacity_ref_freq(policy);
> > > > > > +
> > > > > >       em_dev_register_perf_domain(get_cpu_device(policy->cpu),
> > > > > >                       get_perf_level_count(policy), &em_cb,
> > > > > >                       cpu_data->shared_cpu_map, 0);
