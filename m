Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636E781EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHTP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHTPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:25:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E0D4681
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:23:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d20548adso2198745f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544986; x=1693149786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykld1qIMTeygSSXjT22gXf+zDl3D9IKO0+MSSZhnOik=;
        b=GRjxvZEmUob8EflkJ1mXNWjLQnaDvPmp8gB2ImsRXj6cpTyd5ut0y2EpvrAadDYeyZ
         L39CbvdWmswIney/9YGKi23ILmIuFdYZB+4DpOMi7ao2AAcj7FoI812lU1FA+NUFmrUK
         yXe+4O/zQhkBUIRbKTuGAj1lyNmZCleo5iKIW+7L+MdXAO6t5Bz51qwDl/qOd0HYhec3
         EthXFddQk2pA36+8oqvRp+5dplSqBCQEv/kn594Vf0ESmZ3/SeJG12ewScw1f0Sv7SFG
         OgZJOob6GpN32+nPYtiZHEDAbTWcvksjj8S0tZoKIOV94yQYpW3jg0VddQCkTwTpQX9u
         R1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544986; x=1693149786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykld1qIMTeygSSXjT22gXf+zDl3D9IKO0+MSSZhnOik=;
        b=D0/PivaSgFDuGG0Z+6AiP+DDBymzpQkqZua4u3KOspl+Wh9rWOPebo58SyjKPH1/pP
         1RVU3WTamfbtz4Xt6+27E21hFje5B1lMpY8nrMfO/um8e5eWaEBweammiTmjvJC75bJE
         25fLRL30me788hefT3QBVlP8CICRONVYwRsrV00IbebgpMhf+lRj6Irnjx8QoUJizXZj
         acOHR8or2BDrQ3CTl/JPpfJhHOwjQL/v89BlIUMPxgEmY7kbOtzXufGa7SWGlt67Myl0
         9AHTo3V8fuXP0TVpN2OEtrSieqChMUPhHAbRTocElBiRzrnbzpZNYf74uUI5EfF+nFmi
         tmQw==
X-Gm-Message-State: AOJu0YxjTXszfwRCIeoOO24Q4xy+OJEG7QAzdtUSe6N3AP6vJba/7VRa
        VimQRZv8OhNwGNA//LM1nSDEPQ==
X-Google-Smtp-Source: AGHT+IEwtn7wzr3BWhlssYv4/XwXPq5+U1eC+vk7t3Ja1T0MVYloGPH7ZZybOVq98QYaqFC+drdwoQ==
X-Received: by 2002:a5d:678c:0:b0:31a:e76f:9d16 with SMTP id v12-20020a5d678c000000b0031ae76f9d16mr2799075wru.71.1692544985687;
        Sun, 20 Aug 2023 08:23:05 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:05 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Date:   Sun, 20 Aug 2023 16:22:54 +0100
Message-Id: <20230820152258.518128-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152258.518128-1-qyousef@layalina.io>
References: <20230820152258.518128-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit 111cd11bbc54850f24191c52ff217da88a5e639b upstream.

Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
as it has been reported to cause slowdowns in workloads that need to
change cpuset configuration frequently and it is also not implementing
priority inheritance (which causes troubles with realtime workloads).

Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
only for SCHED_DEADLINE tasks (other policies don't care about stable
cpusets anyway).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 111cd11bbc54850f24191c52ff217da88a5e639b)
[Conflict in kernel/cgroup/cpuset.c due to pulling changes in functions
or comments that don't exist on this branch. Remove a BUG_ON() for rwsem
that doesn't exist on mainline.]
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/cpuset.h |   8 +--
 kernel/cgroup/cpuset.c | 149 ++++++++++++++++++++---------------------
 kernel/sched/core.c    |  22 ++++--
 3 files changed, 93 insertions(+), 86 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d2b9c41c8edf..5a94f5143924 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -56,8 +56,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
-extern void cpuset_read_lock(void);
-extern void cpuset_read_unlock(void);
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -179,8 +179,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
-static inline void cpuset_read_lock(void) { }
-static inline void cpuset_read_unlock(void) { }
+static inline void cpuset_lock(void) { }
+static inline void cpuset_unlock(void) { }
 
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index de078f6c1144..0eff9fb4e6d3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -312,22 +312,23 @@ static struct cpuset top_cpuset = {
 		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_rwsem and
+ * There are two global locks guarding cpuset structures - cpuset_mutex and
  * callback_lock. We also require taking task_lock() when dereferencing a
  * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
- * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
- * prevent change to cpuset structures.
+ * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
+ * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
+ * structures. Note that cpuset_mutex needs to be a mutex as it is used in
+ * paths that rely on priority inheritance (e.g. scheduler - on RT) for
+ * correctness.
  *
  * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
- * is the only task able to also acquire callback_lock and be able to
- * modify cpusets.  It can perform various checks on the cpuset structure
- * first, knowing nothing will change.  It can also allocate memory while
- * just holding cpuset_rwsem.  While it is performing these checks, various
- * callback routines can briefly acquire callback_lock to query cpusets.
- * Once it is ready to make the changes, it takes callback_lock, blocking
- * everyone else.
+ * cpuset_mutex, it blocks others, ensuring that it is the only task able to
+ * also acquire callback_lock and be able to modify cpusets.  It can perform
+ * various checks on the cpuset structure first, knowing nothing will change.
+ * It can also allocate memory while just holding cpuset_mutex.  While it is
+ * performing these checks, various callback routines can briefly acquire
+ * callback_lock to query cpusets.  Once it is ready to make the changes, it
+ * takes callback_lock, blocking everyone else.
  *
  * Calls to the kernel memory allocator can not be made while holding
  * callback_lock, as that would risk double tripping on callback_lock
@@ -349,16 +350,16 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+static DEFINE_MUTEX(cpuset_mutex);
 
-void cpuset_read_lock(void)
+void cpuset_lock(void)
 {
-	percpu_down_read(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
-void cpuset_read_unlock(void)
+void cpuset_unlock(void)
 {
-	percpu_up_read(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 static DEFINE_SPINLOCK(callback_lock);
@@ -396,7 +397,7 @@ static inline bool is_in_v2_mode(void)
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
@@ -438,7 +439,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
@@ -450,7 +451,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void cpuset_update_task_spread_flag(struct cpuset *cs,
 					struct task_struct *tsk)
@@ -471,7 +472,7 @@ static void cpuset_update_task_spread_flag(struct cpuset *cs,
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_rwsem.
+ * are only set if the other's are set.  Call holding cpuset_mutex.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -580,7 +581,7 @@ static inline void free_cpuset(struct cpuset *cs)
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_rwsem held.
+ * cpuset_mutex held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -703,7 +704,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
-/* Must be called with cpuset_rwsem held.  */
+/* Must be called with cpuset_mutex held.  */
 static inline int nr_cpusets(void)
 {
 	/* jump label reference count + the top-level cpuset */
@@ -729,7 +730,7 @@ static inline int nr_cpusets(void)
  * domains when operating in the severe memory shortage situations
  * that could cause allocation failures below.
  *
- * Must be called with cpuset_rwsem held.
+ * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
  *    cp - cpuset pointer, used (together with pos_css) to perform a
@@ -958,7 +959,7 @@ static void dl_rebuild_rd_accounting(void)
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -1008,7 +1009,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_rwsem held.  Takes cpus_read_lock().
+ * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1019,7 +1020,7 @@ static void rebuild_sched_domains_locked(void)
 	int ndoms;
 
 	lockdep_assert_cpus_held();
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1070,9 +1071,9 @@ static void rebuild_sched_domains_locked(void)
 void rebuild_sched_domains(void)
 {
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	rebuild_sched_domains_locked();
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -1081,7 +1082,7 @@ void rebuild_sched_domains(void)
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
 static void update_tasks_cpumask(struct cpuset *cs)
@@ -1188,7 +1189,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	int old_prs, new_prs;
 	bool part_error = false;	/* Partition error? */
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * The parent must be a partition root.
@@ -1358,7 +1359,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
  *
  * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 {
@@ -1521,7 +1522,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -1724,12 +1725,12 @@ static void *cpuset_being_rebound;
  * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its mems_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
 static void update_tasks_nodemask(struct cpuset *cs)
 {
-	static nodemask_t newmems;	/* protected by cpuset_rwsem */
+	static nodemask_t newmems;	/* protected by cpuset_mutex */
 	struct css_task_iter it;
 	struct task_struct *task;
 
@@ -1742,7 +1743,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	 * take while holding tasklist_lock.  Forks can happen - the
 	 * mpol_dup() cpuset_being_rebound check will catch such forks,
 	 * and rebind their vma mempolicies too.  Because we still hold
-	 * the global cpuset_rwsem, we know that no other rebind effort
+	 * the global cpuset_mutex, we know that no other rebind effort
 	 * will be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -1788,7 +1789,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  *
  * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 {
@@ -1841,7 +1842,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  * mempolicies and if the cpuset is marked 'memory_migrate',
  * migrate the tasks pages to the new memory.
  *
- * Call with cpuset_rwsem held. May take callback_lock during call.
+ * Call with cpuset_mutex held. May take callback_lock during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_lock, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -1931,7 +1932,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_rwsem held, cpuset membership stays
+ * function is called with cpuset_mutex held, cpuset membership stays
  * stable.
  */
 static void update_tasks_flags(struct cpuset *cs)
@@ -1951,7 +1952,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -2000,7 +2001,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * cs: the cpuset to update
  * new_prs: new partition root state
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
@@ -2182,7 +2183,7 @@ static int fmeter_getrate(struct fmeter *fmp)
 
 static struct cpuset *cpuset_attach_old_cs;
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
+/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -2194,7 +2195,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
@@ -2218,7 +2219,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress++;
 	ret = 0;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -2230,15 +2231,15 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
- * Protected by cpuset_rwsem.  cpus_attach is used only by cpuset_attach()
+ * Protected by cpuset_mutex.  cpus_attach is used only by cpuset_attach()
  * but we can't allocate it dynamically there.  Define it global and
  * allocate from cpuset_init().
  */
@@ -2246,7 +2247,7 @@ static cpumask_var_t cpus_attach;
 
 static void cpuset_attach(struct cgroup_taskset *tset)
 {
-	/* static buf protected by cpuset_rwsem */
+	/* static buf protected by cpuset_mutex */
 	static nodemask_t cpuset_attach_nodemask_to;
 	struct task_struct *task;
 	struct task_struct *leader;
@@ -2258,7 +2259,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
@@ -2310,7 +2311,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2342,7 +2343,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2378,7 +2379,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2391,7 +2392,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = -ENODEV;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2404,7 +2405,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2437,7 +2438,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
+	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
 	 * hierarchies.
 	 */
 	css_get(&cs->css);
@@ -2445,7 +2446,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	flush_work(&cpuset_hotplug_work);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2469,7 +2470,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
@@ -2602,13 +2603,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
 	css_get(&cs->css);
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	css_put(&cs->css);
 	return retval ?: nbytes;
@@ -2821,7 +2822,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		return 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -2872,7 +2873,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return 0;
 }
@@ -2893,7 +2894,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	struct cpuset *cs = css_cs(css);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	if (is_partition_root(cs))
 		update_prstate(cs, 0);
@@ -2912,7 +2913,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -2925,7 +2926,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -2938,7 +2939,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -2980,8 +2981,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 
 int __init cpuset_init(void)
 {
-	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
-
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
@@ -3053,7 +3052,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3063,7 +3062,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
 static void
@@ -3113,14 +3112,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		percpu_up_write(&cpuset_rwsem);
+		mutex_unlock(&cpuset_mutex);
 		goto retry;
 	}
 
@@ -3198,7 +3197,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /**
@@ -3228,7 +3227,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3285,7 +3284,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
@@ -3695,7 +3694,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
+ *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
  *    anyway.
  */
 int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d34a56f16d13..8a8c9220f4d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7309,6 +7309,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq *rq;
+	bool cpuset_locked = false;
 
 	/* The pi code expects interrupts enabled */
 	BUG_ON(pi && in_interrupt());
@@ -7405,8 +7406,14 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (pi)
-		cpuset_read_lock();
+	/*
+	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
+	 * information.
+	 */
+	if (dl_policy(policy) || dl_policy(p->policy)) {
+		cpuset_locked = true;
+		cpuset_lock();
+	}
 
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
@@ -7482,8 +7489,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (pi)
-			cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -7550,7 +7557,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
-		cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		rt_mutex_adjust_pi(p);
 	}
 
@@ -7562,8 +7570,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	if (pi)
-		cpuset_read_unlock();
+	if (cpuset_locked)
+		cpuset_unlock();
 	return retval;
 }
 
-- 
2.34.1

