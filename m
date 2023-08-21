Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30720783653
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjHUXbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjHUXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273CCF7;
        Mon, 21 Aug 2023 16:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QENWy9wbv5J7yv3ZS7g4mShATbh2GgrWQ9XJ7ALbREuFPI2IMaJVxg8yjWQMbAP9bemM7VqEeQg8yuK6ui3f7vE+7jKdt04G5Wyn+jMuFm6V2XmQ/xxrTdrXus6/b9iOqPR2tT4T5bCu4/E9lJsfyemGRcI4zvJBd2f/gREDKKM6DfBjMsxB9mJlSqEdQxaOZ6OpNGMNtH+LvrrfpiEib6euvBa2zghlWb5F18YwCErFodUtvRMpq4O+fkQT2fSwV+w8INW/ppC6xpgusew2ifi+dTep/FpNJh9WGSa59KGfSd9kcIwpzKJm3VRI55apUVV4lOOhizf1HURKI7LRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbct7425WsHDP5S4c7AYuXD5FhetUd8SWVCtwRhW6y0=;
 b=c1fAKBVaMoe/AcD9r/IGBhHRkwjcY2286dsD4Az9LJnsGotreEpXUZGbnMQuv163CQ1BV+7pbF+s8HafQUmtuRZRNfBxR9NLu7ebnTZWBglH3UG8ZgxBzBpdfDQEiEWHJi2zjPjjy8m/8MSOVvjAkiJGoslTehXqDRz11FtLYgyiee+g3D3buT/iqruRECoCrEvHBe8HX/FMNSYSIlqZ4OoPjXUZThlqpLViIkGG14K2lPviWOetq3BxY0cwth1D4kWRT/7bmaCsPTw8HiIBJzm1rOWSpDqz3jvGJVhxhogtuI8Sssqg91jl9pO06Voc5DXVy5QnoWx2FJGi6Djm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbct7425WsHDP5S4c7AYuXD5FhetUd8SWVCtwRhW6y0=;
 b=LaKUYAUJJCuH+8SgWaziuDT2SIIhKSZ0mjO9T+3pc+nyYIlUfX7eXxhd4a/vbKE4v3IouPV6jX/NYBywWUfPkPNxv52+wZZRksYdBvKXAZH+Ui20Ki4SUeVqr6WnzRuyBGVoR6nCMVidj9fbTIeES8yo/eNGNE0zzqa6tKDla1U=
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 23:31:10 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::52) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:10 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:06 -0500
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
Subject: [PATCH v8 3/8] x86/resctrl: Rename rftype flags for consistency
Date:   Mon, 21 Aug 2023 18:30:43 -0500
Message-ID: <20230821233048.434531-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: e472719c-27c4-47a1-ffad-08dba29eb390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t53NVgmzlDuUcHFv4lPCVWCSmA/I88heZhCACLOwRHTIzhHzwL7dmxaPEQY7EE1nooC2A04dqGCSjE8EgUAFf3XiO653RTVBW8QNEFFEQygtp3P5Iab31vPoUsRbvcR2wpf9TDv6sI22dPKkZDex46jCTImTRf6SnxRrZ8EJdRzS3DV5c/TyAqeajsulIxdIrweuuKwKTgYX6rCDeBqb546DIR3Sfx0A1q0EcHbbLz5reATStNJ/+kFyaG/rKyTVtewBPnysifaT0p1R3DFTSGXypGF8yW0UhlmZyBq1aCDecyDZ0Iawg+lYtRhMGGhiHR0UZkJct8ZA+DhPMSm3yYZTQCTF9n9k8cqvJAmxcOmkvukrsLdyM4zq86/DMOETOMl2IQNuDoX0Jf8BeoUmaKkL+/OQDgPt2MifM6tux5Z4xnn49WSrLN31GFHzrAS8xZm28/0i7J3wAQP2cfeIo1Dk4dZOHcU6ARZAdqPrDaMHXHMYLdTAstL+IT+8TIIoP7C6Fac+kM9wav6eRf8aSR9VunDwyXwOpOg/CHQhd1IPYqEiZOJbdQcILjYTkt5Z6CsxIj+vYdE/DvbVMxW32T15opmNLfogwIpLKEuaEY1o4kIYitcoEWQ6qNHmB1HzOsSx3wTk2yKtqh9kmsBvnwO+07DM0pwIfXaQGGoMSb+bdAYgpK3Cb1pfMtnR5e8ylyY3t/arL0+08fQgRHm8k6nOearXRn7T5X8oAySD86rOmRAkVCgvWhaOajbzouN2ti194k41+fC99qFGMeFzaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(86362001)(110136005)(5660300002)(44832011)(70586007)(2616005)(41300700001)(70206006)(2906002)(316002)(54906003)(7416002)(7406005)(8676002)(478600001)(8936002)(4326008)(40460700003)(6666004)(7696005)(26005)(356005)(36756003)(82740400003)(81166007)(47076005)(16526019)(336012)(36860700001)(426003)(1076003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:10.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e472719c-27c4-47a1-ffad-08dba29eb390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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
index 2f1b9f69326f..3010e3a1394d 100644
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

