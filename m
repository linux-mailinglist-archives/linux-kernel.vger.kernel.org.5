Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AA797F68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbjIGXwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbjIGXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:52:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7841BD9;
        Thu,  7 Sep 2023 16:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmrTU8S8IburovfmfuD0EhF6Pau2ePGNf2Vn/+HmoXZuvNrBt13/C3/qSvL1xMfH9ckG0gI2a21T9r2h6oBlsdHGlCtX5TYOygS+qoGiBJ1p8LhUxFpbGGvs2/rc/SF52s5TFqXxHdh2GOOsoToMnKei292MEWYnlkukayFaIv75/hAzdyjdXoTFfH7PnoW3UQ0Hq8OMeebZMLhqwWqIBBgtcUb2AMWMcjg8dJBU0p2mFJ8604m87Mhu/5pEIulw78kNW+U2fW9PMEdUMOcN309M+RmnyQC5tPtPhqjSXQE/l1GqwxCQwSy37vPl8R80QXAXX5Ko//+q6yykO6CekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgdl2RU+FKn+Mo+oRujHJspSjN9Zd4ic02W5xOP+nHM=;
 b=TJ/6ZOV3lXyfsxL016D0LXMwoosJlXUZCy2Trwhi+D5m/pgLf22RgcwaxYXLH3h3A+OWNSNPOgG4oLeoUy5V/7es0QQcmE3ttcinZy54uM5X3wHFLxq6gz6JX2tqb/X+Qa3FleylhTI3UhO9LpKBexZ0dmBnEZJ50v81jLLRaPoym1B45O16TaRBTSJX74irMTqiAsxwe4gUMAFxOOfU6elaaZ+uP0c3p0+yy8o4cEP1h41j0a2V6RDC7nNyq7g5QVulnkPqqn/sP8rDuej14innOy2ECt6ErkvU0P3PT/s4RAXlssqvsjGvx5J+AV9A0Xyo9E5rZwGMRhe6w9Nakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgdl2RU+FKn+Mo+oRujHJspSjN9Zd4ic02W5xOP+nHM=;
 b=X5kzzfd8/n1S2gACs439/zeP5NKsU4EulJ9/PCs86E4Pg/GY6SnVYlFIM+HhGg7vWu2kraRKBkX1Q5H9fz/YA0AY9gUHY8qPiAuYlCsbJrLtEC4cKhxEP831NhWAzpWrc5iRUqGIvvkwoSJebXNN77T+8ejVs/xAmp/J4EbAym8=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 23:51:50 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::9) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:47 -0500
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
Subject: [PATCH v9 8/9] x86/resctrl: Display CLOSID for resource group
Date:   Thu, 7 Sep 2023 18:51:27 -0500
Message-ID: <20230907235128.19120-9-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907235128.19120-1-babu.moger@amd.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef23c17-70eb-4ea3-d2fe-08dbaffd679b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iS9VIBx+YaAlac6H0SCgw20EiJ5YRU/1zxblh0hugGPF16CWDHw1S054O0ak5T2VI1ZvZJxbi28WwYebuwmq2NMrkiPVfGYEzfJctWkOYy7tG6WhORjkd7fHaa2rm0j00JCbbX2NYzYmlHMlOsQ9sobmd15XW4zdT0gUwzux8K3aY+Pl3Ql5g88Uv9FoE1tpzxMIok4xep8RSPxxELqAider2u7YNb16jwFGsqccC0IvHWFRTyrgcJuRZg7EQszy2vypEiyi4OKLge6xwRZsC1fNyOdSl22veDAUu4tuOkX0b8Y/kfwaxpDVOBgMUsZhttjCtGsfWMgt5sMYFj1mj2K1yKJY+zkCjj3XBA8jgSiVGyjuYNcZ0ylRRREiuMnK5XWIcNPzGSw1S1GGZEbyFz0TG5BII/55jhUrO91F100lfVyGq1VCn6lhz7rn8zpF71+cMtyyESDjnACckw5v1+EErQ5LoMUQfDALzE1i7Ea7HauIEW+Rr+zGb87l/QXcFdD0DbjXpa8aPincYVvJiJ6sX7TtfaVZphl198gBPbPiiGc4JAdKfDhMm7f4cfqsbgO3sNy/4vYIQytDOiYbRJC+Mrkzw3MGoLmb/TUjXQ+5Hk3zPStgI6sncGBpynyLcFG5pPQPBDNw57HDnR78p+Nh8T6r8GV0bn8hHoqfgV2QlsZDXw85uUZfGMsc/OEU5sjkXP6TClZb4BS53WvL6bMLYPq8PQRe/PddIqgEPgwFD2KpvTUBVj3brGtuG3XR9Lg5o71/1fEXk7KGuFDnyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(356005)(36756003)(36860700001)(40460700003)(1076003)(40480700001)(7696005)(8676002)(83380400001)(4326008)(6666004)(8936002)(5660300002)(44832011)(478600001)(16526019)(336012)(2616005)(426003)(7406005)(86362001)(41300700001)(26005)(47076005)(110136005)(7416002)(81166007)(82740400003)(2906002)(70586007)(54906003)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:50.1971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef23c17-70eb-4ea3-d2fe-08dbaffd679b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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
index 38b99a21ccd8..ccdbed615d41 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -299,6 +299,9 @@ struct rdtgroup {
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
index 67b315f3a26c..8be0fb323ad3 100644
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

