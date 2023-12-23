Return-Path: <linux-kernel+bounces-10169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F181D106
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD1628150C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9460D26C;
	Sat, 23 Dec 2023 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="lRpY6c0f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119FD2E9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so2522411a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296326; x=1703901126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57pqwApzCkOiEG2Ugf+nH1exjoE9SPHxB+wBjTutXCY=;
        b=lRpY6c0f+dXrhN5Tv21ZDX/TSvFBMIX2Ec4iBMZCCRAcGjwvcMmUK0doJJ+n6JE5uz
         H24XUSBlF9eXXL7dNwCD4yg0TKeVF7hmOy0VnGCjF9guSB4RkoruFyfuZZCGhW6fj759
         fKwWkCL8CAs4V1p8V5VqMtJ47iEkMSKDpqDcbFK4xWpYGNOuARpz7U0fEBPINRvH39s+
         02/NDFV0bpDYjFP7mMjDksSMf4jc2n9nPx7kvWDMX1/Abzbany2N6It2kGhDFhWvzzee
         KS/XLrIdqBu/u6LS3jKLDGLHS9SViM1a8Be+eDtB3M/brIJYa/mq/31GpHe2lCtJJnlt
         dwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296326; x=1703901126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57pqwApzCkOiEG2Ugf+nH1exjoE9SPHxB+wBjTutXCY=;
        b=Qp1x4CcJ9jLifSJEUIzhfr6uMnffsg9wi7iflPLBw0tnsnObVBZ1VpzOck5p6Ile4G
         8BdAIY0mXFm1LN8dDO14farNV+fB6bXNAr4W5Dudo8j3h5puJJ5Ik5dWPWrFFwpqmJhq
         HKwgLCPQvy60XiT9myhIATLdDEPzBvWJHs4oa+1L5K3IjgoS5vmQqWEjRJCs4TgI11SP
         aVaLLO8S3LNow79VxvbpLSCvIzH++55/n8ww2s5hXlZNNdGygpE0p2sy2xsGcqNje/hj
         T8f3nsNSByMre5DKn0cMR74qruzLCUXcSOuQefcQ+A89F+eUOFFPRdeYRh2V8Fhn8uc8
         6NDQ==
X-Gm-Message-State: AOJu0Yz+kViOnloVtT2vdCVS+AnXkRKS/FyOvU1syCmJ58AiHI037Rpk
	fwk6OKv7xhAU/t8HpPz5F8sVs26ZNoU1
X-Google-Smtp-Source: AGHT+IH03hdTLJyjncTLfZUFWQ1NJlJVPfy8D1iUUGd/a/xnIMBCViz/k97k92NIZuxTBIJo+ro0Dg==
X-Received: by 2002:a50:cd95:0:b0:551:da9f:38c2 with SMTP id p21-20020a50cd95000000b00551da9f38c2mr1105775edi.71.1703296326031;
        Fri, 22 Dec 2023 17:52:06 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:05 -0800 (PST)
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
Subject: [PATCH v3 09/22] dyndbg: add trace destination field to _ddebug
Date: Sat, 23 Dec 2023 02:51:18 +0100
Message-ID: <20231223015131.2836090-10-lb@semihalf.com>
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

The trace destination field is used to determine output of debug
logs when +T is set. Setting trace_dst value to 0 enables output
to prdbg and devdbg trace events. Setting trace_dst value to a
value in range of [1..63] enables output to trace instance.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 13 +++++++++++--
 lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a551b2967cb8..dc10c7535f13 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,9 +60,18 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	struct {
+	struct dd_ctrl {
 		unsigned int flags:8;
-		unsigned unused:24;
+	/*
+	 * The trace destination field is used to determine output of debug
+	 * logs when +T is set. Setting trace_dst value to 0 enables output
+	 * to prdbg and devdbg trace events. Setting trace_dst value to a
+	 * value in range of [1..63] enables output to trace instance.
+	 */
+#define TRACE_DST_BITS 6
+		unsigned int trace_dst:TRACE_DST_BITS;
+#define TRACE_DST_LAST	(1 << TRACE_DST_BITS)
+		unsigned unused:18;
 	} ctrl;
 } __attribute__((aligned(8)));
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f47cb76e0e3d..0dc9ec76b867 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,14 +80,24 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
+{
+	return &desc->ctrl;
+}
+
+static inline void set_ctrl(struct _ddebug *desc, struct dd_ctrl *ctrl)
+{
+	desc->ctrl = *ctrl;
+}
+
 static inline unsigned int get_flags(const struct _ddebug *desc)
 {
 	return desc->ctrl.flags;
 }
 
-static inline void set_flags(struct _ddebug *desc, unsigned int val)
+static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 {
-	desc->ctrl.flags = val;
+	return desc->ctrl.trace_dst;
 }
 
 /* Return the path relative to source root */
@@ -190,8 +200,8 @@ static int ddebug_change(const struct ddebug_query *query,
 {
 	int i;
 	struct ddebug_table *dt;
-	unsigned int newflags;
 	unsigned int nfound = 0;
+	struct dd_ctrl nctrl = {0};
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
@@ -257,14 +267,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (newflags == get_flags(dp))
+			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
-				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
+				if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
+			} else if (nctrl.flags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
@@ -272,8 +282,8 @@ static int ddebug_change(const struct ddebug_query *query,
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(newflags, &nbuf));
-			set_flags(dp, newflags);
+				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			set_ctrl(dp, &nctrl);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.43.0.472.g3155946c3a-goog


