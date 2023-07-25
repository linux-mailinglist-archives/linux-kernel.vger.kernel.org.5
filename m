Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561B7603BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGYATj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGYATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:19:37 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CD115;
        Mon, 24 Jul 2023 17:19:36 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bb571ea965so1630771fac.0;
        Mon, 24 Jul 2023 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690244375; x=1690849175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+qqh8d+I8JLYjOqqDKxKO6P5GvaoCVd7uoNdS5hjoc8=;
        b=WznFZ7R0xXINrzBLd+nnNChtTQYJDmLk1KC+Y3X999aWQ/YIod2Ab79WDPD/+bAMRk
         gbsSq7hg12K9hedgWn+H9DwZZj2U1uX6lvkZHmCGFWjEKSbjP5ogBwE3GeHSgM00BOWH
         uPvcGQD+/JZ/pM2Pj9Xm73hB6lNHAV2sjU0vtGsHGAk6iIzyLTnAtWVHp7JkKbfqZj6O
         pIYNp8xmN0KM3JjcR3zplzYMUtDaZpBeyyelk92Parj0PRAlBXuiOcbPRaTReLAa+utu
         9GReVM2JenR8DiUVOCwGYrlRSQknn8wx7KmzW/um1QvGnScZ43qlTBAJQqZwqm0vXCBC
         1WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690244375; x=1690849175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qqh8d+I8JLYjOqqDKxKO6P5GvaoCVd7uoNdS5hjoc8=;
        b=BA0kfODlhQESsKf6zIbdLUxHACXp2oPKlZ+vnUH++yppOTgxlKgKsVIAgCBzsrjK+x
         ONbm+yliWJ7CaV7s3SNgtp1vV3aMZOKLBLLky4JJKiGz4xizSiLDtjOiC3/hyduNxERv
         2ToWlC/mk2HsfMwGXM6d18AGkF1oj/42GlFsSJlCAxlObdVwG7V9zUaA0onZFXsPfahW
         3kpaCdwGOchHv9hjtdm9qhPZbFUX7GQKGERcff/V34NuH8mL7LgXs2iM2IbEY8xcItNk
         ozQKIiM1u3YNZFZy7VzEc6gTmnZOLT087yyHt8GWJqotmKaitS5jX9A5sngKDH0quob8
         opQw==
X-Gm-Message-State: ABy/qLYxDVk/HDZ484/bJPM0GItTb92hHfPA2K5j649MLlDncSZZfsPj
        8wiBsJikF4At2Xli4UOEYas=
X-Google-Smtp-Source: APBJJlFrbO7bpn60zPnXYA0LTLsksVXo6BfRRkQ++wql/vS+iBqNGNOBySOZBqa9PXmjD9ZaTcubGw==
X-Received: by 2002:a05:6870:51c8:b0:1b7:89b5:7c11 with SMTP id b8-20020a05687051c800b001b789b57c11mr15582524oaj.9.1690244375460;
        Mon, 24 Jul 2023 17:19:35 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([101.235.25.38])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b006736bce8581sm8602432pfo.16.2023.07.24.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:19:34 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] perf tools: Add kallsyms__get_symbol_start()
Date:   Mon, 24 Jul 2023 17:19:28 -0700
Message-ID: <20230725001929.368041-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallsyms__get_symbol_start() to get any symbol address from
kallsyms.  The existing kallsyms__get_function_start() only allows text
symbols so create this to allow data symbols too.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
 tools/perf/util/event.h |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4cbb092e0684..923c0fb15122 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -93,8 +93,8 @@ struct process_symbol_args {
 	u64	   start;
 };
 
-static int find_symbol_cb(void *arg, const char *name, char type,
-			  u64 start)
+static int find_func_symbol_cb(void *arg, const char *name, char type,
+			       u64 start)
 {
 	struct process_symbol_args *args = arg;
 
@@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	return 1;
 }
 
+static int find_any_symbol_cb(void *arg, const char *name,
+			      char type __maybe_unused, u64 start)
+{
+	struct process_symbol_args *args = arg;
+
+	if (strcmp(name, args->name))
+		return 0;
+
+	args->start = start;
+	return 1;
+}
+
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr)
 {
 	struct process_symbol_args args = { .name = symbol_name, };
 
-	if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <= 0)
+	if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb) <= 0)
+		return -1;
+
+	*addr = args.start;
+	return 0;
+}
+
+int kallsyms__get_symbol_start(const char *kallsyms_filename,
+			       const char *symbol_name, u64 *addr)
+{
+	struct process_symbol_args args = { .name = symbol_name, };
+
+	if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb) <= 0)
 		return -1;
 
 	*addr = args.start;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index de20e01c9d72..d8bcee2e9b93 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
+int kallsyms__get_symbol_start(const char *kallsyms_filename,
+			       const char *symbol_name, u64 *addr);
 
 void event_attr_init(struct perf_event_attr *attr);
 
-- 
2.41.0.487.g6d72f3e995-goog

