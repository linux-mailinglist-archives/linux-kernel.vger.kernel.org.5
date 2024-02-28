Return-Path: <linux-kernel+bounces-85750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4886BA50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E450E1C2103A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77472919;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Xl8LWtC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UW06OQNq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656B86241;
	Wed, 28 Feb 2024 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157615; cv=none; b=laOkWyklLPwy/wxRgWjBmO9JyxI68BHyBmw3YTHbJq35EO+/07OQZ3N/nrgCM19yMpuFzqfJ24LGkaKen2WqqKwEddRKjD2kwPBnBo4jxA9ce83JhRB5nDIKoTDakUvFXIQVToL+jJd35BBfWpkzGxjxwso990xQmwkvYjZJaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157615; c=relaxed/simple;
	bh=rxsl6G8H4reZZFJiU0FVX2swHQMF4ZVarS+ieSrkHus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FJwqAB0FQd1ID0Plwfc5lMu5G1fDWCmj1Y/Icnl+QKclr1o1oYl3uMKzScBXHd0CJHRWt5sJg+/OhTxegipLZmqWqN5Q752OjxRbsthVSRl65vMYQch6iepFhcwRaCcmi9UalvSMgdmm8FmyCmFohG6xFi04m67XQr8WrtE1IuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Xl8LWtC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UW06OQNq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od3s+KkUs6tXEclVji6b7Vsrc6PV+vWDb75szXQ+xmY=;
	b=4Xl8LWtCCp75QIUVdpeKjDtrjmBzRD8I3HJGA/ZwT11wEWvRcyK3vIzJtq5OWVb6jCKspK
	A7RZLM3rnobkhlTlFXvGJDwSjLg7QEIuWC1ptF2H1acttRnuQr2g6W7bxIzFX0VxmD8rAe
	o3oMYOzpS7Zaldq3TilNQ5KGNHiXAJEVH+X8GeO2mMQqQVKmVhtaXc+015t7J1S+K58weu
	NyQTJsXtm/+Gkyo00vfYOT86sddw+HFaCQ8ykaZBEYfDBZWAUUYRwze8O+AYxE9byBqCu5
	+XgIRMoZK4BTKrxJXA2jxrcnA+5TIGkJbyvuRV5ILMrbgEv3MTeM4PBWZtoFhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od3s+KkUs6tXEclVji6b7Vsrc6PV+vWDb75szXQ+xmY=;
	b=UW06OQNqWl5taKL8XiGYOPq1B3KniRZpRc86sdbGbFxaAjulCIMSERWLZCITHdgRQEClKC
	u22fl0Up/AVpuFBg==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Rename SD_SHARE_PKG_RESOURCES to
 SD_SHARE_LLC
Cc: Valentin Schneider <vschneid@redhat.com>, Alex Shi <alexs@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Barry Song <baohua@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240210113924.1130448-5-alexs@kernel.org>
References: <20240210113924.1130448-5-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760355.398.15431397062984291541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     54de442747037485da1fc4eca9636287a61e97e3
Gitweb:        https://git.kernel.org/tip/54de442747037485da1fc4eca9636287a61e97e3
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Sat, 10 Feb 2024 19:39:23 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:43:17 +01:00

sched/topology: Rename SD_SHARE_PKG_RESOURCES to SD_SHARE_LLC

SD_SHARE_PKG_RESOURCES is a bit of a misnomer: its naming suggests that
it's sharing all 'package resources' - while in reality it's specifically
for sharing the LLC only.

Rename it to SD_SHARE_LLC to reduce confusion.

[ mingo: Rewrote the confusing changelog as well. ]

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Link: https://lore.kernel.org/r/20240210113924.1130448-5-alexs@kernel.org
---
 arch/powerpc/kernel/smp.c      |  6 +++---
 include/linux/sched/sd_flags.h |  4 ++--
 include/linux/sched/topology.h |  6 +++---
 kernel/sched/fair.c            |  2 +-
 kernel/sched/topology.c        | 28 ++++++++++++++--------------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 693334c..a60e413 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -984,7 +984,7 @@ static bool shared_caches __ro_after_init;
 /* cpumask of CPUs with asymmetric SMT dependency */
 static int powerpc_smt_flags(void)
 {
-	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 
 	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
@@ -1010,9 +1010,9 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(splpar_asym_pack);
 static int powerpc_shared_cache_flags(void)
 {
 	if (static_branch_unlikely(&splpar_asym_pack))
-		return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
+		return SD_SHARE_LLC | SD_ASYM_PACKING;
 
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_LLC;
 }
 
 static int powerpc_shared_proc_flags(void)
diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index a8b2864..b04a5d0 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -117,13 +117,13 @@ SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
 
 /*
- * Domain members share CPU package resources (i.e. caches)
+ * Domain members share CPU Last Level Caches
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
  *               the same cache(s).
  * NEEDS_GROUPS: Caches are shared between groups.
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_SHARE_LLC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Only a single load balancing instance
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4..191b122 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -38,21 +38,21 @@ extern const struct sd_flag_debug sd_flag_debug[];
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
-	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 }
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
 static inline int cpu_cluster_flags(void)
 {
-	return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
+	return SD_CLUSTER | SD_SHARE_LLC;
 }
 #endif
 
 #ifdef CONFIG_SCHED_MC
 static inline int cpu_core_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_LLC;
 }
 #endif
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39781a6..6a16129 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10678,7 +10678,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (local->group_type == group_has_spare) {
 		if ((busiest->group_type > group_fully_busy) &&
-		    !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
+		    !(env->sd->flags & SD_SHARE_LLC)) {
 			/*
 			 * If busiest is overloaded, try to fill spare
 			 * capacity. This might end up creating spare capacity
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0b33f7b..99ea598 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -657,13 +657,13 @@ static void destroy_sched_domains(struct sched_domain *sd)
 }
 
 /*
- * Keep a special pointer to the highest sched_domain that has
- * SD_SHARE_PKG_RESOURCE set (Last Level Cache Domain) for this
- * allows us to avoid some pointer chasing select_idle_sibling().
+ * Keep a special pointer to the highest sched_domain that has SD_SHARE_LLC set
+ * (Last Level Cache Domain) for this allows us to avoid some pointer chasing
+ * select_idle_sibling().
  *
- * Also keep a unique ID per domain (we use the first CPU number in
- * the cpumask of the domain), this allows us to quickly tell if
- * two CPUs are in the same cache domain, see cpus_share_cache().
+ * Also keep a unique ID per domain (we use the first CPU number in the cpumask
+ * of the domain), this allows us to quickly tell if two CPUs are in the same
+ * cache domain, see cpus_share_cache().
  */
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
@@ -684,7 +684,7 @@ static void update_top_cache_domain(int cpu)
 	int id = cpu;
 	int size = 1;
 
-	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
+	sd = highest_flag_domain(cpu, SD_SHARE_LLC);
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
@@ -1554,7 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
  * function. For details, see include/linux/sched/sd_flags.h.
  *
  *   SD_SHARE_CPUCAPACITY
- *   SD_SHARE_PKG_RESOURCES
+ *   SD_SHARE_LLC
  *   SD_CLUSTER
  *   SD_NUMA
  *
@@ -1566,7 +1566,7 @@ static struct cpumask		***sched_domains_numa_masks;
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_CLUSTER		|	\
-	 SD_SHARE_PKG_RESOURCES |	\
+	 SD_SHARE_LLC		|	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
 
@@ -1609,7 +1609,7 @@ sd_init(struct sched_domain_topology_level *tl,
 					| 0*SD_BALANCE_WAKE
 					| 1*SD_WAKE_AFFINE
 					| 0*SD_SHARE_CPUCAPACITY
-					| 0*SD_SHARE_PKG_RESOURCES
+					| 0*SD_SHARE_LLC
 					| 0*SD_SERIALIZE
 					| 1*SD_PREFER_SIBLING
 					| 0*SD_NUMA
@@ -1646,7 +1646,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->imbalance_pct = 110;
 
-	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+	} else if (sd->flags & SD_SHARE_LLC) {
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
 
@@ -1671,7 +1671,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	 * For all levels sharing cache; connect a sched_domain_shared
 	 * instance.
 	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+	if (sd->flags & SD_SHARE_LLC) {
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
@@ -2446,8 +2446,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
 			struct sched_domain *child = sd->child;
 
-			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
-			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+			if (!(sd->flags & SD_SHARE_LLC) && child &&
+			    (child->flags & SD_SHARE_LLC)) {
 				struct sched_domain __rcu *top_p;
 				unsigned int nr_llcs;
 

