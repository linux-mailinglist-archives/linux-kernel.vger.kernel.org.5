Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB8797F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjIGXwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjIGXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:52:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAAF1FCD;
        Thu,  7 Sep 2023 16:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i38MVzpaMqf8a+2NzhDJi3ZbN7tCpJods3DbFEy5sXEvx///Jv9ixIwKM33AizH1NN2MXsRqxlrVbvRX5Zy9mfrl1To7QxJlLOsVxm5X7H9MKJ8uMxk3YbwAuGzIu4e4Q97Oaqveh5C2p4JlJvO+FgytfDLDuJW5mYDiL1xbc9W7/0CR2VXyQToTOAa9BFGApXmZcG0HQs1a+2tat/fagiivhCY6S+RpjqqnlYY+NOUZPFph16is2QZl9ZplGmoOd+j7Nl7lOg/llVfkLHdNRfuSmxUFogbVeB90da5zpG+AikOT0gVoFGYU1WCf0xPvG7W9cXLxgc6Hp9eVHv737w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiAg2hegbT5uQd8uduXJkD7sTAUGE5tl7Thrbog9pq4=;
 b=eciQPnh1KH/aNxYK7doNMTbPrriEEA7pPpy0Fjx0SBqTEWbFLttBm7LM65l4+1dRoja7VRtwIem9AqvtG79pB0xA8ceYeS92gbDuHtJJLyLHqkSvsJohBGDpDLekCbO0fHbe1TFv5awAnx09W6CrkNzs2TrgQfwaOu+u66bDQJ78aWh4XAtAJEBXaJ3uktLiJVlMfNC4MDD14FeUdbh2qsrthTaFEoynlplrF+oj5Qq20Rh+DHcp0ZHgS+EbSsoHxCi6h3s4twC0V5rOPjlvVSSCpLWGmNuxOXpqFBwG11q8v3eW5zwYzUFqJNoOjwr1dg9VMANEke+uEaQuL8kINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiAg2hegbT5uQd8uduXJkD7sTAUGE5tl7Thrbog9pq4=;
 b=Wv8oyJQ/iN5/1oWPLDGrsaU8p7ABsLbsaxu7de6kpqoFfv9qtr4wKq7jiQRZ5/2REMeX7yteWKcYidKgM4jFS1marfugpn8ZnNvBqoSx7EoJn8RkZciLu40bYLMVVcIeNiSIg1d24zTwedHtH4SJ00PoOUnj/ZxD8vOv2ggslP4=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 23:51:49 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::c1) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:45 -0500
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
Subject: [PATCH v9 7/9] x86/resctrl: Introduce "-o debug" mount option
Date:   Thu, 7 Sep 2023 18:51:26 -0500
Message-ID: <20230907235128.19120-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 08808688-2c7c-48b5-94d3-08dbaffd6638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H807Hk9sl3VTLXddldwgUm1V9OtCjFwlDjdtWlM0uynPWHe8JjizWvcM7r+6HRYpxC6pf/Ch2gtN9AY7XBGPZKzXX7NfNnOu/J5LYmiNcZseX6W6q1wThf6TGrxs7Wzo+FIS0c26O1TFfzZZIKIM+9/Io7BuLiUc+70Dtcy/GxZxo9AQIY9/PzZrTjg/A2cWZw5RYy4iA+G3mdDhk6PUCCTi3frgpqm2rP4a2A4sJMXprMEFN/ZLKY7iqV0PzD+7Glb4RxBujWRq7cGUNRR/5VFI6W/zL/heyv+RKIPrmtV7ZqWNAqVS2VHK8x02wvlATK8zP7pr7ut1y9EfsvzcBp+qP9JmbnSuewA00XDmkiBwCV7l5ntNGz+PLCi+5TtAYu0zJ8Gxd50C0dwt6zOhrsWK62RGPoox4TC3wgWV+FNEm7cj4G1qXnZa00j5Cdboa4n8SAg2UWgCFqW7E1i1HqZ2rhfZ3B+hFIcRKlbjf8Xa2mrZSSZkNX49yDYoeH672lGHJKL3tcxiUZPLcE9HJvJ9rjAiGYTb0y/tMjBB0uUK6LsESRqq22QqhPdr3CjG2RrBNkDzj/bKTf9l0DZMTldeJM+GWR8nj1YVkk5guAtEKhKkqnwq0eOR8j5dbiozhQO+PvQ5fUgLG4YjPCzEs7RDk8W4EgSGMrQbjXL/auD+LhLPAtxurMDMqCM6t46GkCuAAUHUEySg8bzfmEc+37XlO5q90BI5H2uxg9C0PLRC7+beZ9RkLyKL2pLN+IcdmFVuV4xJP59jKgtm6R5eXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(316002)(2906002)(7416002)(82740400003)(41300700001)(40460700003)(40480700001)(86362001)(356005)(81166007)(44832011)(7406005)(5660300002)(2616005)(426003)(36860700001)(8936002)(4326008)(8676002)(47076005)(83380400001)(26005)(7696005)(1076003)(336012)(6666004)(16526019)(54906003)(70206006)(110136005)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:47.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08808688-2c7c-48b5-94d3-08dbaffd6638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode.
When in debug mode resctrl displays files that have the new
RFTYPE_DEBUG flag to help resctrl debugging.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 8154e9975d1e..28d35aaa74b4 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -35,7 +35,7 @@ about the feature from resctrl's info directory.
 
 To use the feature mount the file system::
 
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resctrl
 
 mount options are:
 
@@ -46,6 +46,9 @@ mount options are:
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
 	bandwidth in MBps
+"debug":
+	Make debug files accessible. Available debug files are annotated with
+	"Available only with debug option".
 
 L2 and L3 CDP are controlled separately.
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c97578e3115a..38b99a21ccd8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				enable_debug;
 };
 
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
@@ -306,6 +307,7 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
+#define RFTYPE_DEBUG			BIT(10)
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 27cae0cc25af..67b315f3a26c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -59,6 +59,8 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+static bool resctrl_debug;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1874,6 +1876,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (resctrl_debug)
+		fflags |= RFTYPE_DEBUG;
+
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
@@ -2379,6 +2384,8 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 
 	set_mba_sc(false);
+
+	resctrl_debug = false;
 }
 
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
@@ -2403,6 +2410,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
 
+	if (ctx->enable_debug)
+		resctrl_debug = true;
+
 	return 0;
 
 out_cdpl3:
@@ -2607,6 +2617,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_debug,
 	nr__rdt_params
 };
 
@@ -2614,6 +2625,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
 	{}
 };
 
@@ -2639,6 +2651,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_debug:
+		ctx->enable_debug = true;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -3707,6 +3722,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
 	return 0;
 }
 
-- 
2.34.1

