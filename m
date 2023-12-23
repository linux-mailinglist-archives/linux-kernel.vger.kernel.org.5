Return-Path: <linux-kernel+bounces-10175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DA81D10C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BDB285007
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614715EB9;
	Sat, 23 Dec 2023 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="rYYvweEU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E12E5B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso2609532a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296335; x=1703901135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCgim+Lzybt1bsnBJ1bdt7sK2jYxpNtF/tNI/IwIPIs=;
        b=rYYvweEUAIZAU52pyxYMt4MhDsQdjNZFak92AI8WOGhFJLFAZTsvAW4Jiq2ihG59Dg
         etPxLRCdotBRzYF3G7jFAwBa9iq7g/kmcWJf/v/yoTyfAzOrPAJ7ioCAkVIRQY1hyhAH
         bgcr7RefS29wydCRNjjwE/BnAFM0Qf0FOAfLQMMDDAO2cJjcOc87YQxO9iNmtnLqWq0U
         y33laAWOury1lFceMQaaa2XIGgon/reKBrYFb/Yw3E4FKVVdlAflfNB1NWPQo6+EsDug
         NPh2QRBDilykrzxeDAt9sWGwieItFuep7TiJ+iDMK9BSCDhdhjKj1CXJ+EFxAt9AQleC
         3GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296335; x=1703901135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCgim+Lzybt1bsnBJ1bdt7sK2jYxpNtF/tNI/IwIPIs=;
        b=PKEtLM8lu/Y9yZKTQYi7dTL5AZ/HfmB6kCXv2wm+ozeWqPhfP/yxVFg8suum0iGSTM
         F+p7ngI336prnMAlqJYxgL2Ek3h53nWywXDesA4pDzoCwh8RXDjxJjLfHFSHoT/hVOL2
         OIjKERcbQZQCdHnwZ5Oeyaiy40URaaQqgWi3oqNgkk7mz+yhOGAKOcGJJeYKCLIAunaR
         9HQbPpVvWq4s3I45JDD/UkrACy9af4XJBUef8VYmHm3S2NJSY80xLTLwsYej/t5OhopC
         lfFmwSqpLODz4i0mjy2hm+DgB+KbnU/GuzTN2TcDItmN/yQGOGzsZ3wTT0Y1XmYULnsX
         GtKA==
X-Gm-Message-State: AOJu0YzUv7WlatDfJqT1oSHQs8HbDUyJpIsTR9z8spqKL3dwDzklTNkj
	MfrSJj9saEGfD8/GSKt063Rwzr96fPPj
X-Google-Smtp-Source: AGHT+IHM/jKsIP683yreZ4n4i4NWv+WTSC04fOtHCtu4IMYEau5AJUWHSBYSFIDLd6ODxQRzNeHY1g==
X-Received: by 2002:aa7:c517:0:b0:553:9e98:5178 with SMTP id o23-20020aa7c517000000b005539e985178mr596272edq.132.1703296335604;
        Fri, 22 Dec 2023 17:52:15 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:15 -0800 (PST)
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
Subject: [PATCH v3 15/22] dyndbg: add support for hex_dump output to trace
Date: Sat, 23 Dec 2023 02:51:24 +0100
Message-ID: <20231223015131.2836090-16-lb@semihalf.com>
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

Add support for writing hex_dump debug logs to trace.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 16 ++++++++++------
 lib/dynamic_debug.c           | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dc10c7535f13..76eec3f05be9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -298,12 +298,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
 			   dev, fmt, ##__VA_ARGS__)
 
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
-			 groupsize, buf, len, ascii)			\
-	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
-				   print_hex_dump,			\
-				   KERN_DEBUG, prefix_str, prefix_type,	\
-				   rowsize, groupsize, buf, len, ascii)
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii);
+
+#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,				\
+			 groupsize, buf, len, ascii)					\
+	_dynamic_func_call(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump",	\
+			   _print_hex_dump,						\
+			   KERN_DEBUG, prefix_str, prefix_type,				\
+			   rowsize, groupsize, buf, len, ascii)
 
 /* for test only, generally expect drm.debug style macro wrappers */
 #define __pr_debug_cls(cls, fmt, ...) do {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c382ea5dea19..65dafdec7b76 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1355,6 +1355,42 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 	}
 }
 
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), ascii);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%p: %s\n",
+				      level, prefix_str, ptr + i, linebuf);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%.8x: %s\n",
+				      level, prefix_str, i, linebuf);
+			break;
+		default:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%s\n",
+				      level, prefix_str, linebuf);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(_print_hex_dump);
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.43.0.472.g3155946c3a-goog


