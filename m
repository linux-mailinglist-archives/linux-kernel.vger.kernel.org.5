Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7C7B0785
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjI0PBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjI0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:01:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE139193;
        Wed, 27 Sep 2023 08:01:33 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695826891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBwhxxJMOLljiDx3QNMdAK4fQ8y/xjVjglmseFlax20=;
        b=OWEQY6NCvaC3mN0row2lS9YWKn1AbGNShLxZkt9VdKLIA7Tu977Sl5hLDZjq7xElPYsAGo
        +o1psGaG+PcssqFy4f3zhmYRXv0laTXS+p8Nt/ArVbbTZVIGO2IiQ92B0m0NCOtQjRhT7D
        did3UxZARlUlgo7eSVoXDL1jDlh75fejQQWXYCb00H3Gjtn8yXQ0ZikpVfSWXOGj1z4pWH
        qXdbv3gj44fFJCsbQLYFDgR5NdbI0qQgr/o1ZWd819saYoqg92SJKdBbG2upoOo3pBAVdX
        ore1+00BQ576f4bf0oT/k5OpR7s2eZ2rTXjxgp1bW388RB2NM6ySlkvxLPddeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695826891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBwhxxJMOLljiDx3QNMdAK4fQ8y/xjVjglmseFlax20=;
        b=vwIsXdF6O4ytXpnIlsHfpMKP9Aq0jtOBblVFqpf+2AVrAQEcZkxOsCIdQgQzzhLKavCWn7
        f2pT2GUPETYnpSAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Update obsolete comments
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912104406.312185-3-frederic@kernel.org>
References: <20230912104406.312185-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     822deeed3a6a3fdf0cd899d3b403ecbb12fb6c7a
Gitweb:        https://git.kernel.org/tip/822deeed3a6a3fdf0cd899d3b403ecbb12fb6c7a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 12:44:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Sep 2023 16:58:10 +02:00

tick/nohz: Update obsolete comments

Some comments are obsolete enough to assume that IRQ exit restarts the
tick in idle or RCU is turned on at the same time as the tick, among
other details.

Update them and add more.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230912104406.312185-3-frederic@kernel.org

---
 kernel/time/tick-sched.c | 46 ++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b66dd0f..95a8d1d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1175,12 +1175,23 @@ void tick_nohz_idle_enter(void)
 }
 
 /**
- * tick_nohz_irq_exit - update next tick event from interrupt exit
+ * tick_nohz_irq_exit - Notify the tick about IRQ exit
  *
- * When an interrupt fires while we are idle and it doesn't cause
- * a reschedule, it may still add, modify or delete a timer, enqueue
- * an RCU callback, etc...
- * So we need to re-calculate and reprogram the next tick event.
+ * A timer may have been added/modified/deleted either by the current IRQ,
+ * or by another place using this IRQ as a notification. This IRQ may have
+ * also updated the RCU callback list. These events may require a
+ * re-evaluation of the next tick. Depending on the context:
+ *
+ * 1) If the CPU is idle and no resched is pending, just proceed with idle
+ *    time accounting. The next tick will be re-evaluated on the next idle
+ *    loop iteration.
+ *
+ * 2) If the CPU is nohz_full:
+ *
+ *    2.1) If there is any tick dependency, restart the tick if stopped.
+ *
+ *    2.2) If there is no tick dependency, (re-)evaluate the next tick and
+ *         stop/update it accordingly.
  */
 void tick_nohz_irq_exit(void)
 {
@@ -1330,11 +1341,20 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 }
 
 /**
- * tick_nohz_idle_exit - restart the idle tick from the idle task
+ * tick_nohz_idle_exit - Update the tick upon idle task exit
+ *
+ * When the idle task exits, update the tick depending on the
+ * following situations:
+ *
+ * 1) If the CPU is not in nohz_full mode (most cases), then
+ *    restart the tick.
+ *
+ * 2) If the CPU is in nohz_full mode (corner case):
+ *   2.1) If the tick can be kept stopped (no tick dependencies)
+ *        then re-eavaluate the next tick and try to keep it stopped
+ *        as long as possible.
+ *   2.2) If the tick has dependencies, restart the tick.
  *
- * Restart the idle tick when the CPU is woken up from idle
- * This also exit the RCU extended quiescent state. The CPU
- * can use RCU again after this function is called.
  */
 void tick_nohz_idle_exit(void)
 {
@@ -1364,7 +1384,13 @@ void tick_nohz_idle_exit(void)
 }
 
 /*
- * The nohz low res interrupt handler
+ * In low-resolution mode, the tick handler must be implemented directly
+ * at the clockevent level. hrtimer can't be used instead because its
+ * infrastructure actually relies on the tick itself as a backend in
+ * low-resolution mode (see hrtimer_run_queues()).
+ *
+ * This low-resolution handler still makes use of some hrtimer APIs meanwhile
+ * for commodity with expiration calculation and forwarding.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
