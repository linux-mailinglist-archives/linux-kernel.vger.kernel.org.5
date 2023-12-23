Return-Path: <linux-kernel+bounces-10177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0B81D10E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D97285D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A122F1D;
	Sat, 23 Dec 2023 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="RKse9g0w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23127171BE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-553a65b6ad4so2936001a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296338; x=1703901138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r3U79Qxj2jisK+rG3PDZznLSnbCkTYF/t8XERCjqLs=;
        b=RKse9g0wJNNVq91nhwm1yVh1KYuDT1YK3N+kVUb4H3W3bn/t0BnV96S3VnRJfIg6VF
         lHB0wo44x251GEGjw47cLot0theLXMgTcO2ZBd3VNSWkoTBMgPoAwod7S2EjMMWM8hjB
         5rz2IGufiwtM8sAPzMEUxD2SRMAU95VjquvkR2m4pWJl6f6095fIAk2I024LFbogN6NY
         x9qS235MRvY5YFwYmrC3+dMzUxrl4qvqcY6tswdV0Xr1e8QdBCCTIMr5hOthQEzEYkkF
         U6ph7IzHw2ZHXIdb1qMamKyDem/eHXbj2LoHGE3cFlreRdZg/3OAgYIV6Eln5DIxyk1t
         4MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296338; x=1703901138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r3U79Qxj2jisK+rG3PDZznLSnbCkTYF/t8XERCjqLs=;
        b=CVD3gflz/GaD6WLPnn7+rlIYN982bXn4A9RxZt04wI7F7t4PcOQn4tDWld4rQOhI4C
         cnlw23NyUkY5/RwQUjYIk6Rm1IWwlip963zmGNb+C/c+VGrSshhqaJTf7v00nhjgzptD
         /6g9kgY4gkgF2xCR74XUR7A9YHv84uG7yLG7gjqDcwX1f/bHS9WCC35WmiGTLvfloQzf
         ltShxJxEbGvzbScDVAX+LsVZSOqMBH59D8+cIFE+K4A9bmoBPi2aBrXYlofFgtp0Q0/5
         AuWv2VdoWpzQgtONXEjTWuZFLCd221Mnxa+WlPY1prt03Xoze1VdRHLWzc3twiGcKxFZ
         QTZA==
X-Gm-Message-State: AOJu0YxgpBN1qKftH3EVycJ9ZS5YeFkJzk9bqiZAj34PsXBpJDKTcAk+
	LiGbOeu3rhdgrBbPLK2dxihi5gIu+4Gc
X-Google-Smtp-Source: AGHT+IGJvtR9jJPpiHTnki/N4UvZMs/ZA/R0N7HYYjUHElafUXvwZb63+edtlUmS0QC5whlGhv3tEg==
X-Received: by 2002:a50:9f0f:0:b0:553:ee28:b97d with SMTP id b15-20020a509f0f000000b00553ee28b97dmr1537599edf.39.1703296338568;
        Fri, 22 Dec 2023 17:52:18 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:18 -0800 (PST)
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
Subject: [PATCH v3 17/22] dyndbg: fix old BUG_ON in >control parser
Date: Sat, 23 Dec 2023 02:51:26 +0100
Message-ID: <20231223015131.2836090-18-lb@semihalf.com>
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

Fix a BUG_ON from 2009.  I have hit it while fuzzing >control on some
other patches, and panic from user input is bad.  Replace the BUG_ON
with pr_error and return -EINVAL.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8ce485fc84ff..d4e50e4f6635 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -650,7 +650,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("parse err after word:%d=%s\n", nwords,
+				       nwords ? words[nwords - 1] : "<none>");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
-- 
2.43.0.472.g3155946c3a-goog


