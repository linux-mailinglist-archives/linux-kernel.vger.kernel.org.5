Return-Path: <linux-kernel+bounces-162922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A898B6249
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9847F1C2148A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144F13D2B3;
	Mon, 29 Apr 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRHSnL8o"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390A13D257;
	Mon, 29 Apr 2024 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419146; cv=none; b=TOFEm1BB8nLYNj1j+IXLzT7AA4HdbFodS4CwWQyEBUvS5jauue5HsoYzu/I2Qns4mwslTMvGrGKNaRg/MlCKAQ8blkFJ0q6URoQJSF7is8ipSi98DnbGD6/H8zFGf2EtDdVfb6qdQZE5NLojuUZimUbqhG/wshsm8n6IrPYtMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419146; c=relaxed/simple;
	bh=92vmM6FDBYH7yBJcL+jXP0E/TCy4m+jHgv/qEKdzyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0hwd0L+T9JKZEbid0GtVx1ClMqK93OelD0E/W5mfMWzBglqrsSnLfhdwH7RP34P0qnM+JqhDR9+Wx0kfKadFcufMgJB/lV1XvwScGNVh9zUYhlLo8bapNNsWYH7J3F9gmz0ygZbA+0DCiHprn6ucm1oSNKqsTX2CzQWT7YJRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRHSnL8o; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da09662332so160165839f.0;
        Mon, 29 Apr 2024 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419143; x=1715023943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q95ZqInWMJScwhR6tUig8g54EU3c/DeR371Oq/AShg=;
        b=nRHSnL8oDZzaCtwRBRBPVbwyyGR8CublknmWriN/MQ/vUlu2sZNmazw6tuBNdSFgN7
         NmZIx22FpJsJqoZMZK1wl2OpWHkeBRtZWqnkN8sr1Vr3oF3ywlf5I6LgnypmqUsRGFwB
         Sp6bq8bIzR+GXeKjHtS7nK4Iu2WoX2H9hwwKl13qOS1XdIKZp8LFvPdKQYY5kgftM6YA
         Ggj63XRPbDoV0CLQtGzeBDd+T9P3j6g0cXIlphhLOUA7Z8Ne0zstoJ3BJPU39VsQU/r1
         QVdRwuG5epiBgHb0zfslRMXRqbyBOyY2q0xU/5ArJe/hRiy2K177e7cG1YLVB1JDtzSc
         QtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419143; x=1715023943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q95ZqInWMJScwhR6tUig8g54EU3c/DeR371Oq/AShg=;
        b=czOWqYyuXN008fo2f3r2dUbyUBcBJpdavVC2ejfZMlj2DnlXnnKsjwrHq3bUPD/9tB
         Sz71huRDG5hTO2PXSHiU+FRhD7LmigttLrC9UYV1ASQKYXXAP5ehgSYWUrodCCGgL/kC
         jTXsgAqHkjylw5o9KpoDBtIRYCLa9TPJ1RcqsVpohVeWfoeSh2LzAKFMJS+MIMxPEvi6
         S//+rH3C7RsWn6xDr3rbPOb+wjiPeLrDNGM56/9pRwjZxM0TKpmQ4qoDnoelxaa5Z7Qp
         0bsh5C7F8lCi1O3dH2+yExO0pslQKfaS6bkfHYTeYmk9geyBX7+Q5wwv0aMtC59yvGXy
         0xew==
X-Forwarded-Encrypted: i=1; AJvYcCVGSAAvhUCXj7sGhG68SJHiBSPDdnpD1R7FIPOuBnYJ2xuhxouY2IqytIRUj2Wo3iMjj69j0gqGMaUJb1ZgDzJaCkatbXEYrYJXSkukuVxFvoR5VLnRkcZYYnthKy+dp4sdjK3GKRUB
X-Gm-Message-State: AOJu0YzHgHmNzn+AmuCKrCp157NhMR13JtxiLrXc8yHext2icfIl3k4n
	vUlHvyT+Ru+kvCUEdoS33hJmXetLWLcua80InScJ3wEeRQCM1YZJ
X-Google-Smtp-Source: AGHT+IEwf2ZOietSarGxhgNapmV9HHXQqyjB2l54hQBuI85VhrBNeK1Sv3TWDlSimrU15tCjgcdXXw==
X-Received: by 2002:a05:6602:1d54:b0:7de:7b1:2e60 with SMTP id hi20-20020a0566021d5400b007de07b12e60mr579359iob.6.1714419143108;
        Mon, 29 Apr 2024 12:32:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:22 -0700 (PDT)
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
Subject: [PATCH v8 09/35] dyndbg: drop NUM_TYPE_ARRAY
Date: Mon, 29 Apr 2024 13:31:19 -0600
Message-ID: <20240429193145.66543-10-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b53217e4b711..8116d0a0d33a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.44.0


