Return-Path: <linux-kernel+bounces-85484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090EB86B68B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B823828A4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998924087E;
	Wed, 28 Feb 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOIIRose"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE471EC9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143020; cv=none; b=W9kCMUHTs3pqGLMxbS2IW/Q812HG+xWDBecNF45D+tJrur6zEdxxu7LGKnj2z/HvrivlQXu5TIuQX5RTlImdStfPjV9GftoO0rj3APS8z0dMIomy9BUJXNzrkr0JZzrq+u2ximSPq1AG7527GUWbzGcWxibsbyev9w8QK+E3IdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143020; c=relaxed/simple;
	bh=r7EPMWXB50WRmPs6Ybs2X/h0mr+Q2k6sSSuIvq/Jh3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V+BL3seveL1m7URWFbxWTJQkNLnOeiTeHGx8P3mLXzzk3vKN7vzTH1tp+RHKkkNF45kZyNNT3YQcvOF/0GXJWt4oz88iIvwcXoxMpwrVQFRZAV8Lv0ImXtm5SOlrG55ot1pj9nbYfF29Fj15BQS9R1DNQm/jBERKgELzeMf/2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOIIRose; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6081639fecfso271947b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143017; x=1709747817; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=gOIIRoseZ9iFqQkJgw3gbBC+pEyaJolPUbWsbPn1fGSfVKntWGgt36vMMRkzagGmJ+
         XPL4s/PmMcFZuSYWSHiqAh3IpgsTfmQNLQSI4SJZpDAzcETjBmS63BwrREzrb6yMTNxs
         wDxD+9NzQ9JfD5oJS5/M52BWA0cER5eFV9ujocNAplkqRAV0Z6ujCyT7yzVL2TPfYqSL
         oo6MkJDLUqcSzQ0xGs6ccfE293FzMotpkMp2fjI79sBC4E30RX3Qk8WFFmDmbHQ/SDXP
         W4xcJceBd+fPom6ew32rmJOEnmrTgjw3TkHgEyAuPS8w5Cr+YlF4HBDDbrIezuDIEjRZ
         aaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143017; x=1709747817;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=FmxWbiMNh5bBRKRm6RlvOYZCdEnakPj53f68kYFfCClCPVUPXIofPTxBX/BkAHfC0i
         +1rf8ZmQX9glrYDxfwA/4uwIOVt6KtzDmE94yHN/asIE2oTrLJxhKMRCbilSfM07PaIb
         MReyZ+1TZfWWSTcqBYQ+GZ98GuRHdqZ250hb4bsrMlQULU3VeDEr0jE0l3TyZ23X3tfh
         /Dvwr1LI3+OEPdIt9N2KoMi8OHXUZdDhwnWezUKib3k3iD3ZkOjZRpM80Ierhbn+RUtH
         +huTKrunH/9W8hL9ejBwIFX2HZSc3LfBNDjcbhsEnSm4x8VDemWs7hqeD42v6j50t6qk
         uD4g==
X-Forwarded-Encrypted: i=1; AJvYcCWcnuWRQqU49NFyHCJoR+VYq0VmFoWGDt7AJB6SC37TaVMlDzt+2VsnmrnWL8ij73cwxndbiZIoh9a2va14n7idkqQdmINz4RyxmLuq
X-Gm-Message-State: AOJu0YxKU30XfTTu8t28SRxbdAi96CNtSROEgW1kKcGGOD5umTRs6lpI
	4POeS+0y9rypS8baAHglIykldcimeDnVweI8SmfK1gfr35cqAJiGxjE8mkpbrm/SQSThYKWtcmQ
	D8ErBww==
X-Google-Smtp-Source: AGHT+IFi5/bHZk8zQrEmsbF1iNnT4griY5Io+IhoeVk0Thq+2P/tyJLwO2I2phQSqvao27m8GG/ct5VasmaE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dbe:387d:a8ef with SMTP
 id w4-20020a056902100400b00dbe387da8efmr155ybt.1.1709143017469; Wed, 28 Feb
 2024 09:56:57 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:14 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/12] perf jevents: Drop duplicate pending metrics
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

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 65ab03ce5064..55205a260a16 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -468,7 +468,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


