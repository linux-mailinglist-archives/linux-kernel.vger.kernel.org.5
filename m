Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7078A7C56C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjJKO0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJKOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:25:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD0392
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:25:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b7c234a7so15505235ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697034357; x=1697639157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l14hTncC5mvc9d55sNzpnO/j1EgvBAnkseX/eOj6QQ8=;
        b=es6MQyFqFOGWAQKBbeeKoWtkFpJzRc8psyzRTt10mZt3UnK+1OL1gLHUgpuKWXeHjA
         UMg96mitx6IsSQJcCuQTDvhG55WFSyYihXkiE71MQwuC992CQNcWOsRNRFLer1RXf0AB
         yKdJKB0g7VMx8r9/AdhKSwIaGH0m+QsXHJJ4wkh+oVDK9PgtjQF7RmxGD4WqRxeSrkMN
         aWUVGNsi7r0KF6mbx4FQJ5HdRyhn+1iIiGa6W5DqtpOpTmj9mmN94V7AHkvWsZOxrU++
         sSJ4YZSby0PIW3th08HaAgDxIZTGLZVgFx1iLB1Miunzo72OiQOOkXLQ+gi4a8FXPxsD
         Cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034357; x=1697639157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l14hTncC5mvc9d55sNzpnO/j1EgvBAnkseX/eOj6QQ8=;
        b=mecjmCzGzfFmuUBlvNN7ee01im+PtjA2YBId3VccA4caBIfzgHYhuhNYhX6TaOOeiS
         N85O70NudU9JCOb9zn3bQT10NC037bcxD/MD8N41FYQUFzNMBlCUucFEoEtEeEWjUI7j
         iPTZ1Z9ZUWvHtGd4wgqvuiHFkTeFTgIXGtew3fnp83/1YZYzey8rLFoRcLJNNPXbTvYG
         eXq3YT7YZxznFksCoY6o9oM3FG3FToo/91+tvv3sQybbDZT7RhHHRaypWBIP6S3heRsh
         sOXxweFcZN7zdC4MhqbHlMdmNlma1vqWQCpFvmJ/bCJi/YdqKsqapnEg9jjcfS6oO8Td
         0Yxw==
X-Gm-Message-State: AOJu0YwHeNIJgi+ujNOS63LNFVv7Rdo1OS6t/1bs43lWKun+kAWi0nfE
        yD5t9swKctKcz1LfbghG61+2ZLg9Qvwc0/Rrtm/qIA==
X-Google-Smtp-Source: AGHT+IEWkxKy7XH4G4dusSIdv8F7TkD3FNAIrXX1NOI+wrbvLjl3cPagIDjlyQ3TAMp3+0VNOOg/I7dqaW8LUiMWIfQ=
X-Received: by 2002:a17:903:248:b0:1c7:495c:87e0 with SMTP id
 j8-20020a170903024800b001c7495c87e0mr25613343plh.37.1697034357305; Wed, 11
 Oct 2023 07:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-7-vincent.guittot@linaro.org> <ac8968b9-8463-4aa2-a38d-fc2b9137460d@arm.com>
In-Reply-To: <ac8968b9-8463-4aa2-a38d-fc2b9137460d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 11 Oct 2023 16:25:46 +0200
Message-ID: <CAKfTPtBhXRk_Y-xiHn9_jQ1C_ALzbr3-KdwzcTCyupzJ4Gru5g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cpufreq/cppc: set the frequency used for capacity computation
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 12:27, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 10/9/23 12:36, Vincent Guittot wrote:
> > cppc cpufreq driver can register an artificial energy model. In such case,
> > it also have to register the frequency that is used to define the CPU
> > capacity
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index fe08ca419b3d..24c6ba349f01 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -636,6 +636,21 @@ static int populate_efficiency_class(void)
> >       return 0;
> >   }
> >
> > +
> > +static void cppc_cpufreq_set_capacity_ref_freq(struct cpufreq_policy *policy)
> > +{
> > +     struct cppc_perf_caps *perf_caps;
> > +     struct cppc_cpudata *cpu_data;
> > +     unsigned int ref_freq;
> > +
> > +     cpu_data = policy->driver_data;
> > +     perf_caps = &cpu_data->perf_caps;
> > +
> > +     ref_freq = cppc_cpufreq_perf_to_khz(cpu_data, perf_caps->highest_perf);
> > +
> > +     per_cpu(capacity_ref_freq, policy->cpu) = ref_freq;
>
> 'capacity_ref_freq' seems to be updated only if CONFIG_ENERGY_MODEL is set. However in
> [1], get_capacity_ref_freq() relies on 'capacity_ref_freq'. The cpufreq_schedutil governor
> should have a valid 'capacity_ref_freq' value set if the CPPC cpufreq driver is used
> without energy model I believe.

we can disable it by setting capacity_ref_freq to 0 so it will
fallback on cpuinfo like intel and amd which uses default
SCHED_CAPACITY_SCALE capacity

Could you provide me with more details about your platform ? I still
try to understand how the cpu compute capacity is set up on your
system. How do you set per_cpu cpu_scale variable ? we should set the
ref freq at the same time

>
> Also 'capacity_ref_freq' seems to be set only for 'policy->cpu'. I believe it should
> be set for the whole perf domain in case this 'policy->cpu' goes offline.
>
> Another thing, related my comment to [1] and to [2], for CPPC the max capacity matches
> the boosting frequency. We have:
>    'non-boosted max capacity' < 'boosted max capacity'.
> -
> If boosting is not enabled, the CPU utilization can still go above the 'non-boosted max
> capacity'. The overutilization of the system seems to be triggered by comparing the CPU
> util to the 'boosted max capacity'. So systems might not be detected as overutilized.

As Peter mentioned, we have to decide what is the original compute
capacity of your CPUs which is usually the sustainable max compute
capacity, especially when using EAS and EM

>
> For the EAS energy computation, em_cpu_energy() tries to predict the frequency that will
> be used. It is currently unknown to the function that the frequency request will be
> clamped by __resolve_freq():
> get_next_freq()
> \-cpufreq_driver_resolve_freq()
>    \-__resolve_freq()
> This means that the energy computation might use boosting frequencies, which are not
> available.
>
> Regards,
> Pierre
>
> [1]: [PATCH v2 4/6] cpufreq/schedutil: use a fixed reference frequency
> [2]: https://lore.kernel.org/lkml/20230905113308.GF28319@noisy.programming.kicks-ass.net/
>
> > +}
> > +
> >   static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> >   {
> >       struct cppc_cpudata *cpu_data;
> > @@ -643,6 +658,9 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> >               EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
> >
> >       cpu_data = policy->driver_data;
> > +
> > +     cppc_cpufreq_set_capacity_ref_freq(policy);
> > +
> >       em_dev_register_perf_domain(get_cpu_device(policy->cpu),
> >                       get_perf_level_count(policy), &em_cb,
> >                       cpu_data->shared_cpu_map, 0);
