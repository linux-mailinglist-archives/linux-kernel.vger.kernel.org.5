Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2C7C458E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbjJJXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJJXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:34:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32ADB8;
        Tue, 10 Oct 2023 16:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5AxDnu0weRenwVyq3Ud+PHD7l3ldar/OvYcY82bbDrRb9qs2r8CS7Yy4MZ4PHbXTw1ZMICUs+ZW9/NpeRrLgw1R/c1iih6cGEWtro+LhHn5mXaQjSugmsRBvTb6F9GXwn5Y74jn8l02cfa/pstysl1ZLEORansN57e7aZJyfsGpKS5urlfmYKtKIYBMOWisHaMHF2t7kemS2p+d2usQmvgmAr9GTnpvsJvGVy9fkXMZVJIYOwXQTQGFTTnzZ0wOjvMEqGEoTeJen7cU5LPn8a16bw5+EiD71/rZ+3zgnf7+m6bVthGr/Ndmzfrm+8U1WTomNp8bvgsr+En9+TxsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+WfvfgXRMRbjdYp1Vi5GEwXugoe5e8TZLnv0VoakJk=;
 b=K10bAKJcdIU6yLZbQA4GC8gYEhobbS8PRiWV//JMitkaCBmNbzK22NDhhYlUiOVJK3kBKd52qConVGAHsjDGTzm50rV7MiyzQUangZzHJoXiu7DaZNrUiepyXEbGksW6QmU35d6f+/zTw9CtbYer93Mv9HKb8e2QkxXTsDq+a205LLo3I2BnFhmkbZgx6ExuRgch7Cj8H1Yvsklp8G4/RfluoF4JSrTYcq6owrYw3OayNsy+9zy2j68rnMrQ+nwTEXMIryaARj5UvAFi2AkfkCUJNJE/u3pRjAfAY7l1tlgSv2ij1AsFa3KSh2J7H27wN9tAj1DmVTh8ypxHJNiqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+WfvfgXRMRbjdYp1Vi5GEwXugoe5e8TZLnv0VoakJk=;
 b=lOwIOFVdPKTKgFN5G7QoqZsp4pHG9fSUTf5G/tMBcccHBNWSC/LM2pxTwbarCsmpO3iM1rRN5h5rsL17NSeTIHUIremKm5lRjoolpQOLOCLHMIwP1ky88H7PQAfVAycmhP89bAWTDL84xfhHeS51Pt2Eb/oJu6FfsaqgacpLd20=
Received: from MN2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:208:15e::28)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:33:54 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::ad) by MN2PR17CA0015.outlook.office365.com
 (2603:10b6:208:15e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:53 -0500
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
Subject: [PATCH v12 07/10] x86/resctrl: Introduce "-o debug" mount option
Date:   Tue, 10 Oct 2023 18:33:32 -0500
Message-ID: <20231010233335.998475-8-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010233335.998475-1-babu.moger@amd.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 310d600b-cbdc-4f34-8ca6-08dbc9e95e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc4QAnEZYrWB8VcVqkXG04wtYezeD1yZ6B+jpE2LzyCCNJIR9X6EDG6GGHb1mo8l7dxQZnrFEtiOojQcYKk9HirB0HjVQSXQIMXOKw65PwrL8zflYD9se/TEHTJDv0L7fJtsqec7NsF0APNjMU6bEqpf47Lh+2JGvR8Zb2COqvM/OgCyNBPSazXn3a9CN2beOGJTiomoKZpw0mbRYCks8WjWsOdLub5A1WtGJgncBLNbqxgkBjgB+lAooKQnIXF13wheZr2buEJRlyiYEJ1rQ7gu+chi6vTHvIt/9Bm++w62h3zEHAfqrlx791Px/+xFlwvseqY/BjWGJUmzfzyG8Ewl0fWB4enH47yES9NTBULKKDB0u9O1lcBXJNZKkDAVuNekCzyDqVpMAXRJBp+6onQlvLiYfn3VvPzOPL/uN5oHwSP2O//7bEoHD9cRlH+Lzd3l+LqpIbieDTGfSI3rVumNeDYHEgcs7MqAmA46WTwFV1Q83Tm+sR75qXSj9mRk37GfQ7WzYq4ZCgpk0y82WGxXExBnwSSHqmKDvNs4CZp4HblVOfzIUlW5MegMaOKoyQ8Ub/hRJRfUFKSy+2Y2luof0KkA/AeA6wET1FFHgZsePEgMclIRH8xwtB1Nsv3gO6lKPaAez6zjAdVhqWXWgtlvKkTtZrzNdzamuJKb1wqe29+Csa7Fl6T0/pI0BgzvTfIV6MnCCqm/oxwWMFawUXutTD0shGkD0hQg4pi6mFQz8LO48xXjrHQDPNTSII/cdoqOSUIzlIO8/imFysGRuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(1076003)(2906002)(7696005)(40460700003)(16526019)(81166007)(356005)(82740400003)(86362001)(47076005)(36860700001)(426003)(36756003)(26005)(66574015)(40480700001)(336012)(83380400001)(8676002)(5660300002)(8936002)(44832011)(4326008)(478600001)(41300700001)(316002)(7416002)(54906003)(110136005)(6666004)(70206006)(70586007)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:54.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d600b-cbdc-4f34-8ca6-08dbc9e95e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
v12: No changes
---
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 520a7753d829..1774f7b8450f 100644
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
index 2051179a3b91..f0d135e004e2 100644
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
index a34657f0bd0c..150105c21fee 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -59,6 +59,8 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+static bool resctrl_debug;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1874,6 +1876,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (resctrl_debug)
+		fflags |= RFTYPE_DEBUG;
+
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
@@ -2377,6 +2382,8 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 	set_mba_sc(false);
+
+	resctrl_debug = false;
 }
 
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
@@ -2401,6 +2408,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl3;
 	}
 
+	if (ctx->enable_debug)
+		resctrl_debug = true;
+
 	return 0;
 
 out_cdpl3:
@@ -2605,6 +2615,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_debug,
 	nr__rdt_params
 };
 
@@ -2612,6 +2623,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
 	{}
 };
 
@@ -2637,6 +2649,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_debug:
+		ctx->enable_debug = true;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -3705,6 +3720,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
 	return 0;
 }
 
-- 
2.34.1

