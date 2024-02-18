Return-Path: <linux-kernel+bounces-70534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847F8598EC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D960EB20A03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41C7317E;
	Sun, 18 Feb 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzsRMOH6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTmN1BPg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858E6F507;
	Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283076; cv=none; b=ppMCEYoH98Tb/WHdKsxaa4ATXJb0XjB+OyuMqdyp01u+EigJTtTOqBhAwEjL6uzYiEjF1WlrZYNTBhxWpNZ5EGzzlnMWD2jNpVJ8nyJx0GOIyNW5nnsCMmbtbEKsE9/geATzpf6+2wSNxZSPih7acV6s16pX2MPPuYEuQ3pf2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283076; c=relaxed/simple;
	bh=keGeNhzs3xp+qeYPU8cNtdBOt0vcNU3zMqIHr/8gsdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFNV6inn4TM1o/YYlwAMDMLLhVF2EkQrfd+AWDTiwa7gtIAmMmdnWSaLw7Q4xCTWwO9UsFyLpi4bxBvzQf/PoOSzVxx3sk5wKBsMcSU0QS7htnQuZrI494X/DQh822IoFnt/yNw5zfACaqaYEMypVsiza16W3HiGGCtKZPf7r0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzsRMOH6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTmN1BPg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl9qbklGnpInKmYvJoa6ZS5PHIy9GOhc0q9FzMa8X2Y=;
	b=hzsRMOH6xeWxc2o2bRi5V62jaRTvfs7zJ+P0LqBDGw2zp7XE/6L+IQGhAIrtviSmkoco4x
	9eIgWPX+MYzeEF+BWttPOsMQfQp637cS3Ljr33qbYM0REFlEz+3GqCfKqDIX0XLYBkbH/K
	l9JX/WpwrANdf0ctJgkvSnfllg0p3BLmu4mhA7pmccbd/V+FqKDyzsgiq1/Ln/fU3EJuwI
	EO/SzKzaikWR4aiaskFaHBKwzNUgqzm3topJgtTZTG60Axn1vfYluAEdZA5b5ZMkUQnjcI
	8tWHpYiq2ITkc4fiGkjXfwa2ndDHUnwfFQKhqfNEU5OYIfM8xQ9K9p3GtVKisQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl9qbklGnpInKmYvJoa6ZS5PHIy9GOhc0q9FzMa8X2Y=;
	b=aTmN1BPgkJfjz5ghzY+8zNVy8iT7ckSrrKhBMJR8BN+z8EP3Hh0PLeU0D6cc7pLTCRm959
	PY5rzrq5hPOljlDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v2 03/26] serial: core: fix kernel-doc for uart_port_unlock_irqrestore()
Date: Sun, 18 Feb 2024 20:03:03 +0106
Message-Id: <20240218185726.1994771-4-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

mainline commit: 29bff582b74ed0bdb7e6986482ad9e6799ea4d2f

Fix the function name to avoid a kernel-doc warning:

include/linux/serial_core.h:666: warning: expecting prototype for uart_port_lock_irqrestore(). Prototype was for uart_port_unlock_irqrestore() instead

Fixes: b0af4bcb4946 ("serial: core: Provide port lock wrappers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230927044128.4748-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3091c62ec37b..89f7b6c63598 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -658,7 +658,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
 }
 
 /**
- * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * uart_port_unlock_irqrestore - Unlock the UART port, restore interrupts
  * @up:		Pointer to UART port structure
  * @flags:	The saved interrupt flags for restore
  */
-- 
2.39.2


