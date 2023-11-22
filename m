Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5B7F4673
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjKVMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjKVMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:41:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2097.outbound.protection.outlook.com [40.92.41.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB312C;
        Wed, 22 Nov 2023 04:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8NeKcid/siHPeVHlHnQpVF/6IjKctFwU8+VZoZ306Ji5jSIAOl0fSGqj9Xdvkuv4cTTKNULk8sckVhZoM6AVGtVrKwh6C1lcAssSYTQ7s5WrV9nNQ73lLW7NzCZIYrCsofotaOOU4piQM1N8XVJawO9in3h4WDv0O2IKhDsiClfy/hyA1Gct0SEFiQW8iaNYwpqB9EE51L0o4/eMQIphqsnN8kQAl51m3/qMgiwxBTttAbscIcW/pJhrMbnYWOHnsGEdC1Bsm3JjAkmv8JseePN+4R7pM/ysaEh0vNSouUsainGmtW4c5Uszl2fJKX9XXv10puul20osuAuK2q+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvw3h6FioMg4PK5p5fNJW1vQnpncRenq+hQCcqJAZP0=;
 b=gMHb06c+LpRBoU0LBjoI30nj+dvcH/SPXn+OSQUOE7s7+bb1HAa7YBfrco552hgzO0cgEk/otqLKaM4h6QEaTSw5w+3+bG8tf6pXQeAjYUYV4o68Pb9xnQRFPEpMQNzQKFmstOym/0f7SlPyrkfLjTRcgmUwVdQXDMSTG9y/KHIKatQz09yndxWq9td6h2kK/sWd7plhyxw6q8qZDgBfvemD3fxYykyiCIhNg6xHsqy9HK7xEDgVbyZO2c8f/5pXYppQcBo3lEqaZ12Pk1wF9n09qZvFvDnON2gY5CFg+9eduDV27/+T/6loqpJEOl5bU42cBUSzHT0YTfxTx+D9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvw3h6FioMg4PK5p5fNJW1vQnpncRenq+hQCcqJAZP0=;
 b=ttwHTI+9AWqsPX1pKY7IvInkKS31ajfMZoOHysTClorkgZ5JSRdDbd7xoQ8ZsUHnzK7GGYETsA8bRY5jNplSxCgrMviHXqAESqwcUHkRxBUaSXVto6/hdeML25Dn12di8AIrEHq4z8aKDwxUfPej8EMViDFeTB88azvOflqF/sLq4MjUhxz34a2D3bQ/199KJjHmyX15qMIq4RjQYnd95rmpnp87DMH6O/K2qAqdSUrh9e61fjLWwWk32GpGFQgF6BW7iLa61AcTcoS2zqydzXVg3iDN7v2iQn1rpQexxWqs7TRwW/9+8gkHN1lO1NhYWIml+ajJKCq4wMC1egPlmA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6246.namprd20.prod.outlook.com (2603:10b6:208:3f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 12:41:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 12:41:44 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Wei Fu <wefu@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V4 RESEND] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 22 Nov 2023 20:41:06 +0800
Message-ID: <IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qdDgYaHcsczjhX8Sqo05jecRSAP5g+zOOzentFXGi30=]
X-ClientProxiedBy: TYAPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231122124106.836436-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d4352a-522a-48cb-bce3-08dbeb586261
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr8JH/NXHihiANn9ml2v/YK3e7eNUZql8TUHo7gA30rSD0u0ym/Ae7KqNaQ2pM3e+8jzWwx97OBK/YKy0BylxauSQS/XLIqNLuuuczyhIKGNsP4ONOsJX5Kqj3v8GWyCdFrthFFJbREcsAkpkM3VGepVH+FoSu3LsYgoxJcixMgj6m8qi2USEb9cHaq5dD1j0N9Ukq7q8i7ZzqXP2jvv/0iYthe2CIEpAvGBC1M4nsWfFkT1aB8+Lo/PHtSpMIAVCfJhFt+dNwvQUXmfnYjgTo4ya3Y3NGmkx9VLpJwQ+Jw2Qn9aXBs82QMBBqy2ocWgnA/N/j57lqf1DbhVNC4/LW3wTOxUw5bwayTJdyIsIk/PM8o9EGSp3ZHtEGXXXMbI/G8EID/AIugwjEn13NyxLF2IGZ875oo/oqjvd+ZLror2fibA9ttfCxH1c0EjbH/53VZZDhnJeAvxOsxjXwozbXxe/sNJgjRKoPAt2atJIG8vPjgWOIuB10vv8Eg0GIQeJzLzj+ACxXYMJda3wBwITsH05PuJ8HFUPHGXFhIa2fy4Z2hw5G9SH2egvg/U7Icm+dmFVRy/xJ0cH1AC77q7xNmwTR760QKLPYM8/6erAJlzm3tueMR1z14FnYCQ4RK7Ppq2kAdH2TIxoRg4fnQv9rbgZ05oRi5Yc49qPtc2ZZs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGEAefeJHo/KWUhPKA02HVIoDoarziG7Ifz8icpX8YZ34S6Soi0ZRSVvEn7X?=
 =?us-ascii?Q?HU9RvjNpRaMqGXdD7oDZYZKNmO1viiFhNr+wmXmB0XsY9ayZjleoeDGZG+mb?=
 =?us-ascii?Q?kX2ctC54zqxyPX8XG9pTt99C4br7gAJ8u53QTKGiYNdN25Mluqn++/HfsRNQ?=
 =?us-ascii?Q?SgYSd1f5fQaC+mJcnoC/74rqWuWJqaMS+UobCr02Zmvn9RfIr3jIsOQkkm5Q?=
 =?us-ascii?Q?/v3kI1+6t1va+VpJJ0B5yHBloSKfxWyWkOPvyPKxniMbQoRSNlnev/QvVN45?=
 =?us-ascii?Q?tXD9K/0jphviouGjE+apZIpc51DCY35ymATzAYLrNK3KybVsuSSuWZPft7PT?=
 =?us-ascii?Q?TOaZbCCikB4sDpc5gb564jcB3r3kAqhzqyNQKN3SNSG1KjqgBKKwnSEJdtO6?=
 =?us-ascii?Q?Fslx8FHsBewKPVe7algxsDSn9aBuuuYB8uWr6NaF1qnQ2TD4eZB011JMELmd?=
 =?us-ascii?Q?T94x55yYiygYLQsCuHXP9wFJvZLTFbejjVLiw3pp1CM9cVl83/cdTHQiFhvn?=
 =?us-ascii?Q?yPWAR1cKfBtS6UvXFyPS1gzpTjBaLq24J24qjRD7EP/XXGSMV2OaoCT387Ss?=
 =?us-ascii?Q?jd4P9AAUrKm94n1lSrJm0FQhT0V7MmqZEB5u9ty8OjtyeCRJzkqmlwKwI2te?=
 =?us-ascii?Q?b50201rfdsJrKdW77oj3CcNuVwQzZAlXLjCeDRSwPKKHCgZFuf6nIBuBcJpz?=
 =?us-ascii?Q?llHq/seixfkn4TINLzCO3nCHqpeCFDMCbXJyQn9rKlM7sLRhLcMOAoib8x+L?=
 =?us-ascii?Q?Qki3SLZE8+BJLkkSZa4lkeYNLC0+oL0CiKe1ThVuH8hYXrVfnNoAqhZ5EH7b?=
 =?us-ascii?Q?WkIHdf71u1f/+ziihBBrX/XITPzqyfMh8v/U6iECGwbSfIhzqg/vAXqo5U1E?=
 =?us-ascii?Q?dQJ5SBD8E8adP6tOkJ1gpb1kVZEFEAGNf6mb9zDace7BGb1m/SKO7d3BnW/G?=
 =?us-ascii?Q?gOS9MP8bdd7tXD2x/uTDxgI0/XLDYpwpnLxvUuNuYCZzbLpk8CUj+K0NGxsT?=
 =?us-ascii?Q?uGYPxwC6HsxWT08rDwPIhEroDMf87E0b5M3m6XD+dXiOEQW2sQbxJhf1AxXj?=
 =?us-ascii?Q?JcMjWY9raGGEuiATEqW8lrQLr+Xqfcp0uQnFcvXCH8IsdfVphim9N3lnviwa?=
 =?us-ascii?Q?r1gxQY+S5qKajJ6sgVuRVMmV6UszuEh5pznN4kz0AH6oS2ZPt9LkQrJaBBEA?=
 =?us-ascii?Q?5pOKSPC/J0xogqceH/Fh5+ZND5sQqfz7VXhHcTJkAJwp7ZhWTkeA3R76LMg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4352a-522a-48cb-bce3-08dbeb586261
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 12:41:44.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Guo Ren <guoren@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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

