Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58C7F9BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjK0Iaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0Iax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:30:53 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2014.outbound.protection.outlook.com [40.92.98.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F62D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZsXnDnCdqUSdDUbTMp/aUNMHsIgj5y9n1k8HCAZK2TX9iBjJVJTve59aekcr0RaEJo0vnZyhIQlsdwGry0Nb1IWC/HNnitiDcn5Uh33DD8rfZFjKdF/DLaK3btbsYa4Fxp6VmYczTUIBqJYDGWJVell0M2t2CdP37DJ+8hjX1QTVRmvDoxrEnnF3yjF80AZ0pSY9s5xQWQ16vkEBzZoICK6bSxaRn4Flmir3Mt3OzatCFbCjNN2i+29o6oEB2OXyr1O1BpTWGpaE+HOHFvG1Lhp0ktu/FdJjPUVaWHEoejoYuDpc2SmPOjwurWN6ywNPloNVHCiG42fPqWxnde8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbhTtO1DyUajqrpBpxxXwfxzopaRWKbOS3Y6NqqOJjM=;
 b=j9VFTOohTaCvtpAP84BlSWptVk2CNbUc9gksRHVJNpItz9WclTTIKoZNuIxdYcU6DELaA/t9QHnRchg/a+9btMmkimDeJppCI9tPkAhrnhwoi2lC0QndM72d5cpoen4kk83Lg0Y8oPtl3FRvaXvwoWfvgKtWLJpMrHqPd0ryVqzBhKnODaigBeOrmY75hzpjllqleDfUO3mGHC9QKfsQCifUstRTU4lFKxjZm1KJgzT87Otix2L/lI5DS+2x+Kgch9oz0K2hHpCPp5fYw5aXW4TN2OUY6NpSfoO/GXJPn3YpC/GoR/im5ikhP603wp8thGeeG4e95w3Wi47PqY7lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbhTtO1DyUajqrpBpxxXwfxzopaRWKbOS3Y6NqqOJjM=;
 b=uaq47mnFypc/TlPEKt0FMco19gyU5JSl7WVY4YscU1QyCdoN17GfDFnm91a/WLY9Gcmfkkkz/9PO1/xpBFVJVuBgo+SLnCYCt/NNhhzazH0SfpJYJktEcmdPr77HzHYX/OYxfBr56rHTT4c0qFmtUhiZMg9z0ZdTTmlZfjugpp8zMLALKHtiGHBEAVKc1dGslB9WlRUHqni5Sy0EXhLNF5x5mzjS0F8T17MRbY1KUdOj5jiSHHr+tGIS3rqiG9yaOeWBgQSggB2GK3y0mQd/kN6hGQgnCBqMxQH30Jc94Ls2GGQ9wzvdUwe2O0bVV5UWEgEIR/Dbu8m20DXjHx0UPg==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by OS3P286MB2582.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 08:30:55 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 08:30:55 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH 1/2] tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Date:   Mon, 27 Nov 2023 16:30:49 +0800
Message-ID: <TYCP286MB21464B3653B956AF71806931C6BDA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [3n26wXd8UZjmW4kfGu/2yRVJJe4Vrl+B]
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231127083049.145447-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|OS3P286MB2582:EE_
X-MS-Office365-Filtering-Correlation-Id: 606f2a6e-ee14-4afc-f7ed-08dbef232c1d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opPgzYpbLBx89+qw7cAV9HcDaoh8eBprCqVyrFuY/jzBcGXFEYVwPiQVD1hi/U1jy3jI2GaFMzc00ml++DWthaD7B7bEyy+KXjgRJeb5wdbXLnPnZXoSnctFg5ctV7gPvRNWR7hDUBEN3CXMcrZOrvuBeMfA5sTYvME5cl/c4tMFwAL7FWyl9XJqZIX7uGTcyt+M+EXD9y1fr6Qj2tQVPNBWqygdWubLmWmp3aTBj8qNYE9SQAMuRv/ZUCpzmyO7zy3CHGWxPSuI7u/p8O8Zoil0+pFgFQzQ+HtB5iIYsl2RaTjO1XorTqk4c1uDWZXpmcklfm4NIVI/2iCCLyf/swZZnFd08v09Qu1ED3oBhdM0dIV51VL7FAbVu4u0o3aAQF6soukxYZwM2WombYUT6wS02rE4eXG+50qutd9+wrobZNdy2Z+DrIShMVaYIjF552TA6FSxP/TZp5vCbkNzs6BrOnVM7dMqUI4KpFYWu7jfLiFQQQ501AYLatb22i7Kvn/hrh38wWC4qUX5KgKBnN/dd0RCB/PxJ6fPq1m5MeUeqlVvfWiyrT4l9xAnPXBQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wG65ZDB+n6750TFDnK4AdwgRiKZDOtYf2ew0yO8by/jZXpcJLQdR6qQYpVAR?=
 =?us-ascii?Q?jkl72lvuJe2wWZOA4Wt+VBxDNlB0wP4V2xFYMduktI8FVksBDYMEZd0ssKDk?=
 =?us-ascii?Q?yqPYDmX33ubX4BAPCR/hJnzzPuD4thz2I4EQ1tv6BrBvG6ZesHIi6IDc58vZ?=
 =?us-ascii?Q?Bd8aVKLUEhSrxE5BvkXYAXsOl390plWBC7jryEqVDpQP5/5lW5aRX2daQn6u?=
 =?us-ascii?Q?/Sq9x77WedxFtYLZxPJXo7/AtDFyFzqZS0KlEGlL0lxoWODBJRQug1dj7rZp?=
 =?us-ascii?Q?b+zso5kOWZqY34ajXrLXcEYKeG5FLY5q39EO5tfQktdgsCUUfpiR1J8fst7t?=
 =?us-ascii?Q?aDTJIoRKAtvrs6Qhr/LVF8wQ1z9YERTCEB54hd72ylzH0xm4Vd88ZVnLZkE3?=
 =?us-ascii?Q?fW7S+rvXMPfIJNzS4yjYfWtZIEY204+BTV3KUxb4AjpukIpwkD5Y5puZQHj1?=
 =?us-ascii?Q?/18R8mEj3p5WlXyeyn5sBA62yh07k7CaSWp1NYSHvtXdVDOJ859jU4CzpWEk?=
 =?us-ascii?Q?cLFdemhn5X67jR30w4Y4HV3rchbpVJFvaJllr0T5TfPbXzXBiQ4bE1zawBzu?=
 =?us-ascii?Q?57RBTV3VNxQiQqT5cVhFiC+kit3seXHTaLZ4jO+3/lpB/K44arQ4iOIvbRHS?=
 =?us-ascii?Q?N3PO5davpyR0hDvvX4FFlnsmmYcxT7ZSQ/hO/0CQG4Of2JpxNMNL/75Otnuw?=
 =?us-ascii?Q?Pnq0wjSvku32Zifflw7+VrfU+ceOFyhHWKh+05ZSHeeqRt7CQ/7bcZ/dnSJX?=
 =?us-ascii?Q?B0imZfu//H/Tn1X8/4jfAMpm6/RPS7WIfF/eIGg+ceccuCoIPq/XxArTYDP2?=
 =?us-ascii?Q?tjtzlMLz0cFB/IeJHSLi37QpgzY4Mpc289I5tCytu/pQ2k8tEcDpoPwti4H3?=
 =?us-ascii?Q?77Ep7AOZYN0q9qOI/oM9Ub1YJAE7eLesOeYWnAR3tEWLOM1zAjFP2mXWWwW1?=
 =?us-ascii?Q?iVqfg9Rkj1uk14bODklcVtM8S7DfyBB1hY7SbuCQiJ9QNQO5lmNfs75YpWhi?=
 =?us-ascii?Q?dXWAadolNa8/kDAThB1RT/R1H2sJRYkU6MbNWdI6tyBcXvxDjnfSCfxh+Yfr?=
 =?us-ascii?Q?Tgxl/gnHOOUXaWuJ1r1dDwwZmAVQmkO9/0NI3jkcqAsVGf5Bpv7r236L1cFT?=
 =?us-ascii?Q?JEq7oMDsycFejy3ZgBTfKlj3b3FvlsOpdsVdjxgpTR4RvTfEwLQIM5PWNcXx?=
 =?us-ascii?Q?6AuXZBzJyM2MmsIZHrDD8CXt2CESIhewPZXang=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f2a6e-ee14-4afc-f7ed-08dbef232c1d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 08:30:55.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2582
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

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 28 ++++++++++++----------------
 kernel/time/tick-sched.h |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

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
index be77b021e5d6..cdebb6240efe 100644
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
@@ -1539,18 +1529,21 @@ static int __init skew_tick(char *str)
 	return 0;
 }
 early_param("skew_tick", skew_tick);
+#endif /* HIGH_RES_TIMERS */
 
+#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
  */
-void tick_setup_sched_timer(void)
+void tick_setup_sched_timer(int mode)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now = ktime_get();
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_nohz_highres_handler;
+	if (mode == NOHZ_MODE_HIGHRES)
+		ts->sched_timer.function = tick_nohz_highres_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1564,8 +1557,11 @@ void tick_setup_sched_timer(void)
 	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
-	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
+	if (mode == NOHZ_MODE_HIGHRES)
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	else
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	tick_nohz_activate(ts, mode);
 }
 #endif /* HIGH_RES_TIMERS */
 
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

