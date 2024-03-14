Return-Path: <linux-kernel+bounces-102829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED187B799
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E11F22A54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36B22068;
	Thu, 14 Mar 2024 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3Me8htA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211611BDE0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395953; cv=none; b=iibiSOpliBLqUxkXAbM2GhlEIu4eQZmdtqnAH42w4pX2U6MSJeX83knE55r/KLpiJ0SMsTIi6x9mz6fRy9SpHijjUzFUKjYtXwUWFyGxnU5o0/3oQxLT1eFwql9F9d6PQk9B3VmG1SlozLQUsghX+mnnCRULENCRK8ALGY49NkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395953; c=relaxed/simple;
	bh=Mk3XQlHLZxdVodcrzm+PODwSYBMgkZqVt9gXIE7aW2I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pCm3SDYQ6Kfokq9Hs0on4N2MikIs4Bb0GZ+8KBnyOPZ11bSGuZzFy+HuRE9S6jgcq07AC6kN62mYpKxgLSLZ/SXxw/WbkyYjOkZC1REJqj2r4251Hd8U20gjVqsV/VxirJmkL/VHVDUsrKMtbxMtccyLBhwANV9ATiHk+rcUVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3Me8htA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso10660217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395951; x=1711000751; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSBh0lB+a23+39fFaPjg8zQM/Im9uFNXguVDinAnXbc=;
        b=Q3Me8htAcgDEJEuqazatt0G3Rlq7GsKxRDIeFW0dTzEQfeqVVWA72NvbSLXFhqSXXj
         O2o+rPXJKuOaBpK9pwDk5/7k7/mc7l6YM9fL+4Ih+5KDYgwBCwQF1BB51REA2TYOkIN1
         bGYLLKYjvQO9N5CZ61AwyULuiZCKG1n8d7C9II3FrL9JN3Ub0spAXefYGrtDvIYuTYeD
         UY4mIgSzwyGO7lBP0oVnNMek3l7+M49LrhB+7BRws094d7Kx3xHKsU9Gj7gz/1BDBScE
         kYpDAeKO3oCAU1bwTtv9BPOENT5lfFJUyN7EMvl/E/jk4MXV36Nty8XiUs5D23b3lg8t
         CPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395951; x=1711000751;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSBh0lB+a23+39fFaPjg8zQM/Im9uFNXguVDinAnXbc=;
        b=XEdZagZbTNliN9nTuE8dvk+56r9dsURxiA31UNHP/AXKDyHl0o3rQJ5ti9b+HzoQnX
         l7Wc4XVfYaBZ04Dgr49CTr8voGsBL1FBY20NWBWziSpHXZVoj3HGnGpDkJATOELUQZl8
         ONLZdZUd3PS/lq1ylTw9ckHciAxI+kFoXCIqaHuM+Xrgt74M0i712YeHVD5jNeNuok7g
         DdD9gfJYu76BTqROCOF6vgp3l0Dh/vDCickODDHSv3AS0EUZL8rFc/MUOEy+rhWn5e7K
         s5O3HHw4yXct5guTmJvhF4yvRBnyaum8vXnaLgdx9JI4H558ikAQt7Y3E/T1ZfLPbQXD
         4pfg==
X-Forwarded-Encrypted: i=1; AJvYcCVsDfAdD4STyaRZNRQSOaXVsjEZn7MeNWA8scQj9ljWLD8+i1rURpRCWZs+AE8b6vZbKc+lhpzaK+I5ygwTaDjsWtG0aeLzMYZptqIX
X-Gm-Message-State: AOJu0YxTCB1S2UQ98Vl4RhtpIaqfP2ripZp36QLI8JiNfhR7Si55I/li
	8F6rJzkqT+2HE9A+fjPS4BIqyXaNrQ7G+YS08iO/XJ7pa1telCsT42F02Kg90KHikggBeNdChDN
	LZ90tDg==
X-Google-Smtp-Source: AGHT+IGz/WcD1pwUVpDjsHmi87+odVdNlep/ZH4vaPqLNRuRB0bMnFJncve4GNCavNVSJJbYCIMFntlCkmwb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a25:9285:0:b0:dc6:dfc6:4207 with SMTP id
 y5-20020a259285000000b00dc6dfc64207mr211031ybl.10.1710395950986; Wed, 13 Mar
 2024 22:59:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:39 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 12/12] perf jevents: Add context switch metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index bf5c4ffa53e9..bc70743c2f11 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -613,6 +644,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.44.0.278.ge034bb2e1d-goog


