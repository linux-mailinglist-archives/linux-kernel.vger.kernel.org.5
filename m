Return-Path: <linux-kernel+bounces-125579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0F8928F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FF1283763
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9D1C3E;
	Sat, 30 Mar 2024 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XihWC/Ge"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA917F7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711767485; cv=none; b=gKK/HC1phNW/6ITVpHE1Hu7qbVOMXUna3sskBrx9aBtbkgCcMXFlt5Jio3eIdW2QAo/qyhX81meQuEYcn8BtdCOyOZz/OCqPawmtTv+WccWw5OfqIC7v0gAHNzQHT05M8KYxPX+pIETQr32UkkXIa9ijAicgisCjrQ71/9kmfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711767485; c=relaxed/simple;
	bh=yyAknnVqKxohGK+KrJ3yOl5wmEkvrLxbcEXMSH+FrfY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=sRMwFYoZlxhZKiAfCFalKqqxqdTZ9P9g172BXeosrIhdq/FvvFwpVKxzACbxDmDH76y4wjXV5UxT2awrViHeho7/apZ8bpCj0IPQU5COQ2VMzE2rBzeYnYGurtHGsIfvg7Kv4KCAoYuXjwyiatZVG10vlZE589IeYMWN7dP1nTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XihWC/Ge; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1711767172;
	bh=EXPUwh1d3Voi90zGxvN8KSRJq65yqe9XRz36Pr3b6U0=;
	h=From:To:Cc:Subject:Date;
	b=XihWC/GeXTugN/JDkeKtflwBI5lvGA9gpDZzUzZz7VPYRgINFehUsmHRCXUg1hs0l
	 GBeVCMxxDzsBc4gzJn4JnX0cxkzNUJz9nA7qsS11tXsR7hJ9MYr4HI5wOUl/njjKs1
	 pGHSqRIuAcRW/N5+NhkIsJe56Ky+wuLmF1PYkkcU=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:2bc5:23:a538:a92d])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id D30B74EA; Sat, 30 Mar 2024 10:52:48 +0800
X-QQ-mid: xmsmtpt1711767168t49z78gv4
Message-ID: <tencent_F5D82FE0B9A0CA9C3A29C866F225FD915905@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQx/vARoscgH4fTTbuGuf0i6FMa1PYcFwwoXfwOY1EGnDYsiVMbR
	 jbMjeqUjO9LitptjUOMh54ruvgYTiSttk6wF6vrekHVdKxeYm+9CaK8SGjCgYDbZ2/czqRoO6IpQ
	 R7UlUkS2BxPwEAuImYiq5/u8voAB3a7yG6JyxXGE5tijertZPS8GiCrtz+Pspn1Mcn81arwMDG1N
	 ROCLmlQeTr9Wdn2jaEbydo+wgXFUPogx9SxVdVSeAUfoiTJFV/1WpkFcR3/PHN08GDrPM0LOVSFn
	 GiEIpf88LcAfoBzzxKUKCxLb+dfZVsnHc4IWzCqOL/HolzqDI49ophrEVHE9/yFk5EcnKjm8hZdb
	 2IZ4NsvEInfjOAvLgUtLBQMbCN3TQfvk7BEgpZ5F8p49TcQxbVLKMmz+gR8NDelMrwQP6owhPvud
	 YDOa0jbANovwY16oAIJlPY1EZkx5xJ/tFaYuIHFQ6b6H65Ivc5b31fwi6dIp2kCNi3afz/TlxPI/
	 C9BRoYMCjnyJ5+mEaB+7fu+l4851bjRjYjAcMlPmMv1n5gnvtDwS1B0Te5l8sSgpSAxcazYxn67p
	 PG0XISHY075gTNDIhl3B0ZU3M+9yVz0977SCmJdxe7SBYytvhBX286EsnhZ9LojonJ+YGI4sZCJ/
	 r+0b9VkncQw8WCnwB7TCa72ump+HRcbZ+uoXMGQ1MYVZus5+NKY1o0LQHlSXzrTd8lumPKGFmpB/
	 q2lh8D7fcWYwGt5cJvzQ+MGqGAovvtC72Ci8Ic7JxvTpbTYE+VclwbMExyF9IrMPzFlprX7DOJnr
	 pDR0ttpk613DGCUDsaGpRH4LwNrSwXuIe3HHBqsqxor/a9NbqgBp4t5cBt9l7mUlCyv4/lFCuPO5
	 LWhml432qHq6gZ1uxMWUay5xWqc19oPHRPEnqRPwz76PozM8n97qiliS8ZJ1WtDi+npzm2Hb37/E
	 gjGVmuM2Eu5fjsTmSgmyF3F2Akg5JbMuCXuRHC72iqHIM5kBPrBgswWU3PVxaPEBMp6znq4v9mzG
	 N0oHqhcgr2E83qFJv1Qo/e7QU3PO0=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: wenyang.linux@foxmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] exit: move trace_sched_process_exit earlier in do_exit()
Date: Sat, 30 Mar 2024 10:52:38 +0800
X-OQ-MSGID: <20240330025238.7102-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

In a safety critical system, when some processes exit abnormally,
it is hoped that prompt information can be reported to the monitor
as soon as possible.

Commit 2d4bcf886e42 ("exit: Remove profile_task_exit & profile_munmap")
simplified the code, but also removed profile_task_exit(), which may
prevent third-party kernel modules from detecting process exits timely.

Compared to adding an extra tracking point, it is better to move the
existing trace_sched_process_exit() earlier in do_exit(), since any tracer
interested in knowing the point where a task is really reclaimed is
trace_sched_process_free() called from delayed_put_task_struct().[1]

Andrew raised a concern:
If userspace is awaiting this notification to say "it's now OK to read
the dump file" then it could break things?
The nearby proc_exit_connector() can be used for this purpose. But we
couldn't find any specific code that concerns the location of
trace_sched_process_exit().

Oleg initially proposed this suggestion, and Steven further provided some
detailed suggestions, and Mathieu carefully checked the historical code
and said:
: I've checked with Matthew Khouzam (maintainer of Trace Compass)
: which care about this tracepoint, and we have not identified any
: significant impact of moving it on its model of the scheduler, other
: than slightly changing its timing.
: I've also checked quickly in lttng-analyses and have not found
: any code that care about its specific placement.
: So I would say go ahead and move it earlier in do_exit(), it's
: fine by me. [2]

[1]: https://lore.kernel.org/all/c411eda5-5378-4511-bea3-d1566174c8c7@efficios.com/
[2]: https://lore.kernel.org/all/c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com/

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..2cff6533cb39 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(tsk->plug);
 
+	trace_sched_process_exit(tsk);
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


