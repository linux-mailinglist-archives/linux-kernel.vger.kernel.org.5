Return-Path: <linux-kernel+bounces-10173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D5D81D10A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D91F237E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F211C93;
	Sat, 23 Dec 2023 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="EdB/o8uT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E54E56C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33674f60184so2293346f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296332; x=1703901132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWilt8xXopZLz3aWBvrS8u+uuqRM1/IhwYaiNrDNBL8=;
        b=EdB/o8uTMFdMXswuew9mjIXOXLUBt+iQPjCLyYX1yIm4injx5Lsnh5ULdmb7v7CGOw
         wWfbXH6EeAnB6NtvbqwnsGNTVnJpZkPAsASe19PPMWoXpYAp+MlIofT6952zVmlpZA6p
         azN7/2BQoV4wz7W5IdA5LGS2liLNRhGriHcSq7jkoBdJl6UbkiYgCqYUSxffpTUoJrH+
         Rk+E78o45LCS2tvBRr34Ls0vA52tLafkhRkk6IUyem/LPwWAtjunn/sjsJ1gffgDnBSn
         I75dbEsnFGmxeSB1xRyAZ+6TIB9TgAIwKTgUWrUohbsWSp6hZIAOELIAqPg31/hh+BZW
         ewHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296332; x=1703901132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWilt8xXopZLz3aWBvrS8u+uuqRM1/IhwYaiNrDNBL8=;
        b=PJvxh/K/jZY79NjNirf7jY9JiFk0g2jN1Bi7qBWs2gi1NFqB/edTzFe/KiSb1Z8qBp
         rmCnn/T0fnffuh7FFLO7vrh1Ezt1SMc0EAzeXhJVDpcat8pxbXxk/3aJw9+Ev2cpZCPa
         dleOouyJ1CkHZpkuultnTIA+u+O5RbL/1k1TZ1LArsORLkPfVOkuqyM5a5oHDILvJAXr
         kzP20IzQ+1T3VcjIgSvwKhxIcBy8fRbCqZiZMFhGpVaYrnscQnhScY3RtO1UhZp0noD2
         9HhTcG6/ewZ6p2sOoyFQOs8XlrRx3ORpnw3NBZcOCiFgReQ4IY9WndAAIW3EtTvOrNwR
         aWkg==
X-Gm-Message-State: AOJu0YwAffA8QEqnH7F7/c36pxS1dHzim4DfYw7MOcU6Qbc4IH0g9I1v
	EDtKJvUAEIy/Ibiy5JTiDetpZGe7VCjZ
X-Google-Smtp-Source: AGHT+IE17AFKylC4vEQBQhSQfzkY3zey+tE/oZSiU8ugOZex1kpF3bBIdIhwS9dYXMoPcHe6M+QBjw==
X-Received: by 2002:a05:600c:3d0f:b0:40d:43ea:ed19 with SMTP id bh15-20020a05600c3d0f00b0040d43eaed19mr1064900wmb.124.1703296332488;
        Fri, 22 Dec 2023 17:52:12 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:12 -0800 (PST)
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
Subject: [PATCH v3 13/22] dyndbg: add support for default trace destination
Date: Sat, 23 Dec 2023 02:51:22 +0100
Message-ID: <20231223015131.2836090-14-lb@semihalf.com>
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

Instead of repeating trace destination name explicitly for each
command (e.g. +T:thunderbolt), this change saves previously used
trace destination provided to [=+-]T as default and consecutive
commands which don't provide trace destination explicitly will
usa the saved trace destination.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 94 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6c3b83bce18d..99ab5756f0ed 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,7 +72,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
-	unsigned int trace_dst;
+	int trace_dst;
 };
 
 #define DD_OPEN_CMD	"open"
@@ -99,6 +99,10 @@ struct dd_tracebuf_tbl_info {
 	struct dd_private_tracebuf buf[TRACE_DST_LAST];
 	DECLARE_BITMAP(bmap, TRACE_DST_LAST);
 	int bmap_size;
+#define DST_NOT_SET	(-1)
+#define DST_TR_EVENT	0
+#define DST_NOT_SET_STR "not set"
+	int default_dst;
 };
 
 static DEFINE_MUTEX(ddebug_lock);
@@ -109,7 +113,8 @@ MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
 static struct
-dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST };
+dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST,
+				 .default_dst = DST_NOT_SET, };
 
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
@@ -131,6 +136,11 @@ static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 	return desc->ctrl.trace_dst;
 }
 
+static inline bool has_tr_default_dst(void)
+{
+	return trc_tbl.default_dst != DST_NOT_SET;
+}
+
 static int find_tr_instance(const char *name)
 {
 	int idx = 1;
@@ -145,11 +155,16 @@ static int find_tr_instance(const char *name)
 static const
 char *read_T_args(const char *str, struct flag_settings *modifiers)
 {
-	int len, idx = 0;
-	char *end;
+	bool has_colon = *(str+1) == ':' ? true : false;
+	int len = 0, idx = DST_TR_EVENT;
+	char *end = NULL;
 
-	if (*(str+1) != ':')
-		return str;
+	if (!has_colon) {
+		if (!has_tr_default_dst())
+			return NULL;
+		idx = trc_tbl.default_dst;
+		goto end;
+	}
 
 	str += 2;
 	end = strchr(str, '.');
@@ -168,8 +183,12 @@ char *read_T_args(const char *str, struct flag_settings *modifiers)
 		goto end;
 
 	idx = find_tr_instance(str);
-	if (idx < 0)
-		return NULL;
+	if (idx < 0) {
+		if (!has_tr_default_dst() ||
+		    has_colon)
+			return NULL;
+		idx = trc_tbl.default_dst;
+	}
 end:
 	modifiers->trace_dst = idx;
 	return end ? end : str + len;
@@ -389,6 +408,13 @@ static int handle_trace_close_cmd(const char *arg)
 		goto end;
 	}
 
+	/*
+	 * check if default trace instance is being closed,
+	 * if yes then clear default destination
+	 */
+	if (trc_tbl.default_dst == idx)
+		trc_tbl.default_dst = DST_NOT_SET;
+
 	trace_array_put(buf->arr);
 	/*
 	 * don't destroy trace instance but let user do it manually
@@ -427,6 +453,30 @@ void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
 		trc_tbl.buf[ndst].use_cnt++;
 }
 
+static const char *get_tr_default_dst_str(void)
+{
+	switch (trc_tbl.default_dst) {
+	case DST_NOT_SET:
+		return DST_NOT_SET_STR;
+	case DST_TR_EVENT:
+		return DD_TR_EVENT;
+	default:
+		return trc_tbl.buf[trc_tbl.default_dst].name;
+	}
+}
+
+static void update_tr_default_dst(const struct flag_settings *modifiers)
+{
+	int dst = modifiers->trace_dst;
+
+	if (dst == DST_NOT_SET || dst == trc_tbl.default_dst)
+		return;
+
+	trc_tbl.default_dst = dst;
+	v3pr_info("set default trace dst to idx=%d, name=%s\n", dst,
+		  get_tr_default_dst_str());
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	if (nwords != 1)
@@ -537,7 +587,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			nctrl.trace_dst = modifiers->trace_dst;
+			nctrl.trace_dst = modifiers->trace_dst == DST_NOT_SET ?
+				get_trace_dst(dp) : modifiers->trace_dst;
 			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
@@ -561,6 +612,9 @@ static int ddebug_change(const struct ddebug_query *query,
 	if (!nfound && verbose)
 		pr_info("no matches for query\n");
 
+	if (nfound)
+		update_tr_default_dst(modifiers);
+
 	return nfound;
 }
 
@@ -833,7 +887,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	struct flag_settings modifiers = {};
+	struct flag_settings modifiers = { .trace_dst = DST_NOT_SET };
 	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -1595,15 +1649,21 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
-	if (ddebug_iter_is_last(iter) &&
-	    !bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
-		int idx = 1;
+	if (ddebug_iter_is_last(iter)) {
 
 		seq_puts(m, "\n");
-		seq_puts(m, "#: Opened trace instances:");
-		for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
-			seq_printf(m, " %s", trc_tbl.buf[idx].name);
-		seq_puts(m, "\n");
+		seq_printf(m, "#: Default trace destination: %s\n",
+			   get_tr_default_dst_str());
+
+		if (!bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
+			int idx = 1;
+
+			seq_puts(m, "\n");
+			seq_puts(m, "#: Opened trace instances:");
+			for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+				seq_printf(m, " %s", trc_tbl.buf[idx].name);
+			seq_puts(m, "\n");
+		}
 	}
 
 	return 0;
-- 
2.43.0.472.g3155946c3a-goog


