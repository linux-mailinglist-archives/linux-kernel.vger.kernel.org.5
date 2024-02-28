Return-Path: <linux-kernel+bounces-85485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACC86B68D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D24B2754F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684D74417;
	Wed, 28 Feb 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9F7X2ms"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330515E5DE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143022; cv=none; b=Omre/PwPZghkMUT+UQpq4AAVsazF0qtvl5TQw0CYdD0rh0zeRtSHthtHCcm6MeI+98OlNx/g2uyE3Pg0iVveYQQFVS3g0RKjZzX2RqtRhD4WtxdtY7yQpAURuox/mnlBMhqgymLWEvUu5fPYt83Ywp9sLnv4dGMBGn7RJbqBJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143022; c=relaxed/simple;
	bh=YRU8U8+xDv3At1J+LdyKbbC3IhjldoIrvcOvRSvL8Lc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SUxHxuungUOsYYZM2aPQ8l34RWQ0c00EUOOiGDAmd/YWLncaXMUaN5PrIYAkc7S5wu1uyeOnQKAFxmHZ9JtyYE4w2dEEky+H+O7kt+Dimb297lQKbjkVpM+MUGv5nW6ktTOKo8bdkrqv9FlSrKyizw4hWSrxF4RjCzcIncyI5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9F7X2ms; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6094c745eb7so229337b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143020; x=1709747820; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8Zy/5k2whAdLtuhk9uJVeAHCzZsg+vx3YKGl8xR8NQ=;
        b=f9F7X2msOY1NVT21sluW2WqEQpkqjyDTXXm/JcKw71RLTJhTUwAXnaJ7EUo8g6csX8
         Z+4OQBkSfcjeCIcyF/qEfQB6eFTLtGZufxDNi3JSmGwTyPuQqX+SPmoxHm60X4AIOrjf
         mO+WkQHnA+gE/f0dqvvv2sGd/xOA2stnvdIOFiXB/QAjMLnQn3thIlFSgUHq3lNYWPpW
         J7DzGig8oWnkHGropKNWn6+k7Af0lWOP7+NW38kYF7vjv5HVbjzU4G2aUpxKev3I+EPy
         Cp9Bpp+zjVovLF430B7DqwGHRmX8I6rlJGlIkoHX7QfdYRlvP6cKSaThGFYMPkpJ8JEJ
         TCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143020; x=1709747820;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Zy/5k2whAdLtuhk9uJVeAHCzZsg+vx3YKGl8xR8NQ=;
        b=XXAGihN6D+sr/xOWcIIaTHtLnFAsEHIDC2DkKNtwU0HCcM9wRFrFYYQpXVtn3MMtPV
         717OtuHebrLn0yiwi0HnECuaE4ZuhVXfhn1rQqvok5X5Bu5UN0qD3EutceQtJo6c6eyq
         IaeB06pJuRylk3s59f85BqL5pqwIkp9GxmQlEkE7zZKL5zMUllOAF6aMXBLERQfpVGka
         zY9FG8nTeOgOHWX2rCw+txFmPsU6ydybkor9FHOqUuVO5OsE/vlOcaoPNZmvpzus1KiX
         bFhAKXYkhLN2JcbLJy5HnqRPAS56MlPTRObqIb7Ytx4vqEMvzwI3gilY6IOTLkZLxLST
         qzxg==
X-Forwarded-Encrypted: i=1; AJvYcCVzuYZ4ajW1NpsoLJJtuAtrFpqQkY6kapOoZj9MDjcVu369tqpFiZrJUpn4ASFPxCg23cW+wTUS2Ghs8E4BzVeIhUTzkfoUefl9Vskk
X-Gm-Message-State: AOJu0YyTE0rWXrLPTWjkAucHV+q71GGRF+MMljlwgtu/sKl8T7VdQ7CM
	E7PbHw2XLoPGDPn6hRgdelS8zsscyva5n30wzYcOPKdzJbRHnOSfBteTNi76mqpjjTUtg5aOLX7
	icbaZcQ==
X-Google-Smtp-Source: AGHT+IEcnVcrjIxKW/xI+Anl41wk+vCifvb4WaAzGRsYUsAhyybFt98vzONiKDo5dsLAiSQnVsJQbTzHM6eG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dbe:387d:a8ef with SMTP
 id w4-20020a056902100400b00dbe387da8efmr157ybt.1.1709143019661; Wed, 28 Feb
 2024 09:56:59 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:15 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8b37cef0256a..0326050f1e0f 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -492,13 +492,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.44.0.278.ge034bb2e1d-goog


