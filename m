Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9E758E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGSG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGSG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:56:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279271FD7;
        Tue, 18 Jul 2023 23:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt8N5CaQ1lBu/BZP/NW7NLWLELjig+pEL3h+lJ/xypsNM7dyZ4W/IZZK6/HzKP3nXcgmtJyaixi17Fv+JSSiA4eaR+4APWYGRcs0nFtHLMZPWI1VgW4r2+E20tKi9mOz4LaZKBbjpk8xtlsAFax4drCTbkg4fK6hSkWdAaYJe9ujAPX6Iu6XyQI7tmMNLT0Mr3arJHUCHt0Oi3N4d0Lvn/xsqHgPGYIgpw7o53KYCbVnoZdseGkHudjfkVatE83qvstkyH5OpPFC7HfoENrbOQSn4eJmV0zQeW9Mp7oIOh3/cbcTgK8MdhgwHKG06Q99xKwZwKS6xBywycARJbQANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPkSd6f1sGDunuQ8Kabb8LAcrnfOmNUxKIyEJD+oLQI=;
 b=KTA0dGAVUIIBs2K6PApDQVTw+u2BRqQR14yzDZmkbH5kN4OP6iaCZmLs7UX/ApSe1XePkxIPiY3DbuYcxR6jN5vtYUpV4CU9wSOfNgxF/tH4rPM+PEjcSkePzwHQsi/bfqkxzLUHfmfDP6w+fgw6zZO2Z7EurX6W3YIOyN7GBwLraQU3cJEV6kjIAtqWlRd8O3MCnmy4F706ddSsp07ujrT+bnqZaXKSQe+4xFlJdZurNl3ghUPD+KdSXTuZz/wFZQBpl/6d6Rs9nHaSE9RFWpwJXPgf0cloUr1vmDM/A8f1lfdHT8QypNAWbcDXlTHKBpbZdPWEWQrNRLaFWJKnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPkSd6f1sGDunuQ8Kabb8LAcrnfOmNUxKIyEJD+oLQI=;
 b=Aoznjm3VE0LtaacTDyuQulK1W+uTEID3Grvb9Z70g3DKegr1z4BNLVcOz7z1DopIVKdrU440oNNt7iuu2unXqn5pWllm/tkq/ts7iTUN2HEeo0H3wLe/85TN5CxWL6NiNVFUzHv+Y2RCiUBfg/hNjKJ3JRqbpVz0KazgZ+r5WEU=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 19 Jul
 2023 06:56:30 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::1e) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 06:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:56:29 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:56:23 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 1/6] perf/x86/amd/uncore: Refactor uncore management
Date:   Wed, 19 Jul 2023 12:25:36 +0530
Message-ID: <a7b6930de739ffff5ba24836f420938e866f94f8.1689748843.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689748843.git.sandipan.das@amd.com>
References: <cover.1689748843.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2c5729-eee5-475d-5804-08db8825477c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkhFROtU/EUpWsVKQ56wf2NOpm+XkO92miW+roNmTchUqR+rnXCdn1PHra5CMvp+5Lq+IV1/s8NEoAFTofeiC/rQ5TrNocQGfDeTMDIVy4nYLyaQe0JA4xhCiMq+4W8AitqCkirO083QX5fyun7ShASPhMmSB8yb/xDuIagYlVNdsR97ERV+vw1DPu6joo7rvpkaNa7JjvHp0u36NP+4ewp4LuKFEEyUeORbLG7Cd3MnlNNG6UvL4UWxV+bDQ3XLLvqHW6MvvsV6Dv6OhsZMFwR6DJzK1OgIF18OS+tqvghjSMHs/MW3iIPOCOxE6Y5l2vD0I6yRe1Y5U0kMCqHHTeFcMJIE9z66TOsajqs6/ZpyKLSTUlx0WPSLY5862ORjBWXPbcDmijgZLfa+BJmHtgrbxbkkLy7yCy+xSKq8RnlJz6rquLNAOUsolx1h+axlV/EhvHtX4RHY03m7Xe8VPOZENjtQ4OTsl8yv37FEFnQRiuMLtTBpR6TwupItlVH8QpHI9nHhLnhbqjLf019AXpF2yyWS8hRymyCGPhdNTNNGNvARi2JegTzEBurPWwDrALl7rLEkI81PvfjRXkgLdmelP4VGvWvMBglorPHYHqw4vSHSgZlTgjV1Y9XFqA9z7mRp1fd9Vav7PfneiqoU+yTOae0wc30sTnhJB7rFqdNVsfdu8oFNciyCfk7vCnMAPlFX8W6+1HjSKq7aMOA/u0YVK9Jcwi7dqofJWXYL8LaEgbvv0G0ppnup7hnQP0WOBA3JuZpJ72DJU4Mhk5mzaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(186003)(36860700001)(81166007)(70206006)(54906003)(40460700003)(36756003)(426003)(2616005)(83380400001)(336012)(86362001)(40480700001)(5660300002)(2906002)(70586007)(30864003)(16526019)(26005)(47076005)(8936002)(356005)(316002)(7416002)(41300700001)(8676002)(82740400003)(44832011)(110136005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:56:29.7087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c5729-eee5-475d-5804-08db8825477c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct amd_uncore is used to manage per-cpu contexts, rename it to
amd_uncore_ctx in order to better reflect its purpose. Add a new struct
amd_uncore and encapsulate all attributes which are shared by per-cpu
contexts for the corresponding PMU. These attributes include the number
of counters, active mask, MSR and RDPMC base addresses. Since the struct
pmu is now embedded, the corresponding amd_uncore for a given event can
be found by simply using container_of().

Finally, move all PMU-specific code to separate functions and use the
original event management functions for base functionality. Determining
the PMU type (such as DF or L3) is no longer required for applying any
customizations or handling any quirks.

The motivation is to simplify the management of uncore PMUs.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 711 ++++++++++++++++++-----------------
 1 file changed, 366 insertions(+), 345 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 83f15fe411b3..b0afbe6d9eb4 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -27,56 +27,41 @@
 
 #define COUNTER_SHIFT		16
 
+#define NUM_UNCORES_MAX		2	/* DF (or NB) and L3 (or L2) */
+#define UNCORE_NAME_LEN		16
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
 
 static int pmu_version;
-static int num_counters_llc;
-static int num_counters_nb;
-static bool l3_mask;
 
 static HLIST_HEAD(uncore_unused_list);
 
-struct amd_uncore {
+struct amd_uncore_ctx {
 	int id;
 	int refcnt;
 	int cpu;
-	int num_counters;
-	int rdpmc_base;
-	u32 msr_base;
-	cpumask_t *active_mask;
-	struct pmu *pmu;
 	struct perf_event **events;
 	struct hlist_node node;
 };
 
-static struct amd_uncore * __percpu *amd_uncore_nb;
-static struct amd_uncore * __percpu *amd_uncore_llc;
-
-static struct pmu amd_nb_pmu;
-static struct pmu amd_llc_pmu;
-
-static cpumask_t amd_nb_active_mask;
-static cpumask_t amd_llc_active_mask;
-
-static bool is_nb_event(struct perf_event *event)
-{
-	return event->pmu->type == amd_nb_pmu.type;
-}
+struct amd_uncore {
+	char name[UNCORE_NAME_LEN];
+	int num_counters;
+	int rdpmc_base;
+	u32 msr_base;
+	cpumask_t active_mask;
+	struct pmu pmu;
+	struct amd_uncore_ctx * __percpu *ctx;
+	int (*id)(unsigned int cpu);
+};
 
-static bool is_llc_event(struct perf_event *event)
-{
-	return event->pmu->type == amd_llc_pmu.type;
-}
+static struct amd_uncore uncores[NUM_UNCORES_MAX];
+static int num_uncores __read_mostly;
 
 static struct amd_uncore *event_to_amd_uncore(struct perf_event *event)
 {
-	if (is_nb_event(event) && amd_uncore_nb)
-		return *per_cpu_ptr(amd_uncore_nb, event->cpu);
-	else if (is_llc_event(event) && amd_uncore_llc)
-		return *per_cpu_ptr(amd_uncore_llc, event->cpu);
-
-	return NULL;
+	return container_of(event->pmu, struct amd_uncore, pmu);
 }
 
 static void amd_uncore_read(struct perf_event *event)
@@ -118,7 +103,7 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 	hwc->state |= PERF_HES_STOPPED;
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
-		amd_uncore_read(event);
+		event->pmu->read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -127,14 +112,15 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 {
 	int i;
 	struct amd_uncore *uncore = event_to_amd_uncore(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(uncore->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	/* are we already assigned? */
-	if (hwc->idx != -1 && uncore->events[hwc->idx] == event)
+	if (hwc->idx != -1 && ctx->events[hwc->idx] == event)
 		goto out;
 
 	for (i = 0; i < uncore->num_counters; i++) {
-		if (uncore->events[i] == event) {
+		if (ctx->events[i] == event) {
 			hwc->idx = i;
 			goto out;
 		}
@@ -143,7 +129,7 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	/* if not, take the first available counter */
 	hwc->idx = -1;
 	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], NULL, event) == NULL) {
+		if (cmpxchg(&ctx->events[i], NULL, event) == NULL) {
 			hwc->idx = i;
 			break;
 		}
@@ -158,18 +144,8 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
-	/*
-	 * The first four DF counters are accessible via RDPMC index 6 to 9
-	 * followed by the L3 counters from index 10 to 15. For processors
-	 * with more than four DF counters, the DF RDPMC assignments become
-	 * discontiguous as the additional counters are accessible starting
-	 * from index 16.
-	 */
-	if (is_nb_event(event) && hwc->idx >= NUM_COUNTERS_NB)
-		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
-
 	if (flags & PERF_EF_START)
-		amd_uncore_start(event, PERF_EF_RELOAD);
+		event->pmu->start(event, PERF_EF_RELOAD);
 
 	return 0;
 }
@@ -178,54 +154,35 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 {
 	int i;
 	struct amd_uncore *uncore = event_to_amd_uncore(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(uncore->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	amd_uncore_stop(event, PERF_EF_UPDATE);
+	event->pmu->stop(event, PERF_EF_UPDATE);
 
 	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], event, NULL) == event)
+		if (cmpxchg(&ctx->events[i], event, NULL) == event)
 			break;
 	}
 
 	hwc->idx = -1;
 }
 
-/*
- * Return a full thread and slice mask unless user
- * has provided them
- */
-static u64 l3_thread_slice_mask(u64 config)
-{
-	if (boot_cpu_data.x86 <= 0x18)
-		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
-		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
-
-	/*
-	 * If the user doesn't specify a threadmask, they're not trying to
-	 * count core 0, so we enable all cores & threads.
-	 * We'll also assume that they want to count slice 0 if they specify
-	 * a threadmask and leave sliceid and enallslices unpopulated.
-	 */
-	if (!(config & AMD64_L3_F19H_THREAD_MASK))
-		return AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
-		       AMD64_L3_EN_ALL_CORES;
-
-	return config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
-			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
-			 AMD64_L3_COREID_MASK);
-}
-
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
 	struct hw_perf_event *hwc = &event->hw;
-	u64 event_mask = AMD64_RAW_EVENT_MASK_NB;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (pmu_version >= 2 && is_nb_event(event))
-		event_mask = AMD64_PERFMON_V2_RAW_EVENT_MASK_NB;
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	uncore = event_to_amd_uncore(event);
+	ctx = *per_cpu_ptr(uncore->ctx, event->cpu);
+	if (!ctx)
+		return -ENODEV;
 
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
@@ -235,28 +192,14 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * out. So we do not support sampling and per-thread events via
 	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	hwc->config = event->attr.config & event_mask;
+	hwc->config = event->attr.config;
 	hwc->idx = -1;
 
-	if (event->cpu < 0)
-		return -EINVAL;
-
-	/*
-	 * SliceMask and ThreadMask need to be set for certain L3 events.
-	 * For other events, the two fields do not affect the count.
-	 */
-	if (l3_mask && is_llc_event(event))
-		hwc->config |= l3_thread_slice_mask(event->attr.config);
-
-	uncore = event_to_amd_uncore(event);
-	if (!uncore)
-		return -ENODEV;
-
 	/*
 	 * since request can come in to any of the shared cores, we will remap
 	 * to a single common cpu.
 	 */
-	event->cpu = uncore->cpu;
+	event->cpu = ctx->cpu;
 
 	return 0;
 }
@@ -278,17 +221,10 @@ static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	cpumask_t *active_mask;
 	struct pmu *pmu = dev_get_drvdata(dev);
+	struct amd_uncore *uncore = container_of(pmu, struct amd_uncore, pmu);
 
-	if (pmu->type == amd_nb_pmu.type)
-		active_mask = &amd_nb_active_mask;
-	else if (pmu->type == amd_llc_pmu.type)
-		active_mask = &amd_llc_active_mask;
-	else
-		return 0;
-
-	return cpumap_print_to_pagebuf(true, buf, active_mask);
+	return cpumap_print_to_pagebuf(true, buf, &uncore->active_mask);
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, amd_uncore_attr_show_cpumask, NULL);
 
@@ -396,113 +332,57 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
-static struct pmu amd_nb_pmu = {
-	.task_ctx_nr	= perf_invalid_context,
-	.attr_groups	= amd_uncore_df_attr_groups,
-	.name		= "amd_nb",
-	.event_init	= amd_uncore_event_init,
-	.add		= amd_uncore_add,
-	.del		= amd_uncore_del,
-	.start		= amd_uncore_start,
-	.stop		= amd_uncore_stop,
-	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
-
-static struct pmu amd_llc_pmu = {
-	.task_ctx_nr	= perf_invalid_context,
-	.attr_groups	= amd_uncore_l3_attr_groups,
-	.attr_update	= amd_uncore_l3_attr_update,
-	.name		= "amd_l2",
-	.event_init	= amd_uncore_event_init,
-	.add		= amd_uncore_add,
-	.del		= amd_uncore_del,
-	.start		= amd_uncore_start,
-	.stop		= amd_uncore_stop,
-	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
-
-static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
-{
-	return kzalloc_node(sizeof(struct amd_uncore), GFP_KERNEL,
-			cpu_to_node(cpu));
-}
-
-static inline struct perf_event **
-amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
-{
-	return kzalloc_node(sizeof(struct perf_event *) * num, GFP_KERNEL,
-			    cpu_to_node(cpu));
-}
-
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
+	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
-	if (amd_uncore_nb) {
-		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
-		uncore_nb = amd_uncore_alloc(cpu);
-		if (!uncore_nb)
-			goto fail;
-		uncore_nb->cpu = cpu;
-		uncore_nb->num_counters = num_counters_nb;
-		uncore_nb->rdpmc_base = RDPMC_BASE_NB;
-		uncore_nb->msr_base = MSR_F15H_NB_PERF_CTL;
-		uncore_nb->active_mask = &amd_nb_active_mask;
-		uncore_nb->pmu = &amd_nb_pmu;
-		uncore_nb->events = amd_uncore_events_alloc(num_counters_nb, cpu);
-		if (!uncore_nb->events)
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		*per_cpu_ptr(uncore->ctx, cpu) = NULL;
+		ctx = kzalloc_node(sizeof(struct amd_uncore_ctx), GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!ctx)
 			goto fail;
-		uncore_nb->id = -1;
-		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore_nb;
-	}
 
-	if (amd_uncore_llc) {
-		*per_cpu_ptr(amd_uncore_llc, cpu) = NULL;
-		uncore_llc = amd_uncore_alloc(cpu);
-		if (!uncore_llc)
-			goto fail;
-		uncore_llc->cpu = cpu;
-		uncore_llc->num_counters = num_counters_llc;
-		uncore_llc->rdpmc_base = RDPMC_BASE_LLC;
-		uncore_llc->msr_base = MSR_F16H_L2I_PERF_CTL;
-		uncore_llc->active_mask = &amd_llc_active_mask;
-		uncore_llc->pmu = &amd_llc_pmu;
-		uncore_llc->events = amd_uncore_events_alloc(num_counters_llc, cpu);
-		if (!uncore_llc->events)
+		ctx->cpu = cpu;
+		ctx->events = kzalloc_node(sizeof(struct perf_event *) *
+					   uncore->num_counters, GFP_KERNEL,
+					   cpu_to_node(cpu));
+		if (!ctx->events)
 			goto fail;
-		uncore_llc->id = -1;
-		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
+
+		ctx->id = -1;
+		*per_cpu_ptr(uncore->ctx, cpu) = ctx;
 	}
 
 	return 0;
 
 fail:
-	if (uncore_nb) {
-		kfree(uncore_nb->events);
-		kfree(uncore_nb);
-	}
+	/* Rollback */
+	for (; i >= 0; i--) {
+		uncore = &uncores[i];
+		ctx = *per_cpu_ptr(uncore->ctx, cpu);
+		if (!ctx)
+			continue;
 
-	if (uncore_llc) {
-		kfree(uncore_llc->events);
-		kfree(uncore_llc);
+		kfree(ctx->events);
+		kfree(ctx);
 	}
 
 	return -ENOMEM;
 }
 
-static struct amd_uncore *
-amd_uncore_find_online_sibling(struct amd_uncore *this,
-			       struct amd_uncore * __percpu *uncores)
+static struct amd_uncore_ctx *
+amd_uncore_find_online_sibling(struct amd_uncore_ctx *this,
+			       struct amd_uncore *uncore)
 {
 	unsigned int cpu;
-	struct amd_uncore *that;
+	struct amd_uncore_ctx *that;
 
 	for_each_online_cpu(cpu) {
-		that = *per_cpu_ptr(uncores, cpu);
+		that = *per_cpu_ptr(uncore->ctx, cpu);
 
 		if (!that)
 			continue;
@@ -523,24 +403,16 @@ amd_uncore_find_online_sibling(struct amd_uncore *this,
 
 static int amd_uncore_cpu_starting(unsigned int cpu)
 {
-	unsigned int eax, ebx, ecx, edx;
 	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
-	if (amd_uncore_nb) {
-		uncore = *per_cpu_ptr(amd_uncore_nb, cpu);
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-		uncore->id = ecx & 0xff;
-
-		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_nb);
-		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore;
-	}
-
-	if (amd_uncore_llc) {
-		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id = get_llc_id(cpu);
-
-		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
-		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		ctx = *per_cpu_ptr(uncore->ctx, cpu);
+		ctx->id = uncore->id(cpu);
+		ctx = amd_uncore_find_online_sibling(ctx, uncore);
+		*per_cpu_ptr(uncore->ctx, cpu) = ctx;
 	}
 
 	return 0;
@@ -548,195 +420,359 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 
 static void uncore_clean_online(void)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
 	struct hlist_node *n;
 
-	hlist_for_each_entry_safe(uncore, n, &uncore_unused_list, node) {
-		hlist_del(&uncore->node);
-		kfree(uncore->events);
-		kfree(uncore);
+	hlist_for_each_entry_safe(ctx, n, &uncore_unused_list, node) {
+		hlist_del(&ctx->node);
+		kfree(ctx->events);
+		kfree(ctx);
 	}
 }
 
-static void uncore_online(unsigned int cpu,
-			  struct amd_uncore * __percpu *uncores)
+static int amd_uncore_cpu_online(unsigned int cpu)
 {
-	struct amd_uncore *uncore = *per_cpu_ptr(uncores, cpu);
+	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
 	uncore_clean_online();
 
-	if (cpu == uncore->cpu)
-		cpumask_set_cpu(cpu, uncore->active_mask);
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		ctx = *per_cpu_ptr(uncore->ctx, cpu);
+		if (cpu == ctx->cpu)
+			cpumask_set_cpu(cpu, &uncore->active_mask);
+	}
+
+	return 0;
 }
 
-static int amd_uncore_cpu_online(unsigned int cpu)
+static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 {
-	if (amd_uncore_nb)
-		uncore_online(cpu, amd_uncore_nb);
+	struct amd_uncore_ctx *this, *that;
+	struct amd_uncore *uncore;
+	int i, j;
+
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		this = *per_cpu_ptr(uncore->ctx, cpu);
+
+		/* this cpu is going down, migrate to a shared sibling if possible */
+		for_each_online_cpu(j) {
+			that = *per_cpu_ptr(uncore->ctx, j);
+
+			if (cpu == j)
+				continue;
+
+			if (this == that) {
+				perf_pmu_migrate_context(&uncore->pmu, cpu, j);
+				cpumask_clear_cpu(cpu, &uncore->active_mask);
+				cpumask_set_cpu(j, &uncore->active_mask);
+				that->cpu = j;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int amd_uncore_cpu_dead(unsigned int cpu)
+{
+	struct amd_uncore_ctx *ctx;
+	struct amd_uncore *uncore;
+	int i;
+
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		ctx = *per_cpu_ptr(uncore->ctx, cpu);
+		if (cpu == ctx->cpu)
+			cpumask_clear_cpu(cpu, &uncore->active_mask);
+
+		if (!--ctx->refcnt) {
+			kfree(ctx->events);
+			kfree(ctx);
+		}
 
-	if (amd_uncore_llc)
-		uncore_online(cpu, amd_uncore_llc);
+		*per_cpu_ptr(uncore->ctx, cpu) = NULL;
+	}
 
 	return 0;
 }
 
-static void uncore_down_prepare(unsigned int cpu,
-				struct amd_uncore * __percpu *uncores)
+static int amd_uncore_df_id(unsigned int cpu)
 {
-	unsigned int i;
-	struct amd_uncore *this = *per_cpu_ptr(uncores, cpu);
+	unsigned int eax, ebx, ecx, edx;
 
-	if (this->cpu != cpu)
-		return;
+	cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-	/* this cpu is going down, migrate to a shared sibling if possible */
-	for_each_online_cpu(i) {
-		struct amd_uncore *that = *per_cpu_ptr(uncores, i);
+	return ecx & 0xff;
+}
 
-		if (cpu == i)
-			continue;
+static int amd_uncore_df_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int ret = amd_uncore_event_init(event);
 
-		if (this == that) {
-			perf_pmu_migrate_context(this->pmu, cpu, i);
-			cpumask_clear_cpu(cpu, that->active_mask);
-			cpumask_set_cpu(i, that->active_mask);
-			that->cpu = i;
-			break;
-		}
-	}
+	if (ret || pmu_version < 2)
+		return ret;
+
+	hwc->config = event->attr.config &
+		      (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
+					  AMD64_RAW_EVENT_MASK_NB);
+
+	return 0;
 }
 
-static int amd_uncore_cpu_down_prepare(unsigned int cpu)
+static int amd_uncore_df_add(struct perf_event *event, int flags)
 {
-	if (amd_uncore_nb)
-		uncore_down_prepare(cpu, amd_uncore_nb);
+	int ret = amd_uncore_add(event, flags & ~PERF_EF_START);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (ret)
+		return ret;
 
-	if (amd_uncore_llc)
-		uncore_down_prepare(cpu, amd_uncore_llc);
+	/*
+	 * The first four DF counters are accessible via RDPMC index 6 to 9
+	 * followed by the L3 counters from index 10 to 15. For processors
+	 * with more than four DF counters, the DF RDPMC assignments become
+	 * discontiguous as the additional counters are accessible starting
+	 * from index 16.
+	 */
+	if (hwc->idx >= NUM_COUNTERS_NB)
+		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
+
+	/* Delayed start after rdpmc base update */
+	if (flags & PERF_EF_START)
+		amd_uncore_start(event, PERF_EF_RELOAD);
 
 	return 0;
 }
 
-static void uncore_dead(unsigned int cpu, struct amd_uncore * __percpu *uncores)
+static int amd_uncore_df_init(void)
 {
-	struct amd_uncore *uncore = *per_cpu_ptr(uncores, cpu);
+	struct attribute **df_attr = amd_uncore_df_format_attr;
+	struct amd_uncore *uncore = &uncores[num_uncores];
+	union cpuid_0x80000022_ebx ebx;
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return 0;
 
-	if (cpu == uncore->cpu)
-		cpumask_clear_cpu(cpu, uncore->active_mask);
+	/*
+	 * For Family 17h and above, the Northbridge counters are repurposed
+	 * as Data Fabric counters. The PMUs are exported based on family as
+	 * either NB or DF.
+	 */
+	strncpy(uncore->name, boot_cpu_data.x86 >= 0x17 ? "amd_df" : "amd_nb",
+		sizeof(uncore->name));
+
+	uncore->num_counters = NUM_COUNTERS_NB;
+	uncore->msr_base = MSR_F15H_NB_PERF_CTL;
+	uncore->rdpmc_base = RDPMC_BASE_NB;
+	uncore->id = amd_uncore_df_id;
+
+	if (pmu_version >= 2) {
+		*df_attr++ = &format_attr_event14v2.attr;
+		*df_attr++ = &format_attr_umask12.attr;
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+		uncore->num_counters = ebx.split.num_df_pmc;
+	} else if (boot_cpu_data.x86 >= 0x17) {
+		*df_attr = &format_attr_event14.attr;
+	}
 
-	if (!--uncore->refcnt) {
-		kfree(uncore->events);
-		kfree(uncore);
+	uncore->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	if (!uncore->ctx)
+		return -ENOMEM;
+
+	uncore->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= amd_uncore_df_attr_groups,
+		.name		= uncore->name,
+		.event_init	= amd_uncore_df_event_init,
+		.add		= amd_uncore_df_add,
+		.del		= amd_uncore_del,
+		.start		= amd_uncore_start,
+		.stop		= amd_uncore_stop,
+		.read		= amd_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	ret = perf_pmu_register(&uncore->pmu, uncore->pmu.name, -1);
+	if (ret) {
+		free_percpu(uncore->ctx);
+		uncore->ctx = NULL;
+		return ret;
 	}
 
-	*per_cpu_ptr(uncores, cpu) = NULL;
+	pr_info("%d %s %s counters detected\n", uncore->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+		uncore->pmu.name);
+
+	num_uncores++;
+
+	return 0;
 }
 
-static int amd_uncore_cpu_dead(unsigned int cpu)
+static int amd_uncore_l3_id(unsigned int cpu)
+{
+	return get_llc_id(cpu);
+}
+
+static int amd_uncore_l3_event_init(struct perf_event *event)
 {
-	if (amd_uncore_nb)
-		uncore_dead(cpu, amd_uncore_nb);
+	int ret = amd_uncore_event_init(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	u64 mask;
+
+	hwc->config = config & AMD64_RAW_EVENT_MASK_NB;
+
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events.
+	 * For other events, the two fields do not affect the count.
+	 */
+	if (ret || boot_cpu_data.x86 < 0x17)
+		return ret;
+
+	mask = config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
+			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
+			 AMD64_L3_COREID_MASK);
+
+	if (boot_cpu_data.x86 <= 0x18)
+		mask = ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
+		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
 
-	if (amd_uncore_llc)
-		uncore_dead(cpu, amd_uncore_llc);
+	/*
+	 * If the user doesn't specify a ThreadMask, they're not trying to
+	 * count core 0, so we enable all cores & threads.
+	 * We'll also assume that they want to count slice 0 if they specify
+	 * a ThreadMask and leave SliceId and EnAllSlices unpopulated.
+	 */
+	else if (!(config & AMD64_L3_F19H_THREAD_MASK))
+		mask = AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
+		       AMD64_L3_EN_ALL_CORES;
+
+	hwc->config |= mask;
 
 	return 0;
 }
 
-static int __init amd_uncore_init(void)
+static int amd_uncore_l3_init(void)
 {
-	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
-	union cpuid_0x80000022_ebx ebx;
-	int ret = -ENODEV;
+	struct amd_uncore *uncore = &uncores[num_uncores];
+	int ret;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		return -ENODEV;
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_LLC))
+		return 0;
 
-	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
-		return -ENODEV;
+	/*
+	 * For Family 17h and above, L3 cache counters are available instead
+	 * of L2 cache counters. The PMUs are exported based on family as
+	 * either L2 or L3.
+	 */
+	strncpy(uncore->name, boot_cpu_data.x86 >= 0x17 ? "amd_l3" : "amd_l2",
+		sizeof(uncore->name));
 
-	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
-		pmu_version = 2;
+	uncore->num_counters = NUM_COUNTERS_L2;
+	uncore->msr_base = MSR_F16H_L2I_PERF_CTL;
+	uncore->rdpmc_base = RDPMC_BASE_LLC;
+	uncore->id = amd_uncore_l3_id;
 
-	num_counters_nb	= NUM_COUNTERS_NB;
-	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
-		/*
-		 * For F17h and above, the Northbridge counters are
-		 * repurposed as Data Fabric counters. Also, L3
-		 * counters are supported too. The PMUs are exported
-		 * based on family as either L2 or L3 and NB or DF.
-		 */
-		num_counters_llc	  = NUM_COUNTERS_L3;
-		amd_nb_pmu.name		  = "amd_df";
-		amd_llc_pmu.name	  = "amd_l3";
-		l3_mask			  = true;
+		*l3_attr++ = &format_attr_event8.attr;
+		*l3_attr++ = &format_attr_umask8.attr;
+		*l3_attr++ = boot_cpu_data.x86 >= 0x19 ?
+			     &format_attr_threadmask2.attr :
+			     &format_attr_threadmask8.attr;
+		uncore->num_counters = NUM_COUNTERS_L3;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		if (pmu_version >= 2) {
-			*df_attr++ = &format_attr_event14v2.attr;
-			*df_attr++ = &format_attr_umask12.attr;
-		} else if (boot_cpu_data.x86 >= 0x17) {
-			*df_attr = &format_attr_event14.attr;
-		}
+	uncore->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	if (!uncore->ctx)
+		return -ENOMEM;
+
+	uncore->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= amd_uncore_l3_attr_groups,
+		.attr_update	= amd_uncore_l3_attr_update,
+		.name		= uncore->name,
+		.event_init	= amd_uncore_l3_event_init,
+		.add		= amd_uncore_add,
+		.del		= amd_uncore_del,
+		.start		= amd_uncore_start,
+		.stop		= amd_uncore_stop,
+		.read		= amd_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	ret = perf_pmu_register(&uncore->pmu, uncore->pmu.name, -1);
+	if (ret) {
+		free_percpu(uncore->ctx);
+		uncore->ctx = NULL;
+		return ret;
+	}
 
-		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
-		if (!amd_uncore_nb) {
-			ret = -ENOMEM;
-			goto fail_nb;
-		}
-		ret = perf_pmu_register(&amd_nb_pmu, amd_nb_pmu.name, -1);
-		if (ret)
-			goto fail_nb;
+	pr_info("%d %s %s counters detected\n", uncore->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+		uncore->pmu.name);
 
-		if (pmu_version >= 2) {
-			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
-			num_counters_nb = ebx.split.num_df_pmc;
-		}
+	num_uncores++;
 
-		pr_info("%d %s %s counters detected\n", num_counters_nb,
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
-			amd_nb_pmu.name);
+	return 0;
+}
 
-		ret = 0;
-	}
+static void uncore_free(void)
+{
+	struct amd_uncore *uncore;
+	int i;
 
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x19) {
-			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask8.attr;
-			*l3_attr++ = &format_attr_threadmask2.attr;
-		} else if (boot_cpu_data.x86 >= 0x17) {
-			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask8.attr;
-			*l3_attr++ = &format_attr_threadmask8.attr;
-		}
+	for (i = 0; i < num_uncores; i++) {
+		uncore = &uncores[i];
+		if (!uncore->ctx)
+			continue;
 
-		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
-		if (!amd_uncore_llc) {
-			ret = -ENOMEM;
-			goto fail_llc;
-		}
-		ret = perf_pmu_register(&amd_llc_pmu, amd_llc_pmu.name, -1);
-		if (ret)
-			goto fail_llc;
-
-		pr_info("%d %s %s counters detected\n", num_counters_llc,
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
-			amd_llc_pmu.name);
-		ret = 0;
+		perf_pmu_unregister(&uncore->pmu);
+		free_percpu(uncore->ctx);
+		uncore->ctx = NULL;
 	}
 
+	num_uncores = 0;
+}
+
+static int __init amd_uncore_init(void)
+{
+	int ret;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return -ENODEV;
+
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
+		pmu_version = 2;
+
+	ret = amd_uncore_df_init();
+	if (ret)
+		goto fail;
+
+	ret = amd_uncore_l3_init();
+	if (ret)
+		goto fail;
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
 	if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
 			      "perf/x86/amd/uncore:prepare",
 			      amd_uncore_cpu_up_prepare, amd_uncore_cpu_dead))
-		goto fail_llc;
+		goto fail;
 
 	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 			      "perf/x86/amd/uncore:starting",
@@ -753,12 +789,8 @@ static int __init amd_uncore_init(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
 fail_prep:
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
-fail_llc:
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB))
-		perf_pmu_unregister(&amd_nb_pmu);
-	free_percpu(amd_uncore_llc);
-fail_nb:
-	free_percpu(amd_uncore_nb);
+fail:
+	uncore_free();
 
 	return ret;
 }
@@ -768,18 +800,7 @@ static void __exit amd_uncore_exit(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
-
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		perf_pmu_unregister(&amd_llc_pmu);
-		free_percpu(amd_uncore_llc);
-		amd_uncore_llc = NULL;
-	}
-
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		perf_pmu_unregister(&amd_nb_pmu);
-		free_percpu(amd_uncore_nb);
-		amd_uncore_nb = NULL;
-	}
+	uncore_free();
 }
 
 module_init(amd_uncore_init);
-- 
2.34.1

