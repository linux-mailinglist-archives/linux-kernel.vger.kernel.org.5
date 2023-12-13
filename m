Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFEB81065A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378089AbjLMAPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378161AbjLMAO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822CA10E0;
        Tue, 12 Dec 2023 16:13:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d331f12f45so11337305ad.2;
        Tue, 12 Dec 2023 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426436; x=1703031236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t/jCfuCUZC9zxm3UClkrBHsoKKvmWbcSihR8oLu4is=;
        b=R1BC/2KgwIqom53RrJvVKuDlY9X6azxXnmVcAPgJlIaVyWx1wE9wxLnu3sLd0XwFj8
         p/xYaLelZRII1YgfgZy6l873KrHdY6tz+KHVvvCgJEVKhYCcbcKfKvALund280cFo9T0
         NgvvK1f7KH0vnIEk8cESFVd7K7W77TpfmCYY/kz6rgsxLf92TK4cnmpbn5rq97E9bfBK
         LL86ZVr0k4diLs69xKYnp2GuOQYZh0ntx8mbLE3dbhcj1bhXwEX8BHOHAWm47MaVVgaf
         wCQupC1plrw1PgXZ2lbbYsmDIdm3tO4eCRSR0MKb8CvL8K0O3mHSKJQOwgpvMByZb5k1
         7+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426436; x=1703031236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+t/jCfuCUZC9zxm3UClkrBHsoKKvmWbcSihR8oLu4is=;
        b=lhiLw/qe80rKZhDxS81c85LWpYDJ2Z7FZJGEDcXPflrAcpfuhKRq/Fgq1jTxCFufr5
         DmktqaAOKymeYGtryaCRrs0A9o3Zq2mlnJ+NKe9c/HiAJalw1bJbkntFVWjrDvkQOtAS
         dLOAMvtTgXM/LSRsDSYvW0UbUn12/0I2xUHA9I5SfjlIWjl8Js9L2wgyjmo12ucwApwa
         oFhAjzev1TUwmtu2HJveJjY/Ou7HYD6Cbq9qxxQlDheC7k9tf26v0y+ym1ZGdpaW/Jwn
         vJdtvQJ6M+2Uj+GeoUhl8URQO+k1xEAMLlTpWzVbLLbO4mBffezalhxbYJ7vtKuq8Zwm
         aTlQ==
X-Gm-Message-State: AOJu0YyI0rXgpoJ0gqBKjNERm771aN2aNKio4/6MN+WiJTAP/Bvu0jW4
        Pzd8VCNj8bhyXuSUBoCYTW0=
X-Google-Smtp-Source: AGHT+IEulzTP+M/7vHMVxwDJSarpBqmnc2dExzmaYKk80NGHrcLvzEBUa22gIvKzaqA1aPVhi2+7fQ==
X-Received: by 2002:a17:903:228b:b0:1d0:77c9:a9a2 with SMTP id b11-20020a170903228b00b001d077c9a9a2mr4760835plh.25.1702426435705;
        Tue, 12 Dec 2023 16:13:55 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:55 -0800 (PST)
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
Subject: [PATCH 17/17] perf annotate: Add --insn-stat option for debugging
Date:   Tue, 12 Dec 2023 16:13:23 -0800
Message-ID: <20231213001323.718046-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
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

This is for a debugging purpose.  It'd be useful to see per-instrucion
level success/failure stats.

  $ perf annotate --data-type --insn-stat
  Annotate Instruction stats
  total 264, ok 143 (54.2%), bad 121 (45.8%)

    Name      :  Good   Bad
  -----------------------------------------------------------
    movq      :    45    31
    movl      :    22    11
    popq      :     0    19
    cmpl      :    16     3
    addq      :     8     7
    cmpq      :    11     3
    cmpxchgl  :     3     7
    cmpxchgq  :     8     0
    incl      :     3     3
    movzbl    :     4     2
    incq      :     4     2
    decl      :     6     0
    ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 41 +++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.c    | 38 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h    |  8 +++++++
 3 files changed, 87 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 55f97ab1395b..6c1cc797692d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -58,6 +58,7 @@ struct perf_annotate {
 	bool	   group_set;
 	bool	   data_type;
 	bool	   type_stat;
+	bool	   insn_stat;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
@@ -434,6 +435,42 @@ static void print_annotate_data_stat(struct annotated_data_stat *s)
 #undef PRINT_STAT
 }
 
+static void print_annotate_item_stat(struct list_head *head, const char *title)
+{
+	struct annotated_item_stat *istat, *pos, *iter;
+	int total_good, total_bad, total;
+	int sum1, sum2;
+	LIST_HEAD(tmp);
+
+	/* sort the list by count */
+	list_splice_init(head, &tmp);
+	total_good = total_bad = 0;
+
+	list_for_each_entry_safe(istat, pos, &tmp, list) {
+		total_good += istat->good;
+		total_bad += istat->bad;
+		sum1 = istat->good + istat->bad;
+
+		list_for_each_entry(iter, head, list) {
+			sum2 = iter->good + iter->bad;
+			if (sum1 > sum2)
+				break;
+		}
+		list_move_tail(&istat->list, &iter->list);
+	}
+	total = total_good + total_bad;
+
+	printf("Annotate %s stats\n", title);
+	printf("total %d, ok %d (%.1f%%), bad %d (%.1f%%)\n\n", total,
+	       total_good, 100.0 * total_good / (total ?: 1),
+	       total_bad, 100.0 * total_bad / (total ?: 1));
+	printf("  %-10s: %5s %5s\n", "Name", "Good", "Bad");
+	printf("-----------------------------------------------------------\n");
+	list_for_each_entry(istat, head, list)
+		printf("  %-10s: %5d %5d\n", istat->name, istat->good, istat->bad);
+	printf("\n");
+}
+
 static void hists__find_annotations(struct hists *hists,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
@@ -443,6 +480,8 @@ static void hists__find_annotations(struct hists *hists,
 
 	if (ann->type_stat)
 		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
 
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
@@ -792,6 +831,8 @@ int cmd_annotate(int argc, const char **argv)
 			    parse_data_type),
 	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
 		    "Show stats for the data type annotation"),
+	OPT_BOOLEAN(0, "insn-stat", &annotate.insn_stat,
+		    "Show instruction stats for the data type annotation"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9870257ce21e..9b70ab110ce7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -105,6 +105,7 @@ static struct ins_ops ret_ops;
 
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
+LIST_HEAD(ann_insn_stat);
 
 static int arch__grow_instructions(struct arch *arch)
 {
@@ -3665,6 +3666,30 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 	return NULL;
 }
 
+static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
+						      const char *name)
+{
+	struct annotated_item_stat *istat;
+
+	list_for_each_entry(istat, head, list) {
+		if (!strcmp(istat->name, name))
+			return istat;
+	}
+
+	istat = zalloc(sizeof(*istat));
+	if (istat == NULL)
+		return NULL;
+
+	istat->name = strdup(name);
+	if (istat->name == NULL) {
+		free(istat);
+		return NULL;
+	}
+
+	list_add_tail(&istat->list, head);
+	return istat;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3683,6 +3708,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
+	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
 	int i;
 
@@ -3716,8 +3742,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat == NULL) {
+		ann_data_stat.no_insn++;
+		return NULL;
+	}
+
 	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
 		ann_data_stat.no_insn_ops++;
+		istat->bad++;
 		return NULL;
 	}
 
@@ -3726,6 +3759,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			continue;
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		if (mem_type)
+			istat->good++;
+		else
+			istat->bad++;
 
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
@@ -3738,5 +3775,6 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	ann_data_stat.no_mem_ops++;
+	istat->bad++;
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6c75b2832286..dba50762c6e8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -479,4 +479,12 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 /* Returns a data type from the sample instruction (if any) */
 struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he);
 
+struct annotated_item_stat {
+	struct list_head list;
+	char *name;
+	int good;
+	int bad;
+};
+extern struct list_head ann_insn_stat;
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.43.0.472.g3155946c3a-goog

