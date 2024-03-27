Return-Path: <linux-kernel+bounces-120841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713B88DEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3714B2831C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B712FB33;
	Wed, 27 Mar 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCUCywA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2013B2A4;
	Wed, 27 Mar 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541357; cv=none; b=jFtnTC8XJHz2o8iNJL+7rLQQgKrM7STBMri/LvkaRthhXF09/UGa0Yp238XOI9VHi0PFaunhsv4JjCzFpde+/LzmK3NwMv1FajaZF4fQ2qe+qXHtqg3DJb8r9Oitsi7K+norNPzIyDf+bUSsIBZnWjoK6lm6afZ5eRZr2H49Hco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541357; c=relaxed/simple;
	bh=E4YpkBXBnzo2CgGH9WxHGfOw2b3yRS3+tkRoQhU3p50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGpnfASxX9vYEdMlB9K4fHTj6vMg/3fm45vLliQKtSqUTclQAmOIEpoHdZjoKXHl8iExUIE/23PPMvCKbENmu1lxAXxaKbiYk+UK0wSVH++COrzp24Xsv/oASrxa+HPfh4V8aruNHtewC9AJ7n4bjOACGgy/kiQKCKEniREdICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCUCywA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3622C43601;
	Wed, 27 Mar 2024 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541357;
	bh=E4YpkBXBnzo2CgGH9WxHGfOw2b3yRS3+tkRoQhU3p50=;
	h=From:To:Cc:Subject:Date:From;
	b=FCUCywA0wZ7nOmWqctCDv9JbydwgoK/sXbLZX+dsCh+Yv04gHTKtLmXrtHcWR1re2
	 VsCrtrz136NmwToyvXak1G2Y/VyAD5OV/Bpm15GqCFa6GkvyBhW7NjTF9xz+m9WRyk
	 RaBL9OOZT43CLjkxb/B8003UDNVbMVcAHHEOjjLYQuRYFaDgaXHD2gYhD11+c4yheQ
	 rFS2uSWwMS2+rQbVvxXZmvNEg1oroSGih/1Umj4+OAA1DbgDgKY05hNDxB8AuJG0/9
	 G0IluTx9RWUImB42goz1vnWB4W07UCo2mtHdF3cHxWSOzq1jAzuC1vzrVK0YdAXXm+
	 /ryQhdLosPBAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rostedt@goodmis.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linke li <lilinke99@qq.com>,
	Rabin Vincent <rabin@rab.in>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing/ring-buffer: Fix wait_on_pipe() race" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:09:14 -0400
Message-ID: <20240327120914.2826833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2aa043a55b9a764c9cbde5a8c654eeaaffe224cf Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 12 Mar 2024 08:15:08 -0400
Subject: [PATCH] tracing/ring-buffer: Fix wait_on_pipe() race

When the trace_pipe_raw file is closed, there should be no new readers on
the file descriptor. This is mostly handled with the waking and wait_index
fields of the iterator. But there's still a slight race.

     CPU 0                              CPU 1
     -----                              -----
                                   wait_index++;
   index = wait_index;
                                   ring_buffer_wake_waiters();
   wait_on_pipe()
     ring_buffer_wait();

The ring_buffer_wait() will miss the wakeup from CPU 1. The problem is
that the ring_buffer_wait() needs the logic of:

        prepare_to_wait();
        if (!condition)
                schedule();

Where the missing condition check is the iter->wait_index update.

Have the ring_buffer_wait() take a conditional callback function and a
data parameter that can be used within the wait_event_interruptible() of
the ring_buffer_wait() function.

In wait_on_pipe(), pass a condition function that will check if the
wait_index has been updated, if it has, it will return true to break out
of the wait_event_interruptible() loop.

Create a new field "closed" in the trace_iterator and set it in the
flush() callback before calling ring_buffer_wake_waiters().
This will keep any new readers from waiting on a closed file descriptor.

Have the wait_on_pipe() condition callback also check the closed field.

Change the wait_index field of the trace_iterator to atomic_t. There's no
reason it needs to be 'long' and making it atomic and using
atomic_read_acquire() and atomic_fetch_inc_release() will provide the
necessary memory barriers.

Add a "woken" flag to tracing_buffers_splice_read() to exit the loop after
one more try to fetch data. That is, if it waited for data and something
woke it up, it should try to collect any new data and then exit back to
user space.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240312121703.557950713@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linke li <lilinke99@qq.com>
Cc: Rabin Vincent <rabin@rab.in>
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h  |  3 ++-
 include/linux/trace_events.h |  5 ++++-
 kernel/trace/ring_buffer.c   | 13 ++++++-----
 kernel/trace/trace.c         | 43 ++++++++++++++++++++++++++----------
 4 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 338a33db1577e..dc5ae4e96aee0 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -99,7 +99,8 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 })
 
 typedef bool (*ring_buffer_cond_fn)(void *data);
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
+		     ring_buffer_cond_fn cond, void *data);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
 void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f9..fc6d0af56bb17 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -103,13 +103,16 @@ struct trace_iterator {
 	unsigned int		temp_size;
 	char			*fmt;	/* modified format holder */
 	unsigned int		fmt_size;
-	long			wait_index;
+	atomic_t		wait_index;
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
 
 	cpumask_var_t		started;
 
+	/* Set when the file is closed to prevent new waiters */
+	bool			closed;
+
 	/* it's true when current open file is snapshot */
 	bool			snapshot;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f4c34b7c7e1e7..350607cce8694 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -902,23 +902,26 @@ static bool rb_wait_once(void *data)
  * @buffer: buffer to wait on
  * @cpu: the cpu buffer to wait on
  * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @cond: condition function to break out of wait (NULL to run once)
+ * @data: the data to pass to @cond.
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
  * it will wait for data to be added to a specific cpu buffer.
  */
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
+		     ring_buffer_cond_fn cond, void *data)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct wait_queue_head *waitq;
-	ring_buffer_cond_fn cond;
 	struct rb_irq_work *rbwork;
-	void *data;
 	long once = 0;
 	int ret = 0;
 
-	cond = rb_wait_once;
-	data = &once;
+	if (!cond) {
+		cond = rb_wait_once;
+		data = &once;
+	}
 
 	/*
 	 * Depending on what the caller is waiting for, either any
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9c8983073485..d390fea3a6a52 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1955,15 +1955,36 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+struct pipe_wait {
+	struct trace_iterator		*iter;
+	int				wait_index;
+};
+
+static bool wait_pipe_cond(void *data)
+{
+	struct pipe_wait *pwait = data;
+	struct trace_iterator *iter = pwait->iter;
+
+	if (atomic_read_acquire(&iter->wait_index) != pwait->wait_index)
+		return true;
+
+	return iter->closed;
+}
+
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	struct pipe_wait pwait;
 	int ret;
 
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+	pwait.wait_index = atomic_read_acquire(&iter->wait_index);
+	pwait.iter = iter;
+
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full,
+			       wait_pipe_cond, &pwait);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	/*
@@ -8398,9 +8419,9 @@ static int tracing_buffers_flush(struct file *file, fl_owner_t id)
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	iter->wait_index++;
+	iter->closed = true;
 	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
@@ -8500,6 +8521,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		.spd_release	= buffer_spd_release,
 	};
 	struct buffer_ref *ref;
+	bool woken = false;
 	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
@@ -8573,17 +8595,17 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 	/* did we read anything? */
 	if (!spd.nr_pages) {
-		long wait_index;
 
 		if (ret)
 			goto out;
 
+		if (woken)
+			goto out;
+
 		ret = -EAGAIN;
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		wait_index = READ_ONCE(iter->wait_index);
-
 		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
@@ -8592,10 +8614,8 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if (!tracer_tracing_is_on(iter->tr))
 			goto out;
 
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index != iter->wait_index)
-			goto out;
+		/* Iterate one more time to collect any new data then exit */
+		woken = true;
 
 		goto again;
 	}
@@ -8618,9 +8638,8 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 
 	mutex_lock(&trace_types_lock);
 
-	iter->wait_index++;
 	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
-- 
2.43.0





