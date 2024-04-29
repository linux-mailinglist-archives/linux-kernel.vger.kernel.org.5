Return-Path: <linux-kernel+bounces-162927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265288B6253
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB09A1F24A43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68213BC04;
	Mon, 29 Apr 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR+oJp5r"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082C1411D8;
	Mon, 29 Apr 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419153; cv=none; b=Gv7vobpCCy1dJiTd1UguGW8hkpEG+CPZpxSIdXGFAu2H/bZpV84swEQQ+fQ1VoEjIcfj6bz1+0s3xzyaogqVrsuHVRFQ6FqVETUnhtYzZRlEUIJlJlYHEI2rBxRTlJEGbeqaXNu8Dr1vj9zyewBAI0dgqDvbOwvh8bnxEE7aXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419153; c=relaxed/simple;
	bh=hKl7HYOVEP5k7rjGGdRLGhHU97ZsFiMtiOSqbNlt/98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqvb/QMl3oGZOV13ZijLiZkgqKDE6QxWNAeCauwWtdl4bLZkClUFTUB6mZbCt6ezA+mnApJgyaQ3N5TvV1Ha/I54ccQwvUr+aQKT6pmdVLkPHUhW3HFx+6ImUSovzu8mWUVZ7Upvkqu4K1lCSXn7adNdrGKMz6HACKjfcHn6wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR+oJp5r; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7dec7c2a03eso68253339f.0;
        Mon, 29 Apr 2024 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419150; x=1715023950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXXERrklrfJcROQ6dIgi+SzS2bHgMiKq5Ff005OeSvE=;
        b=BR+oJp5riAZ144BgImLM9slMLJR95alIPzWyfUf8Z0vphPSlxpPk6d5PJVKAHJbtaP
         QW+plYmvwCfwWtbeTYJaHeBZ0qiZvsFwigATHB7U4OxGKfW/HnTqn7I2rSMlLvuCy9Kd
         Lh/2tbZLnpwqZWGmPhNJOcgUvhmI7PoI8tvrx9aCwOYyhWBXSLmXoRZ5yPcC3KdrCrZf
         /7QcbkDujSI834ifaX7YeC6vfSUrJZBpx6G4WhUwI6lKThVSQsn5LYPrYNJKZZFZwU3V
         jIhT5eZk3e4vROi/PXV0k+lOvC6P+r+l821J67Squfuh1mYrEl69BI0S2naS0uLjod8H
         p2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419150; x=1715023950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXXERrklrfJcROQ6dIgi+SzS2bHgMiKq5Ff005OeSvE=;
        b=BbQ5fLipvns42HhFN0Cad5ZD52d0fctXG6x5y5NExJmiTV++kI0bpskSdCkRF9mITm
         nMkHty7lDDQSIxVbljwzG8Rt4sv/TEUrEkod7eV0Q5m6RdUtaQ1ozLgtC7hPFOXrmhPB
         CtIuoWeElXXKkIBOLMNF10Pn+tAM1zvgpK9fvRQSdeaQSrxp6N5rWFhcwPrxPhJ0rr2Z
         6mzA8vOLi6P/vatAzJjpTacuuzU/YrT4pLNHK+bbNGy2ExuxUTKYyserFAXk+P64J1vl
         jO6zbYAejY7Ass1X7im4V4FqrrV8ix+jzJTv42UlmWpmwObId3C96OWFzJK04zoe6sY5
         oKSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdf0lCFbBBrA0eEy897vohRpyk8v4rO2kAh3BHsyudz5CUfiFZldqgCaxy78xC3yZFtH2oaJRzUSIhgEpNtPHkUZwLic5CwqjGt4LHXtBy2uIz6J1WNqYuWZoCk7e3BEaFSpsCF9+p
X-Gm-Message-State: AOJu0Yzk8N9thgooLZI7nOS0oMrM0OWHerkuKcsBUoQP0YrD6iA9wIX7
	CiFZ/CjTZuhH4ZlpX7SjNARPxYoJSB9jafkFxT70sy6ae3b4NiNX
X-Google-Smtp-Source: AGHT+IEA1RgM1171jNEZzZ8EdkMx4dSU1qGMrXboTTfU8qqeGHZPWqN8fwMqt58/jAs8Wz1Fb0qj/w==
X-Received: by 2002:a5e:a803:0:b0:7de:90ad:cdba with SMTP id c3-20020a5ea803000000b007de90adcdbamr827584ioa.15.1714419150099;
        Mon, 29 Apr 2024 12:32:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:29 -0700 (PDT)
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
Subject: [PATCH v8 14/35] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date: Mon, 29 Apr 2024 13:31:24 -0600
Message-ID: <20240429193145.66543-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4a0ae31d059..43a8e04b8599 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1245,11 +1245,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.44.0


