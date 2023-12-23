Return-Path: <linux-kernel+bounces-10180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F398981D111
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3901F24FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB028688;
	Sat, 23 Dec 2023 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="uUz84Kqp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9A26AD2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5542ac8b982so2217834a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296343; x=1703901143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjBb7btKJ5cDmDK0xMvEJpKljQMf3aQ5ihb+cugdsR0=;
        b=uUz84KqpQZpD3ynrwdSyysa7U9xdq99VCXqH0o+HAmoowd9p/PMDOBuFiEd/3ToR9w
         xEafMjPLGEdM/s7sRD9GWc3n0ogshKX02RGHyXRpZVOfhpgU1zaeIIDxPs+ADI+SgCZH
         lIlOZX+FJDqU/DzXKqiNLgLO3qYmCyy+QecARAPHaXHPKyYC/LPir6D0X7wmVS4OpoOc
         1vUxq5sWeXBF96x+LXX/7LoSk0UrSL2vqRAdhHhtqCNODZkHfCkQEBnE/TvIbiqNLYIz
         KFYu9oCujW1+kvNqYvMcN8qV2Y7UVOOc5/xTVVxkfiqhFRq7ajgSCoS1NharArX6bJCD
         47Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296343; x=1703901143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjBb7btKJ5cDmDK0xMvEJpKljQMf3aQ5ihb+cugdsR0=;
        b=A5gD4LWnz0aqCSfx3zcXsbtQfhd3GVEDF2dG/eVBlPtPtX24W0XebMjKnm9ACFHC2e
         CcvCuxmc9RkbKydVXfqQ8R0eYuYR7QKAYQOwaCFyJKBGsNosW8L3Nu1F58faJUvZP4Ab
         UP8RGmDkBz2X6pRtfUsnu9joDaUZe8n9lfwWcEKwegt8X6NgZW61dic8YIQ4sl52sVNw
         N9u7UC+iavxB1SGl1UWgcM+zItbkz+qJROuKzw2lMtSrrBi0Oo8jlyaONfWJZ8kCEiTh
         fOq92mj2ow6fPmoDlUCjQUfgUjAm0RyGa9NG8u29qcOb3pD8m2EOQIL8hHOcYJcvq+Zu
         3bwQ==
X-Gm-Message-State: AOJu0YzZ0gafWXU6dZGjvXlHFcnVbSrKGicSODgPFWfe916jKf6hiiTH
	Ml7j6mg2GSWTaiLFjC+y/wYkKpTzyFfc
X-Google-Smtp-Source: AGHT+IGZjxUk65ZXw0pkx+Owpp6yTrhNuEcgFhoBSdzNY7Psstb5Qd6ZBHeB3fdeqMLvUo3H58ziXQ==
X-Received: by 2002:a50:9b14:0:b0:553:8227:178c with SMTP id o20-20020a509b14000000b005538227178cmr1178108edi.68.1703296343184;
        Fri, 22 Dec 2023 17:52:23 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:22 -0800 (PST)
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
Subject: [PATCH v3 20/22] dyndbg: split multi-query strings with %
Date: Sat, 23 Dec 2023 02:51:29 +0100
Message-ID: <20231223015131.2836090-21-lb@semihalf.com>
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

Multi-query strings have long allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +pmf
     class DRM_UT_KMS  +pmf
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

But that leaves unfinished business; that semi-colon needs escaping,
and thats not robust to further string interpolation.  In particular,
it fails when passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-cmd
separators, which is more shell-friendly, and avoids quoting and
escaping hassles.

  modprobe drm dyndbg=class,DRM_UT_CORE,+p%class,DRM_UT_KMS,+p

NOTE: it does alter/break this (ill conceived) search:

[root@v6 lx]# ddcmd format %s +p
[   38.170998] dyndbg: read 13 bytes from userspace
[   38.171542] dyndbg: query 0: <format > on module: <*>
[   38.172011] dyndbg: bad flag-op f, at start of format
[   38.172487] dyndbg: flags parse failed
[   38.172839] dyndbg: query 1: <s +p> on module: <*>
[   38.173285] dyndbg: expecting pairs of match-spec <value>
[   38.173791] dyndbg: query parse failed
[   38.174141] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

In trade for that minor format selection limitation, we get to do:

  vng -v --user root -p 4 \
      -a dynamic_debug.verbose=3 \
      -a drm.debug=0x15 \
      -a i915.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfml
  modprobe drm
  modprobe i915

NOTES/TLDR:

In this example, using both drm.debug & drm.dyndbg is mostly for
testing.  Using drm.debug is preferred, because the drivers all
explicitly depend on that input/control-point, so settings there are
propagated to drivers.

But more to the point, drm.dyndbg explicitly limits the query to drm.
In fact, you could pass a module wildcard in the above, and achieve
the same thing:

vng -v --user root -p 4 \
-a dynamic_debug.verbose=3 \
-a \*.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfm%class, \
DRM_UT_ATOMIC,+pf

':' would be a more natural multi-cmd separator, but is reserved
for +T:<trace_buf> to designate separate tracebuf instances.

If '%' is distasteful, the backup plan is ",_,", since that would
never appear in a useful <format "$foo"> cmd.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 48ce24c39457..453eab7092dc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -963,7 +963,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.43.0.472.g3155946c3a-goog


