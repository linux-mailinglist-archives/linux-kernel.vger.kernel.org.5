Return-Path: <linux-kernel+bounces-166958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66748BA272
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19173B24877
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53091C6617;
	Thu,  2 May 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wnIbi3yn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQoBQxyc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0C194C84
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685930; cv=none; b=iWDExgfhmALvkgTiIakc3wldt/PZbtONTz6h1I4FMIt7btnjOcyZw4No2oSAYhypxQ1UoiTaJ2H2uUvDkopLxodA5OBhuSrVi4fUuRzzkDCGx2ph6PC/7U+b0pg65I+CPlvgoEPaI2EBtAZIEq6OCdFXNOjpPa/Hzwo8FrGD7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685930; c=relaxed/simple;
	bh=TpqIckwvGSQpdKGqCSiygziHu6G/RKJgVV2bED2IMjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo4jQxz2tCuifs0yyRkTwTvywjpv1YC+o+UPolRAgltjgcbQV4IS777T1KYvkf/etO48xAG5VVd9OxhojYqPnAxQaKuQYbfaF1ZM6pQaLEP5Azpzc8xXbMs1EGYPmt4YSsQ2xwR17dLLsVqG86Q9AFdB/nVI5TYnF+ZCUKBp3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wnIbi3yn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQoBQxyc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFo66fB3Dr4Q0iDMaowiC7x8lIqphhEIOzcW8UZuab4=;
	b=wnIbi3ynycOQsHazB1brRXRuRYZlyybYoMQaOPPPtQSY18itzKVUMa3bTHPFNi+wSNBoRO
	LKu5cZPhnDAoLWgVxdBlaMhcTs03yUjbpv4/hM4WlPGyi30cBu5TgbjFWem5MHvbWppkuV
	xBFGb4v8zzU6qieTx8w0sGnPCp/7b9aIYB1lF/AMWgi9PJS3BXh0MN9zK7Rd7YVkXGE0uF
	1QlV2wQgNAZhcjtlQ2geSFnq6t75A/9vH1WItppvPKJyzuip6qIrcVmq9uPy51Q6HiyeLG
	Ex5QhX1AcpWI/NUAfGqp4iGFzri+Hk8d5ASz8zwduCnZfDiIeK4yjRyREl+E+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFo66fB3Dr4Q0iDMaowiC7x8lIqphhEIOzcW8UZuab4=;
	b=nQoBQxyc4wvn8p9aSROxofDmeC77kkudPik29ElIS2AHPKRgWOzt9hU8Yk1Au8r50vemEY
	tLseV/JikeGNTEDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 07/30] printk: nbcon: Use driver synchronization while (un)registering
Date: Thu,  2 May 2024 23:44:16 +0206
Message-Id: <20240502213839.376636-8-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console drivers typically have to deal with access to the
hardware via user input/output (such as an interactive login
shell) and output of kernel messages via printk() calls.

They use some classic driver-specific locking mechanism in most
situations. But console->write_atomic() callbacks, used by nbcon
consoles, are synchronized only by acquiring the console
context.

The synchronization via the console context ownership is possible
only when the console driver is registered. It is when a
particular device driver is connected with a particular console
driver.

The two synchronization mechanisms must be synchronized between
each other. It is tricky because the console context ownership
is quite special. It might be taken over by a higher priority
context. Also CPU migration must be disabled. The most tricky
part is to (dis)connect these two mechanisms during the console
(un)registration.

Use the driver-specific locking callbacks: device_lock(),
device_unlock(). They allow taking the device-specific lock
while the device is being (un)registered by the related console
driver.

For example, these callbacks lock/unlock the port lock for
serial port drivers.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e6b91401895f..15d19d8461ed 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3451,6 +3451,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	unsigned long flags;
 	u64 init_seq;
 	int err;
 
@@ -3537,6 +3538,19 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	/*
+	 * If another context is actively using the hardware of this new
+	 * console, it will not be aware of the nbcon synchronization. This
+	 * is a risk that two contexts could access the hardware
+	 * simultaneously if this new console is used for atomic printing
+	 * and the other context is still using the hardware.
+	 *
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this new console transitions to being registered.
+	 */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->device_lock(newcon, &flags);
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3561,6 +3575,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
@@ -3589,6 +3607,7 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	unsigned long flags;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3607,8 +3626,18 @@ static int unregister_console_locked(struct console *console)
 	if (!console_is_registered_locked(console))
 		return -ENODEV;
 
+	/*
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this console transitions to being unregistered.
+	 */
+	if ((console->flags & CON_NBCON) && console->write_atomic)
+		console->device_lock(console, &flags);
+
 	hlist_del_init_rcu(&console->node);
 
+	if ((console->flags & CON_NBCON) && console->write_atomic)
+		console->device_unlock(console, flags);
+
 	/*
 	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we
-- 
2.39.2


