Return-Path: <linux-kernel+bounces-128772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0A895F76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE11F20FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394915FD1C;
	Tue,  2 Apr 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bsHSuMB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9Zpe5zD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F315F41A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095903; cv=none; b=ShT3adaOfxEPFPNtxH5aCJ5kuUlzC2n17G9gTf2g2Lz3zj+AK7SSWKQ2GoEbVdFQmqmbgumVU5ydqgicwbFv8qRrrfXhdMSJvBRXHDbWlPEVgRmkd1Cp2UPgXhxt6usVt6ZfVqkN2MbzEL8NRngFTpd+U7EgZYUiMeht8B/7Bqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095903; c=relaxed/simple;
	bh=Wetid+W3GuC+Ymmd1WqU1sS4wWD0Phnpab/ybnqHMFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMPHQcc5gPSD1EDW8I5IyP/lyZhpnlCos4k1Ype4JF4KSnC+Rrw8l9K/2CUXu9rxGhjHgvOHFEF8D2DDVZFXIgxH4Va82SF9S5p2/nA0pmzV318k/5h3+Wkv892E+4JWmTv/Yux3jhLrNdxXs9dzcz6B1Ux9wsBEAe7H80ANzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bsHSuMB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9Zpe5zD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tgGYCDtdP5lKrc5acCUoGxSE5RROIy0dFDLevKQFSM=;
	b=3bsHSuMBHth9eC3A0fyARWWGfDGHwae1U8X/emri9Ag3BEuCoiK1WpS/F8qCO3gV+81c+1
	HdK4sehD4sH38r7D+EYNd2MU6qpN0U5cfK5TckyGJSoA6vqOlPGnfay4wtw/83cWmnxJ2q
	9luftdMF6JMy7rcqSAf4lLL28TDSiRopTrXc74FtwJ1w4adZwuanxvh2LLfyVrvFwA/g2U
	30QKawR3i2HJGmLkDSNNdBNS2agrIj8I/kxHhdRZHdwCm8GNLo0WglwGlo/6zoucM+vUaA
	eIFso9MBB8//iAky8gqqWQyowRJGncL8qxUeIsS6O6dePI2vHkOMiXRhYFLSKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tgGYCDtdP5lKrc5acCUoGxSE5RROIy0dFDLevKQFSM=;
	b=W9Zpe5zDc2FpMfZJOPFjkTwpupjBY8O/HU5cr4Cq7W0KJlwcmsX50cz1sxXRkqjYOrD6a/
	QA6BEP94y5z+ZNDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 12/27] printk: Make console_is_usable() available to nbcon
Date: Wed,  3 Apr 2024 00:17:14 +0206
Message-Id: <20240402221129.2613843-13-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move console_is_usable() as-is into internal.h so that it can
be used by nbcon printing functions as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 32 ++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c040fc8f1fd9..bad22092cd5e 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -85,6 +85,36 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_srcu_read_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -106,6 +136,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cd32648372a0..9ea51cb2aca9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2697,36 +2697,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con)
-{
-	short flags = console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;
-- 
2.39.2


