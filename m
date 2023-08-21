Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2D78365B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjHUXbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjHUXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E155195;
        Mon, 21 Aug 2023 16:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNy71paOyoE8rtxCQ0hPgfUtMtwKgsY2YexFxHPOn9uXLLcMGgbksu3RlWLxane973o9jLZEVEGpkyAAkIQ7tleEtl16xqEN28Ln5lxwF3mDPGVPQt4zGQOqNpqHKMMa2B5uY4RE/6s5a7OR3NtXELAr5qYSHs+Gkl3TwGWR7DpQ89qjFAKe6qeo50krnnYzkKE1XUjzieN+XzZJI/0isAd8aFLJodGC6h/wrFHg+34XKrCZqgJ4L2E1ZPYOyAgycc288FTPtAev5bbpZEpDPW1S3zx8y73SAKiabnvdbNUNkehFDve8fHkiIPHAjqN1s7inK9eOuoMhz3DufoUDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwJBGBO/RwjlIDTULKcAkbPlh3qJGfZBP9Hqv3dZVLk=;
 b=KGEOXmBABhcDHh9hHIzmaYQ1uh0Rg6iWVJnl87eaDBDgF5a4vQR1zN/P1av/13kLjkwA61Z94EAKzyYvTs/bNlDLJXAXOlSEp4kyscGM5PRaI3FA31FNoGtQrfFGGQdDmiP4wcJBkJ6yv1g5nH/AkNNLtnz4NZ7nwXuV/2Jjz2Nrm5cHdbqTIG5pBx40k8h/GczIAswuNJRWKwemw0FmDnLs5+P+jJRbtirUMS6toTrqt8/dBqXbEyk6Xoz5/Rch9HUBqHwYZ4RsLpBBxGIha7km38CCCnPvwNhwskCrKEb5kVjQT+XRGSowVJA68Qa3gEZMMI7xX0OEOIT2zc29NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwJBGBO/RwjlIDTULKcAkbPlh3qJGfZBP9Hqv3dZVLk=;
 b=AmFeWzcsoU457iIeZyF3iQWy5pOJ92T4rv6poL4gSqvxs7jK3xN1s/EDzZkHTzJ7Gz6Jblkv1/JWYqwLYp/mxeKyRg/gD0QKi4fTBuERgJDbcA3bKfkjg0BVzE8dGlNoIPx0AROxLYesGpBACk+Ng6SqvATwD3Gl1g5YFRitztY=
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:31:14 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::28) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:11 -0500
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
Subject: [PATCH v8 6/8] x86/resctrl: Move default group file creation to mount
Date:   Mon, 21 Aug 2023 18:30:46 -0500
Message-ID: <20230821233048.434531-7-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: e46223a1-3bd2-4675-2604-08dba29eb5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0JJ4YJOHFAwBlE9DMLNfzag7esFZsHpj1CZuHWd5EFnohvrraelrLY0j/0iZ9Ry9xU8JQcEKVb6WWzehj8P4jyAujdFpZPxKBUdCjr55q3WfPdRdO/kr4BTZPy/na7LlUGLG9FYiAhjEwSvaOl2MwlxoC2+wFRJrj8oGDFk/1mbmBbIXd82HXsQRp5pCiatveJauR9UYN+p4eiZWcVT16WquxgrO1Pk+79IFmhdWxI6chcoebQ5r0RXtgUrMtsm+eBLLQEAMOY2QAshnydwo34EKP8wcYsX4BYI/o8kpggZW2prlkbe0T8PilAIELyHSvjtb4kqt12rh3PfN/7Xo6Xh5XTiN/QzEe2zSGSx7fdTR4anRxO/ygdV+lIOizLsIH3QXcGaztSk2x/bHUSwKuh5Nn5Gt/lRcMTQrEGyqeIt96Ie/gWm/Wuhk8xvNYXBBftUlGhBsD5de6d2VAHPy810pm78Au0S9wdt5FQOhgaMjlUxLsZDzCFeJhH/VcPN8GWzv/xKLNwjZSKoYXJNtmU7yEWQ5Etzod0zUwwn5z5eqmdP6A6X3LX738DNqgOD+uOTO8/mWZzixVqhLHG4cAqnFkr32yKMmJZuSUEgCFutXI90VQGEtO2HIfoO99T8aqfdVTIRqv4nMPNbU0+mvJn0FDkHfBlbRCTMIym6isG90HZz4YnoifYAAiVeXohHeYO6M5JixwoFqHPPXi0sgtrj+s5SfH6gmq8pWZXP69gZcLaSk7KMKRqF+mqk0TfkEJbSYTs8slcq51e5Zs3T3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7406005)(7416002)(86362001)(7696005)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:14.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46223a1-3bd2-4675-2604-08dba29eb5db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b09e7abd1299..44ad98f8c7af 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+void rdtgroup_destroy_root(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 80a4f76bc34b..98f9f880c30b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2516,10 +2516,14 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2528,6 +2532,12 @@ static int rdt_get_tree(struct fs_context *fc)
 
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
@@ -2584,6 +2594,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	schemata_list_destroy();
 out_ctx:
 	rdt_disable_ctx();
+out_root:
+	rdtgroup_destroy_root();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2654,7 +2666,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->kfc.root = rdt_root;
 	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
 	fc->fs_private = &ctx->kfc;
 	fc->ops = &rdt_fs_context_ops;
@@ -2824,6 +2835,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
+	rdtgroup_destroy_root();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
@@ -3705,10 +3717,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.show_options	= rdtgroup_show_options,
 };
 
-static int __init rdtgroup_setup_root(void)
+int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 {
-	int ret;
-
 	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
 				      KERNFS_ROOT_CREATE_DEACTIVATED |
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
@@ -3716,6 +3726,20 @@ static int __init rdtgroup_setup_root(void)
 	if (IS_ERR(rdt_root))
 		return PTR_ERR(rdt_root);
 
+	ctx->kfc.root = rdt_root;
+	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
+
+	return 0;
+}
+
+void rdtgroup_destroy_root(void)
+{
+	kernfs_destroy_root(rdt_root);
+	rdtgroup_default.kn = NULL;
+}
+
+static void __init rdtgroup_setup_default(void)
+{
 	mutex_lock(&rdtgroup_mutex);
 
 	rdtgroup_default.closid = 0;
@@ -3725,19 +3749,7 @@ static int __init rdtgroup_setup_root(void)
 
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
@@ -3859,13 +3871,11 @@ int __init rdtgroup_init(void)
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
@@ -3898,8 +3908,6 @@ int __init rdtgroup_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-cleanup_root:
-	kernfs_destroy_root(rdt_root);
 
 	return ret;
 }
@@ -3909,5 +3917,4 @@ void __exit rdtgroup_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	kernfs_destroy_root(rdt_root);
 }
-- 
2.34.1

