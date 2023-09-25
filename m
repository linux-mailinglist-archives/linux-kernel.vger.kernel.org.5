Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7157AD0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjIYG7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjIYG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:59:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8ABF;
        Sun, 24 Sep 2023 23:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIXeILk6NcWw4m8XwF9Pzck/gHaPGuux29I6cHTrhJosN6qtInmVSCUZeDDCAho9w1/dWMkRKJdLzvmIYU/MWYfu+So5bIokSCd0mzRQWRDwX3LPkSkvzPgAg+9ZvNiQTRpuIlx5pwDtaHWwmHpR9HjIDzoywNyyneTmPVktB0Rvl1SSbZwpoyiQfKEZDHjwnj+7Cl9WLcCBUe7SD2uzA59uD9CVZKI8G+njM1y56C7dH970ooRsmu+J/PtsHUlyoJSBEoml+eiWIsjC1XxzbIfnRzIQM5LNe3Kjplrp4RX5R/KF4EZZWkY08e9loeP6a8IiK2nPVa+z6NqjCy6wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVJc7s+rNFVrNPhF90Yp4VSHKlhfUcR4qAlX2ZgHe+E=;
 b=RZoXgByd28v8Oe3BqqqxoDew7h2yYqQfGxoy3ipz6uViTjf9JcOuzqTeHPMYcQON2jPIui+Ny63jTr2qWqrL1gfjt7Omg8kqlxtlrVQ6dFgeSZ/acd62OUjY2WfYcXXBNlKCFlMwJdzCnLCV7QEYvNBO4xgAK/f/IN61j9aI5amYa1Tbhi8RmQwwfiC/1axvVIhw+NrMBxwBA2IyKitye5EZPCnKWFYLaSf3hSAcVAU+RRWEdm8X61OaPAx5UfdAsLlqG5V0LNc6sjIFRsVe80Kb04zA1wYAtqD8IXrtw0tZE1ueNKxXZ89kWFq32titQO8nk0chUmKQJo8DKFjyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVJc7s+rNFVrNPhF90Yp4VSHKlhfUcR4qAlX2ZgHe+E=;
 b=FxBoWQjTzU/90O7NcjCky6kDBcX4VinRTBGd/4/jACsNXPgbUzLINQ2N/la6k23o88yR9LpNg3bXuZMF0cCjl9rgwvIISpC63rAyeAFp5QyLmmrsB34pEFdmOgZHXExlPRM61AEEdUL8ri43iomIeMRmHo49AI5/sQv8Ute1l9A=
Received: from MN2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:208:134::42)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:58:51 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::3b) by MN2PR16CA0029.outlook.office365.com
 (2603:10b6:208:134::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 25 Sep 2023 06:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 06:58:51 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 01:58:47 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <santosh.shukla@amd.com>, Ayush Jain <ayush.jain3@amd.com>
Subject: [PATCH] amd-pstate: Only print supported epp values for performance governor
Date:   Mon, 25 Sep 2023 12:28:18 +0530
Message-ID: <20230925065818.1502-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a0bd2c-2ed6-43d9-83b3-08dbbd94e006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9cc4V5BX+UKNFXaAghxtBQIGfp1GBleUngUirn3/u//JU/6/ikZUlkntGA/Pammg2c12VLBD6cAxkI5oP4Q97tq6vMBxsH9Ez66w3IgGl4iBtCILHij9PtxC3qhLfpA0MH6ugnWgZSuCEyoD8YgKdUdIcbfRDKByjlzlxxOP93Lk2NkCN6NeITvivjrV6BCjsmqXzxjF6YOdv9RQcCkrcyaD3FP1jAL+DrvbpwUAMJOR3FiAfofkIBzroCqdCNDdyGvOB4jLrvyc46EKN9RbpYJdydr2RBf8Yc2mESAXgKLxxlLjfHanLXNAe59qxm/mV5KMSyAX20Su0v1snbPWhqXjzWirEJOUwJiXmAqY+/+sA85TVDybJrZZIyzPxINig0b0K5G9pr47g4Yz/ocv2T6hdBQJr3nLOB9f3VgB1GlGWuB0umzAiE49UCFirQy9YTMihwA91cT4ynI/tTiLt6u3IJPv/VbJYkElOadPR1Z7VXqxQHXBa06fYrM4MWUhXHg22THXULiqglmDnlZbgkQ6F6XXG1jcZ0znB58Pdlx5gCQP3fP+t+m2tRC94sk5kubKpex+LroZjFFGdROMbyOoMXUkyOagITsRtitS/Rz2vxc2usHUiB5qpN/YI8eHBRTQwTiLjwI4vRG3qMKSh2KRAex15QIdsdMl0c94yiYRPaRnqIN8jHUeKFHGWn87qqFZfwOJkA9n4CZulYGP2UnpiJQluBwNOdqHdyBnb5q2Bho/WEcQEO5Ln7SZSSEc+19dDyDnCk6H9cA9q8dAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(47076005)(36860700001)(83380400001)(82740400003)(356005)(81166007)(70206006)(70586007)(54906003)(110136005)(6666004)(5660300002)(26005)(16526019)(336012)(1076003)(316002)(6636002)(426003)(41300700001)(7696005)(478600001)(8936002)(8676002)(4326008)(2616005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:58:51.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0bd2c-2ed6-43d9-83b3-08dbbd94e006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_energy_performance_available_preferences() to show only supported
values which is performance in performance governor policy.

-------Before--------
$ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
amd-pstate-epp
$ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
performance
$ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

-------After--------
$ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
amd-pstate-epp
$ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
performance
$ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
performance

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Suggested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

---
Changes v1->v2
* Fixed spacebar and spelling issues
* Using EPP_INDEX_PERFORMANCE instead of hardcoding index 1
* collected reviewed-by
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..469461937fb6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -850,11 +850,15 @@ static ssize_t show_energy_performance_available_preferences(
 {
 	int i = 0;
 	int offset = 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		return sysfs_emit_at(buf, offset, "%s\n", energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
 	while (energy_perf_strings[i] != NULL)
 		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
 
-	sysfs_emit_at(buf, offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 
 	return offset;
 }
-- 
2.34.1

