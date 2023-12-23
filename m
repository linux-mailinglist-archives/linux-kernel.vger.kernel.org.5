Return-Path: <linux-kernel+bounces-10178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6581D10F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48BD1C22C59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D82557F;
	Sat, 23 Dec 2023 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="te9hvzEx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DA22079
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55361b7f38eso2842452a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296340; x=1703901140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGHiwp064I3yQf9nvM+/2/akIgp5q6La0/IkEVizm/E=;
        b=te9hvzExw8Pjh2eM9IxzOQwlmgxmVGV1lo6H4+y8tJvT3R5hQca1D+ns/0gPs4KXV4
         NZMihjtHbHMJposjyfitnZI0EBdo6G3kUuRLjeGHKeP9Ea9kk6BHv/vJ54u8iS1++dFa
         VSMOcysNpBhC0zhoW4d9PMKL6IWP5glpu66lMj87L6/Z7krmlHiEzOo/VJ8Ml89VqqAo
         yOgjj3zoFtJNLjiEZZ7FiYgDvkGVIaereyj6SPThGY0ToJz9rLXOWqo0q/CbrIGlZG1a
         jljggG7HVKLf/Ads0S1rz1DuAJZ7zkBxFuj/wuvlG7b/gL0D25qDQwwNeU32ugr1JUIE
         mruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296340; x=1703901140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGHiwp064I3yQf9nvM+/2/akIgp5q6La0/IkEVizm/E=;
        b=X6q4q883XAZDmDCacAqQMoeqLGqlcqrIInjYQ6vLxWrJJBvhHGyrRac4hNkxErPQOk
         fwOig8OmUPRzvfYsODATC6yMIFfjW2H+PFnbWbuijxt+J7/HKbsOOW0vjr43deIg7wPX
         3hqvIt9/p/b8vDeA1ablVaE52ttb6y1/UaqYSXwYfCEGi1PpKNDENhfJcVobtnkgBm7s
         loiXWQ2KfoZJrLc4oxDZ+ipxDOB1xe3D9/whf5gDC/A9sDYJKClxIzi847SDgJAVXtck
         DvJkKaAsYqLJ7FFiKw9zudBXUSRq6Ki1AdbLvK7A7bXynxNklvqH43r5bmDSthF9TY6v
         zaRg==
X-Gm-Message-State: AOJu0YxDbzGd0mYNBdIh+F3H+y62GZ0uuj/EHAenjZTvURAs6UsFHHT1
	CuujBqObVHK9fSpStuwUqTdfApYh68Rx
X-Google-Smtp-Source: AGHT+IGih3SfHLHWBG7q9WsxpnckXIa3GcoYPPXCshE+oN7o7knfi2bIg0na8wJ/LcKZalAQ30Smtw==
X-Received: by 2002:a50:ed11:0:b0:553:b473:6d70 with SMTP id j17-20020a50ed11000000b00553b4736d70mr709487eds.120.1703296340151;
        Fri, 22 Dec 2023 17:52:20 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:19 -0800 (PST)
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
Subject: [PATCH v3 18/22] dyndbg: treat comma as a token separator
Date: Sat, 23 Dec 2023 02:51:27 +0100
Message-ID: <20231223015131.2836090-19-lb@semihalf.com>
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

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

  drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the myriad ways a boot-line can be assembled and then passed
in/down/around shell based tools, if the >control parser treats commas
like spacees, this would allow side-stepping all sorts of quoting
hassles thru those layers.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4e50e4f6635..70d9440193a8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -637,6 +637,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
 			break;	/* token starts comment, skip rest of line */
+		if (*buf == ',') {
+			buf++;
+			continue;
+		}
 
 		/* find `end' of word, whitespace separated or quoted */
 		if (*buf == '"' || *buf == '\'') {
@@ -648,7 +652,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
-- 
2.43.0.472.g3155946c3a-goog


