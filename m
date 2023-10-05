Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F21D7B9E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJEOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjJEOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:05:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8964EF8;
        Wed,  4 Oct 2023 22:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtUEfG/BvQq8qcTEYqI9uCEhLiuhljSYW2o6fIux2fjxvIMpOWgq2emAL1tn+4q9Ujexm9hzMgBizJ+F1PS4gnMvGdQGw25hC3uJiiXzFbQs9hmL7EuqGv4uSwEb7uDrfNa3+CxAu1fDFP3dU7QNLrXn5qXjRFtrAT+I1eyxaOLUVAM0eIXwqk4yRWos/UePGjPNEEA2IYrsGJpjZ3sY1BnXGEElSt4U6/KVG0Nq8DmTIl5WCqwZYUL1G31PkOI5QW2rQL4V63ihKjD6iGoi6jiPezmWo8nwEPWFqW8KXywKG3ZfHnP3/qvFAm5ziRqORaIYwoHUqEdOSg9X7+aRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pasd/eTIvhNEgyrJP1iQxHoAyNdcqhtMCtq+P5vd+XY=;
 b=ZK5+/SAzOAcnIXwqrhE5Gpc0v9kMt1h0shWz5Bb31C/pusfRVrl7nwyH95BUa9H4MBiGV1iKiPLPryafIqPyfYGfBvbobKe3ErAVLjlYoVFCg60vqW6S6n/CvYEnpVLmsvOU+Qz9P/2NZpgZoitOVQ7mOAXEsUj2TLGj42TMvsrgYC0+18tbv7gUDenJP1/jUJqSKKgsFzK8QOfoY9nt/natoJoToMfjl7ekf9Wi3TII2G9MTqQyqi4yZkqwwRdRH+5OvngmGIzweu/vvmFEc0tAJXoiKo+PImzrEtnL7d8xfdNIIyNVeEafa8wAfGqjXyMSwQSIkRAKm8L7MwGNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pasd/eTIvhNEgyrJP1iQxHoAyNdcqhtMCtq+P5vd+XY=;
 b=Czc+eeJMh5HHk9pICG1vCPe+lzongqnJGQ8Ua2CcaNUHkkyaVBVcSGtVIikQR/aQ0h/FPJOW+9ltD3ODtNDlino9pdvNvEE+4iAdFeMVScy3yhV9H9lyB7x0/CuB7GiAJ5nka0Na7jzrO0sY9limafH5bhisosEw5f6dzAU32+E=
Received: from DM6PR06CA0071.namprd06.prod.outlook.com (2603:10b6:5:54::48) by
 PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 05:26:53 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::ee) by DM6PR06CA0071.outlook.office365.com
 (2603:10b6:5:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 05:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 05:26:53 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 00:26:46 -0500
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
Subject: [PATCH v2 6/6] perf vendor events amd: Add Zen 4 memory controller events
Date:   Thu, 5 Oct 2023 10:53:16 +0530
Message-ID: <3a7245598265737ae4296fa6b0ab03a51708c502.1696425185.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696425185.git.sandipan.das@amd.com>
References: <cover.1696425185.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: cc401e67-02ee-4c97-91ac-08dbc563af00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCBhQ7AIZhjFLuErfBbZlE1aoyUuGwRUyU3LixzxCpjX/54fhdtwr8nEyJk3zK7g73NLdDJLRxs3w6MvhFZFPfdOn0jAFXdoxvySMDXqtLStqJIC/nxb7QviL2jIQKVOoU7PzJpJxjw2EBAiUFuYxeIUzYCXALgF+Vklp6jODzeIz4YI0fW+v96dV9SHfkjwUqTqmadoZoAAQNhLi0xtcrzKft/GzegtqOsU7syn2KE9Edp+l3CIziCupg+zL5SrApUSysaY3B5kX0MzT9E0cqMgW1zkvyoLkZA+yJFUfxMC9aAmiH7j8S/WSI7pdKWbn2K577ppJ8mud8xov0MfdbleGONjBIl3uiNxHII9bhB/Zw/q1onstAlnOWePfD68aizXEtJe9i9t/wOn/wRSxw34xpv2wjG4QAkfCRb+1F2q6cRifr17FtojsWNWWWwhSGrU/+RzEFQMjn7QuDAS09w+akuAa4UwC625i5z8atNXoJKlS92hGxZW01lL6p39W9ua+HySK+ZBla7mV6xVqJSCeXxaa1SWA8/4q6xCSnL//A/+d4JGvp7jXGPXpw1zvoOAiUYpZdxGmWwJCQz0mWZ0yZuoYSXz4rBHXpW3gsNLeRoZQKMXfRx7pVqX8Sakh+o4vMIlouCauIwIsm16l+xEJDijdPW7zrHJm3O9czI2mYcMP5nDPoNS74KX41KtVhnlHuJMPLoz1ejOQQ8c3xhX2tbTeb1B+dbtRhIJYUT76zOvrHe5zZVQlStNz0xE1g3DA8K2+5cuFWrSWPTuPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(7416002)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(70206006)(70586007)(2616005)(316002)(40460700003)(54906003)(110136005)(36860700001)(40480700001)(26005)(336012)(426003)(6666004)(36756003)(7696005)(16526019)(356005)(81166007)(82740400003)(83380400001)(86362001)(47076005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:26:53.0760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc401e67-02ee-4c97-91ac-08dbc563af00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
processors. The events capture UMC command activity such as CAS, ACTIVATE,
PRECHARGE etc. while the metrics derive data bus utilization and memory
bandwidth out of these events.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
 .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
 tools/perf/pmu-events/jevents.py              |   2 +
 3 files changed, 187 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
new file mode 100644
index 000000000000..55263e5e4f69
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
@@ -0,0 +1,101 @@
+[
+  {
+    "EventName": "umc_mem_clk",
+    "PublicDescription": "Number of memory clock cycles.",
+    "EventCode": "0x00",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.all",
+    "PublicDescription": "Number of ACTIVATE commands sent.",
+    "EventCode": "0x05",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.rd",
+    "PublicDescription": "Number of ACTIVATE commands sent for reads.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.wr",
+    "PublicDescription": "Number of ACTIVATE commands sent for writes.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.all",
+    "PublicDescription": "Number of PRECHARGE commands sent.",
+    "EventCode": "0x06",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.rd",
+    "PublicDescription": "Number of PRECHARGE commands sent for reads.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.wr",
+    "PublicDescription": "Number of PRECHARGE commands sent for writes.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.all",
+    "PublicDescription": "Number of CAS commands sent.",
+    "EventCode": "0x0a",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.rd",
+    "PublicDescription": "Number of CAS commands sent for reads.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.wr",
+    "PublicDescription": "Number of CAS commands sent for writes.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.all",
+    "PublicDescription": "Number of clocks used by the data bus.",
+    "EventCode": "0x14",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.rd",
+    "PublicDescription": "Number of clocks used by the data bus for reads.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.wr",
+    "PublicDescription": "Number of clocks used by the data bus for writes.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
index 5e6a793acf7b..96e06401c6cb 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
@@ -330,5 +330,89 @@
     "MetricGroup": "data_fabric",
     "PerPkg": "1",
     "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "umc_data_bus_utilization",
+    "BriefDescription": "Memory controller data bus utilization.",
+    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_write_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_mem_read_bandwidth",
+    "BriefDescription": "Estimated memory read bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_write_bandwidth",
+    "BriefDescription": "Estimated memory write bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_bandwidth",
+    "BriefDescription": "Estimated combined memory bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_activate_cmd_rate",
+    "BriefDescription": "Memory controller ACTIVATE command rate.",
+    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_precharge_cmd_rate",
+    "BriefDescription": "Memory controller PRECHARGE command rate.",
+    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 72ba4a9239c6..ff202e0b7b0a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -286,6 +286,7 @@ class JsonEvent:
           'imx8_ddr': 'imx8_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
+          'UMCPMC': 'amd_umc',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
@@ -345,6 +346,7 @@ class JsonEvent:
         ('Invert', 'inv='),
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
+        ('RdWrMask', 'rdwrmask='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-- 
2.34.1

