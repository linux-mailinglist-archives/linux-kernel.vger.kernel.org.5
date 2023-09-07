Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3A797F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjIGXwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbjIGXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:52:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D281FD3;
        Thu,  7 Sep 2023 16:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la2Gie9u2tQJjcIz3dDE5TSQHWS2iuJhDcRzdcc0IOARjYfUN65rSewa37OCf4YhvIunrTDVbowpqPrCxDHVYpLF3b9paHJFbEU1w5UCqwV2607UAgj0+K634w0RXJj3TBG6mVWkFr2wsFCNiHW4xCcdqETVWxEGp+UQ9PUgN5JkgOurBeDdCIkAFDM2hF7QKg7hssQg17HFEHqSjE8pdozjKfxSuYMVF6CBMWerEbw2pFHKc8+PzmywzC0Fy/5KtcwIozUzsGM5SxipC7TnGg0Jj8uw91TkK5rDNTxbOYAfZKX2N02GxLEKGJI1Py85Qlx4dSDZLq3zYRwVL0wOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0NpsTPJd8SV1677TlndpV49bd82TfNqFlRX5JUV0ac=;
 b=lgYcQcFqVrPuLxHedpMkEVLxzEbhQrrLI+71/OGbk7WfoY0UBfmlOOKuwcREKossc12V2QPPzB6n5pqYFxLrWBfhTNEca17iqSqKU+j+zy63A+1Alt/Wi3/BTlvQZKKe5CXX1F0y9+qgpSbDJCGbLDxwjxCa7lM3G5sLaMRwD/gaG6ys0gQ4pYDfVj47cugm6kDwrNSLucDA5TT+MoXEU2oDYOxpyiiQtZaBz/Oj+zQH51Rc9KAE+I+VkRRmHZs01I3mZ3PJQXxkNIkJBToIYITraq85HevaADUICaC/6ECzZpIrMzuQyn4a+NPTHHFow74w7Hb9k6GBFgygA3fgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0NpsTPJd8SV1677TlndpV49bd82TfNqFlRX5JUV0ac=;
 b=kpy5Fb78uA5gozhHa2GXsFuRA0a3pCnt1jrI2KMXI8wYh/hfxjFxMDhVfcltCW2e9+GHlZUknxWzW8KrllVAiIynP+4zoEowKopnsOqVBg92rNw5lyumfSODiOFBxufy5y5ndbEqdFNZCWHnoKCsaSXqAdC1IlWK1Ta3HcJWrFs=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 23:51:51 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::48) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:48 -0500
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
Subject: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
Date:   Thu, 7 Sep 2023 18:51:28 -0500
Message-ID: <20230907235128.19120-10-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4911ac7b-aac0-4d78-7f36-08dbaffd6809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3EbbOfJg0azwVB9ybvzRxq018gUL6X6HIDSB4XAS6rLCd5iDHqWt7HRh/4mkEB/GgRCvV7sFsWGL/QK3dzXb+ewFRZrb+yVofoV0DrZ3dnIiKg69FmDZe2drgqFo6+25fakbRgmCMZ3ztnA1q4605pEcmocj63UwWCIz+aMfxYqg5YacLuvGlZvhuNX1xNyEc6n3UGfrmCj8m9z73/OMpyxPIxvU5A9eSy5Ly5PxdJwjPje3xfX6zYZlWf4fkSpp3zTyjk1I0wCpl7WQYdjuphckS9jim89s0QBWc8mIXSOEavwcUKKpJCxmb0a/hHhA/QhUjSQcTpTiT/pdrbnFEak7W3poUYlFyZev9CPNHO1pXBFzqzPZb5tQgaVrt9v1Rn0uJaC6MnbE5KcPUqu6hIyuGu1mpsdcIN3CRJAu7bxtDrcBfppCWiRIg8E+XwLnttJYdDXTSe/Z1os6zJJjYcx2g3ltK9uQl8iFuSlXAK75ZR9XXSGYGxkWR73VpTgpDh2/l9Ghh0KGMMlnM81vWpv7bKlxsURXYgmiq01ExScWizTi4dGzN9Y468mbgv8cRhaf508/XnZ0OlXuQbXuMNmdbQZDHQqzpNN8sX8nlEZ+zgkZVcQ2jbaHf6DJXqadBSswdwak7N9RyiKotkAH51l7uUlb3nDJQ8kjTZ7eCD5pGx8Dm1MM/Jas0xNI2j0csBO+FhOVglfzEwzAZnNlbUx7jAktry7c0Z0/XOCDLKHeyLPYHVgLUiP3QJNG48PIn85W2QT4YYKtzBQup7MKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(6666004)(7696005)(40460700003)(2616005)(1076003)(26005)(16526019)(7406005)(44832011)(7416002)(4326008)(5660300002)(8676002)(8936002)(81166007)(86362001)(2906002)(70586007)(36756003)(41300700001)(316002)(54906003)(356005)(110136005)(70206006)(82740400003)(478600001)(83380400001)(47076005)(36860700001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:50.9159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911ac7b-aac0-4d78-7f36-08dbaffd6809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses RMID to identify a a monitoring group. When a
user creates a monitor group these details are not visible. These details
can help resctrl debugging.

Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
Users can see these details when resctrl is mounted with "-o debug" option.

Other architectures do not use "RMID". Use the name mon_hw_id to refer
to "RMID" in an effort to keep the naming generic.

Add the flag RFTYPE_MON_BASE, which contains the files required only
for the MON group.

For example:
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
 3

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  4 +++
 arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 +++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 54691c8b832d..98b0eb509ed4 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ccdbed615d41..b4910892b0a6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -296,6 +296,11 @@ struct rdtgroup {
  *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
  *	    Files: cpus, cpus_list, tasks
  *
+ *		--> RFTYPE_MON (Files only for MON group)
+ *
+ *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+ *			    File: mon_hw_id
+ *
  *		--> RFTYPE_CTRL (Files only for CTRL group)
  *		    Files: mode, schemata, size
  *
@@ -315,6 +320,7 @@ struct rdtgroup {
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
 #define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
 
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8be0fb323ad3..fc830ffce82a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
+	else
+		ret = -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1856,6 +1872,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "mon_hw_id",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_rmid_show,
+		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
+	},
 	{
 		.name		= "schemata",
 		.mode		= 0644,
@@ -2535,6 +2558,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2565,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |= RFTYPE_MON;
+
+	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
 
@@ -3255,8 +3282,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files = 0;
 	struct kernfs_node *kn;
-	uint files = 0;
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
@@ -3308,10 +3335,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rtype == RDTCTRL_GROUP)
+	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-	else
+		if (rdt_mon_capable)
+			files |= RFTYPE_MON;
+	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
+	}
 
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
-- 
2.34.1

