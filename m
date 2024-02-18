Return-Path: <linux-kernel+bounces-70516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710428598C9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9724E1C20DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03B762FB;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxf6wz3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wm9tfqa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292D7317A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282679; cv=none; b=nPpM93eBy+4c56RG3dRpRKHaeKRaNf/2YxTC4zoABYBM+UdoBdn1veetzkAhV4YhLPrRX7mLRvR3CzqcVmHuHsgGESvJDu6ubKl2iCAf0oUCppHh6Es48s/nL0VuAL3oTk00GboafuvpyKdiH1BsNpj2VlIXJUZyEWa+xSQcGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282679; c=relaxed/simple;
	bh=9MS2P3GionMP7c/6VZMtfIJf7yMWxofhT265EbuKiDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5vW3rahW7wFn1bkbFGNkQ07MvFg9JSsoUWBYhIY7BefMZM+xCqcxUaN96gTGuym/OGCXJ9FlfU/3nWSaLcwIhP+meX8wQimcmQWS45MTMlHor8ACdZhfxqEYpukdpwkf8DbRLlV37zSFCR3KahtbErh2kmifDwebBTNLpPc65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxf6wz3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wm9tfqa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUbvpoY1vkrIaf4t1+bOO9YGAlSrhJitnWRmUehFKmc=;
	b=kxf6wz3GUu4qdeFhzXpICe2cGfNBJSkLoT82KX/lAcZbK1dpaDV/emR2wz9uRLKOm+7pfV
	X+65xFM6mk8goNdIDmv2Jm7NzIGQE0DHhH/fVd+3jNKDsTSF/cfMY8YcxIz3z8RKWnF4lH
	4yAjPwxF7ORRa1JtkbmQdQLOx04iIefHtB3a34F0yRu19Yl7rKB17/M3lnBFsI52GYqL3m
	kGPiT6n+5j5nKi6vPBIyJ0LRhiqo9I9qM6neXMzdICMbTtpcsLiU2b47FmUcOkziXOeCyY
	BmiguoKf+t3UIdk5pyMCAUtol6CnxZM50YfQ0OiQvu68h708WfRRiJUnaOqDbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUbvpoY1vkrIaf4t1+bOO9YGAlSrhJitnWRmUehFKmc=;
	b=5wm9tfqaTzyXeL2PKtyecqBe9en8uVauawNKYe+bAlM4JD8JFvwFjfMjY+AJsxeI8QH6y9
	U5DlklXhgWwT55Aw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v2 23/26] panic: Mark emergency section in warn
Date: Sun, 18 Feb 2024 20:03:23 +0106
Message-Id: <20240218185726.1994771-24-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Mark the full contents of __warn() as an emergency section. In
this section, the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console output is
triggered when exiting the emergency section.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 86813305510f..d30d261f9246 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -667,6 +667,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -697,6 +699,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2


