Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699976AB93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHAJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHAJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24114173A;
        Tue,  1 Aug 2023 02:01:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-267fc19280bso4318535a91.1;
        Tue, 01 Aug 2023 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880496; x=1691485296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANQBcIlYslUfyuFpH0ut8ZVNsDjb/eKVIKT4N9OJfTI=;
        b=SU1K5qS/8yCfPyxZKXlBwc104Wvn8wfdVsSfRcB96eVcbDwHfzY00tKeboUstqxq0T
         BRMJCfKfzXhVyj8rxZm6f44pcyyQXe+i9GXjHz8RHOeQeg21eAQudXLshb/HC3aGMUZW
         /WRCupIyCLHEiuD7QM/WI6mK5RqoPEZyTsM6su19ihphcVZtidulyL5iUys7qTDiBq3V
         0ZZj5pgtauhC/533lkLJ5yhvVvZV3ret185irdYlO7uU/ViV24rS/vR75BSx2+6TAv0f
         14JA/Itc5uu/JdH26Rth4KabmTUms6+bVuJldzQgdB4d+UoSsi5ujVrypsOR1UIgxMiP
         E51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880496; x=1691485296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANQBcIlYslUfyuFpH0ut8ZVNsDjb/eKVIKT4N9OJfTI=;
        b=YXPD8FrcOBikmCF8FfUOlrWSF2oai0JvBe1xEJj8GH2zrhO87ia89SC5Fn38K6Kc1Q
         nanoHIfpmD2I3NtwQ1rfr6JMR10PUhqQS5FfM1C4XdkhCeqmRg9MvLGzh26ZK6VwZW8u
         j87o/AXTUxIsx3vaTfsg5TQHYRDLuLIhjgb4p60gw0yF7rNO1Qt8N1UoitghCu7ZSx5P
         M49E6uKTxZveqbaqbDfZOgDYpe29t46m29CbE7VwjcPawbpgbmwmJ/DU6VmhpyeBctmS
         onO4+v3cVxaDIqc9P+ONGdT1G6eXZ8RozDCYti8oNP0o6mgSgTmCKpAma7Gg23O+4Wwg
         ONeQ==
X-Gm-Message-State: ABy/qLZe8SBmUd1FlEbjGn8wQGCi86/tkKE5f8xUwsoMuNTQBT0wSW+N
        JZH1kgeKiecMhOv63p6denM=
X-Google-Smtp-Source: APBJJlHq2Lm3+F6k9MivoIGydF/yhZu/S3lgtq1fxoPlsdCFWRgrMkABOwQpROpeXd/v4xKjcex5xg==
X-Received: by 2002:a17:90b:3c3:b0:268:94b:8d0 with SMTP id go3-20020a17090b03c300b00268094b08d0mr14673309pjb.11.1690880496543;
        Tue, 01 Aug 2023 02:01:36 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:36 -0700 (PDT)
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
Subject: [RFC PATCH v3 1/6] perf sched: sync state char array with the kernel
Date:   Tue,  1 Aug 2023 17:01:19 +0800
Message-Id: <20230801090124.8050-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801090124.8050-1-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
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

update state char array and then remove unused and stale
macros, which are kernel internal representations and not
encouraged to use anymore.

this fix is for old kernels, and we will steer to newly
added symbolic char to report task state but also maintain
compatibility to not break anything.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..c0d0ad18fc76 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -92,23 +92,12 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
+#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
 
 /* task state bitmask, copied from include/linux/sched.h */
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
-#define __TASK_STOPPED		4
-#define __TASK_TRACED		8
-/* in tsk->exit_state */
-#define EXIT_DEAD		16
-#define EXIT_ZOMBIE		32
-#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
-/* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
 
 enum thread_state {
 	THREAD_SLEEPING = 0,
-- 
2.40.1

