Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199F7E7574
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjKJABZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345481AbjKJAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460A47B9;
        Thu,  9 Nov 2023 16:00:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so1196413a12.3;
        Thu, 09 Nov 2023 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574436; x=1700179236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvKZfgb9TPzKC/D8JQqUC0o12NYPt/G4JoRXa7PKCNk=;
        b=HxYFUZ5TZorUYGDTkALP8XuYJIic15+yB4YnFv8Nets1et9ioyl7j3zz7ePQX2n+gX
         PqBkdVhGOw9DxaEXUkLHFrE/QlXb9CrhP4YJiBWTNrTK73uzrtfMOVDOoKx8JEEyhpil
         6W4DgkO96PJy2uOAa/k6WE5qgC/xvzWiAFJPxb6eqSqlhBbSf87VR/DWqLuj8MSbUIWo
         pSNUamsWhS5oHcO5nJxyssgUyjwqbSGKiP7wOvegE8lBD37j4kLJt9kdDHAh4NoxFqRg
         OZ7aWUlRj70lN/y6NzQ7k/3YEe5xF9Xspp3kUCWo7781ewbX8vNq0hmdjgvhQ2sKPrTp
         CPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574436; x=1700179236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvKZfgb9TPzKC/D8JQqUC0o12NYPt/G4JoRXa7PKCNk=;
        b=oG3E8eF131ADKwA7uvcYevNHaKT40J3+mE7krcsaXOy5seLsACZ07LLL1znEKORvji
         /5xtmGk5iQ5RV9vHP5khnZ5NxZLx+cglxHmK4i47uVige9JugdZ0S+qN3IgX8HuxEdW8
         63TwN4zcRVmDrzqhweNbjyu5xITTJ1rGKr4V3lZ/X7buzCTm4n//ShUghT4kU7fPBGa2
         WsUT340HD/KrqgJotBZJhOYNSu84U1Y7b2JI/eBc2ijwPdqw8e/7FSRLrPimZeqji1cv
         9nGVPIhDPi843XEW8TR3Lp6SxQMiNQx7uEY5LAJpMkBpFNDrHv+RxmkJ1UzZyslcAPpW
         +3tA==
X-Gm-Message-State: AOJu0YzT3dzchK5Q3xNi0Jw8UQHrXj/8vg0YRDmjUb06B9bv2bYp9H4o
        0lq3QpalCQMim7vTsT/F0i8=
X-Google-Smtp-Source: AGHT+IGGw5+FjGvov4deH0597Hqz6bPE/R28i03Bp6d1L4KHkwqLmd7PycY/kw9a4GFmJqqNYnbt/g==
X-Received: by 2002:a05:6a20:8e10:b0:183:c7ea:bb52 with SMTP id y16-20020a056a208e1000b00183c7eabb52mr7616275pzj.30.1699574436444;
        Thu, 09 Nov 2023 16:00:36 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 14/52] perf annotate: Factor out evsel__get_arch()
Date:   Thu,  9 Nov 2023 15:59:33 -0800
Message-ID: <20231110000012.3538610-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__get_arch() is to get architecture info from the environ.
It'll be used by other places later so let's factor it out.

Also add arch__is() to check the arch info by name.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 44 +++++++++++++++++++++++++++-----------
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3364edf30f50..83e0996992af 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -804,6 +804,11 @@ static struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
+bool arch__is(struct arch *arch, const char *name)
+{
+	return !strcmp(arch->name, name);
+}
+
 static struct annotated_source *annotated_source__new(void)
 {
 	struct annotated_source *src = zalloc(sizeof(*src));
@@ -2340,15 +2345,8 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
-		     struct annotation_options *options, struct arch **parch)
+static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
 {
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
-	struct annotate_args args = {
-		.evsel		= evsel,
-		.options	= options,
-	};
 	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
@@ -2357,23 +2355,43 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (!arch_name)
 		return errno;
 
-	args.arch = arch = arch__find(arch_name);
+	*parch = arch = arch__find(arch_name);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
 		return ENOTSUP;
 	}
 
-	if (parch)
-		*parch = arch;
-
 	if (arch->init) {
 		err = arch->init(arch, env ? env->cpuid : NULL);
 		if (err) {
-			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
+			pr_err("%s: failed to initialize %s arch priv area\n",
+			       __func__, arch->name);
 			return err;
 		}
 	}
+	return 0;
+}
+
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
+		     struct annotation_options *options, struct arch **parch)
+{
+	struct symbol *sym = ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotate_args args = {
+		.evsel		= evsel,
+		.options	= options,
+	};
+	struct arch *arch = NULL;
+	int err;
+
+	err = evsel__get_arch(evsel, &arch);
+	if (err < 0)
+		return err;
+
+	if (parch)
+		*parch = arch;
 
+	args.arch = arch;
 	args.ms = *ms;
 	if (notes->options && notes->options->full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index bc8b95e8b1be..e8b0173f5f00 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -59,6 +59,8 @@ struct ins_operands {
 
 struct arch;
 
+bool arch__is(struct arch *arch, const char *name);
+
 struct ins_ops {
 	void (*free)(struct ins_operands *ops);
 	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
-- 
2.42.0.869.gea05f2083d-goog

