Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66B7AA233
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjIUVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjIUVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5297680;
        Thu, 21 Sep 2023 10:10:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695278003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA7A855TbBCr1Ls7xPmjU7HiQJ8bxXU32yUpWueygxg=;
        b=HJ9z45cqOlsUxdGTO+tqJp+C4Sh8Y5vW+AvS1lN3ZiEv5RhCKlXy9YuKjaV4MVRo0OH523
        7aZUd2O++pooldtAY8OOnHbbNh2rTeBlkSBEaiNAR6cJcYQV4lfg7QdzA3wT7+eCKDW2YD
        E3igFaPv0yI9xg4E/gbtepoFPFKT+Yu4ySb2Lu8PkBYfhfxq+WQ7CPUgbk0+LLhWWBcjhO
        MuYol+Z+a4SGD4HNX6wXVkkp9nPxjZbzfIqKOihk7dMlMQG2gZBvQjgR2ztcU6M1EEE1Ay
        eoOHX8Ud1eAD4aroN4IW+zU6SPQynRHF/zaZtD8rTYApjHaKJK6cSlnPw+03Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695278003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA7A855TbBCr1Ls7xPmjU7HiQJ8bxXU32yUpWueygxg=;
        b=sDuzeD3W5dzENKIoPiQD0aLGp3Wai+BRXUki+elLaLiP4NGo3ngWR4KLjnkPM6xOGRJlSg
        njQlqbuqxRlWVxCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Remove the
 /proc/sys/kernel/sched_child_runs_first sysctl
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230920130025.412071-2-bigeasy@linutronix.de>
References: <20230920130025.412071-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169527800257.27769.9797272865607860084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     17e7170645e34c519443ba63895264bbdee7beee
Gitweb:        https://git.kernel.org/tip/17e7170645e34c519443ba63895264bbdee7beee
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 20 Sep 2023 15:00:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 08:30:18 +02:00

sched/debug: Remove the /proc/sys/kernel/sched_child_runs_first sysctl

The /proc/sys/kernel/sched_child_runs_first knob is no longer connected since:

   5e963f2bd4654 ("sched/fair: Commit to EEVDF")

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230920130025.412071-2-bigeasy@linutronix.de
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h |  2 --
 3 files changed, 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9..132dfd1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -864,7 +864,6 @@ static void sched_debug_header(struct seq_file *m)
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
 	PN(sysctl_sched_base_slice);
-	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
 #undef P
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcf0c5b..7572000 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -78,12 +78,6 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 unsigned int sysctl_sched_base_slice			= 750000ULL;
 static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
-/*
- * After fork, child runs first. If set to 0 (default) then
- * parent will (try to) run first.
- */
-unsigned int sysctl_sched_child_runs_first __read_mostly;
-
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
 int sched_thermal_decay_shift;
@@ -145,13 +139,6 @@ static unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table sched_fair_sysctls[] = {
-	{
-		.procname       = "sched_child_runs_first",
-		.data           = &sysctl_sched_child_runs_first,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.procname       = "sched_cfs_bandwidth_slice_us",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e070dc..9260120 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -100,8 +100,6 @@ extern __read_mostly int scheduler_running;
 extern unsigned long calc_load_update;
 extern atomic_long_t calc_load_tasks;
 
-extern unsigned int sysctl_sched_child_runs_first;
-
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
