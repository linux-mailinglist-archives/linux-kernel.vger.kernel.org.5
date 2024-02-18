Return-Path: <linux-kernel+bounces-70499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343C8598B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7951F22076
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81B6F512;
	Sun, 18 Feb 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snqAalWA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmyFWTbF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F76F094
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282673; cv=none; b=Uv8s91tBnvaOp/R2oG0A0MJpYp7Jehn0wwBJfSmSDngELDRkCJ0KIgwiF2pZH77QEin566yf7pMj3zsLBFnzIK1YW+3VN4gO0pG/HeuPmDqVj0VwDL4cQxarPHjZXiumWSFnffxeDeXqfkEvBR+CULeSbwvSHLKjw5M4oU/wlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282673; c=relaxed/simple;
	bh=xRjhM41YiCV0XIFxys+lC68vQSHxZf7wjECrZPYdxII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj0bkQ6pLnjysOZ3uzyjxPZAFa03D9aicEziRr9PWz4W7jTD6dFAWCa/49QmzwDRMHLr5+9JcCcsgNIh4IvrkZ19rN0ANhC/wD9v18xmyEvFQ4inHmvCwgJrm1k34E2y3KKIPC4BTSWVYpMJifewp3iyR6qtk/1zvs3PdHVtC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snqAalWA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZmyFWTbF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kjns8XLkW3UOjxVLP1Xg+LLtdkqweLRjHg511yq2AQM=;
	b=snqAalWATXYn0aUg65LZvGca4wwwf8i8uVStRHQLraQha7BTOjAHnpHAmXikabBL39RLiE
	MRmXDgvvG2+RBg0rtq5N4Y099iHJtZtZRA2IM7CyqsvJkv1hL2xszoPrUIuRQu2i7iPNm5
	4Ct4gXVxeZ//4jnJt56fzxkAOIuycjU+ZRQseZzN1btEl27/9yjG37VTWInD4oLeSwQB14
	42u4kchPISfE4m5ic24bedmSDw3pVg7g13BwY2g5C762aTwkRl/Awgk1+pErAzruPbDe6c
	eU+3HuZVI71hY0OhWp23G8N/FtzzDJANTPF4+myOwLmf1PAuNXlNo146FHyCKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kjns8XLkW3UOjxVLP1Xg+LLtdkqweLRjHg511yq2AQM=;
	b=ZmyFWTbFlEMBKl9FVuqkxwy1anMpcoUdWmv8BI2orJRjCsQxNuo7BoQOG21L6KMv1rWiVC
	1NYdc0VXdvcu3ICg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 06/26] printk: nbcon: Ensure ownership release on failed emit
Date: Sun, 18 Feb 2024 20:03:06 +0106
Message-Id: <20240218185726.1994771-7-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now it was assumed that ownership has been lost when the
write_atomic() callback fails. And nbcon_emit_next_record()
directly returned false. However, if nbcon_emit_next_record()
returns false, the context must no longer have ownership.

The semantics for the callbacks could be specified such that
if they return false, they must have released ownership. But
in practice those semantics seem odd since the ownership was
acquired outside of the callback.

Ensure ownership has been released before reporting failure by
explicitly attempting a release. If the current context is not
the owner, the release has no effect.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..8ecd76aa22e6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -852,7 +852,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done;
+	bool done = false;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -891,17 +891,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	nbcon_state_read(con, &cur);
 	wctxt->unsafe_takeover = cur.unsafe_takeover;
 
-	if (con->write_atomic) {
+	if (con->write_atomic)
 		done = con->write_atomic(con, wctxt);
-	} else {
-		nbcon_context_release(ctxt);
-		WARN_ON_ONCE(1);
-		done = false;
-	}
 
-	/* If not done, the emit was aborted. */
-	if (!done)
+	if (!done) {
+		/*
+		 * The emit was aborted, probably due to a loss of ownership.
+		 * Ensure ownership was lost or released before reporting the
+		 * loss.
+		 */
+		nbcon_context_release(ctxt);
 		return false;
+	}
 
 	/*
 	 * Since any dropped message was successfully output, reset the
-- 
2.39.2


