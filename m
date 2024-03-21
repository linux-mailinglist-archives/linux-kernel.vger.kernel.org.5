Return-Path: <linux-kernel+bounces-109669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE5881C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50342B216B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A143BB4F;
	Thu, 21 Mar 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FypICoXB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163653BB4B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000831; cv=none; b=qaSJw1DP1a4I5Vxy7NVsb1rtk3Oqn2+cdh8XH3sL0llTNiRxPH6bNXR81aZhzMB3BFWSNi68emi1Lci1zBoVXlR3FNqbNuaCABHrqqim3yedVvYxUZl8OP5b+QpvTydTD5H8glhUfsD1nxNmArhAmIg688yk0cw1n0/dRivIHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000831; c=relaxed/simple;
	bh=7v7oM1u8n9kiYcKuadH+RXqjxbPXBFURl7x7QNk2ers=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AC+opW30jP1kx4KFJY+zO/5T0Wt10DharnvCmt5njpy9885xETDD3OYJfz2hKRKPPkfcNNLZURpfTcRCc8ZZo0yNXhlVaATjHaMbVijP17IchMVpm5dyOjCuM+oYHoqVrMrWXFQm+ZmlwCXZVBGStGIYTVdQejhSLuBHXANltF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FypICoXB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0a5bf550so11269897b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000828; x=1711605628; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cityPEAhdBeJyEBY3gWU3SApOu/VSk8KmD4cos9FRgI=;
        b=FypICoXBghH/pYM/TWIfQEQ73xUM2cAPuzTrFPbq1KMuhXwLy9/W4k0TSWF9KRZpro
         dwHdgmGWmdPfUGGD7VSoPzsmSp65fIyxczR7flZiks7JFy0McEE4rR0DrrC/QPEHh649
         H1iwo4HD0I9F3UMYg3I/cgu0qZXUbKSTHl4I7CIdX1+w/6WhQ90HazP3tFMi7rv9dO2C
         8yEdfCnx1+crw6yGI5eZBqzlA77sStk2uAkR6WXIeJXIUne3cZRBer7Pv2BrBe36trHC
         KTCeYfZCDSmdRFGzne0FrRNMEOXcDY9Y+eegk1Rs9kfqzrVMlN1v5n+KnNMx0dk7/W98
         wPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000828; x=1711605628;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cityPEAhdBeJyEBY3gWU3SApOu/VSk8KmD4cos9FRgI=;
        b=Dtx5+QcFMLRSk/GenzpM7IPBGhFnD/P0/fb2kPnPuv/QIgXjUzgudLVR1okPhFRxuc
         Dji+tatOr8triygwq/sZ9KQXmT/2B/TdyrgZ9+YApOy0G1EJyl9w6700nEG0mKhvHnNs
         yAlTAsW9xHMV7ZiKFwZFZ4BCXPRwwnmgcGS5xyaxBMq2EeeIc55yjV+Pxk8D4//FSpSu
         qO0UQW1x2xY1j2YAhbo1IefH7j+WaZCuzz3jG6cawKw3XDXETZzwrp5oh8aWtleIIqHS
         5BOrZWSuORVd3FmQUAX/awn/9e2ephY8ifN5PYrucYbWoII7TBd5Zad7K1RSiVpg/pWR
         ysnw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQEfmoygqnWsUkDxL9j3xjEs6C4zclC8LXFHIloGQ+Yad4MBNBLKClZgOkaXjqEnNmakv0ZsTW8DTLx55vt4G1L4A77ek+8QNgRp7
X-Gm-Message-State: AOJu0Yx0LbSC/mWbmXdBA7rRtbSabrHXzeAI8VWhP94MWN0UYkQ5MYr0
	xGzphtkuqdqond6Tc4SX8+QFjsYw75ovIE8ukHY4iIP05PctF/TD6Zm5slx5Fr9L0dy4FY4YQBO
	0UEa8QQ==
X-Google-Smtp-Source: AGHT+IHx/MeMz6HZijbBDgupEUp1TZNow5Mf+V/mRGUUxF+8K8Va4d5fs/u2Df7tYh1/xZvu3wYjF30Z3DT8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a0d:ea52:0:b0:610:e44b:acc1 with SMTP id
 t79-20020a0dea52000000b00610e44bacc1mr1676921ywe.3.1711000828211; Wed, 20 Mar
 2024 23:00:28 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:06 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 02/12] perf vendor events intel: Update emeraldrapids to 1.06
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

Update events from 1.03 to 1.96 as released in:
https://github.com/intel/perfmon/commit/21a8be3ea7918749141db4036fb65a2343c=
d865d

Fixes spelling and descriptions. Adds cache miss latency events
UNC_CHA_TOR_(INSERTS|OCCUPANCY).IO_(PCIRDCUR|ITOM|ITOMCACHENEAR)_(LOCAL|REM=
OTE).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/frontend.json      |   2 +-
 .../arch/x86/emeraldrapids/memory.json        |   1 +
 .../arch/x86/emeraldrapids/pipeline.json      |   3 +
 .../arch/x86/emeraldrapids/uncore-cache.json  | 112 +++++++++++++++++-
 .../emeraldrapids/uncore-interconnect.json    |  26 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 6 files changed, 129 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
index 9e53da55d0c1..93d99318a623 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/emeraldrapids/memory.json
index e8bf7c9c44e1..5420f529f491 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
@@ -264,6 +264,7 @@
         "BriefDescription": "Number of times an RTM execution aborted.",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
+        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 1f8200fb8964..e2086bedeca8 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -428,6 +428,7 @@
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -435,6 +436,7 @@
         "BriefDescription": "Retired NOP instructions.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
+        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -451,6 +453,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index 86a8f3b7fe1d..141dab46682e 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -4197,6 +4197,42 @@
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
@@ -4207,7 +4243,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; ItoM misses from local IO",
+        "BriefDescription": "TOR Inserts : ItoM, indicating a full cacheli=
ne write request, from IO Devices that missed the LLC",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
@@ -4225,7 +4261,7 @@
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
@@ -4251,6 +4287,24 @@
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
@@ -5713,6 +5767,42 @@
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
@@ -5722,6 +5812,24 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.=
json
index 65d088556bae..22bb490e9666 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 281419d2edeb..85b89b1098cf 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.21,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
-GenuineIntel-6-CF,v1.03,emeraldrapids,core
+GenuineIntel-6-CF,v1.06,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.01,grandridge,core
--=20
2.44.0.396.g6e790dbe36-goog


