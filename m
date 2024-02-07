Return-Path: <linux-kernel+bounces-56561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980284CBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81303B22020
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9D77F3F;
	Wed,  7 Feb 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/La2GeV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1qo3qxy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE17764E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313278; cv=none; b=b6bu/VYKnOlA+fh7VN0zrtDj436drxsNYXAe5g7Mt2/gjxMOd2vCysnEt1OaQArfatdeDvTl7h62OBPuCOt+d+K01LPcwE4CaBnnOg+Bw6NvDPSOVffxpJsdqHad0FdsopyoHqlDe15G2dd4RlZ89FAXTSvLgGTb7MrsTjMwrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313278; c=relaxed/simple;
	bh=ckxb7Hs30aCftV5qiZnclb3QjFGEdy4s1Y9N5ksQnGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RK1p/NuGumTtPLjU/0anEBTozIC8OEfTrOJdDkP2hH1glcZMVhABkHshxLpjWPPm2FxR0RnAnKhMhzMsxXqesyy3S2QYxabeSmiAXvKCD6wWXpRXspEUcwFB1WU4q3wl3pLfu0NHa41kae5ksvJXVAx6Nv5oj9X+3tmY7e5DKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/La2GeV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1qo3qxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScsgG7oUpi8nHhHjZW51uSVjZ6WQyvHjuWQxMED78mA=;
	b=n/La2GeVVhalB8C8GiJYaxU+bq6VVbovv5adfo9aG1KCxmereWpLNT9sRmBlBiFKVztb0t
	T9XEiVjWe4+gumVsyoV4EvG2bhpQaIgJ5ogxxyAXIp5vSzUtcYxCigYHidySwBuUQoFF/L
	jASogejwayOc6axN6Hsc2LdJKu1418+AAF+6tDmnTlgAqjgqbWc9kokdrcBsjsA+ZIsZKo
	UVhq5PWFm9B69BOn7UPNN4yMezkaRoUqKN3hZ8krK258aPG1K1CVIfkK+rXMN3A36u3Fps
	U4KveJKUoufJWPXFyHV9e9dnGJeH+RGU2SsdCfi3PHS3jKOhJKo3BDrRDR3Uww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScsgG7oUpi8nHhHjZW51uSVjZ6WQyvHjuWQxMED78mA=;
	b=S1qo3qxye6E3wP0zkILPOmR6fe60n+3xfAYFNgYAoAWVa6uzBTPDLALsEuj+E4ke8xjsH5
	cgiaywA/61Oo9cCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 01/14] printk: nbcon: Relocate 32bit seq macros
Date: Wed,  7 Feb 2024 14:46:50 +0106
Message-Id: <20240207134103.1357162-2-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros __seq_to_nbcon_seq() and __nbcon_seq_to_seq() are
used to provide support for atomic handling of sequence numbers
on 32bit systems. Until now this was only used by nbcon.c,
which is why they were located in nbcon.c and include nbcon in
the name.

In a follow-up commit this functionality is also needed by
printk_ringbuffer. Rather than duplicating the functionality,
relocate the macros to printk_ringbuffer.h.

Also, since the macros will be no longer nbcon-specific, rename
them to __u64seq_to_ulseq() and __ulseq_to_u64seq().

This does not result in any functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c             | 41 +++----------------------------
 kernel/printk/printk_ringbuffer.h | 33 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b96077152f49..c8093bcc01fe 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -140,39 +140,6 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
-#ifdef CONFIG_64BIT
-
-#define __seq_to_nbcon_seq(seq) (seq)
-#define __nbcon_seq_to_seq(seq) (seq)
-
-#else /* CONFIG_64BIT */
-
-#define __seq_to_nbcon_seq(seq) ((u32)seq)
-
-static inline u64 __nbcon_seq_to_seq(u32 nbcon_seq)
-{
-	u64 seq;
-	u64 rb_next_seq;
-
-	/*
-	 * The provided sequence is only the lower 32 bits of the ringbuffer
-	 * sequence. It needs to be expanded to 64bit. Get the next sequence
-	 * number from the ringbuffer and fold it.
-	 *
-	 * Having a 32bit representation in the console is sufficient.
-	 * If a console ever gets more than 2^31 records behind
-	 * the ringbuffer then this is the least of the problems.
-	 *
-	 * Also the access to the ring buffer is always safe.
-	 */
-	rb_next_seq = prb_next_seq(prb);
-	seq = rb_next_seq - ((u32)rb_next_seq - nbcon_seq);
-
-	return seq;
-}
-
-#endif /* CONFIG_64BIT */
-
 /**
  * nbcon_seq_read - Read the current console sequence
  * @con:	Console to read the sequence of
@@ -183,7 +150,7 @@ u64 nbcon_seq_read(struct console *con)
 {
 	unsigned long nbcon_seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
 
-	return __nbcon_seq_to_seq(nbcon_seq);
+	return __ulseq_to_u64seq(prb, nbcon_seq);
 }
 
 /**
@@ -204,7 +171,7 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	 */
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(valid_seq));
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
 
 	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
 	con->seq = 0;
@@ -223,11 +190,11 @@ void nbcon_seq_force(struct console *con, u64 seq)
  */
 static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 {
-	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
+	unsigned long nbcon_seq = __u64seq_to_ulseq(ctxt->seq);
 	struct console *con = ctxt->console;
 
 	if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &nbcon_seq,
-				    __seq_to_nbcon_seq(new_seq))) {
+				    __u64seq_to_ulseq(new_seq))) {
 		ctxt->seq = new_seq;
 	} else {
 		ctxt->seq = nbcon_seq_read(con);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 18cd25e489b8..b82a96dc2ea2 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -381,4 +381,37 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 
+#ifdef CONFIG_64BIT
+
+#define __u64seq_to_ulseq(u64seq) (u64seq)
+#define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+
+#else /* CONFIG_64BIT */
+
+#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+
+static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
+{
+	u64 seq;
+	u64 rb_next_seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 *
+	 * Having a 32bit representation in the console is sufficient.
+	 * If a console ever gets more than 2^31 records behind
+	 * the ringbuffer then this is the least of the problems.
+	 *
+	 * Also the access to the ring buffer is always safe.
+	 */
+	rb_next_seq = prb_next_seq(rb);
+	seq = rb_next_seq - ((u32)rb_next_seq - ulseq);
+
+	return seq;
+}
+
+#endif /* CONFIG_64BIT */
+
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
-- 
2.39.2


