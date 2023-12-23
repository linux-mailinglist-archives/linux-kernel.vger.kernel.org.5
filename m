Return-Path: <linux-kernel+bounces-10162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFC81D0FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F758B23AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DCF1C15;
	Sat, 23 Dec 2023 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="d/dEiRp/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB6814
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5545ccc6a11so891849a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296312; x=1703901112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhZRdKG2SUpkpXn5O3JJ5iAzREJVy70U4FekMjB9iT0=;
        b=d/dEiRp/zVzViRLiMIKs2gy0IDa0j//de7igGhfkJ7hsbAUlgJni3blzNmx5fDMP/3
         Zg3c0jpyhhPEDgSqt1cPrYw4OL9H3r5T37NPILezjaTF81Opf41hWFGW7pzQMDCaL6uc
         gqogtcRDJSz+Bmj6sSpAA89dwgIVhxtkIDsX9Bk35KLBUOhc8t7u9bQe1otFLUx4pjEQ
         jwAl1LkN3lz2AEFOubZwiVHrbr7mPvJzmWp4n0OEiKpBzyXXyWeUAeOHyDZWBApTMpRR
         W0JOQ1QYwxFKRFEfeOkfJUWwxXqbtR9TkyVE7n3zMf9+8vXeWqGuATV2FU+HU5KLO7bs
         V29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296312; x=1703901112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhZRdKG2SUpkpXn5O3JJ5iAzREJVy70U4FekMjB9iT0=;
        b=xUz28xTn3xTPb/WFQslEMbPu/jWMVpQYUDsoM/nQ6CqeHUzBQ5WIgR5cI8MT0j4oB8
         1vBg7wk0xKHld0f5yqaMszTtYpCbLaNEFzQT26ap3xzBvoSq6gojHygNYCrV+Lck3s8c
         EZfLzh4IbCyi+3P+HkBMQZE7ydDo/dqrgKlL0hBlNBv0bhk6Yfzjzo0d/rn+jEg/Y4+X
         xCoojourUfABllCIxM7s9c9mQJYGIaaoorA2Vy2EySRitGnaBobTzemLfYaQmagrnwYu
         0tlHuQhKaDWbuLq/QNN3fx4kDqVdzFjrhB+gcul70woZfpmW5tvxzNkSBNBG7YEu3dT+
         yNCg==
X-Gm-Message-State: AOJu0YyNmcMuRCTGCtKv5MFAbQ3iOA+5xoIQ9048xLI0WoqYfl9XaxV3
	U6RlRux0LgVplYw5/9Qxkc2tr6BUYia9
X-Google-Smtp-Source: AGHT+IHJOb5zy2mq3xtQiIwhovQe2UhQXIu8/EZ0R2Fsd0jNa9RlWrwlmF77808j8H/hTBA1d8lPdg==
X-Received: by 2002:a50:c182:0:b0:552:5c49:b58 with SMTP id m2-20020a50c182000000b005525c490b58mr1097109edf.50.1703296312821;
        Fri, 22 Dec 2023 17:51:52 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:52 -0800 (PST)
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
Subject: [PATCH v3 02/22] dyndbg: add _DPRINTK_FLAGS_TRACE
Date: Sat, 23 Dec 2023 02:51:11 +0100
Message-ID: <20231223015131.2836090-3-lb@semihalf.com>
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

Add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7be791af7cf1..497130816e9c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -33,6 +33,9 @@ struct _ddebug {
 	 */
 #define _DPRINTK_FLAGS_NONE	0
 #define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_TRACE	(1 << 6)
+#define _DPRINTK_FLAGS_ENABLED	(_DPRINTK_FLAGS_PRINTK | _DPRINTK_FLAGS_TRACE)
+
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +47,6 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
-
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
-- 
2.43.0.472.g3155946c3a-goog


