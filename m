Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189067C458B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJJXeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbjJJXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:34:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F99E;
        Tue, 10 Oct 2023 16:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTjmgpO6qWK1q26X5GmrcBGn3ybnlFvNDaFj8edyn/YDysue2wCRXWkmMwXMYWNq/4HYnngGqs7nlVmS+kwsmcw8iQmR2aRinoHvB+q4qzQo0iaGTA7rLlSPZPeRrjSsMJMJXvldLb+Z1UKCO3mRAB/M+Kat5THY8Kpd7if1C4kxZj98o3H8g1zgHGoNIkDQGn7H5+hfbvHNLBhupnsaRNwif8QfF5MGac5MHoUjTI6HJ9cTTA8gkvvqjGh3GM+qDqF3bAin17NNfQLpyerRGGitMRgowiikfJ+dSElUn9gS47qAKhtpFUKk4p6hqUY61QRPurO0HDxf4bn+GpojsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akFdCl0umwGazU7ouu48BHdA5i+GpQXriOV1oTjjoDQ=;
 b=nxcgiDGXcVI/6HL1YR7c34zw/iw60sKNotZ9/6PdxSvP1fbwy41C9IaBJhyRR2DIgTiE/p45wbiYboYeKrS0iD2QQypPMo4CadlxoYncff2uMUHl3nFDEK2ushEjdjY9lB8YCnwOr/iO3hN+UFM/UY5tNqbAqBl7KMaqTtCDolyjFnJEw5cUPBQB1IK110HitkDl3dnNZdgBpaAFzf4ph4GzpSVnIJdOCyI2AFXe4nR4jEWA65lxGXAjLebFxvJjAiI0SnJlb5DJMY1EwsbHdZFiF93Nh8W5NOa/pVJGyqmYAgfOge06vxFfv0M+2oEWrL0G9ACHkbnAs0JOgHgyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akFdCl0umwGazU7ouu48BHdA5i+GpQXriOV1oTjjoDQ=;
 b=Gx2MSrAnYQ7DXYQ8vz1n7ZoalDrUDnOI4xx9qjyFQnT0CTeEnKsEW7iSFchf13Kr4cZK9iUxjenYqKQtiX49hXTRwA3NYIdb1KUB+Tj7utyeGmmxRBef/juJf/WOX8mKbNXzljrIha8ld93AyV7JtaS76OCsXDdag4cvH9JHA/Y=
Received: from MN2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:208:15e::32)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 23:33:56 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::9b) by MN2PR17CA0019.outlook.office365.com
 (2603:10b6:208:15e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:54 -0500
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
Subject: [PATCH v12 08/10] x86/resctrl: Display CLOSID for resource group
Date:   Tue, 10 Oct 2023 18:33:33 -0500
Message-ID: <20231010233335.998475-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7580660a-f97d-4ad9-e44a-08dbc9e95f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhtuF+6GzUdv6Rlb0SScBAGFJVjqtsSkQlLX9f6t0v8hWhMOe4WhiOfhDPoC6LYtcT4wwqEh6kyP/4P7BZDXQ7DgCREp//B0BeNtQ4vIvYE1iXaj3FdxC04HL2DqlM/p1dyyOKotIR81kcc+aePKDU1e54jYppQsbmK4YrQRjcapDSrkiwFVrgRoFFd8I2TUoUGPPagtIjuIuiHJt/JpX9umTYTJRFUPXn8iZd4HNiTZ+fpwF6TBFAhnWD3LvstirnJQi5ZG2DJA1IIUAPqE4ZqMO4ZRWC5kmOBn8YYUk7d1KcKQDVxnzOsBtdN0AKTPrAjcKjqOePh0ZxRAYeMbj8T2n9eJqNGuX/zQFfKe+K30CqWjjTuPuqiyVw30x/4LojrQ/blalETDK09h1sTsjv2cOKL4FjH1FVbxW4KVabgAtJKPz305UOkjbNPok3fyfqUIoSp8OEvzjlyKam7xrrqbS4fPn432e7/RDKpUVVYsSinqsLBahcxYmkwFZPHuYa84V3aZ3nSRj2SZbDnfil5wT6So2tfzZBHbi8muSGnNAmPM3SnhU4Pxiaj1D+2aXVqVF4l+WPPxIVso6v15sPf7m3B+b0vdVk+K4joeyRoG7sVrzOp+pE1EdMjwrotnsDg4NJ1cg7a6q4bwJu0hGiusk929eF+2TmA/7A8VQUhYk3KsFm/abPs5N9pzVyvHEFHHK7tM6eei4R3h3aR5PGaN17035nya5WhbR4gg1ts3CY+3a195KtXZ8hgcg9jioOTWakcYOxg7ETvKJjeECw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(70586007)(41300700001)(316002)(110136005)(66574015)(70206006)(54906003)(6666004)(26005)(2616005)(1076003)(7416002)(426003)(7696005)(16526019)(2906002)(47076005)(83380400001)(8936002)(7406005)(336012)(8676002)(5660300002)(4326008)(44832011)(356005)(478600001)(36860700001)(81166007)(36756003)(86362001)(40460700003)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:56.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7580660a-f97d-4ad9-e44a-08dbc9e95f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses CLOSID to identify a control group. When a user
creates a control group this information is not visible to the user.
It can help resctrl debugging.

Add CLOSID(ctrl_hw_id) to the control groups display in resctrl
interface. Users can see this detail when resctrl is mounted with
"-o debug" option.

Other architectures do not use "CLOSID". Use the names ctrl_hw_id
to refer to "CLOSID" in an effort to keep the naming generic.

For example:
 $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
 1

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: Moved the comments about RFTYPE_DEBUG to resctrl.rst. (Boris)
---
 Documentation/arch/x86/resctrl.rst     |  7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1774f7b8450f..5dcd7d250ca8 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -352,6 +352,10 @@ When control is enabled all CTRL_MON groups will also contain:
 	file. On successful pseudo-locked region creation the mode will
 	automatically change to "pseudo-locked".
 
+"ctrl_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the control group. On x86 this is the CLOSID.
+
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
@@ -425,6 +429,9 @@ RESCTRL filesystem has two main components
 		--> RFTYPE_CTRL (Files for CTRL group)
 		    Files: mode, schemata, size
 
+			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+			    File: ctrl_hw_id
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 150105c21fee..953b082cec8a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -779,6 +779,22 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_closid_show(struct kernfs_open_file *of,
+				struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->closid);
+	else
+		ret = -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1863,6 +1879,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_size_show,
 		.fflags		= RFTYPE_CTRL_BASE,
 	},
+	{
+		.name		= "ctrl_hw_id",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_closid_show,
+		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
+	},
 
 };
 
-- 
2.34.1

