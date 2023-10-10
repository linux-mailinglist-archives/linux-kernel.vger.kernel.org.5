Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6957C4588
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbjJJXeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjJJXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8A9E;
        Tue, 10 Oct 2023 16:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4jBXStRBUdy5Ils8clxwHi0SVoWbqNn4+hsaANrRs1nXGbmbHMKiuQFzJkPFUQyqUqtDXmqAVnhba8ZlP2oBzriDpTmDg0rDmhqC6x+8IQB/kEB2UTF+Yy2hDlsJ4aMKHbnozGdK8c+Bnht9HHcHwEOOVi7xpFUQPmrwTYFbDb1iLPRwM0jbXX5h/msmh9pO4V9SbAquZCGwmoReeqoW6JphGSOlClh7MszxO3yEwEHyuW+Qu0sYG3q+CliovqhsC6BsN2292kBc5yOQdu1a1RxMs5nBcj7DBtz2+9cm53UqjpFy0H0ZUiO6QObnIVw2adBH4lFGlZLzbmDktUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjCrpoDVtV6H0wD3sT5CdSWgeYIuhdHxg4IlNeY2I5s=;
 b=nmAuaVn6LdKz7wUV5n0QlyEQ8XxMk682Cavuo0K129OdvFopaM2ZZFst3ohu8/5VF+ZfEiSCKNR4AoOGr5QxXlKq1IjYW83rbVoJS8WoKRu0HC2/7O9ndRXGJyGRaG4y04DfcywA4wuJSgxE/R+5OKuEDXM7PWrSdo7pOsH9wKYKqHjbI5lLSUeHIf/CxrxkofvCD+D2nftjPnsbi1pFfkqV/vEtrkK9i1wesmR4ulpWpTMEbFhXoOd9IKjLmYQgrg7jna1+IjI8ANsnhYSLjXtfUlNztNyxiGYARgMMDhqPAju526hmXucFQM24TP0r6Qxzah6e1sqDzp+YH4yoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjCrpoDVtV6H0wD3sT5CdSWgeYIuhdHxg4IlNeY2I5s=;
 b=iKh/s7RhVN1xkTIRil2KVGxrS7FTt0QSlVbc1CDrrmM647JPzSeVUpLx9Y+UTEghHltwnm02LSSxswxL4ee8jf9qgazWNkzw6mtm5kOBs1lraAIv/J4N+rEwZBKEdTlnsJxlkvYzcvZI95y9W42aMLsureF53y663zE2sMzEiAs=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:33:50 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::7) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:48 -0500
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
Subject: [PATCH v12 04/10] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Tue, 10 Oct 2023 18:33:29 -0500
Message-ID: <20231010233335.998475-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 02edfb17-1eeb-4314-0642-08dbc9e95b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTuYAQdCN3Lrn/W2B9xpHvFvsrMitLK7Y2QPnCUH1UlvzB+BmhqSD7xiNwse+nGLRt20BVSWp3AZZ8WzU9qIMvdZCJe9KiMrAT7/7wsIItcE+6p3907FyuyM1ytKuPdiFRQvBweJ/at5+nmpi6gvaeOqzovDFIlgh+2iFQhdlAlb1H/DwisA3ML9nds4R5Bg1tceII3U+VtmW5rOIDIIRn9KZpNEUHoEBwftX5DkreYuLwu2Y5UTWiQsh/+dz88p5Pxi1RVhAPRcUmZw2iEJ7thDxhqWiVjE0UX0GBFPmOX8qpiS2p6Q5t4ZH/HMZI+SUCIEm3z7ITuBtYHPqLEnz3+Me8JarNtG0V+m8Y73DwBGFqy0FR3LKLuHcJ8djo/c7v7rs33IiM3D0F3pzM2bevwilBgBdEKLBsLWa0DS5MeXbivkSvKbXHaRIpbIV/JLxlWHrEYn/WGUIBtmuBZkdwyEU9dCYKOE14Kn5MiLXRc5ry9QWAP/aotrkaB+ebtidlZCAaqVyAaAhPfH4sGrOmPypvdCuGU7Eq/xmFin+qUq1Mssdrp2/t4PtepmY3dfWXTKnwqaS1eST+fmpPJXz17TwlRfkc1+pE666ucslxO5u1lwmBqRTFKI8aKxvjta8hudihq8teYM3w4VPv+kKrhsF5Uy5qiI9QRhG32J4QH0M56rZWBoq1S6BEVecVZlyLOTwMq3QwMkFvIKoFQ1lvYkgVs2XwoKG6BxhRWHU/rtqJ9DbxGNuMrlZfIJ9T72g9IFEP0GB0RrSvLWsStSsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(36756003)(40480700001)(478600001)(7696005)(7416002)(2906002)(2616005)(44832011)(70206006)(70586007)(7406005)(41300700001)(1076003)(110136005)(5660300002)(6666004)(316002)(54906003)(426003)(336012)(47076005)(26005)(16526019)(36860700001)(82740400003)(4326008)(8676002)(40460700003)(356005)(8936002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:50.0670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02edfb17-1eeb-4314-0642-08dbc9e95b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.

Definitions and directory structures are not documented. Add
comments to improve the readability and help future additions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
     to Documentation/arch/x86/resctrl.rst. (Boris)
---
 Documentation/arch/x86/resctrl.rst | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 8154e9975d1e..520a7753d829 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -362,6 +362,66 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+RESCTRL filesystem implementation notes
+=======================================
+RESCTRL filesystem has two main components
+	a. info
+	b. base
+
+/sys/fs/resctrl/
+	|
+	--> info (Top level directory named "info". Contains files that
+	|	  provide details on control and monitoring resources)
+	|
+	--> base (Root directory associated with default resource group
+		  as well as directories created by user for MON and CTRL
+		  groups. Contains files to interact with MON and CTRL
+		  groups)
+
+	Note: resctrl uses flags for files, not for directories.
+	      Directories are created based on the resource type. Added
+	      directories below for better understanding. The RFTYPE flags
+	      are defined in arch/x86/kernel/cpu/resctrl/internal.h.
+
+	info directory structure
+	---------------------------------------------------------------
+	--> RFTYPE_INFO
+	    Directory: info
+	--> RFTYPE_TOP (Files in top level of info directory)
+	    File: last_cmd_status
+
+	--> RFTYPE_MON (Files for all monitoring resources)
+	    Directory: L3_MON
+	        Files: mon_features, num_rmids
+
+		--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
+		    Directory: L3_MON
+		        Files: max_threshold_occupancy,
+		               mbm_total_bytes_config,
+		               mbm_local_bytes_config
+
+	--> RFTYPE_CTRL (Files for all control resources)
+	    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
+	           File: num_closids
+
+		--> RFTYPE_RES_CACHE (Files for cache control resources)
+		    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
+		          Files: bit_usage, cbm_mask, min_cbm_bits,
+		                 shareable_bits
+
+		--> RFTYPE_RES_MB (Files for memory control resources)
+		    Directories: MB, SMBA
+		          Files: bandwidth_gran, delay_linear,
+		                 min_bandwidth, thread_throttle_mode
+
+	base directory structure
+	---------------------------------------------------------------
+	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
+	    Files: cpus, cpus_list, tasks
+
+		--> RFTYPE_CTRL (Files for CTRL group)
+		    Files: mode, schemata, size
+
 Resource allocation rules
 -------------------------
 
-- 
2.34.1

