Return-Path: <linux-kernel+bounces-14070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E482178F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB3E1F21A07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFB15D0;
	Tue,  2 Jan 2024 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2fSR24Fx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AD15A1;
	Tue,  2 Jan 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZHdqUe9aJpNzVdFIg8wYAeKB4dAkfbVdrJV56aMxyvMYmVf+VUXdzp7DJbZGpp3A59WrKQTAhqM6alASkkz+bZ0jC++fnfQiQ8Ng4u0C+QPRTuQkYBT4ZrIFjVs47J0QUO/4v+cV1DA4kIgHV3qv6WDfKJJpBLUOT/4SmcCxrRtmsIVFdk4Si0s+dv7RKliJ+TNOWZsGQ5eNco7TF5idgQaLWdBWI1/B7nLpN9OiocBVOJ5iZGY40sTRw83wc3XWjHa+j8TLJ8PhVk6aXdetP/pFnFMgbMRDdI8c/dnz8K6ueVsXlJFxqiAkEOCSr2JWXso3/MJyHRaMjblgHnXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlvVQ4BRp4JFq9mRJxrYaCb4qN1pFpK5TMOIPbCUvoQ=;
 b=hSEbLW1Ow9Q86o7fVTdvVrXMYsiyZm3VIBU0TXx8+dIK+QCo59BGor8KQ4EIUI0tuyT6f1FIhXHMWNO5SuuiXTUHGQWfxIIYiyzcY9o+QJ0y8nyuOu77AO1IsXMDWGoQ2g18X03mvpBO/5qZAJOvyZBGthITechu95rn7y1VCB/jOVfRpZbsApvtd8NipEsExTzEJ/ELbKFnXHrNJmQVQh0/mDCHjb1x4gzxIsvlPLjRiuuD3Cn4NtStyCi8YJZ3W8FnYtGYhmD5+nw0N5UZf82OquBT0wjasQj58/B1bbQMPb4BP+FVhMRJ3js6Vqt/ePSW9Bm3FsimWVNSQUa6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlvVQ4BRp4JFq9mRJxrYaCb4qN1pFpK5TMOIPbCUvoQ=;
 b=2fSR24FxTyIB2xsyx5IrcHS9M7hcvcxOaHkPfMhw7ReOevR3oSQkd9vWmtwElmeMM05NU6iPyWq2LlaQ6qs831WtNYAJvdrMR/HDz5wVSaX2oTgPiwNH0/pb2CDRx2qWSS4d2iMoRG/3erCwZv7wsJJhnbJQwEt5GXqE2Cgq+KU=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:02:24 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::72) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 06:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.1 via Frontend Transport; Tue, 2 Jan 2024 06:02:24 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:02:18 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 1/3] perf/x86/amd/lbr: Use freeze based on availability
Date: Tue, 2 Jan 2024 11:31:28 +0530
Message-ID: <d75c92b6bfdd536ad8186afaea6fb7819c64ab28.1704103399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704103399.git.sandipan.das@amd.com>
References: <cover.1704103399.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|BL0PR12MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 120429f7-fcff-4618-2ee3-08dc0b586412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uL2AN35YYc6uC7TV+LFZs6ggZq8laWT28OCrruY4ASy1B44OR4KKxY+w8Rka6YHh6U4E96mlUkOB50r5qq0Ft95vg5eWjK7yh8B5TlvSUH/Hs44J3yZ+BlENW3IDBWwWSnn8POeBBvvOTlPEvnKloptAQjEaKd0Jb1OEtTqUodPwudBdREzPOsKY+EvxGGzLtDR3hxNPv739AVG+ReHnIfvmCK1jw+xrzBV/R8qEKaxENReg51a69XBJ/bpAhPsThZsPNoKG0CLqfnDaLdksmSTysdUfasi1lohxaoW9TOVaiHZXoL50pWDtnhfvB0lepL9f/PE6OT2SB/wG+U5kSFGj2AwuGVBGt/O76SeiG3FT4CgKnPNAslBXPlSAiqZbi/QiSSpDcUMi3N3Y1BvEH7yk8a6j/iJP9MhmByGf1+cMW6n0+G66Ho1H2MuNSSWyotL2lBXoMxIhZZY7UnLtkWjB+AYjzIk38zBmEAkCfrwCGEBooSTOeHJO8OfvfzXDymSueMZ9YblQmIkTEPur5Kl8au0FdIfXlPl0/h6WHGfX2imLfToIc2ssJASl05SRduGlThDx20LLZuB2YuEJr9cgU05k+3u2kLZ3hGGTqVcoORkJjL51qlFDvC1QA3JO/MsrU05Y7UIyzUANPkW8e9VlCaKiwp1XL7v/E6QqjKvW1ha5UqUwYPrmpEBsrY2r463fc0UHIaCABlQjv3hesWWtc1tmoNZFWuiPuEOQ9hA1K54S66mdlM48R4TiSI3R
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39850400004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(46966006)(426003)(26005)(2616005)(336012)(16526019)(36860700001)(81166007)(356005)(83380400001)(82740400003)(47076005)(110136005)(70586007)(70206006)(316002)(54906003)(36756003)(478600001)(86362001)(5660300002)(7416002)(2906002)(44832011)(8936002)(8676002)(4326008)(40480700001)(6666004)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:02:24.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120429f7-fcff-4618-2ee3-08dc0b586412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995

Currently, it is assumed that LBR Freeze is supported on all processors
which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
the feature availability is additionally dependent on CPUID leaf
0x80000022[EAX] bit 2 being set which may not be set for all Zen 4
processors. Define a new feature bit for LBR and PMC freeze and set the
freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.

It should still be possible to use LBR without freeze for profile-guided
optimization of user programs by using an user-only branch filter during
profiling. When the user-only filter is enabled, branches are no longer
recorded after the transition to CPL 0 upon PMI arrival. When branch
entries are read in the PMI handler, the branch stack does not change.

E.g.

  $ perf record -j any,u -e ex_ret_brn_tkn ./workload

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c         |  4 ++--
 arch/x86/events/amd/lbr.c          | 16 ++++++++++------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 4ee6390b45c9..ffdfaee08b08 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -905,8 +905,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
-	/* Read branch records before unfreezing */
-	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+	/* Read branch records */
+	if (x86_pmu.lbr_nr) {
 		amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index eb31f850841a..110e34c59643 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -400,10 +400,12 @@ void amd_pmu_lbr_enable_all(void)
 		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
@@ -416,10 +418,12 @@ void amd_pmu_lbr_disable_all(void)
 		return;
 
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4af140cf5719..e47ea31b019d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	( 3*32+18) /* AMD LBR and PMC Freeze */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..a515328d9d7d 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


