Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A027CB763
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjJQAYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjJQAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:24:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CB111;
        Mon, 16 Oct 2023 17:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXX8eBeQdKMDeNTIjT8pkx2sF71wglgcgoKUNe8Q6CU8zDI7XEgal7nTzX272myr8ERB8Y3GkLGHNgZZ4De6e7moK+CpBxpsQtYPH354ctRmUh/yDOkWsopyFuIqwHXvvnQ4JaNJI+P0p89LHLPXsIcRw4lpwJVQVJ7P1VWEvR8ZuC6woVWXaTkuiDz4RuPzEFssvN9cLWBpdfh/ZOEQ2iCmhupJ7oF+L6aoymC7kHk9pf0WMeC4zP+jP5Qn15QDwAT7ZU+b+d9l6//EjHppUFXAMK05wOzgBKs9doB9AnFdaFVG/qkSdWAYP0emYHfFcCGI0LXD61KxgIFLP+jTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBTEOm/hDV81wZcytveC31QBynHeX0bfTtvjtU/RPiY=;
 b=gIVNTTzV0GY1A76TlKUL8pwR0zjN+CQUEN7HDQ66uLCHyvH6inAuUKZdJwxgPkeyYZRQM+fimXSQU38BQIUnWHyVvhyRW3+zedLWKkU4QePNemSq6EZE3wbqEwTc0rQ6DITBMfNDBPKpOLBZOectT2QEbqai/P+QgJzk8DMexUUNDH2KxqQfFZVgjkfihiQMZp91A/taisrse26xX2SJFzDqDXjSAvSCPmPuRPI9tPTM1ENOPAg9xakOI9LdaUDYGShcqX2okefl3r4vMMc1bljocliHvbVKATTiTSFie5B0yJBXZmEOG5ndx582eWXvvNKetRvByE2f8kErFR73vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTEOm/hDV81wZcytveC31QBynHeX0bfTtvjtU/RPiY=;
 b=gQI+ALKUEwYW3g4CD9KyAQK9Swf1dC9WGjmxu/4Gj/DQIVtamqnAJT1cYTBgVSEZsVb66B+l9/E3LS2xiBQHxcgiQZXEgknXYFw+r5VjpJ2vleP+IDWfLFAYdXb144noIhclZyiYbm49BWTonB+IqIKzjXQ0aHqmbfzjB2aeuBs=
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:23:40 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::7b) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 00:23:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:38 -0500
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
Subject: [PATCH v14 7/9] x86/resctrl: Display CLOSID for resource group
Date:   Mon, 16 Oct 2023 19:23:06 -0500
Message-ID: <20231017002308.134480-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: ed98e4fb-d8b1-4bf8-f7f5-08dbcea75043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6Q8cfpKOtiVOwjcFn6BHa/9SEGO/ZVI7vvxkImIN6vEu/NN+x3cEECoBZqiORnCObbhZ+UGVCjsy5JEcp3b/QTMmvNZAWPWghor4LoaDjpAzjOrOPFJ8ZAothrARdCb2mk4fANe+LhojwN336f4KLpmArtR83EtvhSBRaHrUi4eIU57pP22eab04gk5Xp6hdhklAD/wYT2LAxkj2OjuuaVJv68r0dOqrjFV98Gl/wmNJwj3Y3/thZTtE1Yv+kOD0Pz8uG5iZbHgnUHnEHijhngTMUzXtItJwiXvxGMidR+3eUaozyGabjpdCrLZsgFxtr9wj7QrDQVOmujXdDFfDplpmfZskNH5F1OPXyNg9AYZv3k6FBM6v2M/85QpwLKHBqRPXH6m9yyNoiJiQCprr4zd12p18/U6kveoMEJebl2c4x4Q5VGscyoyrrHYSClACrJu8Jf/+AG8n8hoChPCDIe1tyPE1GDAZ0TJpUXeBMCWelkIr3yd7fHAvVvWnF4kzBcTNl7PTOvbDXRKyY0Xhmz6f1WTs11Q5cq7ig2DTOvWJWJs+vJF+DWodUZcqXH2vPPWzAbMBuh2DhS/MbB1Cm+nH0InJtmL2FNefRH10p6m81U0iBgPjQ5Z1puzOVU4oCodKDBNP+mrSG1th48DlKNgq/Hnf7uIpd0vxqnJwFNNWZxjwVAuTBLh0sCxsJGiDqTwtVmipkOixriue6Gg1Bmxji0Li1ChVHmtVAf2P/+tY0VwgjJtuPwTJAMfK92RZIojvuOaaOKbvSmbTvy+VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(82740400003)(81166007)(40460700003)(26005)(16526019)(426003)(336012)(66574015)(2616005)(356005)(1076003)(7406005)(478600001)(70206006)(5660300002)(44832011)(4326008)(86362001)(7416002)(2906002)(54906003)(316002)(41300700001)(36756003)(70586007)(110136005)(8676002)(8936002)(6666004)(7696005)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:40.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98e4fb-d8b1-4bf8-f7f5-08dbcea75043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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
v14: Removed the RFTYPE flag documentation in resctrl.rst file. (Boris)

v13: No changes.

v12: Moved the comments about RFTYPE_DEBUG to resctrl.rst. (Boris)
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 68f11611f341..7412252f95a7 100644
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

