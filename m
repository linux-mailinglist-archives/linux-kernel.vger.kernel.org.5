Return-Path: <linux-kernel+bounces-146336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894D8A63A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D893FB23B13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8D1598FC;
	Tue, 16 Apr 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L86ujXW4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E511598FE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248181; cv=none; b=Uc1W921beAcxNMcxB2ihFh+oWM3FZmf6ZRsFg5JzpHK8eo9XIq4GoDkfWTh2jUR7VkQjjkZE8wAea7AG0sDExmvz8vasWSQ7Cfvt51U5adhSKZd22UN37cOIX1azDND/myCvg1XffItHMpmnS05rhUUXabppbWZzq8n/UuUWzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248181; c=relaxed/simple;
	bh=KaJz8yoO4z8kzF8PImegTLz6lTpKAp/f4nY2Hi+9ZYE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UDSvAmtwkpQ5ZV0JuWRq2Um7MRxtPPMOlPryPhNvQAd94GoOC4srXQUwUpwHFVOM1/1/QqZFGnseqpbRDHxYRYU4VKaJEkTOrPKOefrps1+BHKEiB/rA7sxb831p70TSdTG4Z6ymJG2uRUDfZWucyhKNR7rhoHbzzPvlhpQwBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L86ujXW4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-619151db81cso31529587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248179; x=1713852979; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VrQN7n3xmbjqa9xka2YhMJJYnp++PDb8jkPaxpbY/Q=;
        b=L86ujXW47MrrrUBU6wy2Ce0+FPpX97SC3vv1D0VGToXbMm+AeAUXPYi7gkmHty2En3
         p4QeiNHegkTPB7XpAKoKnsyuw0/NnLWBJ7AcrPTq5wu7UA9YfeR+R3BCz9vYTVEOII9c
         aUW/hB/SVsV3KFczD3ZjqROsazjPOCjAhwGWGYz3cjAXmHhY5VLSlnF2YOo120/DmxxG
         M6mQhdWGv75Sd928kCpZZ/G1gM+BWFgDiK3QOdbCYVBkWwWA9jz4qEH3TSpuGeNARNV9
         TEQ7pMVmFl3qd0ZjgKcN9+xoH5visKlTHC8WDnkGtDEBzT6wSXnJ6AZ81kTZXXFVVJ+t
         HOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248179; x=1713852979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VrQN7n3xmbjqa9xka2YhMJJYnp++PDb8jkPaxpbY/Q=;
        b=bydsHD/ELO6yOXnNA47JrNOX2W2JAUH6S1zXeHbr/qu5M1C6cfyQxNU2buiD2ymvsa
         /Jbc3+NH7k+3KXtnUTaV4XD/WtFYfgHVhHb9Kml0TnYD0qnFDLYmBi8s0F3kn/ISgXuU
         p2D6J9aBnCeCztvMCMjBz+nviM0F8XHNOoOTxD0YiM7f0MjBTSMtiiXXzIjyN0PAq9mu
         jjfUF3SsnD96HAPJ+ggSiTLzrO5w1TTNPCQcFvYzfEknpSL5Jepp3UndX9cGeoH5NAW7
         xihajRuc0UF21JW416hbYD0F3OekzOi0V/Y8cSWJeEjOnQ5hA5BgNLkE90VPPgOH9PiA
         7mUA==
X-Forwarded-Encrypted: i=1; AJvYcCUcFet2AOMWMIBeM5HUjiYeYBTM7qtvY3rg9i1/3OQn6HxzqUoqqV732BSrueubgnHT9Dd1WsnPLmo9qWeOcwu6ANQkfXn2qz1FnZl0
X-Gm-Message-State: AOJu0YwlzRcpBNLNsMxMB/2oYZ5ex0xIQzYK/bdfxGMdkU3JB0nLLjey
	SMuvOIlIEtuTecgTIaEiXA0udCBWMTDh29qCpy1busg8h3bRer68p+RHCEDoDaVZz5ncMbscZNi
	o8ySN6Q==
X-Google-Smtp-Source: AGHT+IERSGPTpkVgBfw9PFFOt/D0ky1G3+P1qSBu4bKGGyUriqoLEpK5IFzVUX9JSbM2dKNl22D4bBUM9mgq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a25:2054:0:b0:dc6:b7c2:176e with SMTP id
 g81-20020a252054000000b00dc6b7c2176emr369458ybg.4.1713248179377; Mon, 15 Apr
 2024 23:16:19 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:31 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 15/16] perf parse-events: Minor grouping tidy up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Add comments. Ensure leader->group_name is freed before overwriting
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 tools/perf/util/parse-events.y | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8d3d692d219d..1c1b1bcb78e8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1711,6 +1711,7 @@ void parse_events__set_leader(char *name, struct list_head *list)
 
 	leader = list_first_entry(list, struct evsel, core.node);
 	__perf_evlist__set_leader(list, &leader->core);
+	zfree(&leader->group_name);
 	leader->group_name = name;
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 79f254189be6..6f1042272dda 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -193,7 +193,10 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $3;
 
-	/* Takes ownership of $1. */
+	/*
+	 * Set the first entry of list to be the leader. Set the group name on
+	 * the leader to $1 taking ownership.
+	 */
 	parse_events__set_leader($1, list);
 	$$ = list;
 }
@@ -202,6 +205,7 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $2;
 
+	/* Set the first entry of list to be the leader clearing the group name. */
 	parse_events__set_leader(NULL, list);
 	$$ = list;
 }
-- 
2.44.0.683.g7961c838ac-goog


