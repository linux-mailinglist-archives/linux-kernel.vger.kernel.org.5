Return-Path: <linux-kernel+bounces-10174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E381D10B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB932B24624
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B512E71;
	Sat, 23 Dec 2023 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="dJ75vPjM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DF10958
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc794df8aaso27688301fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296334; x=1703901134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6no3BwB4DIf/yo3cr68iWvpmo5tlfbyqPOfodflbjdk=;
        b=dJ75vPjM1nm7UIMCtD6ufaBsaSXWYQTbU/2FujH2j2OyiRiR4UAmSj7VtVVtHQ/PDR
         m65M1gYy7gqKDUYrFlYiiNj/4rXDCl+RJ7nJ+l8J73LHtWzxO4Y5coXGumk/QbkEZ8wZ
         FAEzBwku18SdX1hL93FPs187drniuR5zYtjn1uVAF7CEY8c5OMM+obTztoIQfTbw0s+E
         hkGVylf5p6sqouO8VzlUMcrEHuat75UVbFpITRzqXyyp5EKdGZ0ze8waKvzou8P+6L8r
         7gsqhfqJ4O21TyDLcjcoVH3c4AAVg979Nix7uRRJUoz2D7D5ytu2XdArtokVf0BO4HiW
         Cn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296334; x=1703901134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6no3BwB4DIf/yo3cr68iWvpmo5tlfbyqPOfodflbjdk=;
        b=ZKlnDmeR7g1rEpw/Ir2OTHGTyHJBSiroAS9uyQ1OUxgBC5YXeOOhkHdXdUd6N4NvJn
         5Wggozn6k4bTWBNgpiRMoM0zx+blJhOYvICKPvp9Y3osiwMSZ5IEFThaR9ZNn2pT5Y+Y
         oUtcZB9/LKzU8SzcbfxiyHhjjH/Wl5HMxQq3bKoLavPukwEOdGzHV5Wrr4PnnibPkg9Z
         nFMDCRm9cZO2AZg7S3e8y6iDZpwsYk43Ss45qQeyAdYXcKI0DjVGqmIShe/D7+M3es1d
         fgzEM8i1UYck78oRWFUV/kU2vxowlIENMMiSD59pE1gkea/etHAU2kWG22YTLh/FcuP4
         eM5Q==
X-Gm-Message-State: AOJu0Yy6728v5wCPntkjxIzCMnVH8GaFDmlcfBE4E9Wz6xA+YZqd9tZv
	LTONgwHvVKha2Yvw99LhnhhMxjkeA9Z/
X-Google-Smtp-Source: AGHT+IEwszgKngWrGT2LYlc8oGsyNZz5xzGHAimZZGzB+faoW6ONRI5Z2M/PkJRrzWcLuXegybUe7Q==
X-Received: by 2002:a2e:8018:0:b0:2cc:b4c2:af64 with SMTP id j24-20020a2e8018000000b002ccb4c2af64mr368616ljg.80.1703296334133;
        Fri, 22 Dec 2023 17:52:14 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:13 -0800 (PST)
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
Subject: [PATCH v3 14/22] dyndbg: write debug logs to trace instance
Date: Sat, 23 Dec 2023 02:51:23 +0100
Message-ID: <20231223015131.2836090-15-lb@semihalf.com>
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

When trace is enabled (T flag is set) and trace destination
field value is in range [1..63] (value 0 is reserved for
writing debug logs to trace prdbg and devdbg events) then
debug logs will be written to trace instance whose name is
stored in buf[trace destination].name, e.g. when trace
destination value is 2 and buf[2].name is set to tbt then
debug logs will be written to <debugfs>/tracing/instances/tbt.

Before using trace instance as a destination for writing debug
logs it has to be explicitly opened with open command.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 99ab5756f0ed..c382ea5dea19 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1256,8 +1256,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
 __printf(3, 0)
-static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
-			 const char *fmt, va_list args)
+static void ddebug_trace_event(struct _ddebug *desc, const struct device *dev,
+			       const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -1288,6 +1288,18 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 	preempt_enable_notrace();
 }
 
+__printf(2, 0)
+static void ddebug_trace_instance(struct _ddebug *desc, const char *fmt,
+				  va_list *args)
+{
+	struct va_format vaf = { .fmt = fmt, .va = args};
+	struct trace_array *arr = trc_tbl.buf[get_trace_dst(desc)].arr;
+
+	WARN_ON_ONCE(!arr);
+
+	trace_array_printk(arr, 0, "%pV", &vaf);
+}
+
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
@@ -1300,7 +1312,12 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
+		if (!get_trace_dst(desc))
+			ddebug_trace_event(desc, NULL,
+					   fmt + strlen(KERN_DEBUG), args);
+		else
+			ddebug_trace_instance(desc, fmt + strlen(KERN_DEBUG),
+					      &args);
 		va_end(args);
 	}
 
@@ -1322,7 +1339,10 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(desc, dev, fmt, args);
+		if (!get_trace_dst(desc))
+			ddebug_trace_event(desc, dev, fmt, args);
+		else
+			ddebug_trace_instance(desc, fmt, &args);
 		va_end(args);
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


