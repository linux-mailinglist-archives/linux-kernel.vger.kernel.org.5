Return-Path: <linux-kernel+bounces-128766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3A895F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F8B1C24476
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453015F3F4;
	Tue,  2 Apr 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24p1yYvz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yS099pn3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71615ECFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095900; cv=none; b=WYvorTAeCnSFt8cXIaYsLo33Hdm4TXsUhVcMGjJ7hzfvucAJj6TZqOzMPEHtnozflAULP+llyWnzNUB40PKzCVseMJMTrZQexGYYxv6TZIKMQsq+c8/1HicepYos+B+qE6vH/wokkXOeBAQAHsiOT4JhVBr0tlZZGv6X+HAf81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095900; c=relaxed/simple;
	bh=21FdHB8UvH4vxd4uNwfUpHVEPPOEDJI2uyu9KCT428w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adAH9XTJbzTOJcaiefOiJNbqO0PfrQrR3CziITJnV1INDf/gRuMRlDG2JfCx0cqb/7g67+vqkLTRPM47EpYkH2Z3PjeXVyMGIaIZPStT6Obyqvy4TrQ7pS7xO20gBfg1QNUMy0Ti4cSjVa2rqerSDQTLYsoAIqZE4DOeYwWaYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24p1yYvz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yS099pn3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unFh0IQLca0RDLCECJ8AQ28E69e46Gh0slqQ0uqHhBI=;
	b=24p1yYvzeQzyN6QpK1ZVxPWcIipV8U50Z1YXxDS27hUChffQRgSJxzSL2q60TmiMpB4y0G
	FTNzV96KAGkgxLu3rGeTCN/eT5PlX8Dd+P6ipC8eKBD7LqbvVxe/sZMlGW+gn0ofXxZit5
	UzyBXaEGEeyZygdFhQ0l+1cH+yznC2TUtwyi9Wzs+qRr1aTryJDf9iy9CL1zKBdKzxbcYr
	C6E2hQxW/wfKczJR/q7VyYp5Mjsvvptu3dEEBo09+oX7SdbS8EfAOtXTaJeyF1kqGBFCg4
	ZY7i08mmES+mkUWL10yxRi5tEK/lfTqvKhMVkK11Hsbzk3c5YlWnaop7b7EXsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unFh0IQLca0RDLCECJ8AQ28E69e46Gh0slqQ0uqHhBI=;
	b=yS099pn3rNLKW/Tlevuw3AD/qCG4pMi+LEHd2tCQu4VNWmZxhaTMSIyT9dzpyaMjVQPEqI
	fjZX4A1uQV5Iq7Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 05/27] printk: nbcon: Add detailed doc for write_atomic()
Date: Wed,  3 Apr 2024 00:17:07 +0206
Message-Id: <20240402221129.2613843-6-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 54b98e4f0544..e4028d4079e1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -285,7 +285,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -302,7 +302,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -327,8 +326,32 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	void			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context.
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
+	 */
+	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


