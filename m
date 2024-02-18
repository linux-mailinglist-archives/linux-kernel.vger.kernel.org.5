Return-Path: <linux-kernel+bounces-70531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1138598E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEB028136B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40073166;
	Sun, 18 Feb 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GM/VNnAa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j01hjXjY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862D71B35;
	Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283075; cv=none; b=LzSIsjVjU01EgH+UhpArRIBW+cwraqci/+/xd+3977Ou4bISM/mjZSym3Igv7GurW37Svg9t5GCsr8Q9eOmEW0u+f1HvZblMAxtJiHOA7AVqUOq9gYhXNWnP3mkauYViQpZlbQvyrFh1y4BP9zTdgDcGzjTQ23U4c2ne/1AlUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283075; c=relaxed/simple;
	bh=MO6Y8tj0NIiymjFHpZwGZycpK1m0Vc+X7D6vRJLm6OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrEYbWttJArkFXIjF+xMLBpbPbfDh/5zC83kX4/AaxPiAyfZCfYDJZoaTZKSn960hiak/SKfzRTNF6nXvzezIDcwxPeaKpYv3UBWl39HByt0fI57OCCuHe+YWHgoU5I7W3oZZ2KZNtood2uRjhGOxySf4M7xlA4jwFqevOQabEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GM/VNnAa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j01hjXjY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K5mFiabL7N74FJZwx3sG2fqkTYhk/mX6rh+7t2HHdE=;
	b=GM/VNnAaXsfrk931JW7tOsC8rSnrcoVqetLvg7dHTNoaA0biAHVOo0QDOQZHWoeseZkkwM
	mRFZ9mcxot4t+TcgT/BPvpiknWQs1OH99Fhd8aPFXFwDfpRwYOpkc7KYUHJfcOa5N4nPDe
	pwPSogdC84OLic8N43gLNsWNSSyLgBEKssAc9aR2Ts/+DmFWiYxqhtAHK6nP47dn9C2iUv
	xiRwnf80gRKlr8q8/oWpv3LOCgWxj8qd1UJmWMqWjLMZ0Rb1zHUS2ogv/C4SVqphfIdATV
	Sd2b+8wJRFJh+jdsehIsvBCLThyeZsFXpZQFuJqj+fdo8czdgU31ep9pzrk0Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K5mFiabL7N74FJZwx3sG2fqkTYhk/mX6rh+7t2HHdE=;
	b=j01hjXjY0lEpNjUkrWN71FG4yDfhUXPiKRay1EPW8PknNnIXHNnQV9wJESzRbUmBKK7NOA
	lIzvZldl2ebOclBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH printk v2 02/26] serial: core: Use lock wrappers
Date: Sun, 18 Feb 2024 20:03:02 +0106
Message-Id: <20240218185726.1994771-3-john.ogness@linutronix.de>
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

mainline commit: c5cbdb76e8e33ce90fec2946e8eee7d71d68e57a

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

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230914183831.587273-3-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f1d5c0d1568c..3091c62ec37b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1035,14 +1035,14 @@ static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 		return;
 	}
 
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
@@ -1054,14 +1054,14 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		return;
 	}
 
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
@@ -1077,12 +1077,12 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, u8 ch)
 }
 static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 {
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 }
 static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port,
 		unsigned long flags)
 {
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
-- 
2.39.2


