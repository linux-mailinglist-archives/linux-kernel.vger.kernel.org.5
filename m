Return-Path: <linux-kernel+bounces-128763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B39895F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B4B1F270B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093C15EFA8;
	Tue,  2 Apr 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STpUA7WP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abVaAe2b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B48E15E80B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095898; cv=none; b=KXB6qLHJem3p03fID9aiC647nMbWi2IP3N3twbiko8MFnj+NXO/DJc/7ewQcBpK2uzFIe9q3a1oqlUIRHtXUAuKpBkMRzYKe9yDsnESI1W6jkDmXGP8GIMT5ryH4BC+0IJPDqHxEJvRrqtn1umJx5kyd7s4dqqt6Bu3SIvRE874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095898; c=relaxed/simple;
	bh=8gNFB2aN+FDgLO4RQJ229KG75St1FCE48jzNGYZ/Lqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXSMFBVmzKkWfs2b4Cf2CxJMlZKGly0trBkW8kzS+87YHmjp8X8A1ToeCuld2uBbuGma1cthR1yddVWy9HY2qiDTEPRG6GoZZQqbYcw4Dsld4teH72VqRahNfMd6RPS8Rx+1ePADw4vWFPGKUnF3yMHRMjJJWarXlddhWTHqeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STpUA7WP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abVaAe2b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clMqsySLzP4iDk2N/9w8Tlak39hMNqLWvIbOFYB9iUM=;
	b=STpUA7WP46KPFCg+EABRpi8ZJ6z/BmNct4cP7i+RwGUPsllyQHfuOQ+k2DBxop+S3tB/+7
	94dn2PxGgNfTVf7KVzLRwSV55dp7e0kyaSs51M4EOyeWoNEP2Mdv2P8AC+yVvZAXOFofJP
	RIzADPKjRwFGQ2UNIJOkuh8sUEDDPQlpOtwZFosbcOlfV7QtKz2plb/GvSJxHUlUaV26i/
	vhKW7MuSXFaUyrC3PYuxnZrv5UQy3Xb0fMxm0LL7oMMJX0wnYaFABsV13xEkSUDjuUt8iF
	JUxAHXeCamecG7l+Bf/Wm6O5M/GmMPe8z3DEac/GbuR+T4kuJ+8YZ9tC0iQCVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clMqsySLzP4iDk2N/9w8Tlak39hMNqLWvIbOFYB9iUM=;
	b=abVaAe2bY6SNXtus/u286s8LbuB9sQPtVZn8ycCUKkX8cKJN1oBzqzjCSCFWh2ZTly1HA6
	DJPkCPYV5dEy8RCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 02/27] printk: Properly deal with nbcon consoles on seq init
Date: Wed,  3 Apr 2024 00:17:04 +0206
Message-Id: <20240402221129.2613843-3-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a non-boot console is registering and boot consoles exist, the
consoles are flushed before being unregistered. This allows the
non-boot console to continue where the boot console left off.

If for whatever reason flushing fails, the lowest seq found from
any of the enabled boot consoles is used. Until now con->seq was
checked. However, if it is an nbcon boot console, the function
nbcon_seq_read() must be used to read seq because con->seq is
not updated for nbcon consoles.

Check if it is an nbcon boot console and if so call
nbcon_seq_read() to read seq.

Also setup the nbcon sequence number and reset the legacy
sequence number from register_console() (rather than in
nbcon_init() and nbcon_seq_force()). This removes all legacy
sequence handling from nbcon.c so the code is easier to follow
and maintain.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c  |  7 +------
 kernel/printk/printk.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..d741659d26ec 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -172,9 +172,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
-
-	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
-	con->seq = 0;
 }
 
 /**
@@ -964,8 +961,6 @@ bool nbcon_alloc(struct console *con)
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
- *
- * This function expects that the legacy @con->seq has been set.
  */
 void nbcon_init(struct console *con)
 {
@@ -974,7 +969,7 @@ void nbcon_init(struct console *con)
 	/* nbcon_alloc() must have been called and successful! */
 	BUG_ON(!con->pbufs);
 
-	nbcon_seq_force(con, con->seq);
+	nbcon_seq_force(con, 0);
 	nbcon_state_set(con, &state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c7c0ee2b47eb..b7e52b3f3e96 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3348,6 +3348,7 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
+/* Set @newcon->seq to the first record this console should print. */
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
@@ -3396,11 +3397,20 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 
 				newcon->seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!((con->flags & CON_BOOT) &&
+					      (con->flags & CON_ENABLED))) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
+					if (seq < newcon->seq)
+						newcon->seq = seq;
 				}
 			}
 
@@ -3517,9 +3527,18 @@ void register_console(struct console *newcon)
 	newcon->dropped = 0;
 	console_init_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
+	if (newcon->flags & CON_NBCON) {
 		nbcon_init(newcon);
 
+		/*
+		 * nbcon consoles have their own sequence counter. The legacy
+		 * sequence counter is reset so that it is clear it is not
+		 * being used.
+		 */
+		nbcon_seq_force(newcon, newcon->seq);
+		newcon->seq = 0;
+	}
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
-- 
2.39.2


