Return-Path: <linux-kernel+bounces-86175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA50B86C0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5102876B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657E446BD;
	Thu, 29 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swNltk97"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71740BFD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188389; cv=none; b=MutkpWa7Of+Ew+u/iEwdR7KrC4eY3SoTZvjkko2LCazxdAgIjd54dmeJrt86rQ8Ai547fexeiISlJ3oCR9a+QqsuGwN5sG992j+e6M9sgzghcC1va3bGR3UdpuwPAUrG2aEIo6SfPntLpZrJxd/48WsGTT8j4taV6OZJSqecIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188389; c=relaxed/simple;
	bh=BBmU04u6tU5hlUeOKBhv7F/E4iRu0Xd0+OelCnDu9d4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jTL2VVgIm43vJ4yoCxxD4mGYlP2NLfNR6bKFZM5JujlSO/9z+7A+2m+sJ9MxwbHA6QXuz7SqfaVziFIrjP8gEoEe0M4TI9EUrmWeEIUrwCndpM/CKs7ixUe/nySiL0hjJBuRrEPhFXdWmZM04LcnerewebwSEghoiisF/nKyYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swNltk97; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so10327977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188387; x=1709793187; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=swNltk97i/QW+2O36YEmdnIcd3//4jY4e14/4GfBAao8Za5doN+8lzRqz1hze1Xh3t
         l2unn8Dq8ZyiE7h7TQSDwwjxpD5amWq5wqB4bxsz0eVvaiY1szsx3b/HCte8Jozj/aux
         mnfQU2SmQgJoY/PN2BfYMSPrVsyUyeF9Py8Gq+5NOiy1SIrsXVr48iNkdiXN9zXQuQlX
         pDmHOy9+0olyUAhvsyStlM4nznCSrKUj+WGv/gGUDNA642CkRnazJtFKS1IuUGrbkvh8
         1KVMwAuxw1Oxym/igt1d+iC2D+zwmjFriLQyhPxA+jxeSkhzCSOBiy+CzoI+LsqXGq4k
         mqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188387; x=1709793187;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=UuBYlihLLjOBO1n9pjtvyrf5lcxoZyErN418VG1XnYedhc9oE+gMq+9NKJGLVMQEl+
         cU//rahST3iu6nscigdIua7sRRZmRPFetBUKkae7ZuET+p8/L/+LWS4HXHruJEw9m5SY
         FjloxZPAfahODyD0ryw8TnPS1iw+NuP3hy3BiwR45lgEF65yYhgV4bhIW689UmKzED5y
         KRjsVgrf/VHfTJ3m44Q8bobov9l/rGqv9MGNaTFQlVuNq1Oc5/n8jLlv9c8uNcrws/Fj
         5HtZhgPmM29CxGngNfE9hL0Rkh4SDpk5/3JNUHKdMP0TCeBFy9Xi2YSOamZUqjNcXXKn
         S5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wJ2aptOH/yaoPOwK9PHosmShiqqIRpadRblttQE2Tt1r74HwnT+Yc2lDcDqkdZCUu59/WUltqPZuRuq0jaMxMfmhwV9tb1U91Yv2
X-Gm-Message-State: AOJu0YxK05Li+95Kqu9KmSPL1mY1wsxST0CEllwBpFWJBWNIo3OV7WOp
	c/zwda603HsXdFaepO8S5SlK9dUPLB52Bi5ZZahld9oIZdzrnlLI6tNUXPiq+nzEGFCP55PdXN+
	YtMDCVg==
X-Google-Smtp-Source: AGHT+IFkZo8yecpkI+W+sK5sWL1WR81Xp61y88EwT7xjjPmQZGMa9JVy9SpiYr+4bM67DBi8t2Jtof5ViPP2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:f8f:b0:608:ba07:3093 with SMTP id
 df15-20020a05690c0f8f00b00608ba073093mr304530ywb.1.1709188387308; Wed, 28 Feb
 2024 22:33:07 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:49 -0800
In-Reply-To: <20240229063253.561838-1-irogers@google.com>
Message-Id: <20240229063253.561838-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 3/7] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.44.0.278.ge034bb2e1d-goog


