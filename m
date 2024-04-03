Return-Path: <linux-kernel+bounces-129472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF23896B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3B6288C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E0136667;
	Wed,  3 Apr 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ecRSTjRr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhLlUeyF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35A13664E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138504; cv=none; b=YxFUOnvKpCs0YmVL/zH7rQ3DAAFt8tLj3tqUmx0l6zJbI2sOfvfkDhjmeHe3u3EUy9nfs3vybLqveNQClWla5o/RqwoK7DYdy+lripvxwM2no0yKQwf3Rb0mh5Gz7whX+3y6Sg0JxKT9ItDAQv4rCs7ug8KitI1rzNtyQUM2x7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138504; c=relaxed/simple;
	bh=4onH9pIZb/gpWAuC6bRjLpL7ytiMCrohi3JtJ46oTcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RqlMsdo6VQZKVSgX3sL+J8fs0mADB5IUmKCUb8F61khvFsbdt0ULK/6Av8BbPjDqnAse4cCmtndR5tWvkDVlGD79R9QUgfoBM62dR8+oFYQkzRzfBsVSwyXOYPeqhus9h6KwiQFfT1gM3dfumnztbVYw4qhoDOND6Es7Xd+ezs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ecRSTjRr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhLlUeyF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712138495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjtwVrj/EmusKLU8iBpCgtDctWbmNABP7koU+i0B974=;
	b=ecRSTjRrrdupcIPlo4xWGxNUXAzDCq+qoWxSOxuC46ocbo2OuNKrXkyF5ZQ6wgqaaFVjXh
	sDBcDu94TyumjL6cE17u97b322na24MX4WEdLp/udxg5av7Kjl939D+lJZQOD04O7y7zBP
	+2lYRDGibZyfuNLB4i0BVAVe3DjJA2/sSco59OFm7cEBeYuji3J6hBWlf5FAe0SDRkBzYz
	WiGH/iZot/Tf+uUd8sb7+16yNWo1hVRSN4rZnrLn3ZfOHtD7vNRJa0F7rezp8ZRQlvklxK
	jf+hKzCmfwx5rF67MY8CntooGstJTjhWc6ybMl5yw5t3MGIC/F02B03ztqLGTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712138495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjtwVrj/EmusKLU8iBpCgtDctWbmNABP7koU+i0B974=;
	b=GhLlUeyFgFc2FqWbZ5xYZgNlvCpjigexSrTLoSiX5C6TTRa2VRnVcOP8QfywfMpxNjBQ3m
	YilBFaXfdz6C+1CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 20/27] printk: Avoid console_lock dance if no
 legacy or boot consoles
In-Reply-To: <20240402221129.2613843-21-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-21-john.ogness@linutronix.de>
Date: Wed, 03 Apr 2024 12:07:32 +0206
Message-ID: <87r0fmydc3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-03, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index df84c6bfbb2d..4ff3800e8e8e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3810,6 +3833,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	u64 last_diff = 0;
>  	u64 printk_seq;
>  	short flags;
> +	bool locked;
>  	int cookie;
>  	u64 diff;
>  	u64 seq;
> @@ -3819,22 +3843,35 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	seq = prb_next_reserve_seq(prb);
>  
>  	/* Flush the consoles so that records up to @seq are printed. */
> -	console_lock();
> -	console_unlock();
> +	if (printing_via_unlock) {
> +		console_lock();
> +		console_unlock();
> +	}
>  
>  	for (;;) {
>  		unsigned long begin_jiffies;
>  		unsigned long slept_jiffies;
>  
> +		locked = false;
>  		diff = 0;
>  
> +		if (printing_via_unlock) {
> +			/*
> +			 * Hold the console_lock to guarantee safe access to
> +			 * console->seq. Releasing console_lock flushes more
> +			 * records in case @seq is still not printed on all
> +			 * usable consoles.
> +			 */
> +			console_lock();
> +			locked = true;
> +		}
> +
>  		/*
> -		 * Hold the console_lock to guarantee safe access to
> -		 * console->seq. Releasing console_lock flushes more
> -		 * records in case @seq is still not printed on all
> -		 * usable consoles.
> +		 * Ensure the compiler does not optimize @locked to be
> +		 * @printing_via_unlock since the latter can change at any
> +		 * time.
>  		 */
> -		console_lock();
> +		barrier();

When I originally implemented this, my objective was to force the
compiler to use a local variable. But to be fully paranoid (which we
should) we must also forbid the compiler from being able to do this
nonsense:

if (printing_via_unlock) {
	console_lock();
	locked = printing_via_unlock;
}

I suggest replacing the __pr_flush() hunks to be as follows instead
(i.e. ensure all conditional console lock usage within the loop is using
the local variable):

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index df84c6bfbb2d..1dbd2a837b67 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3819,22 +3842,34 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
-	console_lock();
-	console_unlock();
+	if (printing_via_unlock) {
+		console_lock();
+		console_unlock();
+	}
 
 	for (;;) {
 		unsigned long begin_jiffies;
 		unsigned long slept_jiffies;
-
-		diff = 0;
+		bool use_console_lock = printing_via_unlock;
 
 		/*
-		 * Hold the console_lock to guarantee safe access to
-		 * console->seq. Releasing console_lock flushes more
-		 * records in case @seq is still not printed on all
-		 * usable consoles.
+		 * Ensure the compiler does not optimize @use_console_lock to
+		 * be @printing_via_unlock since the latter can change at any
+		 * time.
 		 */
-		console_lock();
+		barrier();
+
+		diff = 0;
+
+		if (use_console_lock) {
+			/*
+			 * Hold the console_lock to guarantee safe access to
+			 * console->seq. Releasing console_lock flushes more
+			 * records in case @seq is still not printed on all
+			 * usable consoles.
+			 */
+			console_lock();
+		}
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -3854,6 +3889,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
+				WARN_ON_ONCE(!use_console_lock);
 				printk_seq = c->seq;
 			}
 
@@ -3865,7 +3901,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		console_unlock();
+		if (use_console_lock)
+			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining_jiffies == 0)

