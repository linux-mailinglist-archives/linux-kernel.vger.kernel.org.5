Return-Path: <linux-kernel+bounces-10164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42E81D100
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB62850A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722563C1;
	Sat, 23 Dec 2023 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="hPQ9EZCh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5D3FEF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so2909698a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296316; x=1703901116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTMwKRfKSY+wzvK5gdGyAc9H4xcGp0kciVKM/zCn9ws=;
        b=hPQ9EZChfyYOi1klW8JB1Rae7aC7fP74UOwwdYW2PQ9/YblJ4jz8qlQJNxPUZXats+
         AosPR4S7mAz33G8AFAHI8EL/kseYpr9hQFFRiJcTbf+wXCWMUBOriY5OT3miiJFTsUyc
         12E+2JjgFjM6PfzuMxn1crUhHOyA1jmnvqDVMavJ8+XrfpVqF6MXqQWEgeAX9QWiAzkT
         5ocwTfpW7/aTOybk7gQbTYcLd/r1YcOdKh0OjBpvX9DIFToGIGrLrJOKuh4vyDc1Qjnz
         so/6vD1k0B2KNato7Tu9SkSGL+UjTFzpngosszeiAM0QcJClRW7tsCv3gWnPoJFRvQ0h
         +wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296316; x=1703901116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTMwKRfKSY+wzvK5gdGyAc9H4xcGp0kciVKM/zCn9ws=;
        b=ujHDtuEyK9HexjR4uBXsuu3HaluqxrCo821bZNDqsPr6qB+yumXcTT1SAuyCbTprKV
         coX5AGFslaOUVyfu3G/KBNpQdQRc9W3uOxY8I+z2I5e/dI3wmjOPrzpE4Q/PZX3wNjvv
         2P7uJi+8T+AzB6FSfBkz9Nn8CXrfa0cgODyoLaby/Qg2I2nS+jwsilUUL5gT6jytBk6P
         12g5ajJKHF3yXbuOpWWprc8V5eHlIsVdeviyLWWSkpCR7hFv2F6yOZJa0Rhweqj44PTU
         EFEvnJQSg/jKEXjnHBgz1vws0msdOtOdpGcDaL+9zYp5+P3782hLOkVaEQrsa0RLusjr
         Tbug==
X-Gm-Message-State: AOJu0Ywt6nv/6DyCRiPTwq1+JSJzMoMjVCgzSNrGFhEzyrUVyJaV5M55
	pWiC1KLlLnOZconMR5COpCsZoTKDMvgT
X-Google-Smtp-Source: AGHT+IESMikWpnG0X3e9DO41exzd3FpheFJckLS5vxUMgQ2DOljGYKzY9NgSYKVzuKRUKuQEEqetTQ==
X-Received: by 2002:a50:cd16:0:b0:553:b3ee:5840 with SMTP id z22-20020a50cd16000000b00553b3ee5840mr1255409edi.79.1703296315970;
        Fri, 22 Dec 2023 17:51:55 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:55 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v3 04/22] dyndbg: add 2 trace-events: prdbg, devdbg
Date: Sat, 23 Dec 2023 02:51:13 +0100
Message-ID: <20231223015131.2836090-5-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

ddebug_trace() currently issues a single printk:console event.
Replace that event by adding include/trace/events/dyndbg.h,
which defines 2 new trace-events: dyndbg:prdbg & dyndbg:devdbg.

These events save a debug message and use its length for
processing. They also accept the _ddebug descriptor and dev
structure so they can be used to access the whole callsite
record in the future: file, line, function, flags. This allows
the addition of a dynamic prefix later.

So ddebug_trace() gets 2 new args: the descriptor and the device.
And its callers: ddebug_printk(), ddebug_dev_printk() upgrade their
flags param to pass the descriptor itself, and thus also the flags.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 MAINTAINERS                   |  1 +
 include/trace/events/dyndbg.h | 63 ++++++++++++++++++++++++++++++
 lib/dynamic_debug.c           | 73 ++++++++++++++++++-----------------
 3 files changed, 101 insertions(+), 36 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..e5bef24d6134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7391,6 +7391,7 @@ M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
+F:	include/trace/events/dyndbg.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
 
diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
new file mode 100644
index 000000000000..647c30206a7d
--- /dev/null
+++ b/include/trace/events/dyndbg.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dyndbg
+
+#if !defined(_TRACE_DYNDBG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DYNDBG_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * template for dynamic debug events
+ * captures debug log message and uses its length, it also
+ * accepts _ddebug and dev structures for future extensions
+ */
+DECLARE_EVENT_CLASS(dyndbg_template,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len),
+
+	TP_STRUCT__entry(
+		__dynamic_array(char, s, len+1)
+	    ),
+
+	TP_fast_assign(
+		/*
+		 * Each trace entry is printed in a new line.
+		 * If the msg finishes with '\n', cut it off
+		 * to avoid blank lines in the trace.
+		 */
+		if (len > 0 && (msg[len-1] == '\n'))
+			len -= 1;
+
+		memcpy(__get_str(s), msg, len);
+		__get_str(s)[len] = 0;
+	    ),
+
+	TP_printk("%s", __get_str(s))
+);
+
+/* captures pr_debug() callsites */
+DEFINE_EVENT(dyndbg_template, prdbg,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len)
+);
+
+/* captures dev_dbg() callsites */
+DEFINE_EVENT(dyndbg_template, devdbg,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len)
+);
+
+#endif /* _TRACE_DYNDBG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 016f33c20251..fcc7c5631b53 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,7 +36,9 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
-#include <trace/events/printk.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/dyndbg.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -878,7 +880,9 @@ struct ddebug_trace_bufs {
 static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
-static void ddebug_trace(const char *fmt, va_list args)
+__printf(3, 0)
+static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
+			 const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -897,7 +901,11 @@ static void ddebug_trace(const char *fmt, va_list args)
 	buf = this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
 
 	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
-	trace_console(buf->buf, len);
+
+	if (!dev)
+		trace_prdbg(desc, NULL, buf->buf, len);
+	else
+		trace_devdbg(desc, dev, buf->buf, len);
 
 out:
 	/* As above. */
@@ -907,9 +915,9 @@ static void ddebug_trace(const char *fmt, va_list args)
 }
 
 __printf(2, 3)
-static void ddebug_printk(unsigned int flags, const char *fmt, ...)
+static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
-	if (flags & _DPRINTK_FLAGS_TRACE) {
+	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -917,11 +925,11 @@ static void ddebug_printk(unsigned int flags, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(fmt + strlen(KERN_DEBUG), args);
+		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
 		va_end(args);
 	}
 
-	if (flags & _DPRINTK_FLAGS_PRINTK) {
+	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -931,19 +939,19 @@ static void ddebug_printk(unsigned int flags, const char *fmt, ...)
 }
 
 __printf(3, 4)
-static void ddebug_dev_printk(unsigned int flags, const struct device *dev,
+static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 			      const char *fmt, ...)
 {
 
-	if (flags & _DPRINTK_FLAGS_TRACE) {
+	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(fmt, args);
+		ddebug_trace(desc, dev, fmt, args);
 		va_end(args);
 	}
 
-	if (flags & _DPRINTK_FLAGS_PRINTK) {
+	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -966,7 +974,7 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	ddebug_printk(descriptor->flags, KERN_DEBUG "%s%pV",
+	ddebug_printk(descriptor, KERN_DEBUG "%s%pV",
 		      dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
@@ -977,7 +985,6 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 		       const struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
-	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -987,15 +994,14 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (!dev) {
-		ddebug_printk(flags, KERN_DEBUG "(NULL device *): %pV",
-			      &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL device *): %pV",
+			       &vaf);
 	} else {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, dev, "%s%s %s: %pV",
+		ddebug_dev_printk(descriptor, dev, "%s%s %s: %pV",
 				  dynamic_emit_prefix(descriptor, buf),
 				  dev_driver_string(dev), dev_name(dev),
 				  &vaf);
@@ -1011,7 +1017,6 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
-	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -1021,24 +1026,22 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (dev && dev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, dev->dev.parent,
-				   "%s%s %s %s%s: %pV",
-				   dynamic_emit_prefix(descriptor, buf),
-				   dev_driver_string(dev->dev.parent),
-				   dev_name(dev->dev.parent),
-				   netdev_name(dev), netdev_reg_state(dev),
-				   &vaf);
+		ddebug_dev_printk(descriptor, dev->dev.parent,
+				  "%s%s %s %s%s: %pV",
+				  dynamic_emit_prefix(descriptor, buf),
+				  dev_driver_string(dev->dev.parent),
+				  dev_name(dev->dev.parent),
+				  netdev_name(dev), netdev_reg_state(dev),
+				  &vaf);
 	} else if (dev) {
-		ddebug_printk(flags, KERN_DEBUG "%s%s: %pV",
-			       netdev_name(dev), netdev_reg_state(dev), &vaf);
+		ddebug_dev_printk(descriptor, &dev->dev, KERN_DEBUG "%s%s: %pV",
+				  netdev_name(dev), netdev_reg_state(dev), &vaf);
 	} else {
-		ddebug_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
-			       &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL net_device): %pV", &vaf);
 	}
 
 	va_end(args);
@@ -1054,18 +1057,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 {
 	struct va_format vaf;
 	va_list args;
-	unsigned int flags;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (ibdev && ibdev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, ibdev->dev.parent,
+		ddebug_dev_printk(descriptor, ibdev->dev.parent,
 				  "%s%s %s %s: %pV",
 				  dynamic_emit_prefix(descriptor, buf),
 				  dev_driver_string(ibdev->dev.parent),
@@ -1073,10 +1074,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				  dev_name(&ibdev->dev),
 				  &vaf);
 	} else if (ibdev) {
-		ddebug_printk(flags, KERN_DEBUG "%s: %pV",
-			      dev_name(&ibdev->dev), &vaf);
+		ddebug_dev_printk(descriptor, &ibdev->dev, KERN_DEBUG "%s: %pV",
+				  dev_name(&ibdev->dev), &vaf);
 	} else {
-		ddebug_printk(flags, KERN_DEBUG "(NULL ip_device): %pV", &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL ip_device): %pV", &vaf);
 	}
 
 	va_end(args);
-- 
2.43.0.472.g3155946c3a-goog


