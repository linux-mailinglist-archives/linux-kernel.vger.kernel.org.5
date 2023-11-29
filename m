Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81DE7FD45B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjK2KgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2Kf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:35:59 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2040.outbound.protection.outlook.com [40.92.99.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777231BDD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR8EMgI2UvrODe1g4tUR2eStjyrHIcbbEe8xxiscpzOFk7ik9LogQQIGkLdNtEpDPnSfy3Kdj5gLbtGgr/tlEcMIg/RM46fRWddM1nlmgmOKRuWdjfdpGPFRiUr8YPomQew+biUSFBzAgc0+MLuhFvIpnHTJuPSuMu9xvotQ+JqrGyftE5Y87AyVQNCFlQqL3r6m4738Kt3Fd9m+yIPVX/4y3BdN6nPTuFUqLhClv8z6z/Wc6vMHkBRGQ05oQoYzf7FfOrpjBu9RcLHe1haSaWNEKTjYm2bDRcWHh1Ysn2wz67yQgRO3nCYP8bsU4/+Jhbmr7fjokWw7SHT1nSbsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFJJH1ZmzPIZ1jjjiy5SBIGGwpOHEHnRm7YSUJoEY4E=;
 b=GKmRUAiJXJso/pasTxRLgdvQo6LbVknK+3eMTfNI00TAWbQ7WVjZx3LYxFpXLPV9INiuu6UZaD40wRI0RcxK677SY4CUusQxyZMCJDc1Ag3wSX+ZYVG5BQYd4LLTf5LAkUhvHZBPA9d46Svlfkwsr7Nfd7mtBqmuo4usVAl2mj04mMQmFeI5qu0w0rbIUsAHfUTPaftTirEh1+W0PsXJJZGFJKu1LQIK19YBKZFr/wbBkpS9yjYE3P+BnzPb0H2pznMPx8yqwPLiTJkv5nz4kRBlk5EPcyx97mR/ITkHZJXIyzGoi2lVPHWRliL81Bxgmee9XjExCP3G4xr/dE+PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFJJH1ZmzPIZ1jjjiy5SBIGGwpOHEHnRm7YSUJoEY4E=;
 b=JnNna92MQl7SclVamecyXKp6q8YDWSK0fU3JaJI/ILIL3MGScBHbb66ADnV6+XEFcuENzXZfUhmmaNBXrJeihogqAvf76PQntwqnNwTxPuXkKMyCeszdslJBG8hHhWNzjpsF3XwPcDylqdmdIBg/ju2tVjqQuVL1MUMRP4pB37igSnHqycVg7Cv9CX+5PEJ5qBXewoSUOxxxl58++BRHQVeYeEcn6wMJZiNj94e3OnJ9UF7MWgeXO86drydGA3NHIVStuBh7EwD3IVR/zdY8Lp5iZnI4UHDJ9EkW1ljY+Nc+1xA+3IYqn5RH6Le+xbfgGfpGCfucBINjvruZK7Gx/w==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYVP286MB3149.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 10:35:22 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 10:35:22 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH v3 1/2] tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Date:   Wed, 29 Nov 2023 18:35:18 +0800
Message-ID: <TYCP286MB21466A2954F68505833BB0A1C683A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128092354.160263-1-pngliu@hotmail.com>
References: <20231128092354.160263-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [I6fVF2Dl7Q2/X75Jng07n1DF4m6pdmwN]
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231129103518.84437-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYVP286MB3149:EE_
X-MS-Office365-Filtering-Correlation-Id: 594b5f30-3bd9-409d-d11f-08dbf0c6e3ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XfVXht4Xif1sPLcg0B7QIf7wDfAMsQDk6STbn5zmgwyJKt21oIymBT0in41uglFO+vCmiTWimP0tp9R66glTsCwuq/zgSMiRXDBVqbBNokQPr8XCGrjdLvrUQsz7kI+MiJ4zUhuo8Qjl4qfNS0wZy5n697PCfLGskilA2TpXk8eVhy0KZiHPOQZmHjMGxNfHGa0M4hR7X2U853TZi7uvCIwGoike2Cnwl5ttaOiwZwad0SJOLzADKKNA2P49ZjkROUM9bwLEGAfFdYvc1GK23wKtBiYJSGB+qfyoonJcOtD5GqHHgWGPEPE1zG7fCopizGghjdjv20hkLt54nGGunszXTAVJvqYT3WQLtZI9kLPXkD9Pd0ZhxCxGaAgyGSgdtNzzVsaas5B3aJCczBDC83IiqDXym68B2qltQYIXn3bjzp+vD3lxkyZmZZ1wiSgmwBa9N8FFEtXyDClGAeQqQuKjExvSPGz/WGNdrNvnOUyYPCHJTf3nt631Jgi3cH6fAi/VQL6U+dDPlsmQR8fFgUp7kUyzvpSrFjptA74XS7MdbNYr88AtNO2L4VDYVXw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Dig7t7Nx3NOtNNC/Sqrgn5JxcpDWD/P/w+FAl3B1EtRQ+MioIX6tHmS68dp?=
 =?us-ascii?Q?epiYE+xpLVvsxfukdpGcYQyQ6pgZYdJE9SeNIvQ2t8CuFQq9DSxSzZ2iTTON?=
 =?us-ascii?Q?h8Gm5tyhhoaCkZHZrdvK2bIR3k0iG+v5+u0vlavwDIifNbitQ/3f6DRGeZ6x?=
 =?us-ascii?Q?e3s0XhvlVAMr0dUblVIQIX39YXwbU8t7H2keVGS7qm/mjb6LhIYdzQbhOXc/?=
 =?us-ascii?Q?msL0y1v0II+KiM82uK5MMpbutTARFFmSiiHmjsUaaViHmleZRqyPu7dK876X?=
 =?us-ascii?Q?uE4xhTYV/IQAKx4+Bw2DMBgn/ueYm4JMcMcLjadcPHmNkzGV1gsTfry8CZJv?=
 =?us-ascii?Q?se3gDSzbj5phUnFwqlM5xvr53qRo5eQ2RJXthMRhEJ4ljQB/cn5GDYVntkQf?=
 =?us-ascii?Q?tC3yVZZs+d/GvCgua2c9NgzHViKxpOg47Q5+20Np6bkJDz2PNlZ+4lEVV5Ne?=
 =?us-ascii?Q?wAtSwGEpnQQ6qI6RvVbCQ7+CPWuRp00aPcODxxTaMdKoLugJSbFAGjjLEYVS?=
 =?us-ascii?Q?q/ajbFDM7EVcUDDSGDTytEq0MB21Tzv5cPvkco7FfktL0fu61Vu3NQM71nm5?=
 =?us-ascii?Q?ZGynioMUUFaULRulAYBsI/7sQo7jFKZ1ukOckMH7vZxX3rFM2xYILNnhQR8U?=
 =?us-ascii?Q?1fCVkJr+3HvChPXFLES4ek6XXz2h+aIjoLRbwd43SqY1X4rd7yEmvAtLcoVD?=
 =?us-ascii?Q?nP6aUNVdWSZ917gK1CHYpR3VRFXQdQ4UJpNIaB7BFvAdUvzP9exrW1fUV106?=
 =?us-ascii?Q?hTHi5AVQJBun7eqobVLVGdfIgRKRytSLnus+3E1Z8Ntqm/5j1GsJFTSKKFQd?=
 =?us-ascii?Q?HhkzEzn+P4rmqp88CpGv8BxX5AnbMEIx6Het0LithBZYMmcgwNG3Urn5t+sP?=
 =?us-ascii?Q?20ZMbyq6HNFM0IRSg9H2fZHs43qJHPCx6BEXD3bI+IzeaQrk7v8f0h++H1AY?=
 =?us-ascii?Q?Mhpg4zB8jiCbDfz/NrbWmpftk++mo1lm0xUESPP2U9zqf7oF4bD+NUn2Ud03?=
 =?us-ascii?Q?2jEFsnnPUOJ1v6ihZeRyGtYFFT/lO1holR9N2usqlP2PFLcREABd6cW46MzK?=
 =?us-ascii?Q?jhi8foF1lllIcLoYpIG1o51Ifx7lPe2UVstuQISnnMBzeubytGsjfjg8kP8H?=
 =?us-ascii?Q?0fvQZv/9dReo2roVYXfcdTvCM9SzmM/b9NVZAjYCBgvb9dQzJKT4diQr4Rak?=
 =?us-ascii?Q?NpzsEnvLRmvPEkq+/LjHtNJ6DEm8BV3IEApqug=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 594b5f30-3bd9-409d-d11f-08dbf0c6e3ff
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:35:22.5737
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

The ts->sched_timer initialization work of tick_nohz_switch_to_nohz()
is almost the same as that of tick_setup_sched_timer(), so adjust the
latter to get it reused by tick_nohz_switch_to_nohz().

This also makes low-res mode sched_timer benefit from the tick skew
boot option.

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
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 38 +++++++++++++++++---------------------
 kernel/time/tick-sched.h |  2 +-
 3 files changed, 19 insertions(+), 23 deletions(-)

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
index be77b021e5d6..d25039f07838 100644
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
@@ -1542,15 +1534,18 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
+ * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(void)
+void tick_setup_sched_timer(int mode)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	ktime_t now = ktime_get();
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_nohz_highres_handler;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (mode == NOHZ_MODE_HIGHRES)
+		ts->sched_timer.function = tick_nohz_highres_handler;
+#endif
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1563,13 +1558,14 @@ void tick_setup_sched_timer(void)
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
-	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
+	if (mode == NOHZ_MODE_HIGHRES)
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	else
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	tick_nohz_activate(ts, mode);
 }
-#endif /* HIGH_RES_TIMERS */
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
@@ -1581,7 +1577,7 @@ void tick_cancel_sched_timer(int cpu)
 
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

