Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320687C4590
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjJJXe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbjJJXeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:34:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF810E;
        Tue, 10 Oct 2023 16:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm+xJk6NwfS/Y7W1kVpDI7MFnWuEe6dZ1fEAn+FLMCoQmEpzPijZk3f0e2zLqXxJYv3Xmq51W4MeUTxVVUq/Uurv6psZjNxNODweuM1xA/V7456PyUiFmMHf7w8HwhtLPhNKpj+bxOjUnsvRzzmwJc/I22mwSH7iJDbco13wJgrVQGwX3FVziKlRq5uALyBLHusKml2PqZH7HNFjsuBX9OHmoVUO8wE/2IpBBMTJ/feMCmGeB9YO/sJyHNSUsA9fTt0Xix2zj93VJpo0p7pbsB1z+sS+5X7U2vbIyzKbtabWEgI2Y0W3aIB3Sg4lmi0h5Fc5rw3murr1nmq/omXZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmaph0uUsn266K3VN15HgWwURdzFPwcIi3WSSi8E0hg=;
 b=MP9jZVeDF7MIWgl6kZPpTDb85dVJuyj0/Dh25D2QcTw5X6csxngcLiW1eKHbYsn2p4saFjFiNg6v+ik7y/EX8cHDt6O1WisA3m6yjQzHJnwmUQgyeZxevhVljgIVzx6AZVuoX8lL+G7Xpls7J7cjZS5MlYlHxZ+FvZfpJ8E+r30pwFEKCaS9de1Bne7ZYsvxpyUAph/TbEo0sjdsAMpR2u18EM1KRR7WE4HVeuAyDOkvRaTDuBS8L7aUNlmmUb1HwAJjPJWnisK+Mea9lsKoTd2B9adHetm5lLvMUztrEZTQiiott/AXiSFJsL7O0BrlrWQj0G3uc7Cy30cvUoMrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmaph0uUsn266K3VN15HgWwURdzFPwcIi3WSSi8E0hg=;
 b=zEkP4sO2tRXZuawc8lywSGWSFQp/EuJpqKLqwz0Nr7i2NGDbsjVs9YzmjRrS2dAyKn7RAWHaRt03YMEaqgyVactGjPGtx4/Btby4ZwN7nnJG9mcXYSThrkZXfhfwBKgkV8NaC1SbaxClOxA2oCiHbVPvf3j+u7GhbxwfAKcHofQ=
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:33:59 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d6) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:57 -0500
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
Subject: [PATCH v12 10/10] x86/resctrl: Display RMID of resource group
Date:   Tue, 10 Oct 2023 18:33:35 -0500
Message-ID: <20231010233335.998475-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b587c890-9256-4c89-ab08-08dbc9e9612c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sm9w+nekjc9rNYc7jdqzRp5EAXGzw0t68uAIUOhO6ksx0mUGtRjGhSYYGoEmGIZPF1M/+opBVyZcvpNbZQR8T8ry+XbdJ+L++zxaNy83pSoRmy4Dp8LTBNh/BEbx1sFmXyjALmNT6f7ZSi3cDa4VdUsmVK9wEnykYRpItcjJGxBECKcAd3dhfSOxBFIuMSnX7TjBEZ4JG/VbN9C2dEQQi/+z9k60xQMXpPqELyRpziI7CxmDML04MP27DjwbvGzZbune8IAGB9wsM1BucoZk7gGVxjDwQvY8Xkvfu9IhT2Qs3l2xUBNLlur57sf2B4dfZqy2+9PtI0EFJDvAf8Yh4K+5epgxTNvd9hZrzwngEH5gXC/x/Uqt1oI1dIkEzO6Xv7i3qsIbIDGfGYOe+sfklIXBBlV5/tg6hg55OKYnlrtfuK2JTi7PxXDMscq5HE1zr0gu6+ZHklj3fuUzbfLT4e9Cr0bp6DhOuXtytWXAhHtybt/hhHeAPr1qHtfgfVxY6IiI/ls2yGaAIiPl0cjjSKCk9QrNWRT/GjwLI7gxNG749BdD5+7lsE79mynGUac6XtRnXAZs1QKIRJHYxaMeCgP+FeciQCBu+/nyP61WiJU6bsnfKeWw/T2He4ouCBQT87rxzLZD89THh6KCPRwnWU7hNT5QkIsRmDf/TzIkD/Rx9JFSD4kmq1EmZixnjjMfi1EBUPqRtm63PjK++SrMqxnUlSJ6ZzLOIbALrZIdctt7cJmfaWS7lGs8fVaLXBnzbt9IFO8g+SjU9NdWJHh6+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(478600001)(7696005)(2616005)(6666004)(47076005)(66574015)(426003)(16526019)(336012)(83380400001)(7406005)(7416002)(2906002)(44832011)(5660300002)(70586007)(54906003)(110136005)(70206006)(26005)(4326008)(8676002)(8936002)(41300700001)(316002)(82740400003)(36860700001)(81166007)(86362001)(36756003)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:59.7312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b587c890-9256-4c89-ab08-08dbc9e9612c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses RMID to identify a monitoring group. When a user
creates a monitor group these details are not visible. These details
can help resctrl debugging.

Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
Users can see these details when resctrl is mounted with "-o debug" option.

Add RFTYPE_MON_BASE complements existing RFTYPE_CTRL_BASE and represents
files belonging to monitoring groups.

Other architectures do not use "RMID". Use the name mon_hw_id to refer
to "RMID" in an effort to keep the naming generic.

For example:
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
 3

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
     to Documentation/arch/x86/resctrl.rst. (Boris)
     Moved RFTYPE_MON_BASE definition here where it is being used. (Boris)
---
 Documentation/arch/x86/resctrl.rst     |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 5dcd7d250ca8..e89b889980ae 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 RESCTRL filesystem implementation notes
 =======================================
 RESCTRL filesystem has two main components
@@ -426,6 +430,11 @@ RESCTRL filesystem has two main components
 	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
 	    Files: cpus, cpus_list, tasks
 
+		--> RFTYPE_MON (Files for MON group)
+
+			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+			    File: mon_hw_id
+
 		--> RFTYPE_CTRL (Files for CTRL group)
 		    Files: mode, schemata, size
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f0d135e004e2..714606275b98 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -254,6 +254,7 @@ struct rdtgroup {
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
 #define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
 
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 55d1b90f460e..ef4b18091e5d 100644
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
-- 
2.34.1

