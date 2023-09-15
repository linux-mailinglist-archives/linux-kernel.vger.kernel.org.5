Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA47A2A90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjIOWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjIOWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD73101;
        Fri, 15 Sep 2023 15:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR3WMbtJULlvwOIB4bqVkcfyMI0WByJyd3BklDESXfQeaUgmwMsbB8Wv1O0NoWFP/w9yA8tdqFEwOq0lrNpGWH9X0CQEoy/YaOyHkf6/jkPUaaKSzqZ8+Pw5YZEFUzsLMYd2XquI5XE4y+U9qlt6weXO6QekzYMC9KrmpBh9iA/hpiv1A8IXV2t3mQVgnDdpT6/j6esB/PjEOrc/oHZI4O/SzRoH88QZXrFsx0oL7t7+cgrRTrbE7o7oGoQ7iqNapR2I3SXGFRDkB18cJx44Hi1MOJqZ2qYsUIPqIC5Z1Uh0PAnQTl7DjL7RDCOxXG4L5OL/MCCC7BlY73KJEGgPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dINoIK6N/Smd+D1h2Ne9MB3WxGCVRu8LqEjuIiQ6aPw=;
 b=KxNnmvjH5n9Hfus8832BCw8BlZyLpya3HMBFcyS92MHCoE2Wf1s8fYURslm7RYb1AK15s8NPV/R7ZJxKiCLhLWEBoUq4ujMfMjXUYXiVSdnu4CcmgSWeosfD88LZccUQcBGVNMKQa49doLhTDTQhXtihZpANsCSq5iPjUBVD0z9a+mFHvH1b7IuIbLQD9ZoMsnrTkSTOm2J0AbxuFRPaXq7OU/cyvQVFjPeVbr8cIGIntjkmSUkQ78qfnU98EaR48jA69ZcH5VhfOrIltzO8kSUHS0kQEX89oCLXj3fXyEEzG9eGmFxm7/ruDZiUovzl/Ahxw62yAu+M7SoWm4VC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dINoIK6N/Smd+D1h2Ne9MB3WxGCVRu8LqEjuIiQ6aPw=;
 b=gBciziuspqUPTO9vjVQwm9WZxvzq9V3laT73aWJPTkfiLk0qstS7SMtvV9ZRPIvOYbPAx16zpuEQDNsnH7MDVMgSszGUd8wxG+b2fD9BFd1COAVViSbcrUJDa6JOmpF7eYR/iCPG7br8+l4C3yd10QlQ6kuNoVRX6xXEiVfltOk=
Received: from CY5P221CA0088.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::25) by
 BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 22:42:45 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::22) by CY5P221CA0088.outlook.office365.com
 (2603:10b6:930:9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:43 -0500
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
Subject: [PATCH v10 06/10] x86/resctrl: Move default group file creation to mount
Date:   Fri, 15 Sep 2023 17:42:23 -0500
Message-ID: <20230915224227.1336967-7-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915224227.1336967-1-babu.moger@amd.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: b1141be9-9704-440a-501e-08dbb63d147f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BH1s2f1kjjNBGIJmAL4CNDAfzJ/NeCtWlicRZATST2wlj2SzdRSlmSXuTTvnCIfOaUl0QyHLZe0RGHwUmUAjdhkvvAIF6c+r5OIHWBSTPjCcN+j7cfnGURFWISYY5E+opLzfKo4Fv8JVsvEFehjltRY0wy3kDFDJtFD5ZVw4xglih/NgF0UWTsfirpYs35DO3fOxxXpcyJq+vSuABlPxtmje5kl4bkbl5yyK5NFIdUEJOX/zYpAhuMKQLGtOPee0gwezTImUWiSZnXucLN88hI1Xj3xntCM8/Ws/lXTK+bfMle6rWyUqaNX0D0k/YBxYDE/FJDbXkRK+6kP8yoVunP3FTKGVBOvqT72+zT9j/WMqOjPkKFkTHEhC2UbaHStbwy8z+2AsM+fKR64K0Xly4TFbzYJ/Z7C4eVJAm4yn3RF+w4K3fZvggnIOr5KmbxSBitLum2fkVutyb2CBJiFPqTDQMr5A9LO1ozl3SKKV2KJfNBDiRhzzcugUtZugsirtQyIRU/YblfCXZKBjwsWelViFhPqhzdUUZx5PmrYpcVomJ4raj7rFczSDuK/03aauxhIK1+owUCsdX3R2wA1OV9Rsv2GIqP6ZFab/BVpCDVOR24vz42sa2dS9Skf/z/LU2KuOQIOnMTFYjYZvJAZQYTUU8QFd6f7TlOirspuJO4XL2YKAovMvK2ffTHkqSa72vgS3VyeceXwulwPjNOrr770Hj/ealSJdxrVRtbCfVJilpDJpDIkJUC+GPKbFHt0VG90WYD8l2HvmLzUkUVk+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(44832011)(26005)(40480700001)(16526019)(1076003)(70206006)(7416002)(7406005)(316002)(41300700001)(54906003)(70586007)(110136005)(478600001)(336012)(8676002)(4326008)(426003)(8936002)(7696005)(40460700003)(2616005)(36756003)(36860700001)(47076005)(6666004)(81166007)(86362001)(356005)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:45.5111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1141be9-9704-440a-501e-08dbb63d147f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 +++++++++++++++-----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3ea874c80c22..a34657f0bd0c 100644
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
@@ -2511,10 +2514,14 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2523,6 +2530,12 @@ static int rdt_get_tree(struct fs_context *fc)
 
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
@@ -2579,6 +2592,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	schemata_list_destroy();
 out_ctx:
 	rdt_disable_ctx();
+out_root:
+	rdtgroup_destroy_root();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2649,7 +2664,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->kfc.root = rdt_root;
 	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
 	fc->fs_private = &ctx->kfc;
 	fc->ops = &rdt_fs_context_ops;
@@ -2819,6 +2833,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
+	rdtgroup_destroy_root();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
@@ -3700,10 +3715,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
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
@@ -3711,6 +3724,20 @@ static int __init rdtgroup_setup_root(void)
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
@@ -3720,19 +3747,7 @@ static int __init rdtgroup_setup_root(void)
 
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
@@ -3854,13 +3869,11 @@ int __init rdtgroup_init(void)
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
@@ -3893,8 +3906,6 @@ int __init rdtgroup_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-cleanup_root:
-	kernfs_destroy_root(rdt_root);
 
 	return ret;
 }
@@ -3904,5 +3915,4 @@ void __exit rdtgroup_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	kernfs_destroy_root(rdt_root);
 }
-- 
2.34.1

