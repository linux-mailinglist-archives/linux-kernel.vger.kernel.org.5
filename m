Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52727F157D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjKTOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjKTOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0210C;
        Mon, 20 Nov 2023 06:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCHsL1dBRYy3zmdGtvj7J25O3LSZ44ynvLGTQImdTsl6xLFd3OlXIu+6K8NfTMmDid77kKf1FVcWffZHulXqkivYo95ITNnNqAHo5wBVZTYZdH1XsuK+PGbYSgHQMNpxGdeaErI65YFNvikZNJTVbXC8zXq79/3jyIRU0xdgmo77NPDy5qRVRdf93JfE9WCmjfPfe8O7CZfy8SiHl116e5dXmjZo3sc3DfjtEcQl9SAODIg3U3wY//ulufY7y53dBl1FV1d9OvpNLpej6m4P/VXTJ402Ram6/E8/C8U+f58EfSRCCNIIBklNrL3/LNuj8ZPvKE76nOlZMIOLjK1n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CgYUedyKiO6EIimQ7+v0ot41IaJmK11YFGpcndJIq8=;
 b=ABo88JEH9BtR8Lm/4WmONMpyY+QNDH0LhvC0+v+XUcsAmClkdwMS17czn4dhRO4Qpzvop30HBUiJe93+XqWQe5YSTnTYbU70jJQ2X3K/aX0c8MMFq1lxaLAAxasmAfWfwpdxYK+k0/oR1mPFuvLgHKjHzy4zGBt2z+hAU5bt+rBAJGxhSW3JdJiDWf7LRhmtvdf1TeHVRr/Oc8hJte4F1ce8CKiqdq+XIQFBePLi9Kt6AXDpek3tFmkhpShh0vTDiuWYSDknPoFGgjtUcl7txuIwwC1Z1CVye1ChGY6qhDfrdDPplHfBYfiRgTyxR3HAqVtm9hSKTHJyTil4oihvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CgYUedyKiO6EIimQ7+v0ot41IaJmK11YFGpcndJIq8=;
 b=xr2T4ATFBEezhvbhmqd1Kr82S+LUavivU1sMmeqL+14c2BPnkqpe3KF3P4DtfZTi+li9lJ+nzuMMIsQcwEKViTllKF9aMftVkpNSjVraYZhyWTo9CaFGRig6zPj2zVf3zHp69AuHKDxT06uX+qFM8DuqOyly5r9EvYV2AY8g0vU=
Received: from CY8PR12CA0072.namprd12.prod.outlook.com (2603:10b6:930:4c::15)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:16:21 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::b0) by CY8PR12CA0072.outlook.office365.com
 (2603:10b6:930:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:16:21 +0000
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
 2023 08:16:19 -0600
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
Subject: [PATCH v2 4/4] rtc: Extend timeout for waiting for UIP to clear to 1s
Date:   Mon, 20 Nov 2023 08:15:55 -0600
Message-ID: <20231120141555.458-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9f8afb-11e5-4ced-90a8-08dbe9d34528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVWJJC5EZmpDXlhwHJnH2BSEL0pyjTy2A+ZTErcCmrljP5+a3SIFpDmyO6cR2uswdRtCJSccz1I7jW5TkWQiNnmkDFksXnx/B/VOc3rs3//gSHAhkB2K+vp0ibuWTF7Gv5gBNN7A5aQ+fKMz1g56/ojOgymDD8PiUUAz2IP8nLJw37XDXBD3ZHLw/5IIpBHcYzu8PoKTC17Trl9AVrWH6ttCI86pQUKkfj2DtX+5UeMgWT7pC0lCgtRNBxZ2PHTKqK6og/2ZpcuYbpagD9D2h5lrbYD8PwRgIHiCioL7O+c+TD4MkLfAcYNJRUmu7gwDKfTb4BHrqZrBhhi/Cw87W7jp3WEJ/luSG2NtBkmBausiK2UajAPnf6QpoDnOA+0iLW3q/5Xg4u94xB9iQTvdTNeNM8xORJazq85Aic6RQ8xPWim3D8MXa18n6c/0Bw3CWl5ZmD70AWLHiD1SSntAL5rRUFVvc2jgWFb3/+aLC3yrZUo25No9sDo3vmWD8IQR0OrRU8ZY7FvPCUEPS7xy9FMlVqKxNp56yLjQ4SP0ruK3Mr69lbT6Ov5JwW/3LbJf/LnXkzRc+27NSP+lErzI5zTBNRTkU/PHYB/OGYKCTFDOz7l9etSC4GX7o3qyQzRFqDyZJuKHAtwaDdEaDmEeooa5cirwofjgMrc039nwpmMJOsO1xB1IG18HmF76AeBwb8WZlee/td5AZ/l/yN+TUXrz2AFS3/qhO7yT+ZBuOVcaBRgFjuog0YCYlJOZ/EipJjIg47j3FUpWnllaYJA0Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(426003)(336012)(26005)(16526019)(1076003)(47076005)(36860700001)(41300700001)(4326008)(8676002)(8936002)(7416002)(2906002)(44832011)(5660300002)(478600001)(966005)(7696005)(6666004)(110136005)(70586007)(70206006)(54906003)(316002)(36756003)(81166007)(86362001)(82740400003)(356005)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:16:20.9621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9f8afb-11e5-4ced-90a8-08dbe9d34528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
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

Cc: stable@vger.kernel.org # 6.1.y: commit d2a632a8a117 ("rtc: mc146818-lib: reduce RTC_UIP polling period")
Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
Reported-by: xmb8dsv4@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217626
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
index 5abb925da4fa..9191e5f50fae 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -91,7 +91,7 @@ EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
  */
 bool mc146818_does_rtc_work(void)
 {
-	return mc146818_avoid_UIP(NULL, 10, NULL);
+	return mc146818_avoid_UIP(NULL, 1000, NULL);
 }
 EXPORT_SYMBOL_GPL(mc146818_does_rtc_work);
 
-- 
2.34.1

