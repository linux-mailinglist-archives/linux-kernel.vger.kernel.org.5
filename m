Return-Path: <linux-kernel+bounces-10168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25681D104
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30A1B23F29
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22088D293;
	Sat, 23 Dec 2023 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="o3tZvkzV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2CCA58
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc794df8aaso27687931fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296322; x=1703901122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgjIg6X8jjHCdfelkpRM2sipyaIHb+VRBFfUGoyNfPU=;
        b=o3tZvkzVHAbGTUBu2mWg9IHRMf6gQoJLR+BzEi6vHNbuEDLZpvxtNmzSR/oBWmj1DM
         H4V+YaPu9YlLQ4R9+PlxpS+w1zVwDKlBAoukDZCNsNZ4HGFIbt8PeGupKXZP2/SluVVv
         j+2AVUDptwq7GtyiCeQ/ZlbQJdV8WvNfPvhDwxZOo8MndZ6zgF+/oFLxlz2UhCL0Cbsh
         plRyBRDbNIy6IwOCk1vbDMz+adk2oxfGosZzKoPv0QLGMRMW34Bv0CuaG6yBLlKuhgv4
         Ob9aSnzkpNbyzztrQz3+gVz1qJCGJAIQ2aajbnQ7XGQg0uO1oAt6MBdi7XqCIV5ICICa
         4Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296322; x=1703901122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgjIg6X8jjHCdfelkpRM2sipyaIHb+VRBFfUGoyNfPU=;
        b=rVMUjtse6NWAyr5TFDYVMBUJisKvpumauKFLYQ2TqM67iznmNkxyH/WO9c5H8kaWyp
         +AxskSxhkD3hWvCRi14gAAkQTZMcDZv9sTU0KqO+WfrmO8S12IyXrx8WiGnjnke6IVCu
         ZVDINGeSJFpHMjZcsiLwFdwlwlAOYx5SbAMDNIg2RzLdpQ9EGeE8GcI/8ZjGSsBMGrxf
         h0w9LotOf4wuCF4qLFf0gPpPutfw0IJWliy6ACUoLi+6Cg3Ly/EWHqQxlgXT8PZPXlwq
         662MaijCjDGveWmXLXy6Yhzf9D44bNRhCmyoGT3/umZi5TRU6iTsGQz3MVG9C4pOWK/+
         glMA==
X-Gm-Message-State: AOJu0YxWANgMZzQCPNRhoAuad3FMJ5wS0M0SUsO1X5PIVNDINxLBFLND
	h7L1YzIehSyrmWhDyURmjie/GtTSRfW4
X-Google-Smtp-Source: AGHT+IF5u1BZXakcVLDEqYV9x3N8L7jNB/TMr6/1GnBFHrRoKKpXTqVt3uD4Bjf6yqvcBuLzjUXw+g==
X-Received: by 2002:a2e:80ca:0:b0:2cc:9279:3516 with SMTP id r10-20020a2e80ca000000b002cc92793516mr1048541ljg.32.1703296322319;
        Fri, 22 Dec 2023 17:52:02 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:01 -0800 (PST)
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
Subject: [PATCH v3 08/22] dyndbg: move flags field to a new structure
Date: Sat, 23 Dec 2023 02:51:17 +0100
Message-ID: <20231223015131.2836090-9-lb@semihalf.com>
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

Add a new structure ctrl and place it in 4 padding bytes
of _ddebug struct. Move flags field to the ctrl struct
and create setter and getter for the flags field. Add unused
fields to explicitly emphasise size of each bitfield.
This step prepares for addition of a trace_dst field.

Layout of _ddebug struct after addition of ctrl is:

struct _ddebug {
        union {
                struct static_key_true dd_key_true;      /*     0    16 */
                struct static_key_false dd_key_false;    /*     0    16 */
        } key;                                           /*     0    16 */
        union {
                struct static_key_true     dd_key_true;  /*     0    16 */
                struct static_key_false    dd_key_false; /*     0    16 */
        };

        const char  *              modname;              /*    16     8 */
        const char  *              function;             /*    24     8 */
        const char  *              filename;             /*    32     8 */
        const char  *              format;               /*    40     8 */
        unsigned int               lineno:18;            /*    48: 0  4 */
        unsigned int               class_id:6;           /*    48:18  4 */
        unsigned int               unused:8;             /*    48:24  4 */
        struct dd_ctrl             ctrl;                 /*    52     4 */

        /* size: 56, cachelines: 1, members: 9 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 13 +++++++----
 lib/dynamic_debug.c           | 44 ++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9237e4ecd1b..a551b2967cb8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,8 @@ struct _ddebug {
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
+	unsigned int unused:8;
+
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -58,7 +60,10 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	struct {
+		unsigned int flags:8;
+		unsigned unused:24;
+	} ctrl;
 } __attribute__((aligned(8)));
 
 enum class_map_type {
@@ -171,7 +176,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
-		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.ctrl = { .flags = _DPRINTK_FLAGS_DEFAULT },	\
 		.class_id = cls,				\
 		_DPRINTK_KEY_INIT				\
 	};							\
@@ -202,10 +207,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
+	likely(descriptor.ctrl.flags & _DPRINTK_FLAGS_ENABLED)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
+	unlikely(descriptor.ctrl.flags & _DPRINTK_FLAGS_ENABLED)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9682277f3909..f47cb76e0e3d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,6 +80,16 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline unsigned int get_flags(const struct _ddebug *desc)
+{
+	return desc->ctrl.flags;
+}
+
+static inline void set_flags(struct _ddebug *desc, unsigned int val)
+{
+	desc->ctrl.flags = val;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -247,11 +257,11 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
-			if (newflags == dp->flags)
+			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (newflags == get_flags(dp))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
 				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
 			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
@@ -261,9 +271,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
-			dp->flags = newflags;
+			set_flags(dp, newflags);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -824,10 +834,11 @@ static int remaining(int wrote)
 
 static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
+	unsigned int flags = get_flags(desc);
 	int pos_after_tid;
 	int pos = 0;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -835,16 +846,16 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+	if (flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc->filename));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
 	if (pos - pos_after_tid)
@@ -857,7 +868,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 
 static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
+	if (unlikely(get_flags(desc) & _DPRINTK_FLAGS_INCL_ANY))
 		return __dynamic_emit_prefix(desc, buf);
 	return buf;
 }
@@ -916,7 +927,8 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -928,7 +940,7 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -942,7 +954,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 			      const char *fmt, ...)
 {
 
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -950,7 +962,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -1246,7 +1258,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp->flags, &flags));
+		   ddebug_describe_flags(get_flags(dp), &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.43.0.472.g3155946c3a-goog


