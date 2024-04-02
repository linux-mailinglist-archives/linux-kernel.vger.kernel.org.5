Return-Path: <linux-kernel+bounces-128773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C9895F77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A16A1C2205F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3C160797;
	Tue,  2 Apr 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGtgEOWL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yi2ciriB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D115FA85
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095904; cv=none; b=l4S6naFXP8ftiEpEDd2ypzNJTcdPc7W3EaEcwmKiPkh51kLD+hr2sUMQdl71lj1baOeLIcIVmHGiulp3mseljcUSzvA9FgfAuQDHJvKAXfvt+qRutFykx+idb/5E5ZuxovjDUTXyV5DpTaS6le1KpfHYwb2phq+EtEeMsG6aULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095904; c=relaxed/simple;
	bh=hx4xaO/u4i/Ycgs2YXfR0xt1CzcK8YE0NqUsdUu6qZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY+hTNMgs8OKnlZ3dtgK+dLyuHwX9JxleBTef/9Z9qGRdkNEGFbrnCkLlMeIYAMzIWaMbSfv8JNtqaoGXMEn0iboYNdlH0ZuT74VJKz9LS4lUBUhOaxKlAvF/h5eIMlf2DL7eq360Iz31b5cQaXCXHs+orAuw5cbkgGP18p8K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGtgEOWL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yi2ciriB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+qJ3uw8FF3SLnXWdWW9caWOJk87KBanZukA+yTmjng=;
	b=TGtgEOWLDZrUvzi6HxEb+jd840svAuCDAKgRRs9lPU6UJ89ucUGveHuaRJHDwJ1ISzSCX7
	P94pSJgUwWQCl7KeR/LZLxnNZS+9r25J7SK/eQqmRm6wax+DqSzMSJjsvubwW+tFfutfI2
	E2c5bR9+vhq3xf92Q4alW57I5l+it6zpsxUDvnBsoAdrRcxdccIBcWcZvknAmUquMshLpK
	lb/upa/j662/4i13OeEQzq7vVcduLkmTm5Er9+f9PHuwLMtOAA8UWsN9xDJMiqfZ3jN8dn
	UQscsiHaZHTb7G12fC1p5bgS+zH8ftCu0BwXdGr70QP5m5NYEEu1Ftg5Qk37vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+qJ3uw8FF3SLnXWdWW9caWOJk87KBanZukA+yTmjng=;
	b=Yi2ciriBDJJMADCkQuLvnRqql/zUlgXVIWNopY9M7TNmsdaOEX3uRRp2FW0qkk6knLmUmJ
	2y5cXmz5HxGXYmCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 13/27] printk: Let console_is_usable() handle nbcon
Date: Wed,  3 Apr 2024 00:17:15 +0206
Message-Id: <20240402221129.2613843-14-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
index bad22092cd5e..398e99a30427 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -87,6 +87,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -101,8 +103,13 @@ static inline bool console_is_usable(struct console *con)
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


