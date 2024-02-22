Return-Path: <linux-kernel+bounces-76858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0B385FDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59949B294A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1014F9ED;
	Thu, 22 Feb 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XbcuucOO"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C01151CFE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618184; cv=none; b=bzDVVoyQ7uMLegWRPp5CJ9miceB7suSzWG4AG5MrqrjSMmWrnWWVm85gq+eyzBRBMM9lRmRKLoKH8e+zC4Kq9fOlS4skBA2rqCXn7DUSJEVC4aw3YjZZAUC/uqoZfvhSok0IEPRKFuven+PXjt7L85VqJvG9vd92fG3WzPNg//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618184; c=relaxed/simple;
	bh=xjMlJtfruqUfZj2OYIDLZkQ266LadH8pA9nKVTQ3HWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNEh1+4X6Xhyvsu7dciCgdB76koqQDsgBVy3k1zgI0LKGtXaf6Jp1iOW0YMcfwdeQIm1RhjOS7KctUzvnzSbdenHKDpkKgVEwM8WAkpv+dUvMUjKqJevUf36hCp7O555lqpZt5omaYOQoUncvrFqnU/ye+MixMpt4M53xi2/F4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XbcuucOO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0988840CA1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708618174;
	bh=eBplvN3ic9Md7sFZUiWCyi4FDjlzyr+G9b7VtYMVqc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=XbcuucOO8OEakvy4DB9fXyvr9rNK64H4FEm2qvNkvKMEtNPyF48btNZH/PRykk0uf
	 45WYYeQ1tJrNQ6Ah97ne4TFBNE4B3797n2HFzVYgcsv6DxKMdYkJFPJL3crRuGkjlG
	 kkCfj3EZYAPhCDs5wW121fqIiYI0RCk6GdKThXJ2bjuMtwXBJsjzU3xEwrrusJe4HE
	 BqYTQq6TIsjzQJ4a/gtm9/jofH/ACeMrXeZeE9UGam7VA8qSS/JpLMRszhCv/0kuy1
	 lIVERHWQGrxUD4cYinMVrKwUPAd0u47Q9iYZ9Wv+fC3vrI+CItHqM+/BgNXcJLdxeM
	 PNl9KbYK9t2WQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-559555e38b0so1973801a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618173; x=1709222973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBplvN3ic9Md7sFZUiWCyi4FDjlzyr+G9b7VtYMVqc0=;
        b=r0tr0V0hqZ74eR4UDXYZ43fFBN4HruXZKdwXsHSJf9niD/kCw8XbIeLXhH6auBACMD
         mJSI8BMcsTxVqxT52hwHYxM9t0WnQLIropDnfSsEhkCcQGxrCaWzr3yMianIMRUwosP6
         x2IUg2cKFSZyICgq4/qdDpGaTqP3msF8BuFjrsOXF93qAssNmLKyvZ9UWAqLWL6lhBwf
         87Tkueb7Kiu1r84nU4WxNVWTzmXw74iRD7ALvPw1ZutIj3Ao/ARe6kAw5X8assbiZYnT
         AEM3jPic4FhR6kFoUl6254J7IKFDW+RlCiDJSnjq8Rp2ZjnWd5adin3jKnwaZlJ25aol
         au9w==
X-Forwarded-Encrypted: i=1; AJvYcCXiCDEdjxAQOo9KcSLIy31suHktgoAgo7KlnTQsTQ5vkrxS6rbN0+rlEO57QTlueZ2JAn4OzhM0PHllj4K7fZbV6CA5ZjNWPK/0Mgni
X-Gm-Message-State: AOJu0YxbecTfsYjvPXOdfz54sfsbXMQVXt99pKtZ7X8HZEFX5NwPX/VD
	+Bu4nw9BbJIcCSch50H2Dncqa7XPG36Xvy7he1skYeI750pGlYmkhhnYgSnfitrIaxW1HwPy1ZW
	JuVQOipnuCQ9IyzkAwu/SmvF4VoemgHYcq1WoV/f6cNvC1+HfKyS4ezaYCJbogtZ1sGd10T0vxx
	F6XA==
X-Received: by 2002:a05:6402:1812:b0:564:ab98:35ea with SMTP id g18-20020a056402181200b00564ab9835eamr7648757edy.12.1708618172564;
        Thu, 22 Feb 2024 08:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh2FgKMtuawdsf6MkqOgsMe9TeKMVvzH9d2cfSiKaJyq4X3wXPmJLYfAoyXWWksM8sNakN9w==
X-Received: by 2002:a05:6402:1812:b0:564:ab98:35ea with SMTP id g18-20020a056402181200b00564ab9835eamr7648739edy.12.1708618172295;
        Thu, 22 Feb 2024 08:09:32 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b00563f8233ba8sm5675001edb.7.2024.02.22.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:09:31 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	linux-kernel@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 1/2] pid: allow pid_max to be set per pid namespace
Date: Thu, 22 Feb 2024 17:09:14 +0100
Message-Id: <20240222160915.315255-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <christian.brauner@ubuntu.com>

The pid_max sysctl is a global value. For a long time the default value
has been 65535 and during the pidfd dicussions Linus proposed to bump
pid_max by default (cf. [1]). Based on this discussion systemd started
bumping pid_max to 2^22. So all new systems now run with a very high
pid_max limit with some distros having also backported that change.
The decision to bump pid_max is obviously correct. It just doesn't make
a lot of sense nowadays to enforce such a low pid number. There's
sufficient tooling to make selecting specific processes without typing
really large pid numbers available.

In any case, there are workloads that have expections about how large
pid numbers they accept. Either for historical reasons or architectural
reasons. One concreate example is the 32-bit version of Android's bionic
libc which requires pid numbers less than 65536. There are workloads
where it is run in a 32-bit container on a 64-bit kernel. If the host
has a pid_max value greater than 65535 the libc will abort thread
creation because of size assumptions of pthread_mutex_t.

That's a fairly specific use-case however, in general specific workloads
that are moved into containers running on a host with a new kernel and a
new systemd can run into issues with large pid_max values. Obviously
making assumptions about the size of the allocated pid is suboptimal but
we have userspace that does it.

Of course, giving containers the ability to restrict the number of
processes in their respective pid namespace indepent of the global limit
through pid_max is something desirable in itself and comes in handy in
general.

Independent of motivating use-cases the existence of pid namespaces
makes this also a good semantical extension and there have been prior
proposals pushing in a similar direction.
The trick here is to minimize the risk of regressions which I think is
doable. The fact that pid namespaces are hierarchical will help us here.

What we mostly care about is that when the host sets a low pid_max
limit, say (crazy number) 100 that no descendant pid namespace can
allocate a higher pid number in its namespace. Since pid allocation is
hierarchial this can be ensured by checking each pid allocation against
the pid namespace's pid_max limit. This means if the allocation in the
descendant pid namespace succeeds, the ancestor pid namespace can reject
it. If the ancestor pid namespace has a higher limit than the descendant
pid namespace the descendant pid namespace will reject the pid
allocation. The ancestor pid namespace will obviously not care about
this.
All in all this means pid_max continues to enforce a system wide limit
on the number of processes but allows pid namespaces sufficient leeway
in handling workloads with assumptions about pid values and allows
containers to restrict the number of processes in a pid namespace
through the pid_max interface.

[1]: https://lore.kernel.org/linux-api/CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
 - rebased from 5.14-rc1
 - a few fixes (missing ns_free_inum on error path, missing initialization, etc)
 - permission check changes in pid_table_root_permissions
 - unsigned int pid_max -> int pid_max (keep pid_max type as it was)
 - add READ_ONCE in alloc_pid() as suggested by Christian
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/pid.h           |   3 -
 include/linux/pid_namespace.h |  10 ++-
 kernel/pid.c                  | 126 ++++++++++++++++++++++++++++++++--
 kernel/pid_namespace.c        |  43 +++++++++---
 kernel/sysctl.c               |   9 ---
 kernel/trace/pid_list.c       |   2 +-
 kernel/trace/trace.c          |   2 +-
 kernel/trace/trace.h          |   2 -
 8 files changed, 162 insertions(+), 35 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 395cacce1179..16a9087f42a9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -104,9 +104,6 @@ extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
-extern int pid_max;
-extern int pid_max_min, pid_max_max;
-
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * or rcu_read_lock() held.
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6..7c67a5811199 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -30,6 +30,7 @@ struct pid_namespace {
 	struct task_struct *child_reaper;
 	struct kmem_cache *pid_cachep;
 	unsigned int level;
+	int pid_max;
 	struct pid_namespace *parent;
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
@@ -38,9 +39,14 @@ struct pid_namespace {
 	struct ucounts *ucounts;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	struct work_struct	work;
+#ifdef CONFIG_SYSCTL
+	struct ctl_table_set	set;
+	struct ctl_table_header *sysctls;
+#if defined(CONFIG_MEMFD_CREATE)
 	int memfd_noexec_scope;
 #endif
+#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
@@ -117,6 +123,8 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
+int register_pidns_sysctls(struct pid_namespace *pidns);
+void unregister_pidns_sysctls(struct pid_namespace *pidns);
 
 static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index b52b10865454..ec41f99816bc 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -59,12 +59,10 @@ struct pid init_struct_pid = {
 	}, }
 };
 
-int pid_max = PID_MAX_DEFAULT;
-
 #define RESERVED_PIDS		300
 
-int pid_max_min = RESERVED_PIDS + 1;
-int pid_max_max = PID_MAX_LIMIT;
+static int pid_max_min = RESERVED_PIDS + 1;
+static int pid_max_max = PID_MAX_LIMIT;
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -83,6 +81,7 @@ struct pid_namespace init_pid_ns = {
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
+	.pid_max = PID_MAX_DEFAULT,
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	.memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC,
 #endif
@@ -189,6 +188,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	for (i = ns->level; i >= 0; i--) {
 		int tid = 0;
+		int pid_max = READ_ONCE(tmp->pid_max);
 
 		if (set_tid_size) {
 			tid = set_tid[ns->level - i];
@@ -645,17 +645,119 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	return fd;
 }
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table_set *pid_table_root_lookup(struct ctl_table_root *root)
+{
+	return &task_active_pid_ns(current)->set;
+}
+
+static int set_is_seen(struct ctl_table_set *set)
+{
+	return &task_active_pid_ns(current)->set == set;
+}
+
+static int pid_table_root_permissions(struct ctl_table_header *head,
+				      struct ctl_table *table)
+{
+	struct pid_namespace *pidns =
+		container_of(head->set, struct pid_namespace, set);
+	int mode = table->mode;
+
+	if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
+	    uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
+		mode = (mode & S_IRWXU) >> 6;
+	else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
+		mode = (mode & S_IRWXG) >> 3;
+	else
+		mode = mode & S_IROTH;
+	return (mode << 6) | (mode << 3) | mode;
+}
+
+static void pid_table_root_set_ownership(struct ctl_table_header *head,
+					 struct ctl_table *table, kuid_t *uid,
+					 kgid_t *gid)
+{
+	struct pid_namespace *pidns =
+		container_of(head->set, struct pid_namespace, set);
+	kuid_t ns_root_uid;
+	kgid_t ns_root_gid;
+
+	ns_root_uid = make_kuid(pidns->user_ns, 0);
+	if (uid_valid(ns_root_uid))
+		*uid = ns_root_uid;
+
+	ns_root_gid = make_kgid(pidns->user_ns, 0);
+	if (gid_valid(ns_root_gid))
+		*gid = ns_root_gid;
+}
+
+static struct ctl_table_root pid_table_root = {
+	.lookup		= pid_table_root_lookup,
+	.permissions	= pid_table_root_permissions,
+	.set_ownership	= pid_table_root_set_ownership,
+};
+
+static struct ctl_table pid_table[] = {
+	{
+		.procname	= "pid_max",
+		.data		= &init_pid_ns.pid_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &pid_max_min,
+		.extra2		= &pid_max_max,
+	},
+};
+#endif
+
+int register_pidns_sysctls(struct pid_namespace *pidns)
+{
+#ifdef CONFIG_SYSCTL
+	struct ctl_table *tbl;
+
+	setup_sysctl_set(&pidns->set, &pid_table_root, set_is_seen);
+
+	tbl = kmemdup(pid_table, sizeof(pid_table), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+	tbl->data = &pidns->pid_max;
+	pidns->pid_max = min(pid_max_max, max_t(int, pidns->pid_max,
+			     PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
+
+	pidns->sysctls = __register_sysctl_table(&pidns->set, "kernel", tbl,
+						 ARRAY_SIZE(pid_table));
+	if (!pidns->sysctls) {
+		kfree(tbl);
+		retire_sysctl_set(&pidns->set);
+		return -ENOMEM;
+	}
+#endif
+	return 0;
+}
+
+void unregister_pidns_sysctls(struct pid_namespace *pidns)
+{
+#ifdef CONFIG_SYSCTL
+	struct ctl_table *tbl;
+
+	tbl = pidns->sysctls->ctl_table_arg;
+	unregister_sysctl_table(pidns->sysctls);
+	retire_sysctl_set(&pidns->set);
+	kfree(tbl);
+#endif
+}
+
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
 	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
 
 	/* bump default and minimum pid_max based on number of cpus */
-	pid_max = min(pid_max_max, max_t(int, pid_max,
-				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
+	init_pid_ns.pid_max = min(pid_max_max, max_t(int, init_pid_ns.pid_max,
+				  PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
 	pid_max_min = max_t(int, pid_max_min,
 				PIDS_PER_CPU_MIN * num_possible_cpus());
-	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
+	pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max, pid_max_min);
 
 	idr_init(&init_pid_ns.idr);
 
@@ -666,6 +768,16 @@ void __init pid_idr_init(void)
 			NULL);
 }
 
+static __init int pid_namespace_sysctl_init(void)
+{
+#ifdef CONFIG_SYSCTL
+	/* "kernel" directory will have already been initialized. */
+	BUG_ON(register_pidns_sysctls(&init_pid_ns));
+#endif
+	return 0;
+}
+subsys_initcall(pid_namespace_sysctl_init);
+
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
 {
 	struct file *file;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7ade20e95232..829ee1700b2b 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -70,6 +70,8 @@ static void dec_pid_namespaces(struct ucounts *ucounts)
 	dec_ucount(ucounts, UCOUNT_PID_NAMESPACES);
 }
 
+static void destroy_pid_namespace_work(struct work_struct *work);
+
 static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns,
 	struct pid_namespace *parent_pid_ns)
 {
@@ -105,17 +107,27 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 		goto out_free_idr;
 	ns->ns.ops = &pidns_operations;
 
+	ns->pid_max = parent_pid_ns->pid_max;
+	err = register_pidns_sysctls(ns);
+	if (err)
+		goto out_free_inum;
+
 	refcount_set(&ns->ns.count, 1);
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
+	INIT_WORK(&ns->work, destroy_pid_namespace_work);
+
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
 #endif
+
 	return ns;
 
+out_free_inum:
+	ns_free_inum(&ns->ns);
 out_free_idr:
 	idr_destroy(&ns->idr);
 	kmem_cache_free(pid_ns_cachep, ns);
@@ -137,12 +149,28 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
+	unregister_pidns_sysctls(ns);
+
 	ns_free_inum(&ns->ns);
 
 	idr_destroy(&ns->idr);
 	call_rcu(&ns->rcu, delayed_free_pidns);
 }
 
+static void destroy_pid_namespace_work(struct work_struct *work)
+{
+	struct pid_namespace *ns =
+		container_of(work, struct pid_namespace, work);
+
+	do {
+		struct pid_namespace *parent;
+
+		parent = ns->parent;
+		destroy_pid_namespace(ns);
+		ns = parent;
+	} while (ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count));
+}
+
 struct pid_namespace *copy_pid_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct pid_namespace *old_ns)
 {
@@ -155,15 +183,8 @@ struct pid_namespace *copy_pid_ns(unsigned long flags,
 
 void put_pid_ns(struct pid_namespace *ns)
 {
-	struct pid_namespace *parent;
-
-	while (ns != &init_pid_ns) {
-		parent = ns->parent;
-		if (!refcount_dec_and_test(&ns->ns.count))
-			break;
-		destroy_pid_namespace(ns);
-		ns = parent;
-	}
+	if (ns && ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count))
+		schedule_work(&ns->work);
 }
 EXPORT_SYMBOL_GPL(put_pid_ns);
 
@@ -290,6 +311,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	next = idr_get_cursor(&pid_ns->idr) - 1;
 
 	tmp.data = &next;
+	tmp.extra2 = &pid_ns->pid_max;
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (!ret && write)
 		idr_set_cursor(&pid_ns->idr, next + 1);
@@ -297,7 +319,6 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-extern int pid_max;
 static struct ctl_table pid_ns_ctl_table[] = {
 	{
 		.procname = "ns_last_pid",
@@ -305,7 +326,7 @@ static struct ctl_table pid_ns_ctl_table[] = {
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
 		.extra1 = SYSCTL_ZERO,
-		.extra2 = &pid_max,
+		.extra2 = &init_pid_ns.pid_max,
 	},
 	{ }
 };
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..857bfdb39b15 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1809,15 +1809,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "pid_max",
-		.data		= &pid_max,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pid_max_min,
-		.extra2		= &pid_max_max,
-	},
 	{
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..ef52820e6719 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	int i;
 
 	/* According to linux/thread.h, pids can be no bigger that 30 bits */
-	WARN_ON_ONCE(pid_max > (1 << 30));
+	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
 
 	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..dc055e395410 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5461,7 +5461,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 
 	if (mask == TRACE_ITER_RECORD_TGID) {
 		if (!tgid_map) {
-			tgid_map_max = pid_max;
+			tgid_map_max = init_pid_ns.pid_max;
 			map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
 				       GFP_KERNEL);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..e3072523250b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -703,8 +703,6 @@ extern unsigned long tracing_thresh;
 
 /* PID filtering */
 
-extern int pid_max;
-
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
 bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
-- 
2.34.1


