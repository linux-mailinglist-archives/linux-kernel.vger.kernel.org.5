Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8D783656
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjHUXbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjHUXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5ACF9;
        Mon, 21 Aug 2023 16:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlP13MdzFnmCQmyAaeO0atOFoubo0wNXV2ZefrkrPaYUZdis/RdHt7xjaDyKcKJqWQUCDRWP8UbtyGdZgaCcP3A7tvHXmHMXePeBE8rZwfMLouF7UnwsQK5LE/15N12CZNMnXgBSAc+4l6rne7ZYAjSC0MkVR0Bfj3zYMH6kPjRkiWgcTD4/MwPqhrt9R9IdCUrCuPXeZtbqlNCbIQGqBS+6IuM2N7dOQpDdGO9/qtW8/TH2g5Dig0wTciAqQD9QvitjTah4Wvo4JvCahWoiqFonENtRCrJLaXCqDuTauhbvPFdDTglrL8AevuvatXthlbn33oK/dK4oInMoz9y+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaGbPpaCHGt5x+fG5G4ghhXOmA7ox6AkCPo0SQhwWBU=;
 b=IKriF4Rk5txRVNLe7mA+S7rgoTbjyOs9UuXixlrX0BNBrfK62m6pIbvy8M0sX96J0qXrgF5upW/S+mNUZF3U0dTnG2gpWmuzyI1BwcJAAe5PoytAQgXY+vbN5ggxdz6JPXzDNt/Q3mD5CH8G49lwSlAOLYdb482OqnBH1l2Q7TBEgsmel8FRQp5Kqlw9BGif3HlZpVh+M1mHb6W8sQhvzbEwA7VUCDZQht/VbKzNyumOnPcIYlM9y0BLtmUFASmMWHCu49WaucfDyuZeHYCtZAIksXJ7f8PzUMK23uBz1tcSWmXSFIgpuewtnzEjdnvakerlENSUzPf+o0vwb3jwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaGbPpaCHGt5x+fG5G4ghhXOmA7ox6AkCPo0SQhwWBU=;
 b=q1mTQN2L3mRa5uoUcXAutDb3VfevOON0W80XtgSMEbTh0GT16z+D6Cn6tcxnodNMeKl91PAG8P1e68c5+6xV+Di4xzLsi7hV9QduufbPsUg7VqYDcm+XLY/59UgkmtY60Wi1P0QIU7y5VKahYLgpIpSEkNF1Jk6+89l8rLR5CJo=
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:31:13 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::99) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:09 -0500
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
Subject: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
Date:   Mon, 21 Aug 2023 18:30:45 -0500
Message-ID: <20230821233048.434531-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821233048.434531-1-babu.moger@amd.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f840f0a-9d9a-4bb9-02fb-08dba29eb4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XK0K/9cP1iGRQAcCB0FcQHDt5mjeqY4vjwQnA+dmL4IRfvcHHwSoZvI4Z98nVTQpmDKY0y5gpgn7Zft1G89I3j+avDxNnHCJ8CxAutxjeM9eHffwmm6xNZQyGNtf6Ihe36ZWg3gi2xzMBnwwfYrCG5sZTQWxTbWsBCT5TbterWqZzDNjzVD6h04beGpjaVzUMw01otMtOLtQ/hpTGODMueXqTpA0Hjlw3POZCHa5WCaZw5D0sgZNtlUnZvFsN1VIHxsleC3/QPZHvhEbxLmfKAAcsRdiBEu0eNxHPorJX+E37gMFTqP+4Yi/UE5/cITwInIFKMTeC7ZPYDDVuLSX3A+UCwbPI4/R06X1w9iKBJvELpxZY3YDoTF1fRyESuYG0N/C6LOlHdcLx2vIw5fFcJXjWXvjF7SUgfXKub1/LDQsSkwq8LDJyEdukqknOzzD5ZJD2jXxHL6Yy9oVNbKXpCPaZwrQap4V4ucMhKRnKlA+Q5ANjYsb9/PgsWcaOU3VlxEQ1vquA1j3YZR8lhE0sMArIVRZuTHUUMJkmOdSYRxZmUMixXBh5Z3Hpe5K71xnEZiNkKPmETskSI9lza6+I/msOdIgcEILkLDAoKH59YlTNzi5/We/IgXUzgcIJoPJaPRYm2nOnegnpKuI8UuRmYiBPZfwgcokjjiddppEGXSOBhb8c7Qvu0ar5fea5dZs00iWdbhfp6NShQZYvmZWNjyfyD0xFUv641/AddFkgFXInID9W11xDg87So+tyChhVXzhaUi7kz68UziTvVQxIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(7406005)(83380400001)(2906002)(7416002)(40480700001)(5660300002)(44832011)(426003)(336012)(26005)(16526019)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(36756003)(40460700003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:12.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f840f0a-9d9a-4bb9-02fb-08dba29eb4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 ++++++++++++++++----------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3010e3a1394d..80a4f76bc34b 100644
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
@@ -2377,19 +2369,47 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static void rdt_disable_ctx(void)
+{
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
+		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+		set_mba_sc(false);
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
+
+	return 0;
 
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
 	return ret;
 }
 
@@ -2497,13 +2517,13 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2562,11 +2582,8 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2798,12 +2815,11 @@ static void rdt_kill_sb(struct super_block *sb)
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

