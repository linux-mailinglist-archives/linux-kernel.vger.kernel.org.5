Return-Path: <linux-kernel+bounces-102860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B407787B7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409191F27F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8A55798;
	Thu, 14 Mar 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2774U4L"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147D548EC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396014; cv=none; b=itQpK/ONwuZPwIJlMP7C2/5lv3LeXq6x8+cx0rqE/4XlLegdXxIxlx9bkdQ7JqiLSb+xjcHrLGIzchNDJ9vEZztQ443rLkmUj39x941rDxeeGMctrwMtK86mLvy1N4AAq7qmfue86MvWgKY3c4ZPYSqU4cMza7LHNrryQfsOwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396014; c=relaxed/simple;
	bh=slsQ486FDmV+ZxtCxqAbpTjZ7e+5jcmyOmviohPSGHw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=vGs52C+8cWYL9fnbnYwh6Besm+bwmUEJ/NnNFfMURkaCqgL89SlN6FzqaqT5LyeDZ2ctYO+ZmnQGIy/vfAAAhy3YqBy+v98jFUFwPqcPrQUKdLt4vPXip3HRtoiGTjfSZZPKHwzq9PUU2BREbgkOxgkEatXObS1qfDLM6CVPbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2774U4L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f06so10914407b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396012; x=1711000812; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiroQH+MCh0YtGdpUEh3/X3CQ0/YTeWJYjgikZKNUY4=;
        b=B2774U4L4HCRIePlS+y/OPKxfEeWLGxyQSKiA5oWPYv9k5CP6a5w0A9B3gGsMJKdet
         n/FC+RVUS+tOE7eM4bhEpzt/cBGhfo9lSSEUVAhjJxCBEwadKcwVobEsefd8zjQleGIC
         1UHVF/u1dMYSA5hqkcad/aoOQhkpNVF4VqDrNQ3dV1gQ9EhW/mwF5N7KpiBnachbWqwi
         QvDqU0V66kU4JvYR1F3ZcH/ii1qlYNB84Az6GU224O186qFOD7RituPi84mQ7NBli6We
         6E84yZo6sDu06Kowf+6aDxy32PkeJJ93QFBJR0Ko60V94ofsRtWqq2m3u/by5zhQelA8
         WPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396012; x=1711000812;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiroQH+MCh0YtGdpUEh3/X3CQ0/YTeWJYjgikZKNUY4=;
        b=vCYODemXnQuVQvnETWCIoDyhdH4kwDox9jwieZoG1nUitmG3r+PJKHP2gy5YMes8uV
         CG+alyfM/zyJ4X+fymMr2pvFpX2WkszQjIEFDlYePrBAGm/YonSdLu6E/qcuxAkwqzWI
         k55RogXT8kRsuKOZPW1mL+yAwYRsARogBJh3ZUrjgwP2hxubw+u/XDKspWVE4EO86+23
         5by1xhC2zbi1GXefirdqq3/XMYqbc3J5Z7QiYtg+nlTFX5b3n/72kbMnDD3mDV9/G6Y9
         ugrCHWuKBj/VFquwMLVi2/835ejgrarLvObV/odSTz3JCZIk9Xvuk3SrkHpF+bmHr89o
         5SFw==
X-Forwarded-Encrypted: i=1; AJvYcCWcrnHe1s/Y53TLRAjsf1EmM73jewHe5NHuAJb7kTH390ukEW7pPkHENVmle/OriCneP8BiHPdDfSxSjJ/mQCUQX1cDJUpxHCV0GlmD
X-Gm-Message-State: AOJu0YzvT2zCAuNUZhdNOf2RcFJQiMFkJRzTBMUd4Pl+TKHMkqy55dIb
	72TybtWCzBZ7F9OXOdSO9mgbP2fQ3sC4PQcDtZcmzC8IBd6FnktB5139mPPQEv+256J61pal83U
	ekEiyUg==
X-Google-Smtp-Source: AGHT+IEBOHkXOSZG2uOqq0iESlfzDouCBFleNoS96ZHpCr1eVUtAUfnBTxPymOArK82g0zZQIQu2G4azM8HM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4ed3:0:b0:60a:5d76:a875 with SMTP id
 c202-20020a814ed3000000b0060a5d76a875mr126603ywb.5.1710396012545; Wed, 13 Mar
 2024 23:00:12 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:16 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 17/20] perf jevents: Add dir breakdown metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 254a4e73d926..0e3ead0fa0b1 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+  try:
+    m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+    m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+    m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+    cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+    # Turn the umask into a ANY rather than HA filter.
+    cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+  except:
+    return None
+
+  m2m_total = m2m_hits + m2m_miss
+  upd = m2m_upd + cha_upd # in cache lines
+  upd_r = upd / interval_sec
+  look_r = m2m_total / interval_sec
+
+  scale = 64 / 1_000_000 # Cache lines to MB
+  return MetricGroup("dir", [
+      Metric("dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -900,6 +935,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog


