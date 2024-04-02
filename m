Return-Path: <linux-kernel+bounces-128762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B4895F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF77C2875D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620D15ECFB;
	Tue,  2 Apr 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOta4gtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTrtdyTu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E315E816
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095898; cv=none; b=OAEMZcmsRUBe3aIjGuVFq5rEoqrOLr3G6jLQMV5IbI70qMQqNP7IXYl6RoYzuJpF6bjSr2Iv1hhSIGtkMgFkBwh76mRcPEBfNNlDKOB73UTYfbRV3XD3EgRXtPIr+8fiRQz0j1/wx7DO51G+AI4VvbQnI5OqP01sdJIepqbf/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095898; c=relaxed/simple;
	bh=/0MxrjHFyOtBJDmRT8XjtwDOoZX0ohrlr35f/aHxS2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRoIrKynzp0zcsh0dYv+pvupsWUY9w5XfofFZ/xdHXIl5cEYa2ND3H/F0+5qhtAsKs3LhOYGfvZdH7vkybkciiMI2qmb/oZHOcFYsIh6mnf7TTzO83CJm0T9Kfyjb1GhTHG78JNjRreJMxtpsCXH8v9//WEIaDW/B29OHKE2KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOta4gtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTrtdyTu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nd9y0ptddjz3VGhzIqvJOBfqj/DRxNA65wb3bV/cuvY=;
	b=gOta4gtJ6uOdbb3XFjZVywi1IvDppk6CbumLId+in4AwYsVieFFT+PYirKiFMMe4Mzz8ch
	pefePFlLqWzztw0pTBLkydiQln1mOta1CeGkIt9KVNdrq5E7cSWoa+2qrYbFHt6JrksOmo
	BW9D4/6diQ4BEnVzR5wzucq4tj/0prwaTEvpBlJMTzw3k/+DVGYxLhHf9/lI30illfAa/L
	cjvT7oSblViUYWH1L9oDdtkWpsKClXo4DDJ+EVE5oFzJt5lx0UcXtMQ+0EOMwTNFIXP5Zb
	P3MQ4UjmRjj+0ZqKTlztnzYl92IsKonFCbTEwTdHbMltmzsiCdelGDPILgx1kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nd9y0ptddjz3VGhzIqvJOBfqj/DRxNA65wb3bV/cuvY=;
	b=GTrtdyTuYj3sX6Q/3QBdgs9fFHNA2Q+XV+aRiRWhbH94gb/XYQGrNiMqm/smRpRv2sSUtB
	KdMOK0sxfTd7pyDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 03/27] printk: nbcon: Remove return value for write_atomic()
Date: Wed,  3 Apr 2024 00:17:05 +0206
Message-Id: <20240402221129.2613843-4-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of write_atomic() does not provide any useful
information. On the contrary, it makes things more complicated
for the caller to appropriately deal with the information.

Change write_atomic() to not have a return value. If the
message did not get printed due to loss of ownership, the
caller will notice this on its own. If ownership was not lost,
it will be assumed that the driver successfully printed the
message and the sequence number for that console will be
incremented.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  2 +-
 kernel/printk/nbcon.c   | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8a0..54b98e4f0544 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -327,7 +327,7 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	bool			(*write_atomic)(struct console *con,
+	void			(*write_atomic)(struct console *con,
 						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d741659d26ec..2516449f921d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -849,7 +849,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -889,16 +888,16 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	wctxt->unsafe_takeover = cur.unsafe_takeover;
 
 	if (con->write_atomic) {
-		done = con->write_atomic(con, wctxt);
+		con->write_atomic(con, wctxt);
 	} else {
-		nbcon_context_release(ctxt);
+		/*
+		 * This function should never be called for legacy consoles.
+		 * Handle it as if ownership was lost and try to continue.
+		 */
 		WARN_ON_ONCE(1);
-		done = false;
-	}
-
-	/* If not done, the emit was aborted. */
-	if (!done)
+		nbcon_context_release(ctxt);
 		return false;
+	}
 
 	/*
 	 * Since any dropped message was successfully output, reset the
-- 
2.39.2


