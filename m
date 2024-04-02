Return-Path: <linux-kernel+bounces-128774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC91895F78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20621C20B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD11607B3;
	Tue,  2 Apr 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKqoB5au";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs3veSnS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63815FCE2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095905; cv=none; b=Ev3TvyZnzjHD9wFZuWomujjxVEKry1RiQbCm/o0+GaqA1I2lBLAymMMSiEnx6FUI0jR4DtwkBeGgDp8VFus71fXBbzXPbMEREPxmq9vmxWqE+aCWt0YHE/fq4iP/YrPnW2hiLhBFzvN1Ahfnq1yE09/C0FAR8XrLDM0GO78ZRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095905; c=relaxed/simple;
	bh=VSpMNtTyJiGrRPB9RAaRfeLkD8vqxjsPOGjsfXw1Ptc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBmQkmzisnwq1RcQyKOdB9FNEmPUKi+/+mE0C2MLhra/SaNxnfpYzJJcyj/j7o2ERkH/iGCXlrOKzps3IgXL5JTjckcqR1l5ezxAk+URPs+Xmr78nPsWoo8qmYGwBKtqxUyeDUJI+xAIFh4i4SrgMzwDvyjw0qcoc0JqLoNV1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKqoB5au; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs3veSnS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcT8QKbkv/y1+FVd9sExuz/3XCroZtJW9JEMQxy9v3w=;
	b=NKqoB5auNPp6orU1zh/lKnD3P0qVINEUBNK/HLIAsypteh1v4PJg3fbR5zwtn4fmRuzX6B
	ZaOz2ETKimGJK5TjJmJzQswKeNlE8gn3nbFSBCB/LX0qTRdy2TFhDI0da6vksjoW2Y1WVO
	LGBCrHZbNo0vDXDseJPPKRvtMGw8lgEEVN45T6zUCXsSfbnsc5Vei5CZ7P4YGNwdTH3lPH
	9TFp/qRwpQWBRHclHofkB/RtR0yykF3kf7okns8PpIiznkB/uMocJhAPziXTs2759MRprD
	y60J/3mkAtNxTO1jJ2WRT9wHgHI2gXuLSXEgbkYfSVf8Z5goEVJjxU9kNjiT6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcT8QKbkv/y1+FVd9sExuz/3XCroZtJW9JEMQxy9v3w=;
	b=rs3veSnSbOEtPnLvhs9UouuFlg5y5SpXoP4wUoqciuXCfMeoA1tBIwemI1UF55XtI25dly
	Wno9UDkQBybokXDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 14/27] printk: Add @flags argument for console_is_usable()
Date: Wed,  3 Apr 2024 00:17:16 +0206
Message-Id: <20240402221129.2613843-15-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller of console_is_usable() usually needs @console->flags
for its own checks. Rather than having console_is_usable() read
its own copy, make the caller pass in the @flags. This also
ensures that the caller saw the same @flags value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 8 ++------
 kernel/printk/printk.c   | 5 +++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 398e99a30427..b7a0072eb2a4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -90,13 +90,9 @@ void nbcon_free(struct console *con);
  * records. Note that this function does not consider the current context,
  * which can also play a role in deciding if @con can be used to print
  * records.
- *
- * Requires the console_srcu_read_lock.
  */
-static inline bool console_is_usable(struct console *con)
+static inline bool console_is_usable(struct console *con, short flags)
 {
-	short flags = console_srcu_read_flags(con);
-
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -143,7 +139,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9ea51cb2aca9..fe06856f7653 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2942,9 +2942,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3814,7 +3815,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


