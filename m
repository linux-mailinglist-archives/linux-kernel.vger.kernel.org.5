Return-Path: <linux-kernel+bounces-10179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C181D110
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5241F2458B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8FF26AF6;
	Sat, 23 Dec 2023 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="k6xWt0PL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0232421E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5548a911cf9so90851a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296341; x=1703901141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrCo62998dd2zdm2uwyLE8Dvl1Erd3p03bl4+A1t0OY=;
        b=k6xWt0PLaHXRU4zLbVtpgzgCxsmABbV8OQzY3Ab7jVrbrscAyTjT1tfRa9b2a5oXfv
         jnNnNDo6pqaRyJho1abpDzdCbwbH9YXMNbs1CdLDQNoR1LRWqYrQeWUWCWvvAOMo+ONl
         cjKNhLDjWKDixD8kAFupL9YrRmvv+3ZCi/LBHvMbItPS3ln+K6IziwCQV7Cqt3VsJqQn
         MrqFiI+4Qw0CnD1QDdd6EIsYIR+FHveFD5HHGjtia6bHJtHRPML9EyX1w5v3+xuE71iX
         QDFXuKKEACwwWwOn25hTflkzPV+jUURKltjhuzC3e9CyeW8Y7FdGqsiUdB7WV6gx3u83
         OXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296341; x=1703901141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrCo62998dd2zdm2uwyLE8Dvl1Erd3p03bl4+A1t0OY=;
        b=FE7ihXL+k8fMfcSYHFD2PvKRt2KkSJgMF1LskxFaUobdiKpZXgtruoqJwkn83ap9OV
         01rBW/83gCS52nkBayK3EJUtnbB/DHEz5hSttNBg54e3cZehBqNsxzCX8a3WLhr5KO3J
         A9yUr2pOA1RfZe/vVtIsePdvywJmBWPv3vT6GbyAscIQ1daxn80kmwDMqG7DFrc3OrI2
         V0b/NK0lBwqQRsyl+b5ID97Q2IYIjWCM3MJiOQghNy7nLJ3K9hlMKGx9m1MU7KlrMmat
         CwzqLQtmjAwY5KU2CgcMIRiT8zJcZIIfvJNlnCnaDcwwsP08MXZN/steymrfd4Ymnaqm
         DHbA==
X-Gm-Message-State: AOJu0Yx/JYXIP3u9mzWQbyIFuDCpJhvFGcvHdYHPLgguE4hf5MLztjim
	Nzd8SL5wkqxmnPXfWb2lCW80VwMPTK4a
X-Google-Smtp-Source: AGHT+IFGtMBjB6KNG9UAqYAeNaPd5BrmsGBJMrkvaFpkHVfL5KANCS6bPWpkOQVObTchBM6ti/4wxA==
X-Received: by 2002:aa7:d751:0:b0:553:178:9d5a with SMTP id a17-20020aa7d751000000b0055301789d5amr567885eds.130.1703296341606;
        Fri, 22 Dec 2023 17:52:21 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:21 -0800 (PST)
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
Subject: [PATCH v3 19/22] dyndbg: add skip_spaces_and_coma()
Date: Sat, 23 Dec 2023 02:51:28 +0100
Message-ID: <20231223015131.2836090-20-lb@semihalf.com>
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

From: Jim Cromie <jim.cromie@gmail.com>

The function skip_spaces_and_coma removes leading
spaces and coma. With this approach a user can
provide dynamic debug control commands in new format.
For example the following command (existing format)

modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

can also be provided as (new format):

modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 70d9440193a8..48ce24c39457 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -618,6 +618,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+char *skip_spaces_and_coma(const char *str)
+{
+	str = skip_spaces(str);
+	if (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -631,8 +639,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and coma */
+		buf = skip_spaces_and_coma(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -959,7 +967,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_coma(query);
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.43.0.472.g3155946c3a-goog


