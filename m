Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1B7D7983
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjJZAcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjJZAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C108185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a839b31a0dso4846007b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280345; x=1698885145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlWGnfTZDIsgL3Vvd2XnYyZue3ilWZ3uUrC8lYLje/s=;
        b=E+gvav5XPeurmK3VCuV/foUpWH2E5rqLySfX8EH/uHmDJFckc6oL3ES3GUePBOqRyk
         YWhVF1SbSGaR48eRkZm63DjHfkF95rNeZbqIQ08Z6lL6vSCb7DxgGGLF030d05Ceiuxx
         UsrNoPyMsBQHIY+IxsQiEQwsYshiU9MdEdL4zzsbW2LlBg6fainOiF2xnw25aJ6Ylc7I
         xGYDUvkau9VO5dCZ3uD+oz2Z/fs9/Uyca7ZlcAZV4Bq8eyobnoqzBFXyC5R0nT9ERziG
         GzRW0H4ukKyBe1xSDxzZBnwNEGm+A6/0PTI96JKjOt61FBywSdDj4IAaZMOJYfqFvEwt
         GUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280345; x=1698885145;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PlWGnfTZDIsgL3Vvd2XnYyZue3ilWZ3uUrC8lYLje/s=;
        b=mdzVlsN1Io7rOekK9EJSfXSC5gD+OGYW/NewWyB9LisG5LHxADarL1XD+u0TyxewN5
         gTdLTC3OCS9F1IUlnoZovQgIf2EsnhEdzWLqecmzD3mmmokS2PJqHgGJBJ1+PbZ4gyom
         igRhQOCyxm7Q4M6Iv2yJoP8FQkJWCfOcEPU49hCBCCbPYtNnkLLZQIXhOcUgJ7y3/4QF
         QkLzOGHCKHi/WcNZebg9llcfAlW2pilGaqsm9PO6hXDvoBOsmpBiINBVXd7QZ2vUYz6u
         Q63Ju4WoYcl73JuMREhyoajR6SJr7ffT7a3T7nMThIMWrR00wxXvVQ7sneAzprLUaLJh
         QyEQ==
X-Gm-Message-State: AOJu0YzgvrPWNHYYc7vG2GJxVXBFNbPvfsk2sJWejfnN9FAgO7ugp1QL
        ZR+kCOWArvfKyfBCLGTu/0v6o0UNSCxW
X-Google-Smtp-Source: AGHT+IGDk5p6drd67XIPLOiPHChFE+eRz4a8p0Kp/5PYvM+RJVnzxF8V5oTONe3/bRolIXb2VAv5nGjtP8ly
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:7485:0:b0:d9a:cbf9:1c8d with SMTP id
 p127-20020a257485000000b00d9acbf91c8dmr313198ybc.12.1698280345630; Wed, 25
 Oct 2023 17:32:25 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:45 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-5-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 5/9] perf vendor events intel: Update knightslanding events
 to v16
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update knightslanding from v10 to v16 adding the changes from:
https://github.com/intel/perfmon/commit/6c1f169f6ed63ee1fd75ebb303d0fd06d71=
196f5
https://github.com/intel/perfmon/commit/b22ca587ec8b5ac20471ea2f14924f63e63=
afe9d
https://github.com/intel/perfmon/commit/e685286f083ee81cb7dafd0cd8546c79ee4=
33187

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/knightslanding/cache.json        | 39 ++++++++-----
 .../x86/knightslanding/floating-point.json    |  8 +--
 .../arch/x86/knightslanding/pipeline.json     | 55 +++++++++++--------
 .../arch/x86/knightslanding/uncore-cache.json | 26 ++++-----
 .../x86/knightslanding/virtual-memory.json    |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 75 insertions(+), 57 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index d9876cb06b08..8da3a5a7be73 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -6,13 +6,19 @@
         "SampleAfterValue": "200003"
     },
     {
-        "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cumulative count of core cycles t=
he fetch stalled for all icache misses.",
+        "BriefDescription": "This event counts the number of core cycles t=
he fetch stalls because of an icache miss. This is a cumulative count of cy=
cles the NIP stalled for all icache misses.",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
-        "PublicDescription": "This event counts the number of core cycles =
the fetch stalls because of an icache miss. This is a cumulative count of c=
ycles the NIP stalled for all icache misses.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number of L2HWP allocated into XQ =
GP",
+        "EventCode": "0x3E",
+        "EventName": "L2_PREFETCHER.ALLOC_XQ",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache misses",
         "EventCode": "0x2E",
@@ -28,7 +34,7 @@
         "UMask": "0x4f"
     },
     {
-        "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) excluding SW prefetches =
filling only to L2 cache and L1 evictions (automatically exlcudes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
+        "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) excluding SW prefetches =
filling only to L2 cache and L1 evictions (automatically excludes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
         "EventCode": "0x30",
         "EventName": "L2_REQUESTS_REJECT.ALL",
         "SampleAfterValue": "200003"
@@ -50,11 +56,12 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Counts the loads retired that get the data fr=
om the other core in the same tile in M state",
+        "BriefDescription": "Counts the loads retired that get the data fr=
om the other core in the same tile in M state (Precise Event)",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.HITM",
         "PEBS": "1",
+        "PublicDescription": "This event counts the number of load micro-o=
ps retired that got data from another core's cache. (Precise Event).",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
@@ -67,20 +74,22 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of load micro-ops retired t=
hat hit in the L2",
+        "BriefDescription": "Counts the number of load micro-ops retired t=
hat hit in the L2 (Precise Event)",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_HIT_LOADS",
         "PEBS": "1",
+        "PublicDescription": "This event counts the number of load micro-u=
ops retired that hit in the L2 (Precise Event)",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in the L2",
+        "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in the L2 (Precise Event)",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_MISS_LOADS",
         "PEBS": "1",
+        "PublicDescription": "This event counts the number of load micro-o=
ps retired that miss in the L2 (Precise Event)",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
     },
@@ -620,6 +629,15 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Accounts for responses which miss its own til=
e's L2.",
+        "EventCode": "0xB7",
+        "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x18001981F8",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts any request that are outstanding, per =
weighted cycle, from the time of the request to when any response is receiv=
ed. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
@@ -1664,15 +1682,6 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that provides no supplier details",
-        "EventCode": "0xB7",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000020020",
-        "SampleAfterValue": "100007",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
any response",
         "EventCode": "0xB7",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
index ecc96f32f167..089aa3ef345d 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
@@ -8,18 +8,18 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts the number of vector SSE, AVX, AVX2, A=
VX-512 micro-ops retired. More specifically, it counts packed SSE, AVX, AVX=
2, AVX-512 micro-ops (both floating point and integer) except for loads (me=
mory-to-register mov-type micro-ops), packed byte and word multiplies.",
+        "BriefDescription": "Counts the number of packed SSE, AVX, AVX2, A=
VX-512 micro-ops (both floating point and integer) except for loads (memory=
-to-register mov-type micro-ops), packed byte and word multiplies.",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.PACKED_SIMD",
-        "PublicDescription": "This event counts the number of packed vecto=
r SSE, AVX, AVX2, and AVX-512 micro-ops retired (floating point, integer an=
d store) except for loads (memory-to-register mov-type micro-ops), packed b=
yte and word multiplies.",
+        "PublicDescription": "The length of the packed operation (128bits,=
 256bits or 512bits) is not taken into account when updating the counter; a=
ll count the same (+1). \r\nMask (k) registers are ignored. For example: a =
micro-op operating with a mask that only enables one element or even zero e=
lements will still trigger this counter (+1)\r\nThis event is defined at th=
e micro-op level and not instruction level. Most instructions are implement=
ed with one micro-op but not all.",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Counts the number of scalar SSE, AVX, AVX2, A=
VX-512 micro-ops retired. More specifically, it counts scalar SSE, AVX, AVX=
2, AVX-512 micro-ops except for loads (memory-to-register mov-type micro op=
s), division, sqrt.",
+        "BriefDescription": "Counts the number of scalar SSE, AVX, AVX2, A=
VX-512 micro-ops except for loads (memory-to-register mov-type micro ops), =
division, sqrt.",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.SCALAR_SIMD",
-        "PublicDescription": "This event counts the number of scalar SSE, =
AVX, AVX2, AVX-512 micro-ops retired (floating point, integer and store) ex=
cept for loads (memory-to-register mov-type micro ops), division, sqrt.",
+        "PublicDescription": "This event is defined at the micro-op level =
and not instruction level. Most instructions are implemented with one micro=
-op but not all.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     }
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 3dc532107ead..5b2e71750976 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -1,13 +1,13 @@
 [
     {
-        "BriefDescription": "Counts the number of branch instructions reti=
red",
+        "BriefDescription": "Counts the number of branch instructions reti=
red (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "SampleAfterValue": "200003"
     },
     {
-        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -15,7 +15,7 @@
         "UMask": "0xf9"
     },
     {
-        "BriefDescription": "Counts the number of far branch instructions =
retired.",
+        "BriefDescription": "Counts the number of far branch instructions =
retired. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -23,7 +23,7 @@
         "UMask": "0xbf"
     },
     {
-        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -31,7 +31,7 @@
         "UMask": "0xfb"
     },
     {
-        "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps.",
+        "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -39,7 +39,7 @@
         "UMask": "0x7e"
     },
     {
-        "BriefDescription": "Counts the number of branch instructions reti=
red that were near indirect CALL or near indirect JMP.",
+        "BriefDescription": "Counts the number of branch instructions reti=
red that were near indirect CALL or near indirect JMP. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -47,7 +47,7 @@
         "UMask": "0xeb"
     },
     {
-        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -55,7 +55,7 @@
         "UMask": "0xfd"
     },
     {
-        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -63,7 +63,7 @@
         "UMask": "0xf7"
     },
     {
-        "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps and predicted taken.",
+        "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps and predicted taken. (Precise Event)",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -71,14 +71,14 @@
         "UMask": "0xfe"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired",
+        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "SampleAfterValue": "200003"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted near CALL b=
ranch instructions retired.",
+        "BriefDescription": "Counts the number of mispredicted near CALL b=
ranch instructions retired. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CALL",
         "PEBS": "1",
@@ -86,7 +86,7 @@
         "UMask": "0xf9"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted far branch =
instructions retired.",
+        "BriefDescription": "Counts the number of mispredicted far branch =
instructions retired. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -94,7 +94,7 @@
         "UMask": "0xbf"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -102,7 +102,7 @@
         "UMask": "0xfb"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps.",
+        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -110,7 +110,7 @@
         "UMask": "0x7e"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were near indirect CALL or near indirect JMP.",
+        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were near indirect CALL or near indirect JMP. (Precis=
e Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -118,7 +118,7 @@
         "UMask": "0xeb"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted near relati=
ve CALL branch instructions retired.",
+        "BriefDescription": "Counts the number of mispredicted near relati=
ve CALL branch instructions retired. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -126,7 +126,7 @@
         "UMask": "0xfd"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired. (Precise Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -134,7 +134,7 @@
         "UMask": "0xf7"
     },
     {
-        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps and predicted taken.",
+        "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps and predicted taken. (Precise =
Event)",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -189,7 +189,14 @@
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "Counts all nukes",
+        "BriefDescription": "Counts the number of instructions retired (Pr=
ecise Event)",
+        "EventCode": "0xC0",
+        "EventName": "INST_RETIRED.ANY_PS",
+        "PEBS": "2",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts all machine clears",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "SampleAfterValue": "200003",
@@ -261,20 +268,22 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with a store",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with a store  (Preci=
se Event)",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
         "PEBS": "1",
+        "PublicDescription": "This event counts the number of retired load=
s that were prohibited from receiving forwarded data from a previous store =
because of address mismatch.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of occurrences a retired lo=
ad that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad was pushed into the rehab queue because it sees a cache line split. Each=
 split should be counted only once. (Precise Event)",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_SPLITS",
         "PEBS": "1",
+        "PublicDescription": "This event counts the number of retired load=
s which was pushed into the recycled queue that experienced cache line boun=
dary splits (Precise event). Not that each split should be counted only onc=
e.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
@@ -286,7 +295,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Counts the store micro-ops retired that were =
pushed in the rehad queue because the store address buffer is full",
+        "BriefDescription": "Counts the store micro-ops retired that were =
pushed in the rehab queue because the store address buffer is full",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.STA_FULL",
         "SampleAfterValue": "200003",
@@ -301,7 +310,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts the total number of core cycles the Al=
loc pipeline is stalled when any one of the reservation stations is full.",
+        "BriefDescription": "Counts the total number of core cycles alloca=
tion pipeline is stalled when any one of the reservation stations is full."=
,
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
index 1b8dcfa5461c..120e4813d82a 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
@@ -2558,7 +2558,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2566,7 +2566,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2574,7 +2574,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2582,7 +2582,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2590,7 +2590,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2598,7 +2598,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2606,7 +2606,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2614,7 +2614,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2622,7 +2622,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2630,7 +2630,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ANY_REJECT_IRQ0",
         "PerPkg": "1",
@@ -2638,7 +2638,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2646,7 +2646,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_VICTIM",
         "PerPkg": "1",
@@ -2654,7 +2654,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_WAY",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
index 99a8fa8f19cc..9be30a33b43b 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of load micro-ops retired t=
hat cause a DTLB miss",
+        "BriefDescription": "Counts the number of load micro-ops retired t=
hat cause a DTLB miss (Precise Event)",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 7093561389a1..b25f9d90b2d7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -19,7 +19,7 @@ GenuineIntel-6-6[AC],v1.21,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
-GenuineIntel-6-(57|85),v10,knightslanding,core
+GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.00,lunarlake,core
 GenuineIntel-6-A[AC],v1.04,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
--=20
2.42.0.758.gaed0368e0e-goog

