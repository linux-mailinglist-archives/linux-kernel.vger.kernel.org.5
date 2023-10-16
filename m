Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0727CA730
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjJPLzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjJPLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:54:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31801B5;
        Mon, 16 Oct 2023 04:54:38 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697457277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+VpWdgy8ZpqWtZDYHsFaab24OYQaDMpzdaC2RrZl5s=;
        b=z8s1jNSZZ2SSZJKekPQ48D4Q09vevYNOKcQ7gw8DGGfZlmA1RBG2L74LjMNGoYlkpj76cF
        pp0aGsOP21sUpWsg+A46RQgFFdVgRwvCpx/M1FCww46I+20s3KPwrRsQ0DUeWNnKyfCld0
        oBIgsPdwCAHSGZ77IDlao1E6zbuG67y2tneLg/XgnufbRUH07U5Xgx3vdW9QJJkxqf5Yyw
        baKNtzhEqj+6R90CBJoqbySaM1dlDDfa8+qAeX6WsL63Gfmfl3DOb2lHkAkokCLsMD3GCF
        u3CbGPam31QPLQgj+Zm0jS/Y+IY+f+De030XdyTO1UDf0RjnT7CYatX519+1mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697457277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+VpWdgy8ZpqWtZDYHsFaab24OYQaDMpzdaC2RrZl5s=;
        b=S/PQ+8n0GVcY1SliilKyavL/jEks+PPdlNDI3kz/mgdlANkDmTjpSNvoM3LWgbR4v50FZ8
        L1xIGWdAUoqm2PDA==
From:   "tip-bot2 for Fan Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Update poll => rtpoll in relevant comments
Cc:     Fan Yu <fan.yu9@zte.com.cn>, Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Ziljstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202310161920399921184@zte.com.cn>
References: <202310161920399921184@zte.com.cn>
MIME-Version: 1.0
Message-ID: <169745727623.3135.4814080026088715141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7b3d8df549390e797f883efa16224fa0dfe35e55
Gitweb:        https://git.kernel.org/tip/7b3d8df549390e797f883efa16224fa0dfe=
35e55
Author:        Fan Yu <fan.yu9@zte.com.cn>
AuthorDate:    Mon, 16 Oct 2023 19:20:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 13:42:49 +02:00

sched/psi: Update poll =3D> rtpoll in relevant=C2=A0comments

The PSI trigger code is now making a distinction between privileged and
unprivileged triggers, after the following commit:

 65457b74aa94 ("sched/psi: Rename existing poll members in preparation")

But some comments have not been modified along with the code, so they
need to be updated.

This will help readers better understand the code.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/202310161920399921184@zte.com.cn
---
 kernel/sched/psi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 519bc92..7b4aa58 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -596,7 +596,7 @@ static void init_rtpoll_triggers(struct psi_group *group,=
 u64 now)
 	group->rtpoll_next_update =3D now + group->rtpoll_min_period;
 }
=20
-/* Schedule polling if it's not already scheduled or forced. */
+/* Schedule rtpolling if it's not already scheduled or forced. */
 static void psi_schedule_rtpoll_work(struct psi_group *group, unsigned long =
delay,
 				   bool force)
 {
@@ -636,37 +636,37 @@ static void psi_rtpoll_work(struct psi_group *group)
=20
 	if (now > group->rtpoll_until) {
 		/*
-		 * We are either about to start or might stop polling if no
-		 * state change was recorded. Resetting poll_scheduled leaves
+		 * We are either about to start or might stop rtpolling if no
+		 * state change was recorded. Resetting rtpoll_scheduled leaves
 		 * a small window for psi_group_change to sneak in and schedule
-		 * an immediate poll_work before we get to rescheduling. One
-		 * potential extra wakeup at the end of the polling window
-		 * should be negligible and polling_next_update still keeps
+		 * an immediate rtpoll_work before we get to rescheduling. One
+		 * potential extra wakeup at the end of the rtpolling window
+		 * should be negligible and rtpoll_next_update still keeps
 		 * updates correctly on schedule.
 		 */
 		atomic_set(&group->rtpoll_scheduled, 0);
 		/*
-		 * A task change can race with the poll worker that is supposed to
+		 * A task change can race with the rtpoll worker that is supposed to
 		 * report on it. To avoid missing events, ensure ordering between
-		 * poll_scheduled and the task state accesses, such that if the poll
-		 * worker misses the state update, the task change is guaranteed to
-		 * reschedule the poll worker:
+		 * rtpoll_scheduled and the task state accesses, such that if the
+		 * rtpoll worker misses the state update, the task change is
+		 * guaranteed to reschedule the rtpoll worker:
 		 *
-		 * poll worker:
-		 *   atomic_set(poll_scheduled, 0)
+		 * rtpoll worker:
+		 *   atomic_set(rtpoll_scheduled, 0)
 		 *   smp_mb()
 		 *   LOAD states
 		 *
 		 * task change:
 		 *   STORE states
-		 *   if atomic_xchg(poll_scheduled, 1) =3D=3D 0:
-		 *     schedule poll worker
+		 *   if atomic_xchg(rtpoll_scheduled, 1) =3D=3D 0:
+		 *     schedule rtpoll worker
 		 *
 		 * The atomic_xchg() implies a full barrier.
 		 */
 		smp_mb();
 	} else {
-		/* Polling window is not over, keep rescheduling */
+		/* The rtpolling window is not over, keep rescheduling */
 		force_reschedule =3D true;
 	}
=20
@@ -674,7 +674,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 	collect_percpu_times(group, PSI_POLL, &changed_states);
=20
 	if (changed_states & group->rtpoll_states) {
-		/* Initialize trigger windows when entering polling mode */
+		/* Initialize trigger windows when entering rtpolling mode */
 		if (now > group->rtpoll_until)
 			init_rtpoll_triggers(group, now);
=20
