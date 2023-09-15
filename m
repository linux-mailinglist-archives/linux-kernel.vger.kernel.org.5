Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C557A2A84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbjIOWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbjIOWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945A269D;
        Fri, 15 Sep 2023 15:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Coum9UpOAVkEgHjAoo4L9FvimIldMWNubG08+/Th18ifzg42vSt/rxgCRgFQK9RaSDa+9cSRLh1OV8/LuRekfRWTx3wME0/4Ehr7eLrgiH4CTT8/S7uZBdpTbIjj+3wWYQddm03Um1JbF4YCRwKGSfyOZZ1B+jZdNcP34jsLIUduzVaYOu6zJd3RIWRk3EgIU2KKOrP0YH6HLRxXafZmLm0mpDQqfcORKr5PciMqDQ4OPI8iffliO8CAoN6R56zxBkAAvfnjtcgr+li8i9mAZwdieI9SClEsyZRdvPHrv2HDZgWbMgfi1ct90eLtDgdI5m0Znx6OdnBM6B/BNK9DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/p/sKy9VU5qZCE4fZmT/UyLRX35DEIdmsn4W41jxy0=;
 b=P5SfQJMueaTh/It3HqkC/Yl3ZpNWJZxwK8XdZw6KxWAZ4RjuTyHdMHMHl9su9B05pGVi28B/ThdKBabkN37AwcThrZ2gz/6CcKvIU40H0Hwj2vXxV0lUOsCul3hVlsX7icA3T0b2dUbl+iDduBWojHMF6c7fx5RMaBO9znQ/wqgXDpmpLG8SWmnlR38YO6DbiQJC/u3ubDyBT9r5m/QTS8HLMaEyggOuiVQUZqXdIBe034mKk6LdvbEUnxshUjL1ZlqbWEQzRc/azmXMxY6v9YeT32pTpZqphar/ANAVWBCnVdM8unTFUqVfO8ZNkYyYYZd1mXobd7pao8YnPqqslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/p/sKy9VU5qZCE4fZmT/UyLRX35DEIdmsn4W41jxy0=;
 b=HAJ5308uyc+3hSx7MSmwvf4vPE5vWB0emKPLBb6+mdK2B0V0E69VUVY06PGeQeNoVZugUEOl//rWEafC4Tjls4B50LB8cxtYt2rywX/+nzpxpC/xHrLBrYIcDYSeVgx+E53vYh8/ZqmeJmMKXq3Y8CpbZuN/LhYBOW1Og+9HbB0=
Received: from CYXPR02CA0038.namprd02.prod.outlook.com (2603:10b6:930:cc::11)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 22:42:52 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::38) by CYXPR02CA0038.outlook.office365.com
 (2603:10b6:930:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 22:42:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:49 -0500
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
Subject: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
Date:   Fri, 15 Sep 2023 17:42:27 -0500
Message-ID: <20230915224227.1336967-11-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915224227.1336967-1-babu.moger@amd.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 642c61b9-e66d-44e6-ce44-08dbb63d1834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p29ulDix2ut3MqbKemMjmntNx0teSWUcymMG1A46ZVsOE8EIB2RVT4K1FMSHjleo1KaD/6Jd6ifU4gSqSJ18jxm3+bvvxWRlAUeTFpc6RUOSw9sowsyQCnCRDzwuCPd1AzAaACcYXPXifVoiSvg5F9Fw0Tj8zze0nvgf7JwoW8aHDg2GzZ81UOKW60yGxpxCrZI7PyBl/kBr5TaRMCP0UTeB118Le66GaMXi9AdrAOuZJ4rvjx/D2eYHNPq/wj6MjP5TprThrYq0he8+txEC9JVk/2s/BUkEigrZyB3Y6X/B5u1w9t0gJorU/wy9h1DYufkklkMNVNUa+J/ouoCKJaML3MzdBDr1uxFKzu3Emz9t1bcgbbGmOATz2fVBL7/5vLQQ/gZnpWJEvo5j5HHif4/bLGTjpvVVcn7SXFC/OkJ1oAcJwqG3aGYUct2D6rSvnCzr2XDZpUdgtTeUH8qInWPeWpO8u32011Td5bVzUePMBHgEMjtHGNTiZgKoLh9Ri3vYqjQTh0hryr2On33ryU0xQlKBYNZVt1iCRnsupWkEasJ/tM2cTW+2/myqDodlJkZ8w7tPptAoPymYPrnHdDtsGCzq3MTc/+uWyITvSqiuaqskGiGuI7zcjmD/R6hgWkdCKCvw3ij8CEWDZ49c5USkFckyw8dL4X87cZ6suT7CytP6s005/ELJBqGwbH4zl7iDK+FvWUkz8lELCxtwxlyMrebFl3T7l3DDJ8wS4Ipnd8/vYKYWssc9K2v2KFAstspOCgmXU7s1aaYJw0AHww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(5660300002)(26005)(16526019)(426003)(2906002)(336012)(110136005)(316002)(70586007)(7406005)(44832011)(70206006)(54906003)(41300700001)(4326008)(40460700003)(8676002)(47076005)(7416002)(8936002)(86362001)(40480700001)(36860700001)(1076003)(2616005)(36756003)(82740400003)(356005)(81166007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:51.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c61b9-e66d-44e6-ce44-08dbb63d1834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

Other architectures do not use "RMID". Use the name mon_hw_id to refer
to "RMID" in an effort to keep the naming generic.

For example:
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
 3

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+)

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
index a07fa4329b65..b4910892b0a6 100644
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

