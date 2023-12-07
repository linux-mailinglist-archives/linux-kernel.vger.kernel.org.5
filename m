Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B21808E64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443061AbjLGRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjLGRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:09:54 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE9D1;
        Thu,  7 Dec 2023 09:09:59 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 168293200B20;
        Thu,  7 Dec 2023 12:09:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 07 Dec 2023 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1701968996; x=1702055396; bh=bT0vifi4KE
        A/by3Sw+sML2QMzMbrhVLku2bYSBxgxnQ=; b=qtN/QXp1yO9p4LRNkcti69mCK2
        qRjzp4NSMEi+YLiRrUw/c5JmXVL4x0wKzHjW5ZjrhEkWCO9ypxMnAvNqJtiN7k03
        Lp+6WhXfJLt91BzlDflfPTFsD0aJDbMNmmZft9xuHGSRJvjRphCShzNphK3+zspK
        FhvBf7qc3tKr5I2yvzLsd1vlCJmHVTxFHE5AdBhorVF6hLzS+lQOg76OJbOfb6NJ
        p+bboVgIyLQbrI5eKZVYN3cpGB7ohOq4GE0rm6wTw+blTD5jNfv+Rg2yuefm5B5/
        6Y6qel18zqFwHfsarH1JZ7Z8dD+A/BGTXnczVKV8/86l4MzRSzBHKNlypOYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701968996; x=1702055396; bh=bT0vifi4KEA/b
        y3Sw+sML2QMzMbrhVLku2bYSBxgxnQ=; b=cZqgMbdqmXEk3rSVJtRrMSG4aJVoh
        uBkpS+2Nqw5xFcWbzCMCeuW+zAJplRpKQKgty9kGNmTDaLRW4bryH01x7elkTQzm
        cg69Q5+/NbLnBY7wJYbU5DhSxRuTmu6XTt9mp7zCgvMC/VfPe9uVDkDofbLFKbqB
        e32FJDK53cA+1NVsaV91Lel9sUI+osnHBa5p+E6TnduC/tz3ojAwcVDMHu0HQWfB
        f9HXaICGaxCnFCnGmMjWR0xjTvgEbW9oYT0wimLV5I4HMPUILTd3YlIoXON//kdT
        92JVupeQOcb5WUtq7ynoSazbOuypb81uFPLVigvbPGXulbZKL2w+aYLIw==
X-ME-Sender: <xms:Y_xxZfU1brVfg6xeH98zVQaf3Z1Bw2ETtUByiKw5fU0itMfC42U8VA>
    <xme:Y_xxZXkzOcAA_BD-lfEvGOAnsmfTWgtDkcHCYp-paUreBusd2msE_KE9t8WAZw8Ns
    GzyF6Y2b47G8OlzXoQ>
X-ME-Received: <xmr:Y_xxZbb4hZVMKu9eY8NSOZUdjJr8ecjnhInszdvNNnbhhIR75w2fXvhxMtT2kN51N3PkDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhephfehleehfeejtdehteejgeefueehtdeufedvhefghefggfeigfegleelvdeh
    gfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:ZPxxZaXVKWgLL2m4JMMbPh4cTYnj3YQ2dFICIxbtTG_KkxeowKulfg>
    <xmx:ZPxxZZn5ITYaIld9yiA1296pNpjumOYJ5Sym56otDJCiQm7pDDaudg>
    <xmx:ZPxxZXdYqdp34vqOldHuw0LrgcPySQNvIN7NQln2bKmRIQeP8qKFbQ>
    <xmx:ZPxxZctlR7u3CTOHLGmPTv8tDJZTh2YFGwuXZPDR5rI-wB839fHUdQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 12:09:54 -0500 (EST)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Date:   Thu,  7 Dec 2023 10:09:44 -0700
Message-Id: <20231207170946.130823-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                |  3 +++
 kernel/fork.c                |  4 +---
 kernel/pid.c                 | 11 +----------
 kernel/signal.c              |  5 +----
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3499c1a8b929..37d6b4e4ab70 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -332,6 +332,7 @@ extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
+extern void do_notify_pidfd(struct task_struct *task);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
 extern void force_fatal_sig(int);
diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..7bb6488ebd79 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -149,6 +149,9 @@ static void __exit_signal(struct task_struct *tsk)
 	struct tty_struct *tty;
 	u64 utime, stime;
 
+	/* Wake up all pidfd waiters */
+	do_notify_pidfd(tsk);
+
 	sighand = rcu_dereference_check(tsk->sighand,
 					lockdep_tasklist_lock_is_held());
 	spin_lock(&sighand->siglock);
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..eef15c93f6cf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2163,8 +2163,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
  *
- * The helper verifies that @pid is used as a thread group leader.
- *
  * If this function returns successfully the caller is responsible to either
  * call fd_install() passing the returned pidfd and pidfd file as arguments in
  * order to install the pidfd into its file descriptor table or they must use
@@ -2182,7 +2180,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+	if (!pid)
 		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
diff --git a/kernel/pid.c b/kernel/pid.c
index 6500ef956f2f..4806798022d9 100644
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
index 47a7602dfe8d..7b3a1e147225 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2028,7 +2028,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 
@@ -2060,9 +2060,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
-	/* Wake up all pidfd waiters */
-	do_notify_pidfd(tsk);
-
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.

base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
-- 
2.34.1

