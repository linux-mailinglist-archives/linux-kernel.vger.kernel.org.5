Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173ED7C5F06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJKVU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjJKVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F8B8;
        Wed, 11 Oct 2023 14:20:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697059246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hZa+WRFW/1sYqrsgg573q1WxZRUNCB2WoM19IwAfgk=;
        b=o2KXbuduAxg5P/Ob7zKeL7L6HU26Kq0tkcryAPImRGqXpp7hBKo+HbDFcgMsiIkKZu7YMd
        gXsGSewopQZPrOylA1q8npRvjkduZCKSBsy6aQENCvmyVtHCY9lk1ERG7QQHlkfqwHgB4L
        MUtihM4gpjI1A53uAnTf4JdUJc+kddjhv1HvYA7q+ECAPDoPmHsX1gw/C6oDjsXZdSHmcq
        4HtlA/TMc1Yt1tCF1CY/2XDcad24ErvY7EZT6oteUUbkegoGudFVcMZYqxT93mp4LNUV/H
        Q4+UyVdauV8hnfUv5e51XZHkFYmF4nXGA0XfoG2UEdIIJTALFcPrIxGmBuTydQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697059246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hZa+WRFW/1sYqrsgg573q1WxZRUNCB2WoM19IwAfgk=;
        b=3UhmaJt7rEek/hkMAIakYDYXlhySPlsY4xbVrQWO4VRMQdxClmiJF2Jw6c0EjQNAMaUxpm
        fsvwg2rI8JaANJAg==
From:   "tip-bot2 for Yang Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Delete the 'update_total' function
 parameter from update_triggers()
Cc:     Yang Yang <yang.yang29@zte.com.cn>, Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Ziljstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202310101645437859599@zte.com.cn>
References: <202310101645437859599@zte.com.cn>
MIME-Version: 1.0
Message-ID: <169705924586.3135.13461721051414681406.tip-bot2@tip-bot2>
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

Commit-ID:     3657680f38cd7df413d665f2b2f38e9a78130d8b
Gitweb:        https://git.kernel.org/tip/3657680f38cd7df413d665f2b2f38e9a78130d8b
Author:        Yang Yang <yang.yang29@zte.com.cn>
AuthorDate:    Tue, 10 Oct 2023 16:45:43 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Oct 2023 23:08:09 +02:00

sched/psi: Delete the 'update_total' function parameter from update_triggers()

The 'update_total' parameter of update_triggers() is always true after the
previous commit:

  80cc1d1d5ee3 ("sched/psi: Avoid updating PSI triggers and ->rtpoll_total when there are no state changes")

If the 'changed_states & group->rtpoll_states' condition is true,
'new_stall' in update_triggers() will be true, and then 'update_total'
should also be true.

So update_total is redundant - remove it.

[ mingo: Changelog updates ]

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/202310101645437859599@zte.com.cn
---
 kernel/sched/psi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 79f8db0..44a7877 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -434,14 +434,13 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static void update_triggers(struct psi_group *group, u64 now, bool *update_total,
+static void update_triggers(struct psi_group *group, u64 now,
 						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
 	u64 *total = group->total[aggregator];
 	struct list_head *triggers;
 	u64 *aggregator_total;
-	*update_total = false;
 
 	if (aggregator == PSI_AVGS) {
 		triggers = &group->avg_triggers;
@@ -471,14 +470,6 @@ static void update_triggers(struct psi_group *group, u64 now, bool *update_total
 		 * events without dropping any).
 		 */
 		if (new_stall) {
-			/*
-			 * Multiple triggers might be looking at the same state,
-			 * remember to update group->polling_total[] once we've
-			 * been through all of them. Also remember to extend the
-			 * polling time if we see new stall activity.
-			 */
-			*update_total = true;
-
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
 			if (!t->pending_event) {
@@ -563,7 +554,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool update_total;
 	u64 now;
 
 	dwork = to_delayed_work(work);
@@ -582,7 +572,7 @@ static void psi_avgs_work(struct work_struct *work)
 	 * go - see calc_avgs() and missed_periods.
 	 */
 	if (now >= group->avg_next_update) {
-		update_triggers(group, now, &update_total, PSI_AVGS);
+		update_triggers(group, now, PSI_AVGS);
 		group->avg_next_update = update_averages(group, now);
 	}
 
@@ -638,7 +628,6 @@ static void psi_rtpoll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
-	bool update_total;
 	u64 now;
 
 	mutex_lock(&group->rtpoll_trigger_lock);
@@ -705,7 +694,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 
 	if (now >= group->rtpoll_next_update) {
 		if (changed_states & group->rtpoll_states) {
-			update_triggers(group, now, &update_total, PSI_POLL);
+			update_triggers(group, now, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
 		}
