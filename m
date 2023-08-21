Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771F678365C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHUXbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHUXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FF19E;
        Mon, 21 Aug 2023 16:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHQjjeV/WJT9/1QVif6mEEuW/s2c/70/sCTRDFqale+4YJFW9MRLJGUGSiU56MsH1V+GyugXFHgb4hU/qt6YrjvPv2kojJxhWK7ioXxuWJGKo5CLPEn7bbXFm1TpD59xzm1aXHOiCxQJPs/8H8Xmtz5aIVQKo4ZBRnspb8LBRy6U/1hErwRmwvRLNioXqKriigZgy2JQ/WYQUulR7BX1aUtdsAYQ0evTHIl7oy+Sv07380/5d73wmdaAWRqZavG3CRHoWYhZnOh15fEEN/6TEPbX0oqFr0eMM5DhgvnzAGmugLKaOFyGj59LIdxZ8HRL6DnDN/bEswUPoBBywLkCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5JaRJlGzVTLm2l253/kTdU+ipXbVl1ECpEphihZf7Q=;
 b=fZOQJFKEM107IJv83fwPIMBg9gIKZ//cIoQLHZAlYU16ux/sPjetk/eJ+lqawO1mQyUmNw3qZlaZ7CFUcS+AR4BrFIpWur6zISs64Ti3yWDCOFz5csnuRiBl5QqjvJphEZU3qYgyueMJaB/DH735WLfvnZUg5Ktm+ok0QHpNqEbFIcaMoK9Ncitmzj5CINKEC4ma5tQ4mo/Q0e1K5Wyn3Drl5wTBQtdxzRTpLow1/fTS2LoqBtZoFAPtFj2BhdnM5HQIBilb53FQyJtda0UixoMFjZv4HHhw8vSb2NdnI+6lc2IBLaBI8bqxdL6iGKxXq4QVlj7QnXugwkJyhY74yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5JaRJlGzVTLm2l253/kTdU+ipXbVl1ECpEphihZf7Q=;
 b=fiN/+YneJ/2bTH+0WbmAhbqXUOWdwuW8Qat7tsIZ0dZ446aRkfCMu+RF+we9RP7blZo5Wb6Yysxnx6XYvbHmIUKxmYfsSjc59oS+52M9JAt+wBTNVHhGAh/Tdu5AC1MK2avrg7+HiYOz9voUYvNuDQ+0IfyLYUSjG2j6OI91MgM=
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Mon, 21 Aug
 2023 23:31:17 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::6a) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:14 -0500
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
Subject: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource groups
Date:   Mon, 21 Aug 2023 18:30:48 -0500
Message-ID: <20230821233048.434531-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5425fc69-3ccb-4493-5f14-08dba29eb7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2EYCSbynyH3+ZEfijxj9nTKO7iEXt4OXv7ri96oFEu95VgdxuMpdIAX5sm5BvoYJp1j2fW1u5LnMyoaQBUp8iQgHWhCYsgI0WK4Ck6XNxF+h/fPcT/isnyDxpj287Ns2IrMKqqHf21L+gllx3Oic4Z/X6mP6t4VcCViwXUDfDd4ZTqXYuDJuroE2Hxcd52CemkgBDLaKusZUdM8YFvrAYqZ3Z/0M0funEGK0uum0yEYrlj0vqS0ogkdlUm/oDv9em//HjCDZinumZRSXkZD+fWikdNVd6KAnqY/vqbCjo5/GZPC5buScPFn1yxvDfYYJuF7JQ6Tjti7LfnW0eO/8LDckmLvN9gecV1uBzc83CJmChtS9B1CI6xERJYwkoAvNAtd9/FzMsDJl7w99pzHHKJNs9RR5e0lRBqERXV6tmJoJ9c542N+KByOw+QVpkggy4D+qh91XSABQl6RLzi1VUGjCUhFS0GUIjQ86gbAOTHCwsjQho3AxqCkmmcoWIyAJ7a6gw3I7JAspm9NUWnh+5suephfgZS0PUl9Ci/sopszSCC+R7gIJUWa6zYFhO3EB7VqHzKCP+UxdCv7bZn7mgi0mlt7bT/M53WBpERnOW7QAH6NBiSmZBQJObnwf5GjJbg3nnDSXs0ndk5H+eniBMy49R/4TrVK5MLmLOP9VYds+ERgT6yq6yVtmi4JSerjCzrGiNTMUTtg1v87GY68i7hURUxCLCgrftHpgtuZ9ys6rJEG6F3Hiaxmv5y+9IosZjuiO5rxzlIt/CfBG137Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(36756003)(81166007)(356005)(40480700001)(2616005)(16526019)(44832011)(110136005)(70206006)(70586007)(478600001)(316002)(7696005)(6666004)(54906003)(4326008)(5660300002)(1076003)(8936002)(26005)(8676002)(41300700001)(40460700003)(2906002)(36860700001)(336012)(426003)(7416002)(47076005)(7406005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:17.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5425fc69-3ccb-4493-5f14-08dba29eb7d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses CLOSID and an RMID to identify a control group and
a monitoring group respectively. When a user creates a control or monitor
group these details are not visible to the user. These details can help
debugging.

Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
display in resctrl interface. Users can see these details when resctrl
is mounted with "-o debug" option.

Other architectures do not use "CLOSID" and "RMID". Use the names
ctrl_hw_id and mon_hw_id to refer to "CLOSID" and "RMID" respectively in
an effort to keep the naming generic.

For example:
 $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
 1
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
 3

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  8 +++++
 arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 5a2346d2c561..41ad9b1f0c6a 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -351,6 +351,10 @@ When control is enabled all CTRL_MON groups will also contain:
 	file. On successful pseudo-locked region creation the mode will
 	automatically change to "pseudo-locked".
 
+"ctrl_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the control group. On x86 this is the CLOSID.
+
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
@@ -364,6 +368,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 Resource allocation rules
 -------------------------
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2fae6d9e24d3..3fa32c1c2677 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -296,9 +296,15 @@ struct rdtgroup {
  *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
  *	    Files: cpus, cpus_list, tasks
  *
+ *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
+ *		    File: mon_hw_id
+ *
  *		--> RFTYPE_CTRL (Files only for CTRL group)
  *		    Files: mode, schemata, size
  *
+ *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+ *			    File: ctrl_hw_id
+ *
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 94bd69f9964c..e0c2479acf49 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
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
@@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "mon_hw_id",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_rmid_show,
+		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
+	},
 	{
 		.name		= "schemata",
 		.mode		= 0644,
@@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] = {
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

