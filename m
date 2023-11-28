Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167C7FC1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbjK1Oqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346339AbjK1Oql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:46:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB60D4B;
        Tue, 28 Nov 2023 06:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWOEYmXdXHsX9uqxTGDzXdsfUFPsk0joFOfiNEcUNcc86HRXG0ksTSyeT9wuwlRJuy3CuFtqgMCwIjpkBCq6PussD+18Qq8RKjT0b2tg9T7qgySht4V+aH9pdH7Xpvm6PcSB98Rw4KrutqgMHORH6PVdwqNaZP/Aase8OhaFIRkWrnhTJS4ySfJ4K4uIdRGfEE49pxaunyvJF+/sjhCRX6kQi+RqYTXJK2oj7E3pyVQ4jJX4TSNRlAUW/1LtCgAmUWpYsWa5s7ENCv16tR4oWlHkGde8ctHuAV1SqSuX9CxPD0/AqC0gN7/BpUIoV76JKRtDiCnyUX/20fQZxRfKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i91a/0SuuQ7ti/AN7riznmuffq98P/Q1GWqlQeZuB6g=;
 b=Dm2hgTj4mlHQz6szzP8fB60Ru93Qmwo1qoXkUpdIduv3BFJ8slMuf2pEnQW/m6bttH6STZxRk7u+RfTuBKYS0br8uE2P0Kpvy+DwNWp5ahIy6zPLV+1DNyyWPazavey4nuWLMbrjAxx6SOPRgXzOyjbLUj+BWjGzAFRQ0PVS53lRlyWYpgj3p1+AwOusocN8e/Tn866orj949D3Dx4cVT8iLCwr8MJSRZU9/WYXdwhH7Sc8wpo8or0wGfn75StGQK8eb9xcYYvCIjbFZN6xAgpe5ncgsorXFkm+BIdZJR7wrWjZHC6uoJh0iqbOjYeryALkVsT4+uwAvGjnbvII6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i91a/0SuuQ7ti/AN7riznmuffq98P/Q1GWqlQeZuB6g=;
 b=CCvRNu7heBzzKe8NSHHdEWQ/RTrbeDnPpH3I6cTkNyrSFKy3f3qbcWq9YVNC/Q+H+QgAIv48rPoD0qtpRiv+dxG2fhfGPPA+bcRHSMcgPcgmjFClCHeuFQM8+32iHm1xYDbUrOyxH1AHFWSPJWL6nRf8SjzdrN+Hlx1keGJKsrg=
Received: from BY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:180::25)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 14:46:45 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::7d) by BY5PR13CA0012.outlook.office365.com
 (2603:10b6:a03:180::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.17 via Frontend
 Transport; Tue, 28 Nov 2023 14:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 14:46:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 08:46:40 -0600
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
Subject: [PATCH v4 4/4] rtc: Extend timeout for waiting for UIP to clear to 1s
Date:   Mon, 27 Nov 2023 23:36:53 -0600
Message-ID: <20231128053653.101798-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128053653.101798-1-mario.limonciello@amd.com>
References: <20231128053653.101798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da0332f-9b1a-4bb8-b6f5-08dbf020d794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6koyZr28VcSNE0558icCWPqkHwWzxqQxiurFH51XmvOiqwS73D/mc4dPYVVb5HzpS8G6XXFJxGpjK7SSaDmjagbuQRJe0s1hykaSsoa4wsX+PD/JKF5pDPwZSB9Jbr/Zm1Ag2jT8Qv+XejF5re9E2J8qNF7KUgl6calwT8b0/WT1vmwpJY+N5MDpeOi7+uk2Xy/JGdExLxJC/O4OvqhynGhJHaZ3QuRpe3HUKNF3lrWYMEL3wjwG/zq2zUBFzEgbMQKrfSfx2hk1opXO3m+rPT+ufZwBHt+/Ywqd9lpl9oAIPbxJXAmA8xLOUuRBYzjEQ6TFS/Qccq3wpiTLisBGsZr4d9eJ5SH8N/ysG6A3Oc1h1GL3Yy21TJQTfVkAMlO32FuSDlSc76WWFi9Vyca1v49tgaryI1Pr5fmGKExPynPEio19h08rMXSV57rKyzzKq6IZnoWcj4elklVZh+7NxBmniExGKr64BaJO9uXRtStD7qoeofbT+5gj+e7dsAQHOezdkIlnMRKbw2JuFe+6E6qQE13YegdmGN6yBGhAY0tSiEz46h7adCi6KoUalOqyePA7+ROL9+UoMrL/A3Nyhnh+epPGlhk9xQBJ7464D4WmTKpDum4IeWwYVPfM9iMl7MobWpc1xwM+9hZDr6jAjFfo73qM27tV6tS5JxKT2lJVcbfcFdbbzLeFplswTWD2wmcd3HeAZDRtM8ODnpi4EfAMcDck+NkPSRTkOmEjSC9LS2PlMbEAtT3F/PD/s5LyRX37BAg8lqLclw5ViISDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(40470700004)(46966006)(7696005)(1076003)(2616005)(478600001)(6666004)(966005)(47076005)(336012)(426003)(4326008)(16526019)(7416002)(5660300002)(44832011)(2906002)(54906003)(70586007)(70206006)(8936002)(316002)(110136005)(8676002)(83380400001)(41300700001)(40460700003)(36756003)(81166007)(36860700001)(356005)(86362001)(82740400003)(40480700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:46:44.7961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da0332f-9b1a-4bb8-b6f5-08dbf020d794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 4c17b3cef11e..651bf3c279c7 100644
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

