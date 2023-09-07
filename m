Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555DF797F63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjIGXwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjIGXvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B61BD5;
        Thu,  7 Sep 2023 16:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK20OGuKv/eVtPXLkDK5WaxuUGZBi7KSIrWhFZvR6Jm7ng50z5cdzNWg1XDjqXhGGejKz3flOAq2szmgCAahAuwwUKYzYVlHuQ7POeKcU8F0nDXIpKb9iYabDAEC9dhxaFJdwIVShTCT3ULjhZgFq+YszEfO81cmY1bzy8wOeExRYSIIZYO2p+Nh3P3id4gsaowEFno6enRPQPMbplz/xEVQthJWBVsRHZ5mR9suhz3PYRN710HBTqpruGq2bGC4vxUAhkU09Lh3RqD2uyqGcC4BryYpL9pna9sq6XzCN0tb6OEjKCL3cpCxXiKGAtnVuoZTCVwQi/1Vuz0xESJvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJJ8K5WEeyY2J+rKDjlmEIR/NQkyAUw1zmDY5GUlE5k=;
 b=SFpERJWqbeuA1J2gxKQ+bSnQ9rlkvD41lJ4RFzGO2OKK+Mxhz7vwPnGq/d9SssBbX8JsdrnP1Vez2FWbTJtwMtimUOb4ABZvSCh7O6GLLV0JmTQOINiNSr1LIfppyZeV/zJMu7Jg9GLXfBolyr2Ro2Jd/S8LqhsdlNbrqnCjmezuJfhPAkjJRZO8+YOs6r30eXIjQGso0HI7stOuS4MAdujlMcuH3HDWxSy+JAjUlyq2k670+pTmOciT61De/ZcH5ChSnKaOvSzPjQHcErNrxHuDiyHvVp3wngnhIY5K/GzqssLF9w7DX8JhYsj6NQJqsH0nzJBHFeUOnGxFWm47xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJJ8K5WEeyY2J+rKDjlmEIR/NQkyAUw1zmDY5GUlE5k=;
 b=gEJ6J4siX6hAMkx8QxDgjaTMlQld/KKOXpbu2ihtxLOXJeX6OKsYSz2S2XSlH5KG3ujXe6MMNNp8CjDGpfPzTC3lKrsrLGKY5ZiCEoeqIB1nJapfKMsjaXdJGHUNpJXBiNePWQLVgS3K4xZgH52gF9LhWoxIZWOgMepYCrzskH8=
Received: from CYXPR03CA0086.namprd03.prod.outlook.com (2603:10b6:930:d3::29)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 23:51:43 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::9) by CYXPR03CA0086.outlook.office365.com
 (2603:10b6:930:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:41 -0500
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
Subject: [PATCH v9 4/9] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Thu, 7 Sep 2023 18:51:23 -0500
Message-ID: <20230907235128.19120-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cba3b7e-c837-4c3a-245e-08dbaffd6362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMPO5pqVB86NOmrdZXCKDePR9xuM+9TmlrhAg/0TbZWHkoSRom15GbsF2xt5bHLjU976MhNgzGO2c4NXYeTyRw+13B/7Z/AiVjwghuZk4hT4t5jOVO9VOHFjYka4QOrAQeaqnzkhV0y803uBLo6pO3eOkx/C13TO5+SJsIZ1VtdStgD1bevf4ly8xpK7JA7FGR/G5HNYpmleggE8Te6gVb0iEHAAc056UKQZR6xX/DaEGHuMubhDZZf1grcbDFPATBTl+5fopPTZ5xLgCAQorL29M18Y2WgedP/GXNbl/rsCXy7ZMj162W15E91LftqHUK0QI5uNEnhTwhHRQATTMsZFhY/CK+Q3PnG1kNGXaqyuQUcLhofmwZlyMrr3yZaEcgdNdveVJOh8yTcufgckvkXZbYP3t+hUY3lmr8UgvuJa3Iiun6Ca2gpCxt6yH4VRlRqkIOlOSBT13kQYoFe2YDRKxtC29CgUsmr76hlfRmEcFRLvqTrfPxtmlBIAvBABeIaUE5FEzzesLsBYW/hNhgV4h1ibgjg6J8Lsj0tqDE6S4KoYcWB6ob3KHfI/BNus70FnjB/Kqo8lHko/Tvf1dn2MLJYDnb4+NVHHRq9HcygDUKFTZdfdDQeF9hyuyhSYVSufyd8hx43V/nKwrDF9iA1PK5cKcb661gwRyNcIl8+9DHz7SNlDiD+F21hD+OBDO/U8QDGvjU+1sziQlIH8hTE58rNDcv1cCOFG1l4ep+GrfBRIbKra8Nd67MnqBE8q1FucJ99wgPMQ+oPZ7sqHKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(40480700001)(36756003)(86362001)(40460700003)(2906002)(110136005)(478600001)(6666004)(4326008)(7696005)(8676002)(8936002)(5660300002)(44832011)(70206006)(316002)(54906003)(70586007)(41300700001)(7406005)(7416002)(47076005)(36860700001)(16526019)(26005)(336012)(426003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:43.0926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cba3b7e-c837-4c3a-245e-08dbaffd6362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2051179a3b91..c97578e3115a 100644
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

