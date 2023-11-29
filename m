Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD67FCF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjK2GZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjK2GZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:25:14 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C410C0;
        Tue, 28 Nov 2023 22:25:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVtbTQ8z2Tc0nBT7QBFJcMHfI2egcmNbuE7BTzN0Anc5o8DUyCJtdW2rF5WgOWt4Vpuw/3c2QRzA0oVV1b6NO7VhzKpXEUrSAUFkk2DYTXyDBkuEu8px3LKrAiuBQ9DhdoTwLBZp9CWdDesMyrIj6s4VsSrPMDUmnUGjoVnKqvXJMR/5POr1rwe1n6B6j+hlSZ07QFF8bWlfpOvaJ3W/iVDkzu+u9fDDW8IihWzWEgO1xTTTZELt3iGxCaYKYQiALN/FN85Tgw26zWd1BY67Aq2S83MwUzdQeLLfV3SM8EDNA9ZiHlaKcevZs0PMufHqOeQmWufJMhEDwre0HNkAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RQ28sUnvbuzAMhfoQQzqBpi5JWy7c2gSmraHztd0Fk=;
 b=GDSNQ75koOnNK4UeXD7AG1BFalK0OaAk3zJCPdhRdAsbDSSejL7NtAD6NUw8txjAk0tPTRqUkGQGWsorrS/su6Ni7x9mz87HoayBvUGIB1Sg7OF7SDlAdEKnPeCACIdeuNGxajMlr6yEgd1sFp/6mkyDCmBRM2Bda3cJO3gLjo+5J+he+SLoXUQIDRuPm4+Nph1ZBJnHZPSTcjy/MsrBE/H/8f2S20hT3aZbAMmlf5KLSwigybBOb62by0Tq5wAW6n54qSiXSkYvu/pQacVbQ/zmY1AJAPNVcifpl7P1kEvJ1cEE+Tm5uQqPR54MEReDWj/wSvi9L8Xd8NfO6W8cGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RQ28sUnvbuzAMhfoQQzqBpi5JWy7c2gSmraHztd0Fk=;
 b=nHt8/BveEHIZQeR926fw6X91wZo+e64ZmhAvPCa73aVlannaxMbTBgXsIZqkhhJGJJykfjUEbCFO/ofmQDRrzCudgxQjoATetiHox3g03q+aaB2QB3aY3cYFQvEmV3HMoWEhCvr3i1jZnLfzoDQ4aRxcQyqu6s7PsqI93VrA7iw=
Received: from CYZPR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:8b::10)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 06:25:17 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::16) by CYZPR12CA0018.outlook.office365.com
 (2603:10b6:930:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 06:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:25:16 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:25:12 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <eranian@google.com>,
        <irogers@google.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3] perf vendor events amd: Add Zen 4 memory controller events
Date:   Wed, 29 Nov 2023 11:55:04 +0530
Message-ID: <e0d8a7e8ca8ee3e378d8029e80b456ac327d6419.1701238314.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d81ef2f-ddce-4d9a-db17-08dbf0a3f419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKMNehHRI5nzvKRUUmE74OAYtf/GrIFdGCi5JaEe/nKXoPm9Ph0n2tc+WxvZerGR6SG4JEIZbNPIfOkFgkoKtPULHuIQLgmrwIlJy/EpU1XDrY6wiCgwdq5O2lfqr6ztC0wxioJ2pv0hla7D30cVSolnmzYo85ZzmhHdswxUUwpY45ygUTae98jo2Cssd0n1eOgWubssNlDdU72ukGaC0hL0E7qQtU1esWVRciq5foQHb2mWrg5PPPaE++pw2ubyc+UKby+9UsITewCurbMXvPyK9mv3ogFmV1bSiV14A5sHcNYo2yxiAvzV4KbYTEeiATB/7IEaOpKm6NElRdvnEiGBGUbL3lX2eoyIJDslLyhNf0kSqyZPLk2I1kn8+45t3TgYxSqorU+LzcI+2pPqNmRx6cPiOTIo0mFDE8hXKZAG9mRpAeuX/cfPGGxN6zUlO20QFCcIiOJZ7bYNgUQX0NJPqaTeIPuJmDJnh4lM4AyDWfL4Hd77+GxO4fb+YE9vQBKXY/gqwkkJkpRVB9Uvt/amJ+8xzPG+/UTzWz6uACvrOEH8jJJ48f1kIDCstenRfRU7qVbQF2+55HVRL8F0tI1JDGSQ0NyExm1XINMnVIdWQfHosY830xSb6h/vxCobbrcT5OqCQ/SWqkfgQsIEn270ADpo3Tbrer0+W8FGWUVYUkjmORXlyqRAUm6BuMrmnCVYuVmvTfKQDHFrqa5EzVupWbhVJ/UmsE56gRDhU/Em5GG0wrZ8Ny2D6j3AfecUTiJuwGsVWF7N4GIHINO2StHRyecQvfNXmlu2LM69IOGFWxrhX4f9d2jhE0qVpvVLIw+07DrEY+NshSnPozcs3E5L7viQoxgnlR7ldvQIBTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(2616005)(336012)(426003)(26005)(478600001)(16526019)(7696005)(47076005)(36860700001)(83380400001)(5660300002)(7416002)(2906002)(41300700001)(44832011)(70206006)(8676002)(70586007)(966005)(8936002)(316002)(54906003)(110136005)(4326008)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:25:16.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d81ef2f-ddce-4d9a-db17-08dbf0a3f419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

v3:
 - Rebase on top of latest perf-tools-next branch.

v2: https://lore.kernel.org/all/3a7245598265737ae4296fa6b0ab03a51708c502.1696425185.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com/

---
 .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
 .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
 tools/perf/pmu-events/jevents.py              |   2 +
 3 files changed, 187 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/a.mdzen4/memory-controller.json
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
index 0093c998cb6e..53ab050c8fa4 100755
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
@@ -354,6 +355,7 @@ class JsonEvent:
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
         ('NodeType', 'type='),
+        ('RdWrMask', 'rdwrmask='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-- 
2.34.1

