Return-Path: <linux-kernel+bounces-10167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B881D103
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5451F23316
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF61C8D2;
	Sat, 23 Dec 2023 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="hzwx6GSn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB28F75
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso2895309a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296320; x=1703901120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRKKsUePcasMLb/l6ExZubEPezutMAFeV/7I4bHXVe4=;
        b=hzwx6GSnDb3l3B2zAWlJRrBbfBMcO5oKZXyFvIvdUxX9VLkVcSOsxj9FcAIKYw0Lou
         IAthWTKTCh/R5l0jVGx2tw/90ey9XKsTrDKGYcBRyHx3cnFfggEh+VWVeNlZRKt1lN5Q
         tRYB1CtGKVroF8n3aZyrESx6mDa6HPIdtVO+cKjV7dTU5HrAEe1CStTdnLhYQKYsf2ps
         kIhZ6/0olbEnXWwEw1b5gFKVCELO+KLUwRKoJjSuQu0gbssIwkvqWUQGTBVTaKxq6Q92
         GAal0Dhgr1F9qYpEaSnmIl8MU0fAE4UWbC4Ds5lybS2KeevHz0Zq1O4piSetuO6hKpT8
         tSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296320; x=1703901120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRKKsUePcasMLb/l6ExZubEPezutMAFeV/7I4bHXVe4=;
        b=MIMCj6JLDGxypfFVva7R5eLQllvAvDGd8WPJ07QGIVjKJxrWaClpgUQchujlcHBVVy
         JwTJ4fBukwKAQ4ALXk6jus77Z36r/GSF34RP4boCskfojQ+o4SqskPv7awzJj/yPpwNZ
         H8wALgx/zs6eybrz46z9i9/enO8K7xTlH/XtHsX7OSiilJffWP6GMQdasKYosZ/uWFrK
         DxPaiePAosA/SCZ7Zsemw6B5H55mMF3jnkjCa3ePgN98MV22jfC5FfOBMb+4ep/p8r3T
         qNGiguQ6pF6wzO+36EQa8+1+iVATp0q6C/+DyG6ENzqV5BT5gFsq86a90pCTY5Kduhvx
         oCAg==
X-Gm-Message-State: AOJu0Yyw2rGWyFbqV+8Vhf/cs3QoxKOn0BUfBzgH+Y16R+inILGQAk4Z
	HaURD0Hw8vTID+56YX0HtgBAa/hj0TCVLC2QribZCxAQulKq
X-Google-Smtp-Source: AGHT+IEleLe52ad6kti9LjGw4HpH00R+soDwR2zAhzLrvXQGx9wCYbtPXNqRrtGEkfOFGXV3LqEWzQ==
X-Received: by 2002:a50:8e1d:0:b0:553:b4a4:5850 with SMTP id 29-20020a508e1d000000b00553b4a45850mr1046300edw.50.1703296320644;
        Fri, 22 Dec 2023 17:52:00 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:00 -0800 (PST)
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
Subject: [PATCH v3 07/22] dyndbg: repack _ddebug structure
Date: Sat, 23 Dec 2023 02:51:16 +0100
Message-ID: <20231223015131.2836090-8-lb@semihalf.com>
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

Move the JUMP_LABEL to the top of the struct, since they're both
align(8) and this closes a pahole (unfortunately trading for padding,
but still).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 497130816e9c..b9237e4ecd1b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -14,6 +14,12 @@
  * the special section is treated as an array of these.
  */
 struct _ddebug {
+#ifdef CONFIG_JUMP_LABEL
+	union {
+		struct static_key_true dd_key_true;
+		struct static_key_false dd_key_false;
+	} key;
+#endif
 	/*
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
@@ -53,12 +59,6 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef CONFIG_JUMP_LABEL
-	union {
-		struct static_key_true dd_key_true;
-		struct static_key_false dd_key_false;
-	} key;
-#endif
 } __attribute__((aligned(8)));
 
 enum class_map_type {
-- 
2.43.0.472.g3155946c3a-goog


