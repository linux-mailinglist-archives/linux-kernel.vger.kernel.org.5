Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0847CB765
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjJQAYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjJQAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:24:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF06ED;
        Mon, 16 Oct 2023 17:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtBx0KbXVtLemY90MZOby1vTJbdlTHOBjp65VqdXdzSJPhjakeAPol3Gaex6Y142xgwvNMab9QeFk59WkP2aYmL4sPIp/1XvZ10BhHAfDdm1l0JaIEJLo7GzXRenZAypfNOxrX+8MI30BHOdEwrc0zcyG7Dzj6Usrsxun93J4flomJtLC3Xv+2QpGYomZQBnWZw1rfYUrU5XEj2Sib2GkVyyaG1K/+6kq2zRIGARulWCrnaQ4W2lds7D6Ll6hRwl+nFpv2H6OGGpR68uccuetH03Hjpbt2Vzx1+UeKpLFrwEpiZjiJcK0gPNGbid494w5fLsG2HElIM9LMLZ49p5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA5mBzajElpiCfelQe7ylBRN/yhuuRgLzspIzo1mq0w=;
 b=YCR50gP6yEollxDpyZhKpP/9KUG4Cjufrpvcm1HzFcyrkObC33vIFmLOsUg6gpd3i/AYUCqqIIPgNs9SRrN5N/5Q9nZbovbeKyjVEsOB9ZYtxCJnVvI4JnTiphKKGsMNc1hUpuyoHL8WiEM83oQY8AvSALrTZAp7LDeyCxVv6Ol4vp8mRczQhHzTmYzqYwX9CW/pQmlyv73+bycqpdAKDv+e+O9hw77D69uJyiAcRwghx/xTLBVwswyZXw+fnCrZbMiG0Hc9fxJPVsgEsxGDIvfLzNeVocZgvxMcKDEri1XGt6pWmO72PcDlFbU1ySL8SXH244G3Sd/zri5ykhfl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA5mBzajElpiCfelQe7ylBRN/yhuuRgLzspIzo1mq0w=;
 b=CUxhxZj3zEGK59A4MJFgI+hk5vshb+k4Oa0SYe0p2dewzhbz7u/Rm0gXM76kwtia6lSMOQleh5MPqkbZFBCa1I1f6Oq5mu4oFpOLhV+PSRw8PaJlPbXgnSOGd7eCAZDHXbY9irgKdJBs3iDDL5IDe/qMSkjuXhbHf3jzAxAFM+o=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:23:44 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::7d) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 00:23:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:41 -0500
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
Subject: [PATCH v14 9/9] x86/resctrl: Display RMID of resource group
Date:   Mon, 16 Oct 2023 19:23:08 -0500
Message-ID: <20231017002308.134480-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017002308.134480-1-babu.moger@amd.com>
References: <20231017002308.134480-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2a1920-ac5f-4d6b-8f82-08dbcea75263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR3fihi7EhTI4nYm47qTCM9gzTvyPEVc/Tf6rBMQtz95HZzOScWm3YeAo1Z7pXQUQ6jIgRRbKzhOWTSQACEtV4wrE3Zxh9SRJAl+TkqhiO0wwKHtVwmlQr0+X2hsYl2JAFQbuLv+Lq2dzSZCV8hMJT4gYu9Bro15I8Ssmd2gVIZxaxfWVQSCjX+kJiYZ9ec35ZEPXkbtKilWoUzYO29EBKGZQ7KrWjB6dcsoU8tLmX/e+tYgmx75D3zSyvJNDK/dIdGq6RM5rI0XRpf0epgSj1GTnAfwkuMVJnp7RnLIzQlIVj4CY++FUpDImp3eoIwifVSobsOWQfW0+0+gcer/EU8pl9NgSg1B61qJhZdn5Cll/+2HwOOmjlRhMy4Wz8F3osVF2iPksXvRbpeFbEfDILcLU4cdvnYk87SpspVoIiHwEpUql5zaFlthKFAy4tHk6Kfu3TFct3z6VlGZ5HQ1XlGcEWpyc2qMBoZrAZs/f34GNxnebZhRE4pS56LY5dWMHm8egw0TtByRvQmjt79iDvYDRWAd51wRjshWsqlxYablOdskNWQWqE14UN8A1xrnFADeL1TfdMLrcX30ycvxfi6CscjbDXkIwDxhbEhBPrvbaDoOWuM7wxQGRELS0svXGkfF2V1DIi338yjEpE45Q0TjpPqF4p6waXYt8VZnMFAJh9U6VpC/ErfzToP72FqeRMb4/r3ULyi1MpOpcY4uirqjOdHmTygokjeYEkvPp8hgFepxN4nDjXkLkLMKoNyQYA0baWplcJGQKLsEct3W7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(44832011)(5660300002)(40460700003)(6666004)(1076003)(336012)(2906002)(83380400001)(36756003)(426003)(26005)(16526019)(2616005)(66574015)(356005)(86362001)(36860700001)(82740400003)(81166007)(47076005)(7406005)(7416002)(478600001)(41300700001)(316002)(110136005)(54906003)(70586007)(70206006)(8936002)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:43.8767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a1920-ac5f-4d6b-8f82-08dbcea75263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Add RFTYPE_MON_BASE that complements existing RFTYPE_CTRL_BASE and
represents files belonging to monitoring groups.

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
v14: Removed the RFTYPE documentation in resctrl.rst file. (Boris)

v13: Minor commit message update. (Reinette).

v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
     to Documentation/arch/x86/resctrl.rst. (Boris)
     Moved RFTYPE_MON_BASE definition here where it is being used. (Boris)
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 7412252f95a7..a6279df64a9d 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -376,6 +376,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b816b902b5c0..a4f1aa15f0a2 100644
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
index 5f6d6ba63a2e..69a1de92384a 100644
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
@@ -1867,6 +1883,13 @@ static struct rftype res_common_files[] = {
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

