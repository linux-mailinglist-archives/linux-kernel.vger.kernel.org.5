Return-Path: <linux-kernel+bounces-70512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398FD8598C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E437E1F230DA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106476029;
	Sun, 18 Feb 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kipOVu39";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcuQRKgf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3371B45
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282678; cv=none; b=Bg/vGaOrKCNhSMJ2HEMBNBcVoKU6OpMxpmcc+diADPFoN/4om3Wbh7NhiJsd/n50Kmgrkb0gEL5uUWCP021BM9kY0QoJO/gqwIhIrk+ldpMVPB7TzQTGA3b4tyYPEwVDdvbCynKj5/wctxvUXAJZ/66z0uTGEHn+ZojTKFwEKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282678; c=relaxed/simple;
	bh=QdXwnt6+PhX0aD+AlOZp4u+/7nviebzBO5H0/vlodlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oslzbae/biHzS/wfmzj74Fj8vOEaCia7Thx97rh2mEVhNKp3y1gdo7c7/hVAKF5zT47thNzWKYKIXAYQcSycRp34BNIVaykEBp//W0l2IcfY1TCJW1/wH66ZmmP1fwwy/YZ4dyNjmZ52IwNGglkEz4cQTNJZOQI+xqVPydW4cMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kipOVu39; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcuQRKgf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fJ6yqWdSDvmc7d434BHASreaek3tLpIi1BkLTUqxi8=;
	b=kipOVu39ofseUoqPTQoCnM23+6kBri5ZY2eBYwv/o+FNAIZUzfw4DtLwp8jDymOfwfi2Pe
	4hma6CyBwf2rY4nROH7z1tKEDIcig9XMyk0V+3kCWjCIev9z7q94K6jKZEwgEmANmkgtQ0
	bS/5Lwdwmv2ns+NDsy19ux3NkvtqWruYfwTMeQjERAbsIcJigtdYrR0Y4hkaiA3YjLIUsO
	DUJlz+LqYzQ/w3nKk53Hx1EoymeoDaYPowaeN/AJn1sJwzWPYuKlX5k+OChheaPDPp6VLV
	3SHQCtyqROdOxNvNM5LBsbIUXqd54/bZq1/bqjvyzP+MWwhrSn66ePh15T16OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fJ6yqWdSDvmc7d434BHASreaek3tLpIi1BkLTUqxi8=;
	b=zcuQRKgfxpNNB2OuJJiAlo1opLefEjxr6MexZJu4AsBTFQoMR2c3u1HnqC6qtG9R/LOa+M
	kOMUfgdZJyWjKTAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 20/26] printk: Track nbcon consoles
Date: Sun, 18 Feb 2024 20:03:20 +0106
Message-Id: <20240218185726.1994771-21-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global flag @have_nbcon_console to identify if any nbcon
consoles are registered. This will be used in follow-up commits
to preserve legacy behavior when no nbcon consoles are registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 336dad179b99..2c4ab717c110 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -470,6 +470,13 @@ static DEFINE_MUTEX(syslog_lock);
  */
 bool have_legacy_console;
 
+/*
+ * Specifies if an nbcon console is registered. If nbcon consoles are present,
+ * synchronous printing of legacy consoles will not occur during panic until
+ * the backtrace has been stored to the ringbuffer.
+ */
+static bool have_nbcon_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -3522,6 +3529,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_init(newcon);
 	} else {
 		have_legacy_console = true;
@@ -3583,6 +3591,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	struct console *c;
 	int res;
@@ -3639,13 +3648,18 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
-		if (!(c->flags & CON_NBCON))
+
+		if (c->flags & CON_NBCON)
+			found_nbcon_con = true;
+		else
 			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = false;
 	if (!found_legacy_con)
 		have_legacy_console = false;
+	if (!found_nbcon_con)
+		have_nbcon_console = false;
 
 	return res;
 }
-- 
2.39.2


