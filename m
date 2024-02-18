Return-Path: <linux-kernel+bounces-70533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC768598EA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2FF280CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC497316A;
	Sun, 18 Feb 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbZvSBMy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1z8+tEXm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85546F09B;
	Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283075; cv=none; b=ooRR9dVBI0UcwFBp8zIu06DK9/rxerYmFct6AmLUn7jyUakUNgdr7qkCGAvXruL52KFwN0DLJG75dCyunSMNqYOJzTSBNqKvGhzGUUXdA7F2rp/ykjNJx0BPf4un+CWt7y2QXCMAzy1+rWO+AuXWLo6+XmjBqUQ76GvKySzyQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283075; c=relaxed/simple;
	bh=HasGcnsQPSL+51DxJXDfrG8HXukFZjehWiaU2ph0T/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORgepS+1ySG5mjfXLwPqsP4+P20CTb+DUSFCApEEpIugvnCrltawIBltJR9w9rmcSdgoT2eDZ23cHFunsSosgy4j9FArazqM0fW3uvyMKRFLVtFi9BtHeKzV2AyH0+cRspq6POEtt55K1Ioed6UMqRKiPOa5DGnTGFVpd+Cs+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbZvSBMy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1z8+tEXm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7h0W3N0f4G0pvkySvFkTqS4E2wnXwr34/jX5hTg2E0=;
	b=QbZvSBMyDM4LOXmsINAW3w29lQi6+iV6oQkdlkV+GEv4sBYFoXHoVGk4LYf57RGYMZm3Lw
	Agq6rijvE5UuJlE5kduRrbGQHWNTHZ7CR9JG8p8iIUoQuYgOuogv5b5S2koYAlFnLykNpP
	BIcvF321vrpUKDgkTI0JnGQe2D69ltp0PKCjHlY/Mio9lGQw5UMcCHy29ZOajsOxjue1cB
	X4umV+QaQqzODLrSyJc0ZAuZGJSYcA6uKzldZvSMX5nPRvUH8cawUaTYPzzZo2d2OuzuIW
	R+dkjjwKUNILaScRlyDCvBK91fi0MuotaUffV7vgIsZR6lqLkcsmWhCZvm9PCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7h0W3N0f4G0pvkySvFkTqS4E2wnXwr34/jX5hTg2E0=;
	b=1z8+tEXmXQ18FV+rBWbYgc0kRFK8G2HiNfmJFiIet43GfimLO57gHMXL7MJAJy1NTAVxVb
	5IVL+++Q0XAAiiDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH printk v2 01/26] serial: core: Provide port lock wrappers
Date: Sun, 18 Feb 2024 20:03:01 +0106
Message-Id: <20240218185726.1994771-2-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

mainline commit: b0af4bcb49464c221ad5f95d40f2b1b252ceedcc

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

Provide wrapper functions for spin_[un]lock*(port->lock) invocations so
that the console mechanics can be applied later on at a single place and
does not require to copy the same logic all over the drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230914183831.587273-2-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..f1d5c0d1568c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -588,6 +588,85 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/**
+ * uart_port_lock - Lock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock(struct uart_port *up)
+{
+	spin_lock(&up->lock);
+}
+
+/**
+ * uart_port_lock_irq - Lock the UART port and disable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock_irq(struct uart_port *up)
+{
+	spin_lock_irq(&up->lock);
+}
+
+/**
+ * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ */
+static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_trylock - Try to lock the UART port
+ * @up:		Pointer to UART port structure
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock(struct uart_port *up)
+{
+	return spin_trylock(&up->lock);
+}
+
+/**
+ * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	return spin_trylock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_unlock - Unlock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock(struct uart_port *up)
+{
+	spin_unlock(&up->lock);
+}
+
+/**
+ * uart_port_unlock_irq - Unlock the UART port and re-enable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock_irq(struct uart_port *up)
+{
+	spin_unlock_irq(&up->lock);
+}
+
+/**
+ * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	The saved interrupt flags for restore
+ */
+static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.39.2


