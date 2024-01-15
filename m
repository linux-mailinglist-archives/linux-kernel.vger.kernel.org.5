Return-Path: <linux-kernel+bounces-25677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6C82D484
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C683F1C20E97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806C6AA2;
	Mon, 15 Jan 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq4GRdCj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D765689;
	Mon, 15 Jan 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6db82a57c50so139084b3a.2;
        Sun, 14 Jan 2024 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705303397; x=1705908197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DlrDFe5Y9kinmI2EZideUfaxC8SBA39wYnKFZevMC4=;
        b=Zq4GRdCjLOm7sEchNmh0mcQHOS4A9aiqwbcgYazxifGMNe4YsFs8Y7J8SCqhpqhgSM
         FzLy7A1xWQw+Lh6WkH33B+eLZnUJ2O+buGTKOgCHsyMNaDYyc3pwxim8vv37rRGc4tRW
         nBZZuWrOqD/Bt6eOD5FjxpSWEeI45sPscSdOwh/U5BQ/HEAx3J+rDYOyZUu510gWNkqC
         BcwPhxSaZ3acYj/M7O6chnkWzntMPD70Zj6adZqGxjGR9W8JhgxO7br7rOyY3N3wYb/1
         JsBpgim7mwjVCj7IZvAWby3H/FuJRtrnjjFPhnjIjBwCO+Voqg5ttahIVCzvyDBHltxb
         2n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303397; x=1705908197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DlrDFe5Y9kinmI2EZideUfaxC8SBA39wYnKFZevMC4=;
        b=XzHWUavCF26rToFBWs2WIfU5BlRPNk4C3biMj+Gh8D2otj9Otx3rQS0tjxUArLpWpX
         Y12PjUHaWolZYrpr0c5v7ME2kXoYdz4oP2YPTIB+NLO2+RfM1DhkNy2SHc35zau65BAL
         6ismycnN6GrHXeIO6Z3JHHBR595zJgDbcnMpPyXiDjpKjMS5V9tWlC+qr9dkZV2BRQme
         xw48ig84MibxbKdNla5GtbTxylmfjUzei0tghqBIQZJOGv97glcqYrc0AVfXy7eaqoaL
         8c6ehxMTExgaEsna7SaKE6BKraSNn9DmrIQyxmvxomb+j9O9GzpD48WMQfDKWzCXnB5A
         HfHw==
X-Gm-Message-State: AOJu0YxZoCVVTQli7JnKqyPK9Ayp69SfnU3dcLzZwzdjr/F2r7ocxVbM
	m28f0zTmxstM1orBpyeILxE=
X-Google-Smtp-Source: AGHT+IEULegCjFeES6wlLCswi+EwFRbBZqG4OuMyEzjUISfosAI2UtkBU7q70D6rgrdnpD/5+c/sDA==
X-Received: by 2002:a05:6a21:1a4:b0:19a:757f:2db5 with SMTP id le36-20020a056a2101a400b0019a757f2db5mr2012329pzb.8.1705303397599;
        Sun, 14 Jan 2024 23:23:17 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.googlemail.com with ESMTPSA id mp13-20020a170902fd0d00b001d4ac8ac969sm6990545plb.275.2024.01.14.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:23:17 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH 1/4] perf sched: Sync state char array with the kernel
Date: Mon, 15 Jan 2024 02:23:03 -0500
Message-ID: <20240115072306.303993-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115072306.303993-1-zegao@tencent.com>
References: <20240115072306.303993-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update state char array to match the latest kernel definitions and
remove unused state mapping macros.

Note this is the preparing patch for get rid of the way to parse
process state from raw bitmask value. Instead we are going to
parse it from the recorded tracepoint print format, and this change
marks why we're doing it.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index dd6065afbbaf..ced6fffe8110 100644
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


