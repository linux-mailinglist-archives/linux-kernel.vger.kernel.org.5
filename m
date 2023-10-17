Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746C67CB75D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJQAXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjJQAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:23:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2EAB;
        Mon, 16 Oct 2023 17:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwjOtCTVqUtEsX5veLDRY/CX5litQu1V0eeHA+PKaWIupWRqi7ozbmIU58C/PT2vF+VsuUK1kWxrU5rcH69IX3UuqbPrBepbJK9Xn2ulqGJgqPa3EZCDey2SY4sCB/b+bNACHc9CpPNT5qHdLn3+prjSdM+Qpgp5VMCXsU0W3rOy2FCam/suVT+JQWW0pgNulI1EWovx029dCPpNJ14cKBiN8oAPyg31WhjH/pmRB8QiWqB4BMRkQRHv0MKH3Qdw6liUKNSELoHpJKKmpzrQ6D3NE2wGbxZ6QFFcNd18kP+zgV595BGCC6us03tOBqsycXiidpirq7ATqakZzLYYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjTqRul7g52Lit8D0tY2rSL3yj5DF7yKxYQd3xtic+0=;
 b=QbLQVEikIjCg39Ps5l5LX3vt5PFd6qMrrsALS2i7ExQ3g1Mvslh7aC5v0WCUAYdlM2a8oE0dpnF06olqwDgxcBX13CXipDpVJSM+Z81B30Ohb0/kErvRb3Z5Uk5D/YXuJS2Y8G+LL6TuVn4lf+XoQJXn7znVNC8Wu4/kjTlkEWl2iGdUcYAu2zU1YE0HXDhtaRceD9XF5CIADm6zm1/CiqbUf8WXNWqFD2JZH+Iq16EAlr2LssvchY+fBvRLJ4n5sI7oBqFrMeFyoLly5+zW3pq3y94jxCdgE6haIYoe2LtzsScsQlBlNvm0i6WvXpipKc1Gp5HVvlFg/a87svSDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjTqRul7g52Lit8D0tY2rSL3yj5DF7yKxYQd3xtic+0=;
 b=4L2XoLxi9Nvv2WhC1c/Bnn0/F/i5WjI5N7K9B8n3faaKE9ItmtXUwuWW4dtEej75MuEcpoDkUCyBhiMKI/HpD/5egOYsSsInDppjhCApfWO3QfTuTley+L1T4SLTwu6aaNLRpXFMziu555BJtpp0gEzYTpXd6IqDhO3fOy2LwgA=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 00:23:35 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::c5) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 00:23:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:19 -0500
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
Subject: [PATCH v14 3/9] x86/resctrl: Rename rftype flags for consistency
Date:   Mon, 16 Oct 2023 19:23:02 -0500
Message-ID: <20231017002308.134480-4-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017002308.134480-1-babu.moger@amd.com>
References: <20231017002308.134480-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: b4351fe9-57ba-4575-f067-08dbcea74d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYmYHAfTfnvTR2qXgLAcbc3wALMbirXRCOblKGTN3Wm0owkrQWg3yoIaXY5Hu/fA9a/tNu4rNSDvLhGA7cilwNCQBsLzExVHzfAbPFxxp0Pki0si1nX8AnIXJU/0Ye/iV8XfQoi7CowdEi+4MKTTn3Ht1Hfug/zXci6jBOvkiyW2ssMoWUCDbi4LM+Z+ATcalG04Rm2mTwO//D9caqpybPIeHa7WzCprd2wPKWNwoeNm7CmdmoJqxmd13M34vfRzfa8vvOR3jzH8DDzfUQ5rlt8H87ICxLRk/O1od2/r7cetUSwg3hM0i269iDWlwbndIkbywpsMPFPgjdO6jvVo/7KH4+oIKze9etxptGppH2jlAFm2Z0IfT8os/HmVsMSaBoEdSNApBiq+fqVKuqUP7N5CCe5CS4D+tIxbeKtRP7UQ3uG7nAl5b/TdGfMSNhqwwMb3aMIbwufaYaonQ3NQ4q96+/LM79YduHSpJBjbTT8v+3uD7Urvicty8gbBP64GFr8/XVOvUWDFkCZfAg1pphLNKg5hnfEK8T0Y++MCvX6Y07+lEYne7ojlchwdLetwOIAIJkM6QG/0gVinvN7AOjHSC3Lam9RBYreEkcoa5rq9TXCMkx/hTN+DcWyO3d+GwXUyV6vrzNURQnz2XTdkKDW+M/5rEkQOWJBMHRKW8wkyHWc9bb2xBfYy/MydCz7UOwlzU0G9fAexiW2PPn8V0oFXDy2GoZAX4qxQrtnxCHiEYXW5qbgs6YAJx8omrQBzunH7UIQMFPoUQxM9oQmuZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(47076005)(40480700001)(40460700003)(82740400003)(16526019)(26005)(1076003)(2616005)(356005)(81166007)(66574015)(36756003)(336012)(44832011)(7406005)(7416002)(54906003)(70206006)(70586007)(41300700001)(8936002)(8676002)(4326008)(110136005)(316002)(5660300002)(2906002)(426003)(86362001)(6666004)(7696005)(478600001)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:35.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4351fe9-57ba-4575-f067-08dbcea74d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl associates rftype flags with its files so that files can be chosen
based on the resource, whether it is info or base, and if it is control
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.

Change the prefix to RFTYPE_ for all these flags to be consistent.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V14: No changes

v13: Changes related to rebase. New file "sparse_masks" flag has been updated.

v12: Moved the RFTYPE_MON_BASE definition to patch 10. (Boris)
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 44 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0ad970c5c867..ba4611111212 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -248,10 +248,10 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
-#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
-#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
-#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
-#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
 
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
@@ -267,7 +267,7 @@ void __exit rdtgroup_exit(void);
  * @mode:	Access mode
  * @kf_ops:	File operations
  * @flags:	File specific RFTYPE_FLAGS_* flags
- * @fflags:	File specific RF_* or RFTYPE_* flags
+ * @fflags:	File specific RFTYPE_* flags
  * @seq_show:	Show content of the file
  * @write:	Write to the file
  */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 09141f1f0b96..125d12d8f4b9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1716,77 +1716,77 @@ static struct rftype res_common_files[] = {
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_last_cmd_status_show,
-		.fflags		= RF_TOP_INFO,
+		.fflags		= RFTYPE_TOP_INFO,
 	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_num_closids_show,
-		.fflags		= RF_CTRL_INFO,
+		.fflags		= RFTYPE_CTRL_INFO,
 	},
 	{
 		.name		= "mon_features",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_mon_features_show,
-		.fflags		= RF_MON_INFO,
+		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
 		.name		= "num_rmids",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_num_rmids_show,
-		.fflags		= RF_MON_INFO,
+		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
 		.name		= "cbm_mask",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_default_ctrl_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "min_cbm_bits",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_min_cbm_bits_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "shareable_bits",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_shareable_bits_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "bit_usage",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_bit_usage_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "min_bandwidth",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_min_bw_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		= "bandwidth_gran",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_bw_gran_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		= "delay_linear",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_delay_linear_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	/*
 	 * Platform specific which (if any) capabilities are provided by
@@ -1805,7 +1805,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= max_threshold_occ_write,
 		.seq_show	= max_threshold_occ_show,
-		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "mbm_total_bytes_config",
@@ -1852,7 +1852,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= rdtgroup_schemata_write,
 		.seq_show	= rdtgroup_schemata_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "mode",
@@ -1860,21 +1860,21 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= rdtgroup_mode_write,
 		.seq_show	= rdtgroup_mode_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "size",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_size_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "sparse_masks",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_has_sparse_bitmasks_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 
 };
@@ -1931,7 +1931,7 @@ void __init thread_throttle_mode_init(void)
 	if (!rft)
 		return;
 
-	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
 
 void __init mbm_config_rftype_init(const char *config)
@@ -1940,7 +1940,7 @@ void __init mbm_config_rftype_init(const char *config)
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
 }
 
 /**
@@ -2075,21 +2075,21 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (IS_ERR(kn_info))
 		return PTR_ERR(kn_info);
 
-	ret = rdtgroup_add_files(kn_info, RF_TOP_INFO);
+	ret = rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
 	if (ret)
 		goto out_destroy;
 
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags =  r->fflags | RF_CTRL_INFO;
+		fflags = r->fflags | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags =  r->fflags | RF_MON_INFO;
+		fflags = r->fflags | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
@@ -3727,7 +3727,7 @@ static int __init rdtgroup_setup_root(void)
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
 
-	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);
+	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
 	if (ret) {
 		kernfs_destroy_root(rdt_root);
 		goto out;
-- 
2.34.1

