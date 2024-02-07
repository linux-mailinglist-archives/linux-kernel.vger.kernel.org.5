Return-Path: <linux-kernel+bounces-56569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472384CBD0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73B91C21CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DC7E773;
	Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sk6Ms0ah";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzNArgF2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A87A727
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313283; cv=none; b=n4uqSMga4yBK/KMAhqqWvcYsHiBAUGDoCNgXXwKhsHAmygtY7KPKb6rmMDRzeo0ekJvOXCyJ5OTFjThH337BEISEufOwaE1mk91COsrPc0KnNik8S8Oc41hlsmu6YUiCnYxmGoZ9hRwJN+VaSUt65sn461YAQmSW/b/ltOUvDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313283; c=relaxed/simple;
	bh=9pKhdcb4U6Kn6n57q/bMFfBnJsOtwwB+U+IocoT8FII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JW1UnS9RCf/A8Ho+BuJnRzdBgut+Xn98rkc3kIjQQn2oZUaRtASwfSJC2dG9zbXevEpoMH+9Gwv0GSVvzeFW7iP8zcI9/vP+bDPyE4SVbeuSOnJJaJzBTXwXRWbzwIL31vOYBok6y0T5TW1dlqb1ODt0lBmToR5ITmd1VWBHcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sk6Ms0ah; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzNArgF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhO6JKJB/J3Qv7bq/QRbOX1jB95B7+7hKvBX2b3MyxY=;
	b=sk6Ms0ahQUVB/nEPquFAjN6fJ+FmlGtBFidV6ykTNk8cDu9P+zUJdrmD29YSeyOoCKwWNN
	i2j/AiEGYeJhZZCfKmXy4m3x1PDJGWQi1audu+RIQ26QS2plgyd6uz6nKO1XqxCuLCvdpf
	HMBvCOZVltSgZo7mEAeDtUsiiTHkBRIvweHT2DS9j0t9x5VreEdBLdubnFDPseaL+k9Alv
	XF2bT+TBqb2d3GnTLzQMwoBBvJye4leOaMZfDS8P5VVIMa8AEp4VWQzjvvfEBYRl5WPTpc
	Uq4RNrFOsfuLS5NyVPuZJNybblwXqClF/a/n1aOKNnzFgpZwQg3oz392lhBItw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhO6JKJB/J3Qv7bq/QRbOX1jB95B7+7hKvBX2b3MyxY=;
	b=EzNArgF2dx+iI6Bd/8fC6sLYUZBQZEAag54Ig93WG0ie99hdhNAAK/aCcjMGrk0y37TuR5
	bSGXdlnCd/hAZyBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 08/14] printk: ringbuffer: Cleanup reader terminology
Date: Wed,  7 Feb 2024 14:46:57 +0106
Message-Id: <20240207134103.1357162-9-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the lockless ringbuffer, it is allowed that multiple
CPUs/contexts write simultaneously into the buffer. This creates
an ambiguity as some writers will finalize sooner.

The documentation for the prb_read functions is not clear as it
refers to "not yet written" and "no data available". Clarify the
return values and language to be in terms of the reader: records
available for reading.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 244d991ffd73..67ee1c62fcd6 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1987,11 +1987,13 @@ u64 prb_first_seq(struct printk_ringbuffer *rb)
 }
 
 /*
- * Non-blocking read of a record. Updates @seq to the last finalized record
- * (which may have no data available).
+ * Non-blocking read of a record.
  *
- * See the description of prb_read_valid() and prb_read_valid_info()
- * for details.
+ * On success @seq is updated to the record that was read and (if provided)
+ * @r and @line_count will contain the read/calculated data.
+ *
+ * On failure @seq is updated to a record that is not yet available to the
+ * reader, but it will be the next record available to the reader.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2010,7 +2012,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			*seq = tail_seq;
 
 		} else if (err == -ENOENT) {
-			/* Record exists, but no data available. Skip. */
+			/* Record exists, but the data was lost. Skip. */
 			(*seq)++;
 
 		} else {
@@ -2043,7 +2045,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  * On success, the reader must check r->info.seq to see which record was
  * actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
@@ -2073,7 +2075,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
  * On success, the reader must check info->seq to see which record meta data
  * was actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count)
-- 
2.39.2


