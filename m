Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8128000B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376951AbjLAA6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjLAA5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C421731;
        Thu, 30 Nov 2023 16:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/03xY0+PIyugU7gQ0SruKcuqV+UQ9uOGFM5g4dOQJ9Qhjht/pBREak3IWneL9igWRuX6xYqX4OV0hMWBixg7bQkBhe5U6HBbffYqTySKssEovpViDOELbd2J4mfqv/XswELnQwC7ZjpFF6yiRUdI29DxpNxOnJQhGa4t4Ec50ztPUidRezBMEqxCiShhdJoowHmeVcw2fus44BVqpoZZVJc+tfV3y8z5QwqFos9a210iM+ZtnYyO6aj7TuyoZjyusomdFWPf1cCM8WrzyVpfDHeCWw3GGr8Vxaehtoq+AAq3G8V4q52dQiFVNDx81hIM1so6To7DqYIZ+bVNARLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXezd0/zvxm8c1xmbFRqeajtbZKpdK4KxKIu4VPowNY=;
 b=MvyPNs/amQi+bJ8vapYGqNfX8m1XLoJW2WBnubExA6YNNbl0/vse1Xw/34wHj5Xl++4VTReZXtm2jxwZOcD0nBhJ+LPvC5Rkbh58R2vG1/dJkvIPewHJr4IkDDJuMQloXDAUmh5ZzAMPE2lMwIOmFX9l1JfUhzP2cYeL1SF1XUwVL5POAGTtMZD7uj2oQkBRA6A7xB1FvrQnRkbLUaTkHGZ42ew7YncsDOx1gx2vUEYdyYrp+zjtz9yzQlEHJxhWShQ/ueuGt14uaBV8zCTMGa01vmI0JU6Iu7MEmQPRe3Pc62eLJjgKQ88bkTUYhUsP5hNhwX6/Swbj0+Xiec7euQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXezd0/zvxm8c1xmbFRqeajtbZKpdK4KxKIu4VPowNY=;
 b=uL5pTr9rUk9zcr+byBBPr//EFj4P7Xji7sesdwmTv5MenMC20Z6BRlXKaLfWqx+wYhNAgf24lB2h4fvfJUa8f2wZt912j8aWwugyez0ICSVmxpEuIpDckT3XvYO4nWEy1oiwzbTbFwkHAmsHhRKw2Q45Lt172IXcG7jemG3EE20=
Received: from BN7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:408:34::14)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:43 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::6b) by BN7PR06CA0037.outlook.office365.com
 (2603:10b6:408:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:40 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
        <jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
        <jithu.joseph@intel.com>, <kan.liang@linux.intel.com>,
        <nikunj@amd.com>, <daniel.sneddon@linux.intel.com>,
        <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <maciej.wieczor-retman@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH 09/15] x86/resctrl: Add interface to display monitor state of the group
Date:   Thu, 30 Nov 2023 18:57:14 -0600
Message-ID: <20231201005720.235639-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: f6343044-e6cf-4553-6e25-08dbf20885f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gnhT7lQADbFNxsgQl2kk8kvevspRSs8kkrHWbiFHrIEqdCW/0tZySSH6TlmdyqpuoKoHzCum4AvhnlOqWU50QrZ6FGgiHTWVIFMpnrhldSremlhTGcyDPwVMels/NtU7Aabu7SuVZcroXwnScdaMYZDtXbXkTVxyR7EfzmxjuTzkGduJE1opNbos93ryOgC6ajoaiwX9M5bKUL7uI6fyKVnE4dKPvZBQkN7D/rlU2UqMVRAOtxK+mvZm7g1E3yTrb8kQrlaNs7iWB16RhEwBZpZhI2wvu+oLXxBzPECbY/2Z8/ZSB7RBTbNsPAmF14u4BHUqhaPRdyw/eHGJoTLMC+q4oVR9ocVYSMq/r2FHT36anGdaPTthuuWpxzy3+ub1EPM5me4NS8PUkSgB/SwhML0vqVkMnwv/hguQkaRFMv0OvL9Ef4QbhfBtZ2ck/PbLlgrXCcdsHttnfp7KsegF7BpxIi8btskUEsX6Xbd9bXG8rpg3rRuIClztv7EIZJtJ3XsJnBLE6ntPOLoGIBamwAJwZ4CEMqVb0woPMTaGIdgnak/MRQAjA+zCeUSEqOyXp+4ytnEqyY+h3WJzg4O6BhMazqsSJBg0V/JVcbLxPR8nzIAScCh/oe+Q+2qUADiBA+0O9Cg89WuI0ibgGjgKKO/iwVBi1NwJdioQtGsqaUC2+uf4xQWujhoxjUKtfWoexsEterflSX5yRhR53L+674skspqhbE5Sm3yZFl1dURMqClUN2Tj3G7MoqpI+6i62q2p3eE4YJ6rmBUWiGGyCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(83380400001)(26005)(1076003)(6666004)(7696005)(2616005)(47076005)(426003)(36860700001)(478600001)(44832011)(7416002)(8936002)(5660300002)(8676002)(41300700001)(336012)(2906002)(110136005)(16526019)(4326008)(316002)(81166007)(70206006)(70586007)(54906003)(36756003)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:42.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6343044-e6cf-4553-6e25-08dbf20885f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABMC feature provides an option to the user to pin (or assign) the
RMID to the hardware counter and monitor the bandwidth for the longer
duration.  The RMID will be active until user unpins (unassigns) the
RMID.

Add a new field monitor_state in resctrl group interface to display the
assignment state of the group. This field is available when resctrl
interface is mounted with "-o abmc".

By default the monitor_state is initialized to unassigned state.
$cat /sys/fs/resctrl/monitor_state
total=unassign;local=unassign

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     | 20 ++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  8 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 36 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 87aa8eec71b7..d3df7d467eec 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -390,6 +390,26 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"monitor_state":
+	Available when ABMC feature is enabled. ABMC feature provides an
+	option to the user to pin (or assign) the RMID to hardware counter
+	and monitor the bandwidth for the longer duration. The RMID will
+	be active until user unpins (unassigns) it manually. Each group
+	will have two events that are assignable. By default, the events
+	are unassigned. Index 0 holds the monitor_state for MBM total bytes.
+	Index 1 holds the monitor_state for MBM local bytes.
+
+	Example::
+
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=unassign
+
+	When the events are assigned, the output will look like below.
+	Example::
+
+		# cat /sys/fs/resctrl/monitor_state
+		total=assign;local=assign
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2801bc0dc132..bc36acd152be 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -53,6 +53,12 @@
 /* ABMC ENABLE */
 #define ABMC_ENABLE			BIT(0)
 
+/*
+ * monitor group's state when ABMC is enabled
+ */
+#define TOTAL_ASSIGN			BIT(0)
+#define LOCAL_ASSIGN			BIT(1)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -161,12 +167,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @monitor_state:		ABMC state of the group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			monitor_state;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 897707694cc8..edb679b22b7b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -779,6 +779,26 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_monitor_state_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "total=%s;local=%s\n",
+			   rdtgrp->mon.monitor_state & TOTAL_ASSIGN ?
+			   "assign" : "unassign",
+			   rdtgrp->mon.monitor_state & LOCAL_ASSIGN ?
+			   "assign" : "unassign");
+	else
+		ret = -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 static int rdtgroup_closid_show(struct kernfs_open_file *of,
 				struct seq_file *s, void *v)
 {
@@ -1895,6 +1915,12 @@ static struct rftype res_common_files[] = {
 		.flags		= RFTYPE_FLAGS_CPUS_LIST,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "monitor_state",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_monitor_state_show,
+	},
 	{
 		.name		= "tasks",
 		.mode		= 0644,
@@ -2446,6 +2472,12 @@ int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
 		if (rft)
 			rft->fflags = RFTYPE_MON_INFO;
 
+		rft = rdtgroup_get_rftype_by_name("monitor_state");
+		if (rft)
+			rft->fflags = RFTYPE_MON_BASE;
+
+		rdtgroup_default.mon.monitor_state = 0;
+
 		return resctrl_abmc_enable(l);
 	}
 
@@ -2453,6 +2485,10 @@ int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
 	if (rft)
 		rft->fflags &= ~RFTYPE_MON_INFO;
 
+	rft = rdtgroup_get_rftype_by_name("monitor_state");
+	if (rft)
+		rft->fflags &= ~RFTYPE_MON_BASE;
+
 	resctrl_abmc_disable(l);
 
 	return 0;
-- 
2.34.1

