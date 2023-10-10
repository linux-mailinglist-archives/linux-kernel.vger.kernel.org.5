Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6807BF7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjJJJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJJJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A1A7;
        Tue, 10 Oct 2023 02:43:50 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696931029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyvEi/UnAEHOtb09vPDToguMbxB7zsoDMoxkBd3H05I=;
        b=FF5s2ajC+4Yr74T0IpqzYZHFZ7wXpDUuwb4mgVF/QW8U3kBTPfvyOS6oQyzp3Q87e5B7Od
        q+8t+q+caoI7TCMhJFxyRYY2uW6uEaVza3TqQ1lVwOyiGQVBhy35r942nrBSVZLZXpfx4Z
        k9FA/LJ6Pfi0RvmgD9SI5nSCPz45763/HvJzD+h4dH9uXdbmDiMV+8UC3dG1ryH6dOLWtY
        4tULzcB0cxpuyDtwqNBvgIRsZ/qU/QFksNmE0EOlI50NmmWCJYPr8GHuJoF/Qubc01BeqY
        824pO3zZ3d8JfCOW+Eb1PK4XHLYPi1yYRwgdGkBSEJnkRZCr305KF8VWCk6oeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696931029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyvEi/UnAEHOtb09vPDToguMbxB7zsoDMoxkBd3H05I=;
        b=g99sw+KgSRDeNrENDbd0lI+erYPbt1xcTXrjKv4n2jHNQfyoDrUnh63K/gWTSYcrN+hfr3
        WoxviWmh8uI5aMCQ==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Rename vma_numab_state::access_pids[]
 => ::pids_active[], ::next_pid_reset => ::pids_active_reset
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-3-mgorman@techsingularity.net>
References: <20231010083143.19593-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169693102905.3135.18177490895667484755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f3a6c97940fbd25d6c84c2d5642338fc99a9b35b
Gitweb:        https://git.kernel.org/tip/f3a6c97940fbd25d6c84c2d5642338fc99a9b35b
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 10 Oct 2023 09:31:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 11:10:00 +02:00

sched/numa: Rename vma_numab_state::access_pids[] => ::pids_active[], ::next_pid_reset => ::pids_active_reset

The access_pids[] field name is somewhat ambiguous as no PIDs are accessed.
Similarly, it's not clear that next_pid_reset is related to access_pids[].
Rename the fields to more accurately reflect their purpose.

[ mingo: Rename in the comments too. ]

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010083143.19593-3-mgorman@techsingularity.net
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h |  6 +++---
 kernel/sched/fair.c      | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1..19fc73b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1726,8 +1726,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	unsigned int pid_bit;
 
 	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
-		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
+	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->pids_active[1])) {
+		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d7f042e..e7571ec 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -559,10 +559,10 @@ struct vma_numab_state {
 	unsigned long next_scan;
 
 	/*
-	 * Time in jiffies when access_pids[] is reset to
+	 * Time in jiffies when pids_active[] is reset to
 	 * detect phase change behaviour:
 	 */
-	unsigned long next_pid_reset;
+	unsigned long pids_active_reset;
 
 	/*
 	 * Approximate tracking of PIDs that trapped a NUMA hinting
@@ -574,7 +574,7 @@ struct vma_numab_state {
 	 * Window moves after next_pid_reset has expired approximately
 	 * every VMA_PID_RESET_PERIOD jiffies:
 	 */
-	unsigned long access_pids[2];
+	unsigned long pids_active[2];
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7c1baf..6b47edc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3125,7 +3125,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
 		return true;
 
-	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
+	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
 	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
 }
 
@@ -3241,7 +3241,7 @@ static void task_numa_work(struct callback_head *work)
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 
 			/* Reset happens after 4 times scan delay of scan start */
-			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
+			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 		}
 
@@ -3262,11 +3262,11 @@ static void task_numa_work(struct callback_head *work)
 		 * vma for recent access to avoid clearing PID info before access..
 		 */
 		if (mm->numa_scan_seq &&
-				time_after(jiffies, vma->numab_state->next_pid_reset)) {
-			vma->numab_state->next_pid_reset = vma->numab_state->next_pid_reset +
+				time_after(jiffies, vma->numab_state->pids_active_reset)) {
+			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->access_pids[0] = READ_ONCE(vma->numab_state->access_pids[1]);
-			vma->numab_state->access_pids[1] = 0;
+			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
+			vma->numab_state->pids_active[1] = 0;
 		}
 
 		do {
