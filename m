Return-Path: <linux-kernel+bounces-78605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2388615B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620991C24153
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374782D7A;
	Fri, 23 Feb 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PbWbSYuq"
Received: from out203-205-251-85.mail.qq.com (out203-205-251-85.mail.qq.com [203.205.251.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4281ADA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701913; cv=none; b=DdIxahrmw/h0uQP7Hdic9buCah1eKXaBnjzfyR1yzGGMrwiZKhX/ObsKbcehvtE6dh7YjTULs9GnnUBVacY4N43cUlt3cf4dGM0bXcMPGEUeg4+W7rutK9StVZ0TgzWvQfB1YIMbe+Ry2tD/TMkQDPgMDkPPYPHgUJ+qVksau5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701913; c=relaxed/simple;
	bh=3mPRgvG/sxlIoXBUhas58x8E5T3hKihVno9gegRRSsY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qBwDMWL4jYRf8ATBA/wVToGOrLELIJnsn8rLf76jH2o4LY+jAvY+zqQ3aqpcTI6c3aMa0CfTFBKHqENaUmazA4PG/ASG8xMcyxA24QjFRySK5/tEa7XEzCK9c2e0OlXqqyZTHqoFf1cqY9ZjfF740oa0UR1gIFj0/P2xP3Lg63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PbWbSYuq; arc=none smtp.client-ip=203.205.251.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708701601;
	bh=1WtJEn9rrkVa/bjSgot6IPYIwTbNxSH5b4RJzV2SbPE=;
	h=From:To:Cc:Subject:Date;
	b=PbWbSYuqlkBXsfDanbDbc6IW/dpS96uAXWpwOnj5uSCygcD+0HJU9Eg+P6SSpf4Mm
	 XjEAY8H2vGKBJS/kzhkleXYP+aglgcXbdLFz5z6ccUMbzyoPjEMfRaxKF0nPmOdBW/
	 0pRLpoFaICWFVX7IkUUAzXVC/Pf+H7MYKYx2tmNs=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:a0ce:972d:4d86:c925])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 364A3425; Fri, 23 Feb 2024 23:13:36 +0800
X-QQ-mid: xmsmtpt1708701216t4yxx0qhx
Message-ID: <tencent_20932DE952CC4B7E12CF2E5530D45641BF08@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJsKXaiJczxah/ErLlkAIfv+v45KbXjJkbrauQ89wGaYTDPJQt3B
	 CpQa3hygeMYYxieIkL4Z/5vgF9iqqu0HZ2DIHlJ3jJz0jcCaaxq19SJXdkwNPOJgSAVbnle13oHa
	 pMNJC10cwDm8VpNI/OXyG9PhMgC55uj2kw9PyxkO0t/C/f7EC0agMB7lQSVKWXQuHkiAtVmYTS9D
	 SF40Dls/ZG3wY0jHKwGgsRyu7b77GHPAF8QJ3BMMtqdYVgMMhufnwHN1OYvMigUMcHyBIgo22vSr
	 729Va2mCC1Uy+VIZm4h38zCAiynnKJUQMjatXVGwHhU6yChX6twMNUBHowDakBMnDiwigbihW6Rx
	 BPQGfA9N28vF30GsGWe1DWL8/iHqfnMwjQVSKFwnYa0f0MhQAFGe4b5mg0zCHYtFOZ+8HNqjO5mp
	 2vpXEorj65a5KhCvmpGdVBtQRTliuMk1gFVBskeEQBMAi6ItF/WXQi6ymspWxrr+TODUMRf1g99T
	 OREBcqTSbPoz1c9CiPvY630CfUqRxWXJbW9deEmKSpQzRY+YwCUwnbM449s6Y1uNV/DkIHBkxGN7
	 MEL+eaExaCV/uNbJ02T8OVO3YAWLollHF0seqDw37WQvkII5zssIeIeTbwsgO1IcUuUr9/ci8aII
	 RAraSRc8pw9XI9xWHto1Bg2gQ4y03LReWYLyUKf6fnQIlnzRKl68sp4MFIb0gdpipKbkR/3smbs/
	 RXOOUFBTQg7GFVeBWL0s0j/ll6h3lYYlB00qfov8y/Y37wzHtAEfG9brY29DeALVklaM34ie/APg
	 zS96DAVbQFVQHDnM38ycKL4iRv0oJN9WAcDO4UOyoVNTRptcEN0emLpoRZSBt+YRXvT7e6/hPx6h
	 ATttHaGbqpSWfi700fuJppiOfG387Z70aPQkNpSLe7GEmg18ZNbLiyGxxdNlMOXvxbFquk83U6cT
	 CQE6McgfjpWN0lzeBx56ad/8KxHMPBWqipY5VTBGqfXbebcb+KK/W3cXKdAiVFN6DktdMVU3QA0t
	 5lmH1936FTJ7//App/xI7I9oSl3msAYRvhaVC3iw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] exit: add exit_code to trace_sched_process_exit and move it earlier in do_exit()
Date: Fri, 23 Feb 2024 23:13:32 +0800
X-OQ-MSGID: <20240223151332.388253-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Currently coredump_task_exit() takes some time to wait for the generation
of the dump file. But if the user-space wants to receive a notification
as soon as possible it maybe inconvenient.

Add exit_code to the TP trace_sched_process_exit() and move it earlier in
do_exit(). This way a user-space monitor could detect the exits and
potentially make some preparations in advance.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
 kernel/exit.c                |  2 +-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..c2e8655fd453 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -330,9 +330,31 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
 /*
  * Tracepoint for a task exiting:
  */
-DEFINE_EVENT(sched_process_template, sched_process_exit,
-	     TP_PROTO(struct task_struct *p),
-	     TP_ARGS(p));
+TRACE_EVENT(sched_process_exit,
+
+	TP_PROTO(struct task_struct *task, long code),
+
+	TP_ARGS(task, code),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	prio			)
+		__field(	long,	code			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->pid		= task->pid;
+		__entry->prio		= task->prio;
+		__entry->code		= code;
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d exit_code=0x%lx",
+		  __entry->comm, __entry->pid, __entry->prio,
+		  __entry->code)
+);
+
 
 /*
  * Tracepoint for waiting on task to unschedule:
diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..48b6ed7f7760 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(tsk->plug);
 
+	trace_sched_process_exit(tsk, code);
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
@@ -866,7 +867,6 @@ void __noreturn do_exit(long code)
 
 	if (group_dead)
 		acct_process();
-	trace_sched_process_exit(tsk);
 
 	exit_sem(tsk);
 	exit_shm(tsk);
-- 
2.25.1


