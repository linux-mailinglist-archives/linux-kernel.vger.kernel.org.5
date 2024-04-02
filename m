Return-Path: <linux-kernel+bounces-128769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F7895F73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C9C28764D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3D15FA99;
	Tue,  2 Apr 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIVPjn+w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XpvPlopo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF415F32D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095902; cv=none; b=Oezi26pN+FypG3Dqr13ZH4XIKNcdMH9F7TUDmbQ93F0VG/SgJQ4+ELykDN1oKm6iSUfy4wunWymr3xd6vIl+ngi+XTg7vQk4LV18W1dHxYvXK+A916Zm52LbrvAtG8gMZpMK6SH2aFlBlhNfo3ESUIqqd7Q/saA9ShdrVz0mcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095902; c=relaxed/simple;
	bh=qgbf7wzyZyP2i2kvRkavpANgVDXSmqKEab0lXkm1WnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsKApNnaNDhXGEIJBS8BHdX/JKPE46nChZHseKdjtLglr751XYBPdcTyf7phVvlRi1I/DGp13PqKm3A7Bw8/dksdzF3FAcYWTo+1T0fJOOgLQodWnUlLu/hr5R+u8XqnWdiESHH/GYrIIUF0stuZtytthdP+amK1cG8C7OkRNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIVPjn+w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XpvPlopo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GzrUUzQwt9A0JfUhizcLMvUJMEtY0MSYaFGPPBVIb4=;
	b=vIVPjn+wUo/v3OmdzfNEc8Ag3X5youcZKjz9r8Y/LjVq3m4Y7i3BvL4PRSZO4yo6UL+Ixh
	m39MjS7PH+iWeaL/GePtooNLcgMtMB2QkkkIC8FcutCOP8VUPiirloEzxDSTyrKPUsvkr0
	y5tZM0YZLt85/xifyNHMjqoEJMKYrWVG98I67LUC3lrFysZXDqnFH4EC80GlLCqG4/oF56
	KZ/HG/U4uT0RePpCAQicDsNOjODdQj0H7urnHscZYaO6rAubFNk83NmFiJ4VzzyEWehxIo
	tSOTH1/7ybywI3VhYQ6PQES4xJBB4hgkEpqabkshz88Y7kPAvAs5BzUDIzDVlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GzrUUzQwt9A0JfUhizcLMvUJMEtY0MSYaFGPPBVIb4=;
	b=XpvPlopog8JXD/+Q7a622mIt9ySj1HKTo8ih2revZoWzg48eXZq2jshfDqDkYpa58MaF1b
	eY+SebAjyO8884AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH printk v4 10/27] printk: nbcon: Do not rely on proxy headers
Date: Wed,  3 Apr 2024 00:17:12 +0206
Message-Id: <20240402221129.2613843-11-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The headers kernel.h, serial_core.h, and console.h allow for the
definitions of many types and functions from other headers.
Rather than relying on these as proxy headers, explicitly
include all headers providing needed definitions. Also sort the
list alphabetically to be able to easily detect duplicates.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h          |  8 ++++++--
 kernel/printk/nbcon.c             | 12 +++++++++++-
 kernel/printk/printk_ringbuffer.h |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 4e0edcb3c311..c040fc8f1fd9 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,11 +2,12 @@
 /*
  * internal.h - printk internal definitions
  */
-#include <linux/percpu.h>
 #include <linux/console.h>
-#include "printk_ringbuffer.h"
+#include <linux/percpu.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
@@ -43,6 +44,9 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+struct printk_ringbuffer;
+struct dev_printk_info;
+
 extern struct printk_ringbuffer *prb;
 
 __printf(4, 0)
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 38328cf0fd5c..1de6062d4ce3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,14 +2,24 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include "internal.h"
+#include "printk_ringbuffer.h"
 /*
  * Printk console printing implementation for consoles which does not depend
  * on the legacy style console_lock mechanism.
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 52626d0f1fa3..bd2a892deac1 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,8 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 /*
  * Meta information about each stored message.
-- 
2.39.2


