Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052CC797F65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjIGXwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIGXvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AD1BE4;
        Thu,  7 Sep 2023 16:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+VqU2kGYyG2cMd0asejF7SgB9jEURNr+N5FyW3ATR7nkVfHhNxZ2XnN+dhsdUGl/INDdG2ckeiik82DDxZtaYIqpytbGEND3DRyRXX3XZrGhG23JPAbTJl2EXNjeIgRJ5KWQm832/93CNXTzVtAz9muJtpsvDTtKen87TKUyHlhA2e0sYeCM7u+Zb/IJwlNejck1dMGkq8dHrLuOXCib0zDyLn2aARneDbhPhQ+JEJHNXLCSt0kRjf8HlG4HMLRkLnqK5cW40tGGlJGN0TdHyuXxLK4Rt+sqkjO4PfrB/x9v3QedmkiagrXeKRKceTBWsRMxrBoxf4U7qfSQDvhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwEmU9kB96HLuZBNztZ9mxlk90B29OQjWlPHtCKu45o=;
 b=Ni7xBC/G7A8iKXS7sq3aDsK80GJHVvATgoieYTGCnAiEXzDiXGrEE1+SR6fjDjPxuwkJMXFqTn1+seuwsxZgGJ9hKi6c03KPcOTV1wslkfDDCX+nvPRZU/1SFspEKkp8Bn4dqQTNVgG5sLY03VcmqccKHosqg4VxOHYF1DLbSDaqydEpjakYCSbKmzTc5lmv6d1RlqDrHpM5BqVuc5VzC0uV3Z+9mk1s9abRIDhaKIs0Yr1d116foigwjSXjMhHgzUxsyRC15MXj2XO3qKvNXmmdbkkN5VnqsyZLD8ETtvnxniFnUhPPlZirYRqcAmCgWT5eVniB8e2h69pdG2xKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwEmU9kB96HLuZBNztZ9mxlk90B29OQjWlPHtCKu45o=;
 b=Hnucwa2WsPGlBvpYD32S75HWdJDrDbwT9Z8pgVbAL/e8X8/L28DajrvxVp8JyZ+GLK97rTwpJ4FcTE+OoVkfe1rhc7jXRhLCGqzLpXlSS6F7lVD5w3tGSZYEl0xy/Ch3/AMnXxn/DnGUGcYXQeclkFFPT8b5TaehXN/eBdFek0U=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 23:51:45 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::9e) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:42 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v9 5/9] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
Date:   Thu, 7 Sep 2023 18:51:24 -0500
Message-ID: <20230907235128.19120-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907235128.19120-1-babu.moger@amd.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2044d3-e695-4bd1-d257-08dbaffd64bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCvRFJuwDqI0q4cu7nFaVnq1XHhjVB6JmkS1bMvUGSdZ+Kw/0JiCUaKszbKuceay+7ynvqfFXzMqH3t/zglCmkPtgGdo4uRYIHHB6fgyXCOhh5talw5ZMHlmgyGCVUHjlVD5Zmd0zqDSn9djduiJ0TiB63voCX4lne+PX+5ijyxY66TV8hlg/N0pCWlN5lCAIMDCkWr4bSSdQ3cVE3d2S0yilSbJJ35xjc7NQU6LrXE4JqspjM0nQT3qh9h12WmRsMvTXU3PkUYw4J+xzTGysXHO3SgeLrr67mgd2oIGLgmyNJmcBt8ZQhDlB+TS/iPc2koZZdI+DuKEkmnr3f6OszwydxN+UWqgwrLYoK2yPt86sjz316PbYPdDDCOjEfojILgWHAMjCapm2yYbYoEvpZibOnQQusdJiWFYK2TlaPTIqwLQ9FvmYEJ635fC6zF5+vRBYg6+cPtNwTzjtCcOONykyG+zCMA+SnnWfdBKvY0k++0ORXBWGvyYDps6oluRsi6OitxXVWKeOD4q6LqLB3UacVL4bhe+0iY6AmbJ0Di6TdRGmru6nX7FyDNuBiBMU3R2++A2sGvrZfhiFM0/6D3joJPXymXErr2b0wMp0faeONuvkosR2eFm2kdI02uadvDlsqOGzsceCDU3IDr3p6cmz46P/DUx5anMFjA9isLWJ3sLVtyrKR1ajy2JUIgsjBJlcScI9euzH5CZsDJfDuwXHY2Pkxtz0epDEdrNyWLcrEdIKlTdJtsuQswOO/nxjHbl4zvRmpeleJdDtGLw1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(8676002)(81166007)(336012)(26005)(426003)(36756003)(16526019)(478600001)(356005)(70586007)(70206006)(110136005)(54906003)(316002)(41300700001)(36860700001)(2616005)(1076003)(7696005)(83380400001)(82740400003)(6666004)(47076005)(4326008)(5660300002)(44832011)(2906002)(40460700003)(40480700001)(86362001)(8936002)(7406005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:45.3646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2044d3-e695-4bd1-d257-08dbaffd64bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_enable_ctx() enables the features provided during resctrl mount.

Additions to rdt_enable_ctx() are required to also modify error paths
of rdt_enable_ctx() callers to ensure correct unwinding if errors
are encountered after calling rdt_enable_ctx(). This is error prone.

Introduce rdt_disable_ctx() to refactor the error unwinding of
rdt_enable_ctx() to simplify future additions. This also simplifies
cleanup in rdt_kill_sb().

Remove cdp_disable_all() as it is not used anymore after the refactor.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++----------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 35945b4bf196..34cb512be1de 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2290,14 +2290,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
-static void cdp_disable_all(void)
-{
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-}
-
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -2377,19 +2369,44 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static void rdt_disable_ctx(void)
+{
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+
+	set_mba_sc(false);
+}
+
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 {
 	int ret = 0;
 
-	if (ctx->enable_cdpl2)
+	if (ctx->enable_cdpl2) {
 		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
+		if (ret)
+			goto out_done;
+	}
 
-	if (!ret && ctx->enable_cdpl3)
+	if (ctx->enable_cdpl3) {
 		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
+		if (ret)
+			goto out_cdpl2;
+	}
 
-	if (!ret && ctx->enable_mba_mbps)
+	if (ctx->enable_mba_mbps) {
 		ret = set_mba_sc(true);
+		if (ret)
+			goto out_cdpl3;
+	}
 
+	return 0;
+
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
 	return ret;
 }
 
@@ -2497,13 +2514,13 @@ static int rdt_get_tree(struct fs_context *fc)
 	}
 
 	ret = rdt_enable_ctx(ctx);
-	if (ret < 0)
-		goto out_cdp;
+	if (ret)
+		goto out;
 
 	ret = schemata_list_create();
 	if (ret) {
 		schemata_list_destroy();
-		goto out_mba;
+		goto out_ctx;
 	}
 
 	closid_init();
@@ -2562,11 +2579,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	kernfs_remove(kn_info);
 out_schemata_free:
 	schemata_list_destroy();
-out_mba:
-	if (ctx->enable_mba_mbps)
-		set_mba_sc(false);
-out_cdp:
-	cdp_disable_all();
+out_ctx:
+	rdt_disable_ctx();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2798,12 +2812,11 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
-	set_mba_sc(false);
+	rdt_disable_ctx();
 
 	/*Put everything back to default values. */
 	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
-	cdp_disable_all();
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-- 
2.34.1

