Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075A7F157F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjKTOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjKTOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:29 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39111113;
        Mon, 20 Nov 2023 06:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS4/W3f3CE6RWmslp8t/m2rkXROi2MrQGsfccsBtfGqeYqPdkJedCUGP4eEWCd2oerHQpmv6+hj38J6X6GXUg2XnuW8GYoZBb48oD3dAT1SYSe9sBZTocN/5fipefNGIkiEf7IC0oIv0Yhtsek1w2alBeMv8vXsim1YEDVeE6C4tnzzhplYZmRwdlv/0r9Wxq1Ngio1hVmnRK8pE4rcTB4mUHlrAeSmQ3ngERc08G+rXU7FqKgMieDxhRs6OBxTO5mvC7gjdUXOdf4Z68EshmAB01xro6wex/RPdk5thCZnRK64GcXGAzdWbqtNlbXgNV9OArrgXphy0p6VJnl7TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU/xXbt7Cmsljc+S5yKqygKRc9J22o56OUEH5CQ8XRU=;
 b=f6D2v2nTYIg0Ks5imAm8aCDoTk/JnWwOG2Qc2N5XUReKFklSvZU3fff3FhDZbJnQiubgVmHEtNIAZKBmwSafNc88A93IpYM4YyCAwKrv3HGkLpnaVhudpUO2QVpRVMOFOnSu7VJ3E/2ocx1nkPrra+bO/5aUa52m3ukEpHUGaai6BEdV8sP8Mwafk/oGU/g1hWIyGphhqPEStZAvS8W0JdxbABSAUqNtg3MdLlG58N05KBzPuIED9KlOS+7HXKCrdb77L32TbQLSlNuZUrpG8yusJbrLMeA1SZRkbxCNgMQVjJRkJSbIcU+HZYmV54oUz6RX8EWeYZNnKVlo/UY6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/xXbt7Cmsljc+S5yKqygKRc9J22o56OUEH5CQ8XRU=;
 b=fKdL18UKx67DlLzBWnSppoczNYxlgXaVZrCImLxoixRlVVmHTNs9QC1Ak3ZruVa/RKF9/RV/P81Sg9Tdl+2GwItymjFVbF+b4GT6RYsbjAowS8YoJBDGIsZoUqohzpvP1Oudcr1UOJdqa4BaXgmQ7CMKeM/AuLjLZGMhw0jvB5I=
Received: from CY8PR12CA0067.namprd12.prod.outlook.com (2603:10b6:930:4c::7)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:16:20 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::68) by CY8PR12CA0067.outlook.office365.com
 (2603:10b6:930:4c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:16:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 08:16:18 -0600
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
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 3/4] rtc: Add support for configuring the UIP timeout for RTC reads
Date:   Mon, 20 Nov 2023 08:15:54 -0600
Message-ID: <20231120141555.458-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120141555.458-1-mario.limonciello@amd.com>
References: <20231120141555.458-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: e92f08f4-55fa-4f48-9611-08dbe9d344ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ephIpTB6BTU6Q9pb9Uz3T3rfptOSHlU/Psdc30MkJ/8v7/qA0sI/nj2EdKlTcUHpayvVfotV6UJgMPe+8s+bCw3CBc+j524Sl+EppCYn5QmD3o7Pr0y2nmCssIj60Ijb/cFM7khYylgOIvRERi8hGIEk2He9m1P1mn2zlWeYVxVqC9G1f6sJ5EcoB/kbJ9l7lLw/Dg9oSA1jQ0oP4k2s772ip2Rn/2QfEz6fZjT+dgVkewkuw6dJ9Bqd0TxqEmUDYJmy3xd0UW5b9OFG5AI0n5Qdjz0hAowEQNFIhLtfNnqucu5Dzedgl2gqiztTIGdJ5rAUzRKqtm/VLKQVXBeH9czdrcPBC6YvlCEf9B6c5UNdJHfUKZaYzlpyk/B6SD44GYnJ7BTLS1wcLdkWiJL7yfb+aRH8t5+2DxVpXDZoxN1byEeZAPXPMc8AVFjdpJzVBchiCIR5OZ1yjMpZvXEzzU0bvjL6rg8CV4/7TgbS3RVMsP7bpbMNVz+dtD90JSZm5Jvuu+vMudWjWEHg/jyxyfyOFXm78A13zy220mP46z8S633VIjANVS8Krai3ft1NYOp9A+0UwnQ8UqoOPXRAKdmjhRGeRJlSEA/qNoGUmDFk/XFHPwDFVy4ujJvFGoQ1ymU3RSXjrjsg4man4qfNfAjFnigM/fdPWoTJ3tsNRsWiZ3v29tdAr0h3oal1rcqBFv2SPDjQWK01hQhPHGxR5IDlNxcQSuptNtabxPuJfeirUI44CHvHpL4RCEGkEYcA3UJ5nuNCbtlFNwuBsDLKVRuf4vLIJiMpptuUtR2c/e1WL+LA7lh09zQNWgy7DphaIYR+610jY3UowgdRTD4qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(110136005)(316002)(70206006)(70586007)(54906003)(336012)(426003)(16526019)(26005)(40460700003)(36756003)(4326008)(8676002)(8936002)(41300700001)(81166007)(82740400003)(36860700001)(47076005)(44832011)(86362001)(2906002)(5660300002)(7416002)(83380400001)(478600001)(6666004)(7696005)(356005)(1076003)(2616005)(40480700001)(557034005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:16:20.1495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f08f4-55fa-4f48-9611-08dbe9d344ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

Cc: stable@vger.kernel.org # 6.1.y: commit d2a632a8a117 ("rtc: mc146818-lib: reduce RTC_UIP polling period")
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a warning if 100ms or more
 * Add stable and fixes tags
---
 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         |  6 +++---
 drivers/rtc/rtc-mc146818-lib.c | 35 ++++++++++++++++++++++++++--------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 36 insertions(+), 16 deletions(-)

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
index 43a28e82674e..5abb925da4fa 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,26 +8,30 @@
 #include <linux/acpi.h>
 #endif
 
+#define UIP_RECHECK_DELAY		100	/* usec */
+#define UIP_RECHECK_TIMEOUT_MS(x)	(USEC_PER_MSEC / UIP_RECHECK_DELAY * x)
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
@@ -37,7 +41,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -56,7 +60,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		 */
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 			spin_unlock_irqrestore(&rtc_lock, flags);
-			udelay(100);
+			udelay(UIP_RECHECK_DELAY);
 			continue;
 		}
 
@@ -72,6 +76,9 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
 		}
 		spin_unlock_irqrestore(&rtc_lock, flags);
 
+		if (i >= UIP_RECHECK_TIMEOUT_MS(100))
+			pr_warn("RTC took %d iterations to clear UIP\n", i);
+
 		return true;
 	}
 	return false;
@@ -84,7 +91,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, NULL);
+	return mc146818_avoid_UIP(NULL, 10, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
@@ -130,13 +137,25 @@ static void mc146818_get_time_callback(unsigned char seconds, void *param_in)
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

