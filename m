Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520D76185B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGYM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGYM2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:28:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF240A7;
        Tue, 25 Jul 2023 05:28:48 -0700 (PDT)
Date:   Tue, 25 Jul 2023 12:28:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690288125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oT7zrKgEkSdMtqdKcld0uEilXTEtuvjV3fRfLJNLrvg=;
        b=B817jbKEvbwKUnn5Uwmc+HfTSDcbxTBWXxXFahWHVrg60/Ay5zaicnIKIcKEnIKEOVHiqd
        5avdaPbEJ4MBlZZNZPMeYLOvpawys/sbr8GTkynLCqdOVG2Z3OXiQOFJ//jrKDm2YgYKl8
        vDo/bUSPreks3Xn1J3hD9ndtrJekaXhejjd4N4TlYASiD3guN8F5vjr57TpTjSvAMTp5r/
        jMgk20Dgli2BL3DAsAIxdz5+0D/Bt0Go1DECk/sBIJSdJe0TCXJguNsO+ofmx7ZYaf44n3
        ma5al1T9xTouYBYvwpBsle5zLOSk+/oqlKYlmixC9c9YpRM6LGccghvhflWFsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690288125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oT7zrKgEkSdMtqdKcld0uEilXTEtuvjV3fRfLJNLrvg=;
        b=dYzEa9JZyXy1N1NST23hvDSefJ3dFJ4A1NUAoDT4t+pAmZnDrtS+/VFfHT0mIlf9cUdqro
        phmwtBS2gM28tvCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] Revert "sched/fair: Move unused stub functions to header"
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169028812500.28540.5616011722424800278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7c1541e5f8330b0b94cafc5c68cf27ff358a1663
Gitweb:        https://git.kernel.org/tip/7c1541e5f8330b0b94cafc5c68cf27ff358a1663
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Jul 2023 21:30:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 24 Jul 2023 21:42:42 +02:00

Revert "sched/fair: Move unused stub functions to header"

Revert commit 7aa55f2a5902 ("sched/fair: Move unused stub functions to
header"), for while it has the right Changelog, the actual patch
content a revert of the previous 4 patches:

  f7df852ad6db ("sched: Make task_vruntime_update() prototype visible")
  c0bdfd72fbfb ("sched/fair: Hide unused init_cfs_bandwidth() stub")
  378be384e01f ("sched: Add schedule_user() declaration")
  d55ebae3f312 ("sched: Hide unused sched_update_scaling()")

So in effect this is a revert of a revert and re-applies those
patches.

Fixes: 7aa55f2a5902 ("sched/fair: Move unused stub functions to header")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be..695f8e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-
+#ifdef CONFIG_SMP
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -702,6 +702,7 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
+#endif
 
 /*
  * delta /= w
@@ -6186,9 +6187,8 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006..44b540a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1245,6 +1245,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool fi);
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -2398,6 +2399,7 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 #endif
 
 extern void schedule_idle(void);
+asmlinkage void schedule_user(void);
 
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
