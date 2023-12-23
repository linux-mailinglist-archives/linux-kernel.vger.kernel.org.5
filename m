Return-Path: <linux-kernel+bounces-10182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913A81D113
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB81C23E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8462C19E;
	Sat, 23 Dec 2023 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="EDm945XR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6728DAB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so2621170a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296346; x=1703901146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xohLWD0UNw7E4CxloMtBQln7aiOr7P7dbQQwHRMmxi8=;
        b=EDm945XRmNr/HPVgFV3Sj7sIYTtzGZI2mSOz1z05HoVgMF7Q+PWUQhghPc/FsjMiWq
         rZ39EEUApZE7aHBiLad1pMtw5HtGd1w0TB/hKznlYgdjjTX/Bou/Kdm5goPyIjOpqHrw
         OulcXELxcQJWyOF3oNij+I7brx9zBQhpCazmwsGprT8Ddk4LsLakscaLHi/6H1GSNFpO
         7vu/jD9jjNZyWhMLYM60p1iA1nVVdyNi/vS8/yX1BiFXhGKxewKarGph88REPHGgRGdq
         R5lY/0I7yN1FYshqxtXR/o6TTQty2SKJYZdCB6xItWtsqp1VbOTe6S1nLCqtZpJt71pl
         G0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296346; x=1703901146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xohLWD0UNw7E4CxloMtBQln7aiOr7P7dbQQwHRMmxi8=;
        b=PYnpn7e+4ah5rH7RPAiODn7G9VGEqwncGVBFHSlexSk2873/LUAttHHJgB4y7bo02T
         CX10mEGUXycwrCZbtp5Xjcat1kL3OdCzGSakQsuYCqKSHdQ8QptTrQaCJ+Sw5HkUxux5
         zhSXCZYkv5JsRyrtC0P1JqihB4xtAM0wQtnl6QhQaQtlILEjmJ7S+IWBeeYgyKmqfThY
         1ubnEmg6nOexNw6Uo81gbpgAfnYIkaZVbETuvNqSukBgX1Ry9+iN1frvRPxSAT06t97A
         qslxcOVo82fRfCTQsAVYMVnxzd/ltJ3MdI+8gwlrko3ldS9ezKMYfKKB/Hw7gUZQO+Kd
         qy+A==
X-Gm-Message-State: AOJu0YzdQeYZecBNbIfZ5BA24VGE9QguLSkVxU9DQfuvpd8f05abRfNq
	qjG2Y9paWDuwjHsVxrdzhf+fYS7VLa8E
X-Google-Smtp-Source: AGHT+IGkz5CY7aVnBAjHrrTg1kbanOBskxvKEgEFTr7oUGcTJEOjgyeomw7hUSVq36kINBUP2ZVIww==
X-Received: by 2002:a50:e719:0:b0:553:a3ec:3be1 with SMTP id a25-20020a50e719000000b00553a3ec3be1mr551571edn.163.1703296346266;
        Fri, 22 Dec 2023 17:52:26 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:26 -0800 (PST)
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
Subject: [PATCH v3 22/22] dyndbg: id the bad word in parse-flags err msg
Date: Sat, 23 Dec 2023 02:51:31 +0100
Message-ID: <20231223015131.2836090-23-lb@semihalf.com>
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

If ddebug_parse_flags() rejects user input, identify that input value
in the error message.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4718e8faa719..d834581c785b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -936,7 +936,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
-		pr_err("flags parse failed\n");
+		pr_err("flags parse failed on word-%d: %s\n", nwords-1, words[nwords-1]);
 		goto err;
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


