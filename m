Return-Path: <linux-kernel+bounces-166964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA548BA277
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754EB1F2191D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9AE1C68B7;
	Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gPA1Cq3r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="koZ+HFiw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B71C0DFD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685932; cv=none; b=rHRKszkuiTlr9agAGCfX6Vwio8UFsG2Upcj59tfGlsGw0d44/SXujelKjAMEiu5GUQlrU5TF/czyIY9ssSw9kspM9ZqYFbcn96lyaUVYYVw/Zl60ru6mNERD7s0Xj4iOSGFJcKwH1MpzSlrI8AIW6BonJCqlEvMER3w1MIhek0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685932; c=relaxed/simple;
	bh=iA960+saI7gEnS5x6t8Ea+sjaf4rVAr0JyKNQ+CNr70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjXuFtIby3B68wcCjlBB+le4ioGPtsaUtvGhjrtbJc4WFPbSb22FrdZZgOvVvBv86yW8wtHBl8UAu1pxbC3xJaHESv5rf6fxbfeRvH37PR054ATeRC+zdfT5uXQRO6hrW0ZbcR2dTStVdPV4M4Uven9r8tpje4bY9vVIEHXz6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gPA1Cq3r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=koZ+HFiw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kjjk2yQaSdehlXyvncmPkRMwdSdvenQb1yl20R7F0SU=;
	b=gPA1Cq3rEIMA5tnEYeFbB62YkV2ult4GYTqdUgk53OYwzbuS08LNmNTf4AWFxBZCrWhjom
	o1UYAkTlZp0WdoAhhhHjimhf42Pu0CzF886MHtY6YqbJnAlUDJkZOVGEZT20M6n1UjbA01
	K/nSH7VZF2PqEAB8c3ZJ1ojcYLrq2Zn1HXLdArxHv6RiLfIBmk60/E7uB77O61LPCexmBK
	pBJRLz7EYscAfO4/g3JsbGTyi5i4gIb3ZIcDw+Ee3UsgxZKg2YdyXWpuSRyN9gC9z6j2I3
	rgYgxHM1WclrJ5MLbPukCe1Ws0gygyuZutmoYejkTnlS3aghVirNUoS5/YJzFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kjjk2yQaSdehlXyvncmPkRMwdSdvenQb1yl20R7F0SU=;
	b=koZ+HFiwRQvRSIg5gSD7BWhXo8357rjtQVzyhs6tCj6Djvs29yhCVQkBmTitQJPhg6ZViY
	rGiH2fgaAr4Nz9DA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH printk v5 13/30] printk: nbcon: Do not rely on proxy headers
Date: Thu,  2 May 2024 23:44:22 +0206
Message-Id: <20240502213839.376636-14-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h          |  8 ++++++--
 kernel/printk/nbcon.c             | 13 ++++++++++++-
 kernel/printk/printk_ringbuffer.h |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 831f95f26d48..6c1d01eabf3b 100644
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
index b8a7e3e136d3..c429f4cfbb2d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,13 +2,24 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bug.h>
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


