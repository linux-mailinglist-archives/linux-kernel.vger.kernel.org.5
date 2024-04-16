Return-Path: <linux-kernel+bounces-147273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E98A71D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736B9B21752
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D7133285;
	Tue, 16 Apr 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiKTdV94"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686D1F956
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286835; cv=none; b=q8tu45LYI0Rwz/oPWZpqo6vXNzxPENBbNRr53xRczpb4eN3KNjlR+WiDR/ie8BxXYuW/Z5ZP0pZ61MUyHhE6Yg4Ifc/kkoNob2vkj85jDuEcJDVFrYdmSJJC6lT/N3ghRKXlruh2GnUtuLOW2KOFZ1QueszfAy/OoHcYvmUszTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286835; c=relaxed/simple;
	bh=eWS4hkOA9c5MUyVViK475t1qOR4HpPha6Nk9Zap1JUk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tMjBGc/AU6FlHSlzF1MQ+eyLWX4OE1KBYwoRXWmRG5u/CnqNNOrD+3h6sW3Em6gv1zqMGFWlwsEiOR+wyS6e7SoPMog9IDYY8EGJJKMaWD/fD5vv9Z712UJLAfK9diRbRB3+RlbtWGnUcqkTy7UWxYKlPxFBlmM/lfThhWBTG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiKTdV94; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso8067992276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713286832; x=1713891632; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHZ+4taa5ZmMf/oaE74yETbEavJXLOGjMfJKJZgW7D8=;
        b=oiKTdV94ypRqlClyB5jW9fNE0/2SdIhV1hIsbvIxY4/CpRtN/CdmX2YP43Y5fjeQDh
         PLA52JwZt5oOyAl6PIwj6vxhXp7+hKCe+yBKPgTv7hvZ68kA9dtgoeEQRJxPzVbtJgNV
         sAtFf2ONwIHnGAWaDcxgPvDW7ngvBMO8ORhcBQReZ7SXyH5gFwM5EWGggytRPXz/J3Fy
         7Ht3EX7uH3x2aKqmumm2yrQ4P/T5+Y+3iFfVxKDIyTNHb8+VrxtH4nv8bQSaDwVPpVWP
         Rh6dv/w0rXaNV0R1meo+anAGBBcc8OkjRRnNVMHULGgFlVu40DoK2mvrq7bIpd4VNkWL
         euKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286832; x=1713891632;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHZ+4taa5ZmMf/oaE74yETbEavJXLOGjMfJKJZgW7D8=;
        b=MuoEf3XXIWqJkkbQLelLD0r1WLRToK/cQL3skjhNUDYBOq9HIVVahgKdh0v8rb7zcd
         751O4OMY+HqS1lax51hoC/mlQEg30Ym09GwNrP/EWer0v7Fmo8XPs6tE5K1ayUaT2tOO
         ExpVobJTwkpmwYok45+hnmqeIGeBNSjtLMSimbxacmmsxiyXiPizaYPV61IyN69Gcbeh
         U+XPpLLwXyZ/1g4OLbtZHmAswQcroIKwXBAtVfDteY/7EWxKIQnrXPBT5EvP7cBW5FCf
         hLTtSa4wcFOHGBXIC3bfT/vQf59InkxBDksu5va+JfWlw3QjEE4W+xoo93PF0XJ7GQn5
         vmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVNiWs996oXHau40/OEtGcr+JqHsDj16IOyjofdKZpUe5qOyI7yXTbDlCrwEuUtcITItjm/iHgYjA3f/9Seh4KF9hSkItJbq7rr+TEi
X-Gm-Message-State: AOJu0YzaDb1LLebVFY9XxiElH4c3jhs+GHkI4zXhyAep/nV1FtAG34Mj
	SYfmwmmzDwqHoh3T1gM7RjiagNHSLMyivvQfAv2Ql/e/y3cYH1FqOxwjrhYoIL4i/jW4JBDEOaC
	lhCgCmQ==
X-Google-Smtp-Source: AGHT+IHpba/rJhzl9JMKIitpVKqKH62dhmqQWuSYivFdu9/ee66XNw1Ii34iQvnlkzNQhtlYgsX0ePwTqV64
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:120e:b0:dcd:88e9:e508 with SMTP
 id s14-20020a056902120e00b00dcd88e9e508mr4322514ybu.5.1713286832038; Tue, 16
 Apr 2024 10:00:32 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:00:13 -0700
Message-Id: <20240416170014.985191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 1/2] perf docs: Document bpf event modifier
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Song Liu <song@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document that 'b' is used as a modifier to make an event use a BPF
counter.

Fixes: 01bd8efcec44 ("perf stat: Introduce ':b' modifier")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 3b12595193c9..6bf2468f59d3 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -71,6 +71,7 @@ counted. The following modifiers exist:
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
  e - group or event are exclusive and do not share the PMU
+ b - use BPF aggregration (see perf stat --bpf-counters)
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
-- 
2.44.0.683.g7961c838ac-goog


