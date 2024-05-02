Return-Path: <linux-kernel+bounces-166974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8E8BA286
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99BEB24E95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524F20127B;
	Thu,  2 May 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0HE7bHA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhmNS173"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C91C9EBD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685937; cv=none; b=dz+TuXOtIbN81ysh6UqtDDQ85K8Q4rZ0kY6wum8zJu7eduaiClRAzrkI2CH4h8sijw4zMEcYaMDri2LnIeJ4fVZ79Ihw0hAhh/C73EjRIoLmBZXrnDWEFFQTLcQtMhqYl7VS6ykSrc49K/FHbIvFRn5u+zlBF7043h5Vu1qw5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685937; c=relaxed/simple;
	bh=LNUSX7frizCoQB/cUybOT78S5L8+BZsAsyiRjVvjQqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ft5Nqto9ugJd4Pk4O9eJzhJk0omZ3UGZV3vg4bVVX0y1avf5q+mMbgoYpd+muZwmrZG98nOsZlQlsHAAb587suwXjt43N1o/E4LVxB9MPApRqep3iYYidjyOMxdoAOvLISzGpsH03OzdGX1ZwLvEnRfynZbp/zyHrbeqO5qwqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0HE7bHA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhmNS173; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOxgJh7OowKlUgCULZJtMLD8sILLxBu5zJz7tzlhAxw=;
	b=u0HE7bHASx0ogSUS+II8HMVGUModVzXeROfR1tPN3VIsmaXSVEB/2yexQyupY1sJYdkfeA
	Ezt26vCxzgs9EsHTmxJCBTjH+sk1WT1Dr9f2lUA0pIMMs37M62VlBjai+KC1nWvPyHI9Cs
	SWS7/5bROrRKUJ0Wte/RpXrYvDNenQAjxJzDMOjwcKInoLi3oHZsFnWrnF3FIlGAaZdfXu
	DN3VBfF3bLQIh3YNa1ocWQK1j8ofVkemKCM07H5wakawUKzfITOTEF0j4G50HyKbmuM+Er
	fFdY6fiupMEETIFc0QZTj2rOYlWnzQ5vBD22uvPzrF23+SvFAIlyTFQHQUE6ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOxgJh7OowKlUgCULZJtMLD8sILLxBu5zJz7tzlhAxw=;
	b=AhmNS173bXsFi0tZIhvdUKSKBjik/wVvsowX4RFhuueJirBLY6DGrkc27sjk17LJQwMJZZ
	xoSRfoOrrs0hvOCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 24/30] printk: Track nbcon consoles
Date: Thu,  2 May 2024 23:44:33 +0206
Message-Id: <20240502213839.376636-25-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0cb6ae5fd7e3..31ed4450d9a6 100644
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
@@ -3537,6 +3542,7 @@ void register_console(struct console *newcon)
 	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_init(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
@@ -3616,6 +3622,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3683,13 +3690,18 @@ static int unregister_console_locked(struct console *console)
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


