Return-Path: <linux-kernel+bounces-166954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245B8BA269
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67841F23CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A319067A;
	Thu,  2 May 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsMC1Ueu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLAhE8DK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FA180A9E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685928; cv=none; b=hoZFcaZ4GuHe7k3MyV/juMZD/VPBeCwIZZf3sq36CEs1nlrkYjaoUP1azMN270A0fB2MWDmeOK11aRr8obAqEHP0CgC7PjpCb2iSGRSAFiVx2Vm3v1fd3cgWciEcTrVc4RV5hXtueBFcm6HtkqNUkyqnDyEbxudcVvwJES964Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685928; c=relaxed/simple;
	bh=y85BCsAtj/oIZY53Aq9gsvAF7SkfMiwPpUsNnn9BKuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmW/2POr3PYvW3mA44PtfXeBO4q02YXrWmiqSHCMaVOK+iJ3nOjWhZW5j0f2fEVB5tQCm6swhGAf26iuU6JI7dfjyUo5MSKDuhitO0nHbV/9J5AflWuMBsuufS2mJ0hRKwA7CQ6uADIPLadgpkJ/kOGUN2JT50Ds+lEBwxj1ltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsMC1Ueu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLAhE8DK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGxVNv6QbVc1S9vlUzY53XnVo+kA+8x3wI8r9c33MRA=;
	b=bsMC1Ueu4QL/FV59npAdNDqzjpmrtAZ/POtmA+9+31VgEJcbUkZVSXB1XCdgJzS/rluA1S
	HjyGj9VEARxYxNXk0SacPvw+9hMpc8wxkSPDvjwY1sVDZavR/vczJHCkYxnzwnQNJJKk8p
	w0f2CcIOGvnbGxTw/PsCWAsXvfi7jMdKyM9gH0BtaSZT5Rnj2K4to26/3mtJx+AJRbyn4/
	i/gE6H8wdBpJddjkzxleoaK+Gr1zTHOwM4PkZ4uy0P0l53yFotSmSJ+MHabUZTUn8cuRzN
	FgtAEDlhyHaozi/tmr/0rtBGXCRDfbXWjbyA30XconxFEw5QyRvbRy9Rgsk60w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGxVNv6QbVc1S9vlUzY53XnVo+kA+8x3wI8r9c33MRA=;
	b=sLAhE8DKrpSZfCWypbS8O3IlmQ1SjOC8VGrelZOUHpUgdr+8ZFlpVRafWA5RHb2efqBe1R
	5kFjsNXIIThrkHCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 03/30] printk: nbcon: Remove return value for write_atomic()
Date: Thu,  2 May 2024 23:44:12 +0206
Message-Id: <20240502213839.376636-4-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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
index de260531b0da..dd7c3180b335 100644
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


