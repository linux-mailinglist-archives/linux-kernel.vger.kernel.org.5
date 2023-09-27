Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8937B0787
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjI0PBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:01:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF08191;
        Wed, 27 Sep 2023 08:01:33 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695826892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkokVP2wt5Ju449IMUzW4+FI2pML/dPgrILOalHP0i8=;
        b=ofYs34UOmffBxkvnSASegSsN4VSeVLlittKiq9Q1WZzfbMi1Z0DS0wdtNcA3Kjmyh8YxCv
        R+W8x7Kotrljt9cAGetfloTrJp9q3NUO+Z/2ZGiXLM4aHAyxIkC536xz/3exezCklgCRv0
        hvgwbbZFQZ03On+bzbv4z0byy10CJvBxM9QPrAGHux4il8xPwsAnZX7PNog3QQNIlTYimM
        GnW0OGNdd0oqxjjZnJauyIPc2aN5zqWKbKDYN/DmNQt6gbnmY2kYbEkdxpoPolMWDQlCDU
        t41KdJ12QnwIKj0tLUgeYjoWc/BE8+xh2p1S+g/CfcEnsjEtU17uvAgUvDkLAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695826892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkokVP2wt5Ju449IMUzW4+FI2pML/dPgrILOalHP0i8=;
        b=3jkJ2tEXjcDlQT7gQe9lK4jgzJDZotra8xFNcQz7GAZT6Oao3Zgax7+NMxZYX7pdLL7gvG
        6pRJVjTbNirDaRDg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Rename the tick handlers to more
 self-explanatory names
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912104406.312185-2-frederic@kernel.org>
References: <20230912104406.312185-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <169582689176.27769.4731516772037698340.tip-bot2@tip-bot2>
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

Commit-ID:     dba428a678c7263afce06b1f765efa0e054278e2
Gitweb:        https://git.kernel.org/tip/dba428a678c7263afce06b1f765efa0e054278e2
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 12:44:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Sep 2023 16:58:10 +02:00

tick/nohz: Rename the tick handlers to more self-explanatory names

The current names of the tick handlers don't tell much about what different
between them. Use names that better reflect their role and resolution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230912104406.312185-2-frederic@kernel.org

---
 kernel/time/tick-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 87015e9..b66dd0f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1366,7 +1366,7 @@ void tick_nohz_idle_exit(void)
 /*
  * The nohz low res interrupt handler
  */
-static void tick_nohz_handler(struct clock_event_device *dev)
+static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	struct pt_regs *regs = get_irq_regs();
@@ -1412,7 +1412,7 @@ static void tick_nohz_switch_to_nohz(void)
 	if (!tick_nohz_enabled)
 		return;
 
-	if (tick_switch_to_oneshot(tick_nohz_handler))
+	if (tick_switch_to_oneshot(tick_nohz_lowres_handler))
 		return;
 
 	/*
@@ -1475,7 +1475,7 @@ void tick_irq_enter(void)
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
  */
-static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 {
 	struct tick_sched *ts =
 		container_of(timer, struct tick_sched, sched_timer);
@@ -1524,7 +1524,7 @@ void tick_setup_sched_timer(void)
 	 * Emulate tick processing via per-CPU hrtimers:
 	 */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_sched_timer;
+	ts->sched_timer.function = tick_nohz_highres_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
