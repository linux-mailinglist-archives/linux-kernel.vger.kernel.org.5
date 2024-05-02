Return-Path: <linux-kernel+bounces-166979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453B8BA28C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47E61F21285
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168B21018D;
	Thu,  2 May 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXQO7XfS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n88rBhwC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAC200127
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685938; cv=none; b=ZVwGegnv/giP43j14ZPxhGVErHKx57QUP928SIZpS+rzoUbCHmVZjIkritbh4TqY4TZN2Q/R9zP8U+mZKx4NUNgyXxK6bCasVmU0WnWS+u6uX0weBvNdp78Apxq2zzYl4dv80Q4DpaVMB1BzKAEms3wclHKaFBU7y+NPATXbQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685938; c=relaxed/simple;
	bh=ApV3BrzIy3FzvWp+ns3WoghCqTJI0MOJzDStPgz0cJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUvxLGUuMOPDhf9zUNvL6NBoBAW+1J2fYrD1BIVOXu1AM5yoIk2ShWxfnJ+kSVEdbvvlOk3ri7oatIBiFkRTyNtzp4R6UWiFSISLsyzXbu+rvxF6KAtIVextN5ir1hL18l9JK1/uYpqkWQNLK8DxEdhW++CKg4rWHeatg+BaSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXQO7XfS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n88rBhwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypq720fklC/HaR4UTxfPN0fK1+MPpff79Yq5uFGIqB0=;
	b=cXQO7XfSN9tVIahWJBnVRk9/NuzKFtYcODXtqO97f0RdomlvjPrGKpT64jFJn8d9oi+KzB
	+OsIlc71W61ovDYtJfBKxHBDLhFGENjN+VZz1mXE/ZnkfweudCF2tzHIpMkzscb3QjU30q
	1YM2VVqn3bTq8FRZFxRigp6A1cI9oUo8kkr6IHaOsEP0ST449o91o/dArVNQYk+gb0hGzR
	Ou7X+VNxWz4KbEgwMwqNr4ejwRloq2IwPOu40t2TkcprKJgaUUMrjYSwMhDkILebpOwed8
	pJ+4sfSj6y/MUNwhdiUyBT5z9Efg2loXf4LDfVM6ZNtwAdxkEs33uvWlnF3ZrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypq720fklC/HaR4UTxfPN0fK1+MPpff79Yq5uFGIqB0=;
	b=n88rBhwCRrPVvc8GBpeigqEBKog+cA8zT/E2ErrYVLMiuFwxqQMV8NERGVIDDyHHRK/P4S
	WpKd5mkQtLalzxDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v5 28/30] panic: Mark emergency section in oops
Date: Thu,  2 May 2024 23:44:37 +0206
Message-Id: <20240502213839.376636-29-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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


