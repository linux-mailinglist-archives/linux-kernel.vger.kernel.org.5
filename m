Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B17479B65A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbjIKVIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbjIKRr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:47:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAFDB;
        Mon, 11 Sep 2023 10:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQY/0nXppp67hLbKZP1lp9n7D5YOQryNIY5HPFAKtbV7mFLfCbAkjDJZfslNy0hcp8C1tf3hT3dMGlGMFwTi2WJxRHlYMYQqr4tNXqQUrhUeGyxxzyR76oqOyua4O4MsdSiyOHnVp2gjHhb2mZi5/Xyfcz4nyop/XlrAvFB8F47kiuE+4bpc6iJg8TFFs4t6qKVWcv73sb3c3jgxcJDGQSdPZvJhqCvQ706U+xQWgLP3vbiAd8J00dxJ6OEIul86C/pJAxVUDbDFUpvVt7NJALFJ+QQ2ysM8cpnbgCGEY/rBigwpqb1DpaFIYCZPVRp04M7fley2FeftybVZkitCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jtYa3urgTttdqtsW3WRSbUagoe9Oznva9d4GAGY30g=;
 b=G6Zv1UjG1aHH85CosdUY+h+TBzFRTSK+C41AMM1buLptf+GQjDDWDbq+swp6yTUI2LApM22lXF/VjATeB7vThlzsJXTbhzwJCIIjuhFq5tLvfvDcA0oFAM1+KDOKzQx1rWObXtFTGtqZ9OvqyIqFxzYxsGTDn0YVMb9XPwqR5ffLtDprX3AFoN8AflrYTUF0xOOBh2aRJV5oTnQz9lHTuE3LLpYW8bJDP0j4r7OWuYh+BGWio6tF2xhN8S0PYXCtd0nr2c92Urr02hgwMk60nuG6JNlPabpkPjrUgUCPtXdxusBYeyWISViykbMx/jOvmuKX2gF8ZDEDeUUSXjQsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jtYa3urgTttdqtsW3WRSbUagoe9Oznva9d4GAGY30g=;
 b=EXC4RotFnD74MDBsCmWGTK+gCRXDOJCrvTkxR7kKetIeDzjzYcd1fvvKTMfQSmn7OdcCyWqNly8jj30JjqAbkNTxfsyOFRV/YxRYABInpfL15mSCUbPgIhrnJ9hhlTrSiE160x+ryZmaPAjNCEqkL2FihNiuH1LpgwXjEsjvYuY=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 17:47:17 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::8) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 17:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 17:47:16 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 12:47:09 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
        <Sandipan.Das@amd.com>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [RFC] amd_uncore/rapl: Add per-core energy tracking support for AMD
Date:   Mon, 11 Sep 2023 17:46:52 +0000
Message-ID: <20230911174652.191605-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e19390e-b2aa-4917-8c04-08dbb2ef2375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbOm6Ax4+z3oRJs78BO+XsZUIT34agPT5PBxhn6VwcWccI4f42cUUZeL3qaqFbUbBp16DYN2ldU2BV2Kz4PW7AOesUUIYW11IXP/QUDH2ngnpuTJfJ+SNv0FSU4HeG2L4JrGrit2x+gRdRtfOX83ts5vcHh8yJc3Lv9ZVYP7pudH2kXLHqOhv3dOxFXzGO4tyuN8Iz/sW48IyoWNIm3rN86vFK0X468jX6Up43MhLK1U7O5NJ/IdglLWf9iz8afleD0uXDKtSgFloM/dWh3XyXpOAtv8ndgRJwdStO0mBladsJHCin5sAZMUEOtLXMVURJagrdnmeSr0P1Oi9llxmztLlmUrvxTw4/9WFNhwkk9+JGdsItlE3mGPcHktjtu+wygyqF6O6/ivq/Do+b0EhpEFJ2A0alvIn7e2j10jeQu4r2WNvFg3MMKS+i9vuCahiL38p6E4u6BUwTz3i+PPSg3DXeOMApCHUGp9Z3A/iSslXoQPdK2Hk+XXLrDrCF2yCpE5bPZpOjlALEDg8HlCSxVo0DBSMhesVUyA8E9pl9jgsvQYL4rly3xJ1xapIaoazaYf0FAL5MtT4fIfkDu9dQHs4hF/YdqdDf7aMaChK8v9u5OncYWBcF5xWeMLjVZ6x+FSqqpXLmh5I9kccvIWJq3V1ccCOhl7gG0YhkzA1VjeJJcVaL7zIfx6KkzNVnkD97652Un4J2uUUe9e/Q5c5DvSd+hdswxE+clGFQoQKlPCp9lC0+sD6FGTuPX2VeWdbf1oJf58p7J92jIubbNJ7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(6666004)(7696005)(966005)(478600001)(83380400001)(16526019)(2616005)(30864003)(426003)(336012)(2906002)(4326008)(1076003)(54906003)(44832011)(41300700001)(316002)(70206006)(70586007)(5660300002)(26005)(110136005)(8676002)(8936002)(7416002)(40460700003)(36756003)(86362001)(356005)(47076005)(40480700001)(82740400003)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:47:16.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e19390e-b2aa-4917-8c04-08dbb2ef2375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce distinct energy monitoring event in the amd_uncore driver to
accommodate per-core power consumption readings. Unlike the existing
energy-cores event in the power PMU, which aggregates power data per
socket/package [1], this new event aligns with AMD's per-core RAPL counters.
This change caters to the need for separate power consumption
measurements for individual cores.

Running a workload pinned to CPU 1 give below output with perf stat:

$sudo perf stat --per-core -C 0-7 -I 1000 -e amd_rapl/energy-cores/

           time core               cpus             counts   unit events
    17.176191314 S0-D0-C0              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C1              1               4.35 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C2              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C3              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C4              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C5              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C6              1               0.02 Joules amd_rapl/energy-cores/
    17.176191314 S0-D0-C7              1               0.02 Joules amd_rapl/energy-cores/

[1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 arch/x86/events/amd/uncore.c | 213 +++++++++++++++++++++++++++++++++--
 1 file changed, 202 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 83f15fe411b3..e03b12e20ebd 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -26,6 +26,7 @@
 #define RDPMC_BASE_LLC		10
 
 #define COUNTER_SHIFT		16
+#define RAPL_CNTR_WIDTH	32
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
@@ -35,6 +36,8 @@ static int num_counters_llc;
 static int num_counters_nb;
 static bool l3_mask;
 
+static int rapl_hw_unit __read_mostly;
+
 static HLIST_HEAD(uncore_unused_list);
 
 struct amd_uncore {
@@ -52,12 +55,15 @@ struct amd_uncore {
 
 static struct amd_uncore * __percpu *amd_uncore_nb;
 static struct amd_uncore * __percpu *amd_uncore_llc;
+static struct amd_uncore * __percpu *amd_uncore_rapl;
 
 static struct pmu amd_nb_pmu;
 static struct pmu amd_llc_pmu;
+static struct pmu amd_rapl_pmu;
 
 static cpumask_t amd_nb_active_mask;
 static cpumask_t amd_llc_active_mask;
+static cpumask_t amd_rapl_active_mask;
 
 static bool is_nb_event(struct perf_event *event)
 {
@@ -69,44 +75,78 @@ static bool is_llc_event(struct perf_event *event)
 	return event->pmu->type == amd_llc_pmu.type;
 }
 
+static bool is_rapl_event(struct perf_event *event)
+{
+	return event->pmu->type == amd_rapl_pmu.type;
+}
+
 static struct amd_uncore *event_to_amd_uncore(struct perf_event *event)
 {
 	if (is_nb_event(event) && amd_uncore_nb)
 		return *per_cpu_ptr(amd_uncore_nb, event->cpu);
 	else if (is_llc_event(event) && amd_uncore_llc)
 		return *per_cpu_ptr(amd_uncore_llc, event->cpu);
+	else if (is_rapl_event(event) && amd_uncore_rapl)
+		return *per_cpu_ptr(amd_uncore_rapl, event->cpu);
 
 	return NULL;
 }
 
+static inline u64 rapl_scale(u64 v)
+{
+	return v << (32 - rapl_hw_unit);
+}
+
 static void amd_uncore_read(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	u64 prev, new;
 	s64 delta;
+	int shift;
 
 	/*
 	 * since we do not enable counter overflow interrupts,
 	 * we do not have to worry about prev_count changing on us
 	 */
 
-	prev = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new);
-	local64_set(&hwc->prev_count, new);
-	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
-	delta >>= COUNTER_SHIFT;
+	if (is_rapl_event(event)) {
+		shift = RAPL_CNTR_WIDTH;
+again:
+		prev = local64_read(&hwc->prev_count);
+		rdmsrl(hwc->event_base, new);
+		if (local64_cmpxchg(&hwc->prev_count, prev, new) != prev) {
+			cpu_relax();
+			goto again;
+		}
+		delta = (new << shift) - (prev << shift);
+		delta >>= shift;
+		delta = rapl_scale(delta);
+	} else {
+		prev = local64_read(&hwc->prev_count);
+		rdpmcl(hwc->event_base_rdpmc, new);
+		local64_set(&hwc->prev_count, new);
+		delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
+		delta >>= COUNTER_SHIFT;
+	}
 	local64_add(delta, &event->count);
 }
 
 static void amd_uncore_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	u64 new;
 
 	if (flags & PERF_EF_RELOAD)
 		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
+	if (is_rapl_event(event)) {
+		rdmsrl(hwc->event_base, new);
+		local64_set(&hwc->prev_count, new);
+	}
+
 	hwc->state = 0;
-	wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
+	if (hwc->config_base)
+		wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
 	perf_event_update_userpage(event);
 }
 
@@ -114,7 +154,8 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	if (hwc->config_base)
+		wrmsrl(hwc->config_base, hwc->config);
 	hwc->state |= PERF_HES_STOPPED;
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
@@ -153,9 +194,15 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	if (hwc->idx == -1)
 		return -EBUSY;
 
-	hwc->config_base = uncore->msr_base + (2 * hwc->idx);
-	hwc->event_base = uncore->msr_base + 1 + (2 * hwc->idx);
-	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
+	if (is_rapl_event(event)) {
+		hwc->config_base = 0;
+		hwc->event_base = uncore->msr_base;
+		hwc->event_base_rdpmc = 0;
+	} else {
+		hwc->config_base = uncore->msr_base + (2 * hwc->idx);
+		hwc->event_base = uncore->msr_base + 1 + (2 * hwc->idx);
+		hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
+	}
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/*
@@ -285,6 +332,8 @@ static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 		active_mask = &amd_nb_active_mask;
 	else if (pmu->type == amd_llc_pmu.type)
 		active_mask = &amd_llc_active_mask;
+	else if (pmu->type == amd_rapl_pmu.type)
+		active_mask = &amd_rapl_active_mask;
 	else
 		return 0;
 
@@ -326,6 +375,69 @@ DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 
+#define RAPL_EVENT_ATTR_STR(_name, v, str)                                      \
+static struct perf_pmu_events_attr event_attr_##v = {                           \
+	.attr           = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),     \
+	.id             = 0,                                                    \
+	.event_str      = str,                                                  \
+};
+
+RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
+RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-cores.scale, rapl_cores_scale, "2.3283064365386962890625e-10");
+
+/*
+ * There are no default events, but we need to create
+ * "events" group (with empty attrs) before updating
+ * it with detected events.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
+static struct attribute_group rapl_pmu_events_group = {
+	.name = "events",
+	.attrs = attrs_empty,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+static struct attribute *rapl_formats_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group rapl_pmu_format_group = {
+	.name = "format",
+	.attrs = rapl_formats_attr,
+};
+
+static const struct attribute_group *rapl_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&rapl_pmu_format_group,
+	&rapl_pmu_events_group,
+	NULL,
+};
+
+static struct attribute *rapl_events_cores[] = {
+	&event_attr_rapl_cores.attr.attr,
+	&event_attr_rapl_cores_unit.attr.attr,
+	&event_attr_rapl_cores_scale.attr.attr,
+	NULL,
+};
+
+static struct attribute_group rapl_events_cores_group = {
+	.name  = "events",
+	.attrs = rapl_events_cores,
+};
+
+
+static const struct attribute_group *rapl_attr_update[] = {
+	&rapl_events_cores_group,
+	NULL,
+};
+
+
+
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr,	/* event */
@@ -425,6 +537,21 @@ static struct pmu amd_llc_pmu = {
 	.module		= THIS_MODULE,
 };
 
+static struct pmu amd_rapl_pmu = {
+	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= rapl_attr_groups,
+	.attr_update	= rapl_attr_update,
+	.name		= "amd_rapl",
+	.event_init	= amd_uncore_event_init,
+	.add		= amd_uncore_add,
+	.del		= amd_uncore_del,
+	.start		= amd_uncore_start,
+	.stop		= amd_uncore_stop,
+	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	.module		= THIS_MODULE,
+};
+
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
 {
 	return kzalloc_node(sizeof(struct amd_uncore), GFP_KERNEL,
@@ -440,7 +567,7 @@ amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
 
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
+	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL, *uncore_rapl = NULL;
 
 	if (amd_uncore_nb) {
 		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
@@ -478,6 +605,23 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
 	}
 
+	if (amd_uncore_rapl) {
+		*per_cpu_ptr(amd_uncore_rapl, cpu) = NULL;
+		uncore_rapl = amd_uncore_alloc(cpu);
+		if (!uncore_rapl)
+			goto fail;
+		uncore_rapl->cpu = cpu;
+		uncore_rapl->num_counters = 1;
+		uncore_rapl->msr_base = MSR_AMD_CORE_ENERGY_STATUS;
+		uncore_rapl->active_mask = &amd_rapl_active_mask;
+		uncore_rapl->pmu = &amd_rapl_pmu;
+		uncore_rapl->events = amd_uncore_events_alloc(1, cpu);
+		if (!uncore_nb->events)
+			goto fail;
+		uncore_rapl->id = -1;
+		*per_cpu_ptr(amd_uncore_rapl, cpu) = uncore_rapl;
+	}
+
 	return 0;
 
 fail:
@@ -543,6 +687,14 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
 	}
 
+	if (amd_uncore_rapl) {
+		uncore = *per_cpu_ptr(amd_uncore_rapl, cpu);
+		uncore->id = topology_core_id(cpu);
+
+		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_rapl);
+		*per_cpu_ptr(amd_uncore_rapl, cpu) = uncore;
+	}
+
 	return 0;
 }
 
@@ -577,6 +729,9 @@ static int amd_uncore_cpu_online(unsigned int cpu)
 	if (amd_uncore_llc)
 		uncore_online(cpu, amd_uncore_llc);
 
+	if (amd_uncore_rapl)
+		uncore_online(cpu, amd_uncore_rapl);
+
 	return 0;
 }
 
@@ -614,6 +769,9 @@ static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 	if (amd_uncore_llc)
 		uncore_down_prepare(cpu, amd_uncore_llc);
 
+	if (amd_uncore_rapl)
+		uncore_down_prepare(cpu, amd_uncore_rapl);
+
 	return 0;
 }
 
@@ -640,6 +798,9 @@ static int amd_uncore_cpu_dead(unsigned int cpu)
 	if (amd_uncore_llc)
 		uncore_dead(cpu, amd_uncore_llc);
 
+	if (amd_uncore_rapl)
+		uncore_dead(cpu, amd_uncore_rapl);
+
 	return 0;
 }
 
@@ -649,6 +810,7 @@ static int __init amd_uncore_init(void)
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
 	union cpuid_0x80000022_ebx ebx;
 	int ret = -ENODEV;
+	u64 msr_rapl_power_unit_bits;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -730,6 +892,29 @@ static int __init amd_uncore_init(void)
 		ret = 0;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_RAPL)) {
+		if (boot_cpu_data.x86 >= 0x19) {
+			amd_uncore_rapl = alloc_percpu(struct amd_uncore *);
+			if (!amd_uncore_rapl) {
+				ret = -ENOMEM;
+				goto fail_llc;
+			}
+
+			ret = perf_pmu_register(&amd_rapl_pmu, amd_rapl_pmu.name, -1);
+			if (ret)
+				goto fail_llc;
+			pr_info("%s PMU detected\n", amd_rapl_pmu.name);
+
+			if (rdmsrl_safe(MSR_AMD_RAPL_POWER_UNIT, &msr_rapl_power_unit_bits)) {
+				pr_err("RAPL POWER unit reg read error\n");
+				ret = -1;
+			} else {
+				rapl_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+				ret = 0;
+			}
+		}
+	}
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
@@ -780,6 +965,12 @@ static void __exit amd_uncore_exit(void)
 		free_percpu(amd_uncore_nb);
 		amd_uncore_nb = NULL;
 	}
+
+	if (boot_cpu_has(X86_FEATURE_RAPL)) {
+		perf_pmu_unregister(&amd_rapl_pmu);
+		free_percpu(amd_uncore_rapl);
+		amd_uncore_rapl = NULL;
+	}
 }
 
 module_init(amd_uncore_init);
-- 
2.34.1

