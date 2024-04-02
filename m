Return-Path: <linux-kernel+bounces-128768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A683895F71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1DD1F22FC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA015F41F;
	Tue,  2 Apr 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgmJroNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nd11a3Qd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0D15EFB7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095901; cv=none; b=T8Hp8h2FD2prrR4+zZFkKlmmMQi6Oe/u7nCvHXayz6ZoZVEELnjt9tM692fza2JaVbdD1Qr8djO6rS5WUQaQTRHIOpEdKxLFH1WlQa+BpMhHeIsJa/ONnqzcjMjpYDvPWDB3e8yAozUoVFaw6759QQCbVD10y+7RgytBkEyB5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095901; c=relaxed/simple;
	bh=BL7aciVtdhyBPsYEVBpNHekCxnl1nHBbTv2QZkJVau0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV04oZr2CJhBDsl500KCPTU+Sqk/ZSC5H6+7vfY86q5vj7DUWp1wTCYhvVn8VYyLAC4vGkXuEUABeHUCXmyQ1M+xfc//JqSTCg6TlqFKEMIhkWdKjsA7yUGDTKiAoFGjMvn8FFBVkw96Xl6j5P7PnQI4a7z8duThkmdKx95hquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgmJroNo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nd11a3Qd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvqMC7tvfcOdwAxpMAcwYIY/7Ftke4WwpmbtwMe36rM=;
	b=MgmJroNoSgntuBNnk/JNtvXlfv3FMAZUrKbSLeSvFPZzWLOpd/17SGZI7TuNfcNCo1lfFk
	KKTqsCxyG81tjTZho05NXObJ3yN/xVUK9OZ8hC7eRzlS9NvMcaAUFqn/fNTdr2bC5/RzkA
	SDltAEJv2/iTa09JCyR4cgkzCmqVugogoiCvt8SWnx0f1JIVHswHcrkOeA2u+mEKruyb04
	5zVB/7rx6opKg4F9CM6wLTZA2WqQ7/BIbjKHWYqPm303bpKG07DHgMFWq8B1n6wTNdCTQh
	EsQsUmRmp2gWp5rxltXlvyG23pywBY3viPe+9iElbnXzCLJwnsChZyahxEEihQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvqMC7tvfcOdwAxpMAcwYIY/7Ftke4WwpmbtwMe36rM=;
	b=nd11a3QdIaOP1bHTF1XOOKFa0cyJUpm3KinO1YHj6UEo8NmZGcSBbyZ3vO5D8+on5l2Bcx
	3VkcScatHskklcCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 07/27] printk: nbcon: Use driver synchronization while registering
Date: Wed,  3 Apr 2024 00:17:09 +0206
Message-Id: <20240402221129.2613843-8-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on if an nbcon console is registered, a driver may
handle its internal locking differently. If a driver is holding
its internal lock while the nbcon console is registered, there
may be a risk that two different contexts access the hardware
simultaneously without synchronization. (For example, if the
printk subsystem invokes atomic printing while another driver
context acquired the internal lock without considering the
atomic console.)

Use the driver synchronization while a registering nbcon console
transitions to being registered. This guarantees that if the
driver acquires its internal lock when the nbcon console was not
registered, it will remain unregistered until that context
releases the lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b7e52b3f3e96..cd32648372a0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3448,6 +3448,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	unsigned long flags;
 	int err;
 
 	console_list_lock();
@@ -3539,6 +3540,19 @@ void register_console(struct console *newcon)
 		newcon->seq = 0;
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
@@ -3563,6 +3577,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
-- 
2.39.2


