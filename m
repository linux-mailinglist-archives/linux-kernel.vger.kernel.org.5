Return-Path: <linux-kernel+bounces-88981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A186E8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A24289C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19586FB80;
	Fri,  1 Mar 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0jujN/A"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A343B293
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319426; cv=none; b=hbxESSp9dtWwkDPQP/yx9mCSIJTChw1kPeiaGPsR/ZDSFi35CQGZF8qHWRflDldkggKb28xGg04esj+dK208kd/IQQmYXofVgfdpIQfbYml+Z5RwIIOKbkgcjNvJDN6ZsqRx5neyJyBXChYkuXUs8aLq6I5XLFVlF0L+mBsf/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319426; c=relaxed/simple;
	bh=0GwxMF9zq0iQE2g/LR7Nppd8iDmEHy9zf2CgiW+kRNg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GTdFKKT+cTmDSh6dTOmGdUmWObMIO9Xzxzdlfwap3IgyAYMRumjiKLKONC4/CCoXzrXmTuCuNYRhgxRyXgoe0w/S1VmWWPmem3C6P/KJsefGbLAUfMHoDDCBFH4hp/4CKQwvz6x56MRm+j7lWPWPJ2xPWlHpZnKyko9chmJgc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0jujN/A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60832a48684so34393067b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319423; x=1709924223; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fo96hrchgf3LWlHf7KBd8+uynqShNfYHYZPYMJSMK2s=;
        b=T0jujN/AZQjr3lOqDNc7kcB7fE8SKc3QUXTo2yQmFyshdEcJ8k7wE+qyanMnVDN/Ar
         WN+070FwOMK4N5wAGTT2u9TkdR65G+UCXtulSqqtSdkyfJce+fL0hLtprbJzhJuPPdu+
         WcnjUgGq1j7k9oisfn3/YFaRMnSYaoVvh/RerFNIJbcZz+Ra763j/A4suKR90P93JfG3
         aGvi/B2i+fxr4N5+Hx/Pbij4ncOCd4KJ6eXjIwzc83PRz39SwCjhFXgkbVVLPAF7/O2w
         LJ1XbaUEiWhpOMzE6EUf0HxvP51ih0lef7scS5z7S9IpCA7h4S0dws/G2OZ30rhIBJye
         LtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319423; x=1709924223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo96hrchgf3LWlHf7KBd8+uynqShNfYHYZPYMJSMK2s=;
        b=Dj0u7JYwAtC8I/fga/lboNyior4ZkPphaCV3si5u0MW+I/ZPLcbRcrh0f+uUie/XqQ
         thcL1HikDKd7UfebG1h7gPVC3A32VKwtUnIh9u+Mq0IluDb5qEP6R/jL+YrzpIoJogxD
         VUQUrVl6wTixzjn6is0nUljvI4w5U9H4S77sEPAMoxIWD91t6Dkb7mYOhjoAX4ZQ3KNF
         jI6lPhPZuYUbaJ1rNbSPFiI+aMqYHKwjJ+R35hQDDtjoHVaDk/dB3+aGdyNzj19Vs3J3
         RQ3eIpkyHbIWxsh+jY/NjjNq4cOaO20IdJ5f29EAsOKQFjtNH506xzm6sBvMeJIbkABV
         noKw==
X-Forwarded-Encrypted: i=1; AJvYcCXYaI1CVoHMnk3xF4HFyRLYsxuSPeCyuBXhboHjJz8quO334PO8gRMVGN5hi+D4SVsiEgdTKCVKqGjArGCPRfFqpEIfOp29Dx2lB3CD
X-Gm-Message-State: AOJu0YzV02Qx7LvRUb4w1cwt95zrHXkXSMAsJJI9W87yz4ieKOR5s/vU
	zRFHfcRfhV9vNrxLE2MZsPN5jmmsLBIuCKLcWjFUbpV55K4pIV8fc+zjDb21X8K9S0Nzdm62fhp
	qyw/nug==
X-Google-Smtp-Source: AGHT+IGEtw0NhNZNNzxM5AZXFUR7beHFvrjDXANVJCH5+8swKWQ+Zf2DeohiorrOBaHw/YadX2Dc6WCBMK9N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr473516ywg.4.1709319422982; Fri, 01 Mar
 2024 10:57:02 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:59 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 20/20] perf jevents: Add upi_bw metric for Intel
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
index fec8dc23f475..859447d558ff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -990,6 +990,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
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
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
@@ -1009,6 +1030,7 @@ all_metrics = MetricGroup("", [
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
+    UncoreUpiBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


