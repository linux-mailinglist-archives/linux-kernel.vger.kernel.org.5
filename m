Return-Path: <linux-kernel+bounces-166957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1448BA26D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CCB1F21281
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FC1C230A;
	Thu,  2 May 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kk8VD7pT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8Ey1dq2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61C194C82;
	Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685930; cv=none; b=UemXEzY6e5xIShaGgDe2nxpylwVmn2hE6Y/3KXRZJ1liQFIGNMVSd9naS6Jr+YfyJ28moXwXB1GfgJG/kPTqsgYXQj9IVhQDTzVY0TeKsDoCz4VRI0VsUwQN6w/iPdCNiLko2CoW0RX2Kv5svjC00uTuMBpcQPugcGeGYOgFoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685930; c=relaxed/simple;
	bh=AiH8EnN6GRzi8B2qcObkU/HEqg04wntd+nSfmS7tVhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obfO9Jx9jODlMDaiI9uhEyvOHV+zyYGQLwlOSwF4VPhLWTYwLkv9SGfbA6R8ogWlPB9hN/mjNHhTa5JDdnrQv6dlH078UmLhx05AYS2oBd89JgLay1sz9gEYBE1rj3j6/sLtW2RuZbIjI5GNQrgNGLraLEeYtJQqe2xDeN4/nY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kk8VD7pT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8Ey1dq2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkEmSH+TeCzW4mgc3Qx6oM4UTLT7owCiQ5MwVZZnUf0=;
	b=kk8VD7pTXAIheqaqkPXOTdrJTW8fze+gim+F43pfEbl+kcsw+kE55hvDaaTRjDKKW3IU64
	XJIxmLXffSvx19JZym3M30yfv6/1oez7u9mOwI2a9AA9oFwgb7kWBjt+kG3vZQWuddTDLH
	tYBQttmPIKGxkPVj4w/O66KaFyTcZFFBxqrlAFst1cMDAYu7A1ISvzjvZfuJcMrVbx0YAn
	iFRrXMhBh2+aVEAg3Ls8RiZVaDMiBbI5ut6MEonRVYqIttJq8uF6V0GZlPhpVwQG1710dr
	Yz3nXr3UYp+13YjUlj7NFxMj27bDsQBdX/t6Y85xNSszUr6MbeYETGvTqSaSWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkEmSH+TeCzW4mgc3Qx6oM4UTLT7owCiQ5MwVZZnUf0=;
	b=s8Ey1dq2S0Xo9P9sf+bTQCXOfYgSv/3zPCVQmslOZEzOEnoaaNgTxYePAeg0mWF2R+TPew
	Er6mGVceIF4vDOBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v5 08/30] serial: core: Provide low-level functions to lock port
Date: Thu,  2 May 2024 23:44:17 +0206
Message-Id: <20240502213839.376636-9-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be necessary at times for the uart nbcon console
drivers to acquire the port lock directly (without the
additional nbcon functionality of the port lock wrappers).
These are special cases such as the implementation of the
device_lock()/device_unlock() callbacks or for internal
port lock wrapper synchronization.

Provide low-level variants __uart_port_lock_irqsave() and
__uart_port_unlock_irqrestore() for this purpose.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 55b1f3ba48ac..bb3324d49453 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -588,6 +588,24 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
-- 
2.39.2


