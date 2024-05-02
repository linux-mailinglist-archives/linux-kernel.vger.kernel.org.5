Return-Path: <linux-kernel+bounces-166959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B08BA271
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E1A1C20CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAF1C661C;
	Thu,  2 May 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdb8wETF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIQolroO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7518411A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685931; cv=none; b=FjPtl8/aB/FKliNoBTI4u2scPU63s3OUD/ALzorfJcz57mEtWBayMQvkcVG/nZdgl6QlUMUrP5K9+Yu/wVooOFSUEcuUuDidLN/MPzEeRDav2G8Vw66hRFFeIwa22tGH2UNLc2ap8UGn2vM4oUk5j0xd7L2WvEBW+4rRDyQC7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685931; c=relaxed/simple;
	bh=M6731ktSPnZgfCgxzWZvBUYPs+vk9Ud8/zAT7Lv5tCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1GSPYT0tfvwPTQKnj8ZWkF2En0sN9Td4Co193DRYHeimohEj8SYXocxzrdWeZ+L1qQFgsym7ITFNDMJlBVTql1+QyjeGQNozjaVpj62bKshzHMg0/diXsyLRFpBgfJ/JyJzZMtvbvOvM2+85RQd3bhh04HEnpIkIdGJ9uUaOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdb8wETF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIQolroO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92SfCOf+RX+OwCPiZ2+/qccTofi7pfYp20D/1pHbIz4=;
	b=bdb8wETFWt7YOianV1jgkpgzkzRkZnH4WKtGt0x+GFNBb+l6vSY18hiFN/8qTg3/r8B+ko
	k3ySI10sr9MvGGaRQ1vEkIR34G/rOI41iDtBuPWdFidQCVf0ZXXvVQnI7WpaBSQ9pHuoz9
	5DrHQEk4LOpmHgXMC4k22acf2EL5eNSCjyjQQBTTD4lTKFAaWt+/lgHcUx2TwwwZu7qadQ
	pslRt/NsgTra7lG+0o3FxQPlWpgEXj0//Wry1gm3XOkqb3wqLAIuXnJ+EEQzkgW1JjraFM
	q1AcisJ1rRdpY/vw8T4YU7qrGcMW8/RRn16r9Itq9l99FCdvhetLYhVD3hl+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92SfCOf+RX+OwCPiZ2+/qccTofi7pfYp20D/1pHbIz4=;
	b=wIQolroOk21T8TCIUIJ3m5I8IhLHtKwoDTHg/dntuJJ7iQnh2azw+/gwcAMpIZPta76m8t
	mzU4Lei1jYKZzGBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 05/30] printk: nbcon: Add detailed doc for write_atomic()
Date: Thu,  2 May 2024 23:44:14 +0206
Message-Id: <20240502213839.376636-6-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
 include/linux/console.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 54b98e4f0544..3291cc340f1a 100644
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
@@ -327,8 +326,34 @@ struct console {
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
+	 * This callback is called with the console already acquired. However,
+	 * a higher priority context is allowed to take it over by default.
+	 *
+	 * The callback must call nbcon_enter_unsafe() and nbcon_exit_unsafe()
+	 * around any code where the takeover is not safe, for example, when
+	 * manipulating the serial port registers.
+	 *
+	 * nbcon_enter_unsafe() will fail if the context has lost the console
+	 * ownership in the meantime. In this case, the callback is no longer
+	 * allowed to go forward. It must back out immediately and carefully.
+	 * The buffer content is also no longer trusted since it no longer
+	 * belongs to the context.
+	 *
+	 * The callback should allow the takeover whenever it is safe. It
+	 * increases the chance to see messages when the system is in trouble.
+	 *
+	 * The callback can be called from any context (including NMI).
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


