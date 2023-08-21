Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C39783657
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHUXbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHUXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAFCCFE;
        Mon, 21 Aug 2023 16:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0ChFB8NVACV6prCSI9B8NhETl4v+raUiJO5vYTR5fTi1SF8NlR+dMWE8o8JwOlGntHgYQxV6vvJtMDUfjVOFA6E3+yTRub2ENf0jTGhcNHqxXdVQXo0muA6wZ4eCoiRanTmRCoVwC87QBlTXOGiYe6nVXe0zqSo5Ui0Il0okkODT4HQtXqqUSDuOm+cyC5mW5D/sw2dD7IBZc+RvJWK/GoBCktGUgSHk8OBgA3oMcshnr+M4/B6YgVg6mO/2Kuhm0bazyKJw9IW00eNVETOdoKwYvE9YLOmtep1k44hf2M9i/+UHD8whwGOIVjuWOILtTtrr7bXx3ga1yDvaAw6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q5QuY8M0CrOLhESkFdyThNpHD2gSCTJijwjIGKA9BI=;
 b=eLQ+o9tMLzqAmaZABmPb84qyK9fhAMUSqZ110AyJC9c0+LUv4yD3CAM9a5UljXARq3q7niWckN1CsRq7qJLA7otAuI8hj3pwuCY0q6ECFx6dbKHpx7WMWWM4dTT+PATEkpY00tUImAsytE4dnqU/iLjhOTW4Gr+D7Q0aMo8mHKyHI1zuPSV5rhjcgqYZ1qjLBw8cHihSY8BX1M4MxZK2PKZaJ9iVbM6uxwyTJ3kkKpseWoCIrPo38MCg2GdRxBASGh89f65g89eLVIFaeCcXluIYM8RwVS2TJyvalF1A2JwtN77Wg9LhiHpNhrRtLcNJBwclJF9Ny0fQBHVbEvRIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q5QuY8M0CrOLhESkFdyThNpHD2gSCTJijwjIGKA9BI=;
 b=QVUPO2Sq6w7Xnv41L8jdVm6+t8BtosT/3IP+5iq8HHUYP2iGkjV3iPJGHpMeboPzOJ/Mo3LJ0BhLQJFB6UGCgDgNxfIMFc8zU2m0UUk5zU5Ub+o1W5rkdyP6UYwrCKyUhJLEu3dyvNqhmFzkTdJuy/WhWozKFc5hfYRx5ohAN0A=
Received: from SJ0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:a03:2c2::15)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:31:12 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2c) by SJ0PR13CA0040.outlook.office365.com
 (2603:10b6:a03:2c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:08 -0500
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
Subject: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Mon, 21 Aug 2023 18:30:44 -0500
Message-ID: <20230821233048.434531-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 596a9590-421b-4a5c-7f1d-08dba29eb473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw24rV0Er5Imsb1ZttYhBrGLATtZ23YPLmqedKuN6LqJ3YvqPqmFLYByBYOUsw5CR8GlRLZuELOGdILPBCTa7iiaqseDYX0/88NpuaZ+6/EIRqqVawN2ahEtxTfrHIM+TlKdR2CC7bMtLG9mD0oyoOBtntrt6/5/RxEkekr+LQnivDzGfE3mWSm1H5UfQ2M8XoO1g5+zlgSZwIiSAPQKtrHNNVQBft/6OUh1HqBX11wWXsPwgsy78S/0V7AIEPAblx6oeQ6jouq0ypjGHmy1fukG8C+1NP7GGaJe9pI8e7b1qOAmt5erxOXi02ghiP86SMul8HmUWhg+WaQctDXu4rP2aLFyYAhJx4ws6GQ+Qi4xzNUf/OqYiF0K0A1GrrljxFbX0mL6JUrydP2LZZEMc83gLddX+GPYtUeaOSAjSI3CtciQZs936FbWD7acJQmL/KTtgdPTAV8mMKIJW1fTv1f+nVky6y5cGi+IlrQdd9kMrS+nevilL/e0ha8bZ7HwvcsTl+IDcU4Z23qfn80NDGKm176HnpQea5ZR6ets3EWtngxHZQ0XoE37LMRwxN4g0jiHf/d2ojszTnjA3FcYnf73MzO2/Yv9/xeMuUH/xwnUfgWtRJDjphj7bvtEimQvpPzn191w4mPT97Wiy22p3gzJLO3sFJN+frxH1shU//k9zXVsPCG7esaqvpXfAzIwsqSo85NNFH57i/xOflahPOEpQ1ook0lvXg4VLwqPhDS363Wy/SbTEAK5uwSxXasLhDjsW+sFQ7rgT12uZT/crQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(2906002)(7406005)(7416002)(86362001)(7696005)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:11.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a9590-421b-4a5c-7f1d-08dba29eb473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
 arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2051179a3b91..b09e7abd1299 100644
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
+ *	    directory: info
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
+ *		    Directories: L2, L3, MB, SMBA
+ *		           File: num_closids
+ *
+ *			--> RFTYPE_RES_CACHE (Files for cache control resources)
+ *			    Directories: L2, L3
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

