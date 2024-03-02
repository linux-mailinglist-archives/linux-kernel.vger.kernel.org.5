Return-Path: <linux-kernel+bounces-89275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D2B86EDB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7981F23D13
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEC5660;
	Sat,  2 Mar 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+k4w4qd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB8DDB0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341202; cv=none; b=ZKzhb9RDBoerVPP3LVfHseiVhkpWCdHgQNyEBtvk2r8XkEubVZZfcak6RgikWE6J7t64KpffltkWgAfZElvpliErGkyrDuQwt+KldgDhj7Dc6s0SKm+t+xXu7QYr8XcZkoZW/0X8fl+FRs1/SM5uwuxdrHn1wD3cwnGBl1iBFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341202; c=relaxed/simple;
	bh=Q8r8JCAtkGCJmmXhKhiAJOofwbQwry+nv4WJ1Szla+w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dMF8cbRcK0eSrU2WONffOniBfUV+hRUI++iOAzpypo98M7YIDz8oPvUQLG6Zfz63Fog/x+1tFyubQKW1AvWmweK07uvwznC/7IXpCSbxN8QHbGJgeXID1B+Fy5lQiZZOIWz8f2RavTnw0XsCrezWxGMj1g++G8/Sn1kLnMiXB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+k4w4qd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dcaff13db5so26478575ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341200; x=1709946000; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=D+k4w4qdK0KSO0PU3Qk5EpR+BUWjjWv9Mp//dUGjJaHhPwGc0wgLKoreWgWeXIicBu
         3MrEVzhmztJ9sy6Y+IxVsyZ3psvuWbZaEtlnBplOLC1fk0zEDT0XXOfOUfvcapNSvTyG
         bV2MSLnNWTWZEcTsv2Pz2+GxaG1bW64w0UtPufc4LoIWOMUJLhKtUFWVwwI6Qd90Fvy6
         TEghm/bIgRq8byQtxtlPwW1hpCs9FWC7uh3K2dMV528Zf3kUyqd9dD7FVSgEE/ZzcM6V
         ZiZCfzHq60PClDcodmT4JM6QMYwiniFxtI7+9i7MCZK2/zCUvgK0ntunllCCaXGry5tL
         GZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341200; x=1709946000;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=ht+25+a6BgOP4F6uyPfDcql+nv8fKZBWfqWE6m5sg7XPpViFCM7TZ2KCxo0dH7hh4N
         zXvZQM8aOrNAcmfeOAXVJEX0Bs4CEhWS6T7Mt/M+UrAno2BXIzuMCfrTO4d7EXw1zgAu
         spL3XhheXUgUspNxgZpnHmZFKN5GbGCmsF18h6PLd/R4DpPtb5gGjb9fXLHOAVqGu0Sp
         4pVeGaKFOfJNFyFowe/1uwZzn4FoHjX92lzup7KRPzAVrryZ85c9KI/ChJHAyEsmg7R9
         OCzqZWaz4OS3HKdcRjTArVyKsX3GjpKndx3QPYdT1aW6F014KHwAayEMxT/Wn8i+oUFU
         JXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdGUYlKRXMauQlp3mIe8QdZM/DnTOfOTuLvPW+D3UmmvRbqjBEjmgtzsRXk9OkT/XwN0HNDCIlRhZUVd9VMCbd0wfxvc6D3SdlPMIQ
X-Gm-Message-State: AOJu0Yw3c9Tp81eq+QyTmpX16AEQ+4K24P2bkOcTccss4AoHzCmmCyMi
	6zY/OmjoAx8ydXVZjBNXJRQKnKEb6fs/hO7btwq60fnkjCciDNO2r7CSvy7m+q20BL1OHaHJl2j
	X91XLQw==
X-Google-Smtp-Source: AGHT+IEMQI04qGuYa4Zy58eJ8B0dl7EShvAo5QCBxfWARRYtox544qmVY1jy44EJRh7ccXwS5r6FTR47WEBw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a17:902:c40f:b0:1db:e9ed:bbb8 with SMTP id
 k15-20020a170902c40f00b001dbe9edbbb8mr143679plk.9.1709341200314; Fri, 01 Mar
 2024 17:00:00 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:39 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 01/12] perf jevents: Allow multiple metricgroups.json files
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

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2c7e5d61ce92..65ab03ce5064 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -603,7 +603,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -653,7 +653,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.44.0.278.ge034bb2e1d-goog


