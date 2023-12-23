Return-Path: <linux-kernel+bounces-10172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97381D109
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C41F23568
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116DFBF0;
	Sat, 23 Dec 2023 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="rYDqcOgs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A1DDC5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-553a65b6ad4so2935961a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296331; x=1703901131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdlqWnqu9HEJF4lwlqaoI5sQ4NORb79u2q0+TdaOEs0=;
        b=rYDqcOgsRmzpEu5dKICHgLl8VPhVmtX8hieuml5eNjtFMUsjrcqYUlbtYO4GtJzF3G
         wEQnXet+8R5D4plQugGTsygSne1EzxdEHDEpuQ4ZD6TQ9zSc1Uzw2cvdAXfgyRRPgU0S
         IVuxQ7jgJYXGs74sDzKm2BgYLkybMzoMVXNS+xDsb/NghAo5Gt6ieIUSlcSgpmyNEGwO
         i+xgRgRV32rlqOLH4Pw9AFdvYdHql/6u0IIlJIxftbc4CFnwB5MvQI5RlxlXcwJUcW16
         f7oIVOKhB67aHzKZoDZ1wZwu3U3GU4NQ3ZqaKqiSDf9PCowo+keOXRQrQtdZHnSZtzE5
         TRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296331; x=1703901131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdlqWnqu9HEJF4lwlqaoI5sQ4NORb79u2q0+TdaOEs0=;
        b=IabxqRL0fCRZHFydlV8mCnljsTF168+ZtvzAHw5C8b90r8Yj5xl9chr+x2NEf3Vnf+
         M99e9/IZ9UUX2pwbm7XE4x5eFdDfWA1rwi1VTLeUxnq7c5BggsYTM3pUpkiVHLvabEB7
         zn7muKdQJqmmGNYKc85Mws36X7ivNLgAEjuFwbQr2eL+I4pGkwYvX55DT2cqfHzdYznO
         12FzteJqglY6GFecsn/1X7JyZsuDhfGiAHcwZ3Hu3q8Xviv0XM6so5gvcHf3x0wsUDM+
         Bua7MiYmX+onQ6PbCk64zcQ4+CfUlwJ29+qFqby4Y+XE0TB9Fc4U2DGOmgeZkPF2YR0c
         r/mA==
X-Gm-Message-State: AOJu0Yxy2T+BpYTWjReFSVi/M2PSfiyPSIqy/ttIg6kUSwa9d6YrsCV2
	fdsg3UfTr9O46nAZWIXcKpoqc6HVYdcY
X-Google-Smtp-Source: AGHT+IGYUfC9BV1Iv3mCxfW9RC983wRGDmYmzGV2y5ENG/M56vKgRJNTiSeOeJwsuKyaJWd3viuM0w==
X-Received: by 2002:a50:d4ce:0:b0:54c:4837:a63f with SMTP id e14-20020a50d4ce000000b0054c4837a63fmr1227919edj.44.1703296330900;
        Fri, 22 Dec 2023 17:52:10 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:10 -0800 (PST)
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
Subject: [PATCH v3 12/22] dyndbg: add processing of T(race) flag argument
Date: Sat, 23 Dec 2023 02:51:21 +0100
Message-ID: <20231223015131.2836090-13-lb@semihalf.com>
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

Add processing of argument provided to T(race) flag.
The string argument determines destination of debug logs:

"0"  - debug logs will be written to prdbg and devdbg trace events
name - debug logs will be written to trace instance pointed by name,
       trace instance name has to be previously opened with open
       command

A user can provide trace destination name by following T flag with
":" and trace destination name, for example:

echo "module thunderbolt =pT:tbt" > <debugfs>/dynamic_debug/control
echo "module thunderbolt =lT:tbt.p" > <debugfs>/dynamic_debug/control

When T flag with argument is followed by other flag then the next
flag has to be preceded with ".". Use of "." as a separator between
flags allows a later patch to treat ',' as a space, which mostly
eliminates the need to quote query/rules. And this in turn avoids
quoting hassles:

  modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

It is particularly good for passing boot-args into test-scripts.

  vng -p 4 -v \
  -a test_dynamic_debug.dyndbg=class,D2_CORE,+p

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 180 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 141 insertions(+), 39 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 59682729ed3a..6c3b83bce18d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,6 +72,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
+	unsigned int trace_dst;
 };
 
 #define DD_OPEN_CMD	"open"
@@ -85,10 +86,14 @@ struct dd_private_tracebuf {
 };
 
 /*
- * Trace destination value 0 is reserved for writing
- * debug logs to trace events (prdbg, devdbg), that
- * is why buf[0] is not used and we traverse bitmap
- * starting from bit 1 (bit 0 is also not used).
+ * When trace is enabled (T flag is set) and trace destination field
+ * value is in range [1..63] then debug logs will be written to trace
+ * instance whose name is stored in buf[trace destination].name, e.g.
+ * when trace destination value is 2 and buf[2].name is set to tbt then
+ * debug logs will be written to <debugfs>/tracing/instances/tbt.
+ * On the other hand trace destination value 0 is reserved for writing
+ * debug logs to trace events (prdbg, devdbg), that is why buf[0] is not
+ * used and we traverse bitmap starting from bit 1 (bit 0 is also not used).
  */
 struct dd_tracebuf_tbl_info {
 	struct dd_private_tracebuf buf[TRACE_DST_LAST];
@@ -126,6 +131,73 @@ static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 	return desc->ctrl.trace_dst;
 }
 
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
+static const
+char *read_T_args(const char *str, struct flag_settings *modifiers)
+{
+	int len, idx = 0;
+	char *end;
+
+	if (*(str+1) != ':')
+		return str;
+
+	str += 2;
+	end = strchr(str, '.');
+	if (end && *(end + 1) == '\0')
+		return NULL;
+
+	if (end) {
+		len = end - str;
+		*end = '\0';
+	} else
+		len = strlen(str);
+	len -= 1;
+
+	/* destination trace events */
+	if (!strcmp(str, DD_TR_EVENT))
+		goto end;
+
+	idx = find_tr_instance(str);
+	if (idx < 0)
+		return NULL;
+end:
+	modifiers->trace_dst = idx;
+	return end ? end : str + len;
+}
+
+/*
+ * Maximum number of characters which are being displayed when
+ * printing trace instance name, longer names are truncated
+ */
+#define FLAG_T_ARG_LEN 24
+
+static char *show_T_args(struct dd_ctrl *ctrl, char *p)
+{
+	const char *str;
+	int n;
+
+	str = !ctrl->trace_dst ? DD_TR_EVENT :
+	      trc_tbl.buf[ctrl->trace_dst].name;
+
+	n = snprintf(p, FLAG_T_ARG_LEN, ":%s", str);
+	if (n >= FLAG_T_ARG_LEN) {
+		strscpy(&p[FLAG_T_ARG_LEN-4], "...", 4);
+		n = FLAG_T_ARG_LEN - 1;
+	}
+
+	return n < 0 ? p : p + n;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -137,9 +209,18 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
+typedef const char* (*read_flag_args_f)(const char *, struct flag_settings *);
+typedef char* (*show_flag_args_f)(struct dd_ctrl *, char *);
+
+static const struct
+{
+	unsigned flag:8;
+	char opt_char;
+	read_flag_args_f read_args;
+	show_flag_args_f show_args;
+} opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINTK, 'p' },
-	{ _DPRINTK_FLAGS_TRACE, 'T' },
+	{ _DPRINTK_FLAGS_TRACE, 'T', read_T_args, show_T_args},
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -148,22 +229,30 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
-struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+struct ctrlbuf { char buf[ARRAY_SIZE(opt_array)+FLAG_T_ARG_LEN+1]; };
 
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
+static char *ddebug_describe_ctrl(struct dd_ctrl *ctrl, struct ctrlbuf *cb)
 {
-	char *p = fb->buf;
+	show_flag_args_f show_args = NULL;
+	char *p = cb->buf;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (flags & opt_array[i].flag)
+		if (ctrl->flags & opt_array[i].flag) {
+			if (show_args)
+				*p++ = '.';
 			*p++ = opt_array[i].opt_char;
-	if (p == fb->buf)
+			show_args = opt_array[i].show_args;
+			if (show_args)
+				p = show_args(ctrl, p);
+		}
+
+	if (p == cb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return fb->buf;
+	return cb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -221,17 +310,6 @@ static bool dd_good_trace_name(const char *str)
 	return true;
 }
 
-static int find_tr_instance(const char *name)
-{
-	int idx = 1;
-
-	for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
-		if (!strcmp(trc_tbl.buf[idx].name, name))
-			return idx;
-
-	return -ENOENT;
-}
-
 static int handle_trace_open_cmd(const char *arg)
 {
 	struct dd_private_tracebuf *buf;
@@ -385,7 +463,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
  * callsites, normally the same as number of changes.  If verbose,
- * logs the changes.  Takes ddebug_lock.
+ * logs the changes.
  */
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
@@ -393,13 +471,12 @@ static int ddebug_change(const struct ddebug_query *query,
 	int i;
 	struct ddebug_table *dt;
 	unsigned int nfound = 0;
+	struct ctrlbuf cbuf, nbuf;
 	struct dd_ctrl nctrl = {0};
-	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
 
 	/* search for matching ddebugs */
-	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
 
 		/* match against the module name */
@@ -460,7 +537,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
+			nctrl.trace_dst = modifiers->trace_dst;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
@@ -473,13 +551,12 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(nctrl.flags, &nbuf));
+				  ddebug_describe_ctrl(&dp->ctrl, &cbuf),
+				  ddebug_describe_ctrl(&nctrl, &nbuf));
 			update_tr_dst(dp, &nctrl);
 			set_ctrl(dp, &nctrl);
 		}
 	}
-	mutex_unlock(&ddebug_lock);
 
 	if (!nfound && verbose)
 		pr_info("no matches for query\n");
@@ -700,6 +777,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
+	read_flag_args_f read_args;
 	int op, i;
 
 	switch (*str) {
@@ -718,6 +796,12 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
 				modifiers->flags |= opt_array[i].flag;
+				read_args = opt_array[i].read_args;
+				if (read_args) {
+					str = read_args(str, modifiers);
+					if (!str)
+						return -EINVAL;
+				}
 				break;
 			}
 		}
@@ -726,7 +810,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -765,20 +849,38 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	if (is_dd_trace_cmd(words[0]))
 		return ddebug_parse_cmd(words, nwords-1);
 
-	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
-		pr_err("flags parse failed\n");
-		return -EINVAL;
-	}
 	if (ddebug_parse_query(words, nwords-1, &query, modname)) {
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+
+	/*
+	 * Both ddebug_parse_flags and ddebug_change have to be run
+	 * with locking because ddebug_parse_flags->read_T_args verifies
+	 * if a requested trace instance is opened. Next ddebug_change
+	 * sets the requested trace instance as output for debug logs of
+	 * callsite(s) which matched a query. Because ddebug_proc_write
+	 * function can be called concurrently then without locking we
+	 * could for example run into a scenario where ddebug_change uses
+	 * a trace instance which is already closed.
+	 */
+	mutex_lock(&ddebug_lock);
+
+	/* check flags 1st (last arg) so query is pairs of spec,val */
+	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
+		pr_err("flags parse failed\n");
+		goto err;
+	}
+
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
+	mutex_unlock(&ddebug_lock);
+	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 	return nfound;
+err:
+	mutex_unlock(&ddebug_lock);
+	return -EINVAL;
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1468,7 +1570,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct flagsbuf flags;
+	struct ctrlbuf cbuf;
 	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
@@ -1480,7 +1582,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(get_flags(dp), &flags));
+		   ddebug_describe_ctrl(&dp->ctrl, &cbuf));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.43.0.472.g3155946c3a-goog


