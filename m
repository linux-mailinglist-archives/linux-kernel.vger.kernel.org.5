Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386A7C8E52
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJMU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJMU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F5B7;
        Fri, 13 Oct 2023 13:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwuHu0ohqaKq2Q+qkC0A7GelfKV0UA3J7/FA4MgOHTVaq3azGX+wlc5D2QekC2NAbSLkQUOeUTCp0enysFb5/4efC4ys/Kx9n5gkaZLgrHW3MxaE58+JLVLB7LiFqf+s4R8PpZVmRXeRDVHTXiqpPr5yD6+382WZuuWx7/neQVPF3EDkBi5T1Xbh8mT9Dvo9VH6ztBJLN9N4bAl6LLwGv9Wf2Rdx1DtAeCnLlWTgRwsX1WTGD+Fjgrz0w5ofmBPZ8juSiFp6EeXf4k6vpr98uWwWJZEDwnG95aHSgcfKcWx1aKyfOmkP7TZO+oVpnM9rEx7CHl2hJBCiCUKYoxBWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh2ZbCL1qrBxYbPD4V7VGUGFUq5KHRz0TKDp8EeQwBw=;
 b=mubaacMmPmVE2DGzLTu7bYgoBPzkHbd8J3IkCuDWiK9+0/nbLweAvh4VgPq+js29Us/aDSmT1fIc3t1hP62ZnbyzuJ+TAGiUHoaTy9ThHXEP1XlDpuCKkB5SAja0MXhTkvtG0O2d3LjJZsBvszdSEJ7SIYYiShu5jkAMzLZT50sGyNI38YBEPGGbh08SKnxCGNsZLNmVkV5MqLdtAfLjwgz0/SrvrozW04DKchepXxtzy3itDrj+Dc2rW0XTM1jpdWd9ix6C4loSMxG07Wv55nXLPa9SG2fQYdzgiqfJa8OuClDUyOYHriI/USuu9bX/BuVWYLwc+72bRbUYi1ZmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh2ZbCL1qrBxYbPD4V7VGUGFUq5KHRz0TKDp8EeQwBw=;
 b=eJjewEM9Pr4mRIlWQe+WpypOdARuu9HTjByuIjHJK6jt8Sjrj3u3GHD+kAFjqUHLHsIgHPCKpv2T4WbuSA4eUZM2e3OpX5/M401huMyVf8EVWcam3QdNoRJslKnibF757r7KYpplrw5dK0MY5ohQSVEptxGh9fAjIh24KdR+Fs8=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 20:26:25 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::3b) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:20 -0500
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
Subject: [PATCH v13 07/10] x86/resctrl: Introduce "-o debug" mount option
Date:   Fri, 13 Oct 2023 15:25:59 -0500
Message-ID: <20231013202602.2492645-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab9cd68-3225-474b-f217-08dbcc2aab87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OG20YBpgIYWKb7R+84CWVE8a60tvAwkSK9S/38x5YAkRV4s9FpSEC5XnzzG9fjAH+qd2hp3oo+O29mo7ovA9ZKkFjS4OAPOBIGnV5bIBT61DNqWrsety2DduZZYdpfD9dO5VgwZqTle/6koYk212q3jl2m8zenfdsFcT598cJOwUClkp6iFRK2DjL/KfucvtbUYLipbwF5viA/UwFVVgsCsYubCO4yQavqMhRWIBLHs8hdPIPIYSCpaGDI9jLNzzOUVDPfyjLS55+nQKuQ5T/h39vf/AymDxctAf1hWS1qeY5j3sj+BNns4GfDvgN76gCtGq6OHHawE9d7NdFBLc2f7mzo4xo2B1jVFRsnjJ4IwP3067ItK/tV4kFQtpEucEef3lVSzNy0eCHwG2dq3bYl7fz/nhI7TlcQsCh/eZZj8E8l5RLBNtz8Z98zivB2oT0a146cF70/Mn9lTKdYqmIvrpCgvSYsrfAqMksF706BikMxS/a+dwXh2fOtK6hvRN8WdqkJswHaICeQzGLlPUV+zGvc34RfV9OHCdqTUji74N4iHYFkPIL6Gu+Umx5e7mXcGPMTak0iB/nSX32HLW6hhsRLDeEtq27XWgAyDxE258ncLckCFEMX20NVpUEgVZMcPBg0sRwIq2TMpJ1fvI8jpB2rocVnpTK7vR+34qxJbdNXEBuKzRUPvrFJBKcRFlwuzAspBmgpJLnTjvpjGADycBhSfy/FG4df2+oqur/0vv1RyWTj7FeC7TFwqqgVU53oh8DZPETp/giK9GRqw6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(47076005)(7696005)(83380400001)(36860700001)(82740400003)(26005)(40460700003)(81166007)(66574015)(336012)(426003)(40480700001)(7406005)(7416002)(2906002)(44832011)(5660300002)(8676002)(4326008)(16526019)(110136005)(6666004)(86362001)(316002)(70206006)(70586007)(54906003)(41300700001)(36756003)(8936002)(1076003)(2616005)(356005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:24.0781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab9cd68-3225-474b-f217-08dbcc2aab87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode.
When in debug mode resctrl displays files that have the new
RFTYPE_DEBUG flag to help resctrl debugging.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v13: No changes

v12: No changes
---
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1163da74f734..0438880e38c5 100644
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
index ba4611111212..b816b902b5c0 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				enable_debug;
 };
 
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
@@ -248,6 +249,7 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
+#define RFTYPE_DEBUG			BIT(10)
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 55da93b5ca53..84e0f45578dd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -59,6 +59,8 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+static bool resctrl_debug;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1892,6 +1894,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (resctrl_debug)
+		fflags |= RFTYPE_DEBUG;
+
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
@@ -2395,6 +2400,8 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 	set_mba_sc(false);
+
+	resctrl_debug = false;
 }
 
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
@@ -2419,6 +2426,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
 
+	if (ctx->enable_debug)
+		resctrl_debug = true;
+
 	return 0;
 
 out_cdpl3:
@@ -2623,6 +2633,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_debug,
 	nr__rdt_params
 };
 
@@ -2630,6 +2641,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
 	{}
 };
 
@@ -2655,6 +2667,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_debug:
+		ctx->enable_debug = true;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -3723,6 +3738,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
 	return 0;
 }
 
-- 
2.34.1

