Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6B7A2A83
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjIOWnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbjIOWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105BA186;
        Fri, 15 Sep 2023 15:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXeMB5iXk9O8OcztlBYsHRKAH5u0oQtnZetGHAz3e56VYDxSQZilu5lk2o5pcNwxgZZZICx8bD9nFUYgNuST5Odrl+/nbIdcOyV88Q6+GMo7KcV8ZIoQEkr/iMKEGBLxQEVkrOxMuQbBDzH5JMGG4cSTVd13dP/a9kx0CHwgrauzs0rUx3e6w4GxsULv6gue02yGfVVUDV38C5zN2cCoNI+ybFbqU9RUY0KT88yk/7baORZBX/t/p9lF85UrZmODqVHvZwwfcIDZsVC2SBehtraIn9Ufg5XxJjgxFJUxOZScQ3DFx8Qm9gqitTgjCGXEB9SrGdz3y7mXmeZQ8dHnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/7hZ5SyYRhoLJbc5I0K2ThwZ1owcA5JNUGyhoUp7as=;
 b=PTeuSOeq47raz0YektEmTWsfMDF6z1ijd+cwQkr9YOwWagzGWNGU8J8HrMm7y4ijngLfKywQ706FtuvgDRHLNQjBEk2QCPTMQSgq/NvridmQD/nBE2Sdcj8tl14ZVvO7naw5Ntso2Kehvs7g+qZHzr569CWMLMkx5Itr/B5PiFKZVrMklI/jQ+gOEYx1Ie+8iMDOvDy8isrh46FaIJ0lR8ER/mO8F+G1nboQxlE62rtEyT4SkwcfZXh3t3zCsQSIzXyl2AEpBlKdrJK5AMOzBSIu5WNa/zyAGvV4/mquREtulikkMAXpEEkE42V+wRsiv7Er3++EIyO6DSivJMZaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/7hZ5SyYRhoLJbc5I0K2ThwZ1owcA5JNUGyhoUp7as=;
 b=Nv10mebAvj10AeV6nMojFQwbNLwhCzEzyDL3lrvc2/VQ9PuEcaPz6WXlya5rfwpTOQQkmAXX7zbwYiJJWqB20vl7wOULUBAzuDDPTOAGCwS5rQzyhztKis/403+jA9I7Tj9aZuTtR+S0dg7Z2LQAItr6GMPgMXpbuZJMN62I7uI=
Received: from CY5P221CA0098.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::35) by
 DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 15 Sep 2023 22:42:44 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::ef) by CY5P221CA0098.outlook.office365.com
 (2603:10b6:930:9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:41 -0500
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
Subject: [PATCH v10 05/10] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
Date:   Fri, 15 Sep 2023 17:42:22 -0500
Message-ID: <20230915224227.1336967-6-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fcb729-594b-4f11-d2fe-08dbb63d13bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKm/pE1IK/uwPHWGFzlVb0GfE1Yp5ctay1rVebHOq0wwsTO2cXZ/TUeZUWSiiXRIkF3CerJoUtfj4IC5SR82fkhEv0kr/6GJaBJAsKGHeyilQW175dqWxmSAfwVN3A7CkIOexcfMG2VkgNF/PDIBw1OiTyAaO0CHxkzzjj7kHgkoaH39YcOBUJ41FUZ9K3ymAfFvkSxYj9Vs4Cn1QiS4AxaLYubhofn/Z7XqfhN+J1dKcYV3DriMl9kVOCRSaPXRMmdfg1miJlFBDHo3IeP/eck+wgx0/aY82ytAjyHSwuSSvFPYRr4oUFHQNl+mUF4JWUFuIhlKDr0VxzwzDjVFYP/WGI5195+NKJFex4HKS/8fz2lhshb9M9KGxu6UlEhpkwp/V4ZkB14rPoiRE/W6YFB/s+rjJB7VnnhloEzzCpMnQwXRbVSHrGyuXSiZDGnCGPKcEQOFljExmGvfn4f2JmyUEXLP2QbgY/E+Z9ILFLs0n5uVZSon99fXyXttNWB4ma+aonXyXLff08M1es2TV2bzPcJe98YcZRcUgRrbJDi46SZiwB3IBqIHFWGreNXoPWrfym5RxeQ18zI/M8HSiVfBxCSoMznIrVl5GFJsXmk1ItMDyb9Qw5ggQlO/qsCXLocMjh7c+WhpiHdLXaAGkECd8wBuu1vDjdXUoiOWXFWSaGrMUupt/UDFwPjEjWJMtIxTkq0ixeIAvtFzAj+l2pJ/bcIQjB6EtSkLQqzidacQXQkiIu5gYwbFgv7UlH8TGdr1Yegc0VxA5WXVTP60rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(70206006)(7696005)(316002)(110136005)(40480700001)(41300700001)(6666004)(70586007)(478600001)(8676002)(8936002)(4326008)(2616005)(86362001)(26005)(16526019)(5660300002)(1076003)(44832011)(356005)(81166007)(40460700003)(36860700001)(36756003)(426003)(82740400003)(2906002)(7416002)(47076005)(336012)(83380400001)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:44.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fcb729-594b-4f11-d2fe-08dbb63d13bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 35945b4bf196..3ea874c80c22 100644
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
@@ -2377,19 +2369,42 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static void rdt_disable_ctx(void)
+{
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
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
+
+	return 0;
 
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
 	return ret;
 }
 
@@ -2497,13 +2512,13 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2562,11 +2577,8 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2798,12 +2810,11 @@ static void rdt_kill_sb(struct super_block *sb)
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

