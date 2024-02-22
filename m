Return-Path: <linux-kernel+bounces-76945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4C85FEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA79E1F2A086
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BB159564;
	Thu, 22 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFKtniEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QI9P3/F+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DC15530A;
	Thu, 22 Feb 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621938; cv=none; b=Jk3KmHVoqT6eCJeVmHbA1xQ0wOaI+bJTtx7pfinwG6KsbPUrvWCXwgZRZ+QzMjBl1bz5mrHv2HDo6ieN+csf77DxBM41B9VlN9HX1IBluPEqbEmhqD72Hxwy/bnR8b1/H/bSc4I5Ck2otcCBRrae7Hk3Ewrh6fqQ0CMhuiJRbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621938; c=relaxed/simple;
	bh=3gm17y1RSEH1VYQeFlagBre9KU7Ghqq6XCqfV4+GsD8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WEkcw/AwvjxZ2YrUlUsjYBlBtibImw1mXYKq/mUAy9Bnmulpfc8wlv1xhAZl2YA+kXbhxo/gHOVnOdrcd2Zv9X2t6KCK5PRHAEgD3CxYzzGLQuVZjfPtjMYxvpxvc0AKcdtSaxFMQ5R0tK1XOJt0A5R3A6nN010usUCJkn2Hkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFKtniEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QI9P3/F+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3vEV81CYL2KlTJwTTqBwLPja2VeuGCFyuqaHx4+SVI=;
	b=eFKtniEzHybDafazckcYhzpxgaqDJMXJ5fwmI+mJxpRpKPdZTfnWs9fs/YqO5r3ww8R3nq
	uK+T3kjcllluUPtosgM91XSLLaIEEfW5K2h8zo/y0A9vwzSK7YYv5NTKNvq7G2ieh4ggKj
	1oZvellsM3hRRZ1edrxVan/32h4V7933mMAh2Fa9TFxc+YOV2JXEb7twfIU295Piy44PdJ
	HAL5jronVhafmcCeMsufJ8YSbab3lEroANgdQL4wjv7CFeg17WpYEGgzgTW0hSeZYnM1Vl
	78SKdwZNutggaadhoVTEZwEmQLpEnkca2O405eVMfn6cd+FjIpkKjODbTd+4mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3vEV81CYL2KlTJwTTqBwLPja2VeuGCFyuqaHx4+SVI=;
	b=QI9P3/F+s3Y/wVyLYvrz7dUnhHqul/OV+c99LhURmNgDt/cihxdW35ZR3htKnY9T8MkeAP
	ZRPOLzr2IZZmUHBQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] workqueue: Use global variant for add_timer()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-7-anna-maria@linutronix.de>
References: <20240221090548.36600-7-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193393.398.11899642362650399593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c0e8c5b59949e8b8b004481c99e102df606fc312
Gitweb:        https://git.kernel.org/tip/c0e8c5b59949e8b8b004481c99e102df606fc312
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

workqueue: Use global variant for add_timer()

The implementation of the NOHZ pull at expiry model will change the timer
bases per CPU. Timers, that have to expire on a specific CPU, require the
TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
dropped. This is required for call sites which use the timer alternately as
pinned and not pinned timer like workqueues do.

Therefore use add_timer_global() in __queue_delayed_work() for non-bound
delayed work to make sure the TIMER_PINNED flag is dropped.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-7-anna-maria@linutronix.de

---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a2..78eaea2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1961,7 +1961,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(cpu != WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
 
 /**

