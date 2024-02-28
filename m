Return-Path: <linux-kernel+bounces-85476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532286B683
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928E21F26959
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1215E5DF;
	Wed, 28 Feb 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1q5uGIm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20615E5C3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143001; cv=none; b=YF/RFlGvXe+dEY2062B93DcRPlBjb2FnroqVQZVucy8+b0gHzek50AxT1fGzb5khSY25XEAwyqE5xfp1FRBOE/YRuxUj9m7TxucvRpzpAZhYIZPRjOv8Qyc89CF5veJ2wVMzC2XfRvSokPGSUn5oXZb6hFVGx72adWfquShw6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143001; c=relaxed/simple;
	bh=Q8r8JCAtkGCJmmXhKhiAJOofwbQwry+nv4WJ1Szla+w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VFdNG8FkWhqB0JgUOoLvLhSC2t0kKwesAeABIPop4izsqy295GEwWdYNwMa1MuK/j+RBcf2SafWxwq92FezsyRmyXmE4F8UX7ySpQ4Drb4F1lEnkOyjF2TeQE5WwfXcE1Ed9P4XwUacRVhso7WOmCjXOyPlKV6ZFJRG7axDJ03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1q5uGIm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso709567b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709142999; x=1709747799; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=D1q5uGImvlURfYVCMJ91MQQyZgqIKASj5hf65+Sjzq4BYVtSRyLjQ0QwLLdPtuM8LV
         DUEddmawkVE1k6yFXZYO+kL7T2BCcVRifJi1+/0MISEpDyuEUwIokmHQUze6y6738PEH
         gv7Evf7gYQ2ztjFUFyOlykq+oZgAHVGubB7+7Ekw844fM38hzgkAHZ9KGpq0/9ZAv5EU
         WM1Vn2UM6bVAXMDbFuBWcv5bnuZPtR4MZGDL/vncjzx9TYwAKMwZrMx14yMmoA03PZxY
         lNZRlvSJbuqnFVQhe8LsXbwfcdv+qewG7kn74NWn9G0VGBNYi8r+mfwhLyGvpdFEZyhy
         hs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142999; x=1709747799;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=U0NnN0/Hc8nUn4qjm/2k1SI5t0UjQoFM7KQHNjChRZJYaSGMPlInGlAvbX5iB+QoBV
         FKtL01lCwMpRtOC/1AYUyED2fkIyt1WVjjcAqdW+jR3M7pgesJXZs7ABifr2tmj1C032
         +qOB4eA9RTf8KxEOIbFFCGGish+2TUpvIRFMj7pVZrgR7rOXtlM5wBy7o8pzsb0qG4gj
         QW74RJyAMPnY/lL05iEqSAyudy76CB1KuyHh1Wwev/FxYGn9y9qmwlh/FkOfSI76T/UC
         9WJ+/l9bTjQpNHIf5i42fybsIenni+uuLUL+HBJZSUzcwZFr+4wCI+0J0SG54f/ZRiG8
         I3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXCw07IX9fNsuxi1qlNOBDfJAmMLuBhRm7BALl+qXXrQz0I9oOvJ00CE/FKnkK8ZgFnqeoVGg128o2xW9N0qCfP6yfpz9fEMzwFDNmB
X-Gm-Message-State: AOJu0YyL9cMPAkisij6VqjfUGUuiG7BJ8ot6KeQDwJwg5zMulvdPPNm1
	4JoV+bwSA47ix/V6b7+z/f7k1QCTcfc77jmyaj1GfbRS5eZ57p9YXlpBnncmT8SEaPZlwn2bnUS
	NW7DT/g==
X-Google-Smtp-Source: AGHT+IHI/itTEe3VqPJCoYUfVcX7hmPWXSTsc4Oy6YsRC1iPjJDG6HfBmzPzFaHxBAZyfl2m5FE4HgP1LPDK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:2e43:0:b0:dc7:6efe:1aab with SMTP id
 b3-20020a252e43000000b00dc76efe1aabmr2866ybn.6.1709142998836; Wed, 28 Feb
 2024 09:56:38 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:06 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 01/12] perf jevents: Allow multiple metricgroups.json files
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


