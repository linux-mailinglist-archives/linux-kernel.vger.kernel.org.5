Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655D07B758C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjJCXz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbjJCXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B419E3;
        Tue,  3 Oct 2023 16:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+JNu7g8+XMZAnYdSnO65ha5mtZWbJi6PLFczWIDxD4b93d8X3Vol9P8kTeg4Q3FTvYyi7JEU9mJHH9V+YMT8Eah+w8bQdj+bIYZ6byfiSc6OR9pkeRVtOnHEn+3IvRpPhqo+otkYDE+Od7nAFl9R+W1KQuJu5k1DHcdWkBPXzb2eFsktGP/idsjOuI2ZW6ICOrGYJWfqGeyXSqR+FgXpb2Dp3I/Cjr9xHGHanr/0OiVtFnt4Sk78fyPQ+qbum52pdU9nW5sRNAog6s2yh+D9bfpfJJPCQ6bk7o5ZhpSYxDB8DK18ZHwh89mBc7I9nxIZeAx/JuZU/vBuNX1vX4AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=389FH+0iegUEcr2EbdZbKnrpgBuZjnZ4KaMTMilD9/Q=;
 b=lWZq+tRuVIIDAmyyUZJFpJRk58ot8Z8QPl3t0h97TnoNQTG7wd6mfj/zUmoJFkF9ZPIWodxtLpBxyyLaT/l4XZ0T3W7phAlrJ40QZqtErduLqXG2N5kOgVdcMBfMQDzWSpQSTl78LNaxnhGqE1sXQChFZ4S8TjaIKiEhiK9p91LmeMxIMKpjj2BoN3F3Qcqh4ZFbUZya716YvnHJKKPCm5cOfavktiGI+H21K3JnNdZHwT4mXTB3kJeWybB8SmQMtBJx3EZuWl28rX8hON7iS1sD7MrQGSwF+R7OHUbXtHurcnwAvZaUIL8X1dn0KSnD0WluEXNUoUOCP/wPBsIwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=389FH+0iegUEcr2EbdZbKnrpgBuZjnZ4KaMTMilD9/Q=;
 b=OQ5KkGJZhSctRViV2lZGWTDv17Mf1HUiLWd4/AznCTPSEkJFmNlZRhbwLLuHZkZPA+N3wMqInPYs2pm7qjDcV7ydwom/Hkosri8Rnt5W1tn+rXCiV5bqFxjPRVHNsLtgaaQwJsrlsJ+qOQgfPvwpnUGn+MECaHZh23hcHUqqJX0=
Received: from MW4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:303:b7::22)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:54:58 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::54) by MW4PR03CA0107.outlook.office365.com
 (2603:10b6:303:b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:56 -0500
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
Subject: [PATCH v11 08/10] x86/resctrl: Display CLOSID for resource group
Date:   Tue, 3 Oct 2023 18:54:28 -0500
Message-ID: <20231003235430.1231238-9-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1f5b9c-5981-4b36-890d-08dbc46c2686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFeR3/wJvs34OjdG/EmDdVyBOII96K+X3nd7CvY0HwZqViV8MP9V30K8GCjte4qUupp6FY7VbTyhZsT1H/pWMW7cetpmYWYUjTXs6XZq9hMSh++3h/jWhXPN/uIs7+k4gShlpgXDhia1J+AYOPnM74dB8zKPbv3HKUu0Br9ZxqlRAS51dwT7D+DZej6nmgrDGjMAnDKwJNfNN4CMdT25naR9fbw9wl75VlNTKmp59VYy8AjOiMdhCZr1vXFnQQjqBP3xEsYVdkx4Ut1UYq3nSQJZq2CqfNyaLdVuyxe49x1y3wSJyVy3++oGgJX4LBvLBirdfKsOW2/zVzombGNbQIMGynczmnUZk1kl4+DrswgeAQY4rR8Q6GR32cSkBaamiPsU04I8WAPWyxKp8yv0AlRtl76jTMP1yKapughcn+OHAjkfz3WmmYw/1Cu2g9j+XJfJCiYDcZqzpyLS1yfEQK4vtFfwcFejCwq+mGLLSR80R++A4ZcI1rWAHG5/8dHni3Sl9rsHiUVjQsl/JmJOHHJ/8FiE1ieTy4s/fs6Ln2GicGIx6RqUvRhdtkecvK8u1nYDok4zxJcFpx11GTJfF5wZAcvw8/trF4wpzkGe1hLmMNdDta6PG7XI+g6QBjYOYUtvK/NpuisbQy1oH+bnfV4loTP1uvoJ0ELGyMfYVe5VzVL9X126s4Y1DuhqGo6MyMG4Jy4Y8cQRncLmvygGjNpuSFLr47JWu0CCmtB0BYzLVuGDVoyLQO+zmVeEHw92DLd7csKjTewWJd+DLhHLpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(36756003)(86362001)(40460700003)(6666004)(40480700001)(66574015)(16526019)(83380400001)(478600001)(70206006)(70586007)(54906003)(426003)(8936002)(336012)(41300700001)(8676002)(44832011)(2616005)(5660300002)(4326008)(316002)(26005)(1076003)(2906002)(47076005)(110136005)(82740400003)(7696005)(36860700001)(7406005)(81166007)(356005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:58.3357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1f5b9c-5981-4b36-890d-08dbc46c2686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 28d35aaa74b4..54691c8b832d 100644
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
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d68f947c5a64..eda5da9ab81f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -299,6 +299,9 @@ struct rdtgroup {
  *		--> RFTYPE_CTRL (Files for CTRL group)
  *		    Files: mode, schemata, size
  *
+ *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
+ *			    File: ctrl_hw_id
+ *
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
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

