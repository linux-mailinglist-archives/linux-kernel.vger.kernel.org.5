Return-Path: <linux-kernel+bounces-22474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5493829E31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF4289508
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA14C62E;
	Wed, 10 Jan 2024 16:06:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1D4BA89
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEE7C433F1;
	Wed, 10 Jan 2024 16:06:16 +0000 (UTC)
Date: Wed, 10 Jan 2024 11:07:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 David Laight <David.Laight@ACULAB.COM>
Subject: [for-next][PATCH] ring-buffer: Remove stale comment from
 ring_buffer_size()
Message-ID: <20240110110716.02074fc6@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Found this sitting it patchwork and never pulled it in.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 25742aeb135c4a44e92fb347e037adaa145b9484


Steven Rostedt (Google) (1):
      ring-buffer: Remove stale comment from ring_buffer_size()

----
 kernel/trace/ring_buffer.c | 6 ------
 1 file changed, 6 deletions(-)
---------------------------
commit 25742aeb135c4a44e92fb347e037adaa145b9484
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Wed Dec 20 08:10:28 2023 -0500

    ring-buffer: Remove stale comment from ring_buffer_size()
    
    It's been 11 years since the ring_buffer_size() function was updated to
    use the nr_pages from the buffer->buffers[cpu] structure instead of using
    the buffer->nr_pages that no longer exists.
    
    The comment in the code is more of what a change log should have and is
    pretty much useless for development. It's saying how things worked back in
    2012 that bares no purpose on today's code. Remove it.
    
    Link: https://lore.kernel.org/linux-trace-kernel/84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com/
    Link: https://lore.kernel.org/linux-trace-kernel/20231220081028.7cd7e8e2@gandalf.local.home
    
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Reported-by: David Laight <David.Laight@ACULAB.COM>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 173d2595ce2d..7887d61d5b56 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5122,12 +5122,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
  */
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 {
-	/*
-	 * Earlier, this method returned
-	 *	buffer->subbuf_size * buffer->nr_pages
-	 * Since the nr_pages field is now removed, we have converted this to
-	 * return the per cpu buffer value.
-	 */
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 

