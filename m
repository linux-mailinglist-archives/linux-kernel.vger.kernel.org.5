Return-Path: <linux-kernel+bounces-109674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEF881C45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA091C21253
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84252F70;
	Thu, 21 Mar 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxVEFMnx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377A3A8CE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000844; cv=none; b=AP0Z2S8Wi88t3uCFotbHxTXMQe4EvdkEw4YU2Lk0mEpH9gLXfMohTOb/RGRjSgiqI0hUG0sCsyLrHbF+ar7hyq9jHiGT8kXIzo4PC7VO8SZEooIOVNbih8U2N6dDdT2UAsH1WwRFyVWidx9wobp5PCsuqIjFF+KnSkLJ3+sp4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000844; c=relaxed/simple;
	bh=2sCGHhfTvM1eiqRT31kAjLhAeORQLvJAfAZ05gaUerQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=brmX7QyamhQM1H9HMER5tzYnlUjycQgF0PZyjSf2/12roKR7rjD0EQmmWOc7FOMbAZj/d5xBXABbtq7PigPJNhhm2hlu9ahKx1+4BYTM7OmfJTbgYTL+P1Ifea1khffk9W+6QTwdQ2WEvpgzgkfp7Ovm74rJ3111QHWOac55sBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxVEFMnx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so1021412276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000840; x=1711605640; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f2Tz0wa9PP4JsoaCr/wF5HYEQ1obQs2H+ep9hMsTjo=;
        b=PxVEFMnxIh+AcS5yd18RI7SeEi66dGNoKBsGZX2YRxrrAYHCTEetEtKmJl9BPzhGcd
         g3/U5pIqscoE23Lgf56v2UNJVZ/HKx40SaQK+nDLqpJpwqhVLOb5TopphJU/01CeHG4Y
         nZ/6usrpGguZSy7LNuKU3qNhZd61Q8UOj4lp79K6uKrd7tRWFf5yM89sPNmAQhiH8Ebg
         GG66HRcsUa3m1WkPy7gnmkTyxbGzmXdFF8fiyU4qIBoN1v+pGD8Kp2Z5fM8qjo1+oOFS
         1vn6xdEm3Dy8eT4qO0JUif24NueA4BiPj5UiMGrlGFVX7YkFrl/r8We+rbRlJoLQ0SYn
         GQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000840; x=1711605640;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6f2Tz0wa9PP4JsoaCr/wF5HYEQ1obQs2H+ep9hMsTjo=;
        b=LWuhV7qJ4zVbY9vD0Msle33eQro4/bW4H1FIEa4funnEFs48AnQDiS8Keiswz2oEFo
         azdd5hYRvH5Onx/XXHb/jg1l5+7atj21vBWbEaBx2DUZLML2w+/NzWdTfONfpoHDZRKG
         bLlFyReSYlAsgvaVjzPJXA+A3HPw7k7ao54IrROrMHNZq017yk4RgX4admztwx0VX+hq
         nOPVSnVqQYUFfrvoq/BJkkprZ7nFJyZ7SzA7w3WiSPYYXkuMo+bxsm4KaJgUZgWCDeRI
         Q8IUftAR3t5uz0F9UuM3D+FGcGB5T8+ie8KBxQDrW87+Bcy4bLqcVDvc3wIoSDbgs0VG
         vPbg==
X-Forwarded-Encrypted: i=1; AJvYcCWzWTQ+yQVa42jmPG2c61Y3xkKTjz1RBOeiMLOwvQlCiSJDiU5Po9WNO0+y2zfbTB1/z2Y+iyRVTvqK93+Iug3HjWDgHw3VloSvOhtU
X-Gm-Message-State: AOJu0Yz1g+m2ZnhgimntHoNKnYgTWS/VhnwxQe0KUTaOho00my89ny/w
	Ve62ZUE1zekTxmmwLxQANEEQkTR7dpLWB3rtkY5MPnNwRj/tB3BTuRJCHoFC/Byl0tq4PkumVZ6
	bepAoIQ==
X-Google-Smtp-Source: AGHT+IHTJi2GTvvRI42Q5AFPFDj3KegPH5WeaBPpBHusLoVhhDjjb1FoRh5RUtm1vb8QKvqvL5iGEuPEZI5i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:983:b0:dcb:b9d7:2760 with SMTP id
 bv3-20020a056902098300b00dcbb9d72760mr2040596ybb.13.1711000840263; Wed, 20
 Mar 2024 23:00:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:11 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 07/12] perf vendor events intel: Update sapphirerapids to 1.20
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from 1.17 to 1.20 as released in:
https://github.com/intel/perfmon/commit/6f674057745acf0125395638ca6be36458a=
59bda

Various description updates. Adds uncore events
UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_LOCAL,
UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_REMOTE,
UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL, UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE,
UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL,
UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_LOCAL,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_REMOTE,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_LOCAL,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_REMOTE,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_LOCAL,
UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_REMOTE and removes core events
AMX_OPS_RETIRED.BF16 and AMX_OPS_RETIRED.INT8.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sapphirerapids/cache.json        |   1 +
 .../arch/x86/sapphirerapids/frontend.json     |   2 +-
 .../arch/x86/sapphirerapids/memory.json       |   1 +
 .../arch/x86/sapphirerapids/pipeline.json     |  19 +--
 .../arch/x86/sapphirerapids/uncore-cache.json | 112 +++++++++++++++++-
 .../sapphirerapids/uncore-interconnect.json   |  26 ++--
 7 files changed, 130 insertions(+), 33 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index fedaacbe981a..e5de35c96358 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.02,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.17,sapphirerapids,core
+GenuineIntel-6-8F,v1.20,sapphirerapids,core
 GenuineIntel-6-AF,v1.01,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 9606e76b98d6..b0447aad0dfc 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -432,6 +432,7 @@
         "BriefDescription": "Retired load instructions with remote Intel(R=
) Optane(TM) DC persistent memory as the data source where the data request=
 missed all caches.",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
+        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with remote=
 Intel(R) Optane(TM) DC persistent memory as the data source and the data r=
equest missed L3.",
         "SampleAfterValue": "100007",
         "UMask": "0x10"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 9e53da55d0c1..93d99318a623 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -267,7 +267,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index e8bf7c9c44e1..5420f529f491 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -264,6 +264,7 @@
         "BriefDescription": "Number of times an RTM execution aborted.",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
+        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 2cfe814d2015..e2086bedeca8 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -1,20 +1,4 @@
 [
-    {
-        "BriefDescription": "AMX retired arithmetic BF16 operations.",
-        "EventCode": "0xce",
-        "EventName": "AMX_OPS_RETIRED.BF16",
-        "PublicDescription": "Number of AMX-based retired arithmetic bfloa=
t16 (BF16) floating-point operations. Counts TDPBF16PS FP instructions. SW =
to use operation multiplier of 4",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "AMX retired arithmetic integer 8-bit operatio=
ns.",
-        "EventCode": "0xce",
-        "EventName": "AMX_OPS_RETIRED.INT8",
-        "PublicDescription": "Number of AMX-based retired arithmetic integ=
er operations of 8-bit width source operands. Counts TDPB[SS,UU,US,SU]D ins=
tructions. SW should use operation multiplier of 8.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
         "CounterMask": "1",
@@ -444,6 +428,7 @@
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -451,6 +436,7 @@
         "BriefDescription": "Retired NOP instructions.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
+        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -467,6 +453,7 @@
         "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
+        "PEBS": "1",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index cf6fa70f37c1..25a2b9695135 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -4143,6 +4143,42 @@
         "UMask": "0xcd43ff04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on the local socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.   Does not include addressless requests such as =
locks and interrupts.",
+        "UMask": "0xcd42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on a remote socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.   Does not include addressless requests such as =
locks and interrupts.",
+        "UMask": "0xcd437f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on the local socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on a remote socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc437f04",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; Misses from local IO",
         "EventCode": "0x35",
@@ -4153,7 +4189,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; ItoM misses from local IO",
+        "BriefDescription": "TOR Inserts : ItoM, indicating a full cacheli=
ne write request, from IO Devices that missed the LLC",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
@@ -4171,7 +4207,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RdCur and FsRdCur misses from lo=
cal IO",
+        "BriefDescription": "TOR Inserts; RdCur and FsRdCur requests from =
local IO that miss LLC",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
@@ -4197,6 +4233,24 @@
         "UMask": "0xc8f3ff04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on a remote socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f2ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on the local socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f37f04",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; RFO from local IO",
         "EventCode": "0x35",
@@ -5565,6 +5619,42 @@
         "UMask": "0xcd43fe04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that missed the LLC and targets loca=
l memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xcd42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that missed the LLC and targets remo=
te memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xcd437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; ITOM misses from local IO and =
targets local memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xcc42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; ITOM misses from local IO and =
targets remote memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xcc437e04",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RdCur and FsRdCur misses from =
local IO",
         "EventCode": "0x36",
@@ -5574,6 +5664,24 @@
         "UMask": "0xc8f3fe04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur misses from =
local IO and targets local memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xc8f2fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur misses from =
local IO and targets remote memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0xc8f37e04",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO misses from local IO",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnec=
t.json
index 65d088556bae..22bb490e9666 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
@@ -4888,7 +4888,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AD)",
+        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO Ingress (V-EMIB) (AD)",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AD",
         "PerPkg": "1",
@@ -4897,7 +4897,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AK)",
+        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO Ingress (V-EMIB) (AK)",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AK",
         "PerPkg": "1",
@@ -4906,7 +4906,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AKC)",
+        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO Ingress (V-EMIB) (AKC)",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AKC",
         "PerPkg": "1",
@@ -4915,7 +4915,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (BL)",
+        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO Ingress (V-EMIB) (BL)",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.BL",
         "PerPkg": "1",
@@ -4924,7 +4924,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (IV)",
+        "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO Ingress (V-EMIB) (IV)",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.IV",
         "PerPkg": "1",
@@ -5291,7 +5291,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass : Matches on Receive path of a UPI port.\r\nMatch based on =
UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable=
\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote E=
nable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr E=
nable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded=
 (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\n=
Note: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass : Matches on Receive path of a UPI port. Match based on UMa=
sk specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcod=
e (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Ena=
ble R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enabl=
e Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even un=
der specific opcode match_en cases. Note: If Message Class is disabled, we =
expect opcode to also be disabled.",
         "UMask": "0xe",
         "Unit": "UPI"
     },
@@ -5300,7 +5300,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass, Match Opcode : Matches on Receive path of a UPI port.\r\nM=
atch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Messag=
e Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\=
r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: D=
ual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control type=
s are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match=
_en cases.\r\nNote: If Message Class is disabled, we expect opcode to also =
be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass, Match Opcode : Matches on Receive path of a UPI port. Matc=
h based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class E=
nable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S=
: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single =
Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL, =
LLCRD) even under specific opcode match_en cases. Note: If Message Class is=
 disabled, we expect opcode to also be disabled.",
         "UMask": "0x10e",
         "Unit": "UPI"
     },
@@ -5309,7 +5309,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard : Matches on Receive path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard : Matches on Receive path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0xf",
         "Unit": "UPI"
     },
@@ -5318,7 +5318,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard, Match Opcode : Matches on Receive path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard, Match Opcode : Matches on Receive path of a UPI port. Ma=
tch based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class=
 Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable=
 S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Singl=
e Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL=
, LLCRD) even under specific opcode match_en cases. Note: If Message Class =
is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10f",
         "Unit": "UPI"
     },
@@ -5763,7 +5763,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass : Matches on Transmit path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass : Matches on Transmit path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0xe",
         "Unit": "UPI"
     },
@@ -5772,7 +5772,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass, Match Opcode : Matches on Transmit path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass, Match Opcode : Matches on Transmit path of a UPI port. Ma=
tch based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class=
 Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable=
 S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Singl=
e Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL=
, LLCRD) even under specific opcode match_en cases. Note: If Message Class =
is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10e",
         "Unit": "UPI"
     },
@@ -5781,7 +5781,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard : Matches on Transmit path of a UPI port.\r\nMatch based=
 on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class En=
able\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remo=
te Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot H=
dr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excl=
uded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.=
\r\nNote: If Message Class is disabled, we expect opcode to also be disable=
d.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard : Matches on Transmit path of a UPI port. Match based on=
 UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: O=
pcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr=
 Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr E=
nable Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) eve=
n under specific opcode match_en cases. Note: If Message Class is disabled,=
 we expect opcode to also be disabled.",
         "UMask": "0xf",
         "Unit": "UPI"
     },
@@ -5790,7 +5790,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard, Match Opcode : Matches on Transmit path of a UPI port.\=
r\nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Me=
ssage Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Ena=
ble\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\n=
Q: Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control =
types are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode m=
atch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to a=
lso be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard, Match Opcode : Matches on Transmit path of a UPI port. =
Match based on UMask specific bits: Z: Message Class (3-bit) Y: Message Cla=
ss Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enab=
le S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Sin=
gle Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NU=
LL, LLCRD) even under specific opcode match_en cases. Note: If Message Clas=
s is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10f",
         "Unit": "UPI"
     },
--=20
2.44.0.396.g6e790dbe36-goog


