Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34A47ED18C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbjKOUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbjKOUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:02:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD75189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:02:12 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692c02adeefso10861b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700078531; x=1700683331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BwJaaAdF7vT4Afgkg576irhRE9bfTaolG4lJRiY+XeM=;
        b=ppobgi80uOXUUhedtPnjabyF0zDPGkAZl+4XsqqrIVUVdx9EiR/oSRYzhxK6Q15ytl
         4Nl6oM0bQzwAAnYFTaJRdD3HCmVm21PdijJJAWyCtjZ+EPoRyZrFPM6+Q9+DkmJt9sTD
         6WdN9cjRLEvoDENT2e1fUzCSCdSfmXAUGTAdj0SR08KGHrREpPjG5V5A3Wpd5uqyN5BO
         BWZ4nKyrINEpeUWPl1owOcfPfsYZRDySlc9ZMgb+vU79AWaKFc/HYzTti6gwELY6KffH
         mapaqmg/MTLf9Y6ICcAPRY9kEcrLIeO2qKbD5JUuRkPCaWCJSVGVcXtxMm1NSyf9EbG7
         ASag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700078531; x=1700683331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwJaaAdF7vT4Afgkg576irhRE9bfTaolG4lJRiY+XeM=;
        b=Snevca84LulfyevzMs5kwVXpOM3jnKKeF2NBgeS5hE3RQummF/xF0AgT2O2dULCivM
         6TiCLmmGlc4quhd6XSXSpW9I177gQ+wsGXl+bSaNKLlfu7RpH6HHc3zgPYWdVn95RM4v
         SF2q/AsCJJBCmXsetPLkN/v2UHOgSKVCG2UPwoHUQT/WMGWKDrpLMwgESiQZfhwWzwnZ
         +/h72Ykmj/A+SWU/PUcj2+TjPRVpR1K+qJaSJTu84vFbuPr0V1V/9ZrdFgvaZGZAiteT
         FXdtP98feXdxfHNu4Bczx1puhi0RuJnjjFmEIaQOgpQBAqvVxR8MDU3wHWXV5w7O/yX2
         2xZQ==
X-Gm-Message-State: AOJu0Yzbr4O/SFnnWgIrovxoQe2HjDV8Y3OEwmJD5A2apcFFjldyAHtZ
        /J1BAyfM8z0JK5gnY1x4tQlRzk0sIkM1EQgphg/OLw==
X-Google-Smtp-Source: AGHT+IHkKRc9h2xz+M47gYYJwARMwI8TEZUmSXu02a+gMEqPF0Ms/3N2ZqkInfObEiCRBj+X2p1qqoGM/1aeb/qYNBI=
X-Received: by 2002:a17:90b:4d8f:b0:274:6839:6a8c with SMTP id
 oj15-20020a17090b4d8f00b0027468396a8cmr12441942pjb.6.1700078531387; Wed, 15
 Nov 2023 12:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20230804090858.7605-1-rui.zhang@intel.com> <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
 <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com> <20230911114218.GA334545@ziqianlu-dell>
 <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
 <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com> <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
 <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com> <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
In-Reply-To: <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Nov 2023 21:01:59 +0100
Message-ID: <CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Lu, Aaron" <aaron.lu@intel.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On Wed, 20 Sept 2023 at 09:24, Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Hi, Pierre,
>
> Sorry for the late response. I'm still ramping up on the related code.
>
> On Thu, 2023-09-14 at 16:53 +0200, Pierre Gondois wrote:
> >
> >
> > On 9/14/23 11:23, Zhang, Rui wrote:
> > > Hi, Pierre,
> > >
> > > >
> > > > Yes right indeed,
> > > > This happens when putting a CPU offline (as you mentioned
> > > > earlier,
> > > > putting a CPU offline clears the CPU in the idle_cpus_mask).
> > > >
> > > > The load balancing related variables
> > >
> > > including?
> >
> > I meant the nohz idle variables in the load balancing, so I was
> > referring to:
> > (struct sched_domain_shared).nr_busy_cpus
> > (struct sched_domain).nohz_idle
> > nohz.idle_cpus_mask
> > nohz.nr_cpus
> > (struct rq).nohz_tick_stopped
>
> IMO, the problem is that, for an isolated CPU,
> 1. it is not an idle cpu (nohz.idle_cpus_mask should be cleared)
> 2. it is not a busy cpu (sds->nr_busy_cpus should be decreased)
>
> But current code does not have a third state to describe this, so we
> need to either
> 1. add extra logic, like on_null_domain() checks
> or
> 2. rely on current logic, but update all related variables correctly,
> like you proposed.

Isn't the housekeeping cpu mask there to manage such a case ? I was
expecting that your isolated cpu should be cleared from the
housekeeping cpumask used by scheduler and ILB

I think that your solution is the comment of the ffind_new_ilb() unction:
"
 * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
 *   anywhere yet.
"

IMO, you should look at enabling and using the HK_TYPE_SCHED for isolated CPU

CCed Frederic to get his opinion

>
> But in any case, we should stick with one direction.
>
> If we follow the first one, the original patch should be used, which
> IMO is simple and straight forward.
> If we follow the later one, we'd better audit and remove the current
> on_null_domain() usage at the same time. TBH, I'm not confident enough
> to make such a change. But if you want to propose something, I'd glad
> to test it.
>
> thanks,
> rui
>
> >
> > >
> > > >   are unused if a CPU has a NULL
> > > > rq as it cannot pull any task. Ideally we should clear them once,
> > > > when attaching a NULL sd to the CPU.
> > >
> > > This sounds good to me. But TBH, I don't have enough confidence to
> > > do
> > > so because I'm not crystal clear about how these variables are
> > > used.
> > >
> > > Some questions about the code below.
> > > >
> > > > The following snipped should do that and solve the issue you
> > > > mentioned:
> > > > --- snip ---
> > > > --- a/include/linux/sched/nohz.h
> > > > +++ b/include/linux/sched/nohz.h
> > > > @@ -9,8 +9,10 @@
> > > >    #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> > > >    extern void nohz_balance_enter_idle(int cpu);
> > > >    extern int get_nohz_timer_target(void);
> > > > +extern void nohz_clean_sd_state(int cpu);
> > > >    #else
> > > >    static inline void nohz_balance_enter_idle(int cpu) { }
> > > > +static inline void nohz_clean_sd_state(int cpu) { }
> > > >    #endif
> > > >
> > > >    #ifdef CONFIG_NO_HZ_COMMON
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index b3e25be58e2b..6fcabe5d08f5 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -11525,6 +11525,9 @@ void nohz_balance_exit_idle(struct rq
> > > > *rq)
> > > >    {
> > > >           SCHED_WARN_ON(rq != this_rq());
> > > >
> > > > +       if (on_null_domain(rq))
> > > > +               return;
> > > > +
> > > >           if (likely(!rq->nohz_tick_stopped))
> > > >                   return;
> > > >
> > > if we force clearing rq->nohz_tick_stopped when detaching domain,
> > > why
> > > bother adding the first check?
> >
> > Yes you're right. I added this check for safety, but this is not
> > mandatory.
> >
> > >
> > > >
> > > > @@ -11551,6 +11554,17 @@ static void set_cpu_sd_state_idle(int
> > > > cpu)
> > > >           rcu_read_unlock();
> > > >    }
> > > >
> > > > +void nohz_clean_sd_state(int cpu) {
> > > > +       struct rq *rq = cpu_rq(cpu);
> > > > +
> > > > +       rq->nohz_tick_stopped = 0;
> > > > +       if (cpumask_test_cpu(cpu, nohz.idle_cpus_mask)) {
> > > > +               cpumask_clear_cpu(cpu, nohz.idle_cpus_mask);
> > > > +               atomic_dec(&nohz.nr_cpus);
> > > > +       }
> > > > +       set_cpu_sd_state_idle(cpu);
> > > > +}
> > > > +
> > >
> > > detach_destroy_domains
> > >         cpu_attach_domain
> > >                 update_top_cache_domain
> > >
> > > as we clears per_cpu(sd_llc, cpu) for the isolated cpu in
> > > cpu_attach_domain(), set_cpu_sd_state_idle() seems to be a no-op
> > > here,
> > > no?
> >
> > Yes you're right, cpu_attach_domain() and nohz_clean_sd_state() calls
> > have to be inverted to avoid what you just described.
> >
> > It also seems that the current kernel doesn't decrease nr_busy_cpus
> > when putting CPUs in an isolated partition. Indeed if a CPU is
> > counted
> > in nr_busy_cpus, putting the CPU in an isolated partition doesn't
> > trigger
> > any call to set_cpu_sd_state_idle().
> > So it might an additional argument.
> >
> > Thanks for reading the patch,
> > Regards,
> > Pierre
> >
> > >
> > > thanks,
> > > rui
> > > >    /*
> > > >     * This routine will record that the CPU is going idle with
> > > > tick
> > > > stopped.
> > > >     * This info will be used in performing idle load balancing in
> > > > the
> > > > future.
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index d3a3b2646ec4..d31137b5f0ce 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -2584,8 +2584,10 @@ static void detach_destroy_domains(const
> > > > struct cpumask *cpu_map)
> > > >
> > > > static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
> > > >
> > > >           rcu_read_lock();
> > > > -       for_each_cpu(i, cpu_map)
> > > > +       for_each_cpu(i, cpu_map) {
> > > >                   cpu_attach_domain(NULL, &def_root_domain, i);
> > > > +               nohz_clean_sd_state(i);
> > > > +       }
> > > >           rcu_read_unlock();
> > > >    }
> > > >
> > > > --- snip ---
> > > >
> > > > Regards,
> > > > Pierre
> > > >
> > > > >
> > > > > >
> > > > > > > +       }
> > > > > > > +
> > > > > > >            /*
> > > > > > >             * The tick is still stopped but load could have
> > > > > > > been
> > > > > > > added in the
> > > > > > >             * meantime. We set the nohz.has_blocked flag to
> > > > > > > trig
> > > > > > > a
> > > > > > > check of the
> > > > > > > @@ -11585,10 +11609,6 @@ void nohz_balance_enter_idle(int
> > > > > > > cpu)
> > > > > > >            if (rq->nohz_tick_stopped)
> > > > > > >                    goto out;
> > > > > > > -       /* If we're a completely isolated CPU, we don't
> > > > > > > play:
> > > > > > > */
> > > > > > > -       if (on_null_domain(rq))
> > > > > > > -               return;
> > > > > > > -
> > > > > > >            rq->nohz_tick_stopped = 1;
> > > > > > >            cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
> > > > > > >
> > > > > > > Otherwise I could reproduce the issue and the patch was
> > > > > > > solving
> > > > > > > it,
> > > > > > > so:
> > > > > > > Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> > > > >
> > > > > Thanks for testing, really appreciated!
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Also, your patch doesn't aim to solve that, but I think
> > > > > > > there
> > > > > > > is an
> > > > > > > issue
> > > > > > > when updating cpuset.cpus when an isolated partition was
> > > > > > > already
> > > > > > > created:
> > > > > > >
> > > > > > > // Create an isolated partition containing CPU0
> > > > > > > # mkdir cgroup
> > > > > > > # mount -t cgroup2 none cgroup/
> > > > > > > # mkdir cgroup/Testing
> > > > > > > # echo "+cpuset" > cgroup/cgroup.subtree_control
> > > > > > > # echo "+cpuset" > cgroup/Testing/cgroup.subtree_control
> > > > > > > # echo 0 > cgroup/Testing/cpuset.cpus
> > > > > > > # echo isolated > cgroup/Testing/cpuset.cpus.partition
> > > > > > >
> > > > > > > // CPU0's sched domain is detached:
> > > > > > > # ls /sys/kernel/debug/sched/domains/cpu0/
> > > > > > > # ls /sys/kernel/debug/sched/domains/cpu1/
> > > > > > > domain0  domain1
> > > > > > >
> > > > > > > // Change the isolated partition to be CPU1
> > > > > > > # echo 1 > cgroup/Testing/cpuset.cpus
> > > > > > >
> > > > > > > // CPU[0-1] sched domains are not updated:
> > > > > > > # ls /sys/kernel/debug/sched/domains/cpu0/
> > > > > > > # ls /sys/kernel/debug/sched/domains/cpu1/
> > > > > > > domain0  domain1
> > > > > > >
> > > > > Interesting. Let me check and get back to you later on this. :)
> > > > >
> > > > > thanks,
> > > > > rui
> > >
>
