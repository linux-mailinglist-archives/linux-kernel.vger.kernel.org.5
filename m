Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEC7C8E53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJMU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJMU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE179D9;
        Fri, 13 Oct 2023 13:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm6gW7rzwTZHcTKyo9VjKiTbnejik9JGkP/IfljXnmpfyNYKHv0yNLCSbEP7W6VxxXEUOeqmRH7TT0bqvgn3R6aN01MjVH2KSGVfieZtF4yo1coFd09sJIiiVjitzW2xM+5pQKSVNMcMVDGppcciMJmAjR9/DzHDuJ6AtS7xkngC+hT3UdXL5ndzKtnd6HMKzDGutyOkIPaJk6brApGhc49pVYHHvnc7j2Np3WK2bYAaILDSmJazhaER/uX+ha4J1fVcwJ2SXAPPWznY6viuNy48TBNCixhW2NVNLMRdsDeEloQx0Aw0fVbOEkfTHfo0h+fRebl8uSUbLxUvp8Aq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFonQe0XfEvp5dRKc2OGMGwdvIAjBDZfX35rnrN8fcg=;
 b=QByY1SWVvmfTrX+ApT1KV9XRWjpZZju0VwyyBjl5WCOczWMG2sjJHKeRC9nOtXFdXf9UrR//zq0HCJYd8mdNstXNPTecFisQ5FUBx3WYmvUz5jI3CHPwWIHvTs/OY318UNteTG6qh9ohHeP49cPR1dXDbs5ruPh8AZ23xDr1huQZfGkmJx21RJuI4oHKQVtfuXKq+K4XGZnkCHLjyb9aJtn/InD153UW0qtAn9habbIH6KH3Z8F8rad+wlblILGPmOTcKUb1W1iUCu0943J/xC2JulVrmlzBlbmicLEebgB5ts5P22TRLHAyX/MGbVFZziv8lTij7g5j8Tsrh9QqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFonQe0XfEvp5dRKc2OGMGwdvIAjBDZfX35rnrN8fcg=;
 b=MvWt3L1sT4BzoMV1XKPkL226VUYsd9xnSccXHniDmzaAbTo5iaQ4QnMXWqsegloUk9IfDBBiEcNX7zcVx3+jePcWgUD/WjYSpOOuvC6yfx7dB35AplOL9zQelYouz0AxcoALOUeKhFphRdEB0RRsjjrurRzFMenUiz1uLp+EP+8=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 20:26:26 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::78) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:22 -0500
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
Subject: [PATCH v13 08/10] x86/resctrl: Display CLOSID for resource group
Date:   Fri, 13 Oct 2023 15:26:00 -0500
Message-ID: <20231013202602.2492645-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6f77b9-2dd8-4e88-31c6-08dbcc2aaccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSbtofK0AXZI7MOvhwluvdZexu0W2MljX3czrO1c+UUdOYclD5GwDH4kc3qahUAuHwUyq+5OtuO3ZcM9CZ3awHIcI91juJCnCNt3d5dxi37aLiOBg2g/UBvZOjqCBqiUTStAoOXDSs5fi6BiYYE6h6HwzuoKP9eos9YQ/m4R5gskrEbVZrtAMEQO1+aflAimpBT1szvidTf/UKBuTHQgXv5o3/H105MYLus0gU2oSRoKNM//RehHQlmnJHpkNQWeUp47ufbB3MH+NRkDy6plDtVPSHVICEvbo2EZLTq3mX8j2uDj4xIt7IgHG0BT/Qa+At0c+GDe6rAazXdFCIYgjP3UsQL/iNV+j+BCm516DUN2ffFFrfyk22sW5JrG6UP9p2wGku1qLvj+4QMoWP4Hj/3cMdoBj22AHCt312V5pBFttTAa2vo8r6SoiXAuAOfTRhnjMmcZVaVd3ISqgcf2eGSi2HxG0vL1ye0FpeWLSDQfFw8DWGvAZGOluS8UuGaXBzGS/qi3x3rmMseZjWYp1kCRzmqCsRhgNt1Gn2I6A9oMNQfqqh1i15w6vvtEhOLnjE7lrFTRNqoJ+wsveAo59QzlNZZTDNn72SkXJ/SXz96IvmHpiWc6Qb7mjkNk5ramQHADzhwnPDqnxsMrmp+wTfo/owXzwI9Z3AXA7xdgQ6K0P1D96rCMarmFq9tD0MUhvXPhDlnpEI1XDd9iGZbhIOkCnGzvGTSMFMmFNPI5nt5CPxJS4cldJRSiIZUlhNg88XrgwX0gHUiN98UWXBzFIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(26005)(16526019)(47076005)(82740400003)(426003)(66574015)(336012)(41300700001)(83380400001)(36756003)(2616005)(81166007)(356005)(1076003)(86362001)(36860700001)(6666004)(7696005)(2906002)(7416002)(7406005)(5660300002)(44832011)(40480700001)(54906003)(70586007)(110136005)(316002)(70206006)(40460700003)(478600001)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:26.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6f77b9-2dd8-4e88-31c6-08dbcc2aaccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
v13: No changes.

v12: Moved the comments about RFTYPE_DEBUG to resctrl.rst. (Boris)
---
 Documentation/arch/x86/resctrl.rst     |  7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 0438880e38c5..07225d9c0b0f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -359,6 +359,10 @@ When control is enabled all CTRL_MON groups will also contain:
 	file. On successful pseudo-locked region creation the mode will
 	automatically change to "pseudo-locked".
 
+"ctrl_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the control group. On x86 this is the CLOSID.
+
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
@@ -436,6 +440,9 @@ RESCTRL filesystem has two main components
 		-> RFTYPE_CTRL (Files for CTRL group)
 		   Files: mode, schemata, size
 
+			-> RFTYPE_DEBUG (Files to help resctrl debugging)
+			   File: ctrl_hw_id
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 84e0f45578dd..5814a0bf3cea 100644
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
@@ -1881,6 +1897,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_has_sparse_bitmasks_show,
 		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
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

