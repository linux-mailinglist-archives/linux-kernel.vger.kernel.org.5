Return-Path: <linux-kernel+bounces-70504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E28598BE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6818B1F230E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26573195;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7xu7hfV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WC1PWFT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A36F504
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282675; cv=none; b=JkReHT7NbwNe9sFEkl7DtcbCCTNfb6qHFXp0bRrNkwqFICsiKv3MRosZqXdcNM/OdpKgUuV7z1SDNb3hHLcVZzSZfVtTbU9sEy+MSPw8Hc2OqjB2jFpJap5Rz9fgCOEDfaLKl5AUwEMRs12H/AEJNvpzVY7Ny6YJZbdsYSa9tnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282675; c=relaxed/simple;
	bh=VBHx4Cus2cJidu47KwQl5FHQQheHgkCUVrX8zpd9KsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGHncS6O3FLed5WbdgXksC1Ic56ZcbNeWllbMiA67J1I3HGDN+LuFX+j1RuNScjIT4oDQ8MBgrmIU/3uoZ1WpZ6S/0STxcz2nutDb3shyX6lCTp+J6FR5ZZbupCJVKvRFfI+uLT7Z6O8MyE4eJiEY2lwbkhRimXBgnqHDBE584E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7xu7hfV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WC1PWFT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUwIeSGZ+StqqGIqBIJs0cGENFsoVWre3Jl13joVS94=;
	b=t7xu7hfVQXpd79WP0b9+W4yS7IsMad5j3VNVWCe5WHFy2pwwlog2q66avUuTa7EurOMbPd
	UWvIjARCFpJvv5Jp42GoE7ne8PBdxxT6p2fsZH1ic8ur0e0ZMylY00a6CkpP8bXiwZLNb8
	nihLJssxgJ6M8Vb+GyNTdG256q3I0QUsN+q3IT2ZSALYVDLd8S376vkjiitDNaogQ0Eu7O
	R1hQAsoBHDBDNkzF7CxwHn1Wwul0N52Iz616hQhcLL4m+AFia5+Q8ReUR95m9sQ+EEQG5j
	KOn9mXZuS9LqHBWEnxMeYNSdAXBAZYW55ZW+7xob6AfnzKAIQDt2WaQQF/DyXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUwIeSGZ+StqqGIqBIJs0cGENFsoVWre3Jl13joVS94=;
	b=3WC1PWFTwRsETdj+pq340CnfZVlD62OQIrZCKwUyr53+TZcJsH3jvnZzhsPN/IiZFOHmHU
	7MQyIjPv75805ICw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 12/26] printk: Let console_is_usable() handle nbcon
Date: Sun, 18 Feb 2024 20:03:12 +0106
Message-Id: <20240218185726.1994771-13-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbcon consoles use a different printing callback. For nbcon
consoles, check for the write_atomic() callback instead of
write().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6e8c1b02adae..69c8861be92c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -80,6 +80,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -94,8 +96,13 @@ static inline bool console_is_usable(struct console *con)
 	if ((flags & CON_SUSPENDED))
 		return false;
 
-	if (!con->write)
-		return false;
+	if (flags & CON_NBCON) {
+		if (!con->write_atomic)
+			return false;
+	} else {
+		if (!con->write)
+			return false;
+	}
 
 	/*
 	 * Console drivers may assume that per-cpu resources have been
-- 
2.39.2


