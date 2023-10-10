Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13E7C4583
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjJJXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbjJJXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC294;
        Tue, 10 Oct 2023 16:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTSB9LyCSCP0gs8IQNg0FloihfB0TLZNAk2FWKnjoG9OFECtditNZl+sEP1GNrHhx/CVE7Gv3QCGlF3S3ALAc2hi9x6+slefRK3JiPh4S4wBMW7AxS/0zKGEPPPHNaxE0oRW355WH36hDukZOtzZ1bkRp0m9DEyclcjxRo229BJMMNL+/iKqUWQGIVXcZvHlwsBG+DGgJDi7mzFyD0S2Gbenr+1Os7ETYnmZBDz65uPnPW+ZUZvmdup+fIqaQ5nQKrtGDBkGl3+UfXrd37H+k9C7mXUyygqsAy2TopgC5CqntIA7djPbz2bBDiZhjWUCYHfn86uFhESH8psa+OHasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wks3xuViPedDO2nYSh7/q+hbubJfaQT34DHMV+GxKOA=;
 b=YKosFuUyR++W3WLw2gGYozduI93mHXIIA9YAZu1oKNZ5SlJlybppzNOUylRZE7YfuXbfx2HzKVHVYS2RnoODDSuu+/7raRkNHVMXS0623JkTUwaU0eYcqbxJcXgnXDgqMsoMsPFeE/fdz2154NOYRq59UQlGLcceAqjEaC78UegSap+VB3MSKfUFNZfdcMiWk4jIKrWapLlEx2bbwfEcIiAg4Tan9HFWgip2aNGlySdxq6d36lJNZHEJE4oxeK6N5uMSGuV1qhFdcrvZD1n9/NAwQWXX6DAPrORSsqIXiOlSDx3OVrpA9Q2SsyMhryZ7ijk3EHnBMgmRAS/hhlgHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wks3xuViPedDO2nYSh7/q+hbubJfaQT34DHMV+GxKOA=;
 b=vn8uLrzQ2FytwPiWXD8qD6eIDU6avgAkQAI0YAZFryEMoCzIlXF4vvoGZ5PEDb0uKXnVOZtsLIR2nK2AYZoU4dLIEoeGK70o0dMrwy2UwTnnPfkLbR9cvz/AFwOS0jEl4EIq0OSZj6EYLj8W3Yg2SAeqKfXuLh3htyLwSWnfnk8=
Received: from MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35) by
 MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Tue, 10 Oct 2023 23:33:49 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::b6) by MN2PR01CA0022.outlook.office365.com
 (2603:10b6:208:10c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:46 -0500
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
Subject: [PATCH v12 03/10] x86/resctrl: Rename rftype flags for consistency
Date:   Tue, 10 Oct 2023 18:33:28 -0500
Message-ID: <20231010233335.998475-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5ff5f7-3e4c-4791-4202-08dbc9e95a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hgUHljTAa3Ely3ZP1Hm81/ev6y8DrD/V6q2x3ki/S0cn3CJjthN4M4fUuEUKgrPdoXY26a1zEuodYZzxDt+WyaE9uDLRYtPaJamF+CvyEI9nVR8mezhKfnikOMnuQeGV8U/Sz6eE1GbZjUmcFD6a3jrD7AGX+78Du0/t/gPCyckFXlhHfliSES9GmR70yHakpNNxSRCJ/mZoYwX7mcwGK1DfyZlOkpF2+7c2DcWJbxP9uHWkRG2JAGD/pDab+4X133dmuxCEPUpAYyV/cmxLEkbBZklBS0BDpruygMZItmllTNM4SGqoYy9H9P19O5Oco9Pgfy0Bz3pHCCI9yMiXX8aPRJ7IoL8QuqosCRwA8gZPXZuL4TCTOl6hUoRjeNrCJIJ8j8gE4q6d/h/Do/OuFJW+eAb1AklO9BEVBYzLV7w8rwmqBNS9PFzH0w4QMmZAFrNGDgZUK4P+Fhfn+GpfrOzu7NufBmVetDdKOl9MVAkwnrF/gAJCQ7ANniD1I4typmzoIuawmfrLPM1NfAP4XL5Y40bUeHI4thRMrzM8gBuXI6RpSq0vSCdy8uGOzHrysoQMnqqIAn3m1h7DIujkbYvbxbo3IpuYIHquHnczLX5glDwrw6YDqr8oKZTQL+h9mjqFVBalIJH6k9f2YpopvO74yDN3Rir+4dsvMav0TS/RXRaTKGoc24cxOPszJ+cadZk5an1eTF9gTOU+b2lqILg4+bWvlLRQOvKzjsxRsNUIGpUVbbp9ia5cYJGcVCoFzW4D2U8tJnH58Y6fwAHSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(1076003)(26005)(426003)(81166007)(336012)(2616005)(66574015)(7696005)(8676002)(47076005)(8936002)(2906002)(7416002)(478600001)(4326008)(6666004)(7406005)(44832011)(54906003)(70586007)(70206006)(110136005)(5660300002)(316002)(41300700001)(40460700003)(82740400003)(356005)(86362001)(36756003)(40480700001)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:48.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5ff5f7-3e4c-4791-4202-08dbc9e95a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl associates rftype flags with its files so that files can be chosen
based on the resource, whether it is info or base, and if it is control
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.

Change the prefix to RFTYPE_ for all these flags to be consistent.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: Moved the RFTYPE_MON_BASE definition to patch 10. (Boris)
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++-------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 62767774810d..2051179a3b91 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -248,10 +248,10 @@ struct rdtgroup {
 #define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
-#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
-#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
-#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
-#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
 
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
@@ -267,7 +267,7 @@ void __exit rdtgroup_exit(void);
  * @mode:	Access mode
  * @kf_ops:	File operations
  * @flags:	File specific RFTYPE_FLAGS_* flags
- * @fflags:	File specific RF_* or RFTYPE_* flags
+ * @fflags:	File specific RFTYPE_* flags
  * @seq_show:	Show content of the file
  * @write:	Write to the file
  */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7ddfa4b470e6..35945b4bf196 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1705,77 +1705,77 @@ static struct rftype res_common_files[] = {
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_last_cmd_status_show,
-		.fflags		= RF_TOP_INFO,
+		.fflags		= RFTYPE_TOP_INFO,
 	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_num_closids_show,
-		.fflags		= RF_CTRL_INFO,
+		.fflags		= RFTYPE_CTRL_INFO,
 	},
 	{
 		.name		= "mon_features",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_mon_features_show,
-		.fflags		= RF_MON_INFO,
+		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
 		.name		= "num_rmids",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_num_rmids_show,
-		.fflags		= RF_MON_INFO,
+		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
 		.name		= "cbm_mask",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_default_ctrl_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "min_cbm_bits",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_min_cbm_bits_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "shareable_bits",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_shareable_bits_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "bit_usage",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_bit_usage_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "min_bandwidth",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_min_bw_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		= "bandwidth_gran",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_bw_gran_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	{
 		.name		= "delay_linear",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_delay_linear_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
 	},
 	/*
 	 * Platform specific which (if any) capabilities are provided by
@@ -1794,7 +1794,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= max_threshold_occ_write,
 		.seq_show	= max_threshold_occ_show,
-		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "mbm_total_bytes_config",
@@ -1841,7 +1841,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= rdtgroup_schemata_write,
 		.seq_show	= rdtgroup_schemata_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "mode",
@@ -1849,14 +1849,14 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= rdtgroup_mode_write,
 		.seq_show	= rdtgroup_mode_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "size",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_size_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 
 };
@@ -1913,7 +1913,7 @@ void __init thread_throttle_mode_init(void)
 	if (!rft)
 		return;
 
-	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
 
 void __init mbm_config_rftype_init(const char *config)
@@ -1922,7 +1922,7 @@ void __init mbm_config_rftype_init(const char *config)
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
 }
 
 /**
@@ -2057,21 +2057,21 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (IS_ERR(kn_info))
 		return PTR_ERR(kn_info);
 
-	ret = rdtgroup_add_files(kn_info, RF_TOP_INFO);
+	ret = rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
 	if (ret)
 		goto out_destroy;
 
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags =  r->fflags | RF_CTRL_INFO;
+		fflags = r->fflags | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags =  r->fflags | RF_MON_INFO;
+		fflags = r->fflags | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
@@ -3709,7 +3709,7 @@ static int __init rdtgroup_setup_root(void)
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
 
-	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);
+	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
 	if (ret) {
 		kernfs_destroy_root(rdt_root);
 		goto out;
-- 
2.34.1

