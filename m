Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A97FAA40
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjK0T01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjK0T0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85F10CA;
        Mon, 27 Nov 2023 11:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLObBf94vAphWyC1/K98T5vu01XzyrjjjqvQftVrXBKJKD9Aa1hBtuKhcnbMAh5Ygs/ILtvln+BJzKkX+u1Saa7Ab4v61pgs2NGGxDGkXq/JRJ1Jq4NsD6w04aLnlbwXFoMdPehKVgQGm6AHPmyk9XAsw83bH5QxVeFB3vXIKm3+1EVLyZAy8Etx1HNeMsHfxpvOZvxQRwNAP6XCuTmgSalp/esNcSc7lvJQuvl5qiNlBUhOVuH5lGSXdtxP/T2IYC9IvqDpCmDeA2DONP+DBJtwPcHiRI7B/IfXPzEF6kGrG0UcPJ2S3wIkcvvdRdl6mfc/uaIWFgu6XPzgJPZkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcJy6dfauzuJvNcfUZVwibDvAH0IEWGy/wr2Sftqbl4=;
 b=ClSIUWnn7OZWjTpV2amPjDIieQEM0ji1sENbhKwYg1CeNA1iCxW6YaqoNoUaTW9QqsxI+0wLxcc4pR++ftmrS91d36qHvwd03M0VMYUD0jQb2h1GmAuqekPbfp3mv47nm9ITpNwlz/IP8E6y2CZMU4W2GXrb4z5M1ujF9pCDqntP0LEgfYG7zcaahq1KHDt7c5JzghD2FhRqB0xmOyVpsz09vnqKDU4Hc8pVanhOnuNUywUa2QCd+q9g9TdQZFIXrBJAWz9bHU2uZ3AD2linxYxw3FSIGvnmjZKOh70LbQ5/zQPgg39npPyVgU62NuX2wVm+cuIjSoHvE1NdGGB4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcJy6dfauzuJvNcfUZVwibDvAH0IEWGy/wr2Sftqbl4=;
 b=OY+6KiZsBG9/ioRfS3omJ0IQDuQe7hXmsrmLIb2kw4NvSGqUYIeP74BaJBHjMjlGSxm+goTm8Z+DbcKToNmCZ2NrOTkXzVO9iwqy3z/2iW+xF8JIeIgByNsKGcSvPDRFJ2y2rMPMRk/JYz0dO8sfvc/BKLC10B0z5ckTGjcyUd0=
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 19:26:14 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::5c) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
 Transport; Mon, 27 Nov 2023 19:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:26:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 13:26:11 -0600
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
Subject: [PATCH v3 3/4] rtc: Add support for configuring the UIP timeout for RTC reads
Date:   Mon, 27 Nov 2023 13:25:52 -0600
Message-ID: <20231127192553.9734-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127192553.9734-1-mario.limonciello@amd.com>
References: <20231127192553.9734-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|BL0PR12MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1be558-534f-4985-410d-08dbef7eb7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62q6jmqWJEvSy8GHvW6y9WIJHgMJyRvdLua6z25c81hFKF9weUmwNLb/lyvce1LWts1iqJoRII8L9+SFosrcClP7Yw7DU4PUvwCR4/L8dDQ+XHTGKX/3Z0Wrywd8A7eoQJgq/Yjx4FGIHXvuxgUW2uJ3KWGoJXb4RpOpDHjas0wUemVAKKZ5UUPVKbKTtZGXMXWCgsRSsxDujqEatozF3bhk59C0JP5LtizFTlI77zyn+RY10hIcCOT06lVGSYMFkCJMomZNzFfSe2oLMklc1QAJUALrBBavLvd01/oDsHRV5ZEeGKLVwljx8BeJgXZqqgj3Ex0yiFZwLRKN9cZAyaBrCbWa5YPQz+JbzMmnyizfDHa/2Hth4YQAEK+w6AO5ijpWgM2BND/2/pzi309gOo1jk9vnlLLLoMobPHfO7psWVi2w07OKJ09/uzlQngPZpHTQZN3IYXQnLZY+zFZTjgH017quSZ44aOV2WCl7DC4zz28q75HFx/rtaWvCuNogXbG686Om2wYW7iurgpZYDwyhfLSJFJks8Q/PB3U/QnBo8YogLeJMGk4Sw2pszMiuraVAm48XuO8mEPcX+6RPJ+ziVIhJfhm93ynU7Hn4Qs+Qi8NncsVaHi3yBNq4rougi5t1OuAMUEHwyd/fO4fkwLnBxGALfJ37yZfPKV6uCh9RClkYAxPOCuWXnBRCoNJPnBeg54zqZM6ikVYGAdzshTBoLoYHlu4yJEPU3A/k4Y90MGFQfY1h9Im0F4kHtdbBZAVn4SesOEN3G0ZXILTKsJJXhjMq6kyZe9mVO9AHg++Iqa847CHbblsYTuTqHUnZvlEetMLa881IwcxQaSa8qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(356005)(82740400003)(36756003)(478600001)(45080400002)(41300700001)(81166007)(7696005)(8936002)(8676002)(4326008)(336012)(426003)(70206006)(316002)(54906003)(110136005)(70586007)(1076003)(26005)(86362001)(16526019)(47076005)(2616005)(83380400001)(6666004)(36860700001)(44832011)(2906002)(5660300002)(40480700001)(7416002)(557034005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:26:13.2488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1be558-534f-4985-410d-08dbef7eb7e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 43a28e82674e..ab077dde397b 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,26 +8,31 @@
 #include <linux/acpi.h>
 #endif
 
+#define UIP_RECHECK_DELAY		100	/* usec */
+#define UIP_RECHECK_DELAY_MS		(USEC_PER_MSEC / UIP_RECHECK_DELAY)
+#define UIP_RECHECK_TIMEOUT_MS(x)	(x / UIP_RECHECK_DELAY_MS)
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
+	for (i = 0; i < UIP_RECHECK_TIMEOUT_MS(timeout); i++) {
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
 
+		if (i >= UIP_RECHECK_TIMEOUT_MS(100))
+			pr_warn("Reading current time from RTC took around %d ms\n",
+				UIP_RECHECK_TIMEOUT_MS(i));
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

