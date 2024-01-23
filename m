Return-Path: <linux-kernel+bounces-35560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF9839347
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33C5284F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E1604BC;
	Tue, 23 Jan 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="RtwdzzVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRbCi4+z"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C960273;
	Tue, 23 Jan 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024109; cv=none; b=LeRyhAEjPZbzzlF/5rpNnaRHjPfchjxAvxsS8onGgZ/4AI0lvuc3cvCOoVChjzgoKLtqhFzdXPMTqEefDakRLgMgo39M+dSPKb9SqBTpWqghQ6uUQR3gdg6B6FcL9kda1RKkIq1m83P7H0rWrxbNaYQBEk9maVESJiylzUwRp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024109; c=relaxed/simple;
	bh=GNoSOzPorlXaJiPSQNqXcwNADrooIycd6sfZwndbFVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0r//uKZEh/cmIn8EnnqeHxBfT4LcrhK8ehiOMKOL7pn/90jJzYH14xWqfnez0kkIg42Ps+pFEZt44x5czQqTKglsAoq0++BCpIOAx2GlnC7mJ4Ayprss7U3ryVJ6dc9BbQ3USTueKePyh76aoRIghVU9fxXaKShFVUFOlAhEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=RtwdzzVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRbCi4+z; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C1BFA5C01D5;
	Tue, 23 Jan 2024 10:35:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jan 2024 10:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706024106; x=
	1706110506; bh=M9C9oXaW03dr+ruWy17gy2FxHRKy1LqG/xA89jIm6Jg=; b=R
	twdzzVyrV/XPizH2kgzfstAvqCjHQrdbkDlmXTV08IV1djbRnMUdcTjWKHpG0vuP
	Dapaiy/1NkYu6m9Xzr+8sW+PnN1z8Zw7dSHbCxY4vKG6J5nkchsG96+RMTjXUX+v
	o0KD0uIW5pVRgc3/T9yoiR8wVL5lj6a/npJTQqXTus5ejG0VRVm5Y+EflMMjgbFs
	ZkffURe5kNgxtHFmpV0JEmcqCtOGyjz18ackzpo+v17RvRTkic3rDxu3E0R6389T
	zHZ34hIlWu+7C/cs9kqpihLR4q+K2CFTFXeYdE4eyRakyWojx8bBFQb38WCSSj9M
	V7islNSCDD18c+imK7GJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706024106; x=
	1706110506; bh=M9C9oXaW03dr+ruWy17gy2FxHRKy1LqG/xA89jIm6Jg=; b=W
	RbCi4+zYrIaBZg6/tDRZk7pM/C7EYtcMUgWtI7PWu22wxaYeQmN5aMCLklJG8HOf
	F9PK08aG3jX+bo+XXRg1N/hKLFAXvK6ZdseeBnEWN1JAnOGYhBkdeJF6fBUF3Ytq
	cmKFkkq0/XFeuRAQmjdo7ZA0r3Zyumlw0Jg6S25gMwdfsVidiA4VNQzfSqzEs8bt
	XUOYJfW+dVRat9lHihGMU2NQ+ZgMbuxpBl6cWMtjIVBd5FmpCBLUmdyf3xL3/5F1
	mNpzpwNRn8VuDSs+AUGQqcStXOO+FTUIR8I/IGF5ZFqF5f8+usW/QKA6JQRPaxtM
	jCgGmYe8Vn9YA0Ax8PWYA==
X-ME-Sender: <xms:qtyvZUdjCeKpCZAf4N72Y4hStfS1FdktPIvIsE8pekBGbduV8rUKQA>
    <xme:qtyvZWMrmwzKeGIAIug2GLWDVHYAmcFqegJa-zB6mr_nw4ANok3VVyyn93kE8A651
    npM5Csdxr4GSRw0SRk>
X-ME-Received: <xmr:qtyvZVjDsJd-vsG-eWeaGRE5RfD3yssgM2JE-tVDfcsOWJFd3_JwjShCXNKmTe5QGRaVeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhephfevhfdvvdffueffgfffjeehlefffeefffeuheegvedvgefgueefkedu
    ieekgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:qtyvZZ-oxw8spuJs6iMruPU6KqTBmnphQdajNFy8XAUk1hR4cOYUyg>
    <xmx:qtyvZQtqWartjP9mGRbjfFb6j_PNE-tv2RyKBLp5nkf2jagkAv4FiQ>
    <xmx:qtyvZQGlYqq3tfzCLOLj-s6abTWeG9s2P4V4O9QKj8HfSJIv6C2svA>
    <xmx:qtyvZaXnl-JbqYgaeIIktv1HfuQqtBUKJXW_B-kei706mJFKXxH9WA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:35:05 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Date: Tue, 23 Jan 2024 08:34:50 -0700
Message-Id: <20240123153452.170866-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153452.170866-1-tycho@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

We are using the pidfd family of syscalls with the seccomp userspace
notifier. When some thread triggers a seccomp notification, we want to do
some things to its context (munge fd tables via pidfd_getfd(), maybe write
to its memory, etc.). However, threads created with ~CLONE_FILES or
~CLONE_VM mean that we can't use the pidfd family of syscalls for this
purpose, since their fd table or mm are distinct from the thread group
leader's. In this patch, we relax this restriction for pidfd_open().

In order to avoid dangling poll() users we need to notify pidfd waiters
when individual threads die, but once we do that all the other machinery
seems to work ok viz. the tests. But I suppose there are more cases than
just this one.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
--
v2: unify pidfd notification to all go through do_notify_pidfd() inside of
    __exit_signals() suggested by Oleg.
    Link to v1: https://lore.kernel.org/all/20231130163946.277502-1-tycho@tycho.pizza/
v3: go back to two separate call sites, the exiting one in
    do_notify_parent(), and a new one in release_task(), when a thread is
    not the thread group leader.
---
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                | 11 +++++++++++
 kernel/fork.c                |  4 +---
 kernel/pid.c                 | 11 +----------
 kernel/signal.c              |  2 +-
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 4b7664c56208..d752f003a69a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -333,6 +333,7 @@ extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
+extern void do_notify_pidfd(struct task_struct *task);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
 extern void force_fatal_sig(int);
diff --git a/kernel/exit.c b/kernel/exit.c
index 3988a02efaef..90117d7861f4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -256,6 +256,17 @@ void release_task(struct task_struct *p)
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
 	thread_pid = get_pid(p->thread_pid);
+
+	/*
+	 * If we're not the leader, notify any waiters on our pidfds. Note that
+	 * we don't want to notify the leader until /everyone/ in the thread
+	 * group is dead, viz. the condition below.
+	 *
+	 * We have to do this here, since __exit_signal() will
+	 * __unhash_processes(), and break do_notify_pidfd()'s lookup.
+	 */
+	if (!thread_group_leader(p))
+		do_notify_pidfd(p);
 	__exit_signal(p);
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 47ff3b35352e..44969cd472f0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2157,8 +2157,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
  *
- * The helper verifies that @pid is used as a thread group leader.
- *
  * If this function returns successfully the caller is responsible to either
  * call fd_install() passing the returned pidfd and pidfd file as arguments in
  * order to install the pidfd into its file descriptor table or they must use
@@ -2176,7 +2174,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+	if (!pid)
 		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
diff --git a/kernel/pid.c b/kernel/pid.c
index b52b10865454..b55c0adf457b 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -552,11 +552,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Return the task associated with @pidfd. The function takes a reference on
  * the returned task. The caller is responsible for releasing that reference.
  *
- * Currently, the process identified by @pidfd is always a thread-group leader.
- * This restriction currently exists for all aspects of pidfds including pidfd
- * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
- * (only supports thread group leaders).
- *
  * Return: On success, the task_struct associated with the pidfd.
  *	   On error, a negative errno number will be returned.
  */
@@ -615,11 +610,7 @@ int pidfd_create(struct pid *pid, unsigned int flags)
  * @flags: flags to pass
  *
  * This creates a new pid file descriptor with the O_CLOEXEC flag set for
- * the process identified by @pid. Currently, the process identified by
- * @pid must be a thread-group leader. This restriction currently exists
- * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
- * be used with CLONE_THREAD) and pidfd polling (only supports thread group
- * leaders).
+ * the process identified by @pid.
  *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
diff --git a/kernel/signal.c b/kernel/signal.c
index c9c57d053ce4..3e3c9d0fa3a5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,7 +2019,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 
-- 
2.34.1


