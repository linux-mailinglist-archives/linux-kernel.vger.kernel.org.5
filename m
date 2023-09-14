Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C297A06DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbjINOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbjINOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:06:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F36DF;
        Thu, 14 Sep 2023 07:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9WyXbe9qQnM+h4JWTamiH+xlAUQ0B/eHV5F+MgAG5jZvd51I2Y+I4CZkw3BxVGrUVTMGvWuQSv1bTHTyDxKP/iXdHsA9lfq+/qikLE0QSYvKUJs/Rq4t/xtYJ7pQTXYxPYzlU/102VVuUxmuIaFfQ+C7BSqDPSsKr6NYf6qlNGbIrp/eG4INIL6REEcBSeHL/nTYsxuqY1F+1kCf4VEwIpjEcgGGGzKv1xLCzvSXYRhulps3aVJTjavNTHl/KL9W+I+04qae0urCy+Km1AYvHmeE6kTd+hC4Gp+owAS6kCdR6cMzAV0mZuXkA9X79uCEsqCK30A5XuBPVAcyHumAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZgE92FxSI6CdmJ3uDQcJ1f/CA0xCp7hvNvwN175yQY=;
 b=ecQ5BCHN7TuZP+vC3fqWJSVC4BQ1FsayI3nXoxojsioeQkJJUFBPk8bMpof0NdhOT2i6Tp4WyOlhHI5sOL6IxrKn0gIlbX29V2Qw3/LZJ+6OqWU/JvcDeXcPxzXJvI4lp4LcxghUQ1MFzxaibQ6FuLfvTC5oCV9RTshSaLpmTe4nQgmfSV6W49RORBtHG/2KPNLKNM8fj5sWqKS+Srvn1OHKfgOMnQj939x7k+IYCeW0V0ks9xefyQmCKA7jWsvsfMKpPptmb3M/VYb3Y+JvxPPKcXJlHlQKiMF6Eh07cBPlpH+1DxgQfsxlpU+UsLyfrd+aFAMTO/qBfe3C10DqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZgE92FxSI6CdmJ3uDQcJ1f/CA0xCp7hvNvwN175yQY=;
 b=ffOr6IV5Oyb7rwcBHumgeFqVJD5wt/m0LL5Gkw0pCT/7AueZjvAOaFEQrzbjd8ppwnSWJJhNCQKnOPOlD/fz21NvaP4YBDETdV+YMnLpOuyvKuMRKMMunqqQrVy1Fhg944+bx4ZwU0S5YTZMSKxHWBCIybOkIu/xckHMqrtDs18=
Received: from BYAPR07CA0019.namprd07.prod.outlook.com (2603:10b6:a02:bc::32)
 by SA1PR12MB7103.namprd12.prod.outlook.com (2603:10b6:806:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 14:06:26 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::b5) by BYAPR07CA0019.outlook.office365.com
 (2603:10b6:a02:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 14:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 14:06:25 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:06:18 -0500
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
Subject: rom 3540f985652f41041e54ee82aa53e7dbd55739ae Mon Sep 17 00:00:00 2001
Date:   Thu, 14 Sep 2023 19:36:03 +0530
Message-ID: <20230914140604.267672-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 370f1951-f801-4dd1-4ca7-08dbb52bc8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cczQuWTnQOw8oFpUt7wd+Pha5B1ouqVVgGZiyUifhWewv5QA7kfZt/SY0xNJRLcKpQhgoskLcVL+qwVMtdTu9r9ZsBF8aivO8ilcgZbevxv9etycOQGygPdU+8EvsC6BLdxLOebsdi66MD6Jd5ZHrDn7aUZFmuGZlJYf/AeYCiuRQSTR+MrhAHTBMvhwOQiqPoJJUAvIvnBPYATUBthpBPhIcmqt+iMLnXzIDeOuhfO6dLNhRbSU8q2EIMDGxSaO2qQd9ZjfcGet/PweZGrvb/x2u14T2Vx+us65f41Fc8julR+k81tTHNWqE3V9NjbMxeqPidferC9GNaaV4DFDgVAH+r3Zk6uUPR9VvzlzMkPZJKoDNyPFbU+qqWCGAu1ke6LQiV1Or1GlOtkvCZdb6rEMKOqoBzpN5vwV8Su72KTYj6C8n6Lc8okRdaFJce6hHpzP6h2chmWEmHRo0m5c6kMh/z/S/LulBsPbehv8sXtgxjqXc1F5RYbRQ/FKvaArUzMH8HWi2mIyAyRWWOaEKF9fJNv/p+Hh83e6kYpq2i5Thp9eqZopF0O3kmO2vd5LvnGcwEBL/+i+7x0kPDSQ79VCdSSIQ9iFgkxKfSl7UoSXmNnzj2LCevfuYazOBQUJeMRMQXkQXRRlJ1AvJhkwFkeKHi8lrbV7DVfb0CH/w7kJHmpxqF7IPhiCUQITlDbH8x9t2dsA+PW8DU6IWU7I6zwRtJxLy3l3z95lb3P67DePXVhGp4JmrT+GfEvbr68BFCqbfHhlXvaqTiwj2/IvO49OaIUWuLrYNTkuULMX4Kc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(336012)(82740400003)(6666004)(356005)(81166007)(16526019)(2616005)(36756003)(36860700001)(41300700001)(426003)(26005)(1076003)(478600001)(54906003)(47076005)(70206006)(110136005)(70586007)(316002)(966005)(7416002)(5660300002)(4326008)(44832011)(8676002)(8936002)(86362001)(40480700001)(40460700003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:06:25.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370f1951-f801-4dd1-4ca7-08dbb52bc8dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
handler, as shown below, several times while perf runs. A simple
`perf top` run is enough to render the system unusable.

WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0

This happens because the Performance Counter Global Status Register
(PerfCntGlobalStatus) has one or more bits set which are considered
reserved according to the "AMD64 Architecture Programmer’s Manual,
Volume 2: System Programming, 24593". The document can be found at
https://www.amd.com/system/files/TechDocs/24593.pdf

To make this less intrusive, warn just once if any reserved bit is set
and prompt the user to update the microcode. Also sanitize the value to
what the code is handling, so that the overflow events continue to be
handled for the number of counters that are known to be sane.

Going forward, the following microcode patch levels are recommended
for Zen 4 processors in order to avoid such issues with reserved bits.

  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e
  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e
  Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116
  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212

Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
the linux-firmware tree has binaries that meet the minimum required
patch levels.

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
Reported-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
[sandipan: add message to prompt users to update microcode]
[sandipan: rework commit message and call out required microcode levels]
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

v1: https://lore.kernel.org/all/20230616115316.3652155-1-leitao@debian.org/

v2:
 - Use pr_warn_once() instead of WARN_ON_ONCE() to prompt users to
   update microcode
 - Rework commit message and add details of minimum required microcode
   patch levels.

---
 arch/x86/events/amd/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..b04956cbd085 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -884,7 +884,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 status, mask;
+	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -909,6 +909,14 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
+	reserved = status & ~amd_pmu_global_cntr_mask;
+	if (reserved)
+		pr_warn_once("Reserved PerfCntrGlobalStatus bits are set (0x%llx), please consider updating microcode\n",
+			     reserved);
+
+	/* Clear any reserved bits set by buggy microcode */
+	status &= amd_pmu_global_cntr_mask;
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-- 
2.34.1

