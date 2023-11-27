Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F67F9BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjK0Ib3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjK0Ib1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:31:27 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2028.outbound.protection.outlook.com [40.92.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC59188
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdDEYlJYJf8VLfFCff9X0NZll6bh7ooWPxDXQxdVJjXzkW4l/GvzM0bv4kPLPP/f6Tz+JKynatZ6jptTyGnnjN/cgriivx3ot983FXnBl27ZHCc0Z7n39M8IXcyinamNNK0r6ruLVLp4WyoAfl5poGtoaanahiSdQEvxQrHdbuQ+QZPNRbvb+jYwXaFkEtgv2vv7i26mbHJOsqhNtOcOwzIvOuNCPwECVyP6MihR72vODqmCRaWPYGk9RD9zDcZmWse54Q7j+N4hzNKtVlx480izLJC10/rdhszoBXVdiGeObyNp6wv2owS3x5hAdGI7GqTaZcx9L99CxRNVjE1GEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6KEH2EQk7TZ3P/5bKE8+8gyyzc0wNod4mUEc3xY9gE=;
 b=lm5DE3jAN0CF7pYMNhpvJgJ5iWI/49BTPNxbcvxNbj6EZGTKGXBWoQWanEVxRO4BcoqgfpOZ/r6XfNcLgsXQZdiVdqgmsKbsaeJItCGaCZchxajsgeT0GtSdHLbSJwhLpN74bw1jPsN6+OHonn0f7EwinO0imf96yCIJdS35FHDPGOEmuhtNGvQorK1zt57JQKIu66ljPYMX/WQg+pWDLYzE6fGCJayEXZbHNUTxq2XdwUKV+Ho3cwpRkhR1ystLJwFqtHPFJNuiotyKwW2ymB7sGrj282mkUP6H+VENCsDqB0U23PiB+lT15HZlzDgf9vaeN+uzNk6O+tVoueBD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6KEH2EQk7TZ3P/5bKE8+8gyyzc0wNod4mUEc3xY9gE=;
 b=Yk4zacUi9/gVfUnD5UB4KeHDMPFycbSWT5PyGh+uAta3G/7LZlXDjykPSQSnvIfaCYO6RO2Ef6i0XdVbDLFInX/3iUsRWSSP+lzCdzLBkH3d+bAu+IR/qJMJZ5Ya/LCaigAkcxu3Il5c+sgC0zeMjg/ewNYBfv8Vy02MBRS/Yl7JIp2veIK3qQeJVd7wI2VDgWedCYh6mwtZprrvVRtULQfUa147y61s3td7WTVo94Ziy4RKU046+vbAyirqLoxkj1FL8P+dOnMqRB5cX52oHyVm13SF6tGw0BGOPPQHJk+7FhcC1+wC0498w1MsOXaZksH4ciWNIEdFDq05fv82DA==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by OS3P286MB2582.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 08:31:28 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 08:31:28 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH 2/2] tick/nohz: Remove duplicate between tick_nohz_lowres_handler() and tick_nohz_highres_handler()
Date:   Mon, 27 Nov 2023 16:31:18 +0800
Message-ID: <TYCP286MB2146338A68C0382DD17BDB6DC6BDA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Nl0pgxU1RcoULqXFi4BrJFsKlmWwqHir]
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231127083118.145704-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|OS3P286MB2582:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da02b7b-c44c-49e3-dc5a-08dbef233fcb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqQKp+GzVAfLIWI4g7Hs12fjKyZevWTSvx6CO7cs5Nugyhy3Ems2wdkq63vD7SRPRMM8MRYVBG8fza/szZTZSaiqvvzZsS0bZcPASRHAS5BQd5Eru5ZN+nAL2jqJsHashomtyOvbt96+lZSgI+fP8a2eDhnrqNTvU8jgsiINEeyS6L+d6lBDwIKncF/vPD2R5vU0tFgLPxgljg70O7S2DYMUnM4lEETq7hMTAg9fS7+5b3IC34pf8C6EeVSVwRB9ICpTirNmUbVI8TE0pJFO4Wyu7HQO7YBeLdi51WUvY34fflFYHnYM8N+hNdyF4A/iNz4NT+RkS6ytZD1xVRiqLBHlp0tmtoXqtGZQtnA4/HrJBVLjupRSJlMs/guPmz+KxM4WThHjiWpa5BrukTUKmCjXHDR733W8XPcsjpqcG2rYGK6HK81rFDtRGWKGQV9BW+R95z+Ro+OT228FEZ1G31DoGmXFug4Xb/JQAvMIFq5lRMnKmbbtJEqgv2crzYMt8icSY5HQVuUIFqq5dDriOMhlXF172WBaM2dH1Y9w1QoGfyXzPL/tSjtyWuhCLkUZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNckmMGlrcCY1bpr/mkE0wAGYelKmzFZ3hAAZKkG0lGtPl9MkjGhgETqoKUA?=
 =?us-ascii?Q?uOD4IxAvgDQmADpm3M+ha9cEk5GcknkOtr8bZ7inNtjH0C/W7/UH26uZiasC?=
 =?us-ascii?Q?6+bNAY101iZnkKiyPVqp4p4mPA1SLFiI/nmDABZhZ6SIj+QkLRVbOIMWyKYK?=
 =?us-ascii?Q?s7SR/NWN+d2pSmvbISU9nsJecYBMSCh5myGY8HrgfDDkkRJIl+53fFhrUawm?=
 =?us-ascii?Q?UTeC3x59Stldm1nraP1Hil1/1nMJuQT7NlgKm+pG9XPWk+PqbhlQ095+ARjU?=
 =?us-ascii?Q?3h+KA5kkPDcfq8WX66xRhlP0ePwGBONTraum66KvJX4nX8T8WrJMpQcturrO?=
 =?us-ascii?Q?Qz6lhq63sD2yilIr4XqlciWhaPzsy2UELXPjOaM6ZBmPOgvLx6CYHXmvn1uW?=
 =?us-ascii?Q?+e9XQwfjRngLDIyhtzGlKHUh6imSIkrucO4X8a4uvLJvIe2C4PvdpxKXWm4T?=
 =?us-ascii?Q?nSwI9QUk6gxnY976H0Bw4sICKOqlGIPkp/7Ed7ARA5oTugNB45NX/aHsm8Za?=
 =?us-ascii?Q?sGQB2NcpIH8TLTYxIMHEZrRzz0yfSYCQEwwM7xmPNq5OiVBtXpNxvIRMNeqW?=
 =?us-ascii?Q?MUP5V6eASd6jirkgU0JSFFGCnyQUOZBWAK/Mt/5SiuwuPuUrYC7d0sGNhfwh?=
 =?us-ascii?Q?00hb3e7q9ztdOSdfK8ptymhxeW4zNH4lkPigFC8j1wn9O+Bkf95OE5DWF3ae?=
 =?us-ascii?Q?E9LxNmWpXshd4t+lRDmXQiSWo+Uu+Tkn/7ew1MYN1i2kC0wiz62ymDleQMzB?=
 =?us-ascii?Q?fKOWPx8z2/c+frSIAR4dOaEQjsON1DH0BWWSgB337B2xabfKTMpuiFgKYGge?=
 =?us-ascii?Q?kWGdwFnjTcIRqf1LQoT1KRFqhsxmUzCgmPJYJ7z6YlJZv/8lfdwmraVtKOD4?=
 =?us-ascii?Q?ojFp6WP/pWUUZZ3dd5NNPn245/tAz6zAk8pH/MPMDOU3J7P5yesm/7XFBhBh?=
 =?us-ascii?Q?XMLZYtgOcEfxhtPfOkBzGQQlruCokMl7kdzHHhxbVmzW9Uzw2eaNw4MfNz8a?=
 =?us-ascii?Q?j69YdQAuJ94hCu5iBETcw4WpCU46PCrJD7mrwzxBoKLkpCAqFVKPzdpZGbsd?=
 =?us-ascii?Q?+8eRXZ6sC479aPgDs8adlF7T/+vHGdmZflFw3RutRx/ZmbpPxOi0YkmBXs8J?=
 =?us-ascii?Q?zWVIeqXlajONBkK/nQeoNDJhxlb5lI+4pnaQrbCG9x6BUQR0oAaZN4aoC5Jy?=
 =?us-ascii?Q?/zlqHrPxmZdDYNMvdHuI/le/FkYkcDcEKdEfmA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da02b7b-c44c-49e3-dc5a-08dbef233fcb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 08:31:27.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2582
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

tick_nohz_lowres_handler() does the same work as tick_nohz_highres_handler()
plus the clockevent device reprogramming, so should reuse the latter.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 kernel/time/tick-sched.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cdebb6240efe..63422d6f3aa3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1383,36 +1383,25 @@ void tick_nohz_idle_exit(void)
 	local_irq_enable();
 }
 
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer);
+
 /*
  * In low-resolution mode, the tick handler must be implemented directly
  * at the clockevent level. hrtimer can't be used instead, because its
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
@@ -1481,10 +1470,7 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-/*
- * High resolution timer specific code
- */
-#ifdef CONFIG_HIGH_RES_TIMERS
+#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 /*
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
@@ -1519,7 +1505,12 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
+#endif
 
+/*
+ * High resolution timer specific code
+ */
+#ifdef CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
-- 
2.34.1

