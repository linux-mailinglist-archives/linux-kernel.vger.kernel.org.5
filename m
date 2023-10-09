Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6567BD932
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbjJILEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjJILEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:04:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923EAB;
        Mon,  9 Oct 2023 04:04:46 -0700 (PDT)
Date:   Mon, 09 Oct 2023 11:04:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696849485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYdnBcjn2acF9k2TV8GJQ37s+wsSq8z6s/lE/MnM68M=;
        b=wVn63IS4qPmXGq+7hKh8cW/RPBuEliODiNi0pSabNz5+WFKA7raYA0ilqYAR5WFipkLBq8
        zr5j+vFw0FFOLikzSRmyrTxXo5C/2I384O+MP/bPFvfYLkmObWXtHRWIzGunf0bIxN28qx
        wNRFtGQo6tlZ70+YTxkJPql306ymC9/voyuQmUIjSxU7HmI/v9iEDqrqlmlzp/6FB/Amuk
        kewgbe626f0kNxrhjujhgDaZFGLX/iQjAoaqqSMyjHbgLtqInbPsOyeZqi0B+BRqxHnSpt
        /94FDsYuub7fM0EJ6RwaecNaT8uHcTFCx9i1ojmYO5ivgPXjynJJmHHz4v2Xdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696849485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYdnBcjn2acF9k2TV8GJQ37s+wsSq8z6s/lE/MnM68M=;
        b=r0wPdjeSv93jDXRxIs/M2AzybVT7YhKO1X/fIiw16MsksW+3veFEVCDayy4yvjWO6cQqA4
        32zlTNggcHCzl5BA==
From:   "tip-bot2 for Yajun Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Change the type of
 'sysctl_sched_rt_period' from 'unsigned int' to 'int'
Cc:     Yajun Deng <yajun.deng@linux.dev>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231008021538.3063250-1-yajun.deng@linux.dev>
References: <20231008021538.3063250-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Message-ID: <169684948438.3135.11070340713993333488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     089768dfeb3ab294f9ab6a1f2462001f0f879fbb
Gitweb:        https://git.kernel.org/tip/089768dfeb3ab294f9ab6a1f2462001f0f879fbb
Author:        Yajun Deng <yajun.deng@linux.dev>
AuthorDate:    Sun, 08 Oct 2023 10:15:38 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:44:56 +02:00

sched/rt: Change the type of 'sysctl_sched_rt_period' from 'unsigned int' to 'int'

Doing this matches the natural type of 'int' based calculus
in sched_rt_handler(), and also enables the adding in of a
correct upper bounds check on the sysctl interface.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231008021538.3063250-1-yajun.deng@linux.dev
---
 kernel/sched/rt.c    | 6 +++---
 kernel/sched/sched.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 88fc986..76d82a0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_bandwidth;
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
-unsigned int sysctl_sched_rt_period = 1000000;
+int sysctl_sched_rt_period = 1000000;
 
 /*
  * part of the period that we allow rt tasks to run in us.
@@ -34,7 +34,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
 		.data           = &sysctl_sched_rt_period,
-		.maxlen         = sizeof(unsigned int),
+		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
 		.extra1         = SYSCTL_ONE,
@@ -47,7 +47,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
 		.extra1         = SYSCTL_NEG_ONE,
-		.extra2         = SYSCTL_INT_MAX,
+		.extra2         = (void *)&sysctl_sched_rt_period,
 	},
 	{
 		.procname       = "sched_rr_timeslice_ms",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 649eb9e..515eb4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -105,7 +105,7 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
 extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
 
-extern unsigned int sysctl_sched_rt_period;
+extern int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 extern int sched_rr_timeslice;
 
