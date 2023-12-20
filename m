Return-Path: <linux-kernel+bounces-6938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF39819F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78D02873B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9425560;
	Wed, 20 Dec 2023 13:09:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96802D628;
	Wed, 20 Dec 2023 13:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B878C433C8;
	Wed, 20 Dec 2023 13:09:28 +0000 (UTC)
Date: Wed, 20 Dec 2023 08:10:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] ring-buffer: Remove stale comment from ring_buffer_size()
Message-ID: <20231220081028.7cd7e8e2@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It's been 11 years since the ring_buffer_size() function was updated to
use the nr_pages from the buffer->buffers[cpu] structure instead of using
the buffer->nr_pages that no longer exists.

The comment in the code is more of what a change log should have and is
pretty much useless for development. It's saying how things worked back in
2012 that bares no purpose on today's code. Remove it.

Link: https://lore.kernel.org/linux-trace-kernel/84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com/

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 ------
 1 file changed, 6 deletions(-)

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
 
-- 
2.42.0


