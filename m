Return-Path: <linux-kernel+bounces-85480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C8386B687
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C934B26FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A44084E;
	Wed, 28 Feb 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k6CA1bp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65581649CF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143010; cv=none; b=Ag6qDPEzyqAIBml/7H2c7WvnZ5OuNY5NUCP2xwFtNTzRktcl9apijgLA2OI3Ad8KiVuVTUVRAkScac6atRffqJcJ34o/oh5JuMmHVOz2Nook48+PZX/mRRxLraAQWojSOnxsIAk+C2t2iz3F1bo334NiAB47dz/OcZH2mpOvXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143010; c=relaxed/simple;
	bh=j1Uteud1mWr9qwRDjsafkmahAN/I9mDRvh5Ckh8gIQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GOz5lb7tpic774pLlG4r8egCcM6rkBTBpGIGs9C1iPt477mJXEpjmiN3I8sdOXkBe8+35GSGw5p0VrMQ9bphYV8PS9MAogrCZjfVEq9HVuzicOI329qpUwt4x3/Fd1l61E/x0qBRULAp199+HoU54E6UVAFPuE4EfsNop1tFWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k6CA1bp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso82098276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143008; x=1709747808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=3k6CA1bpfOmxIZqZ6XVv7CzRmNKcgV9+xxZd4QbyRuFL9qbfZA7fBUXbWRxg58O75y
         Y0zcONqYc1lMfvmjKr0M838/ae0DDkiJXZ0VpJcYnikcsxGsvXymJz4xk+3c5+BVYwHf
         Hy/Y+PufKcI6gpn8jER++lq/YzUFT+XPz1eeDIrCTr2oKPCd/tnDhVFXQRYkyJLlPI7s
         yAJcfjOwQY2qFKtNrzQS69UOHLLmxKAgT/jGjGBkGsRhXVmfTn2Y3wmw0CaB2QRqkU/C
         JmFJ0FK2BGk93+m5PZqQ6bI634ToCmTVZgr/HmSfFwqFSJitJeU3zcf7DqMTt/ZM1KM+
         Tacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143008; x=1709747808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=Wo95nGnJDYvdi/guBoqEBKgLGcyzfgVUUjAQGvs2Za2yziSj0rqwSc//WBBPmWQTOa
         EnKMaODGkMUDDtc4FFpvknBkFL++WQVHZn5SsbVlpU86GPq9cgywta25W5fJnsWbma1z
         VAYG9R7HYHMyiXB6RBbYwGRBR7HAbCYfvGapXwgoxQKHYVYUPRGf8CKGdUrjFSdFqqfV
         PfC/iby8GluB7oCTRapOrnmxXz8jCSWsB8yKLQpl0li5AgEpFaQ7T02cX+bH1DY+SqcM
         1qwSMfMtGgiZL0x1XqpfU2KnQu/wRZBbq3I0XdbsWyS9qtdWvMxb2Aq62QfC3nRRMMKa
         8eqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHmWlRuOJUg+2ZXNzkPnsy8JAzqUdN3voW1B3bL2X3EddMp6yMuCmq9J0BVFKOxxrNx7fVDp1cZzCX/pv7z7/77jzl7w6spbvABmY3
X-Gm-Message-State: AOJu0Yyw/VPcgwBVPh/38fq9oqe7Bv7jzc03CXxgJLWP9SZcFcw6lOp3
	2rLOZQFn3mOfQ3+HDV+S3PTV+cD6YxlTSdic7CifnkUjcM4/p9ixmCuXwt/+B1zDpVfqJ/hJo0Z
	Jh6OhOQ==
X-Google-Smtp-Source: AGHT+IEf5pbaOTj+BAf1Szc3Oud3EmH2Oy7RUtwaeh5m1O0lJB/DpXaEfNw54//biDSGEwGhu6rWyJH8EWlx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:dc7:9218:df47 with SMTP
 id p2-20020a056902114200b00dc79218df47mr2908ybu.5.1709143007864; Wed, 28 Feb
 2024 09:56:47 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:10 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 05/12] perf jevents: Support parsing negative exponents
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

Support negative exponents when parsing from a json metric string by
making the numbers after the 'e' optional in the 'Event' insertion fix
up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 2 +-
 tools/perf/pmu-events/metric_test.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 847b614d40d5..31eea2f45152 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # a double by the Bison parser
   py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
   # Convert accidentally converted scientific notation constants back
-  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
   keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ee22ff43ddd7..8acfe4652b55 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = before
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before = r'a + 3e-12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_IfElseTests(self):
     # if-else needs rewriting to Select and back.
     before = r'Event1 if #smt_on else Event2'
-- 
2.44.0.278.ge034bb2e1d-goog


