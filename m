Return-Path: <linux-kernel+bounces-89282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D613986EDB9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4F92848F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6E21755F;
	Sat,  2 Mar 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n32Z0gpv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EC1642B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341219; cv=none; b=MjOcb3NpPqjizzC2Iy18jYHcdd0GDl5jq8/BkXHz6gp5F0dFyl/IXLlv7r+z0y6CzLlWR678GgeHhbgxir0+4h1hYT72T9wBRbeKNh/4K1H8Ssk2XId+nJXVgIDOLA/hSrNBOjkcVkHeispOXLZcgXb3eXS9awQxIHfBbXHId/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341219; c=relaxed/simple;
	bh=KBRLOPIttIVmUTXmYYpZ5y5zAjJINB3dv9EpY8rLPGk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YASz+6JoF3GJArkfzzgTqfpDlGWMDlc9jtqQIFfcI/22KR2Nl3erBXG4Ku/x3kG8x+USJiPR4Ngqb28cBv7uExRUY2CwqBhbNgKG/t55FTXsindbvXtlX3N3JPZfjTy3GLbJsk+Mww/zf509Ing0lecV/K2UR5q31NYWCvOPc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n32Z0gpv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6097409275bso35137997b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341217; x=1709946017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEuSAf1lkMchEU55uC9f020RZIQvzTohuVPV0uKWKVI=;
        b=n32Z0gpvPPT2RMv9UttL3rcM6xcZ96lOJy5YZuWKSQHy7QhaQHqkjw3ne6BbBrYStd
         YtJ8sC42cq8Pe7TCQnnTFbSOrM4o0z8/LRE/nU1Cdg6jLH8QeUpyAqOXfP9+UDVlHrGC
         E+wjLAnJqE/sbWvlFa9u+tKguGkeVwWhQYqnQqSKDGWcv35Z/B5HcaWyRo6Jyzu1sJUK
         P2Adce1O3+MnJqH2dBvDF/WgzC69bnG9plbqwcMz5r0AcTMIuPxK+SuU+qdAdq24hlKV
         ELsBjUvlJbBD7IRh7YSs2GKXM3Kp8+TBZ4/zJ9kCdDSwvaD/GoOWzNVgRl6sWnSrRDJ5
         tMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341217; x=1709946017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEuSAf1lkMchEU55uC9f020RZIQvzTohuVPV0uKWKVI=;
        b=pOWklZWyQRX8BX5t4D7TQsCCDDV82MS0MJmP71GQGkrVMIOEdygyr+UqWnSZROf2u+
         Vcdj0NHiA5q0NncyiFycPaRENin7mLiBvawWm/hhKroBgH0iZAmiEttHdtVxXIanogIs
         2PvmWAsMWL4HSGzrJ31lyhl8X2TWVBvkAnLjB62htxuEyXRFHg+CYRprcoshkdKwIqFv
         CrHNF82hpD/dZs2EMaSv33oiuipvEXsGUtjZcV04IMyboDafCkrwXuOe8r8Uz5EOJ/RH
         x/MyEictPyIOl/NDdJHRR7r4uW1ywB8LJcxCwqhin0JhYN+Hq+B1Wo/eNiu3AsIJJYDO
         CSOg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgqbtZ9F5R9tFxXlqqRxIVY0IjXezj3980M4B3C+cvkcpfALZbgAwMfzNCcoodLFw0h3zk41y3ixHS/pighXvv6MmeqykOn8ES6fG
X-Gm-Message-State: AOJu0YxeLd0x/j66hopsqaSIUk+7BTRgIRd1gTVfSbO5b8eEXXVcblld
	9m4jz9fudjMqUTkElKEyv/hiUcQvm7OsAP6WckPkafBDUQrwIF8l2cCTIdGNzm5aIqQsuCiTaKv
	R1bze0w==
X-Google-Smtp-Source: AGHT+IHYuE3DQtwPQjpAUWpr88qJiKyzDrWMdwrTbMErl++YEQ5KILyXH/a7S9NXFk40ZIdNoTjeKHHILR64
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc3:b0:608:ced0:eb2e with SMTP id
 dg3-20020a05690c0fc300b00608ced0eb2emr638850ywb.0.1709341217224; Fri, 01 Mar
 2024 17:00:17 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:46 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 08/12] perf jevents: Move json encoding to its own functions
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

Have dedicate encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.44.0.278.ge034bb2e1d-goog


