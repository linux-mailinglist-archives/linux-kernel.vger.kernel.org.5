Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060097BF58A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379439AbjJJITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379444AbjJJITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEEEA9;
        Tue, 10 Oct 2023 01:19:30 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtkVgkLll/d9ejAB1g4YDHnl46DXCdr4YKF0fTOqSb8=;
        b=gZJfXEA68oTUFnA1qM+/1MV3fISrC6QcVJKrAuy5+hlfxsz/z9WD7Di57NPDqLhk9yJhPD
        8uACfRCGoO4sPZh2BmJiOoYcwcAO7h9k+15BoAX/DL/BGtDruC/kPq4xJCxIA8N33oXzoE
        o76qVgTgyLmkHOicezTXcypFkUAa5neQBXj8jtExWsI3if4d+c9W24ZMAfOaPeDTsZwTlr
        FC4cX2wZ5urm2wz/jIivsu63OavEaO2OY7f7t8x0ZM87p05dQMPao1PhTCjQMBiR0Rgm14
        ta22JYAgGPVNtqfcSCXPmcz2P9EJs9XuNcbQD1ursjasFU0MsgGKFWL/0b7L+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtkVgkLll/d9ejAB1g4YDHnl46DXCdr4YKF0fTOqSb8=;
        b=8mex7i4tQo4J3FdRFF1nzZFEphpVnihH/D0r3TobhwRIktjapN/RwMmXojr6Hu8tP4lg7C
        FeXj2cKq1RCAnjCg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Add memory controller support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb25f391205c22733493abec1ed850b71784edc5f=2E16964?=
 =?utf-8?q?25185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb25f391205c22733493abec1ed850b71784edc5f=2E169642?=
 =?utf-8?q?5185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169692596798.3135.7702003073388693455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     25e56847821f7375bdee7dae1027c7917d07ce4b
Gitweb:        https://git.kernel.org/tip/25e56847821f7375bdee7dae1027c7917d07ce4b
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 05 Oct 2023 10:53:15 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:25 +02:00

perf/x86/amd/uncore: Add memory controller support

Unified Memory Controller (UMC) events were introduced with Zen 4 as a
part of the Performance Monitoring Version 2 (PerfMonV2) enhancements.
An event is specified using the EventSelect bits and the RdWrMask bits
can be used for additional filtering of read and write requests.

As of now, a maximum of 12 channels of DDR5 are available on each socket
and each channel is controlled by a dedicated UMC. Each UMC, in turn,
has its own set of performance monitoring counters.

Since the MSR address space for the UMC PERF_CTL and PERF_CTR registers
are reused across sockets, uncore groups are created on the basis of
socket IDs. Hence, group exclusivity is mandatory while opening events
so that events for an UMC can only be opened on CPUs which are on the
same socket as the corresponding memory channel.

For each socket, the total number of available UMC counters and active
memory channels are determined from CPUID leaf 0x80000022 EBX and ECX
respectively. Usually, on Zen 4, each UMC has four counters.

MSR assignments are determined on the basis of active UMCs. E.g. if
UMCs 1, 4 and 9 are active for a given socket, then

  * UMC 1 gets MSRs 0xc0010800 to 0xc0010807 as PERF_CTLs and PERF_CTRs
  * UMC 4 gets MSRs 0xc0010808 to 0xc001080f as PERF_CTLs and PERF_CTRs
  * UMC 9 gets MSRs 0xc0010810 to 0xc0010817 as PERF_CTLs and PERF_CTRs

If there are sockets without any online CPUs when the amd_uncore driver
is loaded, UMCs for such sockets will not be discoverable since the
mechanism relies on executing the CPUID instruction on an online CPU
from the socket.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/b25f391205c22733493abec1ed850b71784edc5f.1696425185.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c      | 156 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h  |   4 +-
 arch/x86/include/asm/perf_event.h |   9 ++-
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 3189829..9b444ce 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -55,6 +55,7 @@ struct amd_uncore_pmu {
 enum {
 	UNCORE_TYPE_DF,
 	UNCORE_TYPE_L3,
+	UNCORE_TYPE_UMC,
 
 	UNCORE_TYPE_MAX
 };
@@ -286,7 +287,7 @@ static struct device_attribute format_attr_##_var =			\
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
-DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
+DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3, PerfMonV2 UMC */
 DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-15,24-27");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
@@ -296,6 +297,7 @@ DEFINE_UNCORE_FORMAT_ATTR(threadmask2,	threadmask,	"config:56-57");	   /* F19h L
 DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(rdwrmask,	rdwrmask,	"config:8-9");		   /* PerfMonV2 UMC */
 
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
@@ -312,6 +314,13 @@ static struct attribute *amd_uncore_l3_format_attr[] = {
 	NULL,
 };
 
+/* Common UMC attributes */
+static struct attribute *amd_uncore_umc_format_attr[] = {
+	&format_attr_event8.attr,       /* event */
+	&format_attr_rdwrmask.attr,     /* rdwrmask */
+	NULL,
+};
+
 /* F17h unique L3 attributes */
 static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
 	&format_attr_slicemask.attr,	/* slicemask */
@@ -349,6 +358,11 @@ static struct attribute_group amd_f19h_uncore_l3_format_group = {
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
@@ -367,6 +381,12 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *amd_uncore_umc_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_umc_format_group,
+	NULL,
+};
+
 static __always_inline
 int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -835,6 +855,133 @@ done:
 	return amd_uncore_ctx_init(uncore, cpu);
 }
 
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
+static
+void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
+{
+	union cpuid_0x80000022_ebx ebx;
+	union amd_uncore_info info;
+	unsigned int eax, ecx, edx;
+
+	if (pmu_version < 2)
+		return;
+
+	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
+	info.split.aux_data = ecx;	/* stash active mask */
+	info.split.num_pmcs = ebx.split.num_umc_pmc;
+	info.split.gid = topology_die_id(cpu);
+	info.split.cid = topology_die_id(cpu);
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+{
+	DECLARE_BITMAP(gmask, UNCORE_GROUP_MAX) = { 0 };
+	u8 group_num_pmus[UNCORE_GROUP_MAX] = { 0 };
+	u8 group_num_pmcs[UNCORE_GROUP_MAX] = { 0 };
+	union amd_uncore_info info;
+	struct amd_uncore_pmu *pmu;
+	int index = 0, gid, i;
+
+	if (pmu_version < 2)
+		return 0;
+
+	/* Run just once */
+	if (uncore->init_done)
+		return amd_uncore_ctx_init(uncore, cpu);
+
+	/* Find unique groups */
+	for_each_online_cpu(i) {
+		info = *per_cpu_ptr(uncore->info, i);
+		gid = info.split.gid;
+		if (test_bit(gid, gmask))
+			continue;
+
+		__set_bit(gid, gmask);
+		group_num_pmus[gid] = hweight32(info.split.aux_data);
+		group_num_pmcs[gid] = info.split.num_pmcs;
+		uncore->num_pmus += group_num_pmus[gid];
+	}
+
+	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+			       GFP_KERNEL);
+	if (!uncore->pmus) {
+		uncore->num_pmus = 0;
+		goto done;
+	}
+
+	for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
+		for (i = 0; i < group_num_pmus[gid]; i++) {
+			pmu = &uncore->pmus[index];
+			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
+			pmu->num_counters = group_num_pmcs[gid] / group_num_pmus[gid];
+			pmu->msr_base = MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
+			pmu->rdpmc_base = -1;
+			pmu->group = gid;
+
+			pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+			if (!pmu->ctx)
+				goto done;
+
+			pmu->pmu = (struct pmu) {
+				.task_ctx_nr	= perf_invalid_context,
+				.attr_groups	= amd_uncore_umc_attr_groups,
+				.name		= pmu->name,
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
+			if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+				free_percpu(pmu->ctx);
+				pmu->ctx = NULL;
+				goto done;
+			}
+
+			pr_info("%d %s counters detected\n", pmu->num_counters,
+				pmu->pmu.name);
+
+			index++;
+		}
+	}
+
+done:
+	uncore->num_pmus = index;
+	uncore->init_done = true;
+
+	return amd_uncore_ctx_init(uncore, cpu);
+}
+
 static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 	/* UNCORE_TYPE_DF */
 	{
@@ -850,6 +997,13 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 		.move = amd_uncore_ctx_move,
 		.free = amd_uncore_ctx_free,
 	},
+	/* UNCORE_TYPE_UMC */
+	{
+		.scan = amd_uncore_umc_ctx_scan,
+		.init = amd_uncore_umc_ctx_init,
+		.move = amd_uncore_ctx_move,
+		.free = amd_uncore_ctx_free,
+	},
 };
 
 static int __init amd_uncore_init(void)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d11135..dc159ac 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,6 +637,10 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
+/* Fam 19h MSRs */
+#define MSR_F19H_UMC_PERF_CTL		0xc0010800
+#define MSR_F19H_UMC_PERF_CTR		0xc0010801
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5..2618ec7 100644
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
