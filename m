Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B557FD45D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjK2Kga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjK2KgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:36:10 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2040.outbound.protection.outlook.com [40.92.99.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9E1FC6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVtLh4n4WRxD0l/km0nOEmKgRu+FoZB2MG8pxfi8+g1VMk9nWBBYJXydjSeuvCiu7HSU9p6vyIq+Dhz50lDywzsOBSEZSuD5XUERPMHlqpcODFds3gssd5AhUmuRrtsvTRmVDK1oXhl47h1yxWnuwMgaL2uQ8F37D/ZIMWTON3xD1tTV9O4FeDJQf7ag6IQd2JYiVvHw8VCyHxLuAVo8gPU1qHqOt7Vqficp1+ZIBy2FeyKPxYUuqSboUj7zABH2W96fiF6XeDt5rVPJBDFpvz4hCWBltOCmsCYj2iKpSSiDjblIT++SF0SIDZGs2hS3o8uFMU475nV31SDxyCPf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0pXWIpB2Cdgn4iT7LGEloKqQzMDVuK7AODyeLYxRAA=;
 b=WERAVKkUdp1Ig3s+/8Rb59XE05kEGH2p/nD7TTKynzTgRavfg0+GMXwY3aQXNPyGXdG0ERYM6KJHtj/c/PfY/PaAgOoBtmcfiu6FqJw81TtFeE2P4FmvVnKCECM4icO0NLTvAmVpnLTElZnqCnmWHQQvlfUrYELAOCXe2nNURa45dz/xFOLgNFh0IrbXOeIbCr49KvbWovUZGFWeOyQGIptUg1hhRmtjKYZDMiDe3z/8WPFG9qbCMweAfGbGU2LrUQD7gqME1njfkNiIb7z10i+mExdqu+bLgGuave1b5hX4mX3C6Tto5z4J91g9g/oBusKfAmQTA0xoLkDiPU8pQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0pXWIpB2Cdgn4iT7LGEloKqQzMDVuK7AODyeLYxRAA=;
 b=h62QjU8c1BKjSDbO4nT00lCFLfsfO23FSqtjxcveqEb1WykEm1+SEqONsgbsu5EWz6pXriNjJLDn+rKTCUdkxDp5NUt/GBeUaq+uSQEY5OlJ7GTGtPBLLyFxDqAxTx/LeEv2Z/eoPci84j2RBbutdxBgQKz9qwbAu4xa5GsLYwT/cM1T+MmmSvF54l9vMh+waGvTrBt3Ylug4ZKgi7ReP5ppDR+hTXrmP2Xn7XBSc8rBJorFpMXvF3EAp1MqAvfXgIInJRUvGxPCOwQpckKkMTAcFE2BQnJydZQ91nE5JzTc3+hBTM0NmTzwdRcwgF3fHN5zu6EQkZcjCSNNbe6fXQ==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYVP286MB3149.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 10:35:34 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 10:35:34 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH v3 2/2] tick/nohz: Remove duplicate between tick_nohz_lowres_handler() and tick_nohz_highres_handler()
Date:   Wed, 29 Nov 2023 18:35:30 +0800
Message-ID: <TYCP286MB2146C94F0A30EA8F7FEF8F14C683A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128092413.160451-1-pngliu@hotmail.com>
References: <20231128092413.160451-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2owf3DJa3/W8Vmb+w5DWaXALFajkV0wz]
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231129103530.84579-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYVP286MB3149:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ac5cc0-a633-4607-e598-08dbf0c6eae4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScXtKkTRzKnZ52KK2wFUfIAr282id4wie/CZ7o3TzUHpHr/TkvcNTwyLjPOSznnrJQflofOX0oQWTz2OyiTIYZuMXeoT27MIr7M5W7C40UiByyZbvTA4W0Ja4Xq5G0UwlvL7sSlDRwsO8pliKh90IVovOu4Lsys9waKKlvDQdGc35d269jTT4fAaFloTGgzBGJP46VAAQ/lwQ9J8ZwCZ7YRglCRbzssrUjLfsxqrYWUIeSrCcaKFxJOeQyyznLAIv6Hee0whrLD4FDUii0irzK9/MTJ8JaSSZMOoOBd7nSTQBTpTRltn2gweZnM9LLuz3RpKmhWL5YatoqLMAA3AN1yh+wihmCRq7nyUUqSuHbo5BRXg3rUavnFssUI0DqkdHc5WjAjGxaIBjmYVY/VGxnLCtMlTOsClutvfhvgfbs5O5WjuFpqHTBs0jqUUWqJkmCyoOkc6q541/oPaKcHSn0Uzs0dQidsg4sqMTjv9Uwh58X26xHxiNp1kTrqi3pF2alBeBYjzO1raT3/ci41Wvj6z4eeQvAytYlCr8Pz3+p4Im8ULAmnW/UFNYJHQAhU0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uTVWXlp5erIgIaHGoj57qWlRmBYzYRaHkb4VNz5FoSFWBcJXNyIDVW1sbjc?=
 =?us-ascii?Q?6OXUCKhoBk58UHYyRx8o/pfzIXPLXngwdJULv74lok521p+gt7540newg+II?=
 =?us-ascii?Q?Zf0drP8UFD34mgii9NSZS1IM/4gtMv8E/uRNoJd3xvbV0tFPYq1FmXR/lSgS?=
 =?us-ascii?Q?0IIwklm6O5GKZsJa2JdoBykHUzav6JmQPDM1DTXOEInrFeosyO7tUkq3qEdq?=
 =?us-ascii?Q?eWOn0seEX3Z56ZQ/Rd/cAsv58xuJkuVDPlO8APx1nTB9l41FgkW1cWZGj6EY?=
 =?us-ascii?Q?OdTVM/dD/ZgSgu4Ko6GpC2e3nPlSo4XT4MBeBjs73YbQquDNebuhnRP/sBRs?=
 =?us-ascii?Q?UNdI0wQGpnXw3wjJgBDS8wklVy3sn46qX5S/tMdlQsD1uSu97M4ZNYIdfhAR?=
 =?us-ascii?Q?7gA2+/usONqDtO7l8rHiID9LMJILXMhyJnPaRTpjUWU2J9Qzn3BxSXOxEf0i?=
 =?us-ascii?Q?0qs3XJJcjs+9Jz0VMWaa4qhHtH+0uKGZonyY2bL7DMhekpC2bYpQQcJjkyGE?=
 =?us-ascii?Q?QXESWXnzd6g4WwWNJBPpIz2c37euZ9d6GLKk6iCOza5CaOxQ6a/1F52IVKhs?=
 =?us-ascii?Q?aobExHF08H65vut4/Xb3DMQHwp/zhOBsMed6jkop5xLefxcaxIObCvKiuZ9i?=
 =?us-ascii?Q?cX/LZs1tdN7ptrfrd9qB9EY34LJ4X5Zgcs5X5XOoZPniNY1MRMDo31qM3rO8?=
 =?us-ascii?Q?XoMNGoQ/0VBNy30w6o85m12vqLzzxESfSWSTy6zrNeCeONe8ZjszBUDxCOhw?=
 =?us-ascii?Q?KApyoiZ9dyGyh7Wa8rLfINmTBcbVAqiFcFy6VeEEp5J31MNBvWCQCUtL+CSD?=
 =?us-ascii?Q?Y6yaYfJvkaIEfu9xoXZ/WF2nI2blEBcVnSOKuR/crK17wj04bGMzgbUc3GKL?=
 =?us-ascii?Q?G3VkKE8GFzp1So1SXrhIbxIMYzoyhAf4QHTm1xL8wJp893tXN+oCN1+6bUid?=
 =?us-ascii?Q?kVj5rirIRUYFNJDhMyLFYp0of9nxovL1380XjH5tt2DdTNIirNhIXT5tCIp8?=
 =?us-ascii?Q?rUQ9jLZY5oNbiVG2nxdsnmXmB30wlUlparqKxMgLOJa4HaOXofeXYsv0EGKC?=
 =?us-ascii?Q?4vc2jQTA4rObTrK8i822H/NElYSRRq/yg8Ow7t+5kzN2e+CQbdvw8YbMEdTH?=
 =?us-ascii?Q?eOi7nZX40cBcDjDDZpVgtiDf9/Ah+nbjufrBee/HO12QzCRLclvFPNJS6Rvi?=
 =?us-ascii?Q?y7j0Bn/sfJwLLfh6qP19k8wZPb2GPkzA4CRktw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ac5cc0-a633-4607-e598-08dbf0c6eae4
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:35:34.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

tick_nohz_lowres_handler() does the same work as tick_nohz_highres_handler()
plus the clockevent device reprogramming, so should reuse the latter.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
Changes in v3:
- Remove the first``#ifdef CONFIG_HIGH_RES_TIMERS'' in tick_setup_sched_timer()
  in patch 2/2
- Add comment on sched_skew_tick introduced to low-res mode tick_sched setup
- Replace hrtimer_forward() with hrtimer_forward_now() in tick_setup_sched_timer()
- Remove the sedond ``#ifdef CONFIG_HIGH_RES_TIMERS'' in tick_setup_sched_timer()
- Move tick_nohz_highres_handler() ahead to avoid additional declaration
Changes in v2:
- Fix build warning: Function parameter or member 'mode' not described in
  'tick_setup_sched_timer'
- Fix build error: use of undeclared identifier 'tick_nohz_highres_handler'
- Fix build error: use of undeclared identifier 'sched_skew_tick'
---
 kernel/time/tick-sched.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d25039f07838..a045425b8bf5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -255,6 +255,41 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
+
+/*
+ * We rearm the timer until we get disabled by the idle code.
+ * Called with interrupts disabled.
+ */
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
+{
+	struct tick_sched *ts =
+		container_of(timer, struct tick_sched, sched_timer);
+	struct pt_regs *regs = get_irq_regs();
+	ktime_t now = ktime_get();
+
+	tick_sched_do_timer(ts, now);
+
+	/*
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
+	 */
+	if (regs)
+		tick_sched_handle(ts, regs);
+	else
+		ts->next_tick = 0;
+
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (unlikely(ts->tick_stopped))
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, TICK_NSEC);
+
+	return HRTIMER_RESTART;
+}
 #endif
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -1389,30 +1424,17 @@ void tick_nohz_idle_exit(void)
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
  *
- * This low-resolution handler still makes use of some hrtimer APIs meanwhile
- * for convenience with expiration calculation and forwarding.
+ * This low-resolution handler still reuse tick_nohz_highres_handler() since
+ * most of the work is independent of the clockevent level.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
 
 	dev->next_event = KTIME_MAX;
 
-	tick_sched_do_timer(ts, now);
-	tick_sched_handle(ts, regs);
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (likely(!ts->tick_stopped)) {
-		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	if (likely(tick_nohz_highres_handler(&ts->sched_timer) == HRTIMER_RESTART))
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	}
-
 }
 
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1481,46 +1503,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-/*
- * High resolution timer specific code
- */
-#ifdef CONFIG_HIGH_RES_TIMERS
-/*
- * We rearm the timer until we get disabled by the idle code.
- * Called with interrupts disabled.
- */
-static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
-{
-	struct tick_sched *ts =
-		container_of(timer, struct tick_sched, sched_timer);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
-
-	tick_sched_do_timer(ts, now);
-
-	/*
-	 * Do not call when we are not in IRQ context and have
-	 * no valid 'regs' pointer
-	 */
-	if (regs)
-		tick_sched_handle(ts, regs);
-	else
-		ts->next_tick = 0;
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (unlikely(ts->tick_stopped))
-		return HRTIMER_NORESTART;
-
-	hrtimer_forward(timer, now, TICK_NSEC);
-
-	return HRTIMER_RESTART;
-}
-#endif /* HIGH_RES_TIMERS */
-
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
@@ -1542,10 +1524,8 @@ void tick_setup_sched_timer(int mode)
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-#ifdef CONFIG_HIGH_RES_TIMERS
 	if (mode == NOHZ_MODE_HIGHRES)
 		ts->sched_timer.function = tick_nohz_highres_handler;
-#endif
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
-- 
2.34.1

