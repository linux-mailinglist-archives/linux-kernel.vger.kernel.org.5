Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66BF76E341
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjHCIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjHCIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:36:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248723C31;
        Thu,  3 Aug 2023 01:34:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b91c2744so481121b3a.0;
        Thu, 03 Aug 2023 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051675; x=1691656475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzdBr4YE6+e2aCPihxyG1VP6AlkYIgUBNXtEC6jGkqA=;
        b=Y/9r8JJKfyClJG9K8FJm7KPjugSxpks8rCNhdwQOcJ/bv6c8+pq3lK1IGeChGXO2LC
         pi3sH0DN49vBEdT3Qsn6L3k7bSFjv45LF32+NLCeRjTucTTcel6FNw6g4Jf1HIPX/Byh
         CFPwads8yzANusFzRsqrcp27YQlhFSCVP5tt1F7ywMOWKqRZA3T1GHLOuCt/Vodga/mc
         +OGFmPsQHN+3DHmzldqn5nYkzEAv4BpH2ReuCijEBmP7XjPi3iEwm3SSh7uEDwWSvO3Z
         gMRmxZJVK+ePNtOwjYugvmX3+8FoHs7WFHenPW/eFPImn5eDtu4qcJN3QTr6B0nuxHvF
         bYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051675; x=1691656475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzdBr4YE6+e2aCPihxyG1VP6AlkYIgUBNXtEC6jGkqA=;
        b=QN+XxRPsEHEipReA3y+RX6zVTq2/ihrkm0k65yztcS5nZIdmijhdTjMTaQM6It9Lw1
         E1W0UUe/pO3RfhoEbVCqdtxRqWWjVGy7mGDjChveeSHICtOdacRbwLHil5JBmbZtASdO
         NWR3tvL4W7cUthaYQ66uL2VckgTTNAaYEsbxnol2sm/D28nE8j/skJcmp6JXJ3pwIdDp
         u2C3RiuLe+BfcXGEznLgmDp+BcSPf0yXjNy4OtUjuf1SvF762MjGql+XbE6mCTDyAt/P
         ZEBKi7Ii+kxPy6v7Cu5Bs2ul4mYQUwExUQa9Xhg0qGHr+yiia9JGmfemYfawNuMiotzS
         kSAg==
X-Gm-Message-State: ABy/qLZ81Il02Zfit6KrJC2RY7F9Q7duPWA2s2ixeVS/bp1P0Pm1Xs0l
        SI/lce4vYpJ+aHIR7GekimI=
X-Google-Smtp-Source: APBJJlEGFiyYR2dnywruAdKluQmnlzdmdALjAj927Ka8hbWWQiJM/D7yXi/2t+xwAdwtSeQEt4rHLA==
X-Received: by 2002:a05:6a00:15d6:b0:682:a62a:ec36 with SMTP id o22-20020a056a0015d600b00682a62aec36mr22266054pfu.15.1691051675648;
        Thu, 03 Aug 2023 01:34:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm12541876pgf.91.2023.08.03.01.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:34:35 -0700 (PDT)
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
Date:   Thu,  3 Aug 2023 04:33:48 -0400
Message-ID: <20230803083352.1585-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803083352.1585-1-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
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

Update state char array and then remove unused and stale
macros, which are kernel internal representations and not
encouraged to use anymore.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9ab300b6f131..8dc8f071721c 100644
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
2.41.0

