Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243E8006D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378017AbjLAJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75009194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:08 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6FUfFnmqt4IfzZcGlQkVi9fkygYWanokVt8epCh18g=;
        b=lgvXqUjFJoLwU9+ZZLvtquxTwT6ofi+2y79zdhzkCm+arupJRiVKmMIVcB3lduxwWCFofb
        MFOL7JDx6+6MFnMmEPZRzTDdRIidDu055pueLPcpiGoOrPv1g40SAikE1AQ96Zg1aCUWsu
        /RfyywAtAOETUaaOeWDUdTjDg1K5i8v5TCoy1b8UAilHhdNHc0/3AnPNkftGpd67MIalU9
        PXMyPG5DMKfCOgRGIYO2Vtiq31A/P7fOfozAca61lrAgMbutkFYtbzGQ38QYnXCUZcDprj
        jhoN1vY2o7ZgxvN6IUOgYw/d4bOtBFlACxjARMnb88bChF6B1h2PGlbSvNVcnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6FUfFnmqt4IfzZcGlQkVi9fkygYWanokVt8epCh18g=;
        b=swIBVCbe9PNsC1cAlRdY84Lq5DKzwDPoPs3oPMIaRGhQn1B3L/aGAyxpp9foQnhZvbP1Cq
        ixM6qqPcxQvkLZBg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v9 01/32] tick-sched: Fix function names in comments
Date:   Fri,  1 Dec 2023 10:26:23 +0100
Message-Id: <20231201092654.34614-2-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When referencing functions in comments, it might be helpful to use full
function names (including the prefix) to be able to find it when grepping.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New cleanup patch
---
 kernel/time/tick-sched.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be77b021e5d6..5c28cc80fd25 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -920,11 +920,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	/*
-	 * nohz_stop_sched_tick() can be called several times before
-	 * nohz_restart_sched_tick() is called. This happens when
-	 * interrupts arrive which do not cause a reschedule. In the
-	 * first call we save the current tick time, so we can restart
-	 * the scheduler tick in nohz_restart_sched_tick().
+	 * tick_nohz_stop_sched_tick() can be called several times before
+	 * tick_nohz_restart_sched_tick() is called. This happens when
+	 * interrupts arrive which do not cause a reschedule. In the first call
+	 * we save the current tick time, so we can restart the scheduler tick
+	 * in tick_nohz_restart_sched_tick().
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-- 
2.39.2

