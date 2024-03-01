Return-Path: <linux-kernel+bounces-88978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1DB86E8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80929283804
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE269D1D;
	Fri,  1 Mar 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cgsmqq4d"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541D4CB58
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319418; cv=none; b=cAzHa5pUXo8DH+Tu74W9ucr1+u/3j27LmvonRye9GAYNeJfRZKb1W0pnbVJRsLf3vybtMbFZnG5x5Uu/hc2JB55kFxvPZwF8Ij8lFb/xD1ZFp7apMeF1zWOcxE0jOHmAZz07E3XE3DLWOVPe+Mg13jYTiv/RFr3PDvY4ZxkiATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319418; c=relaxed/simple;
	bh=C2x1ZFv37V+E2DKqeXmWKBtEiLApxmFaf2acyhRA6xw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Bzgh92T+1lqdUhUz/aaUO7v82ZzHBmKkrKECyLaiCmSCSS5ImPBM+0ufmnbEbXICm3mPa4NqHgUzFy7kqmsoOQCRhZRP9r2otOS3wvl6ciWSvWJ+XlXkZFsocGzbgQZJLwc9z383GirjR6VU5wM3zA50768NXiv/JuidlI/mxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cgsmqq4d; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso42114927b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319416; x=1709924216; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qx4Ri3vgVtjrNh4FbnpR3dQWcRAmzh3jMNXhRug+BKo=;
        b=Cgsmqq4dknhkpZLdgRQQTr5xUXskaWHN18er35GBX7mHrGEoHPy8HOkN52uoWYVswi
         9YgpFkapobdp5E4ysmyYniayKDaFBRrZD8B9SnZH0I8PmC60vNF7/GyOfdmptC6bo/2D
         74kmnotMIxNiZh0J0wtoIjAvRE4ZMiRgc/fRYJlh2SHODalmN/XZ5enQSRQUJEgd79rR
         sIjo5dvX/q1y+rC2t7ohwot0Du5LTlFkrEB1uj4q7BxlTGR1Erh2u8qzbLAMZrlEdBtv
         5kpEIc4jNI+OH7seHPbhmG4WCfZC4IqTXRMLswz/UGwsN5nvTRtwwSTBqjh4XO1WewJ8
         Dr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319416; x=1709924216;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qx4Ri3vgVtjrNh4FbnpR3dQWcRAmzh3jMNXhRug+BKo=;
        b=Cer6lSNnp731sgOrdj6Hg2V0dpBGCNav8CFOxQqm6hWx5OTFdFmzcZxLuyxOJVPusr
         p3R0eDhKRJgftPuGB0dSwNZBengl50WW0PDL/fVl/Bhcqv8Xaixw1KpzEJht+4z+c5cS
         h1O+kN4QhUaQatjg8O6dY6CisiO5je+mAcmUs1HViszTO/ww5SnH6T2nClrdSu7Woxkj
         BUef8ACyVl2BLKZnZRVdjYGS8mWtW7P+3C/kE2kmInwnmI8Bx3RnZgiwyyEq4BQ9eb53
         qFIeeiL4fdXxvM3pt4CVegkw+K8LR9vFRd4hPUOaoAd636Qm+vigDil3cQMFQsDw+oTy
         yqbw==
X-Forwarded-Encrypted: i=1; AJvYcCXzPrZv5UUqCK0Kwj5uug7u95o3Jt0yLgfknM4vrXa8HJa5Lr9sFFfs/h0Avh2nag+o8uON7AuiUG/I0sB48vNRivZmHx6tVkSCBWLg
X-Gm-Message-State: AOJu0Yyv8AwzG+wB/1MVmzjFoNH/QpEnb1zVwEae47cc6donaC2Jmprf
	E4GXEjP1b8H77VWTEdcKSYJWdLlOAzyJ1lBpQNN8aXdjyQALrmCygjG1XwjJIRAR4K0KPN8b1Tl
	20EY1/A==
X-Google-Smtp-Source: AGHT+IFuYYaNOfIUtqEh9c+trnUnE8Fk5bO2e8KimGgCTfh07FJ6EbMKq7PfHptG7wenEAj3+7NMAsv9sWMy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc3:b0:608:ced0:eb2e with SMTP id
 dg3-20020a05690c0fc300b00608ced0eb2emr477450ywb.0.1709319415826; Fri, 01 Mar
 2024 10:56:55 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:56 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 17/20] perf jevents: Add dir breakdown metrics for Intel
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
index 76e71f11a579..8086aef3557a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -885,6 +920,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


