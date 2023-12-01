Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5728000A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjLAA5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjLAA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D410E2;
        Thu, 30 Nov 2023 16:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBhodxyy/3PqzwibUeo2C0QHUq4TLvE7/VbKNLIP3POMjtkXpYefUE/jnRQThVl6sQWYeF7beaheI30CtN/l9V7zbuGFDEJoFIrcoAQRXiAw/AvgNO+ZPzOFwAgnfY1FCcV20m/ISQ2uHRM//9eJtVm5R9TwpNJmv4hpRlPeAZ0HKw7MBXXGrZe8AH5F0zMjw1Io7HReiTB85gST6u+lQ3tuBthNXQ+xUfKDYWL3rFZOaJpVTN4cuPvHXF3u/QsUUgDS2JUKvU899OF+WOUQ6OEPzBrki5I5JeVHFCejvJdzVj7dS6dCiaV4AxnqW0S3CbSdxSI23xQBtINcaRwAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAUs2kEFEcbw6N5nkuzxlVSz3dGrY8GDAh4BH31LD+s=;
 b=EFTdW4BF37S4yeBt+4eF0WPl/MPOXeWzBaZsgNraKOfQfO8QUFl1j9CyNXfgCbcx/qUHsIWmojpZJ8l/4Geqep2VfH3uMCo6Q0i7jVxYHyNQHMOOFL0Q2CgMCHjcWMm48uTVxZvG0l+RdcuwdtmRe9+7OayweTzJfg0G5zMZCyCXx+wWEYQexBfEOrdm6xD70IDRgLFAkw/txhu64h8uuMBm/pBIRxfdtC11ghSjfAeNqjIIQW15D+8NEkPNGXeBm/uWR/YpRJJ4yThXOG8OqKQh8a40W7SW+nqLR9f5ptMeGBSddPtm/MsgfVxS4yxlkgtlbHLsZH7Lq+XPlKBBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAUs2kEFEcbw6N5nkuzxlVSz3dGrY8GDAh4BH31LD+s=;
 b=UGZFGp+pkdRUtploTc1T6gbGH3kZKrt2JAPcmdvEcjf9w3uNxa12HxvtgfyEM2/3ZlVz9bUEn/w47AkYOJvEYQZDzGftDPC+ozH6mEsEAgrEh7zr4Wefa/JgogpLx4+iiNHNCiTd6hjBNSLIy6K/vuhlmW+/omuuiTTBJTRO2Lc=
Received: from PH8PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:2d0::21)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:57:32 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::d9) by PH8PR02CA0010.outlook.office365.com
 (2603:10b6:510:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:29 -0600
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
Subject: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth event configuration
Date:   Thu, 30 Nov 2023 18:57:07 -0600
Message-ID: <20231201005720.235639-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 380d9b1b-d262-4ccd-1009-08dbf2087ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJKbQNJDWQMI42J2EZ9Q5EMqxO17sLtN+rSEdVI9CTB+h5YPMoVbY4Oooa8K9dQogqLLAQkDkMnaYFMbuxsJcE5pUW3JiGKhbOQ2VcZJvGOFHAmCHPb/xT8wEcj+QI1Rt+8IAcqRHcaaSd05zVZUBg9kMrJP6DNCMAVlGGIRnZYIHL7tU6wPK8XHVVPiPY5AnyFg2AlFy2iAyOO8IoiMX26LIT/14PwosLc8AXbsSHdVA9ch3AK0ICeSM7wLzEGR1HOc4+QKSMDydG8PrgOp5hIZxzQ6JS80M6lhIr4O4yMqpwm1JSY5msbBnaEbVJq1rFfT27m+b6hlskT2n38DjrOs+WJ99/7NyO7ybX/UbGOuAaEBZCg7xEVZI1CitREx4kKzQ0Mi5FS9pnzdH83wFp7BWG89ZYHliSC5orz/SJCkMYdaENSw1mN3GPs93WB6TJT+D5SgOk1M0jCFZDn5ARdN85SVtOLxh85PrWQeHtpE4QsdmMY4i7LJqqwgdXwvbYeyQN6hmzjnOl8IASXPC84Iol5x3O2SnxMV3no6RjWr/UOHEyI0z7d7xnx3f9Kj9nOaqKwiB+oofKDN740jvzko7Jqs5BMR9k8JK1K1EN0IJ6NiD4zTzYwh6zjXdy/VjiuphBZCAKVLRZvOdeVRRZ5NsiH4nuRqkMVFlEn1v9IifSWy/4uZWL8e8YMEr2QrZIk6QbILFiaCEmOlfg2PZvMGyW+i2k4YrliU4VlSBrCuy6jnSHk9p6/Jh2WDH2Px7u2E/f7ljIW0Pq+bPmn+Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(36756003)(54906003)(70586007)(70206006)(316002)(110136005)(2906002)(41300700001)(44832011)(86362001)(40460700003)(5660300002)(7416002)(426003)(81166007)(356005)(26005)(16526019)(40480700001)(82740400003)(336012)(47076005)(83380400001)(36860700001)(1076003)(478600001)(966005)(2616005)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:32.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380d9b1b-d262-4ccd-1009-08dbf2087ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. Currently, the maximum
supported event bitmask is hard-coded. This information can be detected by
the CPUID_Fn80000020_ECX_x03.

CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
Configuration] Read-only. Reset: 0000_007Fh.
Bits	Description
31:7	Reserved
 6:0	Identifies the bandwidth sources that can be tracked.

Remove the hardcoded value and detect using CPUID command.

The CPUID details are documentation in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d2979748fae4..524d8bec1439 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -50,9 +50,6 @@
 /* Dirty Victims to All Types of Memory */
 #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
 
-/* Max event bits supported */
-#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
-
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -117,6 +114,7 @@ extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
+extern unsigned int resctrl_max_evt_bitmask;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..c611b16ba259 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -127,6 +127,11 @@ static const struct mbm_correction_factor_table {
 static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
 static u64 mbm_cf __read_mostly;
 
+/*
+ * Identifies the list of QoS Bandwidth Sources to track
+ */
+unsigned int resctrl_max_evt_bitmask;
+
 static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
 {
 	/* Correct MBM value. */
@@ -813,6 +818,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		return ret;
 
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* Detect list of bandwidth sources that can be tracked */
+		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
+		resctrl_max_evt_bitmask = ecx;
+
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..6c22718dbaa2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1547,7 +1547,7 @@ static void mon_event_config_read(void *info)
 	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
 
 	/* Report only the valid event configuration bits */
-	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
+	mon_info->mon_config = msrval & resctrl_max_evt_bitmask;
 }
 
 static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
@@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	int ret = 0;
 
 	/* mon_config cannot be more than the supported set of events */
-	if (val > MAX_EVT_CONFIG_BITS) {
+	if (val > resctrl_max_evt_bitmask) {
 		rdt_last_cmd_puts("Invalid event configuration\n");
 		return -EINVAL;
 	}
-- 
2.34.1

