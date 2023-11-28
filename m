Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065637FC197
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbjK1Oqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346340AbjK1Oqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:46:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B49D53;
        Tue, 28 Nov 2023 06:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRmQt++Y2C4diQcPL3o/uV4UfNNwNK3tD3J2Kqnm/iWZx30UhGWcfy10xlUvfzhXw+MvMzqBb0w1vB13S3QXecqxMvDBtngwLp8S/xwtrbhTKj0M0Pa3qhKxX2TrSZaERd9nve7botDlJ39AD2hCttucRfSpAEIPya6jH51YK4jTewkw7w7CcjuWS8mYvgV+e4kmyH4o9zyyY8lGcgVqxRCVmj+bgSD0XjwIPIC6HYvlkTK/iIwLPbS0lgMuCHQRASDYjMWfaYt46FWIcRjq6iKfzFzHQffoFFmt8eLEjTckGfk3Rq37JwENVgQFAOjfo+iOj7fJY3imjbiFY6ioAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps6iDQXFBMjrpu52pMY4QXIybFrEFrNvG7BxcKU0/28=;
 b=gIaR94fAL4XfAy9vwTKHlzAbQFRfGh3gc1jnK66YFdKCOa8ZTzqtiWmB5NlAkzBmbq+FM0wi+DknfBnqr0AuLoxm55l/NMP8N+6SELuw4bSzhz/5OHEcogkUmXUcURsJoiUfHGQti8OQ+2BFws2v8IAlp/YYu0jr9TvZCI+jTjNY1KfRJFQ7vS4P+533sEk43qaBuIqlJ52VFD0sKR6xe1w7zIu61cqY7i5R/G3CAqQAeGfmfypuaPvd/caHAGkxoJEUTB78Ap5EpbQd0nIed08CjFvQUD+J79WS0Z9cW/cHe+2KTZ4MEcEMkoC/Rwk8Eri3UO3RGJG6VnoO4JypVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6iDQXFBMjrpu52pMY4QXIybFrEFrNvG7BxcKU0/28=;
 b=OdpgXv1HmZTplZYuzAqnRNft/0sCISIw7ppAeevga9UD2VOKjrOkwBAAnQ0vWPeTDCgSFnZ8Z36Mi7IJO0iNv26Xq0DSpPPOkPqUFRhp4emp3vGdKZg194/suHAgYSY2iET9FmTnXBiMTiQy6Kqr39kxaNDZJQ9xbyYufHuNt6Y=
Received: from BY5PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:180::26)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 14:46:44 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::a) by BY5PR13CA0013.outlook.office365.com
 (2603:10b6:a03:180::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18 via Frontend
 Transport; Tue, 28 Nov 2023 14:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 14:46:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 08:46:38 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, <dhaval.giani@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 3/4] rtc: Add support for configuring the UIP timeout for RTC reads
Date:   Mon, 27 Nov 2023 23:36:52 -0600
Message-ID: <20231128053653.101798-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128053653.101798-1-mario.limonciello@amd.com>
References: <20231128053653.101798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b24af6-af33-4a40-f804-08dbf020d713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0hJLQ7Ax1ZwOVFbbbSQqCgv+lb/e9gJmjzo9H5UfZOEG1G6t/GzpdJsEjx3ouR6hacOfYkshHaoWFIhCxyzT249/0bTjwbu+OUqsL/2OcTjzoADxx2KhpYS46AwSh9AEhuxKk2URTtbPcHFYscTmI0Py9on01TwoVI9KmO6RkRDn47zRXdXUQ1IIGTNcMB3//yhcD/juyrOe8g+Hco3rj9rE6vYOnHREcCmUzsyxUV+7s2MJ86tt8t/1w3lDuxUQ+l5wyyi/pEZRSbzQ8GEJNhSNIWDf2Z3X92kj8ReWFPVh79szBo1s3N7YmjH9rtAGkVUjgd/6M3FpTr02r1X19HwiktgWyy+vdp6EEK3ts0k2nk3eG/QjbRrY7uQy754yj5X5MYX1Yp16FL1eb/GvV+BxCkJToWW2VizKApOwaZOJpr2XOqoTvjg3Xrj2SiryQ8WBo4Kacnxs+C8tzB2Z/+8TttsoD2oGfnHjQIatnewsiPMvDukhPIhRrsFq8bEyUIZH+5W9ZuGej1dVtWR9ucyqE8Blbp4hK/2CjYLzYlaqy06lOriCCVpFneCQvHoRAx2ubj7bOYEDV+FWNeSs3j7FThxCChLo4/+4+Ca1PDsTL/T68KDHSPMriPCPcy7ZUF4jZJl30kvaCCzLHzTmFd3HCnR76XSsWNzflbGUQXzC9QA9iz41Pr5N57K44mv5xBn3+XcgoN6iefYGmoEXwTQd2NiiZK802s7Sn9dhxky7X0ayVQieLscl3Kk7e8T7Y6soY580Y1D5DjXcQzTxJLkfYlzlu2dSFYhSivb8MFMrt3GKauwuXBovNRAggJBlgzAv5vKuFF7eVtwOSLNfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(8676002)(6666004)(8936002)(45080400002)(4326008)(7696005)(316002)(70206006)(110136005)(70586007)(54906003)(40460700003)(478600001)(81166007)(47076005)(356005)(36756003)(41300700001)(1076003)(86362001)(26005)(40480700001)(2906002)(36860700001)(44832011)(2616005)(83380400001)(336012)(426003)(16526019)(5660300002)(82740400003)(7416002)(557034005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:46:43.9524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b24af6-af33-4a40-f804-08dbf020d713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UIP timeout is hardcoded to 10ms for all RTC reads, but in some
contexts this might not be enough time. Add a timeout parameter to
mc146818_get_time() and mc146818_get_time_callback().

If UIP timeout is configured by caller to be >=100 ms and a call
takes this long, log a warning.

Make all callers use 10ms to ensure no functional changes.

Cc: stable@vger.kernel.org # 6.1.y
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Change label
 * Logic adjustment for for loop
 * Fix pr_warn variable
v2->v3:
 * Logic adjustments
 * Clarify warning message
v1->v2:
 * Add a warning if 100ms or more
 * Add stable and fixes tags
---
 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         |  6 +++---
 drivers/rtc/rtc-mc146818-lib.c | 37 ++++++++++++++++++++++++++--------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index fb3025396ac9..cfdf90bc8b3f 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -80,7 +80,7 @@ init_rtc_epoch(void)
 static int
 alpha_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	int ret = mc146818_get_time(tm);
+	int ret = mc146818_get_time(tm, 10);
 
 	if (ret < 0) {
 		dev_err_ratelimited(dev, "unable to read current time\n");
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 41eecf180b7f..17adad4cbe78 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1438,7 +1438,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	memset(&curr_time, 0, sizeof(struct rtc_time));
 
 	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE)) {
-		if (unlikely(mc146818_get_time(&curr_time) < 0)) {
+		if (unlikely(mc146818_get_time(&curr_time, 10) < 0)) {
 			pr_err_ratelimited("unable to read current time from RTC\n");
 			return IRQ_HANDLED;
 		}
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 1309b9b05338..961ebc7f1872 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -67,7 +67,7 @@ void mach_get_cmos_time(struct timespec64 *now)
 		return;
 	}
 
-	if (mc146818_get_time(&tm)) {
+	if (mc146818_get_time(&tm, 10)) {
 		pr_err("Unable to read current time from RTC\n");
 		now->tv_sec = now->tv_nsec = 0;
 		return;
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 72b7a92337b1..c2e925357474 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -120,7 +120,7 @@ static unsigned int read_magic_time(void)
 	struct rtc_time time;
 	unsigned int val;
 
-	if (mc146818_get_time(&time) < 0) {
+	if (mc146818_get_time(&time, 10) < 0) {
 		pr_err("Unable to read current time from RTC\n");
 		return 0;
 	}
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 391f91d3d144..d278b085821e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -231,7 +231,7 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 	if (!pm_trace_rtc_valid())
 		return -EIO;
 
-	ret = mc146818_get_time(t);
+	ret = mc146818_get_time(t, 10);
 	if (ret < 0) {
 		dev_err_ratelimited(dev, "unable to read current time\n");
 		return ret;
@@ -307,7 +307,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 *
 	 * Use the mc146818_avoid_UIP() function to avoid this.
 	 */
-	if (!mc146818_avoid_UIP(cmos_read_alarm_callback, &p))
+	if (!mc146818_avoid_UIP(cmos_read_alarm_callback, 10, &p))
 		return -EIO;
 
 	if (!(p.rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
@@ -556,7 +556,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 *
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
-	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
+	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, 10, &p))
 		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 43a28e82674e..4c17b3cef11e 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,26 +8,31 @@
 #include <linux/acpi.h>
 #endif
 
+#define UIP_RECHECK_DELAY		100	/* usec */
+#define UIP_RECHECK_DELAY_MS		(USEC_PER_MSEC / UIP_RECHECK_DELAY)
+#define UIP_RECHECK_LOOPS_MS(x)		(x / UIP_RECHECK_DELAY_MS)
+
 /*
  * Execute a function while the UIP (Update-in-progress) bit of the RTC is
- * unset.
+ * unset. The timeout is configurable by the caller in ms.
  *
  * Warning: callback may be executed more then once.
  */
 bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
+			int timeout,
 			void *param)
 {
 	int i;
 	unsigned long flags;
 	unsigned char seconds;
 
-	for (i = 0; i < 100; i++) {
+	for (i = 0; UIP_RECHECK_LOOPS_MS(i) < timeout; i++) {
 		spin_lock_irqsave(&rtc_lock, flags);
 
 		/*
 		 * Check whether there is an update in progress during which the
 		 * readout is unspecified. The maximum update time is ~2ms. Poll
-		 * every 100 usec for completion.
+		 * for completion.
 		 *
 		 * Store the second value before checking UIP so a long lasting
 		 * NMI which happens to hit after the UIP check cannot make
@@ -37,7 +42,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -56,7 +61,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		 */
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -72,6 +77,10 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		}
 		spin_unlock_irqrestore(&rtc_lock, flags);
 
+		if (UIP_RECHECK_LOOPS_MS(i) >= 100)
+			pr_warn("Reading current time from RTC took around %li ms\n",
+				UIP_RECHECK_LOOPS_MS(i));
+
 		return true;
 	}
 	return false;
@@ -84,7 +93,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, NULL);
+	return mc146818_avoid_UIP(NULL, 10, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
@@ -130,13 +139,25 @@ static void mc146818_get_time_callback(unsigned char seconds, void *param_in)
 	p->ctrl = CMOS_READ(RTC_CONTROL);
 }
 
-int mc146818_get_time(struct rtc_time *time)
+/**
+ * mc146818_get_time - Get the current time from the RTC
+ * @time: pointer to struct rtc_time to store the current time
+ * @timeout: timeout value in ms
+ *
+ * This function reads the current time from the RTC and stores it in the
+ * provided struct rtc_time. The timeout parameter specifies the maximum
+ * time to wait for the RTC to become ready.
+ *
+ * Return: 0 on success, -ETIMEDOUT if the RTC did not become ready within
+ * the specified timeout, or another error code if an error occurred.
+ */
+int mc146818_get_time(struct rtc_time *time, int timeout)
 {
 	struct mc146818_get_time_callback_param p = {
 		.time = time
 	};
 
-	if (!mc146818_avoid_UIP(mc146818_get_time_callback, &p)) {
+	if (!mc146818_avoid_UIP(mc146818_get_time_callback, timeout, &p)) {
 		memset(time, 0, sizeof(*time));
 		return -ETIMEDOUT;
 	}
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index b0da04fe087b..34dfcc77f505 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -126,10 +126,11 @@ struct cmos_rtc_board_info {
 #endif /* ARCH_RTC_LOCATION */
 
 bool mc146818_does_rtc_work(void);
-int mc146818_get_time(struct rtc_time *time);
+int mc146818_get_time(struct rtc_time *time, int timeout);
 int mc146818_set_time(struct rtc_time *time);
 
 bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
+			int timeout,
 			void *param);
 
 #endif /* _MC146818RTC_H */
-- 
2.34.1

