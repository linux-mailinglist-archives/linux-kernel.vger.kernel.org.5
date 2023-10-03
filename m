Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1966D7B7588
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbjJCXzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjJCXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2BBD;
        Tue,  3 Oct 2023 16:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNaFXaH7gBNi5eE/ftRKG6yZaqHrchgXx7uP4341DJ7T+8YaVzZhxDhCAn4D/Eg2sMTTuTTs1qivUN1omyLDPfdSA2PyP3Zk6ZmJ93DUqeH8p5CL/6hiH137GuEbrbFJkl4LXlcInXVES/wiJ0UI1reDKiTaxCaaVSJ4hXBvCojkbKO8Z7nbjpn/EWdnAnX2hlt89ahnrXv/vPGpC6UbdaDH2H6LTY61nD2yCdUDXAVIMYVLFsShIetb/5Llw9qjaEJ8IL3X96YPF7I/9AlB7F18o5rwwr1b6QwbsAV4+XirCsLm5Uu4tP5D4U2aL+LP/ihAxgfIXGYeqI0ouAZxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvLp3ruEV92yv6FV48PWw6is1UZBCFZ+uHy28wWq6p4=;
 b=FmoeFCiv6O9TXoGEbLCUGwP5J8bPyCLrtt4Hq6E5jUSxz5oZBmwVO+mbEt1T5yPbRgrsrWXDSw6Eh4nyFhn/sGrhgaBVHHsmwjmAFtTysDMn1680OI8q6JmPhW7xzSuGeEqHuMtT3fQMVFONc27+5Hnnv8JWci7dWQHiKcHtYHDrbH0UcRiqIkKoByJixXDT25g+5GJufQkVXUEuXmGQbSO8wmhGseqzljyp8ZJZRtZc36WwLmzawVT5U+G0ebo4tYyR4era74LIhsLPRx/Lk9dydT8ARVeeHDignWzCczpdT8c4Bat04r2ZupVEu8ZH7lKilkoeM+wNHc0oI+DHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvLp3ruEV92yv6FV48PWw6is1UZBCFZ+uHy28wWq6p4=;
 b=FtK+J2QBR+g5Y+Q5wpMKRhr9gn+8YWN/5gX5iBOgsGx8h5HDQRNZ+iC/4hc4IZkPC1zGjlb+Mkm2jzlrLMs3bcUWti4OchyrWKZKHbRrSOWYL+Yvp2GQlFddk6twUqQA87xa3EHPJ7zY+quOzQFch3kSsQ1ktk+BmIyvMBEKGZU=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:54:56 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::b4) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:53 -0500
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
Subject: [PATCH v11 06/10] x86/resctrl: Move default group file creation to mount
Date:   Tue, 3 Oct 2023 18:54:26 -0500
Message-ID: <20231003235430.1231238-7-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d92659-50c7-4724-930c-08dbc46c24e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cu3Ku6Fjvw5J8dZDRE+m2Axa+jZF91fQ/f4u44gUcS1fu1Uy20rRWAl3LNY/teT1DK50z1Cp/6f6sZxovoCXaztyRPRqgXqyOvJLx6A+sjC5L2IuY0CvVlexfOYULd6FmgXxhN5J1Fpj/QzDkmtL60aLYx9uI4AOSWr4g4tS5bi5QpRxPvzyvz4sD1YSfQI0mwxzVf3hj/rMYeS1Jih0Vn4kWoJdkuwh7W1RUMVNswC2BwwborOt4Wykkve9ZBhvwkcRPVjYPIcX0FsnjcKnUthVGzo1mHOk/9jMR9JQwfkzmrknUvdxmndzpOWbr6b1k9jo9jSYEhvLbHrnasRqebRoKxVAkyE/TVb6qyTNc7fUNipim5SiElWn17Mnlla50DfSA+1Hw8+zmUBc87OakxYOwMcmq4fA2+NfiQAq9ULr0oDi6roSFk2XnI1pW9z6O2TRQoJWiwhnVyDGeocbBVEuQdQK5NvzqwXmqDq/wJhmau1I+S5g0CFXhjsj5gPkJVLy1q6EmmMJydaS1pkIBVtKaOeRPrXCde0h/XWfUvOwjIvAs/s87ZAzMWWlA9QVUnAPbVwMLOvvln+xPawOeITUDEaj7VzCL5zzBe9CSdnI3DaJ86fhYwt0RNWosLSBqO0IZKKOkmVmOAxr+byxOSma5PI4FLobkI1qAzeRTPsJv0E6DrZRThGolux8ACgeOC8/9aEwERX5N+hODmB9c9DBK42bGakH6qKZIFAvWX+cWAs6u+vRNnOWEv61e1QiIPJPF2QfZMNDbdKVtG/HCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(426003)(4326008)(66574015)(336012)(83380400001)(8936002)(8676002)(70586007)(47076005)(41300700001)(316002)(54906003)(70206006)(16526019)(478600001)(36860700001)(6666004)(2616005)(110136005)(26005)(2906002)(7696005)(1076003)(81166007)(82740400003)(5660300002)(44832011)(86362001)(7416002)(36756003)(7406005)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:55.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d92659-50c7-4724-930c-08dbc46c24e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

