Return-Path: <linux-kernel+bounces-70506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CA8598BF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327681C20D20
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A373192;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiMlLlop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFUUiIHd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470346F50C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282675; cv=none; b=bTVB4U3gorWFZCM9rTR+7W7fWi/qCziwgEkGLSi5AYqKgs11rFivksI/tcxHDsuGn+xaxthhEnW7F75HSPdKv4zM5IoA6WRYLTTT4nXF+v1NwlEbIQQ0VKSBJ0wg99CWAqiTARwQC86kuhRZYoHGfHQdnJPdzNDUyyk9KCuxyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282675; c=relaxed/simple;
	bh=KWSkXCKQeNrr5eZStT4LqIX1rH8fREQLBiX0c1gHrHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sy7ozQXYskoiRyAtZtwEyjfCsjAGRiVQKSZ2i3KrMthUfKmJJGr33q28amZr0BpW2oMb+EAu71HkcrglfQvI6DbV20pooeFJo0sBQPMrxLgShppA2dRKU1Ocl0OfE6AyzqcKLqouIXQN/BLP3kxLMyuDKvAsnFebJDNsnv54wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiMlLlop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFUUiIHd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GibUZTFTeq8Azv+JjrVAmh6V7HAl4otIfefb2UG9wk=;
	b=UiMlLlop/JEpMBas0X+fajoIusei1Be/FpyJcoty5xeAu1KPqr30RJO4Hqf8X8OyGyDfXN
	nU4N3qCrcwCfyCoU3j+3RzzC96tUZFGkLzMmvIpCbG4POseS/+TEi98WGoMo/Zyz3K/YMe
	F/dZ2U45Azmi1NXFJX/PuiIfwJVVEGkhkbBKuu5yW2J4OfBtwmceEveWAu9QcNEa+xd6+1
	5tjS6hUYg9cj0kG37YdxaCUukxh3+QoatNCcg9S1ejaC+ZS/pbp7beRR+3DY/OKSYzPF4F
	AfbBSmFwHRjJTseChgbZxHA9q41FgyWWNUd0Z6lBsrjGTPjwE/6NnKv2Z/j22Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GibUZTFTeq8Azv+JjrVAmh6V7HAl4otIfefb2UG9wk=;
	b=gFUUiIHdAlO9f732mfLv2nx9vP+orySfBI5//27FsQFvL56KV9Ud3P30BMUojDQAZxZS0G
	GlaQl5HxOC/sgCDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 13/26] printk: Add @flags argument for console_is_usable()
Date: Sun, 18 Feb 2024 20:03:13 +0106
Message-Id: <20240218185726.1994771-14-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
index 69c8861be92c..6780911fa8f2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -83,13 +83,9 @@ void nbcon_free(struct console *con);
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
 
@@ -136,7 +132,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ecb50590815c..9d56ce5837f9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2939,9 +2939,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3783,7 +3784,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


