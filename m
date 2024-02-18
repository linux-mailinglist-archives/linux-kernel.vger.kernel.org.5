Return-Path: <linux-kernel+bounces-70517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7969C8598CA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1AB2125A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12E762FC;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ctirOIaN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqqpxluB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B973198
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282680; cv=none; b=FRfx2MhUkqDiKpd1FenA3lmhxgcxpSHOr6pmymypQNz1K531ATUuYHQI4fd3cZqekERkSNSmG6+yD0XnxaABv2x3V22oq/IyHUFZ3k5t0zU2CERFkO2AZOqqcnOQofpAoBTFwvnw1szfILnoKVtR8oAQFUfxqA/U5QADqiDArG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282680; c=relaxed/simple;
	bh=KzZOuY5lO3xJJiP/W1QN+WoXmg5dBEU4teyAhbH6PyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhGxNcUIbkS9OP1rqDZcWodK6ojIBKL0YCafEtygoppKL6NOT6yQaELhUzbhjWoIeq8yngbOZNeQgWo0x04U/opmwg/ABi3cABNKy9hgS+NWyNq4e6N1Ittjwf1I81PbIb4mJoytunPeK+iyuVDZ6aC8QmiXQjzy+/Qi2+G13tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ctirOIaN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqqpxluB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuY4H6DNfOvqdhuJgmJkGITg1xVtZYUjr6s1BV/VGVM=;
	b=ctirOIaNRIvgvx3YlEoT7eH4LHmxuqM1FokSoyH0oWhdq5jTYW+lYL/44OKj6rsAY5RpHU
	frOqOjhxm1qw2g0xiZ155kVd/OxpvloShfzpNUx01Sk4PcAmjHDs5XFq5SY3zojwP44Niq
	kzuFFtUdhdYhkhJLWdxnh7H0aJNevyyCAHMDzAD1jkPltPwhfq/vDUtYAATl5c/c/QkGSh
	YhQOiylqDCC57M3b5lC4o3b+XocaT2fVAfMSuZLrpWxyx0vIeYKO/wyA9D9YvImqOK+KfG
	4ygRkaJdPAqFfgSlKNV+NsklnZIxpcjlLBCaLg1NSY7N9DGFfkGz0zQmyiqZ5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuY4H6DNfOvqdhuJgmJkGITg1xVtZYUjr6s1BV/VGVM=;
	b=RqqpxluB27iUY1upXjEPYku+xInDFnSzwmsETUKpBmIETtkeLCPFtzkFtxr0vooC1/lybD
	z01lu3AituTxVGBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH printk v2 24/26] panic: Mark emergency section in oops
Date: Sun, 18 Feb 2024 20:03:24 +0106
Message-Id: <20240218185726.1994771-25-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
index d30d261f9246..9fa44bc38f46 100644
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


