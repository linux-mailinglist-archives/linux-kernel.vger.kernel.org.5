Return-Path: <linux-kernel+bounces-166956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA58BA26F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3C288BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9A1C2317;
	Thu,  2 May 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lnaxy3Mz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHfXRFBh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07422184139
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685930; cv=none; b=gNTwFXQGTqKtuZA8x3wnTLQLTAD1pZcg9mFbNQK5yL8r/k+AoeY2xjiTKIsEdwwYKKNvY/ClR0kaTASCejTe6hIehUMvqISoI4unmjMUefRj9JwBgMzBIi90Gh+G3oPVhtjExuUvSEX4OfGSdyJMz/yXR6rQ2Kj+gVZbCJ1UpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685930; c=relaxed/simple;
	bh=nIpG4fXaTa8mSjCbv1ZSGShw/vQloUe1E2WzNi1qKkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuoYQdM3c3liYIYaJ71xaAiEVpqdmT8Tq3PBecM38Ee8WGgFZ+eHBwMBwU8Nv4rLTrIzH5jnIduuKTUdyg2KrC/1WNwpzWkZIuJn+xZoWAqk1fyDjmX7DwfXY4ZwnqM5Xe5N+f1mAja7b+NQW1VK9HrARTZ9Kko1uUY9X1HzjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lnaxy3Mz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHfXRFBh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikaIBhkO9a0LJOxhudxcKYnEZt0PSHVLhaJwgBGZFyQ=;
	b=Lnaxy3MzelPLT6Dypxah9BXa9yO3bszXdMn0azEFPWwppEid3+frayfJxKp9U9cGCt8FDG
	rXe/yYr1kx7RzdFx13+DfajkQ6twUZghnjAjOnfiLR4qr1L55QmEJdxSJUWa7ywx45IhAu
	/07sihJQB2B+7Jtmf1HVQheYsxWMED4/5JmonRfMUE4zBManaqthVmtbiMDiRpiToJ4Aew
	PEurfjsu7hsSyVhwMov3axLiLO4k94mKBtScwfcLN7q0FaEVJphXCouBijZR3prtiKPlaP
	Y+MpEs0gCbAfjOG86biT4FSJP8xkhtMKQLaTuNYN9+kuaMIm3hOswQZ6y5IDWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikaIBhkO9a0LJOxhudxcKYnEZt0PSHVLhaJwgBGZFyQ=;
	b=mHfXRFBhR+Y1FEepmsSL098XTQAXcNo0Rhv+48QUKQYIWB7luDPWPkbNpRv0NK9WroEoEh
	tXQm21rVwqRWZqCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 06/30] printk: nbcon: Add callbacks to synchronize with driver
Date: Thu,  2 May 2024 23:44:15 +0206
Message-Id: <20240502213839.376636-7-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls. To provide the
necessary synchronization, usually some driver-specific locking
mechanism is used (for example, the port spinlock for uart
serial consoles).

Until now, usage of this driver-specific locking has been hidden
from the printk-subsystem and implemented within the various
console callbacks. However, for nbcon consoles, it is necessary
that the printk-subsystem uses the driver-specific locking so
that nbcon console ownership can be acquired _after_ the
driver-specific locking has succeeded. This allows for lock
contention to exist on the more context-friendly driver-specific
locking rather than nbcon console ownership (for non-emergency
and non-panic cases).

Require nbcon consoles to implement two new callbacks
(device_lock(), device_unlock()) that will use whatever
synchronization mechanism the driver is using for itself.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3291cc340f1a..33a029d976c3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -354,6 +354,49 @@ struct console {
 	 */
 	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
+	/**
+	 * @device_lock:
+	 *
+	 * NBCON callback to begin synchronization with driver code.
+	 *
+	 * Console drivers typically must deal with access to the hardware
+	 * via user input/output (such as an interactive login shell) and
+	 * output of kernel messages via printk() calls. This callback is
+	 * called by the printk-subsystem whenever it needs to synchronize
+	 * with hardware access by the driver. It should be implemented to
+	 * use whatever synchronization mechanism the driver is using for
+	 * itself (for example, the port lock for uart serial consoles).
+	 *
+	 * The callback is always called from task context. It may use any
+	 * synchronization method required by the driver.
+	 *
+	 * IMPORTANT: The callback MUST disable migration. The console driver
+	 *	may be using a synchronization mechanism that already takes
+	 *	care of this (such as spinlocks). Otherwise this function must
+	 *	explicitly call migrate_disable().
+	 *
+	 * The flags argument is provided as a convenience to the driver. It
+	 * will be passed again to device_unlock(). It can be ignored if the
+	 * driver does not need it.
+	 */
+	void (*device_lock)(struct console *con, unsigned long *flags);
+
+	/**
+	 * @device_unlock:
+	 *
+	 * NBCON callback to finish synchronization with driver code.
+	 *
+	 * It is the counterpart to device_lock().
+	 *
+	 * This callback is always called from task context. It must
+	 * appropriately re-enable migration (depending on how device_lock()
+	 * disabled migration).
+	 *
+	 * The flags argument is the value of the same variable that was
+	 * passed to device_lock().
+	 */
+	void (*device_unlock)(struct console *con, unsigned long flags);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


