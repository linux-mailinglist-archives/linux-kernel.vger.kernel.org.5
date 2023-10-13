Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38E7C8E55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjJMU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjJMU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84E123;
        Fri, 13 Oct 2023 13:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeNZLJipuSNDLFagKsN5x+Qj0gWKlym+ujRepUm+M7QF8Vo170gf6H0Pe74LoEz5GZvbdRsSCQUWaISFnLdHy4OredoJa9GD6M4c5ZEan+0GD6JEpNyMmrDFFtK+hsoluIrLaLrPSK0iPpB+Q7WpVp7ha29vuabyAjY5itUmq9ZdQb55CEpBI5GWLiSkHQpEQsodeCf2g02Mo8wf8bCApTrmxeeO52RFlvHNSm5sRRJTruZrDyrMKxTG3PwPStrzUa/OkrF3JSv6eteJFqJHCeLY6YkhU10/XvCybxvqg145lm69WcXOTz1OB59prdhCESon7iOU5jhNdlz/lg1ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzARhYoRMczK9QFOxyv7dr4AjVgu5stMp6ji1D6r8gU=;
 b=InG6LTE2gjKkPe+6OuyOEacmKQ2XZAE78NOHUiFQ5OGh2FeImhz3BqpJGiYttwTjWjiaTzBnse7Lu1MrgTRdr8XIQm3CyYRL57NCe71VfxaoSY7Yiq+PX247xPsZxm0qliY5fK68M0l8EHTUF6dzFq9nctVVhyJcY/boZFvxuJQtZYBX+9zWDaoyu/IVNTnCGAmibriyHGTAtzRTpDPevbY2kFyWAnrXvbHLhAkWXtgTUL7yRxgoejGLMdKnJEibiZb6peIDEgh0gvK/mCtmAxONy3D3uX9i0g32OipOLhml2B/tsjiVy1WHbIR3Z0pEkj2don0C+3TLtwYrcLk9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzARhYoRMczK9QFOxyv7dr4AjVgu5stMp6ji1D6r8gU=;
 b=y1D4R2s3gBdm53SB+WmfemTdhuQMCbejUCxowrVH+arKqjEQ4SxU6F0pAMtRwdP4dZZ8X5n43CScx530IeTmaOk+TYeLEgEhVOtGNEricBQ3EX0as5yP2+UIQKsTLD0agnc7+SOnKxWXxEJdfhKjA2f/sSOVeTU/EpXtBeYwmws=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 20:26:28 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::8a) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:25 -0500
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
Subject: [PATCH v13 10/10] x86/resctrl: Display RMID of resource group
Date:   Fri, 13 Oct 2023 15:26:02 -0500
Message-ID: <20231013202602.2492645-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5767d053-29b3-4268-0f13-08dbcc2aae0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVVN/rE2DclXL80gzo/Tg1Etcycz+ZzA2A/1wcTAWgZfcY3v2VmiqVaMa5+hExbUjllXvCE+Pa65tQupiBgPj4hqWHwEZRIBOeTHONh2Yf8GyOoLXQfb46JlE0Rfbg1QnOQ7SPY28vwdNW95MvD/tNe6XO73Gqjl5hS3OHiEEBWT9U0larRFA5wVm5VoYe7DgPsz8oa2ipxckBmDpZ3Zo3h5j8VNrbiw2VVqmvYhjGm1LyZwe7VEYy4bZwSMSwC+XRROZlvWp5SgFBHOiucXcECbcDIBtV6NzoST0IbGoNcu7KTQPLoDKsBvtQ7o1m9FApuEyUlHMYvpezhnS3VqujGeTb6gZFYsCF6RyYM+Dfz5KvqsXf7XLWBmE+XFk1lwXWTA6Vj507li4NwPO3Atl2dt2cq1jaG6Wwdv07abq10PURo9Q5duNq6isZHwEs4KNPKoZCJT3gl02Bb46tKiyam3J9MJfUNzyLAo7jAAOid4zHmXJKL6vfQ6ng2/aE8OdnseJMaxozcSPH7g0rr3DIMW0XfJvSRBipUr33i1/UW/2vI0IFVj3A2ccK4c8EodjE/ioEQLnqRn6ZW7o040cx9XembJtDTG5Np8mJvCrEgYxQA6IF/yIYaQZp3DKRBzT5kyn3TlqLTEN8Op9WybinAiCi+Y63O2kxpUTPZqeUbUx/3087Hk1awv6Ha2sRCuNM25QUmAiG6xVsTNnU/n5F0B965xA+mgBDpSo3ykn8j86SOSsikh0M8OOJA0jqRj+uvnYPFmKYv/AjsNXvrGOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(7696005)(6666004)(356005)(81166007)(82740400003)(36860700001)(40460700003)(47076005)(86362001)(16526019)(66574015)(336012)(83380400001)(426003)(1076003)(2616005)(26005)(44832011)(8676002)(7406005)(8936002)(41300700001)(316002)(7416002)(2906002)(4326008)(5660300002)(110136005)(70586007)(54906003)(70206006)(36756003)(40480700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:28.2969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5767d053-29b3-4268-0f13-08dbcc2aae0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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
v13: Minor commit message update. (Reinette).

v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
     to Documentation/arch/x86/resctrl.rst. (Boris)
     Moved RFTYPE_MON_BASE definition here where it is being used. (Boris)
---
 Documentation/arch/x86/resctrl.rst     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 07225d9c0b0f..d1538b480b22 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -376,6 +376,10 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
 RESCTRL filesystem implementation notes
 =======================================
 RESCTRL filesystem has two main components
@@ -440,6 +444,14 @@ RESCTRL filesystem has two main components
 		-> RFTYPE_CTRL (Files for CTRL group)
 		   Files: mode, schemata, size
 
+		-> RFTYPE_MON (Files for MON group)
+
+			-> RFTYPE_DEBUG (Files to help resctrl debugging)
+			    File: mon_hw_id
+
+		-> RFTYPE_CTRL (Files for CTRL group)
+		    Files: mode, schemata, size
+
 			-> RFTYPE_DEBUG (Files to help resctrl debugging)
 			   File: ctrl_hw_id
 
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

