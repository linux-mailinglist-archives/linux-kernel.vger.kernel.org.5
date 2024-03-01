Return-Path: <linux-kernel+bounces-88963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194E86E8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B9F1F21F74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC83C070;
	Fri,  1 Mar 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtFccn+7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2E3BB41
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319387; cv=none; b=Zm4oYMSqp85Wcm4NiMEPmdBa7pl9P5r02kmDWndgIA4jUXBKp4pFObF6ZlQitJG2O7fasasNGwi7qHMR3M/qiGgLLHTBWzgEi9WX51HhTXGzt21lVcuM+Btz1Kvw3Oaa6EhKqa1QAYtr66xlijGq/Myn9gAhhAS49Y894JzId4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319387; c=relaxed/simple;
	bh=SYzzekKsm56SYljV7D2+Kgk899aiMFZ1uqVugeWMohc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tBF5MxUWieyzbtlHGeKKBLrzydKwAxHSwVGeQVN25HscvXGvDp8EjaCFOsAl4s1QL6mosH2HAc/o9dIqk8knUfxdjkAgWCllVOMpRVXXDj8JlrMbhp7TFb6lGcHRXEtUHjstWqGQOLmoB37GWoG+Ll+dyFqOD782EH899ZuqWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtFccn+7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60971264c48so31095957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319385; x=1709924185; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/hkLOGxFb+NGL6rpwIzI3DU/bCodQ7sPVZDGihfs7c=;
        b=JtFccn+7YxCk4qNDXYazHzLXmlV3Z3oh7BOuZZKHn7etAW3CVaXJg1tCGt0cHcJ7cA
         etYUUdHBtQcUNC8AusKqdipp/GU4vDiGBdIgRpkSSWRZLjng/jpg1MTWDx2lXStUxSyE
         PbPD9UD1+N0c3Eb2h5/EED5HQUoBTsfGpgW7HoWB5P4E19rBG/kdFWhVTrh38oK3tYWU
         7yqfFpJTqNnmW8bubi0IF1O8dg7rIH9UiqB6Vs0gqUdVuADFMZFrwfQXtpg57rj4clYv
         f2kxrH8SEC4a6dGOPqzERuOpgy744CkHOUJE92EQsE8lO45GcjH7fUue0uFzlpJiiB4T
         tzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319385; x=1709924185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/hkLOGxFb+NGL6rpwIzI3DU/bCodQ7sPVZDGihfs7c=;
        b=AVwZ7SINsuF1JX/lprL7ZNsQBdzw9upCX7NhKiXmteYB2TigGJnya1GdzMNttOn5SO
         P0JLoyPEDzNJK9guPigBS6EweVae+lNG0RUKujoaEziVPIK8rYUWPmY3uqq10/YjQ4v+
         sDg5z4RoIdAsYEEeBsNWPTP+2OLZ4tEQGDfKR62hP/DAMX241UzrlQ37shOIYcrBEGg6
         z6o64k2fYzvda8NiTWAlbBIZqjYxI0lZKlSsaoDHP34+9Hszxls83gArSwOBhWK2s7Sf
         Kx9JxJo03kuw8NFQb/59sg7xow3jaVxDnbk/2m8gPPh16SaO5O1YQstaRtDdoTlxAN7o
         stGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEa9crTbHtCJQw/Za7Y/dUzpPJxXfslon6PI5qZLg1Ihs+qP0Ib5ZPx1HdmkBNWgwWkJtZaxL9m/JhdqT1wcKFBUNd/yQx2WYzdpFw
X-Gm-Message-State: AOJu0Ywh9fcZHYgZJffOdts4yfKBjV6cMglZB2GJx3zGC87Tk/PkniMo
	rWYG6w7e4EtdrmkeOT9H3pJUHlTAJ21dzOa3XBDi0WmcN8I2UGOaBbqzWyW3Jc0cbIPLh9NevfE
	Lry4ofw==
X-Google-Smtp-Source: AGHT+IGXrMDUUSzU6gg4XPlADHX21Or8/UHujHN85RnAMUy671BE6MjzRQ6oTcUcCleDiGdhvAPRQGvVHMLh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr100391ybb.10.1709319385391; Fri, 01
 Mar 2024 10:56:25 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:44 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 05/20] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
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

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 7d445e47ae09..0b84506cf2f7 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -8,10 +8,12 @@ import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_pmus = set()
 all_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_pmus
   global all_events
   all_events = {
       "context\-switches",
@@ -24,12 +26,17 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       for x in json.load(open(f"{directory}/{filename}")):
+        if "Unit" in x:
+          all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.44.0.278.ge034bb2e1d-goog


