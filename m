Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75557CB75E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjJQAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjJQAXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:23:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B93FE;
        Mon, 16 Oct 2023 17:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ8O0IMY3SGxAWmcY6YxRJ4glckZq3hw3/q9MlFJce5TA7pbzw/fmaMrh6BwFuCp0vG8B9lpWiCoM1u9yTTMTMJavq5eDZ8NC5WUI5BnKH1lonxeAqBnkqNmI52IxysECMSGzBzhqB73mtMajS1chK+Sq/DyTJcPtXWRjUlHQRmrZHYGRmlp5BlOEwatrkpna0/9htrpJ2vpjk8h8ObsWd8eNoxtngF4Qmo9uxZBHBrDQMd5xYSqn55kmnNgwW29QHq7ZdS5bkSZRxxmgmB1iIklA07XMeX67PPuLxxZSKXzRjX8lgZtcRnLyQ/fn2x0Grddupfzvh2flGIiHfZMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27DSedx2hGE4Bg3gVP5x0PPZ7tUFt+K2UTQLHt1cg8w=;
 b=chRPlQ2Vi4LH99iO3GtRgVkANs2F92RFXoblviNARWhiHW05laBhFO5rcCWcw97jqcUJ7JXNHsxf3qc1xSPNiEvalLAI0qpW3zMXCxRkEcB72oRPIK4PP4hXSs+PQmG6zN+Ap62KCyrEsFx8ms+UyKQvuM7oJaWztT9lARJx2ii2vFCXlqpxxJCQxa3qbKV6uix9gye8FO7mYAgWsbZz5lFDd2M4EDJzV7VqASkOmy4krm7RW5FK0YFDcLOYUeks0tGBsfu4M2Nc4kwO1IglkESx5FzjEY+J8z8e5iO9cPbOgLR3mRNuhrm1vGn54yr/R6hHarpBc5haKkOr/+WPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27DSedx2hGE4Bg3gVP5x0PPZ7tUFt+K2UTQLHt1cg8w=;
 b=gdBuLzrxMjTJUmr4orkoGwEgJvkpkMzYx09u9eMd9T5/NusKqyJf2iWwg2MvxdBGOgw63jE/Tku7mYbBgNcNSnqaTeBB+A0rxjA9wVXV8Vr11m8kCphq634QBDhS1Ac+Lrn4DvQ/UGCtQ4xHx6CW7gpvooFwFLMQXBkSQ7FCzPY=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:23:37 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::26) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 00:23:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:34 -0500
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
Subject: [PATCH v14 5/9] x86/resctrl: Move default group file creation to mount
Date:   Mon, 16 Oct 2023 19:23:04 -0500
Message-ID: <20231017002308.134480-6-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 17378192-e38e-4f41-81f7-08dbcea74e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUE9CtBsrw2KJrlKCKPwnNxFwF6jTW4ebBQs+I7LM2JDkzOBPtX2ISU7f6w07PI44Gi6oLKzDqECF/ZCanjFtrEDD872AiYvxd+x2vdck7fPZ3rhMKcVl5efRYh1jFhtAQCQNZ4a3907/jhoemI0uPuVr8BBjOy+UkNY0qpvf88Xe6tA74oG14RdR82Af3LvDAgjhrxcucobpwR8hPkJe4b4LmC3FnzJgrIu8h0jKiAVTDsDm28uozqwLqgSjfcR0OSZLNKLt5/ER3DOI1R12cIMVoQ1RlXlZeS7DhIzc1hmCQ1TXAxZjkEhfFovROIb2YjDQZYQgOhACgbFnLCoinjH3lUa0z0CSAyepZzKJJ5Ir0Lt8L4kJNI8BnV7U0P1aZDGp5DnOny0kD6eyYL5SyXNYqEhcMAME3C5LAGtbGYmFhRBDxqZuR5rj6b/sqhrDFDGJaR2rscWpHUFWcnlvGw4puFctZLbrobCcvHzeGJy37J1lqVonEG6QZJbpGy63aiugP7bDCng6dU4vikbxZ7pWTcCNdF/wU2rc7S5t2TXJEN+ZWzvIKCWPOjIK5MZr/cegbM1PiG1cYweT185jknL8ze89254S0dOcgebLWSrjrGX9vsIZ44WoHLuv0CNmOSmPbLc6+r9KQvSMN2efX4CAvH5VBsV5WtQk1umDXcVKCSXAgO2MygDOxY1YHSyrnScV3ZshOZsKmI1LpwKEYrTsWcJoL3JRck4crbw6aH5/KFznnEn0wt0Y5ovlLNf3suzm+G4/TP8wjoTqsQ2Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(110136005)(70206006)(70586007)(54906003)(2616005)(47076005)(83380400001)(356005)(36860700001)(86362001)(82740400003)(6666004)(316002)(41300700001)(26005)(1076003)(16526019)(7696005)(66574015)(426003)(336012)(36756003)(5660300002)(81166007)(44832011)(7406005)(7416002)(8676002)(2906002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:36.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17378192-e38e-4f41-81f7-08dbcea74e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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
v14: No changes

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

