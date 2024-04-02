Return-Path: <linux-kernel+bounces-128780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B6895F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430601C20819
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D1161B4E;
	Tue,  2 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2CniPFW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6lH22voz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F756161319
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095908; cv=none; b=GWMC3Stuy0gwouKY/0+JL0uBpT1H5uBY1Rgztu4bW30hsvU1oXsFY0IfQ8lkdCFj1s61/TgD8kx1yiJhLA2fVLwZsZP0YUGvXOpT/Nn3JZTZnAqNZ2fBUgEtatEFbiPeDrSQWzJC5hfMUvMcGjEyMAphZbYSdMjRHjkJ8iFA6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095908; c=relaxed/simple;
	bh=ea/VSkLziN3LfF9dxUVRYcPw9vAR9EyCyVl6lSgqECM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rbj1H0VFO5G9/Aympyssufpy/+LX7OrT7/t014D/MfI614KghFKm9o7Uhst1G5gIMVNJ+oYxPZwq3pGXemWBV86dr2DHRxwKzJmmfWJvXeOcVg2gf+4x6qLh4zN4gzNVwwn2yWVE3j9QGuL+N+mPOVQGglS6CY8TrzFIi35f4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2CniPFW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6lH22voz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU8IWDIJKFpfEhPU59onSvKonMZgsk+kpNnh+HiGC7g=;
	b=2CniPFW5uube6TVk/d4kn8aPetcO9M/ExOy5ajsCLwBPl2HmcSKqE3ZA8CQXP0ElT/9UxX
	+TDC9kGLNP8VpmVHzTD5TUHcR3ILVXsvgbQRza0NJDCA2AjjR1LzKvKJeLIB2EuSKrr2eD
	mzCQe1XjoCiwM9pLiVivKzwA//T+LO/sakSEnvS0q5drpajBJBGct+J4SLp2fcPpJkS7pL
	R6spksFUYbCsCc7za+P0fCcMBC2OQw8oQtnhFun31IzitFzCMmTmPF/qKEowm3GeHzj0WT
	Sqhw++EskvWGYComVoH4xy+kfZ9ZntgVXkLkVj0pbUx3Jq680qP65I+tp0Yivw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU8IWDIJKFpfEhPU59onSvKonMZgsk+kpNnh+HiGC7g=;
	b=6lH22vozQipEEMG2qPHiu4Si6m5fdkfeSaV+42aQXUsVLnHsTryadC8rRPLQH9ISaDg0al
	R6yNebYJCDkAltDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 21/27] printk: Track nbcon consoles
Date: Wed,  3 Apr 2024 00:17:23 +0206
Message-Id: <20240402221129.2613843-22-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4ff3800e8e8e..329b8507f8a0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -470,6 +470,11 @@ static DEFINE_MUTEX(syslog_lock);
  */
 static bool have_legacy_console;
 
+/*
+ * Specifies if an nbcon console is registered.
+ */
+static bool have_nbcon_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -3533,6 +3538,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_init(newcon);
 
 		/*
@@ -3619,6 +3625,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	struct console *c;
 	int res;
@@ -3675,13 +3682,18 @@ static int unregister_console_locked(struct console *console)
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
 		have_boot_console = found_boot_con;
 	if (!found_legacy_con)
 		have_legacy_console = found_legacy_con;
+	if (!found_nbcon_con)
+		have_nbcon_console = found_nbcon_con;
 
 	return res;
 }
-- 
2.39.2


