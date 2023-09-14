Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5F7A06DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjINOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbjINOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:06:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678131BF8;
        Thu, 14 Sep 2023 07:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFvX8G5V7unwk+ydmmT6i9JupXIiiedGpfFgvtL2WHkQC7CqwrbGnjpWVwX71htjGzheq6sDztaqApun6E8Jp3Zpr+g6eom/qONOaOdXu3o6wzsbKHjUZbZbflRYqs9fXU8h8OtDsoFqwFiptJ2dBc14j/psNULrNOxXducaTBzfzFCC13Q7fn3QZpsOvj7acaIgYr4YqbdM7rYSt7wfuGW7b0MKTmEav5NvGSfScdQUA4Ug3vawxfXGL4NbJV00ybl+lfEwlbZbvocy331DsxgLOqGbxsCtdA/m9r3ANxbKi/ayHtKd3BKCHzS6UFpz6RkJtSdpvWdaetCOJWn1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX0TiGt8sPR/7d9wQa+rwjxiuTN0AN+4ZeVCzEOt5BM=;
 b=c1wC1NDF0zO5xkHY/iiw8678W1NeDGwgWeHHlpHswuT6fe7q6VXPj1iFTrwfvYmBBiZeHDiINhEwNr5GIGo6DVInTsb8sM/OMd68Bwi1wNbyL1jGMgINgUZe9Cj7IQOpWh13JaSS0WepXGQ56WUyGnzWHnWwKeCJvJIADaXHNgMAPmcArmkOFZivyrbD4rnfdlAQKirtY3N6u8KE5SOHHg/FWPMCu0n7DfpZ7T9O47sIqnBiO10SFhLppPzRjZzF4qYJLeUNQGDY2cb0yBqXFZUZPYoISxynMkPOrSWA2smmNFFW6ZsZrWNBsmVKPubA4Q5BzhqTedbpYph688vOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX0TiGt8sPR/7d9wQa+rwjxiuTN0AN+4ZeVCzEOt5BM=;
 b=YRBGsdau2eC0WOgKhmE0J6/8G+38znfE2SIXYb5c6VajWgDznIts4Zm7gg6uzYIui5s82bQiOwoml7EN0ITwwIqJ+5AfZlZHKoW34699oFoRYjxyqEMtPqNQSM1vG8zvQxciSkJm4phfVIXgUL7TK15V02M7WWalIge/Od/fmnc=
Received: from BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 14:06:47 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::9) by BYAPR07CA0026.outlook.office365.com
 (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 14:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 14:06:46 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:06:38 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <x86@kernel.org>, <peterz@infradead.org>, <leitao@debian.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <leit@fb.com>,
        <dcostantino@meta.com>, <jhladky@redhat.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 2/2] perf/x86/amd/core: Fix overflow reset on hotplug
Date:   Thu, 14 Sep 2023 19:36:04 +0530
Message-ID: <882a87511af40792ba69bb0e9026f19a2e71e8a3.1694696888.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com>
References: <3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deca4ca-f7b1-4557-f686-08dbb52bd511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3iD4+27YkTmj1gbkSPy+qv59he7vwy72Kn6s+sZqaVOZsoZyUmeRtKJ3eJQt5/vD+T41czpMw6XTNrn3NVp/BNFTJQ2yviZlVNnkZpXLERytDkNaRsMGtXtIFtHrLxB1m/Vv+bRT4eKfXPaZpybVc+CWn1/NKd0zqrbIxat1Y2GegnGFq8fL0kqRWHB50fVf8Tic5h4y4cYgdnhNoH2+rtdg/E/Pkm+biNIgcVz2I/z0ZggJ2wQVdMvm0SOwMN9TAzcPKyAWnrmpJtBH9Jdx7+WaQ4SIsi5yWQMdwORp/Oyop/+soLM5EqK7+Tlv8tDdKDe7+NtBHR1AUMMfeCG+ydt19mMl/ZX+AE93wc4Q5zphwZpRAMRDDMvVcssrL3tjg6bnbNSaY9fc2qkoN/rBFQ6dz3e5pRwT3+jjFiAFDEK8HiL92UCNOoa6ce8GXtz8BpjfxtLSDLR87m9kKISFX6wkYobzWtwneKSPd15TAQpGTCoCxwUN7q899xFhoQ4yM3Kw8KSeg6+mNh79TMoZaFvkJBO+3ZlYzDPw2AbUlkKMXzA0UBle7WCXJJp6nfwdU7XkfODweCAT0p1Ylfp2FGzXue4Bo+/JMNrJpCShRqZ4AlnXCmJ/i03ZzIJ3xHD2B6JWWQG6J1S99aEaW4g2CdCBXTsTJr1nWvXgQrtqhrw1xiTEyOM/A/leZwNTSThkXlwNeWA/nq2Qr0Dt02ZGsaPfCTrxzncjf0pmsSW1fOAtKOWGcpQ3Ip8GJ25ACyf+zn0Fja5Bq+czw69svi4XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(26005)(2616005)(8676002)(4326008)(47076005)(8936002)(16526019)(81166007)(5660300002)(83380400001)(336012)(426003)(44832011)(36860700001)(7416002)(41300700001)(40460700003)(70206006)(54906003)(70586007)(110136005)(40480700001)(6666004)(316002)(356005)(36756003)(86362001)(2906002)(82740400003)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:06:46.4596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deca4ca-f7b1-4557-f686-08dbb52bd511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels older than v5.19 do not support PerfMonV2 and the PMI handler
does not clear the overflow bits of the PerfCntrGlobalStatus register.
Because of this, loading a recent kernel using kexec from an older
kernel can result in inconsistent register states on Zen 4 systems.

The PMI handler of the new kernel gets confused and shows a warning when
an overflow occurs because some of the overflow bits are set even if the
corresponding counters are inactive. These are remnants from overflows
that were handled by the older kernel.

During CPU hotplug, the PerfCntrGlobalCtl and PerfCntrGlobalStatus
registers should always be cleared for PerfMonV2-capable processors.
However, a condition used for NB event constaints applicable only to
older processors currently prevents this from happening. Move the reset
sequence to an appropriate place and also clear the LBR Freeze bit.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

v1: https://lore.kernel.org/all/20230613105809.524535-1-sandipan.das@amd.com/

v2:
 - Rebase on top of tip.

---
 arch/x86/events/amd/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b04956cbd085..e24976593a29 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
-- 
2.34.1

