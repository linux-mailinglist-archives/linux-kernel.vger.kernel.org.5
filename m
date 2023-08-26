Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652F7894E6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjHZIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHZIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:44:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2107.outbound.protection.outlook.com [40.92.41.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001862130;
        Sat, 26 Aug 2023 01:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8Jq0QH4R/cm6b/s4ZwvtRohwJqlNFI+HEnF8pmKkQ/JTgCYuQCLKGdXMkGzz0/JmbScDm7XHju+VM4Z9Yoqp6jqE6I5cNF2NfCntxR+KEirjiVI5W9sATDvRRaSKx847v+3mtEKqXwU9mQr87ZcjpusmQ0PnbnihrD2uToZdYnkSG+Fz5osJCQ8D406IM7GgnIMuTls4aouSlhlU2YvHDeQNd7++zqOp1bnHeB9yQ0UeTG3dNEY+crznd5Vignn1e0rK2jm8U+AWdqUqGvEQSAkRxIFXAsxtjtHWQ5jvIiHNSKsczArMf3LlR892RLNNabZMs+joaSLv/ElkuKWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZJ7nNZ6nvMSYL1B1rQkQGrO5GV/LUh0eSQpyFbPPl0=;
 b=D3MaPwIFPA4CI/3miSMQNFvW0p29E3vSE2xRAQzYiJEB8b+cgyUrDM+wENBGbOOpq0V2QmGjyFQckvYVEcYK2WV1Vdl+cBlraG+z/u9ipTyW4yjNXk9gkLTaopfAE8BU8SRCebXTylLJFxKX7NHOl6+Q/7WhK1FiIEddTORoOMTkBqpSDZhqSNw7uI7oBJNc0D1EFfvFAsHTaaJwyuDjnO4GIJgnZabv9U8S2pvBB8lJkppPtveZYonZA1m0YWDDREYw8aODO6ejSY2ycTqW5BNz7vdRv8rH2ns4U7aZcr92os6GcGs8iD5a/p+itib9dUBtKVuwq2dYJR0q/GHRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZJ7nNZ6nvMSYL1B1rQkQGrO5GV/LUh0eSQpyFbPPl0=;
 b=m2g0LUg9pbYqBXR3hwVux0xjZY7vJMtRl6S90fUtpnFU/WYMqWf5LBa/7pkXI1K6nLbmnLqxhcPG1wXy2K+0OBkzRy2viyguzX33UOvLxkVrV7oYpDUwk2Tk7o+iKT7MUmq0NxSkIa2ZDv+giyGLW3a+ozyI3oDEPp2uGepV3Jml5wa6itZfpEjILrHPljDaOJ5HwqKBoNVZqgGuW1cgkZRfKBzPdw/5H8JtE3IZmZ90pZmsMZMJuiK7W0bOCKGgm+fVMLSMnyigPDV6bje9HmQ9OdNLYIbM8bpL3EuBb3GUH1IyTlat+y9zYG+3I3ZOoUzazy+ct+NEEQJ6rs+e8g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4844.namprd20.prod.outlook.com (2603:10b6:930:23::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Sat, 26 Aug
 2023 08:43:58 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 08:43:58 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>, Wei Fu <wefu@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH V4] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Sat, 26 Aug 2023 16:44:38 +0800
Message-ID: <IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [QvmJ2czK3Ni5JmyBpTG5B0NI6xMbokXZEDiIIGUE7wQ=]
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230826084438.154358-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2c4d0e-989a-42f5-b37a-08dba61096c9
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EB/EQr+q11q+JsAPQ9zfesvGwA0uFncXq4shT/jdkgp3nswYHW7RLfzrDhq86gRZdSLh9TR+W2nGJRQGdKbm3CgBT5mJpbEIPUn5A00Dfu+DnzfPtq6ZqeLeRouj0yoLn+kAIFlMaIGYrpoDl40ACLFpFiib2I5NIQxN0wYIleo+E6d+wEGu2V5yzic8NFX1sVoqdR2XKzitHLo2WVZrbEaWQSbxUqIl6WPiGQqY8cmCyufr0wBZEaTmwNmf0rBljWTqnzdNKRiZFBqV75N2Hw4IGLWKtbVn73riIdTHHr58kHGDG4bkIq8CF0h5H5yHWJHzQDuVAr4ttgVs4LKIMpN3s02oqqUz/K4GOUEDbB1lzYmkvPLSQGZtShyIdT2lucfqPOX3TcoTz3AKb0ICzmmxvXuru2meD4yp0Q+B693n8f7S6puYRExcaZUtwRQcXE2rBDMXp1zz6BcqgqCmETfzUq8aNhucExavRa3R2QlTFe0wsMx3JmJ4trPPnIXnAUxBOyU6Ur2kObQFjH1oMGCU7WJrGpQz6R/7xcSM+F0IhjU/eMSCY5kp0Nc5X26xt8xoSNd1E61PB1UD3TO5bgKb1hK5zYVs4AaKAAVqCu2knO3MO5ZyB3JC+MoKU1fpZ85JAdZGMFBROK4IdRlUptLBtX7obRXi5om4MsJC0RB3wNXOI2TaGetrnq8oLBkuFDMZUHrdAfk2u/cPTVM90Jf5ck3WWBBEWns7a89DLmaYQzWQdOsR10w0G1X1xX6Hp7uxDOQezaOwCqqLQYXogvh8IHdVT892EARKLJb7ycSvhAVl0pQueUWLRqft6+o4a4SFmxZyC2tWeXLL6YgebVs
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoUwhaPLg5lDTcHI9HNq8j9dJbB59l9alScdmIMcUhwSFzVFL6EhKHv/yqIFZIyu5SF8ZwXOffi0fKTe1HRX+D3DdoPNyyhadfvIr2sMJNNdRSXNOEPe1MNfu3J13ValVNG1wMPYraMGBuDpO8dSxusJq48O6s/rhQdbrUPaTdvJhO4LvRO5tkC83PQSpjcTmiE8nDYl4na9QbTAgd82rA48gj15WdRz8MxW6wBTXA6LpEqqHErm2KiWuktTDcrw7wK1Ctsy/Lc9nD0d2zGSpJX8JvFnBoiplH8YfbhjblBYDCdYvEwaTGfJJZE8JYv9kgByF8uXiTUsfaQLtFOdBxNsVD9zLQJKbHy+oXyHbsLh2s9YayYyNh1kq46JvQLLT4nVfywny0Jk/CSpSsOcwIYqWVif0ltBUAyZi04aZZr/2LA6kndRWj7vYLmTLk4QjGBnePeAVXUVxDfpHPMaPQh1VRJj3mRnt/jdKrAZibNn5oq0hZB7XxQSi49iLnmzp8IU6PT7L7hL+tXbjegOjRUfFS/io2jcEK9hEAv8jvLr586+N0e1bd/uDIKjMHA6rVW3a4uWGPpXGV/c3Lh/y9nYYpFmOY0oO1z+iv1Kbhk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqArJnuFQyYE93qz+aPhifwTXyRQim/ML/65R0TK+Hx06g+L8iEgNVc1SW+a?=
 =?us-ascii?Q?3wiXsdqVcIIYDgMF+ihdqv5hbbxMm6mZoziiICtDoCt8v6dEv1uANl4YvWqJ?=
 =?us-ascii?Q?VDCdGB/SuwlAxBsMIMlE5B/6LAeWug55oAFOUQkuDdeFSEPl15yYDD21WVbK?=
 =?us-ascii?Q?vlk8+wGsFLw6RE4mmUoZXbd2AafocZ6GKvb3STCii35+7tl61N65pEEdt8Ji?=
 =?us-ascii?Q?mB1DrX6y5lR8WmjxszXGeqx9Rx8wzItIMoe87wBWTfsddxVswLwCjRoJN3RT?=
 =?us-ascii?Q?Fh8G7gLzACAGZGNiXVSiJJUSucYJKYW3cjtSWNnEib4XGrBQrT4RAl3lU1MN?=
 =?us-ascii?Q?/JDl7x/hnDB8ZcDgFRVoBx/NSm1VQPJg2rIuL0HW0xr7H7eO205fY1vU9ZYr?=
 =?us-ascii?Q?NjM+CeAMJzcBtx2dsqyw5qlt8XK4/mfdAMgjPtHPJDXRn5YY0/nMCoWl9bjE?=
 =?us-ascii?Q?s+pvJR9YEqrPMqZ2uL/lTDFktj+/l9x9UI985Xk+fsc3mvjDbMsvxv380zPt?=
 =?us-ascii?Q?KC7ACjdI+7isLTxm1Fn3vzkiJysBztbff78hNZCMu8bgGErbXjvIwvvpvFZa?=
 =?us-ascii?Q?aWuLtzzK/nHuSXONWVfWMbLY6GWIsTokT2VW+UrHsNsIiUnuQBFAano+GUCI?=
 =?us-ascii?Q?9XzOuQQ0Mj+VUCq2q6mksLf/7OwO2k6DnsSVTB1ZMQzkT9VTEP5lGwINBF2f?=
 =?us-ascii?Q?zvNzLTgklC8rt+mV4fnXleQsSf7Dbi/OxSN8ILNM5ZtnYB7P+eze4KpF8k35?=
 =?us-ascii?Q?A/Jzfx41Wgdyv8d2BY+pGJaTpLFzfHG7ABxoSYKoVrTD6Kcnl0hiuSAjspSC?=
 =?us-ascii?Q?mAxu7rnzofjY/M421D9skQwgRP+EuTIcgsS2digDGG3JBkKl3SO+ggj5C3jM?=
 =?us-ascii?Q?bsBt7OIC9vfWAomY0crFeLxTBl7G1v3NwGcITwhEknlCQ61iDyguDqNAfifr?=
 =?us-ascii?Q?I2mbn6VNZV7MOlgY4XQqS+rzd5W6vZxR39tvnX2g034f1Grfvwg8t5VTnxn/?=
 =?us-ascii?Q?PhFIKYEilX0kIkjro3AS/D6ZOJTttk4plC43XKGU/kKht927qvqHZ2wpyIy1?=
 =?us-ascii?Q?LZdbo5LBgyXzTXsZL5tYhZjIE4OzAGcgcId5mq7pa1lpdvN512OihSGoR8Q4?=
 =?us-ascii?Q?hVJYqYm0nkyXqhBl7NGlIDXVNw6rBpf+UeukOeJvULtXwbCOy/GXCHGDykg1?=
 =?us-ascii?Q?EYrkjxfsn41jQFb/YDKCfyrDR7Te+kc5PfN3cSsrMZGd36zWjxOcnj+QbFY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2c4d0e-989a-42f5-b37a-08dba61096c9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 08:43:58.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add json file of T-HEAD C9xx series events.

The event idx (raw value) is summary as following:

event id range   | support cpu
 0x01 - 0x2a     |  c906,c910,c920

The event ids are based on the public document of T-HEAD and cover
the c900 series.

These events are the max that c900 series support.
Since T-HEAD let manufacturers decide whether events are usable,
the final support of the perf events is determined by the pmu node
of the soc dtb.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
Change from V3:
1. fix some typo in json file
2. correct the event id range in commit
3. rename directory to c900-legacy to identify the old T-HEAD cpus

This patch need the following patches for opensbi to function normaly:
https://lists.infradead.org/pipermail/opensbi/2023-August/005500.html

The dtb patch:
https://lists.infradead.org/pipermail/linux-riscv/2023-August/039040.html

A test result on D1 board with mainline opensbi and mainline kernel:
[root@test perf]# ./perf stat -a \
>   -e l1_icache_access \
>   -e l1_icache_miss \
>   -e itlb_miss \
>   -e dtlb_miss \
>   -e jtlb_miss \
>   -e inst_branch_mispredict \
>   -e inst_branch \
>   -e inst_store \
>   -e l1_dcache_read_access \
>   -e l1_dcache_read_miss \
>   -e l1_dcache_write_access \
>   -e l1_dcache_write_miss \
>   -- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 100 2048 bits private RSA's in 10.06s
Doing 2048 bits public rsa's for 10s: 4051 2048 bits public RSA's in 10.00s
version: 3.1.2
built on: Sat Aug  5 14:56:47 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.100600s 0.002469s      9.9    405.1

 Performance counter stats for 'system wide':

     7,120,831,110      l1_icache_access
         2,145,279      l1_icache_miss
         1,307,935      itlb_miss
         2,477,482      dtlb_miss
           402,760      jtlb_miss
         8,043,723      inst_branch_mispredict
       153,469,454      inst_branch
       537,300,381      inst_store
       947,508,099      l1_dcache_read_access
           770,550      l1_dcache_read_miss
       537,262,702      l1_dcache_write_access
           171,436      l1_dcache_write_miss

      20.315046885 seconds time elapsed

---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/thead/c900-legacy/cache.json   | 67 ++++++++++++++++
 .../riscv/thead/c900-legacy/firmware.json     | 68 ++++++++++++++++
 .../riscv/thead/c900-legacy/instruction.json  | 72 +++++++++++++++++
 .../riscv/thead/c900-legacy/microarch.json    | 80 +++++++++++++++++++
 5 files changed, 288 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index c61b3d6ef616..b42b65d09c36 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,3 +15,4 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x5b7-0x0-0x0,v1,thead/c900-legacy,core
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
new file mode 100644
index 000000000000..2b142348d635
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
@@ -0,0 +1,67 @@
+[
+  {
+    "EventName": "L1_ICACHE_ACCESS",
+    "EventCode": "0x00000001",
+    "BriefDescription": "L1 instruction cache access"
+  },
+  {
+    "EventName": "L1_ICACHE_MISS",
+    "EventCode": "0x00000002",
+    "BriefDescription": "L1 instruction cache miss"
+  },
+  {
+    "EventName": "ITLB_MISS",
+    "EventCode": "0x00000003",
+    "BriefDescription": "I-UTLB miss"
+  },
+  {
+    "EventName": "DTLB_MISS",
+    "EventCode": "0x00000004",
+    "BriefDescription": "D-UTLB miss"
+  },
+  {
+    "EventName": "JTLB_MISS",
+    "EventCode": "0x00000005",
+    "BriefDescription": "JTLB miss"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_ACCESS",
+    "EventCode": "0x0000000c",
+    "BriefDescription": "L1 data cache read access"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_MISS",
+    "EventCode": "0x0000000d",
+    "BriefDescription": "L1 data cache read miss"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_ACCESS",
+    "EventCode": "0x0000000e",
+    "BriefDescription": "L1 data cache write access"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_MISS",
+    "EventCode": "0x0000000f",
+    "BriefDescription": "L1 data cache write miss"
+  },
+  {
+    "EventName": "LL_CACHE_READ_ACCESS",
+    "EventCode": "0x00000010",
+    "BriefDescription": "LL Cache read access"
+  },
+  {
+    "EventName": "LL_CACHE_READ_MISS",
+    "EventCode": "0x00000011",
+    "BriefDescription": "LL Cache read miss"
+  },
+  {
+    "EventName": "LL_CACHE_WRITE_ACCESS",
+    "EventCode": "0x00000012",
+    "BriefDescription": "LL Cache write access"
+  },
+  {
+    "EventName": "LL_CACHE_WRITE_MISS",
+    "EventCode": "0x00000013",
+    "BriefDescription": "LL Cache write miss"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json
new file mode 100644
index 000000000000..c822b5373333
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json
@@ -0,0 +1,72 @@
+[
+  {
+    "EventName": "INST_BRANCH_MISPREDICT",
+    "EventCode": "0x00000006",
+    "BriefDescription": "Mispredicted branch instructions"
+  },
+  {
+    "EventName": "INST_BRANCH",
+    "EventCode": "0x00000007",
+    "BriefDescription": "Retired branch instructions"
+  },
+  {
+    "EventName": "INST_JMP_MISPREDICT",
+    "EventCode": "0x00000008",
+    "BriefDescription": "Indirect branch mispredict"
+  },
+  {
+    "EventName": "INST_JMP",
+    "EventCode": "0x00000009",
+    "BriefDescription": "Retired jmp instructions"
+  },
+  {
+    "EventName": "INST_STORE",
+    "EventCode": "0x0000000b",
+    "BriefDescription": "Retired store instructions"
+  },
+  {
+    "EventName": "INST_ALU",
+    "EventCode": "0x0000001d",
+    "BriefDescription": "Retired ALU instructions"
+  },
+  {
+    "EventName": "INST_LDST",
+    "EventCode": "0x0000001e",
+    "BriefDescription": "Retired Load/Store instructions"
+  },
+  {
+    "EventName": "INST_VECTOR",
+    "EventCode": "0x0000001f",
+    "BriefDescription": "Retired Vector instructions"
+  },
+  {
+    "EventName": "INST_CSR",
+    "EventCode": "0x00000020",
+    "BriefDescription": "Retired CSR instructions"
+  },
+  {
+    "EventName": "INST_SYNC",
+    "EventCode": "0x00000021",
+    "BriefDescription": "Retired sync instructions (AMO/LR/SC instructions)"
+  },
+  {
+    "EventName": "INST_UNALIGNED_ACCESS",
+    "EventCode": "0x00000022",
+    "BriefDescription": "Retired Store/Load instructions with unaligned memory access"
+  },
+  {
+    "EventName": "INST_ECALL",
+    "EventCode": "0x00000025",
+    "BriefDescription": "Retired ecall instructions"
+  },
+  {
+    "EventName": "INST_LONG_JP",
+    "EventCode": "0x00000026",
+    "BriefDescription": "Retired long jump instructions"
+  },
+  {
+    "EventName": "INST_FP",
+    "EventCode": "0x0000002a",
+    "BriefDescription": "Retired FPU instructions"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json
new file mode 100644
index 000000000000..0ab6f288af91
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json
@@ -0,0 +1,80 @@
+[
+  {
+    "EventName": "LSU_SPEC_FAIL",
+    "EventCode": "0x0000000a",
+    "BriefDescription": "LSU speculation fail"
+  },
+  {
+    "EventName": "IDU_RF_PIPE_FAIL",
+    "EventCode": "0x00000014",
+    "BriefDescription": "Instruction decode unit launch pipeline failed in RF state"
+  },
+  {
+    "EventName": "IDU_RF_REG_FAIL",
+    "EventCode": "0x00000015",
+    "BriefDescription": "Instruction decode unit launch register file fail in RF state"
+  },
+  {
+    "EventName": "IDU_RF_INSTRUCTION",
+    "EventCode": "0x00000016",
+    "BriefDescription": "retired instruction count of Instruction decode unit in RF (Register File) stage"
+  },
+  {
+    "EventName": "LSU_4K_STALL",
+    "EventCode": "0x00000017",
+    "BriefDescription": "LSU stall times for long distance data access (Over 4K)",
+    "PublicDescription": "This stall occurs when translate virtual address with page offset over 4k"
+  },
+  {
+    "EventName": "LSU_OTHER_STALL",
+    "EventCode": "0x00000018",
+    "BriefDescription": "LSU stall times for other reasons (except the 4k stall)"
+  },
+  {
+    "EventName": "LSU_SQ_OTHER_DIS",
+    "EventCode": "0x00000019",
+    "BriefDescription": "LSU store queue discard others"
+  },
+  {
+    "EventName": "LSU_SQ_DATA_DISCARD",
+    "EventCode": "0x0000001a",
+    "BriefDescription": "LSU store queue discard data (uops)"
+  },
+  {
+    "EventName": "BRANCH_DIRECTION_MISPREDICTION",
+    "EventCode": "0x0000001b",
+    "BriefDescription": "Branch misprediction in BTB"
+  },
+  {
+    "EventName": "BRANCH_DIRECTION_PREDICTION",
+    "EventCode": "0x0000001c",
+    "BriefDescription": "All branch prediction in BTB",
+    "PublicDescription": "This event including both successful prediction and failed prediction in BTB"
+  },
+  {
+    "EventName": "INTERRUPT_ACK_COUNT",
+    "EventCode": "0x00000023",
+    "BriefDescription": "acknowledged interrupt count"
+  },
+  {
+    "EventName": "INTERRUPT_OFF_CYCLE",
+    "EventCode": "0x00000024",
+    "BriefDescription": "PLIC arbitration time when the interrupt is not responded",
+    "PublicDescription": "The arbitration time is recorded while meeting any of the following:\n- CPU is M-mode and MIE == 0\n- CPU is S-mode and delegation and SIE == 0\n"
+  },
+  {
+    "EventName": "IFU_STALLED_CYCLE",
+    "EventCode": "0x00000027",
+    "BriefDescription": "Number of stall cycles of the instruction fetch unit (IFU)."
+  },
+  {
+    "EventName": "IDU_STALLED_CYCLE",
+    "EventCode": "0x00000028",
+    "BriefDescription": "hpcp_backend_stall Number of stall cycles of the instruction decoding unit (IDU) and next-level pipeline unit."
+  },
+  {
+    "EventName": "SYNC_STALL",
+    "EventCode": "0x00000029",
+    "BriefDescription": "Sync instruction stall cycle fence/fence.i/sync/sfence"
+  }
+]
--
2.41.0

