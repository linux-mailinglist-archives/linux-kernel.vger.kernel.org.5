Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8166E7C6390
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbjJLD4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377378AbjJLDy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:54:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB8619B0;
        Wed, 11 Oct 2023 20:52:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c60778a3bfso4900275ad.1;
        Wed, 11 Oct 2023 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082736; x=1697687536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNrNBiU6krvSQLSVIZCNwHSxv8ln34r7JWtg5yyof2s=;
        b=X3SM2v4cmKQL1Y2lAPBJTCTFMX1jatJtw7ICKlFFv/Xo8pAHs2P7BEFLgXpJJjnjnA
         YRPrmuy8ipPMPuU/BE55/ruNkCg+++XnucRYCyUDoovxWiPW7b35o4CTbJLMJU7NQWnz
         t9l2BXXhNzZvx86/CPdJhKuXvBL6dw1n0NJtkl9a5gWWAGrQsBSDpv/eBTmXPHtxlOJj
         azhIvhvSblmSDrR1ujHpSBE3a8DWd3O9aRhmHzQmu7stSLYj+bnEE/2WiLK+hNrwkaC0
         t1Sh+x+BPPFexsPF7sN3/22fg0Q2e1rwqxu6MJEdVdiJYikJFwYskCqKccfnbKSo4XED
         Y0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082736; x=1697687536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNrNBiU6krvSQLSVIZCNwHSxv8ln34r7JWtg5yyof2s=;
        b=AtpzxzlZKOiyqH1oKqoss4ylJH3iC24McqUYv8l0ij2f8TkV7NQl8VITeab2gz+fB4
         tWI5YFJpVgaNm7D3bZNKbwiRAt3ZyY4jNEk/nxNeFckDruRf4e6j7xvOFFKyE8WwOTUE
         g5Fcg7taIzsKR6mgqWhbCFF9exjNu5BMYjZs6Ba9krciPwiyuzpzz/Fx9vad0vua/nwe
         3fxxY8qO4DO1QG9pmyC5ScMxr8vUnsbqMZyvcSQUD9DKsOT2s7c6r5EoIWnZLJsbAq7W
         RLN5LcI4Gcpfu3g5WCIc5XI7dEMvkLhmDflOlLS+shJpgq+21WzglvP549FRf97MRCqE
         n9Cg==
X-Gm-Message-State: AOJu0YywyswJjXN7eimw7C7CFuEjwN5W4gZXhBXv3rRKER+Bz8BHQvjs
        7Bg6Mm6pqM1Zx1jXYUAh4f8=
X-Google-Smtp-Source: AGHT+IEvoucq5vGkiukqULI5yroAc9jrfO3u4Qb6tislqrRUkaUQHapZOolBoBQ4uiK96KmMoOm+Qg==
X-Received: by 2002:a17:902:e9c6:b0:1c9:ccbc:4ca5 with SMTP id 6-20020a170902e9c600b001c9ccbc4ca5mr3499059plk.60.1697082736192;
        Wed, 11 Oct 2023 20:52:16 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:15 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 47/48] perf annotate-data: Add stack canary type
Date:   Wed, 11 Oct 2023 20:51:10 -0700
Message-ID: <20231012035111.676789-48-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the stack protector is enabled, compiler would generate code to
check stack overflow with a special value called 'stack carary' at
runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.

While there's a definition of fixed_percpu_data in asm/processor.h,
it seems that the header is not included everywhere and many places
it cannot find the type info.  As it's in the well-known location (at
%gs:40), let's add a pseudo stack canary type to handle it specially.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c |  7 +++++++
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 677dc01432d3..68d7d207e2f7 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -37,6 +37,13 @@ struct annotated_data_type stackop_type = {
 	},
 };
 
+struct annotated_data_type canary_type = {
+	.self = {
+		.type_name = (char *)"(stack canary)",
+		.children = LIST_HEAD_INIT(canary_type.self.children),
+	},
+};
+
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 0bfef29fa52c..e293980eb11b 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -77,6 +77,7 @@ struct annotated_data_type {
 
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
+extern struct annotated_data_type canary_type;
 
 /**
  * struct data_loc_info - Data location information
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 414ae45b7c06..f343f90612d0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3720,6 +3720,17 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
+{
+	/* On x86_64, %gs:40 is used for stack canary */
+	if (arch__is(arch, "x86")) {
+		if (loc->segment == INSN_SEG_X86_GS && loc->offset == 40)
+			return true;
+	}
+
+	return false;
+}
+
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl)
 {
@@ -3889,6 +3900,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		}
 
 		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			mem_type = &canary_type;
+			dloc.type_offset = 0;
+		}
+
 		if (mem_type)
 			istat->good++;
 		else
-- 
2.42.0.655.g421f12c284-goog

