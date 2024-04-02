Return-Path: <linux-kernel+bounces-128771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3D895F74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D21C2401D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF215FCF5;
	Tue,  2 Apr 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orRhzLBw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7XGskGEa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C615F3F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095903; cv=none; b=CxZ536y4kR/FZXdRHLfZcvEmwOP+xUgk4bXYVW7bIwLp3W9YOeI9nsGTcnXaHwoKDlcBUOgy8YorMML9I4rhIkIOC1ohVQPOslSvVzHZL7c2oUU58N1JauntqghA7wcyrVk7GZFssXm54f34XGbBwyvc43ZWjZMbQzaOLxigBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095903; c=relaxed/simple;
	bh=H8Y6h4f+pnDIq01N0fQkcihCHtRyqbPCpn/ulCQW4A8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4q/AALsYF8UoJhvFRJFoY4AizPNFqBGDfp4tigrOFfYq4vNLQGvk6g13r+hwMUf0w3FTtDbqQ7ou4aWQeUni+bD9/L4ZsUucm5Wxq7lMUyllViZ6hc5alox271d90xi6AWznJoQdfyg/euAaUg/mIXQnHknKSuedXRdSHwiTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=orRhzLBw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7XGskGEa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ht98dgt7fflhXi7xwdr8D666RniCtKRAaw59pcdcaw=;
	b=orRhzLBwweHWfysRCvB62UA+YhniOqlwKgKuGBc9/ggHICSRUGZao3N7LkUiA1+Jj2+3BX
	tt7V3hrjNd7J3qNh4RTWlQv7t/c5KN7UupU3qfJBt0a4s37wGH+dn4gWpPpwMlHK9l1aev
	/sxTeugGs8tuTSDlAby8x9q5Q1uWfY/tsUQIIEwvI4blYF1gAbHI5/+NsxqkGoqDsDUtSX
	3RKsoC07aYAKhB2Hv354x2+9LKma5sDhzUfJu3VZjhFbkzsqXGIhYu0W0pnKQWyC+v+y5t
	i5f4Bq6OlXXt2PC8XYBabXzLGMxs9QAZXTOTZoETDSdCsGgf77plrtjCoaKQoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ht98dgt7fflhXi7xwdr8D666RniCtKRAaw59pcdcaw=;
	b=7XGskGEaEanzfpedqUohrkuPUoZ2sgt2vEjj+i+a6RU43Y74/V+lZwN+5BXTOxLI3TUHAn
	wG+STzDT8Q6hx8BA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH printk v4 11/27] printk: nbcon: Fix kerneldoc for enums
Date: Wed,  3 Apr 2024 00:17:13 +0206
Message-Id: <20240402221129.2613843-12-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kerneldoc requires enums to be specified as such. Otherwise it is
interpreted as function documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index e7c35c686720..5f1758891aec 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -137,7 +137,7 @@ static inline int con_debug_leave(void)
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -218,7 +218,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
-- 
2.39.2


