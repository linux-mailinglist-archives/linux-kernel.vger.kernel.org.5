Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2567A2A85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjIOWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbjIOWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629F268A;
        Fri, 15 Sep 2023 15:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbXS3iqFWuPMBlB7Q0++4zWi5fkHa9f+Jl2bwUdOzSUU6HP5HK5ekzhbmHWsqaZxTjxtLy+WVXIwjqhZFiVNttRqc7Ylcam+v21Bjup/I1DrA0xJd0hnDT8YtLFN5trBJgUxtkjYvBEoQA4GCSLFf2nTOEFdYQqUkPGVZ6KLPybr4TMeg5VZMmqxeLqcZSc7Iu4IOeJbKXuPC9F1UxOhqsfXKiodliZCAQw86zOjuHVU8fFnL9WV9ujfhqSgzW+P580UUCByGeAv2Z3bF3ABRYjSWctYFdypwJMALamHd14EtGgqaqpppdttoRiT5kIwjfuLt9E24J7FFls1MpzVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hW1sH+uy2BK99NH17UbT1ILqKzFbGOj2VAhNTqgB5I=;
 b=JOy+Ek7uNxFV92ryRt1BiPb+yFdccYcNpDtGhYFL4G9E2ngUwRCyJGsTWxkkWT85Wd4xpHzEKUwVFsO1ZtXK0Cq6h3iOCwTGf9ywIe/1qa0v9+AMJD65CC2BPh/8btVPSgqySDcS2eazQER9Y+Woz9RBTTurud6vTxb9WN+PKQzQ3glw9d4Q5DRRc66BWP+Pn93lP4/fGmWe6XRGsJG4vIGDc2bsLssnNyBucBmULhzjE5+bXfVsp0aNGDMeFUc5nfhpFTm0gqC4g0kBfT0P+o/IgY1XU7G++CveP99F0zzsUD8PKRHwsWMj5Yx6KcF0mUOxFB/yWzQGRYjrYYun8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hW1sH+uy2BK99NH17UbT1ILqKzFbGOj2VAhNTqgB5I=;
 b=xVGlb9GgCzZC9tFWyCtre/AvygzRPtW6z+esUWC/Ch2D0GVTv2fqowVPUhLI9X4/QdyvwNyC2jDeikm0kHT26mvhH00twz04bBgRt8emsADZ4EVan6SgaA8n19KFNk/Kc7GpCC4JJrJiax8WkHb+KdqmtI0MRGfWOYWOE9GnfJo=
Received: from CY5PR22CA0097.namprd22.prod.outlook.com (2603:10b6:930:65::22)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 22:42:49 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::77) by CY5PR22CA0097.outlook.office365.com
 (2603:10b6:930:65::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:46 -0500
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
Subject: [PATCH v10 08/10] x86/resctrl: Display CLOSID for resource group
Date:   Fri, 15 Sep 2023 17:42:25 -0500
Message-ID: <20230915224227.1336967-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 31367151-4061-43b0-8f72-08dbb63d1653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWL1pRb1dpImBO/0YWeXXA+kkjJM6FJdo18QTmG5DMPPbv45ft7KIk36tgicdEqSY0TXhuLP6cdvg6kjaasqDL5ZaJMc/cwNMixE5mu/zHelWoE3IjjtObak6SpD7IZgRK0Ma/oLhCgLn/A44idtMR9qfVvUYTzQ+JULhhSzloLyQTmgOcwY42V6KVldrg38O86DoG9Pufkt5E6WHuUZayryC5++svez52dpb2wDswZKZseeQ3avCtPnKraxbmbYJSXW6jlKwJVjXF93EV9+gld7iFwZouWn+X3H3WSIrnCe3jLC65YTPvjyLpvxQOABT5eVJ8PrysL1qS00UjRz4y600YLDKQcVwLDgj7hD9NI54KOhaiUiugnYaSFinCcW5MXgIPEHoTtLmZRAK69NiApjnPHxr0wvSK94XJvFFcWDv3uv3OR0+PIqSEb9u10sARP3zRWABk4WU1X6HYG//JMyjkRJrRT54/6sU+MkPkP8ZbS6SWQ+KhvH1s9HSXfKPEORf4+pw0uS6CFJlnoOYhfHaxl1lUYsWGSZ553Rrws+rnE87G48NH4aUB5vKYXUsQCZY7J/ojeLC6S9NBu2FA339YMLuAY9na3Hp8qYveRjgJpIxM+ysAd/QCEVLpJYpK265qQLTq7QpBDZcRZD0kh4qXKqeO76hshuLM9Vd/PO8SCDOtpR0NwhIgrTs4+q6DcHwk2IBxhbfM6ilYqRtyi2VjoH+4iAKR73dQxFSaj9rFDo4IwgbIyZElZ7c5NigwXrbsLMM4YVQvOyumzruA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(336012)(1076003)(7696005)(70206006)(36860700001)(478600001)(83380400001)(16526019)(110136005)(47076005)(86362001)(356005)(426003)(26005)(81166007)(82740400003)(2906002)(54906003)(70586007)(6666004)(7416002)(5660300002)(36756003)(4326008)(8676002)(316002)(8936002)(44832011)(7406005)(41300700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:48.5954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31367151-4061-43b0-8f72-08dbb63d1653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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
index 68d1b7147291..a07fa4329b65 100644
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

