Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F77C8E51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJMU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjJMU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB47F0;
        Fri, 13 Oct 2023 13:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnQfQAiDRqGOCj5EQkehFN+QnE2eMqz6H+44xYjchIl83xSgoDPiWqnrsajOb5IVcT6D/sJUshmrQCK8L4nXESJM2cCxlHhS1UDE1PpDei7Vf0ttSPrfeI/vaCmPNteHHGjlH4rpBln3JQixf6vaK1fbi2ysxeLcxN7Kd+Yy+QNuYjh2SFXGz+aB5bh9YZL/ii7uwiYcfiVyo4L+wMNdpiEsmb42PtTKCumMGKd/vT3qhQZOkay3jgDD+mBO1L8MBORTbU0ZyFlK8V6cNMB1ylg+s3zNLbyECPC3LAENkngxnOVTF1xImruJK5e919mCjxhEaV2XmgtUZ+czHjI/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd6tdTcU3TIUkjXSphXUPjL4BOn/PCWoK4hUkNiM8zc=;
 b=TMMYH4g0wp9PemoWB80d4j1/KaX/kXcTRC1v8aAyLuQjzzCh8BuPA9IiViThqqO3Am1wtflWdi/r98M2tiMPC7CdopHsPcWEzO+TB3cPSPlHTIvx4vdTG0cN/dAzOq2cqdZEg/LFedl7Yxa0RzhOrwNtXawCS5WJ7JRITHuhpYr+5UX2Qw/d77onqtyz2r9/3uyLdvpSEdkh3XtAKRtjf8sXz7ZEXU+ZQbaPOxTBjDR6YauHRlzw8vaJyP0ynu/K7Xcq+eA+5Cb5t23BzsBU3f/yiTfZViQc4qcklkT454cWxWwL/6dI+VTS703KXXrLcF+WjccjfuRhjzBRtMB7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd6tdTcU3TIUkjXSphXUPjL4BOn/PCWoK4hUkNiM8zc=;
 b=JcgDFeMJfYMtwv03NyvLPz9LlG8bwfGvjprAQLYQOOxHSXBDnp7J3S/cUBN5+028FiYXFq6wgH61s0gkmLgWl5U74ZT7InXM2vELVPnNYrgNdCLl8OyIYub1ml6jdxC8flxrFEj20+uiIYzfdhg9dzMH5ieMVYpMPzBOJqU3mAA=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 20:26:23 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::9d) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:18 -0500
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
Subject: [PATCH v13 06/10] x86/resctrl: Move default group file creation to mount
Date:   Fri, 13 Oct 2023 15:25:58 -0500
Message-ID: <20231013202602.2492645-7-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013202602.2492645-1-babu.moger@amd.com>
References: <20231013202602.2492645-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: f14f7718-d857-4c44-bf66-08dbcc2aaad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kU5NMHmlBRbEMaZTQ841x16o97ivj6ZCjd+leLKO6h3QkMRxMbubycpmL8XJjUOTeSIajrko+KVnLhWQCx6ptQztgVQQNWAAfBti1fDeEUMI2Tk99JgVrokMBEzqLLnROJl79Yj+EpsboW0YUbmMUkEW27vr+HoxoQYDmnx6bHg4mbXMjswmzy1m3RKAYDdIMb8z3rGBbKi+fVEmGhQ/gpGoNOM/CF0Sa7K1+b0BXXnO2K8nTGDX2rPwjZgsGe4rYQePyvAU5t3hnF3d/ZGOsdy+pLBGYyhE2wU43UTDK4X86e9yW3ZBRgmp94QqgdIjqdwz9J9H0BaOlShFqmvmSByIljCaZyh3n4pYL36pOSphOaiqWxt2MLJKqH25EPgCfbW1tPHHYas9BSmGEITRPAwGPyLG0wHQO5HDjBGAT9Bdzu3mhORMg29Z1nqQhHeUI56ycgCvUdDXHaPvk0U0BCHH+B87PvPWHQTJwJMNAVC1L5ink5uy3VcbBs/nuCePrpm4anMpgS6NzPMRTZBe5dpQkEX9aVCNWDZoHWVKm1iHv7OCdEio2jaNG8QDOlpi8kWii/bjpTG7dd2t6JQruszqeZL+KWTWrUpUNcWR3mzXxp444PzUXiCuX/kvqUowuA5TWg5GFC9ddwVYL1kwnWzNfsSRJrC1z/+nK43Zc/OP4IcVNqUog1DLCosG7gOm6oM5L0OP4YARZ0tft9ABfL2UpKs/pOyhSvpTPEC4Gip/9is/UOLlVlzv33EqKCcfUlzF9aMYdQWdKUwLPn2rbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(7696005)(2616005)(7416002)(2906002)(6666004)(7406005)(41300700001)(4326008)(44832011)(478600001)(426003)(66574015)(336012)(16526019)(5660300002)(26005)(1076003)(83380400001)(316002)(40460700003)(47076005)(36860700001)(36756003)(54906003)(70206006)(40480700001)(110136005)(356005)(8676002)(8936002)(82740400003)(81166007)(86362001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:22.8906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14f7718-d857-4c44-bf66-08dbcc2aaad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default resource group and its files are created during kernel
init time. Upcoming changes will make some resctrl files optional
based on a mount parameter. If optional files are to be added to the
default group based on the mount option, then each new file needs to
be created separately and call kernfs_activate() again.

Create all files of the default resource group during resctrl
mount, destroyed during unmount, to avoid scattering resctrl
file addition across two separate code flows.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v13: No changes

v12: No changes
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 +++++++++++++++-----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d1b5fd70ccbb..55da93b5ca53 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -54,6 +54,9 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+static void rdtgroup_destroy_root(void);
+
 struct dentry *debugfs_resctrl;
 
 void rdt_last_cmd_clear(void)
@@ -2529,10 +2532,14 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
-	ret = rdt_enable_ctx(ctx);
+	ret = rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
 
+	ret = rdt_enable_ctx(ctx);
+	if (ret)
+		goto out_root;
+
 	ret = schemata_list_create();
 	if (ret) {
 		schemata_list_destroy();
@@ -2541,6 +2548,12 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
+	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (ret)
+		goto out_schemata_free;
+
+	kernfs_activate(rdtgroup_default.kn);
+
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
 		goto out_schemata_free;
@@ -2597,6 +2610,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	schemata_list_destroy();
 out_ctx:
 	rdt_disable_ctx();
+out_root:
+	rdtgroup_destroy_root();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2667,7 +2682,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->kfc.root = rdt_root;
 	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
 	fc->fs_private = &ctx->kfc;
 	fc->ops = &rdt_fs_context_ops;
@@ -2837,6 +2851,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
+	rdtgroup_destroy_root();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
@@ -3718,10 +3733,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.show_options	= rdtgroup_show_options,
 };
 
-static int __init rdtgroup_setup_root(void)
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 {
-	int ret;
-
 	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
 				      KERNFS_ROOT_CREATE_DEACTIVATED |
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
@@ -3729,6 +3742,20 @@ static int __init rdtgroup_setup_root(void)
 	if (IS_ERR(rdt_root))
 		return PTR_ERR(rdt_root);
 
+	ctx->kfc.root = rdt_root;
+	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
+
+	return 0;
+}
+
+static void rdtgroup_destroy_root(void)
+{
+	kernfs_destroy_root(rdt_root);
+	rdtgroup_default.kn = NULL;
+}
+
+static void __init rdtgroup_setup_default(void)
+{
 	mutex_lock(&rdtgroup_mutex);
 
 	rdtgroup_default.closid = 0;
@@ -3738,19 +3765,7 @@ static int __init rdtgroup_setup_root(void)
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
 
-	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
-	if (ret) {
-		kernfs_destroy_root(rdt_root);
-		goto out;
-	}
-
-	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
-	kernfs_activate(rdtgroup_default.kn);
-
-out:
 	mutex_unlock(&rdtgroup_mutex);
-
-	return ret;
 }
 
 static void domain_destroy_mon_state(struct rdt_domain *d)
@@ -3872,13 +3887,11 @@ int __init rdtgroup_init(void)
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
 		     sizeof(last_cmd_status_buf));
 
-	ret = rdtgroup_setup_root();
-	if (ret)
-		return ret;
+	rdtgroup_setup_default();
 
 	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret)
-		goto cleanup_root;
+		return ret;
 
 	ret = register_filesystem(&rdt_fs_type);
 	if (ret)
@@ -3911,8 +3924,6 @@ int __init rdtgroup_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-cleanup_root:
-	kernfs_destroy_root(rdt_root);
 
 	return ret;
 }
@@ -3922,5 +3933,4 @@ void __exit rdtgroup_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	kernfs_destroy_root(rdt_root);
 }
-- 
2.34.1

