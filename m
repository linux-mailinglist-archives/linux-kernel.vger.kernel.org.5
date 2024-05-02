Return-Path: <linux-kernel+bounces-166963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CA8BA276
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B9289B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7791C68B4;
	Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZe8W9Sj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5+n2CmFo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48241C0DC7;
	Thu,  2 May 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685932; cv=none; b=Jm3YfVAOgson00w19oSqyoVohD4WPLY41HpqaiQP4spe1Rk6dJxpsUihBE5O0BGQ9zEPvjKzHS7Yx29Ipp4UBgbDtrlzJt0674uKIKjZekkZvJXmum+mPbV+AZBhhFks2n/1F1OIbKtBpv/q9/mW8Fz9ynLtZ0km1yAYN8Evxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685932; c=relaxed/simple;
	bh=srR/EU4bu+X+MU/e0RZwp80S2gQQhwvRUTVL0x1Wui4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6UclchGm1F/SImaEabufpvfa0Ex5j51gWpSVxYT+Ds7Fd0Qj98ng4i+XGD7BF4WfyKPF+TkSsPAXbTIK04Y/D2ckDeFfbDxA4+eRnKW9PJhlYP6NvMorCHQcdCOLFuMrBhPjWECDkS9fwbgl8PePlCB6VzHxNLPBX2bgXICjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZe8W9Sj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5+n2CmFo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMOfjsio8q+enlxkVZ0j+9BtcTeI3xwELU/31QEEo9o=;
	b=aZe8W9Sjo3BYhl80HQeLmX3SjyegySo8XXe07/p5OKOmdjIzHZttvHGXsrm5YcdoZ3q+xl
	gXhJd+vCDShiQyfCOvE6rIOqZJv8Wv/VJer3vtqsHCe00pbXQXDn08NXlaGsykeJj1iGFk
	CdSzFHUD9jd7YWHMbN0nT5tGSSI4dmSlzw69YuhGUtrxu91tMfM5/uAW9mJVyJceWgNfBU
	lH95YXgbBZCR2x+tEY+e8Exq1ZKtKAFqtmQgey4M1IfzK1bZbMybpafWhz661OInZpzkrJ
	YkpignhRhoSjqtOwZ1BivJ3LnyiKZ3sTzgS3zH5ak2Ygab7CR7BNqGbKwvfR1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMOfjsio8q+enlxkVZ0j+9BtcTeI3xwELU/31QEEo9o=;
	b=5+n2CmFoXbxIeCA3Cwr7AwJnIgNeQK2rxGV8mSQRmr2drfyQmhdUe+LxttrwvFxo7t5Bnu
	49wei5CgqPJRv9CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v5 12/30] serial: core: Implement processing in port->lock wrapper
Date: Thu,  2 May 2024 23:44:21 +0206
Message-Id: <20240502213839.376636-13-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the port->lock wrappers uart_port_lock(),
uart_port_unlock() (and their variants) only lock/unlock
the spin_lock.

If the port is an nbcon console, the wrappers must also
acquire/release the console and mark the region as unsafe. This
allows general port->lock synchronization to be synchronized
with the nbcon console ownership.

Note that __uart_port_using_nbcon() relies on the port->lock
being held while a console is added and removed from the
console list (i.e. all uart nbcon drivers *must* take the
port->lock in their device_lock() callbacks).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/serial_core.h | 82 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 038693774f21..a2f307dce221 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -12,6 +12,8 @@
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
+#include <linux/lockdep.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -623,6 +625,60 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 	up->cons = con;
 	__uart_port_unlock_irqrestore(up, flags);
 }
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_using_nbcon(struct uart_port *up)
+{
+	lockdep_assert_held_once(&up->lock);
+
+	if (likely(!uart_console(up)))
+		return false;
+
+	/*
+	 * @up->cons is only modified under the port lock. Therefore it is
+	 * certain that it cannot disappear here.
+	 *
+	 * @up->cons->node is added/removed from the console list under the
+	 * port lock. Therefore it is certain that the registration status
+	 * cannot change here, thus @up->cons->flags can be read directly.
+	 */
+	if (hlist_unhashed_lockless(&up->cons->node) ||
+	    !(up->cons->flags & CON_NBCON) ||
+	    !up->cons->write_atomic) {
+		return false;
+	}
+
+	return true;
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_nbcon_try_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return true;
+
+	return nbcon_driver_try_acquire(up->cons);
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	while (!nbcon_driver_try_acquire(up->cons))
+		cpu_relax();
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_release(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	nbcon_driver_release(up->cons);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
@@ -630,6 +686,7 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -639,6 +696,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -649,6 +707,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -659,7 +718,15 @@ static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *f
  */
 static inline bool uart_port_trylock(struct uart_port *up)
 {
-	return spin_trylock(&up->lock);
+	if (!spin_trylock(&up->lock))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock(&up->lock);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -671,7 +738,15 @@ static inline bool uart_port_trylock(struct uart_port *up)
  */
 static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
 {
-	return spin_trylock_irqsave(&up->lock, *flags);
+	if (!spin_trylock_irqsave(&up->lock, *flags))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock_irqrestore(&up->lock, *flags);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -680,6 +755,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -689,6 +765,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -699,6 +776,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
-- 
2.39.2


