Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD120758E39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGSG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGSG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:58:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986DE1FE8;
        Tue, 18 Jul 2023 23:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfHKxgaygwFdJ4xk0wLUrj8CerTv3gNWtD6yidcxSWL9jn+ho2Gi1s3kWO8teb3hrAz2i9smJAq+Y1vMcOYHfatNkctWVwBH0tXX6cN8ijYeCbrR/y5stxqLxjaM79IsFpT/wtqdK48T/dAoIRN+H4JjPD2uD8G4NgWILJFn6hQbIYoi9bbSvHBxJIxnEK0C6lQDG6SFDklIGmfCXBjboO4UmwzUfSA6jNbMS1mRcxF8T2W13wr5QtN/M9dD00GyXzp0E2UMMnqGzg9GYXHdFhw3HPn6su1TZa+2jIY03t2emjV7ka42l7LRccRWWGM3aMD+NmVO9tKV7ZxLKOE4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucIt6usfVwa5iVw1cbvicaBXZykmgyDVLlRaZolSXns=;
 b=PaibzPJRNAS2fDyoJQerUPfVVOAeakKQXxLHvPIwvAkbd63dDS6sP7RoHznMAUSQi0nj9RD9ph8HIv8TpfBh6ohl5kpNPAcM2bFx9gZVfIPHXfbz5J+4+xhPfWQVLcw/8b1XLbRVIUJ5gbyPFl2r/G/WONNbKsUNykzmLlgdjfWZALutNXBv/35a5Ds3YaGr8v3/ISf2GUPomibOBRjFVJrn/SIdxVVfDoANiHdg9VTf8Z1x9x2q2EYpjGnmcHWPt1Yq3MquTYNEkeV/MPnCcWv43gCq1GxyIew2oX4S7mn4uqS+DYdTjmNdVACGzQ6YOdu0packFNO62KNROsv2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucIt6usfVwa5iVw1cbvicaBXZykmgyDVLlRaZolSXns=;
 b=Q76T2t6/LBpR17f9740r0sZcCT6HhsXJXilX/R5cfgj7SkuDUngEMLz3HLTYnimGoHVOCRhyQXB9sKhJVFB5x6N7HwaXhkebM2pfS7V/AVEFBwY5uDGbt2PI6D6oodvqlso8TFQGPiR8Q3WMAj9iZArbO9DS0ReFxag1/6XR9L0=
Received: from BN8PR16CA0001.namprd16.prod.outlook.com (2603:10b6:408:4c::14)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 06:58:24 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::c5) by BN8PR16CA0001.outlook.office365.com
 (2603:10b6:408:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 06:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:58:24 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:58:08 -0500
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
Subject: [PATCH 5/6] perf/x86/amd/uncore: Add memory controller support
Date:   Wed, 19 Jul 2023 12:25:40 +0530
Message-ID: <a143f95aeec5040525530d6292537218aa64d565.1689748843.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|BL1PR12MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c60716-27f1-44c0-c0e9-08db88258bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB53PlUB60UEEetLWRMUb0jH7xb0rXi+qo3xWu3FVbFRv89SIGNBGdErfT/tEw207Vg75km7A5fvCiaQPVylz3f2e6opPCElNu6Sld9EsO6y0cAcEOgsemrXnGNCC+o+7CcdiJUgmHkV38fLuNEZSSN3DZ1oQxiEHsgZfIO94dwnzOdBznL+R0MjQefaHJNuCZPDaDLdA7HFfhQYi2Rv71Deu+TjtOYqid4S5pXBcrRqrpvzOcEn/2Wi7ryxc2kMDl+WwBhYjL9LnOFupNvkapQffP4mp+lw0vu2ahckQsGsTYyBsTS92wWI30dmONlfxqa3OMBfIm/iY028AkQjfU333Vas09Hh1HjZ0P3xbrhjeV6fXmIGbIURhsy3CUUNdhhROpXrijzv3pwQ/NN1OUrNy/OeQ4ySOdGbw0xTQWyhiEfB1P8THo2wasSNVLxpTdhp469h/t5+p4gRRxPbO8WxEQnIdc9Buuf1YvTrbUkGWMMHJeFNcGn6hXb1gSKJXsRmO6Xg6CiRMFaLPtx6jd0Dro9j5skTak4o8tV8Hm7sV1aDJHOiwaLrRfxfWpywzJSea0boxg44MTPaiJhTCed0cOSlNqVSPkjkIJcPgWw9ncSO8Qd6T0Nk9LExhIyKJDJQlvRyn7HgzQNQ26YA9eaZNpS6So90s97fnL2mLF01uAjb336Da2BNt1eLM7m7zgX1k4fsuxT/s6sAUqSdBjATNKPVGxgKUR8kbwO5A3JMqPad9+fzIprbhvDvL42NuHDHXLPyhlsotBSNJmc4Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(54906003)(110136005)(336012)(186003)(16526019)(26005)(82740400003)(2906002)(30864003)(316002)(41300700001)(4326008)(70586007)(70206006)(5660300002)(7416002)(8936002)(8676002)(44832011)(81166007)(356005)(86362001)(40460700003)(36756003)(36860700001)(426003)(2616005)(83380400001)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:58:24.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c60716-27f1-44c0-c0e9-08db88258bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
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

Unified Memory Controller (UMC) events were introduced with Zen 4 as a
part of the Performance Monitoring Version 2 (PerfMonV2) enhancements.
An event is specified using the EventSelect bits and the RdWrMask bits
can be used for additional filtering of reads and writes.

As of now, a maximum of 12 channels of DDR5 are available on each socket
and each channel controlled by a dedicated UMC. Each UMC has it own set
of counters.

Since the MSR address space for the UMC PERF_CTL and PERF_CTR registers
are reused across sockets, uncore groups are created on the basis of
socket IDs. Hence, group exclusivity is mandatory while opening events
so that events for an UMC can only be opened on CPUs which are the same
socket as the corresponding memory channel.

For each socket, the total number of available UMC counters and active
memory channels are determined from CPUID leaf 0x80000022 EBX and ECX
respectively. Usually, on Zen 4, each UMC gets 4 counters.

MSR assignments are determined on the basis of active UMCs. E.g. if
UMCs 1, 4 and 9 are active for a given socket, then

  * UMC 1 gets MSRs 0xc0010800 to 0xc0010807 as PERF_CTLs and PERF_CTRs
  * UMC 4 gets MSRs 0xc0010808 to 0xc001080f as PERF_CTLs and PERF_CTRs
  * UMC 9 gets MSRs 0xc0010810 to 0xc0010817 as PERF_CTLs and PERF_CTRs

Memory channels are generally labelled using alphabets and the mapping
of UMCs to memory channels is dependent on the family and model. This
information can be found in the "UMC and DDR Phy Logical Mapping"
section of the AMD Processor Programming Reference (PPR).

If there are sockets without any online CPUs when the amd_uncore driver
is loaded, UMCs for such sockets will not be discoverable since the
mechanism relies on executing the CPUID instruction on an online CPU
from the socket.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c      | 171 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h  |   4 +
 arch/x86/include/asm/perf_event.h |   9 ++
 3 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 6653e8e164bd..c3e1bddd4e1b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -27,7 +27,12 @@
 
 #define COUNTER_SHIFT		16
 
-#define NUM_UNCORES_MAX		2	/* DF (or NB) and L3 (or L2) */
+/*
+ * While DF (or NB) and L3 (or L2) PMUs have a single instance, there may be
+ * multiple UMC PMUs, each corresponding to active memory channels across all
+ * sockets.
+ */
+#define NUM_UNCORES_MAX		64
 #define UNCORE_NAME_LEN		16
 
 #undef pr_fmt
@@ -264,7 +269,7 @@ static struct device_attribute format_attr_##_var =			\
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
-DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
+DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3, PerfMonV2 UMC */
 DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-15,24-27");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
@@ -274,6 +279,7 @@ DEFINE_UNCORE_FORMAT_ATTR(threadmask2,	threadmask,	"config:56-57");	   /* F19h L
 DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(rdwrmask,    rdwrmask,       "config:8-9");             /* PerfMonV2 UMC */
 
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
@@ -305,6 +311,13 @@ static struct attribute *amd_f19h_uncore_l3_format_attr[] = {
 	NULL,
 };
 
+/* Common UMC attributes */
+static struct attribute *amd_uncore_umc_format_attr[] = {
+	&format_attr_event8.attr,       /* event */
+	&format_attr_rdwrmask.attr,     /* rdwrmask */
+	NULL,
+};
+
 static struct attribute_group amd_uncore_df_format_group = {
 	.name = "format",
 	.attrs = amd_uncore_df_format_attr,
@@ -327,6 +340,11 @@ static struct attribute_group amd_f19h_uncore_l3_format_group = {
 	.is_visible = amd_f19h_uncore_is_visible,
 };
 
+static struct attribute_group amd_uncore_umc_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_umc_format_attr,
+};
+
 static const struct attribute_group *amd_uncore_df_attr_groups[] = {
 	&amd_uncore_attr_group,
 	&amd_uncore_df_format_group,
@@ -345,6 +363,12 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *amd_uncore_umc_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_umc_format_group,
+	NULL,
+};
+
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
 	struct amd_uncore *uncore;
@@ -757,6 +781,145 @@ static int amd_uncore_l3_init(void)
 	return 0;
 }
 
+static int amd_uncore_umc_id(unsigned int cpu)
+{
+	return topology_die_id(cpu);
+}
+
+static int amd_uncore_umc_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int ret = amd_uncore_event_init(event);
+
+	if (ret)
+		return ret;
+
+	hwc->config = event->attr.config & AMD64_PERFMON_V2_RAW_EVENT_MASK_UMC;
+
+	return 0;
+}
+
+static void amd_uncore_umc_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (flags & PERF_EF_RELOAD)
+		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+
+	hwc->state = 0;
+	wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
+	perf_event_update_userpage(event);
+}
+
+static int amd_uncore_umc_init(void)
+{
+	unsigned int cpu, eax, ecx, edx;
+	union cpuid_0x80000022_ebx ebx;
+	struct amd_uncore *uncore;
+	int umc_idx = 0, group_id, group_num_umc, group_umc_idx, ret, i;
+	DECLARE_BITMAP(group_mask, NUM_UNCORES_MAX) = { 0 };
+
+	if (pmu_version < 2)
+		return 0;
+
+	/*
+	 * Each group of memory controllers can have an unique configuration
+	 * based on the DIMM population scheme. If all CPUs associated with a
+	 * group of memory channels are offline, the corresponding UMC PMUs
+	 * will not be initialized since they are only discoverable via CPUID.
+	 */
+	for_each_online_cpu(cpu) {
+		group_id = amd_uncore_umc_id(cpu);
+
+		/* Check if this group has already been discovered */
+		if (test_bit(group_id, group_mask))
+			continue;
+
+		__set_bit(group_id, group_mask);
+		ret = cpuid_on_cpu(cpu, EXT_PERFMON_DEBUG_FEATURES, &eax,
+				   &ebx.full, &ecx, &edx);
+		if (ret)
+			goto fail;
+
+		group_umc_idx = 0;
+		group_num_umc = hweight32(ecx);
+
+		/*
+		 * There are more PMUs than anticipated and the max array size
+		 * needs to be increased to accommodate them
+		 */
+		if ((num_uncores + umc_idx + group_num_umc) > NUM_UNCORES_MAX) {
+			WARN(1, "some uncore PMUs cannot be initialized");
+			break;
+		}
+
+		/* Create PMUs for active UMCs in the current group */
+		for (i = 0; i < 32; i++) {
+			if (!(ecx & BIT(i)))
+				continue;
+
+			uncore = &uncores[num_uncores + umc_idx];
+			snprintf(uncore->name, sizeof(uncore->name), "amd_umc_%d", umc_idx);
+			uncore->num_counters = ebx.split.num_umc_pmc / group_num_umc;
+			uncore->msr_base = MSR_F19H_UMC_PERF_CTL + group_umc_idx * uncore->num_counters * 2;
+			uncore->rdpmc_base = -1;
+			uncore->id = amd_uncore_umc_id;
+			uncore->group = group_id;
+
+			uncore->ctx = alloc_percpu(struct amd_uncore_ctx *);
+			if (!uncore->ctx) {
+				ret = -ENOMEM;
+				goto fail;
+			}
+
+			uncore->pmu = (struct pmu) {
+				.task_ctx_nr	= perf_invalid_context,
+				.attr_groups	= amd_uncore_umc_attr_groups,
+				.name		= uncore->name,
+				.event_init	= amd_uncore_umc_event_init,
+				.add		= amd_uncore_add,
+				.del		= amd_uncore_del,
+				.start		= amd_uncore_umc_start,
+				.stop		= amd_uncore_stop,
+				.read		= amd_uncore_read,
+				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+				.module		= THIS_MODULE,
+			};
+
+			ret = perf_pmu_register(&uncore->pmu, uncore->pmu.name, -1);
+			if (ret) {
+				free_percpu(uncore->ctx);
+				uncore->ctx = NULL;
+				goto fail;
+			}
+
+			pr_info("%d %s %s counters detected\n", uncore->num_counters,
+				boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+				uncore->pmu.name);
+
+			umc_idx++;
+			group_umc_idx++;
+		}
+	}
+
+	num_uncores += umc_idx;
+
+	return 0;
+
+fail:
+	for (i = 0; i < umc_idx; i++) {
+		uncore = &uncores[num_uncores + i];
+		if (!uncore->ctx)
+			continue;
+
+		perf_pmu_unregister(&uncore->pmu);
+		free_percpu(uncore->ctx);
+		uncore->ctx = NULL;
+	}
+
+	return ret;
+}
+
 static void uncore_free(void)
 {
 	struct amd_uncore *uncore;
@@ -797,6 +960,10 @@ static int __init amd_uncore_init(void)
 	if (ret)
 		goto fail;
 
+	ret = amd_uncore_umc_init();
+	if (ret)
+		goto fail;
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3aedae61af4f..bfcc72b20f54 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -624,6 +624,10 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
+/* Fam 19h MSRs */
+#define MSR_F19H_UMC_PERF_CTL		0xc0010800
+#define MSR_F19H_UMC_PERF_CTR		0xc0010801
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5a3ec3..2618ec7c3d1d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -112,6 +112,13 @@
 	(AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	|	\
 	 AMD64_PERFMON_V2_EVENTSEL_UMASK_NB)
 
+#define AMD64_PERFMON_V2_ENABLE_UMC			BIT_ULL(31)
+#define AMD64_PERFMON_V2_EVENTSEL_EVENT_UMC		GENMASK_ULL(7, 0)
+#define AMD64_PERFMON_V2_EVENTSEL_RDWRMASK_UMC		GENMASK_ULL(9, 8)
+#define AMD64_PERFMON_V2_RAW_EVENT_MASK_UMC		\
+	(AMD64_PERFMON_V2_EVENTSEL_EVENT_UMC	|	\
+	 AMD64_PERFMON_V2_EVENTSEL_RDWRMASK_UMC)
+
 #define AMD64_NUM_COUNTERS				4
 #define AMD64_NUM_COUNTERS_CORE				6
 #define AMD64_NUM_COUNTERS_NB				4
@@ -232,6 +239,8 @@ union cpuid_0x80000022_ebx {
 		unsigned int	lbr_v2_stack_sz:6;
 		/* Number of Data Fabric Counters */
 		unsigned int	num_df_pmc:6;
+		/* Number of Unified Memory Controller Counters */
+		unsigned int	num_umc_pmc:6;
 	} split;
 	unsigned int		full;
 };
-- 
2.34.1

