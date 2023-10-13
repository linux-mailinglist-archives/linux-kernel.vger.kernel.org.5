Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA27C8E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjJMU0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJMU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4EC2;
        Fri, 13 Oct 2023 13:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg2rZKLOrE38ZmUBMVcWlgUxMisbMpyEy+dvjNsef3k8fQarCcAwPwOy03llWQz/CEc8Y0AfWxlIjdE5r+/XQ7k7T7gZs29chtWwg9AkJ4RC7J5aSor+N7PNHevwIh2h9o+XLcmYo0sNlkmur4OO+llUUeICTTj+r1LPdf5/jmcqWTiW6RVc6teMhjcn5msv5XgO8N8LL7K4FFzokJYqBbUhZ8ENdMS8YDxTqFjFmmJ4apkgj7cexs++WYEk9aHY4zMGjl5ihuLxCjSj7thk7/RW62W2w/M2B5kJLbLoIqPRureTknwdJ16Aeo+UvD9WLZWNlRXrzstmPmZgZQpSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnIl4U+OW3MUJzJwILuIlJmkwXHrfA2c4XaGs2GwoCk=;
 b=IP9OHah6baNY/zmsLc/QoE1Z1ys6Jk9khyQpJfvgOXPyJsIL6cDhG3M9ni+716Git9KUyXbPexINKGXK8xQcqDy9vDFvEW71jZxaeQ48ikm43KyUC97+wkcz+nk+zyPeZjztZKp5juqtHkyb+EsXViwEdgtnhZevaMMJjGnLPGc9olom7iHxNWvcNEL05gpyTJTt3avcKoBtZqhYhVaigGncLGvCjUKNzG1amesQJ4EOQ8W/4Lou4PhMgvgMDVd8dpcO1H4OuS5nGjuOFkDrJvMlTKCOPjZCyb2BeS56AvlPwxNLt0r5xojavIUMp1yCPUfy7fgm21sX5oxdkbNNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnIl4U+OW3MUJzJwILuIlJmkwXHrfA2c4XaGs2GwoCk=;
 b=3ZZGzxowFqzp20HRnkrJtkfGGwfoRvTA4wLiQdVejWKU9zZ1J0hogOZFcL+SF5OEGlycH74Dr0cIXvR+oMgJFYnCjJWgPM6/AV2IBWqVptuHVotyCjK/oqLH+DSZcCP4C50wrQQKMUBugfQR6ioUiXWxw/Ph3qUDfVUPAjkAJMs=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.43; Fri, 13 Oct 2023 20:26:16 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::8b) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:13 -0500
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
Subject: [PATCH v13 03/10] x86/resctrl: Rename rftype flags for consistency
Date:   Fri, 13 Oct 2023 15:25:55 -0500
Message-ID: <20231013202602.2492645-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 08570af6-1552-4feb-f7ff-08dbcc2aa694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax8PtSR8uKuynG7sJ+EX8c7QNE5f27Mb50qZCZZYiLF0zKPxx6mq992emQr1B+xOZF4VHMkzlZLzt+X87uysnTOR+DonDZ4rcX+ab++/XEKZAn4vhALlGOhfcwdbqO0yw4oVvvHLoy3BiHOe1XhfnI6kz19845nyT0hTn+wB1GF4XKBphDHVqm0FuxfNV726nWOumeBap2Q86qIwf3RNSAZ/mIlVeepf8ZdZVPPRVAbHadAKjEXjKAbjBwxhRTLibtNLv8aYK10Uaj0kV/ymjS1sRxHRHoo5DEIZIiUOqlmTdS97yY4tFY8QW/j6Nh+n5zUHj0Ej1hdDz0AnlCDnbpk7u6DgUIe2Yo0QuC0m7rEG4xCGIJPJrGifA1URlLsoHp/UPW3H3zjHWNkKx0xtwYZEsKDh2pX9V31Rxu/rNTiPnYydj80lz+VsaYE+vDDH7b/uHWSh81t4ieTQImNLcNPnR4Pr1jyKKisPideRVoETaaKlmz70JDwCJtR4KSp45uwKkv5Kdn0dtZFIe/Vd6LYRJTeB/C8SCWVVQGLCNdQk2pvzEaq8wkQ99ZXzzC7iiIWN1LX1j3gGFnCWjSikv8VMbVvKMENhooawi4N3rfl7mKcKSfb7jL4LWdOwFkJbbZOZTlVtvbxZd3KlbOpl25nY9jcqVySTfWw06Q/wH/9M2kuV+/O3S2AGtUyIWgqNlaAz+jrQhsQKrDC18zSbdVhnM01E1VXqu21whDvTSqTQxpBPVPYgRYDMjPC5VfFNSum8DKr7URloGcMtnETQrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(16526019)(70586007)(110136005)(6666004)(2616005)(70206006)(41300700001)(1076003)(316002)(54906003)(26005)(5660300002)(83380400001)(336012)(4326008)(426003)(8936002)(66574015)(8676002)(7696005)(478600001)(44832011)(7416002)(40460700003)(7406005)(47076005)(2906002)(36860700001)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:15.7280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08570af6-1552-4feb-f7ff-08dbcc2aa694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v13: Changes related to rebase. New file "sparse_masks" flag has been updated.

v12: Moved the RFTYPE_MON_BASE definition to patch 10. (Boris)
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 44 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0ad970c5c867..ba4611111212 100644
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
index 09141f1f0b96..125d12d8f4b9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1716,77 +1716,77 @@ static struct rftype res_common_files[] = {
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
@@ -1805,7 +1805,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= max_threshold_occ_write,
 		.seq_show	= max_threshold_occ_show,
-		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
 		.name		= "mbm_total_bytes_config",
@@ -1852,7 +1852,7 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.write		= rdtgroup_schemata_write,
 		.seq_show	= rdtgroup_schemata_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
 		.name		= "mode",
@@ -1860,21 +1860,21 @@ static struct rftype res_common_files[] = {
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
 	{
 		.name		= "sparse_masks",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_has_sparse_bitmasks_show,
-		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 
 };
@@ -1931,7 +1931,7 @@ void __init thread_throttle_mode_init(void)
 	if (!rft)
 		return;
 
-	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
 
 void __init mbm_config_rftype_init(const char *config)
@@ -1940,7 +1940,7 @@ void __init mbm_config_rftype_init(const char *config)
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
 }
 
 /**
@@ -2075,21 +2075,21 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
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
@@ -3727,7 +3727,7 @@ static int __init rdtgroup_setup_root(void)
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
 
-	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);
+	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
 	if (ret) {
 		kernfs_destroy_root(rdt_root);
 		goto out;
-- 
2.34.1

