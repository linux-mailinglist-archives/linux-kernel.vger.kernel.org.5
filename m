Return-Path: <linux-kernel+bounces-63029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26668852981
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CC7281DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FC1642F;
	Tue, 13 Feb 2024 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhQFSqIX"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FD14296
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807690; cv=none; b=uXxgaoJX2c8liId9Aq8vmp4XEadKH7QkhR58YGx5SGSb+rFAXddgVHbxdGVB4EyMRqpDsy/Y/u10NFZG6Lv9Zz6aq7N68p3MbImkKjHMWHhI8y1eCeY7snTv04c9EJXU5oyRrHoWWhQPnFGMrsv3rm9BYyD/FPs8rFxcYYul2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807690; c=relaxed/simple;
	bh=khsTqwcZBQpWOoIsK0o01WdwNVeiq1TlWrkd2MONNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pq+xhXsZzX8A9+sBG9lTAjrVDvHTGmMXIwGerw6/FoU2m+CERrhR/dnPDzgHMYP2TdG6Qv+Z+qV7nI1c/pcJR1Jn49KiAHqK0f1gAffm9+mK34bor+VqI6LOuf3J+mALIzTtorbhXkfrrimSbhH3926bhM17gE3BgoorTvcndRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhQFSqIX; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4c02be905beso869653e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707807687; x=1708412487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/kNUrAzifjXolLE6vlI4p70yemYc9oxr9WZx3u7HYg=;
        b=XhQFSqIXkUtvZdJKpCti4Ffj7ZBprWTOKtsO8VeB0FAEcCbhXoQT64TsfA3Hv1/W5t
         8Eb91QgYTaFLFRUtD4NCO8b6hZnqB2HBY+fwUt/JOieucqVhtv1SGs+rnpiC5iyGyeVx
         4H3NeScQUJkOgi7AJPd4YHrrS4oJYN9cba+pKQdd40uHICYsKmu1ayPj7CiXFGcLrvIf
         UvoZKMnWpq9F1Hb+mpFFS/XJHn+q2iX82vIpmoS73L0tyr/GK1zmbjp9BJZl33MrkkEm
         8SZ5C58Rm+1ub0sYPgWgGqT7AAfcwqNdxR/Oj+OcrWinalENqgorq+MezgAbla7ij9r7
         rznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807687; x=1708412487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/kNUrAzifjXolLE6vlI4p70yemYc9oxr9WZx3u7HYg=;
        b=VO6EbGbCuJgvIF3VpFkkjsnbt7qQBRD4ZhjVIP7uxvGg+Zdu0jxFztz8zk/Wzkc9cr
         AYCuHSZqBefLB3SnE/atGFgDPnwYl20T8Vv0ucnkIWJCSKT4oyQXbzt+e+B8Q888YWG8
         IcIxu22MWZfEaKGpu5dpfG85XnGEc+lQQoDvzVp+E1FavseLUqEqYM4sjLERPNwGrqoH
         5QH2Zo+PThbPHkJntaGHc6RG36ybi/n5oJn2pMXmHQ7ALhUVNuHy+5Swn7BmluX0F3HC
         05yHV6qJT1CkGaEQAA/0fvcqbJibDXIqTNDdqxXmFpuKm/L2Xr1prqtoHS+18tqhu1Ex
         LUWA==
X-Forwarded-Encrypted: i=1; AJvYcCVftZGYUaUdiWGuAhZHDJau4oOA6vkTCGxPNAhEM0zPVTilF07XZgK7E91dP14IBqnj3Sh5kFDuQ1ncH2pIWyB9why6a5uKNpNAPZGp
X-Gm-Message-State: AOJu0Yy/nB07msSscOFS0swLfTo+T4EnONTEAHWOy4hEYcej1FofgVh0
	6QcHJAbTrPrcEl6ZXULHoAwpB6FfAeGNObRGHnMvuvVwIst5Z5ikpZlNjaGzRUu0bCQ22GT1f5j
	fHk8eXbgCUcSwWRVJM3LHwg9UBhQ=
X-Google-Smtp-Source: AGHT+IGfo5cJq0fnnJn9lzaamI7a6iXibVcud4a07s1EGG59Ltpz3aK+jFxzEV+9wBb82MmM/p7KN/7BNne/O+ZKcvw=
X-Received: by 2002:a1f:df42:0:b0:4c0:3000:8b26 with SMTP id
 w63-20020a1fdf42000000b004c030008b26mr5394444vkg.4.1707807687473; Mon, 12 Feb
 2024 23:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210113924.1130448-1-alexs@kernel.org> <20240210113924.1130448-5-alexs@kernel.org>
In-Reply-To: <20240210113924.1130448-5-alexs@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 13 Feb 2024 20:01:16 +1300
Message-ID: <CAGsJ_4wh6kDs_OqOae-HocKWR9SuVY=KJR7+W1v11mE=ym0nYg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] sched: rename SD_SHARE_PKG_RESOURCES to SD_SHARE_LLC
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Barry Song <song.bao.hua@hisilicon.com>, Mark Rutland <mark.rutland@arm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex, Valentin,


On Sun, Feb 11, 2024 at 12:37=E2=80=AFAM <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> SD_CLUSTER shares the CPU resources like llc tags or l2 cache, that's
> easy confuse with SD_SHARE_PKG_RESOURCES. So let's specifical point
> what the latter shares: LLC. That would reduce some confusing.

On neither JACOBSVILLE nor kunpeng920, it seems CLUSTER isn't LLC.
on Jacobsville, cluster is L2-cache while Jacobsville has L3; on kunpeng920=
,
cluster is L3-tag. On kunpeng920, actually 24 cpus or 32cpus share one LLC,
the whole L3. cluster is kind of like middle-level caches.

So I feel this patch isn't precise.

>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Barry Song <song.bao.hua@hisilicon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/powerpc/kernel/smp.c      |  6 +++---
>  include/linux/sched/sd_flags.h |  4 ++--
>  include/linux/sched/topology.h |  6 +++---
>  kernel/sched/fair.c            |  2 +-
>  kernel/sched/topology.c        | 28 ++++++++++++++--------------
>  5 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 693334c20d07..a60e4139214b 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -984,7 +984,7 @@ static bool shared_caches __ro_after_init;
>  /* cpumask of CPUs with asymmetric SMT dependency */
>  static int powerpc_smt_flags(void)
>  {
> -       int flags =3D SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> +       int flags =3D SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>
>         if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
>                 printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling=
\n");
> @@ -1010,9 +1010,9 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(splp=
ar_asym_pack);
>  static int powerpc_shared_cache_flags(void)
>  {
>         if (static_branch_unlikely(&splpar_asym_pack))
> -               return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
> +               return SD_SHARE_LLC | SD_ASYM_PACKING;
>
> -       return SD_SHARE_PKG_RESOURCES;
> +       return SD_SHARE_LLC;
>  }
>
>  static int powerpc_shared_proc_flags(void)
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flag=
s.h
> index a8b28647aafc..b04a5d04dee9 100644
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -117,13 +117,13 @@ SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SD=
F_NEEDS_GROUPS)
>  SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
>
>  /*
> - * Domain members share CPU package resources (i.e. caches)
> + * Domain members share CPU Last Level Caches
>   *
>   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longe=
r share
>   *               the same cache(s).
>   * NEEDS_GROUPS: Caches are shared between groups.
>   */
> -SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> +SD_FLAG(SD_SHARE_LLC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>
>  /*
>   * Only a single load balancing instance
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topolog=
y.h
> index a6e04b4a21d7..191b122158fb 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -38,21 +38,21 @@ extern const struct sd_flag_debug sd_flag_debug[];
>  #ifdef CONFIG_SCHED_SMT
>  static inline int cpu_smt_flags(void)
>  {
> -       return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> +       return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>  }
>  #endif
>
>  #ifdef CONFIG_SCHED_CLUSTER
>  static inline int cpu_cluster_flags(void)
>  {
> -       return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
> +       return SD_CLUSTER | SD_SHARE_LLC;
>  }
>  #endif
>
>  #ifdef CONFIG_SCHED_MC
>  static inline int cpu_core_flags(void)
>  {
> -       return SD_SHARE_PKG_RESOURCES;
> +       return SD_SHARE_LLC;
>  }
>  #endif
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cd1ec57c0b7b..da6c77d05d07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10687,7 +10687,7 @@ static inline void calculate_imbalance(struct lb_=
env *env, struct sd_lb_stats *s
>          */
>         if (local->group_type =3D=3D group_has_spare) {
>                 if ((busiest->group_type > group_fully_busy) &&
> -                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
> +                   !(env->sd->flags & SD_SHARE_LLC)) {
>                         /*
>                          * If busiest is overloaded, try to fill spare
>                          * capacity. This might end up creating spare cap=
acity
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 0b33f7b05d21..99ea5986038c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -657,13 +657,13 @@ static void destroy_sched_domains(struct sched_doma=
in *sd)
>  }
>
>  /*
> - * Keep a special pointer to the highest sched_domain that has
> - * SD_SHARE_PKG_RESOURCE set (Last Level Cache Domain) for this
> - * allows us to avoid some pointer chasing select_idle_sibling().
> + * Keep a special pointer to the highest sched_domain that has SD_SHARE_=
LLC set
> + * (Last Level Cache Domain) for this allows us to avoid some pointer ch=
asing
> + * select_idle_sibling().
>   *
> - * Also keep a unique ID per domain (we use the first CPU number in
> - * the cpumask of the domain), this allows us to quickly tell if
> - * two CPUs are in the same cache domain, see cpus_share_cache().
> + * Also keep a unique ID per domain (we use the first CPU number in the =
cpumask
> + * of the domain), this allows us to quickly tell if two CPUs are in the=
 same
> + * cache domain, see cpus_share_cache().
>   */
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
> @@ -684,7 +684,7 @@ static void update_top_cache_domain(int cpu)
>         int id =3D cpu;
>         int size =3D 1;
>
> -       sd =3D highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
> +       sd =3D highest_flag_domain(cpu, SD_SHARE_LLC);
>         if (sd) {
>                 id =3D cpumask_first(sched_domain_span(sd));
>                 size =3D cpumask_weight(sched_domain_span(sd));
> @@ -1554,7 +1554,7 @@ static struct cpumask             ***sched_domains_=
numa_masks;
>   * function. For details, see include/linux/sched/sd_flags.h.
>   *
>   *   SD_SHARE_CPUCAPACITY
> - *   SD_SHARE_PKG_RESOURCES
> + *   SD_SHARE_LLC
>   *   SD_CLUSTER
>   *   SD_NUMA
>   *
> @@ -1566,7 +1566,7 @@ static struct cpumask             ***sched_domains_=
numa_masks;
>  #define TOPOLOGY_SD_FLAGS              \
>         (SD_SHARE_CPUCAPACITY   |       \
>          SD_CLUSTER             |       \
> -        SD_SHARE_PKG_RESOURCES |       \
> +        SD_SHARE_LLC           |       \
>          SD_NUMA                |       \
>          SD_ASYM_PACKING)
>
> @@ -1609,7 +1609,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                                         | 0*SD_BALANCE_WAKE
>                                         | 1*SD_WAKE_AFFINE
>                                         | 0*SD_SHARE_CPUCAPACITY
> -                                       | 0*SD_SHARE_PKG_RESOURCES
> +                                       | 0*SD_SHARE_LLC
>                                         | 0*SD_SERIALIZE
>                                         | 1*SD_PREFER_SIBLING
>                                         | 0*SD_NUMA
> @@ -1646,7 +1646,7 @@ sd_init(struct sched_domain_topology_level *tl,
>         if (sd->flags & SD_SHARE_CPUCAPACITY) {
>                 sd->imbalance_pct =3D 110;
>
> -       } else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> +       } else if (sd->flags & SD_SHARE_LLC) {
>                 sd->imbalance_pct =3D 117;
>                 sd->cache_nice_tries =3D 1;
>
> @@ -1671,7 +1671,7 @@ sd_init(struct sched_domain_topology_level *tl,
>          * For all levels sharing cache; connect a sched_domain_shared
>          * instance.
>          */
> -       if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> +       if (sd->flags & SD_SHARE_LLC) {
>                 sd->shared =3D *per_cpu_ptr(sdd->sds, sd_id);
>                 atomic_inc(&sd->shared->ref);
>                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> @@ -2446,8 +2446,8 @@ build_sched_domains(const struct cpumask *cpu_map, =
struct sched_domain_attr *att
>                 for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent)=
 {
>                         struct sched_domain *child =3D sd->child;
>
> -                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && chil=
d &&
> -                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +                       if (!(sd->flags & SD_SHARE_LLC) && child &&
> +                           (child->flags & SD_SHARE_LLC)) {
>                                 struct sched_domain __rcu *top_p;
>                                 unsigned int nr_llcs;
>
> --
> 2.43.0
>
>

Thanks
Barry

