Return-Path: <linux-kernel+bounces-64798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB58542F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475B01F21C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74914AB8;
	Wed, 14 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESIxsA0b"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729F12B8C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892650; cv=none; b=cK/QtSw+81i40Fm9KI8NdBuIjL+K+JEYpa+z5lg5F2eWbCekEZNHmstL4v9dE4WZxFNnsf1TAF+wsiOoWuUm0febJPzfRwNA6gt/MoaTo9S42UpxaO5ruis9A9AZUTprriQoa9Cr4HY977ep/xPDQFPRaBhpwqpLVbkcrIJiZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892650; c=relaxed/simple;
	bh=gi4txDdv0C9NQjjEzGpOMktXyzhWLm0PbyoiCg8lenM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CqttRdZG6qt2sAhVtOFvXLkaapbJI6RHlV+3L6u2tYLD+LUU7/tGlbYWqQABSAFhm/UAk+v/5YLge5d+SpA81LceybQFyw2Dr1xxh0QGSQ+dxYjJmoOIBRl65hD5Q/zHeyM7GiJGXVDTQlkzVa+k0Pzjz/BcbeP47TowPQgp2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESIxsA0b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso7062267b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892648; x=1708497448; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CANQqurHGmF5Ru8GYcuqg+/9JMey73Sl/dxU7/wCOGk=;
        b=ESIxsA0biR3o1+9gLHaK9lU9NuyJ3HJw8dfsMYdRxzdEbvKJSKymj7wfdcGS6+pCnt
         7uJr4q1gF9qcVGUd80IbaPzap8aTLBguMdLYiZMCgezMl9uN1P80Zzi2f90lhR6D3dJs
         v5Dwd3nT6LFpctpm2qV+bUkLMvp4gGjwsFraKvZ331HeaP2vCpzdEuqxIZ2a9iQfHs5z
         79JnYSpUGAeKYxGGclHdY5F58gJYvYUKA+fDDZkhPwYfnEQoiXBBTr+lyc50wVdkdPGd
         K5ObK6hZZ1dEVMMvgpzZFE330LSO+AO7ht0FWy25dbS5aoqm96sxb/7Ix54W6f1mu/AM
         iCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892648; x=1708497448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CANQqurHGmF5Ru8GYcuqg+/9JMey73Sl/dxU7/wCOGk=;
        b=veOzy1zQ7A6KIZpO21eYDOUaeX+JHZKGZphInxzr1lAstX9qh9xKlpq1690OX1RVkp
         VPZaNOPsjnP+baAYwbro2dMEJB9e9IHSYhCjDFjmp/djk+jhUn5wANRIKvxAtwUuOaJZ
         mqHjST7tKxSkV7PJNTQZZ9YXQdmvlbqsDMcMaMkKefO+4G1RfgussJHAkTV8g9161pbg
         COHSjW54jgHrNgAvW/R8KDzP2UGzTpdt1hetDBZTos8Kt3A/KqOLcwPauWTMyRFh3Od9
         87VeDzuBSUkkoBKs0Bi7XWMttMhTgvNLWMyeRBNYRHGBdmtwFnJDrGu1+XCO00eRPUlA
         RfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhFuHyb6q9kTIal1Kkud/YxgOZlzbbFhTyn0gVTYzXRz5a8/qEPaUx2rJIaOu7PvJKB3Jx/No34f2lccex6f1b+dp8at+UrB3qAxHS
X-Gm-Message-State: AOJu0YxlLEZYOnskHVoE0T6nwABrUMJDeCtbV4nk0mtD/pvey9Fxfe1J
	jUMo8lY2am1lhzuaCYt2HdoBzHVXko02ESUOS1slJwm1KIXapxRAXRHycmEaxIU77nbUxLY0q9B
	LG6WDag==
X-Google-Smtp-Source: AGHT+IHGxTR+p0CnuoOK+VdU0lHFhbRYRprRzVqsZvfUFCN+ScY3VDeSQ24bNsXgrrxVtSJ52mhmdBCQBk5J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:4fc6:0:b0:604:125:f0cf with SMTP id
 d189-20020a814fc6000000b006040125f0cfmr232032ywb.2.1707892647799; Tue, 13 Feb
 2024 22:37:27 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:05 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 3/6] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7872ce92c9fc..e072b2115b64 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1113,29 +1113,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.43.0.687.g38aa6559b0-goog


