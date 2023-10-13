Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07F7C884A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjJMPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjJMPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:05:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1FCF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d113508bfso1726237a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697209498; x=1697814298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+et0olFKLIXuqTKZSNcjwQQhWaV7GbRhiBuQ9dyCjg=;
        b=ZNJCKShs7a7zRxTzZlGyL2f8CIUyAlqR3nMEmecXRrk3exAz5UjsGWMTG07w6Gw9MM
         DcnpBsT3O1aG9LvJdHO2UJc7cAJrgU7Jn0iq2edYUTJQcds/ONCEpQH9tzitgig8KHaf
         o33X2eG/XKYPsD8mgZt2qtoFP26AwiHBE2J8C6Qp7Ajz+oRKgu5kzC/P4NOPM1SRvhN1
         kocGecxW7PMjcy81Vz3dyR9FiSY6VyJh1KabMEJFjd7BwPld7kSfMPNocvojq9uSHOC8
         644UZN3b8G6Ag6w8P0VS4nxEoabGtfOVc4h9mvilZEqOzUH8E2WG6LIN3hQ9pDcG12fJ
         iu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209498; x=1697814298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+et0olFKLIXuqTKZSNcjwQQhWaV7GbRhiBuQ9dyCjg=;
        b=fZCxbblIYsiTMHkHX/LlNmazXD4vh6exWHp5BywJ2au7EpOWmXDoQsvy/4enqt3srA
         NQSivBPq/6zUgoqKV98K4VPaVVdOI3tx5A9l2njfQx7GyI+I6/phkAcnEU0c5ElAn5bQ
         ASNrvPNGWkEy0BQXqUbHzOh0VaxfwfGHOmGRyL9jRqWvv5XEjdGjyWhw+BS0JjHqsa8x
         C+mqnU3PkR2gfU83AOH7kgyThTRgX4hlxbCQeM7s3BlM4eS4+V04qAOkjA0uSnN/T1mX
         ZLe9L1XK14/G3BNQfL+eKH52jLN5XW4jMx2xMw1M4Zg5geJ+z95cxYbRd5YEBpG3t4zR
         OS4Q==
X-Gm-Message-State: AOJu0YxvRNe2MSjGDQo6lGbi5nfVd/NQlq9TiPANg4Lgj5B50/dxQhPR
        lKmHAXaPWLAItHz3An6X4S3lIuxfA45Ch+V33WMevg==
X-Google-Smtp-Source: AGHT+IFK0CFw7xaGvqVkt3sgwb78rKASish563wiH8oSU4hu23qMPOyXDObZI4LbnPWVJuB65SO+wT5dAgMZN8/FLpU=
X-Received: by 2002:a17:90a:6641:b0:27d:2054:9641 with SMTP id
 f1-20020a17090a664100b0027d20549641mr4920503pjm.36.1697209498275; Fri, 13 Oct
 2023 08:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121707.51368-1-yangyicong@huawei.com> <20231012121707.51368-3-yangyicong@huawei.com>
In-Reply-To: <20231012121707.51368-3-yangyicong@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Oct 2023 17:04:46 +0200
Message-ID: <CAKfTPtAtXYQ0LBwRo-RRcoFDTCn4_BGhJDCjH8PAhSgmAbs+bw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, tim.c.chen@linux.intel.com,
        yu.c.chen@intel.com, gautham.shenoy@amd.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 14:19, Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency. This
> will be implemented in 2 steps in select_idle_sibling():
> 1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
>    if they're sharing cluster with the target CPU. Otherwise trying to
>    scan for an idle CPU in the target's cluster.
> 2. Scanning the cluster prior to the LLC of the target CPU for an
>    idle CPU to wakeup.
>
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
>
> With this patch, We noticed enhancement on tbench and netperf within one
> numa or cross two numa on top of tip-sched-core commit
> 9b46f1abc6d4 ("sched/debug: Print 'tgid' in sched_show_task()")
>
> tbench results (node 0):
>             baseline                     patched
>   1:        327.2833        372.4623 (   13.80%)
>   4:       1320.5933       1479.8833 (   12.06%)
>   8:       2638.4867       2921.5267 (   10.73%)
>  16:       5282.7133       5891.5633 (   11.53%)
>  32:       9810.6733       9877.3400 (    0.68%)
>  64:       7408.9367       7447.9900 (    0.53%)
> 128:       6203.2600       6191.6500 (   -0.19%)
> tbench results (node 0-1):
>             baseline                     patched
>   1:        332.0433        372.7223 (   12.25%)
>   4:       1325.4667       1477.6733 (   11.48%)
>   8:       2622.9433       2897.9967 (   10.49%)
>  16:       5218.6100       5878.2967 (   12.64%)
>  32:      10211.7000      11494.4000 (   12.56%)
>  64:      13313.7333      16740.0333 (   25.74%)
> 128:      13959.1000      14533.9000 (    4.12%)
>
> netperf results TCP_RR (node 0):
>             baseline                     patched
>   1:      76546.5033      90649.9867 (   18.42%)
>   4:      77292.4450      90932.7175 (   17.65%)
>   8:      77367.7254      90882.3467 (   17.47%)
>  16:      78519.9048      90938.8344 (   15.82%)
>  32:      72169.5035      72851.6730 (    0.95%)
>  64:      25911.2457      25882.2315 (   -0.11%)
> 128:      10752.6572      10768.6038 (    0.15%)
>
> netperf results TCP_RR (node 0-1):
>             baseline                     patched
>   1:      76857.6667      90892.2767 (   18.26%)
>   4:      78236.6475      90767.3017 (   16.02%)
>   8:      77929.6096      90684.1633 (   16.37%)
>  16:      77438.5873      90502.5787 (   16.87%)
>  32:      74205.6635      88301.5612 (   19.00%)
>  64:      69827.8535      71787.6706 (    2.81%)
> 128:      25281.4366      25771.3023 (    1.94%)
>
> netperf results UDP_RR (node 0):
>             baseline                     patched
>   1:      96869.8400     110800.8467 (   14.38%)
>   4:      97744.9750     109680.5425 (   12.21%)
>   8:      98783.9863     110409.9637 (   11.77%)
>  16:      99575.0235     110636.2435 (   11.11%)
>  32:      95044.7250      97622.8887 (    2.71%)
>  64:      32925.2146      32644.4991 (   -0.85%)
> 128:      12859.2343      12824.0051 (   -0.27%)
>
> netperf results UDP_RR (node 0-1):
>             baseline                     patched
>   1:      97202.4733     110190.1200 (   13.36%)
>   4:      95954.0558     106245.7258 (   10.73%)
>   8:      96277.1958     105206.5304 (    9.27%)
>  16:      97692.7810     107927.2125 (   10.48%)
>  32:      79999.6702     103550.2999 (   29.44%)
>  64:      80592.7413      87284.0856 (    8.30%)
> 128:      27701.5770      29914.5820 (    7.99%)
>
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> in the code has not been tested but it supposed to work.
>
> Chen Yu also noticed this will improve the performance of tbench and
> netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
> cluster sharing L2 Cache.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 12 ++++++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 666ece65987f..4039f9b348ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7259,6 +7259,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 }
>         }
>
> +       if (static_branch_unlikely(&sched_cluster_active)) {
> +               struct sched_group *sg = sd->groups;
> +
> +               if (sg->flags & SD_CLUSTER) {
> +                       for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
> +                               if (!cpumask_test_cpu(cpu, cpus))
> +                                       continue;
> +
> +                               if (has_idle_core) {
> +                                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +                                       if ((unsigned int)i < nr_cpumask_bits)
> +                                               return i;
> +                               } else {
> +                                       if (--nr <= 0)
> +                                               return -1;
> +                                       idle_cpu = __select_idle_cpu(cpu, p);
> +                                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                                               return idle_cpu;
> +                               }
> +                       }
> +                       cpumask_andnot(cpus, cpus, sched_group_span(sg));
> +               }
> +       }
> +
>         for_each_cpu_wrap(cpu, cpus, target + 1) {
>                 if (has_idle_core) {
>                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -7266,7 +7290,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                                 return i;
>
>                 } else {
> -                       if (!--nr)
> +                       if (--nr <= 0)
>                                 return -1;
>                         idle_cpu = __select_idle_cpu(cpu, p);
>                         if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -7395,8 +7419,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          */
>         if (prev != target && cpus_share_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -           asym_fits_cpu(task_util, util_min, util_max, prev))
> -               return prev;
> +           asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +               if (!static_branch_unlikely(&sched_cluster_active))
> +                       return prev;
> +
> +               if (cpus_share_resources(prev, target))
> +                       return prev;
> +       }
>
>         /*
>          * Allow a per-cpu kthread to stack with the wakee if the
> @@ -7423,7 +7452,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>             (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>             cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>             asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
> -               return recent_used_cpu;
> +               if (!static_branch_unlikely(&sched_cluster_active))
> +                       return recent_used_cpu;
> +
> +               if (cpus_share_resources(recent_used_cpu, target))
> +                       return recent_used_cpu;
>         }
>
>         /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 998f03d02de0..ef4fe7bcf740 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1859,6 +1859,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
> +extern struct static_key_false sched_cluster_active;
>
>  static __always_inline bool sched_asym_cpucap_active(void)
>  {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 48cd88350d18..925cd68abc8b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -673,7 +673,9 @@ DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> +
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> +DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
>
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -2386,6 +2388,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         struct rq *rq = NULL;
>         int i, ret = -ENOMEM;
>         bool has_asym = false;
> +       bool has_cluster = false;
>
>         if (WARN_ON(cpumask_empty(cpu_map)))
>                 goto error;
> @@ -2514,12 +2517,18 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                         WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
>
>                 cpu_attach_domain(sd, d.rd, i);
> +
> +               if (lowest_flag_domain(i, SD_CLUSTER))
> +                       has_cluster = true;
>         }
>         rcu_read_unlock();
>
>         if (has_asym)
>                 static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>
> +       if (has_cluster)
> +               static_branch_inc_cpuslocked(&sched_cluster_active);
> +
>         if (rq && sched_debug_verbose) {
>                 pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>                         cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> @@ -2619,6 +2628,9 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>         if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
>                 static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
>
> +       if (static_branch_unlikely(&sched_cluster_active))
> +               static_branch_dec_cpuslocked(&sched_cluster_active);
> +
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map)
>                 cpu_attach_domain(NULL, &def_root_domain, i);
> --
> 2.24.0
>
