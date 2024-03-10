Return-Path: <linux-kernel+bounces-98123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11B877568
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0442C1C210B8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88D10A0E;
	Sun, 10 Mar 2024 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UWa+EZgO"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECC1FA5
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710048362; cv=none; b=b8PsrMSAJfTvlSsmXKtV5QKLurxrVU1kaW0BUA5hL08TY164YuCRAds1GZ26NWxYMu3ey70onfaMXuAkqhWgVc/VCSDEP6Sjpj4KkRYNLOQkQiSkQTp+Pbtri6GG/BE9W7O9zf4tyNi5SP7wQ3lmG8Tuuj+RFlhxvXDULKF5stE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710048362; c=relaxed/simple;
	bh=f2BLX5fET0RUFWfLQGHErQZOtiUviwwQTOr1HfZUlKw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BF2vx3lUunDKHaylLVX0dN15eeB1KaS1PLgp6NSB/oSXNf2FNRWUQrOn72p5jOC2LNB2ZE3tn7eCH/cEO3IGO9+LRkHemE2XrevF2c8OUWmVI59Z0bMQmaFetlqvL5wrj3uA9A0DiiHzZERForVETUW+O2WL+flnpPoynl6RxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UWa+EZgO; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710048356;
	bh=RFbrlE8bKyXh1wQvXS2b2V9UYhLWFs0ZKai1mg42aZ4=;
	h=From:To:Cc:Subject:Date;
	b=UWa+EZgO8D9bxIDkhObskjHv8DS3nw0FRYNYX6e2pNFLSX/vXVfUIcBOwoDgskqPp
	 1Juc2ak8IX7Vr+2izm5DPw1+CH7qvr/25VzEx1dOCb83RaXS5kHDz4pmqU+YdE4Jgr
	 4t5+WGnNQkvQ02VQZ6ZNCCtbLeFKJ43meikDaRRQ=
Received: from localhost.localdomain ([2409:8a60:2a60:3eb0:f685:8358:c9e1:8bef])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 6749F8FA; Sun, 10 Mar 2024 13:25:52 +0800
X-QQ-mid: xmsmtpt1710048352t52ifyxyr
Message-ID: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6IKq8JVkXKogtJegkw40HF9lvXESOQ0BxLnK52Kp4sM5WW2TBL+
	 StaxctsMbu1tcZoVstbdkxpckc9j9ZUoJSidPHv9Tkq7U/KveKhM4Q3majfdDgY+KZQFUDfTRcZl
	 wOPiMg4E8SnSwZK30O2sTXmguFMTWgZrlxF0y2/8SP3fKEhFr6zAe47XQwkByagoYiLz4JFqbKzm
	 2RFts/KWPZ0z85khLZAnfWeSRGPpGESkg4gqqOHCvrYgDb74eAMu49uIrfTC9PuJKCE3eplj4Nff
	 P0d5f3ioXEOdSVoeI/Pthbt5IZIv8fsMBLUXt2g5E/X4e/2rF/a/ruR/KVSZJqvbNLPUSMaPK3Xp
	 IUkqzJUyEUtpxkvqHrzaLXuPH/UYpiV4PgGl9r2k8HVjHGv2yuZZgzyv1xfLZZLQ6SLkYki+Zx84
	 JRaYlN0D6Mg/3Nfa/IUsRlq/V6MtHNjsx6pV/u8U0lUcwjZUDfayiMFWPTs2zGPRGWUDgxJAf0y5
	 shmlu+7WLuUG9Ky+X7VTmJdJio64W2DOU8elFEPWuuYOKC6rrUy6fWR6ykL23l+ePZTJgnBEgoUA
	 dAqqon+LG8Rrg4lXY1K5IMCqOBvVaLFud1ur8BY1yI8yKlWd610d4uzjjSZtsJN7zdqX4w12C6OI
	 GL+josLCiq5RByb3an2q1aeezSzDbZxE4pyJ+iufLQbs+fa9Rdh8qm/wFeMlQgI+iB4eXl1xk/oA
	 WYshM5JqwtRKUBn0MPbQipSK7WRmFlz5q3Lc1m5tgS8IRH1US7ov1OEvxpcYbp9UJLtSwzsevP4w
	 hSbuWAKX5A2p/jIEAxZigriygS7d1PnzDVY6TU+sTMDK+J7EfLG+VIh5DvtmNj3rj0/BJiY4Mkxe
	 Mi4dochRoHIG2Ljubrge4z7/1XfIpH7sjzaB1UAZca2fwMPvNCkVIMyj3KZNjI39sz5EWVljWYra
	 ykfKlIKdZtebdhjDsRuwBwKuiqIOLlQ6bbJrKaBdIvXD+G/tgvgRhDA7XIKGam65NqUfWLkoPc2B
	 5Noly/6gEEAv7BG5Eln8/K+1qq7nY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Subject: [PATCH v3] exit: move trace_sched_process_exit earlier in do_exit()
Date: Sun, 10 Mar 2024 13:25:29 +0800
X-OQ-MSGID: <20240310052529.294895-1-wenyang.linux@foxmail.com>
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

Move trace_sched_process_exit() earlier in do_exit().
This way a user-space monitor could detect the exits and
potentially make some preparations in advance.

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
: fine by me.

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


