Return-Path: <linux-kernel+bounces-84082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC786A20D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8311287B50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD9156985;
	Tue, 27 Feb 2024 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dleXVlg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA4153BCD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071332; cv=none; b=HeFDIi/eDCln2Hid5BZ2qG+nivS8ZG18iYQstb+yiALw5DrUywk88CWNfEewC2lsuz1nULwPzjWLRwyriatzxSvfZ6BY1yJuH4/pKm25/OC59fuotg1Vv2XvfR70vw2OTOa2Bz/5m0vvNtB0T1kN9d/btAqjo4CKl0IzA2CUQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071332; c=relaxed/simple;
	bh=/yGeJM1MC3xrnGlw+YrOzjUeVSCpkNh+lS2W25QBImY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D64A8+mMkY3LzB25EwDAQWyaazk5RJo7v9vlKS6i+vAlVnyscg5Ge3RHv9lOLH0+q+5lk00G6jGmDDbuQRJoPqlohJ3e75I+d1RgHGBi6kNQmmXNVvi6YNvB/XmEX1dHfPfT1SPEmsFr/TynYB/ZFHZzsSs8LIM2+6VY4M77lFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dleXVlg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso82021337b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071329; x=1709676129; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLvFhK5uL/QCeGE47QDYifrDggRxdFdeVaa+ektv4Ks=;
        b=4dleXVlggqGls83VLDgVmaAYqUTq7J/uiSL0iJc+KNyKLNICbsipEW97LvJweK32Hv
         XCGViPHcDRN0RZ9MzTlYCKWgog99NebLaguxMTvpcQJxNJf/Nwo7FWdzlMiE0VSMyvut
         RcNvasddobo2cv9jO/pwsLSS5swYhqMc1N/EhvgjCp7YmAyg/nkN8JGo82rYbHN+EKGa
         H3sdYTUZPFJdYf0nJOi8GloAulR6WFLIo114Gm1Ovwt5e7K6/iXsHgXSbm+N2VpDXrkN
         Sa0jJEbxXjdsnmU0bpuECXAJkR0DYXJT+5lKwsBNkRRtJ+Qo5Aq7NXTALOoh0FZxcOHH
         2stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071329; x=1709676129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLvFhK5uL/QCeGE47QDYifrDggRxdFdeVaa+ektv4Ks=;
        b=UchK9s/7rOwtSBbuy32P9LElPH4slwQdYwGl1EpjARRq2CASkUzIBhXLOiBYkDmcIm
         EQbJAXU36MUesYOZZIoja7d8hd3qqeq4uqF9kb8/D8xEBP+pxGeIbGVzC6y7IUrqq/5z
         TsNrPNwcXwULEB6XZhNnPV5jUIZ5ZxNplzX0zZ8C1of4sNZPvJ9L13LRxXxBFYe8WAwx
         PsrgqAYc6mRXz8TudcWJvdCMtipmcdBQlVNSpdPqymZrX0jiMUJ58dyLkDMymQvOtpV7
         amJ9wa7EDE1isrHES1TbYEVDAl4NFRQIT8KgZtW12DrjbUGuk6ztp4TgrzNaW2sWOJ3N
         BjeA==
X-Forwarded-Encrypted: i=1; AJvYcCVmCLFl7BqQowC3P0Pvw47Fi4ZYn1MLrr1u35EAnbeXolhK54WRzflyScP0dKq/TZBgWp/WXncYojP7AdP90TdtarwCpWAeIiLcIKdX
X-Gm-Message-State: AOJu0YwSHi8AHnCZKlbxfIveBTlDa4KGbMJlGLI8EXWESCENHVT0kyw9
	veHBioEvmCzReQX4JL6y27f2E1RBfAd9RhHD6ZbSmSRHjDbTyNdHm2A3btm13QimhLTTrIb9Uw/
	rxeidjg==
X-Google-Smtp-Source: AGHT+IGZSMnaIsAQtX/ldCpU/7po8oMpdQxnfEczmc5sne5RHle1yvyEtqmQ/soBLtduA34btzf9Vr/IMJAe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a81:a08f:0:b0:608:e711:5a5a with SMTP id
 x137-20020a81a08f000000b00608e7115a5amr807524ywg.1.1709071328756; Tue, 27 Feb
 2024 14:02:08 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:47 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 3/6] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.44.0.rc1.240.g4c46232300-goog


