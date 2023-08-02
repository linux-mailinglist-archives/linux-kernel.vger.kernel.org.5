Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6976CD82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjHBMt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjHBMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E92271F;
        Wed,  2 Aug 2023 05:49:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790ab117bd5so120086739f.0;
        Wed, 02 Aug 2023 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980552; x=1691585352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPn/mgTWKV+oBePvxacidtJnH5NXaYh0/ilB9/OG6C4=;
        b=BsmjiHo5WQQKClP5ASFtdsx0MlRD8yQSsvBGCM+NZ5GvwEDKFO8y8x02RduX1Q6Hm6
         CPuaI/jLsxd9z57uutSrPQ/rPOttOx01/WFA9pyta/NEqdzAgQCF1ZTBA9m8iM1/kpH3
         z65NBjwVeazO0Q8Fc2/yZui8mj2KvOcJTGPVddZxrfMPGHLddhmkwsjCZrSvoWbOl6PY
         KSP2aAZQBr9d9BufbCAvdlad/j3ulGI8JGqpcRfoX87o1QRM+qO8z7oYSjF6YKA4Gx+u
         A+tw5BJaWOYgThrR+7cZsLAHUHDjeb4pxkr0vdUxgfJoZvAA9VhrD0lJwG1rFh/ISIwO
         DPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980552; x=1691585352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPn/mgTWKV+oBePvxacidtJnH5NXaYh0/ilB9/OG6C4=;
        b=AmyxQjQpYDADpRvLQrE0r2Ib59A3+9pmM4Au7H/AvglyvXT8ZxNeoleArPhD3aOxfA
         ewsAVtazXP1xPUBmJ3H4Dzs3vrfjjlLYEBAvhGJspvg3f8nX1HBJTfw9j4BNcwEXVdDO
         mx9NSNF289GaauZfB/lKj0j1T2egU7inW2HlljBOnWdMTohto0L/y/6m9qDIHe5UAt/A
         V+Vk3KBs8ms9tJWJa+ZFtFPS5WwCm8joCZGF+yKvkOD9XbWAPD8xUtfHIBIK2ih9z+V2
         15ZFOmngC7j/7ZzAxz67HIq2X7LDZD8ESXzyfuTz6VouGYEb+tbBeZE688ZY4owfW3w5
         /Sgg==
X-Gm-Message-State: ABy/qLbSNwiNFPEGTRpqjLcLUg/pg1snIpU5KMAR4Lb6EiBDtTABIezF
        sBiuGV77I0ziFmCezai5LUg=
X-Google-Smtp-Source: APBJJlErD1wHdBCAteMiisn+oi7DyRmull0LoxCEYSB3RmEGXwBJDpTihPy1OWjYPqu/tWZPejeyiQ==
X-Received: by 2002:a05:6e02:1521:b0:346:f30:ad58 with SMTP id i1-20020a056e02152100b003460f30ad58mr16967213ilu.24.1690980552110;
        Wed, 02 Aug 2023 05:49:12 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:49:11 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v4 6/7] libtraceevent: prefer to use prev_state_char introduced in sched_switch
Date:   Wed,  2 Aug 2023 08:47:29 -0400
Message-ID: <20230802124840.335638-7-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802124840.335638-1-zegao@tencent.com>
References: <20230802124840.335638-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the sched_switch tracepoint introduces a new variable to
report sched-out task state in symbolic char, we prefer to use
it to spare from knowing internal implementations in kernel.

Also we keep the old parsing logic intact but sync the state char
array with the latest kernel.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index e0986ac..4c57322 100644
--- a/plugins/plugin_sched_switch.c
+++ b/plugins/plugin_sched_switch.c
@@ -11,7 +11,7 @@
 
 static void write_state(struct trace_seq *s, int val)
 {
-	const char states[] = "SDTtXZPI";
+	const char states[] = "SDTtXZPIp";
 	int found = 0;
 	int i;
 
@@ -99,7 +99,12 @@ static int sched_switch_handler(struct trace_seq *s,
 	if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) == 0)
 		trace_seq_printf(s, "[%d] ", (int) val);
 
-	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
+	//find if has prev_state_char, otherwise fallback to prev_state
+	if (tep_find_field(event, "prev_state_char")) {
+		if (tep_get_field_val(s,  event, "prev_state_char", record, &val, 1) == 0)
+			trace_seq_putc(s, (char) val);
+	}
+	else if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
 		write_state(s, val);
 
 	trace_seq_puts(s, " ==> ");
-- 
2.41.0

