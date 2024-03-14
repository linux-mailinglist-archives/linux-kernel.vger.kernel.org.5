Return-Path: <linux-kernel+bounces-102863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258187B7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933611C206AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646158231;
	Thu, 14 Mar 2024 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4P4Qx+P"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58F57870
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396020; cv=none; b=Jw/Fh3eOhBWfiK/3nQXZtinks0dL4Jdc6Py21d7P4Ta2K6Y3kS0AL/jEopr3ZXvkucgG5rAUVGUc/5u8pn5UBOssPbgM6rgfmZnoOYEQzTIxSOSSbOaVCLw7ouix08kLdTno/vBVrD9r6S3eDt/k+ozICMF4A5j2y8xxtqCAdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396020; c=relaxed/simple;
	bh=CsX0lQnByBZDbYc0bC/+3WRwprgEBJaViufFNrdPpWk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lUKLjai6XSIJotH2szfjrZBx+eLXFxKCbts0uju6ndrudh22GpjoQY3aJjtAk2G29/2KwhPyE0gpZId8XJsYRmTFH80hUCCoR5pN2cJZ7xjypDX2txhmkzenJQIwc9M4mp2ckfjvTwY9bigzIeNxTlVfgAsXNJ8U03XY/0MxSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4P4Qx+P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a3bb05c9bso13300257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396018; x=1711000818; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWUXwe+5uPOvq9VWv9aWVcoc1LyId0S73x8LQ06sEM=;
        b=Z4P4Qx+PheNK5oyDBjNw1WMXug4nbu4Z35fx6OalyzXjPSV907aMCNn8hNIHtC7LTO
         kPeRDFj4BX6njGC1pUCc70TW10aJVcKcq6B3yssnZy0mSp/PLbLedhRymeYCw3vXeSRl
         x1RpD1b57vlZpmZITp+EFsEYqXgA4QpzpgVwFucfQNdSXV41rgPB8vQ15QoFsfygQ4VA
         +bTI2Y/zNcvMbh3wZ9eKqI949J1goJzWrPwBYKWzLJHl4KRKp0nXgKAGI4Cb2DDmkemz
         KvXcontuw0m0yz+AO5iUkfTdS+LTHs/nxMNOW8V5qvNcEvQVM7Q9chBmVfCPISOu5woo
         oOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396018; x=1711000818;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWUXwe+5uPOvq9VWv9aWVcoc1LyId0S73x8LQ06sEM=;
        b=tOPhAhLbF9YXE888+TFL8JPIEnmAZa1eEMDqaFtjMETciAo2js2faTsnn0lZEOkMyN
         hc9cMUV2Psbv9PktxUU8OgLWRd4T+Gi5pQiU6w+7RE0lHhjRbaiAQmYrdpF/VWSCznKY
         G8Bi5f8OrCZiIq06Tguiref+lF2hM5axE91uKOob0odORG0BIx/2DdWi8naj9bcUgV70
         Oa2zpI7n3cYLdHR3Pl5iDXW0yrkTevv/GgNlp3WFB4C09K0hgpaCXnaSYEtnD8fAbReK
         jTZ6ljY7uW5H8Qe/AoLUt8DJ2RIMa8lmVf6ebEh0FZliGR0I89Lh6YHsV7lEEPmEnFeA
         uo6w==
X-Forwarded-Encrypted: i=1; AJvYcCW8Q5jb0TSJpxlxv7v9Kdyd2hykt5FhAwcyKPpq8JPIwtM2bk4b0lCBa+YekmWgwZZpuLsXd+5bPpgKM2vUuW1TRguTYLllypmPuNeu
X-Gm-Message-State: AOJu0YziYG1niU5H1SO+9MLmZGHvNvIwAl2AJcbAgzONr5OnoVLLt6xq
	moSbwbLOEF2lk1ifyQssJ5C+05fgyAaKzWUf26knW80UYsc5wFZGs0h7OKYrD2suiG917KPQIwm
	NDj+cEw==
X-Google-Smtp-Source: AGHT+IGkvCXkHOuijNMrlG8qdOyE9AHiz1Lw63N3mHdp2yGpOkH9A4N3QKasquBeDRnefnUvLLTmQLydVhes
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4886:0:b0:60a:66b9:c089 with SMTP id
 v128-20020a814886000000b0060a66b9c089mr150033ywa.8.1710396018654; Wed, 13 Mar
 2024 23:00:18 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:19 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 20/20] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 95b4dd3c175d..778517968b4e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -983,6 +983,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1024,6 +1045,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


