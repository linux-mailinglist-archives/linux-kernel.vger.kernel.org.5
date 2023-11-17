Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442EB7EF93B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjKQVKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjKQVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:09:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C2171F;
        Fri, 17 Nov 2023 13:09:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNDNlOsqYftdcRKfkUZh2hlg7VuG+2m0ylMhVT2Jne9QqQmcWaMQKqMHLwl+SEMwwB/ixfuwc64FLwPZqsf0tPj+FFZF2kBb9wqJRoJnbv9OUVHxjNfSfXLyRV5U+8FPhOfVVC/3QSMJJhARoezgn6+p9+hmygDV/rSQKjnyOxzHtxPnh3GMGzURbCCQMW9/1wwp3+TBvHoC0SVWGaMayuRe4ZpFuV4c9x0f0mfuxmap6u46o976fjn7IvgLJDJv9O/x7cM447EG+D2/BqODs0AtlS6KwXiyRyUGZJuqbe2y6LcfVAQ+Ywf6zOgE24KFnSviXV0W01Zs0F0s/E/Umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFyiGmf119Op9GqQbFyP0NA4Zv5VJqvlGq3oKt7TijQ=;
 b=Z51eYaE3Qa8orG3JLEt4Qzw936WWroq1NpueNUCngdl8IfZgcaeirFGQjVM6KGMLZrRPccjbuEPZVcx7/Vq6s7O8OPrkUL94Rb9MBguEISn3PuBVZRl4bBQzCLb/uUnNbFmLfIDhHJTwEJNDpjr09h6pghvOJ3eDrnPpbr5O4479J04Q7ugd4bC9N3erXKgDh95n5PoKADcBu0iNT2HmCWWR9gisOahbRa3FCBEWHjHlh8LZQX6FwEiLiVsLtVhNLMu1JurO7dWjBmXZlKpPPLcz4MgtmsuwKCIGC7ft2JB6S7pl1IggXCWYoNDHjY3YI0CXxZ9dyvXM/AfZGIkp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFyiGmf119Op9GqQbFyP0NA4Zv5VJqvlGq3oKt7TijQ=;
 b=tud27KH2Fa1DZtcj7xap5bx4Mq4AxGahzmcBezqBM3KlXc/IE+WwuKhbu9IXYH1czbx4yIwqegGksMGMmYvKWAco2DAnjDkrGt9LNyRTRhCYzZZKH+dpVzTbrlSnXwUf2xFbleKXa0WSv2WoeVqsHRkE9jJewy87QF+jO9CrIg4=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 21:09:36 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::91) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 21:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 21:09:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 15:09:34 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] rtc: Add support for configuring the UIP timeout for RTC reads
Date:   Fri, 17 Nov 2023 00:32:19 -0600
Message-ID: <20231117063220.65093-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117063220.65093-1-mario.limonciello@amd.com>
References: <20231117063220.65093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: c0912520-5cbb-4516-4b0a-08dbe7b1810f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1AvWDSWXbFzEKQu3v/vYEMJqKg0SJF4Y444aPwunfUQ1nl9b62yN1SzNU/Bppet4SWEXk64qpCnqIjc0LoYSymSwoWWPItOVlOmy+Cl6wfeMEMwwrWGiUnw800Su+/cyNU0Fk6gnmzSUIto60Q3Wqu9VW49mfBUbHZYwVvDyFTBeMeSESZ4Rtuc4ov/hF/7Ay+vPzCkiui/T21yzhmji3YXXmkt8uLMB/5c0nwW4w/+HlfIusy8fKotpHV99m4C3rZx1167V9gKRqr0L67MVUkgiWNFWVIPGGteMLXrfVSHvb2QTdNbpJxeamWsJY4MuJ+Nepufk7onUv6Mz6Akt1b38bh+dylZ+X5alaNGiXDhsD/whDy3RT4W9FPQeyHlO1TPSXqcV/vzGOa/Aepaf/t/2Tv1KznN49sszsfScSGUVzs5t4yaPQ0E9C7Rg58bZLV7M/cJYmel3uzDPH7tvM/JEuywu1rpA2r2rm751XXpA07+u7PZvnm8CpoF4MIAYQgd2OTF6DhZEhiw/u5E//Gs/hLbV7Zm6MpuZoL5Dj8ODsZ+yL2yD8AVF7jgnpCnFj+0NU3oPOV+6bhX3uzSZ+5aOiwYaHEnTQsW0xI06d8F+M7clMfX/MEI0D6NI/Sj820AWi3PtPsWh3Sc+Hwos1xwXXi/aGQevUidvrjiR8kf9jgjExH953M3pK7n36DvCOYmIB7NQw/xJn+BoagTxzhziq9DhgqHTtCA5dp96XukHlvwULskmDTOnpYRo/pbpEX3br77aoFLARrNhaLVHaAWzq97eyYMgjxQ4AnpZvzwMXwZmf1FKUvs7GN2vpLjy7U01H4imT1wdaI19WT2hCaHMYCLGJHVVcXR6W9iwuB0vgje5Q/a56abueIWb0Dlt+VeSGn/X1cSXy6j3pxSNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(336012)(83380400001)(426003)(6666004)(7696005)(82740400003)(16526019)(1076003)(26005)(2616005)(40480700001)(70586007)(70206006)(54906003)(110136005)(478600001)(316002)(36860700001)(47076005)(81166007)(356005)(40460700003)(8936002)(8676002)(4326008)(44832011)(7416002)(41300700001)(2906002)(36756003)(5660300002)(86362001)(557034005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 21:09:36.1829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0912520-5cbb-4516-4b0a-08dbe7b1810f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UIP timeout is hardcoded to 10ms for all RTC reads, but in some
contexts this might not be enough time. Add a timeout parameter to
mc146818_get_time() and mc146818_get_time_callback().
Make all callers use 10ms to ensure no functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         |  6 +++---
 drivers/rtc/rtc-mc146818-lib.c | 31 +++++++++++++++++++++++--------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 32 insertions(+), 16 deletions(-)

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
index b39890a5531e..16dcbd196ce2 100644
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
index 43a28e82674e..75b2fc1791e6 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,26 +8,29 @@
 #include <linux/acpi.h>
 #endif
 
+#define UIP_RECHECK_DELAY		100	/* usec */
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
+	for (i = 0; i < USEC_PER_MSEC / UIP_RECHECK_DELAY * timeout; i++) {
 		spin_lock_irqsave(&rtc_lock, flags);
 
 		/*
 		 * Check whether there is an update in progress during which the
 		 * readout is unspecified. The maximum update time is ~2ms. Poll
-		 * every 100 usec for completion.
+		 * for completion.
 		 *
 		 * Store the second value before checking UIP so a long lasting
 		 * NMI which happens to hit after the UIP check cannot make
@@ -37,7 +40,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -56,7 +59,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		 */
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -84,7 +87,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, NULL);
+	return mc146818_avoid_UIP(NULL, 10, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
@@ -130,13 +133,25 @@ static void mc146818_get_time_callback(unsigned char seconds, void *param_in)
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

