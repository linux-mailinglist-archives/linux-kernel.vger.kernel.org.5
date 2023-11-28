Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4147FB59A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjK1JYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1JYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:24:12 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2073.outbound.protection.outlook.com [40.92.99.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AF5D0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cszRAVam13KzLSpyri0Z+neo5RcFBmyBQL1JYI0HEhZsGV+nzGA923CNIh5ApASvMuAVAFYuGkGZONBcIIko7YZN7c/xoyftgYEIq+/HX2nLlINfKAHJsxBt/Z50afxOwrXweid56aij9StHWJEAH+X6nnvd6pdZ6YKzdtTGBNFsTr+7Of45qfIXdvDIOM423E0i/5fU5ulARxoteVctUcSqvwPOnWIiU0wBwRogECTUI+dyOujEI1zr+HTg5B6yv7osFNmP84EatvQtfetd9PzRt4FhY4+EQ+lNF/cDeTZ+58yqh3EtwCY/hNoUUxnHMa37xeOQ8x7aTzhWl67fLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kEb4vVlqMF9z+4MBpf5lIv4WR04bwkZdLBmgTCGfco=;
 b=UYsE6V3VYYSzgKDatut7WMltz0lUb5QV+lPI4NaZaAAVVYgw1m22ZsEBgpuWzywldxqN0am/GpzMkwwQKi86nLFxbfg5nvhsy/lSUEKu9FbKwsdc6Ek1RZLneNTzKFT9lvEzCGnslpOK1Aim1j7re1gwHIAyCAnie8ZSufqaBnXj2cImuFgDkHta7gAvcCydjW2rVUUSpW+NV3hTz0bm3rbGN2aosyp2qP/Un7wIku/nGhztaJb8w8PbaRe38JEjIRbSwap3IMbqK8LBAkIWEYrfjMjI6HaG3KuO4gMNvpNOEHQ1ol5JuEjPuQ6gnS2UxEraYxFtpEhvhs1zc98kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kEb4vVlqMF9z+4MBpf5lIv4WR04bwkZdLBmgTCGfco=;
 b=SWYkHcX7u8C94pm5cpqWpaQzaUXgjMdYnSDecf8I0MSZKAeskpZpW9G+U/cGnCRXntYxiB76EXSLi5hkh+F89ipMwzgcHn/Oj0aIYrg5Ivfg/55cGCYDT5RB7H3+Y3ZZ2GB5R1qoBmR8zJLic2vCwUMBcwKqwB0vNXMMpQeJQCNRX4LFZVyNCOanNdHzBx/ryiJGSPigu/xJAoeQJiSUFNmdotOPbY6KjwcZNDekaXS5LOoyV8O6WjNI1e9AFrf+vP7Axg03brRrwN3jwadfFVgpXWOoRfMQ96dzyv2khKadvJ3mLHfQHrB6WfHlWqV23eqPXeyIljYtUaBjT7YMMg==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TY1P286MB3405.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 09:24:15 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 09:24:15 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Subject: [PATCH v2 2/2] tick/nohz: Remove duplicate between tick_nohz_lowres_handler() and tick_nohz_highres_handler()
Date:   Tue, 28 Nov 2023 17:24:13 +0800
Message-ID: <TYCP286MB2146FA111842EAD33796AF5EC6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127083118.145704-1-pngliu@hotmail.com>
References: <20231127083118.145704-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [g3cg2rXksPg0mwyiatDHncz3IuPGL2VA]
X-ClientProxiedBy: TYWPR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::20) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20231128092413.160451-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TY1P286MB3405:EE_
X-MS-Office365-Filtering-Correlation-Id: 788d8520-7c0f-4b5d-6195-08dbeff3ca73
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hz23AqrVKKmuXSNVkSDPdHZmKpwfUxpgPZCf6O3PH2HuL3EuejFCq8h9Bj+1A9P7n3Jo/+9kI0kZ7MIfnq1sqggN4Fy7cVpyVDJPtf+QE8bMYLkVeF+qPZ5aGrCHGu0SZJf+Dt8Ks0DpiEBgeOsQjjFVfN25CnUhChqDroIJXsFKRdYNP4Z8yt/+DC2Do7WjF4ZUoMkoHEybVEwDyp8+xwLPmk5DhaCAAZuRIv5ZJULUGUXDaUM2yWL6U7W5Eck7wV1ROS5467gw5yDnvsG5dRh06v/9NJaRjU6z3dxfxyZ6E/QlGEX3qeGRnBrVi5AhCRxEJUZefHCSEWFZ2W2KDGrEA6yHDrM8xS5ZRF0L8sh4i6jKDSyS0hVD0jd08TX1tX+ZD9QuEECZk8qMr7KEczT8qtASGVq2J36bWm8gxsyt8IKHs8N4kL/c+5L6i3bhVDxTeujsi9xCXTtrbUKk98e0iq/f2jjEA6q/7eb1M2v84/BuV7jluYfcQ+DXZQtCGEXurMYEY7HEsYrQ7nyyCGyn0ySiHac4wdUYfywQK0L/rbPUB0Dy9S+3yfzqdmu+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NmpkJxuMfuhgpcT6RfwcLNCwf7pPBmDtz9yuZnetP9MWbHtZGt8GsM3EIwvN?=
 =?us-ascii?Q?G/aSAxImmkH1HK8Oe1xihWagb8mkusvAMHDo7Q9JK/lVi8/lgx+pXwq7/sQw?=
 =?us-ascii?Q?Zap7CDVLPF+B0Dn6PSXVKUUWLI9W52DbC/PDGmSJXMG3Ab2oec78FptPulVo?=
 =?us-ascii?Q?SxWB8qah73uG4QOEmM7Rb7Mc9FB049nSFGGH06RNnJja1p6BLOdddwamfQXc?=
 =?us-ascii?Q?tDOqOYKEQxM7K3UkOUvL/F+Bf0Xl/XfIUSbwqF+s1ZadIJqwkiGB8Pzpj8kB?=
 =?us-ascii?Q?G6Hr6MYYLUXb4KC6u8lrdOXU2rqpzZSCjQG5+Y3rDQ7eyhZeBCehCS1DAKW0?=
 =?us-ascii?Q?paolWw3zty/OmxfgRfCNPj+Xk3JhCH671uKyLqQl4uDTOWatbr7dTqb6+pPp?=
 =?us-ascii?Q?oBWQtrbmDacqgaHV5866PbCje3lvJKVYF+oRspSz1Z4NrFSnWVrBGCZfV9sj?=
 =?us-ascii?Q?/f8lo4WVecEuzPcHKYszhkNhLTSqqABMVvvA4aLPV4iwCTx1wUnEEm/jjOGL?=
 =?us-ascii?Q?rrEv1sEMbRsIqVNuEuilbhOU7LkoPSn7pSdBwA5QoeXZqfxI8SrjFLqS6ZlE?=
 =?us-ascii?Q?MUZMQi3yqeCiY9tkJMdVHVZl187jft3aRlo/wEkJbNjlLDot6W35i10IYv9C?=
 =?us-ascii?Q?OTX+psArizsK3QBGRF8IWpMN7ycMH9mI6PRuW9iHoSNzRQacJkPS8KL0yQEA?=
 =?us-ascii?Q?1q6QOvT8PhKQTC3cJHZnUqHPHVxVDz6HmX58Bhg3LWz4BFv5ZCQDHJYzAwfF?=
 =?us-ascii?Q?3iMTecvQcND0PeIfqIgVZYpbCtIXYXnKjyxsZimaw6OQMqEnnUaP6lmDmybX?=
 =?us-ascii?Q?2usrGjgkVjrdTTq0gIzP27xW1sjm2xkJHw39sYKsaP2+fZd6BaPuItsZ6yOG?=
 =?us-ascii?Q?edr6/A4018Inu8WatrBsUSW7SOXa7NaKxbJNQeQQHK2nMAFD8RmbzN+E+H9e?=
 =?us-ascii?Q?e7EPlfUDBRQtdbzuNBfZl1+5h/yR12aMuB+7FB7Widmg2cnSM42UeYY9evwd?=
 =?us-ascii?Q?OuLU2Bse8K9+HWlG1nmP9Szg9dKyE5dZxnEo6sfs4TSq57stiekfKq1GXX5W?=
 =?us-ascii?Q?PRAUuwMwutjbqkpvL/+renfmmvToc1cK+aPFbHtSJyQ2MZpt9I41wZnM2hBK?=
 =?us-ascii?Q?D8VrxwwKc+QhuwERe8VY3qteKWefHDRiwibybK53pT/oo92bGCp34uB0oA75?=
 =?us-ascii?Q?7Yn8JcqERNvaPG/DGmbNOnIK5qftG8s7nDTxJQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 788d8520-7c0f-4b5d-6195-08dbeff3ca73
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 09:24:15.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3405
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
Changes in v2:
- Fix build warning: Function parameter or member 'mode' not described in 'tick_setup_sched_timer'
- Fix build error: use of undeclared identifier 'tick_nohz_highres_handler'
- Fix build error: use of undeclared identifier 'sched_skew_tick'
---
 kernel/time/tick-sched.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 96fcf5cb1b49..c2142b38c31d 100644
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
@@ -1519,9 +1505,7 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
-#endif /* HIGH_RES_TIMERS */
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
-- 
2.34.1

