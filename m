Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991017EF938
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjKQVJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346202AbjKQVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:09:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B277310EC;
        Fri, 17 Nov 2023 13:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlfLKy/n7b+nfp/hMbJzwtbeANqXUYVn6nMDxN8o1tRQV42Yj53CBfOMIdt1/t++t0yJxhhUQTo93O4VjK5eBoMcz7QeJDWaXLXrP8AyAu5kwUJvsooFKTrD26bqsJBXwXfw55SCrpD03BSydLP2WVT+ojVZ8WUGPSyP9dyNQLbhmBXD92q0w8qLXa/JsHE0MipNSGCUMRviEO43H+RGjjLs5UatwiEWvM7VJq68Wb0w2F8NzGQQiPyoNhGNdsZf4lzSIduZzWIUhu/iiebu1TOSFP7/Dik8ULwyegW/NYNXeNMXHgdBeUFAgBaDxxlY6HKjZpTYSyFXUwSLfOQD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fQjz7zeh9vmmyAWNqSCY1iMHAwLZ/KlnAy5z4AG6nQ=;
 b=UdrxRBKrnWaIwqtHK/Gqh/rcU1T0k6Q6NrdViI6YXmhp9VW0Jk+ouI3J2KOvcg1v3p2wI8k75qlDBSiD+DT85lYrGc5jm9XvdHuVJk7VfN9gw7pC2rx6563Qc9Vtl6njz64G52i2Xzo+8/X9D7Uu7U1pZ4RB8HvsRqNYt0SJH0JC4oV27sUG9FIakJdirZ7d6NEAEX0w46ypnmZ3xiBje8Fpz3el6MCM/+cQMHSPk6YvUoewDelxniEhTUtQpPiF+zK9q0h4oGtEOZcKof7Neu/frutmStpA2V8pxORBnYdmiGEmSzrpXOuSagx+2GH3/ZCNUorgKrTTGvhhn6rsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fQjz7zeh9vmmyAWNqSCY1iMHAwLZ/KlnAy5z4AG6nQ=;
 b=f+/7kf8PHHk2C+45WSba94hKT7SOiZRzRcHZMSO6NkD+Hznb/s/nRGNI+9fmucwUjTc034SWFhA17D88NNQJFqUyrMoEBsRU9mgro9nyieHgAoL8RXogKf6JVhdevIEA1tL8NjOzHlJutKK5kir7jj514Bz9bsWQBwaE8uq2lf4=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 21:09:37 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::f7) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
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
 2023 15:09:35 -0600
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
Subject: [PATCH 4/4] rtc: Extend timeout for waiting for UIP to clear to 1s
Date:   Fri, 17 Nov 2023 00:32:20 -0600
Message-ID: <20231117063220.65093-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e62e546-5487-41bf-1f91-08dbe7b18165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G4D4h1YiDd667T6FCthrIXsUo83CkvP8/i+Kv+YnTmMyKoZiN2DnHoHceh9L2POv6vVKf6EUFefuvJoG26DZ97jLcah66D2r4Oof1T1V3EdjIx4bjQSew8Mk0BhZA6u9BZ/ojOrZD4E6Ed0iMLryjkG1bjzfA1dPVNA1Z3HFIB42ZDxp6oywl6eR1efas03MkSsUu+zRiEoCn35pWHB/5zM0Hqr7ctuolM7MScPL+OpLNvsodAk0g2IsOIdjdPLTnE40R2Wy1j42ECTiWm4E0LC7Y0PxXvm6BRcCybgAp46FGAXP2qFK71zKLN0e32x+8NYf3p5zRjnLoAjMwYlzztH03W9323J39wSAVoGpi6Uj8G4J553N+3BZnYx1wynM/zZ3vO12rqr1DucKB8fBe88cUfUrpBoPVKZmskKrVYS6FCok5kTOPyD56IABlR0nGR4RbXRwbGb+7uL4i3XNrBgdDW7lcQK4mO6WU/7fBwX6GQ8CFMIUGCqDc1YRxKs2tLeCPtonKlYJ/Au6ZFfWc0+1lXPkWaukxmafCTE1LA6pXGDp3G+XgUvlwAJMwNG2iz5Wj6W7BNGSdSXaHP+SH+AQS6XiJgeP+U4yVpTnWoV2FdWbtuSHA2GvQAOxY46WyXeK2hlvfWSdRJ0I04vFGhQpvkYWMhb4Ii9zRqaZiySRcCBOFaD7IVH4ZGQG01su/evH61DWB5E0PA+UhFQSEXaLF2DArX8srVlo0Vgexq7d3o2v14+R3rM6qAh3cbLgVkv+8C/Hex2qMN16vvJ7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(2616005)(36860700001)(44832011)(83380400001)(4326008)(16526019)(8936002)(1076003)(8676002)(336012)(426003)(6666004)(47076005)(26005)(2906002)(478600001)(356005)(40480700001)(81166007)(7416002)(5660300002)(7696005)(82740400003)(54906003)(966005)(316002)(70206006)(36756003)(110136005)(86362001)(40460700003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 21:09:36.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e62e546-5487-41bf-1f91-08dbe7b18165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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

Specs don't say anything about UIP being cleared within 10ms. They
only say that UIP won't occur for another 244uS. If a long NMI occurs
while UIP is still updating it might not be possible to get valid
data in 10ms.

This has been observed in the wild that around s2idle some calls can
take up to 480ms before UIP is clear.

Adjust callers from outside an interrupt context to wait for up to a
1s instead of 10ms.

Reported-by: xmb8dsv4@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217626
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index 16dcbd196ce2..345897dadb91 100644
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
index 75b2fc1791e6..c6f5db6521dd 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, 10, NULL);
+	return mc146818_avoid_UIP(NULL, 1000, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
-- 
2.34.1

