Return-Path: <linux-kernel+bounces-128765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D2895F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCF2875E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD215F3E8;
	Tue,  2 Apr 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFXhDRIa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UIYUPjc+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D115ECFE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095900; cv=none; b=rMg3SHxFpdkHo0c6Ly6W2CtrvMKQnDud0EvzS6TqX/2NYpnTG3zlLO4NQyZlarS6W5bvPhcUFL7ZWIRpzTe6oxIsU5w03ec6SuJpKLQh2AZYxowoqm+A5uZvk/w1SCj9WnG8ouc5cngGPlLloUa0Ihs5CyQiICV3fk2mY9VQfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095900; c=relaxed/simple;
	bh=ZGfKxGfEmF/DaQH7qHtPYDaH5xaSTIeExUXAHoqBHGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quEqA/j56g5r375Jkdt8n47FH11EredXl2aCmusCCBIfOvqj4pHxVQaufIfp5tUlmMU2zw2Gb9mWk7rUDbJImXnEtRLhyJMZX+hEGibjVh/ltdzKI+2GLKtu2gaeKUZ+MhQIvKUcpYNW4y5DEG0nOVuVbzGedgNohPZIw8it2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFXhDRIa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UIYUPjc+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yB2aLQdKE7JgW5QmS0138amGRuUP36LU9EqlH92t8Q=;
	b=hFXhDRIaUS1GUQ62DUUuwVndZc60ypo15bP5KCOzzx+kKEZbS/KroAQvZtjkJPufWAxmd8
	J2KHlOB7Ow4swEPorfTPxmn/x4AZFgLOU3hGA5b9JKS+IPNh0Y+WlOil9a2ZNEsnu5A24E
	/2RettyikmlfQoWFlpbWqBfB7+/cDJ52stfULtAIXwZk8ddrjcXqX48LamEtedpNw5l78u
	BQ7S0O8PNTh0nd+eBnnSnvjoUyqKlALXr1+Fmaj4D2CFdyep9BlbgYVMw3luVlrHpHJz/q
	BB6OMR9cEHVn2WF2/AYtpZxc9TjlFxpdEcxzw0qQ2fsfvDVZlmHRoDFdFjo9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yB2aLQdKE7JgW5QmS0138amGRuUP36LU9EqlH92t8Q=;
	b=UIYUPjc+DAKmgQcthYjmBgxwriDD1XFrnT4cdAJ5Fg5doID6zeHrZW8AOKFK9pD2oye+WG
	D067ObgZ2qnyedCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to synchronize with driver
Date: Wed,  3 Apr 2024 00:17:08 +0206
Message-Id: <20240402221129.2613843-7-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls.

Follow-up commits require that the printk subsystem is able to
synchronize with the driver. Require nbcon consoles to implement
two new callbacks (device_lock(), device_unlock()) that will
use whatever synchronization mechanism the driver is using for
itself (for example, the port lock for uart serial consoles).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index e4028d4079e1..ad85594e070e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -352,6 +352,48 @@ struct console {
 	 */
 	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
+	/**
+	 * @device_lock:
+	 *
+	 * NBCON callback to begin synchronization with driver code.
+	 *
+	 * Console drivers typically must deal with access to the hardware
+	 * via user input/output (such as an interactive login shell) and
+	 * output of kernel messages via printk() calls. This callback is
+	 * called by the printk-subsystem whenever it needs to synchronize
+	 * with hardware access by the driver. It should be implemented to
+	 * use whatever synchronization mechanism the driver is using for
+	 * itself (for example, the port lock for uart serial consoles).
+	 *
+	 * This callback is always called from task context. It may use any
+	 * synchronization method required by the driver. BUT this callback
+	 * MUST also disable migration. The console driver may be using a
+	 * synchronization mechanism that already takes care of this (such as
+	 * spinlocks). Otherwise this function must explicitly call
+	 * migrate_disable().
+	 *
+	 * The flags argument is provided as a convenience to the driver. It
+	 * will be passed again to device_unlock(). It can be ignored if the
+	 * driver does not need it.
+	 */
+	void (*device_lock)(struct console *con, unsigned long *flags);
+
+	/**
+	 * @device_unlock:
+	 *
+	 * NBCON callback to finish synchronization with driver code.
+	 *
+	 * It is the counterpart to device_lock().
+	 *
+	 * This callback is always called from task context. It must
+	 * appropriately re-enable migration (depending on how device_lock()
+	 * disabled migration).
+	 *
+	 * The flags argument is the value of the same variable that was
+	 * passed to device_lock().
+	 */
+	void (*device_unlock)(struct console *con, unsigned long flags);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


