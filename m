Return-Path: <linux-kernel+bounces-10161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239781D0FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E48A285082
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7687B1109;
	Sat, 23 Dec 2023 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="kK/EUhAc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBB802
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so2909664a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296311; x=1703901111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wna70XTeBlFKQHd72a/Hk84hDNIQx/tPURUUiyG4BEI=;
        b=kK/EUhAcP/V2QTddLJqSJPE5QLAGwu1SZuW2RBgXiFndE4yRu6+Zl4t6yKIza5biqM
         69bdYU5nuJWk1bg5Cs29GREyK1pNuuHYue8FeAMaN1WmT2/xsXxoro3oMx0YzHY5Cx7Y
         2Lqi9USNxE6cEy7nHGqGr91fruNzlFAX/hKnXPt6/d5kmr78Fg/q8Jb/vIye/p05WdAM
         LYmRaoyy9vQYKQasLLgFqe6AOVRSBPu1GN33mQpMxdyuniyfDRzIpjT9DNOWetW4HgEd
         GA+ulwX4hdXsmyHVD1+tw6osvaKwPLa3cVtQcOwtpRiPabBXVmDdmFmclC+oCBTUt6rM
         dABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296311; x=1703901111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wna70XTeBlFKQHd72a/Hk84hDNIQx/tPURUUiyG4BEI=;
        b=A37uREzF8LmWtgDSuaCb88K5VyRKWrwP/PdIqLuEAtH07Z/F4g8mG2kpobWbZhwB35
         Rhw+NUoErUM8fJkg5QbOSJkVzZvI7XMbWfXmIqP9Xfkx49kdhJUZLzbe7CGI3fbRfYZZ
         A74FvugAKioLsdWVGA/jKUE26NXop7F9xranBsd5u8rGoRZXRPrwdY4vbxzteHRDExuB
         yUjqtIZz6Mar21ER9YBAkdp7nPtwm/LXmQHajxW6Xv/4aO7AN6KcApOfK4mP302NL0pY
         ca4Z3f1YTnpPydA4+T+RU9s1NDMNCXOd2ii/ASc5/+k8RbBesnevH+b7Fan8LWhzhZ15
         bYAA==
X-Gm-Message-State: AOJu0Yxur0hbXs6ystpWVZSP3HtkE6Kzi4MbYemVkffkCiKwvQfH5Hwi
	yTIV887OJPRLJH3FPSvI63y9ijd2wSj6
X-Google-Smtp-Source: AGHT+IHuAI+pCvrrP5Nn9XPNhtdmvTAUBKtkiKmu5JmUZSpJIUgA5u9YqukoNQm7zBUDXFJxDcwu8A==
X-Received: by 2002:a50:d74e:0:b0:554:877e:b7f with SMTP id i14-20020a50d74e000000b00554877e0b7fmr156143edj.39.1703296311200;
        Fri, 22 Dec 2023 17:51:51 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:50 -0800 (PST)
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
Subject: [PATCH v3 01/22] dyndbg: add _DPRINTK_FLAGS_ENABLED
Date: Sat, 23 Dec 2023 02:51:10 +0100
Message-ID: <20231223015131.2836090-2-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Distinguish the condition: _DPRINTK_FLAGS_ENABLED from the bit:
_DPRINTK_FLAGS_PRINT, and re-define former in terms of latter, in
preparation to add a 2nd bit: _DPRINTK_FLAGS_TRACE

Update JUMP_LABEL code block to check _DPRINTK_FLAGS_ENABLED symbol.
Also add a 'K' to get new symbol _DPRINTK_FLAGS_PRINTK, in order to
break any stale uses.

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 10 ++++++----
 lib/dynamic_debug.c           |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..7be791af7cf1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,7 +32,7 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +44,10 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
+#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+
 #if defined DEBUG
-#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
@@ -199,10 +201,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..ee0cb37153ef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -89,7 +89,7 @@ static inline const char *trim_prefix(const char *path)
 }
 
 static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -247,10 +247,10 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(newflags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
+			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
-- 
2.43.0.472.g3155946c3a-goog


