Return-Path: <linux-kernel+bounces-166969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15AE8BA27C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866E51F21945
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F31CB31A;
	Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0lnJc6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDGpdx7F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B61C65EC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685934; cv=none; b=tjPSwg3iYgoYokrzCmRq3puDAgS3tv9Og0DHP+rypwhUrq28MvIhI3VZJ7aDmzJdVUp2eA+1tSqH3lifjmKAYZNkJh0ld1i3b8eeGjcioOBCjCtAmRgZPw6hiBcHe4FR6Bvw86ktuGGgxL8ufB7SkS4nSM5zSIrr7/YrvaAL548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685934; c=relaxed/simple;
	bh=SNLZe25NvdawX74sPMNN2b32M9UWDQ0xBcf74EaYUGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez65Ed11GO0WXismU833mXESueJ+Xmv9hZHXCvsCd84uL0stkie2flCSU7WMhMGE1WRuDb2GsGg6h96jKnemW5SK2lQzBqL8yFQMT8OG7/B4iwz5oVvwl8F3frX6jft96hG1nhLVlFjbeSW5/raoLPRFomXUQ3yskToB+FXZVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0lnJc6O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDGpdx7F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHXFQ842EHAesP3cWbIS8s/eD5QSwLsV5qin0yhI+w4=;
	b=u0lnJc6OtkrxDt5k76e0WVIUprCNBu9MktrVs8rsgDncMTv7pyWfIDOygfzEIHCxiA3m1T
	mPa+et4CoUVTYN1PcDUbcIk5JpF/qc22Aul5LWW3OrFVCu/nBG5pfsAhkh4+yvhf83BQKr
	B7p4XvToB31OItxKQmKCD7DWDOzB/terNQw09PVz2YW0yArQ5ls6JYrVxHzHItQZCvDytc
	HvT2cnAEY+o5fuuakohSvqvBWv9fJGVvH2n219HYVsS1+8rv6oLL0h8PWeHqdX5rkUNmZX
	coWd1HRN8G/oCyoYYB0GwFLmoH9qbx3vgZ5UWkSW3SEdZ+43IouiNFBOL1sfQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHXFQ842EHAesP3cWbIS8s/eD5QSwLsV5qin0yhI+w4=;
	b=QDGpdx7F/MGax+73p1+r2KrWTywkx7Qu89uuyDkRbnj4YFv+60ndkyutIyN2BRzd8rmluK
	MEYKpLhNGHbIKYBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 17/30] printk: Add @flags argument for console_is_usable()
Date: Thu,  2 May 2024 23:44:26 +0206
Message-Id: <20240502213839.376636-18-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
index 943e8f083609..e2de2d262db4 100644
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
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b0e99ee472e1..9cdc110a46a2 100644
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
 
@@ -3823,7 +3824,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


