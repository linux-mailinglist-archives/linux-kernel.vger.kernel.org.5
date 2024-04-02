Return-Path: <linux-kernel+bounces-128767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E8895F70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333061F22B73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BE15F41E;
	Tue,  2 Apr 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pV1zFXK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zluu/oDS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192F15EFBE;
	Tue,  2 Apr 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095901; cv=none; b=skC+nYvAMzO2W7ZH8tLb5v6UyhAWpJnEyTn97Y8ZWpCmdjqrxxtg9yyWxPhNIryOO+/yRVLBtBD6oUSMZh/cM3J+0e0noTDu3ivFltnr6EudkahLOm2spIfpOlDsSoZYDVTBTR7Ue2M/OMDR3w1vKJUSqoGXePc+vf6eqx5GTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095901; c=relaxed/simple;
	bh=/X5uefQjhA750hOZTgQlvyUovMXIIaaI0zWJuuBr4mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/UTyo8ERb5QH2ivoEwuh+PWsMa6fxF9FgyYm7hWMvk5A8BbuNDYwMNkTnzmAWpNHYAwgth9k5uvllJKZq22upEqFjT0H8J9M6IzmkR7eBFYby7UFwDJ+T+HFRq5kd19YaSmWaSdJ8QKD67Jl2DlKmLzLg2/6F4WIZhvhV5T0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pV1zFXK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zluu/oDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/D3T0A0n/PKPue9SIuCwjpbic3bBzP+cAanQ+lkJw=;
	b=pV1zFXK7RAbppXFv2IS8dg+AhtNAnjopkWGUF2CklgX9leSv1mvngtanG0zDD1M9HcNiHt
	8fgHYo5P8BbLt/aOwP3OikrckUHgIXnFXFsFnXgxKX6BmLbStdCMdhu9kpQFllBVHoQg0h
	fj0rw92Zqk/LjGUqdggnaA60qWJODj5iJZjC9jGuIgMQqR8SCMdwE5PNERKXlHQiHLXheJ
	BbP2Umkls+hFnaKPkQFa4K9qFA79Cu2raSBpUaIArQx1ryayBkqFCkT9MK3nowVRGRGkOG
	EYSjzfuOKFdN1ETE8z4xRRDNz47WK0PjleGmNUApfrmwkJjihrO7Xf8FImquyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=np/D3T0A0n/PKPue9SIuCwjpbic3bBzP+cAanQ+lkJw=;
	b=zluu/oDSmszLBYJ/hpp2azudGkY5hPIYhQCXTs+b4t6Ld8QirZSsrSrRdoTSFQ98bEea+L
	RS7F5AOcNjPlSuAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v4 08/27] serial: core: Provide low-level functions to lock port
Date: Wed,  3 Apr 2024 00:17:10 +0206
Message-Id: <20240402221129.2613843-9-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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


