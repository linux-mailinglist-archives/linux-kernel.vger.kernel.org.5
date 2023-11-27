Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24657FAA42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjK0T0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjK0T0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392A10D7;
        Mon, 27 Nov 2023 11:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgnzr/WD28guiC5CSf6pfW1uOKLn8pU0sK6E6eOAlusy8y79O33iuBuZ0wgD8bxdVDzoMsahweEZwPJpOhhdx3RfkfNj9UZlzeOQxiGG6JEN16jemqRlwmqHKVJL3JWZ3nEalTMAdlFAle/SvBDnTuKXaOL23KXE8nT0MRuaSM65J32CxouG4VgRQuirJmnbajM8d+ra9x/nNw7ng1PX7v2kdmOzjeITSOo9O1tp/XxxakFzSmuEhFW/YgmvnPYpIPjHrdj5AliF8gEs8vgezmyg8uVdu/BtW1+Pgfsmprh7axUyU9UTbhXtMJTn1IEWRXbXV8gaOiDEn7xzITwphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umLioW63EAOyf1vpISoUT/wL0Lfpe3FtD1EImu1KLys=;
 b=An4W6rJUfvgFwIRVefaJKxN5FRkKZ7HeQ0Szm5btIfUbf8FlpFbHWboPJB3eYZA+zI3psGuYCist+uyNHSAf2nIkmZuf7KgxkE+WTRlbX/wrITO5OeJcOfsD6ARGi9ub8x2EIjhXif4gg9TQI2D86b1uJtz74RxDc9Eowiq2jXGmXZG1EqHqLmuBLJFWUxZ2mfPBTUJW5WHzBMPOc/LPIp9twW8HXFcq4/x7Uc+SSEQT5l4Yzt4z6KnMCxOUwtk+Wn9Rr47mwtn1VMIL+o3YxXpEZI+lyJTARpV3xcXGmnaD+Y7vfa1ZIWU9b9KUP/qozeRID8LS9vAXSVtTepQO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umLioW63EAOyf1vpISoUT/wL0Lfpe3FtD1EImu1KLys=;
 b=qXV29ecQ1cv3rulNTvc/40mf4Inyo5JOaoe5G1aWsnIq1jHFCrKTDQZjkb5SwF5nQRCQzsAM0oKXYrvUJ4w5QDizd7IEgm6VEtxGWhWYcv20btbuU0J5ca+DjPgFHkjIAtdpSN0P5pCmRO3VYOJN+32Mfy0MuXztiZup4WBaJEY=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Mon, 27 Nov 2023 19:26:14 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::e9) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 19:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:26:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 13:26:12 -0600
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
Subject: [PATCH v3 4/4] rtc: Extend timeout for waiting for UIP to clear to 1s
Date:   Mon, 27 Nov 2023 13:25:53 -0600
Message-ID: <20231127192553.9734-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127192553.9734-1-mario.limonciello@amd.com>
References: <20231127192553.9734-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: c746ae24-a050-42c2-23c0-08dbef7eb8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03QZLve4gPcKn+D+6Wif9kA4R7I0iGDHiuYgBjAkFDlnBvwG8s3bVcW4a4kDoRV/q7dcXoMN5Cf1VjhLZ3/dc/zzWnmPvfFztyVnh8JnTqjzaHG2cd1WMJ3xp794xC/hstfQD+4jld+5uXFtcXsuguF9bEUxLfjFvzEFAwOB6yjsXBz8Ef5WpHD1kdgNbSyaaDNILnZRKuUeeYPLm2mRneqtxjT0esq8QD4SbDY0xfSM1/GjauD9qDg7VU/h0oRoOG2OK5MB1NUqYms/WuOVmrUPfrlXoGd3ZAEM/CnKEXxndWdirvdxx0KXk9/2GgVQrOw4aq6zhUJ0PAMyNzDL35Uq5mRF0uRZBNok9lji97oKjq9Q11zeqPeO8az9SFrSzylLf/yUc0KjuLvne9NGtQzgHBFPZ/NOnV2EmNbgwF/fHJg0yDR3NhJ8mt86Q36w8T4cRia7cUMmyfNzYA2mzdKuloNbLENGYRq41OJ1adSl9p5iy5Z0GstVC9z4uKTVM2U0wOy5TIF2LEsyknTaXZnAn/k5oUJ9tEF49wyCtk8kIVuOzlIiCyDA4kZwECrXiWWQxuIsOJCLYvsjp5hrbhkKNC4HL3nGf45v3GsIvocOMd0aaX5UeW+S1cYw8FfB2sFmzKGTNtuo+T8pSxk9/nH1c81SnWPL28U2/QcLzAzkM5wEyO1hpERywQj7n6xkuwNDHnpWtQct9jH2V5JQEr4jtge4swZe8DsxNzt099f56TEtgi/1QKSXJuXdhfcpXPkj/xV3X411/LDpnXVRbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(36756003)(1076003)(86362001)(81166007)(47076005)(356005)(83380400001)(5660300002)(82740400003)(7416002)(336012)(426003)(16526019)(26005)(44832011)(2906002)(2616005)(40480700001)(36860700001)(7696005)(6666004)(8676002)(4326008)(8936002)(40460700003)(966005)(478600001)(110136005)(70206006)(70586007)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:26:14.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c746ae24-a050-42c2-23c0-08dbef7eb8ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specs don't say anything about UIP being cleared within 10ms. They
only say that UIP won't occur for another 244uS. If a long NMI occurs
while UIP is still updating it might not be possible to get valid
data in 10ms.

This has been observed in the wild that around s2idle some calls can
take up to 480ms before UIP is clear.

Adjust callers from outside an interrupt context to wait for up to a
1s instead of 10ms.

Cc: stable@vger.kernel.org # 6.1.y
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
Reported-by: Carsten Hatger <xmb8dsv4@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217626
Tested-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Acked-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
 * Add Carsten's name
v1->v2:
 * Add tags
---
 arch/x86/kernel/rtc.c          | 2 +-
 drivers/base/power/trace.c     | 2 +-
 drivers/rtc/rtc-cmos.c         | 2 +-
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 961ebc7f1872..2e7066980f3e 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -67,7 +67,7 @@ void mach_get_cmos_time(struct timespec64 *now)
 		return;
 	}
 
-	if (mc146818_get_time(&tm, 10)) {
+	if (mc146818_get_time(&tm, 1000)) {
 		pr_err("Unable to read current time from RTC\n");
 		now->tv_sec = now->tv_nsec = 0;
 		return;
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index c2e925357474..cd6e559648b2 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -120,7 +120,7 @@ static unsigned int read_magic_time(void)
 	struct rtc_time time;
 	unsigned int val;
 
-	if (mc146818_get_time(&time, 10) < 0) {
+	if (mc146818_get_time(&time, 1000) < 0) {
 		pr_err("Unable to read current time from RTC\n");
 		return 0;
 	}
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index d278b085821e..6bc1e0279cd9 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -231,7 +231,7 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 	if (!pm_trace_rtc_valid())
 		return -EIO;
 
-	ret = mc146818_get_time(t, 10);
+	ret = mc146818_get_time(t, 1000);
 	if (ret < 0) {
 		dev_err_ratelimited(dev, "unable to read current time\n");
 		return ret;
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index ab077dde397b..fa7a09b2123e 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -93,7 +93,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, 10, NULL);
+	return mc146818_avoid_UIP(NULL, 1000, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
-- 
2.34.1

