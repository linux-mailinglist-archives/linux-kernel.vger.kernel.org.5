Return-Path: <linux-kernel+bounces-10170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45C81D107
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD11F237B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0CDDA5;
	Sat, 23 Dec 2023 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="AnqYeeIU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841ACA58
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so4189751a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296327; x=1703901127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2o9QWUmLsmLvKLWM0RR7VB6Xiaqd4YI7JC6zr82+Kw=;
        b=AnqYeeIUOnM+Q0jcIMVTs8efCgrE7FyjvKMuHj8M2fvOYEkZPhsGZgWUeub9Q4keem
         1YSPIuX5rjeJ70GPqLLgoUDyzXK+tsGfzm0vFk7SoJkq7hwO2fWns9Lwz+4tkyVemcAE
         QroHcymdPU6fCgBMYEQdZhBxrcT0SahDy8l4z8CNVvkJeg1nwz3/EnR47lIc/ojeVg9I
         cCQBdRWoj2tJAmypkkKl+4gG6b4YrCKS6kCKLIA7rwAQTgYO9CSFoZwq+OagMfpl8BEC
         HIgVns3KdLtVyZSQ7ryo94AzG6Kcoj0gobocvFhOUnc3ZdODH+qUSJaNMR4lIsD43NBS
         YPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296327; x=1703901127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2o9QWUmLsmLvKLWM0RR7VB6Xiaqd4YI7JC6zr82+Kw=;
        b=tLR89vyQbIi7A63YbjXKRXDIfxEgpndDZx72JR/ERts3unVk+c0hcInOHQqZzYC9N+
         UzQsBdtq8jAI2PS59Uy5ZBKdfu4G+p/hjh1uUKTxAguXs03kv9cdrTjm+C7L9iYmtEJs
         qJN0ZC3crZIH3Bhxfvohi9/Doo5dCECd3/P/HjyfAw61b+ZNBU12lQ/Wo0IFdTKLDnzU
         bq6Cv19si5sw5/XRJLLd49ZTL8aVWEsqQXItTTrbSnaC0rW6Wco2AH3QR7rdG4n50Q7i
         +3Yn9Q3hkchAERALhIYafg2OdtGixi55FlTrrJrK8B4ky+EioNyGxK30o+e4nt4kndGm
         fbnQ==
X-Gm-Message-State: AOJu0YxRpOScLZelclOaBIbNtC7dcJnTUrwffAWagvImZ0eUQAjPbdtt
	Dg4++e25j4BnP3OwvDT3Pq4mqGUCT5mX
X-Google-Smtp-Source: AGHT+IF/IEi1FPdb8lQGnNOd/id6xI/QKz57n41JZHWM68qfCtK5pV2adnQyHwnZGkKbf7zsoRGzng==
X-Received: by 2002:a50:d7dd:0:b0:553:39e3:879a with SMTP id m29-20020a50d7dd000000b0055339e3879amr2149324edj.41.1703296327595;
        Fri, 22 Dec 2023 17:52:07 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:07 -0800 (PST)
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
Subject: [PATCH v3 10/22] dyndbg: add open and close commands for trace
Date: Sat, 23 Dec 2023 02:51:19 +0100
Message-ID: <20231223015131.2836090-11-lb@semihalf.com>
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

Add open and close commands for opening and closing trace instances.
The open command has to be mandatory followed by a trace instance name.
If a trace instance already exists in <debugfs>/tracing/instances
directory then the open command will reuse it otherwise a new trace
instance with a name provided to the open will be created. Close
command closes previously opened trace instance. The close will
fail if a user tries to close non-existent trace instances or an
instance which was not previously opened.

For example the following command will open (create or reuse existing)
trace instance located in <debugfs>/tracing/instances/usbcore:

    echo "open usbcore" > <debugfs>/dynamic_debug/control

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/Kconfig.debug   |   2 +
 lib/dynamic_debug.c | 194 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..233132a05299 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -110,6 +110,7 @@ config DYNAMIC_DEBUG
 	default n
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	select DYNAMIC_DEBUG_CORE
 	help
 
@@ -181,6 +182,7 @@ config DYNAMIC_DEBUG_CORE
 	bool "Enable core function of dynamic debug support"
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	help
 	  Enable core functional support of dynamic debug. It is useful
 	  when you want to tie dynamic debug to your kernel modules with
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0dc9ec76b867..dd4510ad124e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/trace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dyndbg.h>
@@ -73,6 +74,27 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+#define DD_OPEN_CMD	"open"
+#define DD_CLOSE_CMD	"close"
+#define DD_TR_EVENT	"0"
+
+struct dd_private_tracebuf {
+	const char *name;
+	struct trace_array *arr;
+};
+
+/*
+ * Trace destination value 0 is reserved for writing
+ * debug logs to trace events (prdbg, devdbg), that
+ * is why buf[0] is not used and we traverse bitmap
+ * starting from bit 1 (bit 0 is also not used).
+ */
+struct dd_tracebuf_tbl_info {
+	struct dd_private_tracebuf buf[TRACE_DST_LAST];
+	DECLARE_BITMAP(bmap, TRACE_DST_LAST);
+	int bmap_size;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -80,6 +102,9 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static struct
+dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST };
+
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
 	return &desc->ctrl;
@@ -171,6 +196,145 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+static bool is_dd_trace_cmd(const char *str)
+{
+	if (!strcmp(str, DD_OPEN_CMD) || !strcmp(str, DD_CLOSE_CMD))
+		return true;
+
+	return false;
+}
+
+static bool dd_good_trace_name(const char *str)
+{
+	/* "0" is reserved for writing debug logs to trace events (prdbg, devdbg) */
+	if (!strcmp(str, DD_TR_EVENT))
+		return false;
+
+	/* we allow trace instance names to include ^\w+ and underscore */
+	while (*str != '\0') {
+		if (!isalnum(*str) && *str != '_')
+			return false;
+		str++;
+	}
+
+	return true;
+}
+
+static int find_tr_instance(const char *name)
+{
+	int idx = 1;
+
+	for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+		if (!strcmp(trc_tbl.buf[idx].name, name))
+			return idx;
+
+	return -ENOENT;
+}
+
+static int handle_trace_open_cmd(const char *arg)
+{
+	struct dd_private_tracebuf *buf;
+	int idx, ret = 0;
+
+	mutex_lock(&ddebug_lock);
+
+	/* bit 0 is not used, reserved for trace prdbg and devdbg events */
+	idx = find_next_zero_bit(trc_tbl.bmap, trc_tbl.bmap_size, 1);
+	if (idx == trc_tbl.bmap_size) {
+		ret = -ENOSPC;
+		goto end;
+	}
+
+	if (!dd_good_trace_name(arg)) {
+		pr_err("invalid instance name:%s\n", arg);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (find_tr_instance(arg) >= 0) {
+		pr_err("instance is already opened name:%s\n", arg);
+		ret = -EEXIST;
+		goto end;
+	}
+
+	buf = &trc_tbl.buf[idx];
+	buf->name = kstrdup(arg, GFP_KERNEL);
+	if (!buf->name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	buf->arr = trace_array_get_by_name(buf->name);
+	if (!buf->arr) {
+		pr_err("failed to get trace array name:%s", buf->name);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = trace_array_init_printk(buf->arr);
+	if (ret) {
+		pr_err("failed to init trace array name:%s", buf->name);
+		trace_array_put(buf->arr);
+		trace_array_destroy(buf->arr);
+		goto end;
+	}
+
+	set_bit(idx, trc_tbl.bmap);
+	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int handle_trace_close_cmd(const char *arg)
+{
+	struct dd_private_tracebuf *buf;
+	int idx, ret = 0;
+
+	mutex_lock(&ddebug_lock);
+
+	idx = find_tr_instance(arg);
+	if (idx < 0) {
+		ret = idx;
+		goto end;
+	}
+
+	buf = &trc_tbl.buf[idx];
+
+	trace_array_put(buf->arr);
+	/*
+	 * don't destroy trace instance but let user do it manually
+	 * with rmdir command at a convenient time later, if it is
+	 * destroyed here all debug logs will be lost
+	 *
+	 * trace_array_destroy(inst->arr);
+	 */
+	buf->arr = NULL;
+
+	kfree(buf->name);
+	buf->name = NULL;
+
+	clear_bit(idx, trc_tbl.bmap);
+	v3pr_info("closed trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int ddebug_parse_cmd(char *words[], int nwords)
+{
+	if (nwords != 1)
+		return -EINVAL;
+
+	if (!strcmp(words[0], DD_OPEN_CMD))
+		return handle_trace_open_cmd(words[1]);
+	if (!strcmp(words[0], DD_CLOSE_CMD))
+		return handle_trace_close_cmd(words[1]);
+
+	pr_err("invalid command %s\n", words[0]);
+	return -EINVAL;
+}
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							  const char *class_string, int *class_id)
 {
@@ -567,6 +731,11 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("tokenize failed\n");
 		return -EINVAL;
 	}
+
+	/* check for open, close commands */
+	if (is_dd_trace_cmd(words[0]))
+		return ddebug_parse_cmd(words, nwords-1);
+
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
@@ -1191,6 +1360,20 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 	return &iter->table->ddebugs[iter->idx];
 }
 
+/*
+ * Check if the iterator points to the last _ddebug object
+ * to traverse.
+ */
+static bool ddebug_iter_is_last(struct ddebug_iter *iter)
+{
+	if (iter->table == NULL)
+		return false;
+	if (iter->idx-1 < 0 &&
+	    list_is_last(&iter->table->link, &ddebug_tables))
+		return true;
+	return false;
+}
+
 /*
  * Seq_ops start method.  Called at the start of every
  * read() call from userspace.  Takes the ddebug_lock and
@@ -1281,6 +1464,17 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
+	if (ddebug_iter_is_last(iter) &&
+	    !bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
+		int idx = 1;
+
+		seq_puts(m, "\n");
+		seq_puts(m, "#: Opened trace instances:");
+		for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+			seq_printf(m, " %s", trc_tbl.buf[idx].name);
+		seq_puts(m, "\n");
+	}
+
 	return 0;
 }
 
-- 
2.43.0.472.g3155946c3a-goog


