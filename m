Return-Path: <linux-kernel+bounces-89279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DD86EDB6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625221F23F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4812B83;
	Sat,  2 Mar 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sao89wZT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F811724
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341212; cv=none; b=devDlZst1qgJMPPzFobwCagf7o+uG9DbwZchkWt7/oi61+WHfAO3tQ1bKV0cZUSZ2pSmgcJ3PG52HlPmYoD+u37PQUxNz/LCidpa9dpom60C4iJ4LN2aWmm4A0xemutRQzj97IFEXz+VqpeDGuAePKIBanAqQuwPEYQyCi9VDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341212; c=relaxed/simple;
	bh=j1Uteud1mWr9qwRDjsafkmahAN/I9mDRvh5Ckh8gIQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QJ5xowguVym3KsardYe4oLkYkHxo5jPnouqQRFcQlhft94rsIFLjcpfeV3yoNWk6Nr/PKmVjIMdgHUltDlFktvfGBzPAi7t92Dw/fmVFCCHSKbbGxKlz27IMUKGo3WRHjLQxX+zRoJujD9ujHu6lqyBMD2zTDCCHNp2Wcg6tFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sao89wZT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so48532217b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341210; x=1709946010; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=sao89wZTY/KDVvh69F/w/NIM2DGgIH5hpEanldAlBkfnbUUwcaODWWGmvCAK+oe9oq
         tqu5ByTR/EGnpwH90MmYHFLKQpYDRwhLDIzOUJXHBQ/4NeCdmO6+9WzhmXY7yHKU0Sh9
         o0Qoh7Q7BL+UjYc4+8SNjBRJuagJ+Fk8GEtQk0uokganZTvatbrrwFvP5F+JbIfKkhl3
         EI5rPaxnpG7zvW7XfCVu8sLfe0hLjhKVcLU6ps7/W9cdqpeFZLHgR0pkTK/iWYGd2/Lx
         jobjo9K47qaeD8sVmhHBr7/AwailPdR3pwWA3iavnk8xk0ByoBaD/8IZel0It8809U4+
         QJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341210; x=1709946010;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=VrIWwZ5ysfTuWj+CJcdc6Yqce4A5qP7KAi1O00Qvau3ejB/YYu5zU3KJBjimeaJ3zK
         WWqyIJaDr7zXsjVbfrOooyT2hz+PKF7OJ7HLzyJHmIU8QOQVQA1TEBVtg6V1aJ3qdyiS
         H/FGp88MsT+UGGSpeoPpb9cjICrTuo1c0X7b7sbAssliOT2/eSMAW4LJQVZv7jXwonyT
         hYyCWnytT/UF0KcPdWMWmWxBPzDWCf8byYYUUBO+6SNCRI5ic6e+W9+I/h2TeVNulj0x
         alCvEbCpN3G+h5e1q13u4Jn8HB0cikmLqhS+tQrNClDKMkRobtBC+CVQSzHkJqODQi4K
         sRNw==
X-Forwarded-Encrypted: i=1; AJvYcCUzfRF4EEaOTCHtXFBWZmAz+SYRw4f0SJduESd5PgYfNmEvfeROprH3e38JP6tgEB+8Lds0uWlqRVaGUNKh+QFbrZECeGO2sD1m6/eP
X-Gm-Message-State: AOJu0YwQhpb8VwUXgiG6wxvOZ1w65ngFhDB20SVUeWwbCHwZHxDC7Mc0
	lTyFxibLunMHhZLw/euLU6qfWYR0W7u4ePnyDaSxl2eGxp40fXuwPVA4wXIrQ6lRrO3h/VpLys9
	aigelAg==
X-Google-Smtp-Source: AGHT+IGo9ikATikHZ84fMbX5tniwY5SQp1oK/Dis/YYeok7/lK6jKFF77bld3uJMRdNW83gei2dwCmWVYsID
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a25:dbc9:0:b0:dc6:dfc6:4207 with SMTP id
 g192-20020a25dbc9000000b00dc6dfc64207mr714766ybf.10.1709341209852; Fri, 01
 Mar 2024 17:00:09 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:43 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 05/12] perf jevents: Support parsing negative exponents
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


