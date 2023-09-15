Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3567A2A92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbjIOWnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjIOWmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F95101;
        Fri, 15 Sep 2023 15:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caXDvIwhmCpLRbRco7F0KcIkM/6R9Y8g1C08u8NNuuBIAyNjCGr++zI1eQqotf7VMWNkYMIRq8TkGD+4Jv4+Dds8JO9VdnyErDkwOuI0GywC0FYPvYUCz9v+40MnJRinzU8tXJEQvsrufLx39Ry2BqhzwE8CU92NqMKEsZe6Z0fSmQXq+mm3mF0ulr9FDqbLBz8YHjE7HwHkXsFmMpd4P97K3eyZQOkfsQoMN935YlkNnEb7vGfrV116oO1nmo+tDpbta0mqMLdtHdBD1p9nbE4XiOs0A2wPw751lHVF6khd5xhEck1994mHLhIQ1a1MZOU9llYDRNZlemjxpzP3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRNwt9E+1bJoLKKiUsRyKY7GIJyJUdLTEXyJaGny0OE=;
 b=TqAixs56F0Yb9KfOGsGcTTCLVIwvpiZ1gUA24WN2MAi/8y8elyU1cY7lz1iWg4E2gTKXO1p7EHj3jR4rN2B7gE3/dik/8othXRfjn9ph7ISUSVgfRP4JrUp3nP6Or/Robpi/HAtWun3tO5lZwRtNbeS9NPLhCIycZVwHdm1jJsAeDrUs6/kjLsLs806K0YlETx3a8lzybZPEiyD7ZHVgCvSjd65S2EnrDLmwqFhrBOYy5xjgvI/dK11GndsmZocsCk4L1R23uxLhW14PDuU2O7hnWjhgKMZv6DCkJXN+4K+HmRT0dSYhMoDUaWNQ1QSicBjnATwIFCVPCE91VqhCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRNwt9E+1bJoLKKiUsRyKY7GIJyJUdLTEXyJaGny0OE=;
 b=ipNln5TauhxwJ0w0rnlzk2uM3jz9WALyJucJlNpRTizJcKUGJSEpmjwyuLLvzEOZqjLego4AsIo4uYUspGfdIYKpQFFuub49AKXF+yU9e9qLjlwnmMskaXu8K9uQAEFx5xDOOg522FkAmlvDY7XRL7ZQKu/ykMtuExowWq2hHI4=
Received: from CY5P221CA0105.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::40) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 22:42:42 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::83) by CY5P221CA0105.outlook.office365.com
 (2603:10b6:930:9::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:40 -0500
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
Subject: [PATCH v10 04/10] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Fri, 15 Sep 2023 17:42:21 -0500
Message-ID: <20230915224227.1336967-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f52e28-0cd6-42d3-b6bd-08dbb63d127e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+1x+qJ4WjVRAC/vZB7i7d2D3DfLMa8zEiN6+HratIK2nbQkdHzLG1Jz+C7qT7RnanJaF11Lh8NVFgj8Jv7UC8G84VQ/mmS49mlM4bNNWRQ1HJK5efq0Os8CU4GeGox3SnJ2SEv1SnNL5piB29z8Be3ckUiXKCTNe1QeoT3ko1c1rSd2Q8yAaegKfbuWGPVvpUV3DKSOMXe85mgF0S5SD4CXp5zF7cOx6OxUnHJlK7kQu1lTwt4lBDVwbMgnBCJlxxQLuG6IS6umFL4j78KvtuyFSGBoOS2pDO/TXNGk2gDIR72cwm5kLa+WHnLWZCL+kCKBul93nsk3zIS8cj4qmXGAE9yQuqPUX59Oms+KnN/ot1F8xMGmoJnG7kb02g7kzY0vTiF2IAzCES9YTuCt6iwhkfoW+8e9FVMoKzqD2JnWr4LcmkyAC+6f7z+m+TmkhjYVaaslNsOfIDAvFVj3qCFOscjR5fg5VPW48Ji1n/O9hrLMRDWRbYAyycZGnsW+gHYOiMIvtisFxIW2q9HD7iuHB7L1efiNhCB8YMmJJzxdV9faG+YL8+22s0eSWWgeynLpxSJlDJ3ktSOLORHEchvgiXCRY1AEpJRmuS4nji6QpizM7d0X/qY/zO+slKphiGMUjsz8zPaQS8w4+2Txl5Ea9mhMBrdttF8v91UDiHle6b14J/Nuy7A1QREC3nLEAOhjf4BCuheHC3d3BKQqWpgLokDHX59YX14dvT3lnJI9TobgzKbM9/EyNntIq5gmexKqHE3hZTLpoEyRrf439w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6666004)(478600001)(1076003)(2616005)(16526019)(26005)(356005)(40480700001)(81166007)(7696005)(40460700003)(82740400003)(86362001)(316002)(54906003)(110136005)(70206006)(70586007)(7416002)(7406005)(41300700001)(44832011)(2906002)(5660300002)(47076005)(8936002)(8676002)(4326008)(36756003)(36860700001)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:42.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f52e28-0cd6-42d3-b6bd-08dbb63d127e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.

Definitions and directory structures are not documented. Add
comments to improve the readability and help future additions.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f71bc82c882f..14988c9f402c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -240,6 +240,64 @@ struct rdtgroup {
 
 /*
  * Define the file type flags for base and info directories.
+ *
+ * RESCTRL filesystem has two main components
+ *	a. info
+ *	b. base
+ *
+ * /sys/fs/resctrl/
+ *	|
+ *	--> info (Top level directory named "info". Contains files that
+ *	|	  provide details on control and monitoring resources.)
+ *	|
+ *	--> base (Root directory associated with default resource group
+ *		  as well as directories created by user for MON and CTRL
+ *		  groups. Contains files to interact with MON and CTRL
+ *		  groups.)
+ *
+ *	Note: resctrl uses flags for files, not for directories.
+ *	      Directories are created based on the resource type. Added
+ *	      directories below for better understanding.
+ *
+ *	info directory structure
+ *	------------------------------------------------------------------
+ *	--> RFTYPE_INFO
+ *	    Directory: info
+ *		--> RFTYPE_TOP (Files in top level of info directory)
+ *		    File: last_cmd_status
+ *
+ *		--> RFTYPE_MON (Files for all monitoring resources)
+ *		    Directory: L3_MON
+ *		        Files: mon_features, num_rmids
+ *
+ *			--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
+ *			    Directory: L3_MON
+ *			        Files: max_threshold_occupancy,
+ *			               mbm_total_bytes_config,
+ *			               mbm_local_bytes_config
+ *
+ *		--> RFTYPE_CTRL (Files for all control resources)
+ *		    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
+ *		           File: num_closids
+ *
+ *			--> RFTYPE_RES_CACHE (Files for cache control resources)
+ *			    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
+ *			          Files: bit_usage, cbm_mask, min_cbm_bits,
+ *			                 shareable_bits
+ *
+ *			--> RFTYPE_RES_MB (Files for memory control resources)
+ *			    Directories: MB, SMBA
+ *			          Files: bandwidth_gran, delay_linear,
+ *			                 min_bandwidth, thread_throttle_mode
+ *
+ *	base directory structure
+ *	------------------------------------------------------------------
+ *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
+ *	    Files: cpus, cpus_list, tasks
+ *
+ *		--> RFTYPE_CTRL (Files only for CTRL group)
+ *		    Files: mode, schemata, size
+ *
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-- 
2.34.1

