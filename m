Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E447C8E48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJMU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjJMU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E38883;
        Fri, 13 Oct 2023 13:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCom/2oe2jO4XLcqsCEDy6PVP4bRr3HeaVa7cWSekZ1Eq1W+o6H0kItvsgIHVAPe5jOFnShqjJ/uvv0wAkSeCYroZRXyVlOJorP3Jm6GdlpjqQFsdcdcuCAmPZu1l4WRuzjZ8ZrA1RNTDdRbIGeaxgbqaMKmnHV38adqPbpvqNkAivbXb3TL9+S0n5kjXj3LP2AEjKEEQE840QuPa6jELNLMHzX+NRjKnil7xKKbJ6TkinC+9SHfwblMX0oGQVL/4B+nDv0fvMM4KUNlBxdyduliQkHTipcxU3YxxBe4EYftiy/fv6xQbnaYDntWTzshTq0M2hb0dfOVDfbPyet1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+cuwXqDoO6EAY1Xh2HSt3VpcRgwcwOk8iItpy7V0MI=;
 b=WSKU3U8YNJ6zwpOGuRB8zLV/EbmAO70jRFdwpbBf98ETuVREHlp/2Iy1ncZMH00w1TQuUoc/d2ODUDor2xTXf/dY9BUcr9mPE7ppQoMzMym6bxOgOvyNZb1BWn2Sb8WbgHEesmT8U3mVTZQg2sIwVgFn6pV6GhmgMq+uJQgEV0DfKaRu/klEpzOMuMmbPs+ED2cbM+xwpkyCpHmepoNMcjrySWnEsLKPKhB0WUk6jX/dKrVLTav3hQF3ZP737Ce/GsnZVOKrERbThVVGBbhAr4dPSGp8K4dRXTtdJtDEw1GyRU9QBUi/ieuHKulDmciKdRSY3jw6OHBQQDTcjfyyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+cuwXqDoO6EAY1Xh2HSt3VpcRgwcwOk8iItpy7V0MI=;
 b=HTVIWoO0Qp5BK+ea5i2uIvclK81MTUpoEQEee3su6pNyo0DmxUe3JLJpVfAFFZsL7ZvrnHu0zsg7aMM1asknpYeQ2NaqbA2K9VizDzu/OocbB53H77NmbiejMW41bR9ewU1IhjF0RQxW3+AUbZqVAwFRCy9OOhDTWNkDpg2e5/0=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Fri, 13 Oct 2023 20:26:17 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::68) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:15 -0500
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
Subject: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Fri, 13 Oct 2023 15:25:56 -0500
Message-ID: <20231013202602.2492645-5-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013202602.2492645-1-babu.moger@amd.com>
References: <20231013202602.2492645-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH0PR12MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7983b7a7-44fc-4373-b2e6-08dbcc2aa772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceYtmxmh1aVJ1Whj95nYdhj6N5NGw+6QVjurNLpIM+P8W6aVLzoZumj0NHIphOF1gKDJEXFatF5LgrFjAeJub4Tw/rW9EG9MAcWnyrwsIJc8Sd3+rcFernZ4bIz9PRl42Jgjhy4dsdleeutRqBMl+5nhqw0FmVX6pyNKxP82qXFLBWEOEwu3sH8LeUpOUKHIpL2HhH3CFvwOgjLNtsOhR4K9uQSb1NNz/VUUXn0sTnnrTOyJfVdwZitjm+RWvRyZUZRMcIzvCDHxk17JYtgJITbfgR0YKfgcfrVaO8PvE2eCmH8T6Cg5vapEkvYCB222TMJXce/4kPmVHL+R7X1NdeaYaVe627ahxjq4TI7Gwb56mGHkCTcoQ3GOjYnZSWhGgnKuJhDhsnVShF6owxQGpj7AA3Vj4DKj09uYRIJUWmUbHsKGpGQPo9jGBq7L9HvYRavB2tBx9BwhIWoiCPdwhSjY16hDdr1GCEZrwZemh2IPzm81QuQVuxdSykpl08ZbqSy+VL77TfMcwVqQSF1TLi70LcWAW0cKGmWfaLGAejQarUeLRKPRrubkypJDovUxnvwrXgcStq7LBmYgBlZc3p0kjGWfKtzSi840j27v6W0vjmnQ0RicDSbSricZU09aQX8ghRSrY9suw1sYFxUACNEJ4Fp/fwAI1kUnBIc9VMjXCY+EjG3+yayMslUOnazN1rjBl/hBP5aH5cLbV8K470+wgScNuObGg6hDB6T/LnX8Ur5JqgLA2IWlljJvhtPkaBDBnUab0hlsax0blXjQDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(8936002)(82740400003)(36860700001)(2616005)(7696005)(6666004)(478600001)(86362001)(47076005)(336012)(426003)(110136005)(316002)(26005)(70206006)(70586007)(1076003)(16526019)(54906003)(8676002)(5660300002)(41300700001)(44832011)(7406005)(4326008)(7416002)(81166007)(40460700003)(2906002)(40480700001)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:17.2280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7983b7a7-44fc-4373-b2e6-08dbcc2aa772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
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

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v13: Fixed the format issues in the documentation. Needed few minor format
     changes to address the syntax issues.(Reinette)
     Removed "Reviewed-by and Tested-by" flags as the patch has changed.

v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
     to Documentation/arch/x86/resctrl.rst. (Boris)
---
 Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 178ab1d8f747..1163da74f734 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+RESCTRL filesystem implementation notes
+=======================================
+RESCTRL filesystem has two main components
+	a. info
+	b. base
+
+	/sys/fs/resctrl/
+	|
+	-> info
+	|
+	|  (Top level directory named "info". Contains files that
+	|   provide details on control and monitoring resources")
+	|
+	-> base
+
+	   (Root directory associated with default resource group as
+	    well as directories created by user for MON and CTRL groups.
+	    Contains files to interact with MON and CTRL groups)
+
+	Note: resctrl uses flags for files, not for directories.
+	      Directories are created based on the resource type. Added
+	      directories below for better understanding. The RFTYPE flags
+	      are defined in arch/x86/kernel/cpu/resctrl/internal.h.
+
+	info directory structure
+
+	-> RFTYPE_INFO
+	   Directory: info
+
+	-> RFTYPE_TOP (Files in top level of info directory)
+	   File: last_cmd_status
+
+	-> RFTYPE_MON (Files for all monitoring resources)
+	   Directory: L3_MON
+	       Files: mon_features, num_rmids
+
+		-> RFTYPE_RES_CACHE (Files for cache monitoring resources)
+		   Directory: L3_MON
+		       Files: max_threshold_occupancy,
+		              mbm_total_bytes_config,
+		              mbm_local_bytes_config
+
+	-> RFTYPE_CTRL (Files for all control resources)
+	   Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
+	          File: num_closids
+
+		-> RFTYPE_RES_CACHE (Files for cache control resources)
+		   Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
+		         Files: bit_usage, cbm_mask, min_cbm_bits,
+		                 shareable_bits
+
+		-> RFTYPE_RES_MB (Files for memory control resources)
+		   Directories: MB, SMBA
+		         Files: bandwidth_gran, delay_linear,
+		                 min_bandwidth, thread_throttle_mode
+
+	base directory structure
+
+	-> RFTYPE_BASE (Files common for both MON and CTRL groups)
+	   Files: cpus, cpus_list, tasks
+
+		-> RFTYPE_CTRL (Files for CTRL group)
+		   Files: mode, schemata, size
+
 Resource allocation rules
 -------------------------
 
-- 
2.34.1

