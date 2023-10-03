Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666847B7589
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjJCXz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbjJCXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18620AD;
        Tue,  3 Oct 2023 16:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=antMkCkeAClkJZjITvCN9UNyuez5EtmMVJhN+JChhLeAAPHZzcX9tNSM5GwK9ixAJhxxodCnx9NKEK3Ga780/W25877UDl0+8SUrEExXY9QhFeUeVvizO/kYm7xHSeumCeSl646/whoIE5qEFdyyPthwIdowpqvU4ujtQ2DLlUQWVj40IRJp5U+LDubeDE6tk4F5wPh92zfEjD+LgBKHyZ0FxZey0ma2bFUFzOoAciRBDAMgyLr8bRWmcMjjiY+ctD5JZnpWWHf0W6loM7zkZJhHCNbWg669rPi0sZhI0inc3SahiBNn4/rpaSxCL5qKuxKpVihf9gZ7KCQ71qQE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfZs/yf6pi1N0glw8R91wNVfpSW16yX8dWgEjBMLSDA=;
 b=Dea+CndGMUu1f2cUpaWNuT30AHwdvKX1v8YwhVlNJ2QcfnxQ4dWjzzBDMgBYH5ROCJDZpv3mm4+jIj5mdP87AOYqGL2gZ3Pml9kjLGoLeaVhD95HJ3V/kP7OVbtw4fvJ/oLnCSN1Hk7vCaY3el8C/OWmLxLfTJGpjzmqGaaiFFzh61zKYYYqdJgLVcYo13tRksnGmAiq+kfHqJzx8nOPAEwwBcIu6nRctE9dcVBXhdOw7Uwm8btkgbnI1Inqz1n1JyG3pQbbZ9yhyDKQisyHcRz8UhIm0//mwFwMbXYgRFkaiwTCC0mxJD34vLyJKj0iXPhhXYeOgATjd045JpUURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfZs/yf6pi1N0glw8R91wNVfpSW16yX8dWgEjBMLSDA=;
 b=1dzyhJ+IsVjLPfN66IOV7TuLxbnieK27p2EBQydkbylhUcnCY7EbL99d6wyr+p7kzGFri7Ys17GJq6zKsnD5dNk2upnkbXhnEIsgjfjFV9NEOI+Ev0h2M/yRq5Ra3Er3FHMH08USQpliRGzZ/Pu3FfuFY27xHrF5MuS87hhAXi8=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Tue, 3 Oct
 2023 23:54:57 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::ab) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:54 -0500
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
Subject: [PATCH v11 07/10] x86/resctrl: Introduce "-o debug" mount option
Date:   Tue, 3 Oct 2023 18:54:27 -0500
Message-ID: <20231003235430.1231238-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 0494b466-3d87-417a-070a-08dbc46c25e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGW02Bqc1kDMDV6dOwnwPMlVaAM6zXN9wWi9rjLAc1mvWMX156g9npOCmixs8WH5p5TqdamTRPFwXf7W8e3QOjGDn/rt2uquvgDa/DFQOO3gZzTR506pIppPziH5z15rUNN7Z3uKHzBy70qowr6zaYunVYu9njVrQs9AM2SmNJeI9SZq2DGOnOMfH3kDy6J58O95Q2qJkUM9vzfm4eH5U9PAHQUtIgbVgiX+r+rI/4PkXQ3+rR62EdebupOAxROnKxoY6aTViyVWEagq6ERKcLIF6bDXt+E4EV5Ebt5agIAK+C+s6O6VzTKfPfnhrOMrtFfP6jG7UjEjjc2vgGyNXDL/o7C7F5zN1b5wP5PP+vT/KpdfIRSn55GH3f/xiEwevsvKxQcwcX2bF6fzxbiZzBfHBqfZ8xokc6ce8J7AnoDHpivpOO6rPR0T7oAaLTht32P+7OmVOWxsXXQCGVQ7s+hn8VVCsUsfZTzqSyVIIwXmku+5Qx1FrFToIU/Yt3QNg++LX5xKme8fQqNmdu94Wkh6l54Y8vO36bOnprq835NpgP+FhkHvH0P861A/Wt/AdJAvwEFUQF9louy6idmLEPGmr9v0FGWhd0q3FSdWUA7+ZdWEOXsYh1DOtZXrwW5zcfdnDWVuNbrTZ4rTJUmoNy6SGaTvjCrgew1FCbje1LtaITsZWmj7inisLZuxbvzRcHf1kuixR1UTj7sdnWGT1LOZJDhVKjvldkcJMtBoRZyfRZphoInwYrjPd8OLU05rGorD3ZpgFXbWTiJ7Jbipnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(316002)(54906003)(70586007)(70206006)(36860700001)(110136005)(4326008)(44832011)(40460700003)(8676002)(8936002)(5660300002)(41300700001)(40480700001)(83380400001)(426003)(478600001)(26005)(66574015)(1076003)(2616005)(336012)(7696005)(6666004)(16526019)(36756003)(86362001)(7406005)(7416002)(47076005)(2906002)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:57.2576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0494b466-3d87-417a-070a-08dbc46c25e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Documentation/arch/x86/resctrl.rst     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 8154e9975d1e..28d35aaa74b4 100644
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
index b47a5906f952..d68f947c5a64 100644
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

