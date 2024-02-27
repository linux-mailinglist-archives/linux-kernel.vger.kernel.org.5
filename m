Return-Path: <linux-kernel+bounces-83367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5208695C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FA61C2125F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7E13F016;
	Tue, 27 Feb 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SJxU4FMk"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668513B2A2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042694; cv=none; b=YprLojt+3gTVqaiiJBOHmEinMy81zHM25YkGIuAvO/e3bvlYXXCucLVVC5qWLqHa/9DoGSayPU0d3AJ8xcVgiApxwXC/MYKg3VNeRy5OuqJU8DWig335V2JHpbEfjqpJ0rptjdDYQF+p47T926MM5LsFLG0Ipran+OLi/ehDJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042694; c=relaxed/simple;
	bh=ZTq+4qNtCP1azUpNOB0zEmq/9GajT6vQsmv20g0qWQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx20H5rAhGm/gDi4nEmleg+ajhw69mc4VTtLnEZXukBjv1DJPYl2f+KoJv6lW38arzfsr8TzxZ33Lpe7G3umP2I++MkzKZtJnQmVZmydB6K2A++O88qnCERB6f4Ehl0Wm5KoKN0o51J5OP+PFWlzLNsbAVEwJX8051pvEmPK/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SJxU4FMk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7nIBZ028210;
	Tue, 27 Feb 2024 06:04:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Z/l/HMo+rs1PzPxqk7ImSDlkM44RFvo9y6uaZ84wbUw=; b=SJx
	U4FMkjOXnpVOLAVllSpGp4FXmLm/quWivwHebdMoAUKE0JjjvQIyDpkEVYay9ngQ
	G3G5OtHWoa3PcQRl3eLh+yM8+NTptlj398bChxhZQgH2ySnmE8aD+jkY3vMx86xR
	ETXBSuAfCacuGySbN6ejSkZwe+amBp4PA1Pp5N6w8G9UwD1TB4m3Cq0GjnulVHx7
	VPY2UFzB3Q1vzZvu+Dn4YLqdndiukqXDis+mVV2TmBeifQ9gePEGl3xpoGQZWYgW
	BCM0susMOvxFjkldcL/mQ1brOKdo0awmr3U4go3WkjvEWD9qu5vnDEeiRoG0zeRG
	1nMLbCcBUZV+VuHIeYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3whbpe0xh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:04:45 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 06:04:44 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 27 Feb 2024 06:04:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 06:04:43 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 0F1AC3F7141;
	Tue, 27 Feb 2024 06:04:40 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v4 3/3] perf/marvell : Odyssey LLC-TAD performance monitor
Date: Tue, 27 Feb 2024 19:34:25 +0530
Message-ID: <20240227140425.3418814-4-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227140425.3418814-1-gthiagarajan@marvell.com>
References: <20240227140425.3418814-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Nk6CbYhzysytxK5CdIiPFe0YYtDbwjY3
X-Proofpoint-ORIG-GUID: Nk6CbYhzysytxK5CdIiPFe0YYtDbwjY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02

Each TAD provides eight 64-bit counters for monitoring
cache behavior.The driver always configures the same counter for
all the TADs. The user would end up effectively reserving one of
eight counters in every TAD to look across all TADs.
The occurrences of events are aggregated and presented to the user
at the end of running the workload. The driver does not provide a
way for the user to partition TADs so that different TADs are used for
different applications.

The performance events reflect various internal or interface activities.
By combining the values from multiple performance counters, cache
performance can be measured in terms such as: cache miss rate, cache
allocations, interface retry rate, internal resource occupancy, etc.

Each supported counter's event and formatting information is exposed
to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
the pmu events. For instance:

perf stat -e tad_hit_ltg,tad_hit_dtg <workload>

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 62 ++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index fec8e82edb95..df6569f7a06f 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -37,6 +37,15 @@ struct tad_pmu {
 	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
 };
 
+enum mrvl_tad_pmu_version {
+	TAD_PMU_V1 = 1,
+	TAD_PMU_V2,
+};
+
+struct tad_pmu_data {
+	int id;
+};
+
 static int tad_pmu_cpuhp_state;
 
 static void tad_pmu_event_counter_read(struct perf_event *event)
@@ -214,6 +223,24 @@ static const struct attribute_group tad_pmu_events_attr_group = {
 	.attrs = tad_pmu_event_attrs,
 };
 
+static struct attribute *ody_tad_pmu_event_attrs[] = {
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
+	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
+	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
+	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
+	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
+	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
+	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
+	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	NULL
+};
+
+static const struct attribute_group ody_tad_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = ody_tad_pmu_event_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 
 static struct attribute *tad_pmu_format_attrs[] = {
@@ -252,8 +279,16 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 	NULL
 };
 
+static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
+	&ody_tad_pmu_events_attr_group,
+	&tad_pmu_format_attr_group,
+	&tad_pmu_cpumask_attr_group,
+	NULL
+};
+
 static int tad_pmu_probe(struct platform_device *pdev)
 {
+	const struct tad_pmu_data *dev_data;
 	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
 	struct tad_pmu *tad_pmu;
@@ -261,6 +296,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_pmu_page_size;
 	u32 tad_page_size;
 	u32 tad_cnt;
+	int version;
 	int i, ret;
 	char *name;
 
@@ -270,6 +306,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tad_pmu);
 
+	dev_data = device_get_match_data(&pdev->dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+	version = dev_data->id;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "Mem resource not found\n");
@@ -319,7 +362,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	tad_pmu->pmu = (struct pmu) {
 
 		.module		= THIS_MODULE,
-		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
 				  PERF_PMU_CAP_NO_INTERRUPT,
 		.task_ctx_nr	= perf_invalid_context,
@@ -332,6 +374,11 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
+	if (version == TAD_PMU_V1)
+		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
+	else
+		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
+
 	tad_pmu->cpu = raw_smp_processor_id();
 
 	/* Register pmu instance for cpu hotplug */
@@ -362,16 +409,25 @@ static int tad_pmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct tad_pmu_data tad_pmu_data = {
+	.id   = TAD_PMU_V1,
+};
+
+static const struct tad_pmu_data tad_pmu_v2_data = {
+	.id   = TAD_PMU_V2,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-tad-pmu", },
+	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
 	{},
 };
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
-	{"MRVL000B", 0},
+	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
+	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
-- 
2.25.1


