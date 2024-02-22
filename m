Return-Path: <linux-kernel+bounces-76728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C485FBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AC21F2470F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CA14831D;
	Thu, 22 Feb 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXxhbRr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVQ8Uaod"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5621474A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613639; cv=none; b=HEERLmwxF6oP0gaME/gzlnDk0x55SqTkhjA7N5x4nOlzVNAYmPTRiTi8raBWKCyYNlMbK8JVIQMDH0pKLsYHKK8e0Sh4wHfsm4YQC7cLj1UYYSyU3eLvlpTDgMY0OcMfb1sYHJ6p9G+7Pyf2zEZWKQxwcPL+pBTiCnvtcFKDmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613639; c=relaxed/simple;
	bh=l1dvnYIkbVQGD2EOv6y5d0AMbBQic+r+Q8ubYp/1wzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrAMKPuaYMp3bFYlZRCrhFbApanz2ZTjRJbwJJI9nETj7yUvQlS8jJsci+OnJZk9ZAI3PQEgKhfNQBYhxqaW2ClxENMiVrS+tUzUb1wh4QWJXAqfM3vfOUA/CgeERJQ6mo+9X6fbmzRz5Fub3tSR+PYL7K30xF/7Qq4EAgWYq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qXxhbRr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVQ8Uaod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708613635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftFB7iq5QbNfkEzFk48AFLpiuJwfQQxJUlxL4LvbesA=;
	b=qXxhbRr+8fbp4feSZQlXFT48tW1d+9ECLIOuzKO7R6GYS8KQKz8rlE7T0vNeVEXXjZiDgb
	8pvujYcWkxg9guXpeRtS5FmMHtahJHQPardhs9liwHfVdm5gvPJ1Nj+o231nSqsOr5n0yj
	5UmYxrxTPdzWperHKaUDnaykK/imsmdvvuWwFpgMqTpRnlI4eMOpiI6yYqYJebjM+ZVGaR
	Fl95q6+NbyMjExwyRI1wAINTarvotqY4fOBLfcJXAeEneS2vNaMOHR5H1Wxg6WqAyKWlGZ
	awdztHKGgXY4J7o7RUe6NMU05kpj0rOARGfHtauJRJS+GLEB3KwOgwvukfXlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708613635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftFB7iq5QbNfkEzFk48AFLpiuJwfQQxJUlxL4LvbesA=;
	b=dVQ8UaodovodkLeyjIRK3u9a1o7yw/M73eVVSHMYk8UpkBEiHrpuTaC78x5/C6pFb0BLaV
	eUKU70asSrQOS4BQ==
To: Mukesh Ojha <quic_mojha@quicinc.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH] printk: Add atomic context check inside console_unlock()
In-Reply-To: <20240222090538.23017-1-quic_mojha@quicinc.com>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
Date: Thu, 22 Feb 2024 15:59:31 +0106
Message-ID: <87plwo5z4k.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> Situation of schedule while atomic context can happen in a
> scenario if CPU-Y executing a async probe of ufs and while
> printing a line it is started spinning for console lock
> after preemption disable on CPU-Y and later it got the handover
> of console lock from CPU-X and in console_unlock() it get
> schedule with preempt disable as console_may_schedule was one
> and due to which do_cond_resched was one.

Nice catch. But I think the below patch is the appropriate fix:

John Ogness

-------8<--------
Subject: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()

console_trylock_spinning() may takeover the console lock from a
scheduable context. Update @console_may_schedule to make sure it
reflects a trylock acquire.

Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@quicinc.com
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1685a71f3f71..1612b50b2374 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2020,6 +2020,12 @@ static int console_trylock_spinning(void)
 	 */
 	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
 
+	/*
+	 * Update @console_may_schedule for trylock because the previous
+	 * owner may have been scheduable.
+	 */
+	console_may_schedule = 0;
+
 	return 1;
 }
 

base-commit: e7081d5a9d976b84f61f497316d7c940a4a2e67a
-- 
2.30.2

