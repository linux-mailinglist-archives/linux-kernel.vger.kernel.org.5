Return-Path: <linux-kernel+bounces-69227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257DB8585F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1F71F24719
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55B13540F;
	Fri, 16 Feb 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="X8qngnjZ"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0577F05
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110315; cv=none; b=EBKHK52G09MplzFka5wvgpy+a19hrT+UjMGtUcb3xce3HSAgaDmksU9CkILI//wP3GkS0SEWnjecmr6kOWU/LENkdFTB2hADtGCueUS/VKGnOPvVCJzmrWtAyO/VF1hBuqcqh92/qrQESnkbpZjhLMwyy4KNyPNuqQZ5uKV5R30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110315; c=relaxed/simple;
	bh=/CdKXp/M0IoZ35hcQEsRX21/nqp6k3E+d9PhAK6qvWM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ubflAlgVbqw95H5lio7v4wIls8AJQ75EuW854R/izcHd9pXS+ehJ6ljXKUCYA1N8rvE9RDssU7tpOpHsJiEovDHaj3DMg3ohsh3UZCjcq3dXhG6AljppfOoNRo/xwOkS0gEM9M25fdUj+vfPB0fL8j+Y24A7uKPCMUDn4La8OXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=X8qngnjZ; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708110004;
	bh=tnXXBc9Dk9zk7+Jx65RRNfhiBjugPoxHOwEKCCZqCk4=;
	h=From:To:Cc:Subject:Date;
	b=X8qngnjZoBF5u5759OHcd3yi6Fg1ZPbr3Bx9B7zpGGg2hSjBrWK0GrqeKFmBHfowu
	 3NQACBS2DcLK705NkmOl8H+G3KdWF9LRnS9YvdgixEhMcNG/qQrBpd0lxOeCAXznyO
	 ABSVucae6HftGVnh01ZOf7xz8NVOYVwNHx71P7+E=
Received: from localhost.localdomain ([2409:8a60:2a63:47a0:34af:c8ac:3595:9c10])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 1BA45; Sat, 17 Feb 2024 03:00:00 +0800
X-QQ-mid: xmsmtpt1708110000txpy65wqo
Message-ID: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
X-QQ-XMAILINFO: MdIvn1KXX/GIZaBqqhfY5ZNopXF6lFNATki9PxNHb1s0aqdSaXmHESGehNahBx
	 fvLc2ueJ32JX/nmq2Cg78kEyZZS3UfagYnaTbOc22pjVzu7S+6wJ4FzisZYqIpM2+G5aZ9w+v7ce
	 vfdUWGq1NQwWpwvdgvzA40qfEKJI0wy0HXt6XN/83B8O5YUCVcfNlGuEsW8Myt1nEwp6AHn/8aNm
	 YyLI3xjbMZp9d+hpmAYz1SPJoQIYt3tDrAbJ5u74+dSHfFIekue6PFa5xugw7S+a2Y/+U9OvuF3w
	 Zkdatxzvx6gtPTUvKAxMoll23mEw0oFcl4ZkiDvBV5VBa7XzqZ6E3xUmZloGFRu3Iq8Fsbxd1nSV
	 7zDaJtimT9jNeT3s8av6gUxOyGYlLN7wU7VxPYI71uzLTHfj4XimKeidRtYdl5zC6Z0n/ylOcJ4P
	 4zir20b1vpBFhVkrZk6Ssdn7AIE4X7We6gXHYJHAO4TIsxplPGgjoHpHNJ73lohIVpOG9czEAKdr
	 iDtRF+P3/+sbW3ZureR3map+rifPyanpXeQwJJ7UAzizzPMuxlMqeyz8vnenZgUEYpQy/yjOlSpO
	 qJyU12xSV43XBoUeS7aYpbp8yPtUWrnCHhMO4BmM8oqVIsNHCnrgIzp0rt3K0YbJKGNLKwSBP62e
	 bgxMAvHsMgu0ztRcby1LqqRV5G9Yw2jmKANEuem4dvvsod7xLptaOQpbdFPcIiHvicMpQYf6HiiE
	 1n+BNShPiqnqgxYvMGdK0P9BTEBn3o+PKLm3+3A73OGmZzw/JZ+m3wgmycXBjSn326D1Ex1xStDK
	 BU/VUbaoaAXDAWij2hE0naFkYgdVqISocd4aQRirlV+Oh7kgpEX7ENhZrmrblkI4t/hfPSZ5PT55
	 +n60dep3xxW7tPzv4PC37yxVdzmy7v5Yr2QuXGcZwMW5grd9Uuj+m58WKvutNTxwe7CjEZMQEhrQ
	 tAgxi3U7ELfAXgpCEQbQEYJgtljn6P9Eb6ghQQTmCI429KRoP5Z7UKtwYho1/A0Ie17mgwcY54KR
	 3PQazk/g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Subject: [PATCH] coredump debugging: add a tracepoint to report the coredumping
Date: Sat, 17 Feb 2024 02:59:47 +0800
X-OQ-MSGID: <20240216185947.352535-1-wenyang.linux@foxmail.com>
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

Add the new trace_sched_process_coredump() into coredump_task_exit(),
this way a user-space monitor could easily wait for the exits and
potentially make some preparations in advance.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/sched.h | 7 +++++++
 kernel/exit.c                | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..ce7448065986 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -334,6 +334,13 @@ DEFINE_EVENT(sched_process_template, sched_process_exit,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
 
+/*
+ * Tracepoint for a task coredumping:
+ */
+DEFINE_EVENT(sched_process_template, sched_process_coredump,
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
+
 /*
  * Tracepoint for waiting on task to unschedule:
  */
diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..c11e12d73f4e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -425,6 +425,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 			self.next = xchg(&core_state->dumper.next, &self);
 		else
 			self.task = NULL;
+		trace_sched_process_coredump(tsk);
 		/*
 		 * Implies mb(), the result of xchg() must be visible
 		 * to core_state->dumper.
-- 
2.25.1


