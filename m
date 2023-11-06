Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099A77E2CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjKFTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjKFTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:35:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B5E10C4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:35:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so5576977276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299355; x=1699904155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SA9U3BYKpPLNMavyPlNHV0DBfe0X28VHPrgcDnlNWu4=;
        b=dtPbMDawfzBhwhQq3OO+tqSrn9Z5NXNBhaCYZ0iaiOKCRu5v+wr4ItugAqtwQwRmH+
         uP0YW2zXibSwOHKrnn96JOSFiloFEbTMa5IYbVJ1QNWJbpq+ZUvN86/rQFa8hDCwHXtV
         Bffm/zFcrGUJSR6pNzTE7IvDneaj9JKB2fulmEv0JzTi06PUaBFDUof+mafYI1naHrPm
         GYsWi6iMQRQoqX+oLKixJlre6CVGg0Qi6paJCmLo0hVrm9pkP2rgBhWLs4q0zNH9c+xg
         2tOT0E1Z6f2VWQUUoSxZxQ7TbmMJmUkKuIS2Uz2X9JdvzFSQv5TqRxaNg6YIwUn0bWUi
         6YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299355; x=1699904155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SA9U3BYKpPLNMavyPlNHV0DBfe0X28VHPrgcDnlNWu4=;
        b=c9z2kFU4GhWvTIHxYoDSTLvmIpNwpXC1mKfDODzIHg7yvcC8BP0G9FgQdZEsCAJxpC
         AXGPQf+HJgG2mff0BST+5wyingxk/PbTnyUu6g+yWyn0MivPWFFSnn8eW64D+Fa/ON8/
         wYPkQdUhdXH2o/i5KL8aK8Gl07osWnssi3ADBTyv4eWulgqQMcYro4mD9zQ0n4+JFUuH
         Cn47fFdz1A7lqBAjqrXUEislUhZg2SkMvSwLJrjA/yjR4m30JRl9ygj2WFtIHitxuddq
         iq6i6gIPC1rH+SQWkUtpOhROrTclgclbYpo2B8jlvfPvlTC+YVyavNAhsSiOd0ppOeb0
         PvVg==
X-Gm-Message-State: AOJu0YzbuRBitWnpaBM5SDdrDgIeAFBFbkS/4sM6t5/u11nwzzgKEBWe
        sCWOwPapNHBJgCa2Ys/wTiUKgex/kJqEC6QkOeMZ6faW2QB8Oqu2cnTJXOQr7DUHBk1FqSTUlOC
        Y3wLnoEyuBOOXs8ieIhfKbMw8qUt55YaXOaY5BUKs35nhO+H7OfrJNawfMJB5vLBe0+UYl+Y=
X-Google-Smtp-Source: AGHT+IF5RAlbcLYjtzUA5D89EB529oUqPyEcJ5pKnV8ZnWdz83UyUdJSJ9VqPvsLcCCnDWjLa0aBuLaZTMhp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1802:b0:da0:94e8:84d4 with SMTP
 id cf2-20020a056902180200b00da094e884d4mr554056ybb.12.1699299355240; Mon, 06
 Nov 2023 11:35:55 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:53 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-11-jstultz@google.com>
Subject: [PATCH v6 10/20] locking/mutex: Switch to mutex handoffs for CONFIG_PROXY_EXEC
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Since with PROXY_EXEC, we will want to hand off locks to the
task's we are running on behalf of, switch to using mutex
handoffs.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Split out only the very basic initial framework
 for proxy logic from a larger patch.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from core proxy patch
v6:
* Rework to use sched_proxy_exec() instead of #ifdef CONFIG_PROXY_EXEC
---
 kernel/Kconfig.locks   |  2 +-
 kernel/locking/mutex.c | 39 ++++++++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273ecd..791c98f1d329 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -226,7 +226,7 @@ config ARCH_SUPPORTS_ATOMIC_RMW
 
 config MUTEX_SPIN_ON_OWNER
 	def_bool y
-	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW && !PROXY_EXEC
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f37b7afe8aa5..5394a3c4b5d9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -914,26 +914,31 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	mutex_release(&lock->dep_map, ip);
 
-	/*
-	 * Release the lock before (potentially) taking the spinlock such that
-	 * other contenders can get on with things ASAP.
-	 *
-	 * Except when HANDOFF, in that case we must not clear the owner field,
-	 * but instead set it to the top waiter.
-	 */
-	owner = atomic_long_read(&lock->owner);
-	for (;;) {
-		MUTEX_WARN_ON(__owner_task(owner) != current);
-		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-
-		if (owner & MUTEX_FLAG_HANDOFF)
-			break;
+	if (sched_proxy_exec()) {
+		/* Always force HANDOFF for Proxy Exec for now. Revisit. */
+		owner = MUTEX_FLAG_HANDOFF;
+	} else {
+		/*
+		 * Release the lock before (potentially) taking the spinlock
+		 * such that other contenders can get on with things ASAP.
+		 *
+		 * Except when HANDOFF, in that case we must not clear the
+		 * owner field, but instead set it to the top waiter.
+		 */
+		owner = atomic_long_read(&lock->owner);
+		for (;;) {
+			MUTEX_WARN_ON(__owner_task(owner) != current);
+			MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
-		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, __owner_flags(owner))) {
-			if (owner & MUTEX_FLAG_WAITERS)
+			if (owner & MUTEX_FLAG_HANDOFF)
 				break;
 
-			return;
+			if (atomic_long_try_cmpxchg_release(&lock->owner, &owner,
+							    __owner_flags(owner))) {
+				if (owner & MUTEX_FLAG_WAITERS)
+					break;
+				return;
+			}
 		}
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

