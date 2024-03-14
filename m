Return-Path: <linux-kernel+bounces-102799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA287B76C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA232285330
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE25D271;
	Thu, 14 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGF3dDZf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF1947B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395480; cv=none; b=MR8V7FkOykJ0bdXD7/SD4c3wJa25V3xKWfS7lDaf5eUWOacby7591ab3VEB1vmxh5zNeixJTTmqQiXIa5gLeBs+Psl848GUiiqYU/mYXUqhrUnmWJjUX3OvhzSHPrQHoRK2t8tqiJcDbXv2Sy57BKB3JSe/syfdTE2+cE7Xt144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395480; c=relaxed/simple;
	bh=v0yqG1/eVUcfK+EPjUe4XPhP/J2eaY9fzjQzfVc6/H0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=akn45jsc99QAiwCRf7AfQ5CmverI6SDWA3KDHqBRRFJCUzoA62NzD5H66g7ZrJ2Q1bPKpStSuW5/Xj/Uy6O5Z40LLw/Nifiga26Sbg500i+KkZSEcTeZs73d720nlso3xTm9K1UpeViNDg8r/At0UsyNpgIHNJ7X6prZspm2+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGF3dDZf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso645521276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395477; x=1711000277; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCqK+HuTsy25M+g/yEFD0qCgc7u53JD83szShkckrSU=;
        b=OGF3dDZf2gu95++gEz9cRV7zwm6TKcwJNKRZQUqnWplbCDTVE3q2wn8SgQhKO4jkZY
         s08GfPEJEEVOEsyGkK6tFVIJutPfGTZwldy+H510Ji683cjGbj0F60Hr9M6XZcOa3Pw3
         ah3owNM7fOvVrJAinZKT6Nxa0oHKjltFLisKWUloRhKVA/X9Yo/QKYZb7btHGZQPyLeJ
         2zOdjWDXyeYzTTg1qyOFZgb73f6OPxT9gZPLnFHoS0Q4fwAcynr3lAaSjbayd93eBr7i
         3fQNV0CR6eEBweNbmlQDP6AsEf/2dzB3bV9QOb0h044aJE6Yq7QyGQSPvVVbLIFPJyci
         9Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395477; x=1711000277;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCqK+HuTsy25M+g/yEFD0qCgc7u53JD83szShkckrSU=;
        b=GJHEWEkDjQjHdoHo4kiMmM3tFfbQFOIwM6gaNqJdUgh2gWNqrY8eKTbpfGL6l1M5FI
         qKypT7/zDIpIErSsazFfv5lsSRGYcSBtMcWFfyfyvnv01s7i/7cAeOS0r6Leo79YUTV+
         cJ0Xi2yx/r+ZEUnLZ9fGDJYtx1LXHtwiHyVFeTfWEl05qjk9oMSOQJcIaJHPM/aYz7D2
         00L9TJ0N9mk/HpJ/+8oIOpA2Qzy8ldBv3i22iBDrVcLY17yzv6LCvIxIzVORRK8AuT1U
         gi6gNCJHW1CBE++FK6iSj7ZZlxqDFFSTDpbW4NZP3yWERsxtLjrSgn9NQPT9onyGjujV
         zI4g==
X-Forwarded-Encrypted: i=1; AJvYcCVSzlMRBnp7AOg90an39vwXjLJb2W17Ahy0veMPSxNJLZ7MaQpSffXWqfaK5HS/Njx3X/wIDUMWiBXF01LGnYinZlyjJO1+bKt4e0o6
X-Gm-Message-State: AOJu0YwZWIhxHWnWSCC9DFpG41552gZZ4neK69QuKDkx1JSDAq8ve4tl
	i/tGRFpU5b8DEaCOc7D2RjLuX0PPfprNo4uxqvFSx25C8ph+dOq3ulnDEx77krvefwdH8KTuFva
	nENQ0Zw==
X-Google-Smtp-Source: AGHT+IFhxtG7mMRDTi6SM6yIa7u6l7RWObt1YAjc3sEUyr42CneABw1rvByHjjYv+EGuqN6cKrznog0AtTg2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2504:b0:dc2:3441:897f with SMTP
 id dt4-20020a056902250400b00dc23441897fmr212987ybb.6.1710395477631; Wed, 13
 Mar 2024 22:51:17 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:39 -0700
Message-Id: <20240314055051.1960527-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
v2. Fixes two type issues in the python code but no functional or
    output changes.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  17 ++-
 tools/perf/pmu-events/Build            |  60 ++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 162 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 342 insertions(+), 36 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog


