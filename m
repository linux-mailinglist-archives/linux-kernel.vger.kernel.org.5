Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079F78365E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjHUXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjHUXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3CDCC3;
        Mon, 21 Aug 2023 16:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtNyQaqf3Yz7cvmVE3SnLa3V0Yulg90kgGAHPkcI7k+FeyxjVaogPyiSYQC/R2hV2P+0IB7wpg/gkLbT2hl6ppCsT8KPJorryfWn4ArZxHHsOwqYxudj8tocQCJC3sjSv8eah+JwmN9DyuJIAyYOikeODS5PFF+NvEtHtVHn0lWfatbgWyPEqG8GWd4FVJ0DranEQ4uAwH3JaODo8CaVwl7oJaNuNDrn/gR93xx1pHEgeY535wZDw7haC24I6/O3fIeNJfURl+TV7cjSN8oPjoCHoOF5epqOj5Zu7VNnoBDQNGhQK2Kw1EqNFqhdLgjObJr9Jp6WMXI03XgXAYgFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix4QNRpJw4L1QShqOhzE5LKToWjyw1ffu2sR4ovlY1Q=;
 b=cJGR21WsesdsCzXJq30vpnj7rbZcvXxX5MrUnskgO3v+NX+zUrleOMAk2XUENcsIKPYdqmrOt/9DkU8ULTSgrFiux7KWzdzDj8EdTJW3mP6iss9I5UMVJ3shZiNJaYmLMdaCNRfFaZPU8hJJyjSDFQOktjbEVayrnj0xU+5J71vQKphMcfq9ENlVlGEvTHRFcM4RvxmAOIRY7xh07TvQ+HC4Zu7P625stxchsPHvNiDU32SaAvKG7PZse6IF8XtSSnNvuimmqzWyxsaDrWNQU5w3iPohsXJ8jooPpru2aSTveEAgzarkShfzAxZWxQJa4MbLA7a6/8FxswMsMQ01mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix4QNRpJw4L1QShqOhzE5LKToWjyw1ffu2sR4ovlY1Q=;
 b=MM9ARYF2xhfoKltRWL/9p6W1x67ZYzl/VEHVIkJ5Y2lNCKHCtcEAnL7zk/GV1U+lYkqGD0+X3Qm37QtwVkwrAXk1viW5OBp9heJZ8d7Y6AVVKtVBl4upESAAI1Aw/o4+5K4oTJG+vmM4bsWpbzm9muZu9zUJHG2YwWxvTgzyvx4=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:31:17 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::69) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:13 -0500
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
Subject: [PATCH v8 7/8] x86/resctrl: Introduce "-o debug" mount option
Date:   Mon, 21 Aug 2023 18:30:47 -0500
Message-ID: <20230821233048.434531-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CO6PR12MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f04ad7a-399c-4809-27d2-08dba29eb781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2HznhTEszLfDDnxNCmpz+8pehJMOCQNE+FOC9g9o9ro+fEt8bglIuNe6N9flMA8chxwcTlr1e1W5jTTy86+LS1HlsCtnxi8AnejQAV5FMCgJZA9Qljx8gqPB2kxFBcv7D+xZVKG8LvVfL7+zllRvMEeL66afiL/ReppzvchkbwmNsIgfbPvzEjPWUNkETICLhXRFaF0XD6w+o2K36gh6h1fA1FqRgfme1uO/2SHhED4VHrpKMHsLTYgLNadBFPM2dRDBkmPtUlX1gcLh3hNHkWFel2B6Nm15q+8VyRH+qi2slmSvyy/tSwpqAxaqFBjDND4p5ob1pB7mmD+yrj9HWTTXoFGmbd9nHCrTkkaq2xekv7hNP/PCzscjjBhHgU8623L3XKAgvxv4phLeYeqzHZpliZ6ELbrbRNWIRD9weADDJhp+dYg6F5vRp1uuR4AmKV2y7Cl7VtRYO9G4c7ITlMDUTG8zLX8fAMzgAj2fc+bVZ6PPIJxJKwJGNOXvKlAyHvk8BTlTza13pjsjOq1wJe8Icj3Me31+r29CwcFS5CRmOHst/zp4vFIEG7bnsKUAFxQLHVSFkGEW+tGvtWXQH/wNBWFjQqYgbq8F6cfGx7pGBvcB+2JNgw9wryvS9U1kOzOvpSXkqe4yLNBFmfjbwLGfNQC9qbAPROeSzFuiik9M13lCw/SO1PlPJ/jIbRL4iT0nDCJGGSWvdF03n5MgVBKkI+/yeL9i842N4oBNMbVyXXQs2pabW538nug4YK0ql9Hhj3LEAWXnEA7my4Vnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7406005)(7416002)(86362001)(7696005)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:16.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f04ad7a-399c-4809-27d2-08dba29eb781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode. This
option is used for adding extra files to help resctrl debugging.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index af234681756e..5a2346d2c561 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -35,7 +35,7 @@ about the feature from resctrl's info directory.
 
 To use the feature mount the file system::
 
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resctrl
 
 mount options are:
 
@@ -46,6 +46,9 @@ mount options are:
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
 	bandwidth in MBps
+"debug":
+	Make debug files accessible. Available debug files are annotated with
+	"Available only with debug option".
 
 L2 and L3 CDP are controlled separately.
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 44ad98f8c7af..2fae6d9e24d3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				enable_debug;
 };
 
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
@@ -306,6 +307,7 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
+#define RFTYPE_DEBUG			BIT(10)
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 98f9f880c30b..94bd69f9964c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];
 
 struct dentry *debugfs_resctrl;
 
+static bool resctrl_debug;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1871,6 +1873,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (resctrl_debug)
+		fflags |= RFTYPE_DEBUG;
+
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
@@ -2379,6 +2384,8 @@ static void rdt_disable_ctx(void)
 
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		set_mba_sc(false);
+
+	resctrl_debug = false;
 }
 
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
@@ -2403,6 +2410,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
 
+	if (ctx->enable_debug)
+		resctrl_debug = true;
+
 	return 0;
 
 out_cdpl3:
@@ -2607,6 +2617,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_debug,
 	nr__rdt_params
 };
 
@@ -2614,6 +2625,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
 	{}
 };
 
@@ -2639,6 +2651,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_debug:
+		ctx->enable_debug = true;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -3707,6 +3722,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
 	return 0;
 }
 
-- 
2.34.1

