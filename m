Return-Path: <linux-kernel+bounces-166965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7722A8BA278
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328AF289EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ABE1C8FA4;
	Thu,  2 May 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nYH6AIbc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rPOLxf/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B91C231D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685933; cv=none; b=bTYBoOvnwQldiIm+ymo8uRT/n6/TEG2BxYrMvXySefUgC6MDRNW1/MoswNHRVxBLROBx7aBXjLtJpgyvHBvG9TFd+EOayUWP3lwVE/Lge4AhV/kbIrPVyRWHTTz533ad9VxIWlADmvUbBGJFEvpmYdxKzj8uVmvwuRocNBi3XjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685933; c=relaxed/simple;
	bh=9Grq66tYc52lVbzlMciVnJKn6pZT7/ppw1afD/fleRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYSZt+RUFivNqXrnqmz5jWfz512wALGWbiwa7fMrfMrQWoVJNZr+O4eyX0RK20DtV2eQQJlNAgtCta4362so5X6g/g75s4QFgrcvXxlklTJnpjycuQtjRFWadQ98mmMmzjWpjnTySBlVFIg1FHVcqzAzRXN+Anc+1qMHHzZkc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nYH6AIbc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rPOLxf/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oias+1Ax4KrbbYorG2aEU5ZFjDcXbK21YV2QApk6lYk=;
	b=nYH6AIbcNA8QPlt0tOnDKiW/tsi+t7/yqOJT6sNmNitdzf3LSiVu2fclTkn68B3CEJniIg
	3QL9gkvIpBXxjHaX735avSeIufQkOT+tDHmr0gM8Ld1qmCcLHJy+rI5wCJUhw7QGygUNUO
	q3G4FA9e8B4/8sVxzXXpAKadWAluYfOwbI4mHTyK7quNuopV7G0m8ToKHSrhZWvaH8NnJd
	a37lkIoyKCsdm7WcSw7uJvUBOic/EM5mosKGqU8I+uiWKfiN+dTOZiOtaytSbG1CKK9Ew9
	dfBPy2L3j+XEfdS/JU6JICIKJmUzbYed/jrI6sDGRAAyBHHBaPnrj3CXTXinYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oias+1Ax4KrbbYorG2aEU5ZFjDcXbK21YV2QApk6lYk=;
	b=0rPOLxf/XfcOzqKBz3DqmUwP1Y9YIM/ER7etnQaRg7Qd0vSJDMwooZvHb2ygHcHcejkoY2
	96snNTDsIP5DYuDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH printk v5 14/30] printk: nbcon: Fix kerneldoc for enums
Date: Thu,  2 May 2024 23:44:23 +0206
Message-Id: <20240502213839.376636-15-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kerneldoc requires enums to be specified as such. Otherwise it is
interpreted as function documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3c20938f3676..71d0638aa818 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -137,7 +137,7 @@ static inline int con_debug_leave(void)
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -218,7 +218,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
-- 
2.39.2


