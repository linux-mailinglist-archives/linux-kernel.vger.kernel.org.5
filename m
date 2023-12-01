Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA728000B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376597AbjLAA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376660AbjLAA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:55 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3A198C;
        Thu, 30 Nov 2023 16:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP+XVe3W9MzON0CmtpiZl2PCTcKNgRlDaAIcejCFy+pjFGL6VZdTBb9j92LFHyLOSDIXoWWF9mpyHjOei9rNkE+90uzleiXLdYQukG05WeFtYXCJidtNJrDozEUH7/eI6HD4cu3JLPi/PphG9RIpc9mCafKIro/Z2jkg44/NB2PN06Os5zxvM6XR7mSX3CgScr4ZcaLr652p+zTdeWidndekbmkrA9O/+bz1q3o1ZDJnHysMDsNY5Fp9waahVBsZS3mRKhkzQVe19A3AsIjuFg+ZoUPMWbg1GYX8+B/p6OF8FCD9QgXJYO6uTVzpbZEa/E5BCLIrq4HIJFUXeywbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8OF7Qqyvrszj+BrHp781vIQT51Ku/jK3w6TgA1FvgU=;
 b=ivgEwzl5uGdwbzitkJhlJe6wJT2sauZnCRlW/Ygba63FAV5xrAa3/wPP4QTCpZjWkESdcdleSvOB7FFbyfG4kRIItwpucXrqgRaLBFilZIbBnXyNSR+zFimNRQa2hNOYZN6k+h0qlkOapMylkFFZaJ0bN4mlu3AFziruFS0Mx4tMVHwc6ssk16kVuHHwoZ1Q0scsV5U8KI2NXVs8lEWLu7zuEMt6OnLJMzMdHry2lPFY/Uc2Ob97snAte1EyqagEaluJEmFXrcZXonffYOHiicahSP4l5oBg/TPK+YSFL6z3YJER4wWEHWPbZ23bFzgGNHK8i8ZmGFYXcYxx/kbCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8OF7Qqyvrszj+BrHp781vIQT51Ku/jK3w6TgA1FvgU=;
 b=SuFJa6DlZyYrJYNdYEwXZ5vUzxr8XcvBtmnZD1AbCNVuDvUxQ3m5N4o9q1dh/fq14UG/N3wa6ryp6Wz7x5KwlV5oOMChrzTgfDanpafLLBhkfKSxQCcTYzKhEbeO7nCh18CzSwDZYxaGlWCnWgX5dJOZ7lMrwied3t/3tKmsP+A=
Received: from BN0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:408:142::18)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Fri, 1 Dec
 2023 00:57:46 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::d6) by BN0PR08CA0002.outlook.office365.com
 (2603:10b6:408:142::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:43 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
        <jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
        <jithu.joseph@intel.com>, <kan.liang@linux.intel.com>,
        <nikunj@amd.com>, <daniel.sneddon@linux.intel.com>,
        <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <maciej.wieczor-retman@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH 11/15] x86/resctrl: Add data structures for ABMC assignment
Date:   Thu, 30 Nov 2023 18:57:16 -0600
Message-ID: <20231201005720.235639-12-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: b35c1e24-f1cb-4361-262b-08dbf20887e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2PF84T2vcfUvMASw3+F+ZXu6IOBI0m5kj43/fUxx/usp41RjAfyzkPk1Vzn8tUc+pHKhVwFHWi+RzwiktyLsP0Ux7bSKsFGWUy5+Ny+Eu7M4aOVebb4cb4KHW8i3fM3YD8fRJmfCwTG7eJTN9rn7XK+NnEuTreibDsXlxDZZnIVoPhZxvRGETsmddPo7JxwvI+YNQypO0GNzEbvKchfw8jIEZTTDbsGmcBfzk9MrUzdRRgDNidTA1ocirrQBYDR9EHDB3d2aPCZBPNOGkIpHcPhxbFZwsBWR9q+vjT9KnzOs9uD3pXLGD1QUSMXBI5wX6H6NJOAF1d3WW7kfIYgSUK7MlahVioO5+rPfyDfa7vdC/6Auvj/F8UhrKkhtMakcvwO+au2CNmAqBOAKLyPgyeUeYcqvQDGr4cpj3NlNm8HPtUOym5gzqGtSgjj5N3RIcefyuCEN9Q5WU+ZKVK2gb/SrBTCAFxG/LJvppU6fJPH4V718riFku9xfClo8SMZRVr69aNCi25upRqSlkzItsCX6IgL4VG+Jdscs711n+6SwumUCcqWdm2CJELYoPLnCh+l3R4e3fpklibgsMZZpcfMfvLWJQChEWZSlm0wPTKXBUlKny7I7oc4kfxvs8qsgX0FHh2KTpfy+txMpGrxWbLEyzMnddYVP69DRU57RO6vuA4/pcL0E9BoxcMPe3bg5HQTGloRRKWJaz9TulqFje0f3XUWSyfCyJSwML5ormQRIags+/azeGWgoEebBSopRUBYxz2Wh8xBGT8PwvD3OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(36756003)(7696005)(6666004)(2616005)(86362001)(26005)(1076003)(70206006)(110136005)(316002)(426003)(54906003)(40480700001)(70586007)(16526019)(336012)(4326008)(8936002)(83380400001)(8676002)(966005)(47076005)(44832011)(36860700001)(7416002)(5660300002)(478600001)(356005)(81166007)(2906002)(40460700003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:45.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c1e24-f1cb-4361-262b-08dbf20887e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABMC(Bandwidth Monitoring Event Configuration) counters can be configured
by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
while specifying the Bandwidth Source, Bandwidth Types, and Counter
Identifier. Add the MSR definition and individual field definitions.

MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.

==========================================================================
Bits 	Mnemonic	Description		Access Type   Reset Value
==========================================================================
63 	CfgEn 		Configuration Enable 	R/W 		0

62 	CtrEn 		Counter Enable 		R/W 		0

61:53 	– 		Reserved 		MBZ 		0

52:48 	CtrID 		Counter Identifier	R/W		0

47 	IsCOS		BwSrc field is a COS	R/W		0
			(not an RMID) R/W 0

46:44 	–		Reserved		MBZ		0

43:32	BwSrc		Bandwidth Source	R/W		0
			(RMID or COS)

31:0	BwType		Bandwidth types to	R/W		0
			track for this counter
==========================================================================

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a2086aad580c..ec85f6733eda 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1124,6 +1124,7 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bc36acd152be..ca4b551dc808 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,8 @@
 #define TOTAL_ASSIGN			BIT(0)
 #define LOCAL_ASSIGN			BIT(1)
 
+#define ABMC_MAX_PER_GROUP		2
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -168,6 +170,7 @@ enum rdtgrp_mode {
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
  * @monitor_state:		ABMC state of the group
+ * @abmc_ctr_id:		ABMC counterids assigned to this group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
@@ -175,6 +178,7 @@ struct mongroup {
 	struct list_head	crdtgrp_list;
 	u32			rmid;
 	u32			monitor_state;
+	u32			abmc_ctr_id[ABMC_MAX_PER_GROUP];
 };
 
 /**
@@ -527,6 +531,24 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * L3_QOS_ABMC_CFG MSR details. ABMC counters can be configured
+ * by writing to L3_QOS_ABMC_CFG.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long  bw_type	:32,
+			       bw_src	:12,
+			       rsvrd1	: 3,
+			       is_cos	: 1,
+			       ctr_id	: 5,
+			       rsvrd	: 9,
+			       ctr_en	: 1,
+			       cfg_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1

