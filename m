Return-Path: <linux-kernel+bounces-70502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E368598BB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9832E1C20F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE26F539;
	Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUvH6ld6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mv3bI0iZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5766F09C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282674; cv=none; b=MrjfjejcyY12hoSJfICLYJEu1AXyJNGesjG6UCW+xUJTpm4HhSJGEThYqIyUoSlARYtlLqtH4hPldujSqoouE1T9/0M1kkrlxl/+3CzMZQnlDXqKnckVU59I3TFdA3qMiQ31rOSTd+aIQf7PXqW+atlv6YMo70MXs83plAhaxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282674; c=relaxed/simple;
	bh=vTgd2itv2WvqWfA2iHd5zEucMOb4GN4MKZQhbctg1CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+GfE/DmQ815XkHAIHAxqPE524y93tsrHQJ8lD8lnjKSwa7+5b6UtBpNCxafjwJf7sjMnOiaT7SE+ZpaWohlM/oK0BR9BSF9dMiOGndbtvLuk2ERdTFnbfks17SOp3hCYAcnk562lnwKIF/c3p6llGoXjy7dDiZ4VFk6KO405sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUvH6ld6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mv3bI0iZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I1dHuUwYQfwJlbzcngwYe/b4Lctrl7m0BYdiHEdADM=;
	b=bUvH6ld6ZR2Lx7Xmdigmcn4lgfr2aDNvw4v/80RT0CXEAcaNRMKHc5jHO6u4d7wjSu/kLh
	xfbiIRlZLFennUA4anuz4ogw5nxq3uoQNdSr4AS9EpdIyuAyE6bm6xHKI8lP6pZSj0asaV
	jce8Tfn5LLyr7LDy4vYkcEfHQjv+rYzyi82pYP5oOd880wpNfwKafO0sh/KGE7/4hDp/CQ
	hAUPlz1qdkP9mi6CtrcL5wxhCsaz97b9WRlh33kGjePhNUgcYigxSKYU/xMeunxgaSt3Xo
	s3kOkTkSe7ie8C3PBR2rawdtpVOBYFIa9jCMKt4A3p5z5prM65E5vTdN5ubQkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I1dHuUwYQfwJlbzcngwYe/b4Lctrl7m0BYdiHEdADM=;
	b=mv3bI0iZRBTmcWWJ3oT7jB7zGmwIkGzso/mTLeCK3sGCyUsHPvlz6U4660FUqUbnlE82tO
	7rxsKqaEcP+w6OCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 09/26] printk: nbcon: Add detailed doc for write_atomic()
Date: Sun, 18 Feb 2024 20:03:09 +0106
Message-Id: <20240218185726.1994771-10-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_atomic() callback has special requirements and is
allowed to use special helper functions. Provide detailed
documentation of the callback so that a developer has a
chance of implementing it correctly.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index e4fc6f7c1496..5c55faa013e8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -278,7 +278,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -295,7 +295,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -320,8 +319,35 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	bool			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context. (Optional)
+	 *
+	 * This callback is called with the console already acquired. The
+	 * callback can use nbcon_can_proceed() at any time to verify that
+	 * it is still the owner of the console. In the case that it has
+	 * lost ownership, it is no longer allowed to go forward. In this
+	 * case it must back out immediately and carefully. The buffer
+	 * content is also no longer trusted since it no longer belongs to
+	 * the context.
+	 *
+	 * If the callback needs to perform actions where ownership is not
+	 * allowed to be taken over, nbcon_enter_unsafe() and
+	 * nbcon_exit_unsafe() can be used to mark such sections. These
+	 * functions are also points of possible ownership transfer. If
+	 * either function returns false, ownership has been lost.
+	 *
+	 * This callback can be called from any context (including NMI).
+	 * Therefore it must avoid usage of any locking and instead rely
+	 * on the console ownership for synchronization.
+	 *
+	 * Returns true if all text was successfully written out and
+	 * ownership was never lost, otherwise false.
+	 */
+	bool (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


