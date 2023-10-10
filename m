Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B57C458C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjJJXeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbjJJXdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8A93;
        Tue, 10 Oct 2023 16:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdNcTOdk+/6UZhryh7S34E8trsqIpCWenN0GN+HIDIc2W9sOBmAmRZ5dAAsa7FMcXxqStVgwmTMKcrwuwVcRvuyreHYaVmVCBL6qAAjDQSQNM2c9mE+nzUBROb9CKfktIS0sXQc8juU6MRwviWc+/AFAxsaPbr58VtE35lA/tp7JJdEdYjJqnYUB+hQskI7qEJgaLNkQchG1aYhoAFX1Idk95Y98b+n8Hyyia4/OlszTbKywDKgei2CuPuxOsEXR+Dq5SCezpfeXZ2mOqPJmp89jPoImmQWCdzBnEZSC/AOEYy1Z2Bgh6BJ4+daGKj8txd8p9qzsN7SUm9wZEORHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc1oUxiw0dA5e9jsoVcsacmbFKbM3gi7SYCxARNC66U=;
 b=Y2/UjzJcTrHhVdc8sz3N0GlpaFJvpxLk9Wx/JGPmKvRZ/iOb55Dxlq+X1WIGt6xphmwCMz51r2hKGd+P0Wx++wMhFDtg196YSrL97pMg0YG4dNkxDtRrXsNzoxrkEfD+ATN0cutU7aN2rcA8F2ITNYNOmbjGFFIv+li3/MsWys4LwYPqHXC9KDfYjw/D+ayRwI08AhsGYUpS0vBjsfvLxgzq4mXABFFbxWNVnirWPoCvREIv5tE/KA5+v1jCiptAGnCIYSOOfvE7GawbpA0yODJIe2/z2IdBZLhZFf7+PzZecrBStyC1hXxnA2drKRRhdgMYVpaydsGsmlDgiov59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc1oUxiw0dA5e9jsoVcsacmbFKbM3gi7SYCxARNC66U=;
 b=r4Y0SNsq3ffcikIxuL82YlUoEsugX6IHcBsHydYWmnbtcvsm0Li1oiWZ7lKm1W57Oo2a7bqzzrzparX1zHkOEQPYNyHZkwD9Zau7R67kGwBnA/K/lPXdtiqj9Q9PbKqOpunUIPTjTgVbVd7sdkA7lqvBFCIwSqC7km9XjXf7ns0=
Received: from MN2PR17CA0033.namprd17.prod.outlook.com (2603:10b6:208:15e::46)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 10 Oct 2023 23:33:51 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::80) by MN2PR17CA0033.outlook.office365.com
 (2603:10b6:208:15e::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:49 -0500
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
Subject: [PATCH v12 05/10] x86/resctrl: Unwind the errors inside rdt_enable_ctx()
Date:   Tue, 10 Oct 2023 18:33:30 -0500
Message-ID: <20231010233335.998475-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010233335.998475-1-babu.moger@amd.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 901245dd-c94a-48e5-8dea-08dbc9e95c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5ox6Xs77fbhhELMUdCCrpk9kNYMbTzzK91CCCPANo+Y+8Kne/8K2dhR801aQLiy7OECvwjlMc83L7WzJbfws55CqSTklHdK97aWa2PCukIDtFup+jlBSgL755V6omvvzMfASMbu8ngg2/g1TIXbUzeSnO+fLdCZvq1aF4cQ/Q9g3kDJ12lxeFUvGG1G+h7YkrziW5SFRM09M0naYzmtaT3q/7rd9W+Nqfai9vIy0Mmk22rRLnM/UkKn2IFkpr/YdWbv+xrqBTJVwdT1IZI1sT45IgybSuycxrn0Z9wjVqrtWWjNNEFnewxIsS0GM6ZUS/s725Dt+D1bKwx+GVEPEDTyk4N7W44E9wY8Dtx09eRqWOSutFih1xQEER4OTPB8ErdDHkHqnJmGoGu7O4aWQ0CBo1Wutf50ERsvJ/TZvIduEGRgv7Tb8PQKc7Nbz2BUnIJlEO8cDKA/Cq+DnGtUgQlFT4Vq1eLDwei2ufIYCTHrm7+OfMi7y62xia15LeRaaL8TrPV8vBbMJENRNjLXQAMgPa/5aXk8kgD8lfGxnFLI2gcYCLAz1ZOu09Itfq10SIK3jDecLZgfofi+RgINaFlJOYktgtAsfSHYqUgHqKYXxG2pVfiECXtpDM5Yq+rUfQ+Au6PaeEhmgcFbnPSA6N+p3ps+soCfVvhRWNt1nV+OFxqgCdQ5G/6qsgLFSDNESd8znT4qrlXAb3dGoGOboZkZFxwsPYUsGyztwfvsuX55a9cqyQJOUm5xGygv649Hh4FNL+0qbJ+C5fGqKKZ4eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(40470700004)(36840700001)(46966006)(82740400003)(7696005)(2616005)(1076003)(478600001)(426003)(316002)(41300700001)(336012)(40480700001)(66574015)(7406005)(7416002)(44832011)(47076005)(2906002)(8676002)(110136005)(5660300002)(70586007)(54906003)(70206006)(4326008)(16526019)(8936002)(26005)(83380400001)(36756003)(40460700003)(36860700001)(356005)(86362001)(81166007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:51.6458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901245dd-c94a-48e5-8dea-08dbc9e95c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: Removed the redundant comment about cdp_disable_all().(Boris)
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

