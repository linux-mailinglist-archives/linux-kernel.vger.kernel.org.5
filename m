Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDC7FAA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjK0T0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjK0T0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C899D60;
        Mon, 27 Nov 2023 11:26:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuMtHx7YaKB2FYe42pltZPlas+uhrWd4h1PYa5eES5wtIhPEAnZIe7Q424t5MbjlcMnQDhugXnwZI1IO1Y77OEeSr/NBr5sofO6HlfyrOyY4m1dzQCdNDfIS7T5BMzZjQmTujcTIeNzkrDZdYxAGZ8aiJJ7+p5jOQ69PStFKWK5cROpcFB1b2396UITcPSzSM5UQ7HbDBW8xx7iWnbN/0C838M3/LbqpY4GV8I8HxLQrOEC9kr2jFRFhyb8+maGNDW9u4MTH6HD4RjnXY+raWtvRju0qTgjvQjh73NrWIqs3fAHBbi/9yt7Tr6kT45e3P5ZCnq9hYXinwCCWG4uVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koPpbArlYcE4vPhoQ+Ikg770yizTTTEAbSY0aTCnKVY=;
 b=C7QP+zpc4rfkjUxa+pgC7m4tg8zFphX1Zxkb/GY/xnb9j9+yxeMAskvq+gIEjIKTpvffk/fFtOY89AL3Byxr/AwXS/Y42MNvEJbQM/4qsG7CCzNBI47VD9knRV+JkUQZhHxwVPimDwCGZJbCpU58My2AeJrwmhcQo1XI/b73dnr+9SwTLxELNU6XKmhRTVEPcrp/SgZ/oemflMkDB3Q1XPKh98wWJ9bz7Z69mvIqHjWfabFb4D56DulMmtgUGZKkephL211rDGuSpm3P5ufZ1fdg65tVrb80Ylu0BYaOMvq7O1CCY5K97J4/dOaWM0nWwPQmQWnwaRhs2K/yUgxvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koPpbArlYcE4vPhoQ+Ikg770yizTTTEAbSY0aTCnKVY=;
 b=ZkVXa4hEjw4Q/dN5ROMjOt3CPLnrFZ/vLngCrS7sFiBFez5Dl1oUCLaYfJMxl5Wnku1dAxCjuLmgLD9xJJc+9FNN80GEtUJipzmfLkVksioZJCXcjUG14nHWp3QhXKonX0XktFY24L1sF3VBmQKXkgdKpyUp73vmCkp3OtWohC0=
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 19:26:12 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f2) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
 Transport; Mon, 27 Nov 2023 19:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:26:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 13:26:10 -0600
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
Subject: [PATCH v3 2/4] rtc: Adjust failure return code for cmos_set_alarm()
Date:   Mon, 27 Nov 2023 13:25:51 -0600
Message-ID: <20231127192553.9734-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6019ca-a280-4f75-2493-08dbef7eb708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK1ecO+vuBzGC2WNPgSXbXOk4FdzcrkoLskO8GkkrYKDBC6xF1LrRWY9s/bALVjkzOHnfBPAgvQmDUWDldDCgZZqZSd3ZuFBfEmjCvn/bUQq5AMslqDsj89LbDFYTEJf1mZ4r422RSpUeL/rlxgr1RVY6aJolyhcIjJh/DGa4U/08tueM4QlVax0qVDjU5WhM18uJHeQL9OCDjwnFLaXS/uTjdxlx4NLtIUQJX+rEX6nUkwW2X2IbmV+aL6Y2jDPFsVFZMSwNZEkcbqwESz+WnNl0zueaPR+fWnpsvltjEHC3XpVBYzcOHBfr5hr0OwYrw/bbjhO3+CCyV8nml3/Lx1M/O4bk+9zZ7P12x0leZrJ46jg+z6p85JFSgq8tOdnuMyYwQgpNBqb/9PoB0Fuwkg9UbvShdY5dEo/xELHALBOnO/syCSkobKF8wopOLLUus8gXE6tRDjOzfbXcLFWCn2Z2zugE/oRojNY1dkyMsUxmcjRxA/sngWmxd6bhdVaSSgBKN+g6sBMlYNhOS9jWyUvsg24QPjHT+DRSEs+oMt74dwoQSY3Ixo7XGmBV6yAJbp6aLvnX8ACciYdqYkcxOMNxZfeqtzchHD85XhUTPePP3ZjAZP3UBrKThWpAQ2hdtEf/ATwGnOFK5BwCQCgXiJ9KSY7KfsfkAGZKIbhr05pyrhhqz/dHKMW9iRBjJ0y7h8lHSNYHPFVBQV58/boqXaYsCh7XqRDOMupylAFv59VTBR7w3lONZpVaT6CaOBerI/wYJ9Xlz8WX6u/WzWsHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(4326008)(8936002)(8676002)(7696005)(54906003)(110136005)(316002)(40460700003)(478600001)(81166007)(356005)(47076005)(36756003)(40480700001)(41300700001)(1076003)(86362001)(26005)(44832011)(70586007)(36860700001)(336012)(2906002)(2616005)(426003)(83380400001)(66574015)(16526019)(82740400003)(5660300002)(7416002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:26:11.7801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6019ca-a280-4f75-2493-08dbef7eb708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mc146818_avoid_UIP() fails to return a valid value, this is because
UIP didn't clear in the timeout period. Adjust the return code in this
case to -ETIMEDOUT.

Tested-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Acked-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org
Fixes: cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
Fixes: cd17420ebea5 ("rtc: cmos: avoid UIP when writing alarm time")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * cover cmos_read_alarm() too
 * Add stable tags
---
 drivers/rtc/rtc-cmos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 228fb2d11c70..391f91d3d144 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -292,7 +292,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	/* Basic alarms only support hour, minute, and seconds fields.
 	 * Some also support day and month, for alarms up to a year in
@@ -557,7 +557,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
 	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
 
-- 
2.34.1

