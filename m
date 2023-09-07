Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24A797F61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjIGXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjIGXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB81BCB;
        Thu,  7 Sep 2023 16:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMIoECWGxJJ6E5V50cS6ztM+ocyiNl9+PtRf/lSAObCrYEg4UQDLuww2l+ZwlAPgXFUaf5dV/PkElLhZOwmDMIbzewEpGsDEoRwFV8xQsAr0DZRQRU4paLLHyRso+SklViS/I+3DEa8OnslqRQR4gHtMBeeLMgxDWE0OnIJmDeBS7gsS+yphgo9jp1QwnIe1hYNu1kQnnHoYDtJ1Mtb5W1lOFglNNzn4aTUDApO+58rKyOaFpTscZRejObiqxOeCOb9TUQtoWOjqI+PiWgclN8m/3PA2PvfEpCt4BbC0mhqS1WUDp8GKm5y4Hv4N+jC8gXQv27z7U0N4Wyyq4oKLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qJQTtROfQdtyytJgjiQR6NbVxPyc37RxBL6Z6pNldE=;
 b=IvYNEuFoa+FS2eD2d/ZAx404tiOAJwXyxG7ozcI3lDUE4AHiyOIyqBnYr0ctPZiQ+J3r+2MFR+hHms7zZHEPqnHPPVr7hPax0lhArLDtH60CFgzUxcXG9gBhmSxQb0dLZymLzjuywfwO2wjgFW5maF08N7W59j2R0mNoPjwbsjWoTbjsHz4FS3ygjTGOn/FkozLyPSqO5MWW4GXMbWQJbbrboTczEmcvfNTMwXS1D5YOchUP5fGrZCJB8mrv7ERmo28sefYaZN0d7smH5lD3mahtKi0wdqdQE96Gyj88xkFaKZ+Lf3DPbNHtn7zXKSeVroSdIOveunKZZj+00Vdskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qJQTtROfQdtyytJgjiQR6NbVxPyc37RxBL6Z6pNldE=;
 b=mKCHoUSg/EzCMeiitnIrc09MhqFhwVIpZCK0Iusl8KSGbMzQ8cIm2+2M/f/CNnUshd9Y17crHeX8UygKyF4kp5PgqpjPQpnSpWAoO7YCKdpEfi1kshzxpcnHokZYc5cNe60huJZ9PDJL1gDD9ZZqPG22ej1lq0KmAEGhm9AfHig=
Received: from CYXPR03CA0087.namprd03.prod.outlook.com (2603:10b6:930:d3::12)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 23:51:41 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::e6) by CYXPR03CA0087.outlook.office365.com
 (2603:10b6:930:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:39 -0500
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
Subject: [PATCH v9 3/9] x86/resctrl: Rename rftype flags for consistency
Date:   Thu, 7 Sep 2023 18:51:22 -0500
Message-ID: <20230907235128.19120-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 256e0313-1096-470e-9204-08dbaffd626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4l7pbq5dG08uWpo3bnPdFE5xpKGoIFaaBVaWb6Rr21e2yD3RKJVFPvrx5w0xzYx4rFz/4YqQAURCiFcBhzGmY2UaHukoowz4jacN46KPf7SgVSloEiLzEVhQrq5hkOhhHIruIFHn2u51k/py4M4uLF/D9zzC+NvWaNQSQGjniIV3Vmh7/IITuwJsIAldYy7gA93BuOsz//ny3a64mPqZESyODInMpAoq0d8brVh4xmQAWaRR5XqddRQlnZEooLdmoNEsVaI694zmQiI8qbgC3ALPg5plslr8SzBozi55+W+3Tvg+7aHMHFyYW74Jw+jekY1e9Og1MUqcljq0Llse7qAM+dSWUW5178BcjrQAaEKj+hA87zHU3mcMPgboP8lpRgF5fTdruOlXBu+CfDyls9E4qFIMe7brynkT1hA64exRubcILQwI8xoHr5wZGaewC/ii/EblVxGF6oufbCIvoVOFM9E5v398eRJ39CziG4YtzEptFKFdR6yOvEj0jgs7keFhkx/zEmso/QaGz/F9mZtfhDO4vy5/9Ak7zNsd1SgAq90m+yuT4TWvm6Kl8iMtLE+RL6mB74ssu0C9QWrMfeOkr0gBIzli6cN5CNzJpNliGnocMxmBKC4U39idXUW+99POEiRgNx2D39Ek6Wr5tUnoyacBbp31Dfo0ZjmjdqypfnqIL60SyG/zJRt/1ev9skvV9NFHP1z+4+Hz5E8u2JOXIwrzcnFUZxgczY46kzBpeEzFtxCRh9YCUwq2PhuBEUPICbczppWKeD6sNvCLGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(7696005)(110136005)(2616005)(6666004)(86362001)(478600001)(26005)(36860700001)(47076005)(83380400001)(426003)(81166007)(82740400003)(16526019)(356005)(70206006)(4326008)(5660300002)(44832011)(316002)(70586007)(54906003)(40480700001)(8936002)(36756003)(41300700001)(8676002)(7416002)(7406005)(2906002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:41.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256e0313-1096-470e-9204-08dbaffd626c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl associates rftype flags with its files so that files can be chosen
based on the resource, whether it is info or base, and if it is control
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.

Change the prefix to RFTYPE_ for all these flags to be consistent.

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
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

