Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8057FF664
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjK3QlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjK3Qkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:40:52 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB41A4;
        Thu, 30 Nov 2023 08:40:57 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EA2735C006B;
        Thu, 30 Nov 2023 11:40:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 11:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1701362453; x=1701448853; bh=GcRUTefwOD
        feWsEEU+T7P5vkTMTkxQIp7mTUU9VqXL8=; b=xGCt99ogNyz5PF4Lg0iAzjC7qp
        FTlBXswcvclsYpRpetMTOZeHvn0VKjXlt5IxOKdgHGAdqFfr7wACfU37IXpvx/6t
        P8GYFuhEuY1+1HU/lQU4KGELsKb+Shoqwh6YBsDfec4s8aGLKT6QUYU26PSui/6I
        /4gT+bDjkIJGkOJp6Gbxa7FpsfUJjyWrNHakgInrdTcGADekAP8zHs0ntdDyfBnF
        qcu93zQEGRxPbQRSSR5Sh/2L5PmeQW/DnL/8cjpFNAWqGjyRdzu0y0eBBV8VyEuo
        nw4aOFHD4fteUzqZZFz14NyYmX9BKhwRd9BnVu3tyScO7/ArxN7XfBz0rPPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701362453; x=1701448853; bh=GcRUTefwODfeW
        sEEU+T7P5vkTMTkxQIp7mTUU9VqXL8=; b=MRoPsenNPeU3+ceAOVhtiJAXfV/uR
        GTn22jjH2BZ5z93PfBkF7NgpW7yARoJtGwnZ+pew+zZqqULn+2GKr02BLwdjYVg8
        7VbnJ0yYaeLbvBy9Db+9x21UY4Lpk3ozF8v80qwwkvLX5G05+7gFGAE1Yb6R6xLD
        thYnzYkEMKNVz1cyfUx7xzcK+Cu84vVl1kxlXt0cZ4AVHTqcGF+nVl2XdG5yqcLP
        RxjinEvBgtwLrUbq6zpGD7XC5bLhk5BjrUrWxbLm3NrSk0ArDsLkPksVv5J4XINd
        XIAv97dzF9BE10dgkLytjqllQj8UE+NC3FTwCNdFFrxPzlN9noMKkwr0A==
X-ME-Sender: <xms:FbtoZbKWnQl9swwhF8d-cfzIQYsWVfddnN2c-BAD0eV9J4oY65wgXw>
    <xme:FbtoZfIxiz3L1siGUM_UngRKelJoyxSHY7M9gkhGuHLGwx9e6qM-c80jFmZtLMyfT
    nfHkSj3WYTS65MkFYo>
X-ME-Received: <xmr:FbtoZTsInCHdFqc4s2hBM_B6_DMTGmgdsayeC2IyuId94Z9migP3UkwJCSFHGLIufG6J7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepheeffeehleeftdfgjeegheelieefvdfghfeuudeuheehuefhhffhtefhiedv
    geegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
    ihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:FbtoZUbvG4ShnYrcRkxZ93RRhU0Fb2PHZpTDdZfbiq1pKNTMOjRaCQ>
    <xmx:FbtoZSaJqd2StH1olzM6QrkKFhb5agn88EuXXs4pVKGOqF4WS0V9WA>
    <xmx:FbtoZYAlVpZucUuefDFRhFSpY9SFdUEqv6zM9RGwA7dktX2mQwH-ZA>
    <xmx:FbtoZZwdqZz87YMNN4LKK5f2fPACkWh_pwkndUjK2LDjOkX1yiOJ2w>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 11:40:52 -0500 (EST)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>
Subject: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Date:   Thu, 30 Nov 2023 09:39:44 -0700
Message-Id: <20231130163946.277502-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

Another weirdness is the open-coding of this vs. exporting using
do_notify_pidfd(). This particular location is after __exit_signal() is
called, which does __unhash_process() which kills ->thread_pid, so we need
to use the copy we have locally, vs do_notify_pid() which accesses it via
task_pid(). Maybe this suggests that the notification should live somewhere
in __exit_signals()? I just put it here because I saw we were already
testing if this task was the leader.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 kernel/exit.c | 29 +++++++++++++++++++----------
 kernel/fork.c |  4 +---
 kernel/pid.c  | 11 +----------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..34eeefc7ee21 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -263,16 +263,25 @@ void release_task(struct task_struct *p)
 	 */
 	zap_leader = 0;
 	leader = p->group_leader;
-	if (leader != p && thread_group_empty(leader)
-			&& leader->exit_state == EXIT_ZOMBIE) {
-		/*
-		 * If we were the last child thread and the leader has
-		 * exited already, and the leader's parent ignores SIGCHLD,
-		 * then we are the one who should release the leader.
-		 */
-		zap_leader = do_notify_parent(leader, leader->exit_signal);
-		if (zap_leader)
-			leader->exit_state = EXIT_DEAD;
+	if (leader != p) {
+		if (thread_group_empty(leader)
+				&& leader->exit_state == EXIT_ZOMBIE) {
+			/*
+			 * If we were the last child thread and the leader has
+			 * exited already, and the leader's parent ignores SIGCHLD,
+			 * then we are the one who should release the leader.
+			 */
+			zap_leader = do_notify_parent(leader,
+						      leader->exit_signal);
+			if (zap_leader)
+				leader->exit_state = EXIT_DEAD;
+		} else {
+			/*
+			 * wake up pidfd pollers anyway, they want to know this
+			 * thread is dying.
+			 */
+			wake_up_all(&thread_pid->wait_pidfd);
+		}
 	}
 
 	write_unlock_irq(&tasklist_lock);
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

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.34.1

