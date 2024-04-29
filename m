Return-Path: <linux-kernel+bounces-162944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DB8B6294
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF112847E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7C13C699;
	Mon, 29 Apr 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4xKcmFH"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39113C3C9;
	Mon, 29 Apr 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419573; cv=none; b=I8Bj0UrCB2qWZryv5qDVXXhlwvCUmWB5dqkzr8CAgKfN9zl8OWPZFgxidkB1R5GWYAQeb2PqmHx/c43jf9R2EWlAJdznNJCUCTTyrgB53z+hz3LGDgdsTJetCT4/M87vFLYr8OvjqcbjqOkeAzkT9MSRjVBfAHv2i/GIuqHY5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419573; c=relaxed/simple;
	bh=Zz98BXo6lbuvyhCQUEGZtTRcSFE48GbPSYaZ0jQWueg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LW5Ym4/yWdJY88KzaYi4yNrwbD6QvI0mkrrkl2GkbS5QtZEpeVRKzlqf9JvjpWP4kmAhw5sFg3e50CyiorWlL/7n1qgC0JAJcfl2cG4y7vdvfbmtOz1eaJc89BZG4hEGW3jte11Dyk7AXv8fW1eMw+/6/Cb/MOxBTx23x4AEkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4xKcmFH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7da04b08b82so130418539f.0;
        Mon, 29 Apr 2024 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419571; x=1715024371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LYQlvE+T8WA65CtT3d9bMBQ65wsAHik/vFXXFGgqX8=;
        b=W4xKcmFHNY+uPVV67n+Or3cN8wEnNlFWBP5bDwF0nKljHOjQ/n3iCA6eHCd3HUxqgP
         HFBXamVVsCnEXXPXxQ4m8cdr8LWGpHO/89GOwYXTDCWAl9zwLnHyfQVMAVPg6wA2xP4I
         R083BOB1vMrsvtbOMhSYV59Sxo9ynHgEN3cVO4UyamympWnlu7fy5zdx371IiQm9lSpv
         UgE4niqHccuqQDGPpvzEihatZVGUOFDRPkr3nYfZ2kE6GegztEcOWc1a+TEpALH1wwNV
         BMkgeVWuwdzWchKE8tt2kLj+iHC7Ix7vgUWZgTY7G5kbQU29yIgXUoYEvw7AWmCIHA9Y
         BtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419571; x=1715024371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LYQlvE+T8WA65CtT3d9bMBQ65wsAHik/vFXXFGgqX8=;
        b=oO+rPWLW7kC+oTdR+B2df1uuMNow7yl4RUUPjSct8DOolQHQSQ99NzaiIEcqotDTuQ
         HcNgmyUBeY269Q7xPP7THw7KhQY9tqubILO43wivXWQ/08S3TMhDYy3MEAQZ9lOS5UpM
         aGxT+6InIUtRkTU53defzWHU9Kf8xb6moz6BLaqTtyHbp07Uc4VwdLM0FOYMouhkrRZU
         XxuvJHvGBdWjJZSE39xXruZ56NOZyaSlPimC87U1yxeNDrN7Dd0CwjwPHMyKqSaQVrTU
         Q5qIdV+AYrA5p6SDyS0zFf+bbxmiK+fB9P7UeZgxdH1Bqi+Jbj68v4R54aUqa5G/ZjBW
         CjKA==
X-Forwarded-Encrypted: i=1; AJvYcCU14dV+BVx7ehlSG6qA0P7pR5F9lnSxa9pByzVm5RKmTxTab6R5xjDhLQ8r8gOGSoEXWTSFEtXlsR4FdHJ06n+TtMmzKaVoWKJDxVPPcW4nFhUVZqQ+vcf3/Zyq9eO8tFcdlfLAhMBD
X-Gm-Message-State: AOJu0YyqyO7Q2RlbYKyvgWug4nUU39O6fTbOH2Wf5/dgOsijuUEDYeSl
	IlYk29/03ir6L4MrorKMRLXaeqUxc2dmelW/M+0ZHQM55DL6JGmq7sJzkfog
X-Google-Smtp-Source: AGHT+IF6th92SlL7HDkoTDaUnOqtPhi3umBEhatRUoNm9PW/+KDNrLLSMW7oFL47yK2VDF4hmnRS1w==
X-Received: by 2002:a05:6602:1c92:b0:7d7:56a:1d75 with SMTP id hf18-20020a0566021c9200b007d7056a1d75mr14087995iob.10.1714419571016;
        Mon, 29 Apr 2024 12:39:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 23/35] dyndbg: split multi-query strings with %
Date: Mon, 29 Apr 2024 13:39:09 -0600
Message-ID: <20240429193921.66648-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-query strings have long allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That worked, but it left unfinished business; the semicolon in the
example above is a shell special-char (one of the bash control
operators), so it is brittle when passed in/down/around scripts.  In
particular, it fails when passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-cmd
separators, which is more shell-friendly, and also avoids quoting and
escaping hassles.

NOTE: it does break format matching on '%' patterns:

bash-5.2# ddcmd 'format "find-me: %foo" +p'
[  203.900581] dyndbg: read 26 bytes from userspace
[  203.900883] dyndbg: query 0: "format "find-me: " mod:*
[  203.901118] dyndbg: unclosed quote: find-me:
[  203.901355] dyndbg: tokenize failed
[  203.901529] dyndbg: query 1: "foo" +p" mod:*
[  203.901957] dyndbg: split into words: "foo"" "+p"
[  203.902243] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[  203.902458] dyndbg: expecting pairs of match-spec <value>
[  203.902703] dyndbg: query parse failed
[  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

The '%' splits the input into 2 queries, and both fail.  Given the
limited utility of matching against the working parts of a format
string "foo: %d bar %s", nothing is actually lost here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c1bc728cb050..625838bd74aa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -596,7 +596,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.44.0


