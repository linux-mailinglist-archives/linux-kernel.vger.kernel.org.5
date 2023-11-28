Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8273A7FB599
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjK1JX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1JXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:23:55 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2109.outbound.protection.outlook.com [40.92.98.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9ACC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmLCmFvrlPtth7gx3FDEdiEQvUIzqx+lop6BnMEY+Q+VRagdGYvzBTmHYehTj/ZwIvIWAyXIkMt+WUaPtjq2fGsIlrV77TxRXGXeVQif8WKpZXlMZ7RENqpLbWgXuoxHXsL+D9qhuiiAeIw0yo/ESRpU0ZDfI3DYNXXmPTD+S9GrP+S1lazWq87o6zgwvNMkcmjlH3ho2XUdKmaoT/dQRYojyNA1mo9k1h4HlnjYxhldJUItE/PgrYz/Y1co2q1Lj//oKlrSCc8c8BnRrPWM0rGfcknPIxfFYG3dlR+Yf9JaGesiJ/1TQjMjnI+vMftBGHqK1BrHB3rI/4jMu28RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLZHFQjeR5l5f3KenJMNmQpZB2+0r0sY1aWm5t/CK7Q=;
 b=D2XOVw8pkTil4N1Sr+ZF12vU626LbLhxEc06E/ulRN2pDpd1JJ6zVc3zIRAnoxCvEJqsgQI/hDpCn8eqGP8gF+RoqVMpTaj+/de7GfmcoIwUKo4MWKoGLbX0VbNopyJASD2wO2mGGFrd7AM4bnJQs3CyHPbTGNgaja4puQKanNvofaeSYTTsnOGK7+OVbVV74pPq8BuCYVKkodZTtGyA3mPxfHU1Lrx2nNKBLRSUyrnIrvHuS3Z+yxrkGGQPyXVX5KPej3LTN79BqpmojoHgJorJ89zLGqGQ3GzFHvPzQWjN4a5Hu6yK5ZOWOhSIVtBYrYfGrlQyYBGLkABg5GcUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLZHFQjeR5l5f3KenJMNmQpZB2+0r0sY1aWm5t/CK7Q=;
 b=twbH6aIS1XBvLNbvrHbZBQuZIwnv9OqoiFWrkZ5YD4afxmBbxhNZ5WXe7p/3gT0gFmBHSDpu3TS5bm0K4RSxOMs65HX1++BXHNhJBML/XOcQBFiv/fM/IeomeP0eqJJpWfKn+FBw5v4ngu5i0VsLcbj91jYdxywRu3GwCVugjF1VqiEFaWvlA9gFmSy9/jO9vrcwvoVueYQ1hN7agbAjZ2Cco7pR1b2DFjWlpgC772TrkXu/oZIlBXxgc7HlWVEnZeHTkd3f6g5Bnqqp+rvH0bh/iw524AqJXFqpT4Ky/F3bHi/IlOCn182uYMImgSAbTcNLXSoUqI/L58gqkkseRw==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TY1P286MB3422.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 09:23:58 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 09:23:58 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH v2 1/2] tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Date:   Tue, 28 Nov 2023 17:23:54 +0800
Message-ID: <TYCP286MB21464DF5148B8FF8B142ADF7C6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127083049.145447-1-pngliu@hotmail.com>
References: <20231127083049.145447-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [eaMjgQIEfNDt/mcglzzZK0Ko0fBLeRJi]
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231128092354.160263-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TY1P286MB3422:EE_
X-MS-Office365-Filtering-Correlation-Id: 743bcd06-ffc1-4a4a-51b1-08dbeff3bfef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5eQ6GXzgGDvR4do60Az/hFzl00fwjX/gohRIGklKtbQOz1W9IW+jYv1mQX8o/wkWiRlMGMfVoUX2HDLtRlWBjOycTOhKgkp9im5ZnuAEom57L6QuuH0SoyX6vBdKsOj9Ui4tV9KpEkFlcxJLUbc3kL4Jw7GcjA3u86UASBr5jt4ZS6vgtn0kUKpjCJsawH//8n4Zf32fB4Uqm7Xuoh6ruSsRyHFEtusIx0LNKtJdTffyAdeTQbF9HT2tRBXxs/e9t5tAGY4Kkm7Z7Sc16sf34ysh0Rk2Da+i6tvR+HOYPEVFw5dK9Dc1WqQFiQU4t3jXhKLumaAQ1TvpEH4T9PSg3Q8B7CwrIQ8ErqVMxCR7pU2h49YrEUsT6B53eLE4O0RsdiADiK3KPTpQYHieuaGhIIHea4Eyf7ydihSbTiHZfSlTy+yUaH9YAgdlo12znHbrz3P7WZxCthNttRkQsHD6p4gU6BrEkVuunI1bHbuMkXRboqbA7pa3vKClYabttinlxE5bEHM9sAM6UXTQKAlnLNCgOMr2uRmzFWxMZ/l6JmgCEqFumdYMNQ9YkgrB7y4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNP/2ZSGYt4zDAtqenh9MhemnZzmWcnZg4D4+fbjksY0li9fiTmlhGcwbAiR?=
 =?us-ascii?Q?1Lh7BzzzB6C5Ia/ZZK6jQwUTWDDgsdyaDTkRnANNV55SO44NQ3KKxJiVH5pL?=
 =?us-ascii?Q?+YtCSV3LC5pAXJNmour3aw8fpM8/5Ytb7tG1RwMPxjZbFRv3QFCpkMNHX+Ks?=
 =?us-ascii?Q?F0AAz3sOGQtBnXSCRIEfusR5tkf/k1nF3Ez8pQa1uLPNX4tzRIortdnObYR4?=
 =?us-ascii?Q?x4uLkv/XIwHk3F3JM5nT0rMGypGjL8trm3QLdPPxg5nBZm+JLhLmJQQgVvvA?=
 =?us-ascii?Q?ZF1gsUCTy7cTRMwuWLwZHCWTCH614s00WrPsOL6k2sIqR3bB1WYCzSe+upFV?=
 =?us-ascii?Q?JdAIMa488xaBX97APDNCK0arsoJR854glokFw/ztESRDZb4Wn75z2YalsL5s?=
 =?us-ascii?Q?9runyEMK6bWzj2e8k+CUgNVdIj/ITuLtkxj5qCZQz3vRQ7B9TR8VummUnk50?=
 =?us-ascii?Q?T+cv+FvGNtEDLXb0WyjTrydFfhnOa+/rcFs+KFKNNxzHM22Eekr6jkcCuE8T?=
 =?us-ascii?Q?h31/t8qEdkRPYp+QMKHG+H6S1VgG0glP14fhqj+gICr4JHHBRk99V9mPrxlu?=
 =?us-ascii?Q?/RoR/P8HH9JKFIjEnzIZ7dEapAwqEqmuqZc1aeim88JCY2mmthAgvy+hJYIb?=
 =?us-ascii?Q?tSemvK2rJ0ODiVTwMztbBHuGRQ0Nfo7U8pK1QfeopJoZ5phrC3AOKO1PUFBN?=
 =?us-ascii?Q?rn5AoEfZarStOjeGd5caCeMZhkWeuG62hnRfnksQAU1Zy0FmbkFv6D14wjiF?=
 =?us-ascii?Q?J2pFHzFaxGQwwx6rcdB/lpXVIlbSO+FDsGwY3i3hqHIFC+3wd6oYXymbdyyM?=
 =?us-ascii?Q?4ZeretRq2tAD04+dvnEsZ5HeQ2wrbdL7r1byrQ3aHHSVbky4cIKj0j4bcmQj?=
 =?us-ascii?Q?2R8oZaQhClPEof/bFsaVyxNVsMM4ayxMSvPFEglp3mqCB8qxG1E1s4lJR5kg?=
 =?us-ascii?Q?u+dZ1M0LPKMB/hV9LWY/Asu3CcAE0x+8zVR8yi2+Kb+nNbBzo4GhBJ+btOt/?=
 =?us-ascii?Q?AmVa++qihVEjAeRHK7z8nR/1dnkLcdT6UHh4LxNXMLFoskLza9dRHdbsG8vZ?=
 =?us-ascii?Q?LsHrr1UQOrZnI7oaWk7kDrZfuVLyL2ycthLi4iNHQCPxAkkK9X2uSEc4mrJj?=
 =?us-ascii?Q?4UnS6ka4Ob0obXoePv0yT5/zkPLH6RIOy0/6g6/5k5sQ/4BLHtCB/Tl185Az?=
 =?us-ascii?Q?lDUT8MXN2iOqLk6M31gN4cMpZW6forgefDIoRA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 743bcd06-ffc1-4a4a-51b1-08dbeff3bfef
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 09:23:58.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

The ts->sched_timer initialization work of tick_nohz_switch_to_nohz()
is almost the same as that of tick_setup_sched_timer(), so adjust the
latter to get it reused by tick_nohz_switch_to_nohz().

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
Changes in v2:
- Fix build warning: Function parameter or member 'mode' not described in 'tick_setup_sched_timer'
- Fix build error: use of undeclared identifier 'tick_nohz_highres_handler'
- Fix build error: use of undeclared identifier 'sched_skew_tick'
---
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 37 ++++++++++++++++++-------------------
 kernel/time/tick-sched.h |  2 +-
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..355b5a957f7f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -746,7 +746,7 @@ static void hrtimer_switch_to_hres(void)
 	base->hres_active = 1;
 	hrtimer_resolution = HIGH_RES_NSEC;
 
-	tick_setup_sched_timer();
+	tick_setup_sched_timer(NOHZ_MODE_HIGHRES);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be77b021e5d6..96fcf5cb1b49 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1430,9 +1430,6 @@ static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
  */
 static void tick_nohz_switch_to_nohz(void)
 {
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	ktime_t next;
-
 	if (!tick_nohz_enabled)
 		return;
 
@@ -1441,16 +1438,9 @@ static void tick_nohz_switch_to_nohz(void)
 
 	/*
 	 * Recycle the hrtimer in 'ts', so we can share the
-	 * hrtimer_forward_now() function with the highres code.
+	 * highres code.
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	/* Get the next period */
-	next = tick_init_jiffy_update();
-
-	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
-	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
+	tick_setup_sched_timer(NOHZ_MODE_LOWRES);
 }
 
 static inline void tick_nohz_irq_enter(void)
@@ -1529,7 +1519,9 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
+#endif /* HIGH_RES_TIMERS */
 
+#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1542,15 +1534,19 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
+ * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(void)
+void tick_setup_sched_timer(int mode)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now = ktime_get();
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_nohz_highres_handler;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (mode == NOHZ_MODE_HIGHRES)
+		ts->sched_timer.function = tick_nohz_highres_handler;
+#endif
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1564,12 +1560,15 @@ void tick_setup_sched_timer(void)
 	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
-	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (mode == NOHZ_MODE_HIGHRES)
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	else
+#endif
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	tick_nohz_activate(ts, mode);
 }
-#endif /* HIGH_RES_TIMERS */
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
@@ -1581,7 +1580,7 @@ void tick_cancel_sched_timer(int cpu)
 
 	memset(ts, 0, sizeof(*ts));
 }
-#endif
+#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 5ed5a9d41d5a..35808bbb8a47 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -102,7 +102,7 @@ struct tick_sched {
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
-extern void tick_setup_sched_timer(void);
+extern void tick_setup_sched_timer(int mode);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 extern void tick_cancel_sched_timer(int cpu);
 #else
-- 
2.34.1

