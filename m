Return-Path: <linux-kernel+bounces-166966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45B8BA27B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B42928AAE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFF1C9ED3;
	Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRCUgySs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBEygG+t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F851C233B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685933; cv=none; b=J6AqXmyMzuifBRQUpzcsaO4lx9y3KnMaggDe4W5/0lRNB9BucuMPYzWLGPoQcU9YY/SZSsu4Xah8p0ZqMIU6F3AIQt4RexiMN1f/FiX484GgfnfZtpQg3bgQ0s2/iZe/Zmi9IcOOomOt1X1D3rFVxdJtCYVAwR591sGS5xuLSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685933; c=relaxed/simple;
	bh=lwK7GcrDHEjSCVMCl6fH9fAyvwP+TuECoQz0KJrspIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swPlsRww6YpA9FwWaWN8WpvZbVGQqOL2TSgWsFc6ArTzWbrxw2c39m8UZ8KD3MJaUeHCtqvwN6+GPnIU+q7if/Awuf8E09v95mnujlUKvWi06h7q5nKYXABVzLqImkaNxBVNvi/mpl3JwMTGc2wcD8UDp6/hKC9EArk+1CC5QoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRCUgySs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBEygG+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIB/C0kn4U7fgTEgQsG7CoHVIr2JrRBBOwabsQzPu5A=;
	b=aRCUgySsgIMJPdkX8w83I6XtQKM9MpLdM6TI+yT9ThD4ktEvVJnqNLeguPv6YLzZUxxb+c
	Bztr3PrEnd4upA89FdjBv1Q9Rb85zJ8XRtUjzf0DHaKbxduHe/V3NxAM080s56WDnyvskl
	MUsPrX5WLHLX4FndYzXvdyegCdm6ysiEJ1KgYbTp37NRk7lfkRhOVLsTmQxuDYh/Np0mF4
	49FlaFL3CgTM0ru92r5wfiYze7megajaQOcnfvK8x8LZFeMjCr/BqKy1zLfL3vHdYDqdts
	uIWTzKL2CAKcf5kCHKCyv28V2SurryoiRzSXcOyHds1UNrYORKhs8/JT7+grDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIB/C0kn4U7fgTEgQsG7CoHVIr2JrRBBOwabsQzPu5A=;
	b=bBEygG+tIrdX7FBVduKNWeDSAUMNudEJd1sOtzR6U/D3E4AIyEkPwtD52glTUiabrv3W0U
	Z8pUERObNzgqokCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 16/30] printk: Let console_is_usable() handle nbcon
Date: Thu,  2 May 2024 23:44:25 +0206
Message-Id: <20240502213839.376636-17-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbcon consoles use a different printing callback. For nbcon
consoles, check for the write_atomic() callback instead of
write().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 339563dd60bb..943e8f083609 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -87,6 +87,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -101,8 +103,13 @@ static inline bool console_is_usable(struct console *con)
 	if ((flags & CON_SUSPENDED))
 		return false;
 
-	if (!con->write)
-		return false;
+	if (flags & CON_NBCON) {
+		if (!con->write_atomic)
+			return false;
+	} else {
+		if (!con->write)
+			return false;
+	}
 
 	/*
 	 * Console drivers may assume that per-cpu resources have been
-- 
2.39.2


