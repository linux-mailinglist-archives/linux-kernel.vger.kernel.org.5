Return-Path: <linux-kernel+bounces-56572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CE84CBD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9127D1F22EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52097F46F;
	Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJVAYK/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeaaC2Sa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A77C08C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313283; cv=none; b=ePSyF8JRSfQkQjo+27qk0w/KqJUuAXkcg/2QyDtLFkJ+wrLCUhgB1GhYrHW1JguwZmIww95oj6SpivIBDxzSA5e6DA6/sjj9jF4lgr5dW7WKO3JE/6JvUd/nHR9sZE8OvwQ/ZtW3+bmmICsl521dTYO5z8hMK34yhTFim9TM57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313283; c=relaxed/simple;
	bh=Bn8TIXFNy3nrR6EMlKeOogQoD3nNIaQmPzKytNHWvfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQbX/6WSTR4KHKb5BzR+eRq1oeT/cReYJNjVmCnGiAdiyFvbdL8iB9ZxGnEn/JxUnOUQnpt0k/w4fpzsu5LKCAcZeea1445zPAn7UlywwiYAEPDidL64cNDGqjcBjhUrf/FAj3KvJmL456n7lxBNUPA3WPRPJubcLNaasEa3Z3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJVAYK/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeaaC2Sa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cOMblqM1UqBk6IDY0+aDtpsYhEPmwBpENMB0j8kk28=;
	b=MJVAYK/8B8rWBhPLduCIXQaBtKp9vcnlN9io5mD5r2rJxwFngbFDMi/th0WOB1+9Vz/hpa
	IVmVjklkR8lOyIRxbqBZ+sShA2MavoAVu3yb4sJv9HVG9rGQIIVYxVW1Fs3Y9lOIaOJ+dp
	4ojca3GCz4a755r4SevT3vT9Xj96UcVWOLq9kDCXjnXYY5qI/dQrFsyfn+WxFEpHUKSEDi
	nkEFwjdnH18wwJvtBKeJU3dXBXtACBjlBpvFJVjvXmlsDV7wAJlJSHJikzWI9ROv3padVj
	HqBN+zcZ7KXYoQQHksqEbn+xx07Z/+Frfcr7SdRYICmDKNI5UOnhv9DfAh+ucg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cOMblqM1UqBk6IDY0+aDtpsYhEPmwBpENMB0j8kk28=;
	b=VeaaC2SaSkOlJC7NiQORzUvNwmblPlIYafvBsfBZW5GZJyphx67eE865Bel0XHeYayVX0F
	wSO8A8uUFhEKEzAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 10/14] printk: ringbuffer: Skip non-finalized records in panic
Date: Wed,  7 Feb 2024 14:46:59 +0106
Message-Id: <20240207134103.1357162-11-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Normally a reader will stop once reaching a non-finalized
record. However, when a panic happens, writers from other CPUs
(or an interrupted context on the panic CPU) may have been
writing a record and were unable to finalize it. The panic CPU
will reserve/commit/finalize its panic records, but these will
be located after the non-finalized records. This results in
panic() not flushing the panic messages.

Extend _prb_read_valid() to skip over non-finalized records if
on the panic CPU.

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 24b484c221e8..88e8f3a61922 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2099,6 +2099,10 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
  *
  * On failure @seq is updated to a record that is not yet available to the
  * reader, but it will be the next record available to the reader.
+ *
+ * Note: When the current CPU is in panic, this function will skip over any
+ *       non-existent/non-finalized records in order to allow the panic CPU
+ *       to print any and all records that have been finalized.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2121,8 +2125,28 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			(*seq)++;
 
 		} else {
-			/* Non-existent/non-finalized record. Must stop. */
-			return false;
+			/*
+			 * Non-existent/non-finalized record. Must stop.
+			 *
+			 * For panic situations it cannot be expected that
+			 * non-finalized records will become finalized. But
+			 * there may be other finalized records beyond that
+			 * need to be printed for a panic situation. If this
+			 * is the panic CPU, skip this
+			 * non-existent/non-finalized record unless it is
+			 * at or beyond the head, in which case it is not
+			 * possible to continue.
+			 *
+			 * Note that new messages printed on panic CPU are
+			 * finalized when we are here. The only exception
+			 * might be the last message without trailing newline.
+			 * But it would have the sequence number returned
+			 * by "prb_next_reserve_seq() - 1".
+			 */
+			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+				(*seq)++;
+			else
+				return false;
 		}
 	}
 
-- 
2.39.2


