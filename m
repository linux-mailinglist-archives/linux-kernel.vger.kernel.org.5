Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2A758E31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGSG5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGSG5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:57:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347A1FCD;
        Tue, 18 Jul 2023 23:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8a5Ro7Vy22jGUiusISdhPFCZ00eacRsOQDVd6cdokTVl3crwf6TQvJ1oyLlVqLBKqfUx8KSfsfvWP6lPUhVJIX0f5nBxt3q9kMBYP+XJ4FUOJi6pX37PpTWYq+aM9JSUzMDUNd5it5WZ3ek89eBW/9lAvhFr2lqzUaIwnCxeK4ka6XAL+rlodghTL1uuaG5q/g6122egLFkbPC23T3FW9LoUfLYkZhRzCOCscf6+IR8Qsd/fUA/d9Pq5NMvQa09/BMxPvhj5a3PW5bJminrcCL0RsLW4Ggb24dBfDHXj4g9Az4RFZi6IJTvrBTXrhl8dF4WxAc0EvC56BKtws8AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rV9NYaI5UnbQD2bHgUaC4mqjQ88OBPiQI4VdbSJBVE=;
 b=TNpcMUjnoJASJskddpxzPIY0RhpcRjaD6xhBQnfokhAy+qrBl3twgwLVyBHKeSyhm47a433wMVIocIFYHDUmvdmhZgs0BxDbyCqGq0ZbWXEfJnSvbpxFnwKHUI8mfu7U4YUjK8K+uLekNjM0Hjyo0jbC8lUZ1W+YePgnmpB3WS4CprgXaWBeiDC/rdYOcOSml6NsCvRDVQMXeLFdVUjCdHdhRCW798xcHSoCg/rXTY7g9kFo+Hz/8aFvxH1oh+OG20lQpdjT7nEZ/ccAQ7WLCGYB8LloWcGiBkVSC78++KeTlv6im/6rNHeUAINEOLw2dQTMoeiHbMPavZwXRm9Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rV9NYaI5UnbQD2bHgUaC4mqjQ88OBPiQI4VdbSJBVE=;
 b=mIDu2e93PfPAYR31dvzhqUuKm8LyFnxwzQYwno20PYsiZDRjsBJMY4u0CsJFx+0Tx2zIcYLlv47Uwxh+At5g57M/X4rZTFh4IBu5KB1gQT2SIpLrPRwpdhCfpBsp/kN+2SGlupkaj/gfdzR7uoTHAjrNszbLU8WdNMlTb5mUV0o=
Received: from BN9PR03CA0716.namprd03.prod.outlook.com (2603:10b6:408:ef::31)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 06:56:55 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::3c) by BN9PR03CA0716.outlook.office365.com
 (2603:10b6:408:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 06:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:56:54 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:56:48 -0500
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
Subject: [PATCH 2/6] perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
Date:   Wed, 19 Jul 2023 12:25:37 +0530
Message-ID: <d48c60aea3a72c136811c0079f9802a988ee9271.1689748843.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ab0781-7c32-4bb3-7124-08db88255652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q23gPQJ3+2deyNACQ51Cn6LLM2ksAxGDdEvmQZLTVCrPSN2xlLKEE50Fq4kNCNh1nmveZAIb8EcHyp+jLT+CpGAsgAHBkOwK3r3replTaQ5LFRxxRSLc1QDFWEc5SaGWPdgcnKjeuhcYpn/La5WkxHhbkXawL4EI/BzZzpqVCVK0L9l2xCo2heTT2f8/h3S5WRFLj01fcE4g42aFVSgIPJLgblPi1Mkp5ygDCS2y5iaIe6f3mvk4q4E+C712n9sj/f/1raOV8s1wqH4l3I5Q2bFfCeP3jmFcitnNMB9BQzzxM2UscJbbpfLWdJ0CwwBxSCj3oST22htzg9M+qk+jYhMlpx+CA3p1MOTQL+zPwu/h9jGxlATfDASvTuxLhWlzNFlAMYJlTwvuaP/ObURDMUN1Y1Usj5f44fnZHexORxLpclL5pWob21DacXvpuS4xNAZTuPsMuGuSuLMnQ2CyksedX5ApyM3PKrLd/5lzRVL8jgpd0Gv5KatMaI5aGKNVwTghu86r57tvnjcqIT4Cmy7wB/ONeZYJL+o9t07FRB/iebgytbtwlTk4snrSYEfj7LTdtnmdRE21ayoQGjuAqs7yYGyQ4v9VBiOWNcrYFSLlQGgJRuybebQxB+OUdq95i67nG51im9v6Tg3Gs1B9mKBEVPIwjnFPV15+M0biUREPmK0XeT6oDFJxT4OcPLfEisoRxw6TkO+ktBWuPLQYW+oz5Yg8kpEiS5GnqsTjlmW4G0dbweiej9FtGMJ6CRL0b/KozUSTIzVfsxL0U0EbuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7416002)(8676002)(82740400003)(44832011)(41300700001)(86362001)(5660300002)(8936002)(4326008)(316002)(47076005)(83380400001)(426003)(2616005)(81166007)(356005)(70206006)(70586007)(2906002)(36756003)(110136005)(40460700003)(54906003)(478600001)(16526019)(6666004)(36860700001)(186003)(336012)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:56:54.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab0781-7c32-4bb3-7124-08db88255652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Not all uncore PMUs may support the use of the RDPMC instruction for
reading counters. In such cases, read the count from the corresponding
PERF_CTR register using the RDMSR instruction.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index b0afbe6d9eb4..f17df6574ba5 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -76,7 +76,16 @@ static void amd_uncore_read(struct perf_event *event)
 	 */
 
 	prev = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new);
+
+	/*
+	 * Some uncore PMUs do not have RDPMC assignments. In such cases,
+	 * read counts directly from the corresponding PERF_CTR.
+	 */
+	if (hwc->event_base_rdpmc < 0)
+		rdmsrl(hwc->event_base, new);
+	else
+		rdpmcl(hwc->event_base_rdpmc, new);
+
 	local64_set(&hwc->prev_count, new);
 	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
 	delta >>= COUNTER_SHIFT;
@@ -144,6 +153,9 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
+	if (uncore->rdpmc_base < 0)
+		hwc->event_base_rdpmc = -1;
+
 	if (flags & PERF_EF_START)
 		event->pmu->start(event, PERF_EF_RELOAD);
 
-- 
2.34.1

