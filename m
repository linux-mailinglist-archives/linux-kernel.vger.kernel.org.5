Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A1790747
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbjIBKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:09:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2710EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:09:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2302595f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693649394; x=1694254194; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UWMJt0qHRQjgD059LCJSnvProE73St5Ky3Vs+OYm7fQ=;
        b=oEhjby9hPsRY4hb0f9FgclFdABncIVP4qyX15WB9mjTa+We+By0kKEi4cIn8N0ZwPK
         2YUv2VJCcmfosdIfhkHDSEL52TZO26DTCebLkgXUTC8hK5AmmeSaWQpNmeYsorPtPcI4
         fu/5ifA3FgZq3tvSey4ySWwegQshqy/Gmuvsxt0K6LOX+9aN3Fsm71kNfqez1qBqlFzY
         TWOBCH/0/LylJaZxmoVZAGMTbL0jyyuzt6cyfRVSrxD2BKNJ9Fq4aRS0/MHA7UWQccDN
         tjE3MPvXB8/xZO8UX7Q3kamyIM0XZIsZT73juzCK+IRQ0KUoD6VBN7HKnNVf1YtAaTGT
         X49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693649394; x=1694254194;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWMJt0qHRQjgD059LCJSnvProE73St5Ky3Vs+OYm7fQ=;
        b=CNc1wSHWqWEQb71D3IAZ5GU6lnH8qn1MmiSjgoJ7f+mQQdwxUp6nqEXomOKiJi7IpG
         hFQFLylusaLdoMfp2YsKYQ+/9C1zVXOZf0av7cJpOjc+Q65oA596HoWElp1Wf9Z9fDhn
         +c27SWCgFctovh0Geg1n3HzDfWjVCPIWNhdXH4EjdC5oTA/P0VaArOHxSt9r6s8a6NJI
         w66I19ThXusJlPykmnQj17ZJaXWoOgD5nlHuNkw4SfnwYc8dYKh8CzAIquPNj1ey4CIc
         uyxXAQ6rYq6D+NEH0JvE8STroFqK6hKB3ndStDUCjmnwb3T/t/8FgQ60nfz/uhGlpgF2
         RKPw==
X-Gm-Message-State: AOJu0Yw11FuW6y21yVLWkmuw8ScldIq/iEyU6V+3ixGqm74ec961g5po
        41nbVAAuzNU8dXnDxk0GIjM=
X-Google-Smtp-Source: AGHT+IGp+zz21HG0drITKVg9gAnyQ8ysfxAbgvchjKDwvBz5MdIrEhnuEDljWa1DvRCYBxCrjMdCvw==
X-Received: by 2002:adf:de0f:0:b0:317:cdc4:762e with SMTP id b15-20020adfde0f000000b00317cdc4762emr3480736wrm.63.1693649394227;
        Sat, 02 Sep 2023 03:09:54 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600011c900b0031c77c010e1sm7960154wrx.96.2023.09.02.03.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:09:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:09:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZPMJ7rJd7VzhBpl+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-02

   # HEAD: 0d6b35283bcf1a379cf20066544af8e6a6b16b46 sched/core: Report correct state for TASK_IDLE | TASK_FREEZABLE

Miscellaneous scheduler fixes: a reporting fix, a static symbol fix,
and a kernel-doc fix.

 Thanks,

	Ingo

------------------>
Costa Shulyupin (1):
      sched/core: Add kernel-doc for set_cpus_allowed_ptr()

Hao Jia (1):
      sched/fair: Make update_entity_lag() static

NeilBrown (1):
      sched/core: Report correct state for TASK_IDLE | TASK_FREEZABLE


 include/linux/sched.h | 14 ++++++++++++--
 kernel/sched/fair.c   |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..77f01ac385f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1671,7 +1671,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
 
-	if (tsk_state == TASK_IDLE)
+	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
 	/*
@@ -1679,7 +1679,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
 	 */
-	if (tsk_state == TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT)
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
@@ -1858,7 +1858,17 @@ extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
+
+/* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
+
+/**
+ * set_cpus_allowed_ptr - set CPU affinity mask of a task
+ * @p: the task
+ * @new_mask: CPU affinity mask
+ *
+ * Return: zero if successful, or a negative error code
+ */
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 911d0063763c..8dbff6e7ad4f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -699,7 +699,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 lag, limit;
 
