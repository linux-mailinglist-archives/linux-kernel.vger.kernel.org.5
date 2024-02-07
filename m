Return-Path: <linux-kernel+bounces-56568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3284CBD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C971C22A7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451927CF02;
	Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iK/gRZVy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2sK/GioH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D57A72F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313282; cv=none; b=fKvkAuhlTymcycBX2d4DK1rZhuzbUirQLtjz9jU4OhaQeezgyGeguAGI1h9OPFI5G9NAN0+GRjFdrUikgpi5ebeTNXGK2EC7ziTuGF1flrotrg/8w0UVzuskzUmfj5hfxf6DP/vi8hregYcwUQVo5g3QENifUT0DIO+KcqofkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313282; c=relaxed/simple;
	bh=jE0seAEC/xsUWMRtdK3YedzagSyj6mY+1emI8btEf4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzxciqblxtj05vKWVOh4YDimamGDY0KXAyUeL+JZ4SW22tMNdz/QipTXklxmaD+uLtzO/3c7OlOGhC2ii4Rv6JFMj7B4uXS0Rpx0YcPdHVxuBcqjRXr6Vt0B/MTBLe+HTk+swiAKd6sbHMNaSj0zYldsm6hB08Kmw3k7eT1AQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iK/gRZVy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sK/GioH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xT7zVJldSqDSwoUDq5kV0sG2up4ftkGgvjxHkX7b2JY=;
	b=iK/gRZVy1yAsy2xKP2G9BqmZpuuGbm32s8UcXFG/hBTiagvYU6EoS/TBBVmV33diYWmUOM
	OTPByYacFZy0/RuqZnrT21N7r+qe4PnGixv6MXVLumcD72yaNRW594Sg0PWhgnGIyV/fcI
	8tKt6cODKqTnDuJA3JRrOjma9eyroJSXhCnuwVWrYdwDtAKMVHc/u3plx9O7dr7OVHquv0
	v9fNk+Ptha5BdRC9EgNN8Q5GcBX0L2Hmgtogv2UdpUEL8c9or8pFPg/ErqNapJvdsvWiR2
	+wxxEvXPzYioktkLWU9dQyV3cRPnA//ynXONy7xWePvTmnqoBRvV6qrSMPP6Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xT7zVJldSqDSwoUDq5kV0sG2up4ftkGgvjxHkX7b2JY=;
	b=2sK/GioHV+lIq5/fwAQVa/ezEoivaOvGl1twa+slOYEw+QdPKUhyN3Q+1v8nZskiQAE+l3
	VAWlM4oFIvQ2zHBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 09/14] printk: Wait for all reserved records with pr_flush()
Date: Wed,  7 Feb 2024 14:46:58 +0106
Message-Id: <20240207134103.1357162-10-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently pr_flush() will only wait for records that were
available to readers at the time of the call (using
prb_next_seq()). But there may be more records (non-finalized)
that have following finalized records. pr_flush() should wait
for these to print as well. Particularly because any trailing
finalized records may be the messages that the calling context
wants to ensure are printed.

Add a new ringbuffer function prb_next_reserve_seq() to return
the sequence number following the most recently reserved record.
This guarantees that pr_flush() will wait until all current
printk() messages (completed or in progress) have been printed.

Fixes: 3b604ca81202 ("printk: add pr_flush()")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            |   2 +-
 kernel/printk/printk_ringbuffer.c | 105 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |   1 +
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82dc2c7949b7..f3a7f5a6f6f8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3755,7 +3755,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	might_sleep();
 
-	seq = prb_next_seq(prb);
+	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	console_lock();
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 67ee1c62fcd6..24b484c221e8 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1986,6 +1986,111 @@ u64 prb_first_seq(struct printk_ringbuffer *rb)
 	return seq;
 }
 
+/**
+ * prb_next_reserve_seq() - Get the sequence number after the most recently
+ *                  reserved record.
+ *
+ * @rb:  The ringbuffer to get the sequence number from.
+ *
+ * This is the public function available to readers to see what sequence
+ * number will be assigned to the next reserved record.
+ *
+ * Note that depending on the situation, this value can be equal to or
+ * higher than the sequence number returned by prb_next_seq().
+ *
+ * Context: Any context.
+ * Return: The sequence number that will be assigned to the next record
+ *         reserved.
+ */
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	unsigned long last_finalized_id;
+	atomic_long_t *state_var;
+	u64 last_finalized_seq;
+	unsigned long head_id;
+	struct prb_desc desc;
+	unsigned long diff;
+	struct prb_desc *d;
+	int err;
+
+	/*
+	 * It may not be possible to read a sequence number for @head_id.
+	 * So the ID of @last_finailzed_seq is used to calculate what the
+	 * sequence number of @head_id will be.
+	 */
+
+try_again:
+	last_finalized_seq = desc_last_finalized_seq(rb);
+
+	/*
+	 * @head_id is loaded after @last_finalized_seq to ensure that
+	 * it points to the record with @last_finalized_seq or newer.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If desc_last_finalized_seq:A reads from
+	 * desc_update_last_finalized:A, then
+	 * prb_next_reserve_seq:A reads from desc_reserve:D.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
+	 *    matching
+	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
+	 *
+	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
+	 *       different CPUs. However, the desc_update_last_finalized:A CPU
+	 *       (which performs the release) must have previously seen
+	 *       desc_read:C, which implies desc_reserve:D can be seen.
+	 */
+	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_next_reserve_seq:A) */
+
+	d = to_desc(desc_ring, last_finalized_seq);
+	state_var = &d->state_var;
+
+	/* Extract the ID, used to specify the descriptor to read. */
+	last_finalized_id = DESC_ID(atomic_long_read(state_var));
+
+	/* Ensure @last_finalized_id is correct. */
+	err = desc_read_finalized_seq(desc_ring, last_finalized_id, last_finalized_seq, &desc);
+
+	if (err == -EINVAL) {
+		if (last_finalized_seq == 0) {
+			/*
+			 * No record has been finalized or even reserved yet.
+			 *
+			 * The @head_id is initialized such that the first
+			 * increment will yield the first record (seq=0).
+			 * Handle it separately to avoid a negative @diff
+			 * below.
+			 */
+			if (head_id == DESC0_ID(desc_ring->count_bits))
+				return 0;
+
+			/*
+			 * One or more descriptors are already reserved. Use
+			 * the descriptor ID of the first one (@seq=0) for
+			 * the @diff below.
+			 */
+			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
+		} else {
+			/* Record must have been overwritten. Try again. */
+			goto try_again;
+		}
+	}
+
+	/* Diff of known descriptor IDs to compute related sequence numbers. */
+	diff = head_id - last_finalized_id;
+
+	/*
+	 * @head_id points to the most recently reserved record, but this
+	 * function returns the sequence number that will be assigned to the
+	 * next (not yet reserved) record. Thus +1 is needed.
+	 */
+	return (last_finalized_seq + diff + 1);
+}
+
 /*
  * Non-blocking read of a record.
  *
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index d49460f7578e..52626d0f1fa3 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -395,6 +395,7 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 u64 prb_first_seq(struct printk_ringbuffer *rb);
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #ifdef CONFIG_64BIT
 
-- 
2.39.2


