Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E548000B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376856AbjLAA57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjLAA5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD2172C;
        Thu, 30 Nov 2023 16:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrEwHHitFhpocL4aFLo+IZ4ook/FNlt9XVxz7G0/QHbGzDSfzWRkb9yXQwTR+xcYi1ekziSkp24s6MOoWVFchNED60+IKNKx/joT+Ygpq00V4qIw3hZgeopcf0pPtzepK9nhtHxU0nO+mnAOVx3bKRwb59U0sMCdI0HPhhnnft7SQ4xKVzj3nlCUZo03M7pgxh4MVzyvAJBT+twQW6w6mytkCZHOEX6XDDM/O8DBXDRs5fXTJaTUU8kSvVSPXhyKc+7OctOjHck+OJljSjbE0XwAd9uohc6gXYc7+FORV4dwUXBRLZl/UkNrZ9RG983NW61GnM46UXi11gG2u1AQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgTL1J5pdOe1QBZ7AXIPSwxtnTWTGgPBIC6MKEUG1mc=;
 b=T6bCGXz1mBEchsR+mWP1CsCEhM5JDGenLXFkmQF84w9DBtqwJBaEuDvJ9YXkI8EI6puVCu37w9seykJKTusrUZiYsbx0aOsfBIZb9M/kZy09JnI3RTmtyBb+B7JT6EHE4vMfBrsHFhZLHBNq87D/XsEwc07phb+NLM+j508ns468Mwb+g2e7hVfbUrxh4MqmWL9RfqY8dTG+rj29HquaZjaCPWfXKdYJsHC7DOev+veODc/+ddlBS6jelSiF0kY4/k4ASFJS6XIZFUqtKbSI76KVWfMPRhLQiMXIicJd85QVjLkOb34BvgdYUhuT6uUw7/AIcPrwiA5Vu1pS+yOG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgTL1J5pdOe1QBZ7AXIPSwxtnTWTGgPBIC6MKEUG1mc=;
 b=nzJfEyivgdKWVdAZ1DeipPqDC2YuQchxM8nYKFgIFpsq2GGcpe+6XtOVRP/xllbgBZoEQpJP0eJasVnx3aAvM13H7orwiXeWTu3ofbHaN9sMapK5pPT3WL+IjOlFSXQwiapRvaFzA3BV19JCbhUdt0Mmxx5h2o495VBV1QBOoaE=
Received: from PH8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:2d0::15)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:39 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ce) by PH8PR02CA0023.outlook.office365.com
 (2603:10b6:510:2d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:37 -0600
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
Subject: [PATCH 07/15] x86/resctrl: Add support to enable/disable ABMC feature
Date:   Thu, 30 Nov 2023 18:57:12 -0600
Message-ID: <20231201005720.235639-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a322eb-2310-4d2e-de17-08dbf2088416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp4Xob0+kJEJGWX0qpYxIQNJxJOawQp1vwjIpU/MBU655LgnLxsFPr569gPbd9azbX0uwC/LmKlyKP1wFvnAM25L+e/x6og9CahLgCLNvZ2RNtewINxX286iVsFiEtGexqKFM4w2k5zDStHUjEz2DuD5h96cya25+N17f6MXOjLuWWg/Q7KcQtEcj+KgUO8zsUR09NImj39xpLbsOulqdRzJihBjd3KxFPXuJoPJnAF+U9mH7QW7UABX1QQJrkddniNiqIDauEXW44LeHCP61fI4kSqBhUtR+L+kBQwYuvXuGPGopLaTJ9GcGp26CBYuClzOXzYQbkXagZK+5JG4P5IhN1e5HjY7rqKnxvFehBHN3HNLkst3f7SPZserzG+mEPOd1bG+YRyYiYrsZxGFtrg4hp0B9lQMFoOXc2qyDWFyhMBjm3J7Y9CGTkWcvGRrx2VkJ5qKx4z8LDqseBB5j1yZ/1vuNoCYQcIurXbtE/Or3f7++uNdRYjDwqj1xG/Qc4bfAYYnUMEIkcczayXOInBJZFyNCeT0rdu9SI1N6hQrhRH1KtcujPoy/e8XtuPZ4e2xZ2FbyhY8vDplGDXuFoWswMgh3Z8xXrJmTEXodNBIJ6n9k8kSLPWM7BcbZK9QQSjhiIoWtKEqQZty5n71Eybm7R6O+09CvS7G0ePkqhQOYozuQX+DXop96/2OopnTTk/vg5tAY0hVo7IbpxViOgmbzwBOT9n+Rc9P06fP4e6l/lUcV+Pwn7L1cDbVz36fLKHbt9A2vAjCic/p6RcCIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(83380400001)(26005)(1076003)(6666004)(7696005)(2616005)(47076005)(426003)(36860700001)(478600001)(44832011)(7416002)(8936002)(5660300002)(8676002)(41300700001)(336012)(2906002)(110136005)(966005)(16526019)(4326008)(316002)(81166007)(70206006)(70586007)(54906003)(36756003)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:39.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a322eb-2310-4d2e-de17-08dbf2088416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the system to enable or disable ABMC feature. By default,
the ABMC is disabled. User needs to mount resctrl with -o abmc option
to enabled the feature.

ABMC is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG. When the
state of ABMC is changed, it must be changed to the updated value on all
logical processors in the QOS Domain.

The ABMC feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 10 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 79 +++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 737a52b89e64..a2086aad580c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1123,6 +1123,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b8f3a0b1ca41..2801bc0dc132 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -50,6 +50,9 @@
 /* Dirty Victims to All Types of Memory */
 #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
 
+/* ABMC ENABLE */
+#define ABMC_ENABLE			BIT(0)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -395,6 +398,7 @@ struct rdt_parse_data {
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
+ * @abmc_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -410,6 +414,7 @@ struct rdt_hw_resource {
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
+	bool			abmc_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -455,6 +460,11 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].abmc_enabled;
+}
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a4328e12a8f6..7f6ed903ba17 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2365,6 +2365,72 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+static void resctrl_abmc_msrwrite(void *arg)
+{
+	bool *enable = arg;
+	u64 msrval;
+
+	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+
+	if (*enable)
+		msrval |= ABMC_ENABLE;
+	else
+		msrval &= ~ABMC_ENABLE;
+
+	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+}
+
+static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdt_domain *d;
+
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
+	list_for_each_entry(d, &r->domains, list)
+		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
+
+	return 0;
+}
+
+static int resctrl_abmc_enable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled) {
+		ret = resctrl_abmc_setup(l, true);
+		if (!ret)
+			hw_res->abmc_enabled = true;
+	}
+
+	return ret;
+}
+
+static void resctrl_abmc_disable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (hw_res->abmc_enabled) {
+		resctrl_abmc_setup(l, false);
+		hw_res->abmc_enabled = false;
+	}
+}
+
+int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (!hw_res->r_resctrl.abmc_capable)
+		return -EINVAL;
+
+	if (enable)
+		return resctrl_abmc_enable(l);
+
+	resctrl_abmc_disable(l);
+
+	return 0;
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -2449,7 +2515,7 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 	set_mba_sc(false);
-
+	resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, false);
 	resctrl_debug = false;
 }
 
@@ -2475,11 +2541,19 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
 
+	if (ctx->enable_abmc) {
+		ret = resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, true);
+		if (ret)
+			goto out_mba_mbps;
+	}
+
 	if (ctx->enable_debug)
 		resctrl_debug = true;
 
 	return 0;
 
+out_mba_mbps:
+	set_mba_sc(false);
 out_cdpl3:
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 out_cdpl2:
@@ -3802,6 +3876,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (resctrl_debug)
 		seq_puts(seq, ",debug");
 
+	if (resctrl_arch_get_abmc_enabled(RDT_RESOURCE_L3))
+		seq_puts(seq, ",abmc");
+
 	return 0;
 }
 
-- 
2.34.1

