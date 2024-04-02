Return-Path: <linux-kernel+bounces-128785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651C895F84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675881C224C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE5016A99C;
	Tue,  2 Apr 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jEUQYJPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8UYn3jmD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E516A1C5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095912; cv=none; b=bP+UkWFZOjq9+FGXEhcASudnVExqG3Ap0koR/g20CpgFcz3q3XdugU5vPHCnoxk1ONNAM6ylyo++I6TWWYJetS7nJ0kIynAx+PTpiudvhDxjR3Y733u1O0yHsyY/1BYkhra6YrqRS2H/Aeya+fkLqTqEZiykYL0VWpE4WvE1n4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095912; c=relaxed/simple;
	bh=c6akV9Q4yr/rVYenMeX346mAEuxD5wte66aQQO78Ys4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDnggPWLFPNACVCD90QsjsZlhZQPDul+rkHWDdlVWG1+Z/9PnhCiIxaQLEPcKVkp4KKpxibIBdpSfg6W8Wa4AMWDtpOwVshbrXR9908ZGufhHos1P8g6V8QSfrSFa5iRrAqOKYxv7i9GZMVmU/V8zX8aQ5N/pY+/Ra2I68fppys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jEUQYJPU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8UYn3jmD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRn0di1HIXp5SiW2VwTfWrnEOjP1EiU0PA9D4LBG0KY=;
	b=jEUQYJPUMBBAm3IA0xtFogfZYqN8W6tk7xUNjjINI11G289jXRJUfyFKHWIKN6MR0k3jUk
	chUu61nuVRMycoinG+POGGDHbT+Du+0H4G7cHJfJhOKhHyVq9ETm4wVvcxeFM5lGJLIbqu
	MO9cNkOVpeWzHpS+gFgYb7vZhbAerUSJBna/pETFTuLBMoUJg2C+XYPmU7qr75br10XZZa
	uK9Y5W+KeqcsoINaRAyAI9FR2pnMH1lNuXPMXQ8m0M4QD99O1yBkP9vu57rRKrFDRUqSFL
	FRWCKjEnBp5xHVHUge5um1GmTTJwLR7FxKFJRdWHSX43IrdjgzRbtWl5MyKDDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRn0di1HIXp5SiW2VwTfWrnEOjP1EiU0PA9D4LBG0KY=;
	b=8UYn3jmDJCT+vLtiD+HIuun0WTy8GnE/FgLQA8pHn/0RkeFSKs9TW1kQpbpyPxGskCjZQV
	qLOR3bfzO9aCTWCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v4 25/27] panic: Mark emergency section in oops
Date: Wed,  3 Apr 2024 00:17:27 +0206
Message-Id: <20240402221129.2613843-26-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark an emergency section beginning with oops_enter() until the
end of oops_exit(). In this section, the CPU will not perform
console output for the printk() calls. Instead, a flushing of the
console output is triggered when exiting the emergency section.

The very end of oops_exit() performs a kmsg_dump(). This is not
included in the emergency section because it is another
flushing mechanism that should occur after the consoles have
been triggered to flush.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ee03193f9495..3754a2471b4f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -634,6 +634,7 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -656,6 +657,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
-- 
2.39.2


