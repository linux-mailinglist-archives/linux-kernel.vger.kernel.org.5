Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5637E00F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbjKCJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347350AbjKCJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:48:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034B191;
        Fri,  3 Nov 2023 02:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/wlv9P5HqSppGtT7IG/MgLXAbGXFb5ZDt+SdmCpehjhWarkUhjpGJZ51MggIw6w6F1iUPaQUg6qH1V+lEXtRICnwADo5HdDM7AOqLAjNbjCNm4cm2HT/8QADMba5PVnnoMzt2xH0B2zP5ptr0bxexuf4nkVZR7kdq+kmvqvxcgX12sREQ0GLI4/1bwCx6fd5T9B75NqGXOC+Ccuv/r9LVhIVQ+u4ugeIF8KhTdg+s7mULKiyF5zeZhW3BtY9n7RDoyfkXoORqzTXHQML2xNkBXvlO/Lk4GgCdMHHLbB7tcaeTvkLsn79XgjIKNhDpeq4jna1IChFVqkKbdFoxJqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j/kNxdSGI9o+b+OkQesaP9tuZHVn0Pk5jKeLJOwH94=;
 b=XLvAwGKtnAABUH95mL34Dalx3u5LWV+Ruk+KBtgG7MgQd/O2Cg/sdtFYAZTTnbCxBGRRhLszZXotHkkC40QZLD/cnfd+xvhAN2fImzVEHNFpW1nlzIPHXv0x7+zRGqiWXsxtVjwLDVlaI3cJPCkJtD18QtCbTcVdXjeh3fXLebwPUEaGjSye7hD/TWQ13sbaf6F1pYKnfWty1UfNCD2Sd90bN4ObWyzFFHu1crVsu3g19W0YKBKYJZ03pKu+kuN58cGJn+p6Poy54pgImqoPRC57U4+vBjO1gAAyuPdcleHZyiKpCphU3b7Q42iVdB62h8Aksrix179FnRdhr2C4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/kNxdSGI9o+b+OkQesaP9tuZHVn0Pk5jKeLJOwH94=;
 b=fqMEeMBaRhgFqV7jaEUBKYmLkt08J1p9DauawCpAehw4WOz1jZTbRGIISpHlaq8uB4/ZQ4+V/bmBfHP/gtQjlY66/Mva44iTHP2uJXo4Djs4KZTCRR++QxoZdyYiILYVPL1vyAPDv4lcyZdRQuLSTgucyP1nQBf7BVKHElKBClM=
Received: from BYAPR07CA0097.namprd07.prod.outlook.com (2603:10b6:a03:12b::38)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:48:36 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::16) by BYAPR07CA0097.outlook.office365.com
 (2603:10b6:a03:12b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 09:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 09:48:36 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 04:48:31 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <Perry.Yuan@amd.com>,
        <wyes.karny@amd.com>, <Mario.Limonciello@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ayush Jain <ayush.jain3@amd.com>
Subject: [RESEND PATCH] amd-pstate: Only print supported epp values for performance governor
Date:   Fri, 3 Nov 2023 15:18:15 +0530
Message-ID: <20231103094815.16141-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 287e987d-7ce2-487c-6a66-08dbdc520cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY1SyLeffk7f+iZgd+5IApdwL/3ivciUX+O7esgiDAVJqrzhabTmobdcNjdNACB9elMXr+VjpOxv2oUDJKzRwUzQegtVu+w6GcHDuvN940vBI7jKDNe41VOJUw3YZ3Z2c61wu08odH+eQAjGUFOD7aWMrR5KtIKfum5mYywJ9LZZTL2RfmzNhVGULm3o1gA1bbKh5+9c5pGoaCgqOIcVoxud3t1fNy/MTe3j7NUwOArUfy+ZxypWyn5GdiqpU6XbgFfaSBOSyynVRB72owGdDr56AUKdqOKKcCbCe+tU18gNCGtiv9nWAS6VkdUGfmfeXwYZu3AFbgCApejqzhbLzNWTvkywxgzVy7kcGSaw0/9QynKLXQ5BBjOPK0JJ6PNDXI6FpjhBpIMHBrEdCvMGHUXLHePIMAzGpKefb5KjjnaWfxMWk71u7TSKWJ4iLqEpS8MviK/U3oyPYrXpmcIKhe+zh7KLimeezO83Ho3DsSWU+E3af64W4S3qWbyjHHpLuMzYNQa7O4UsQKguX26aG1HfNgyxl5CAwL8HCBktEKbdAieAKraRqSBviybDIj+I1uyWuHdGihDanDwzh5GSo4hEzwoLXrIQuyvy6O6p/UGh/5STEm0y2Nmmv/R24UtlKJ4XT5V5aJ22Tf1syngCeX23KV5TgXVd5FQ9c8R4/KjIaV1bcB2ZliMPmZmmvKh90Atfz0b5q5GFz1X0S8F25JlQz3ap3x4mbAoaX/dNszzK5bAhxqinXkb7gZfQoPyYqizkagh+Kms+4FFvPof1+UQGqkhpqffDakjkDURoa98=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(478600001)(2906002)(426003)(336012)(16526019)(1076003)(26005)(83380400001)(36756003)(47076005)(2616005)(40480700001)(36860700001)(7696005)(6666004)(54906003)(82740400003)(70586007)(6636002)(41300700001)(70206006)(316002)(356005)(81166007)(110136005)(8676002)(8936002)(4326008)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 09:48:36.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e987d-7ce2-487c-6a66-08dbdc520cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..e6c5a57662e4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -850,11 +850,16 @@ static ssize_t show_energy_performance_available_preferences(
 {
 	int i = 0;
 	int offset = 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		return sysfs_emit_at(buf, offset, "%s\n",
+				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
 	while (energy_perf_strings[i] != NULL)
 		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
 
-	sysfs_emit_at(buf, offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 
 	return offset;
 }
-- 
2.34.1

