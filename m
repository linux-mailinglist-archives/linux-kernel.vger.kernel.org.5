Return-Path: <linux-kernel+bounces-11603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98D81E8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6511F21757
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B852F9F;
	Tue, 26 Dec 2023 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f73C2U3/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C51C32
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbdb46770d7so5562076276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703613652; x=1704218452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQnopqwXCPJwf1o31D0QkbeUw9iOW+EHq9+aREsG9fw=;
        b=f73C2U3/jNohZsnmPU/1qJJSEHwpxbCFXOoE9tPRapD5CwVVDo0yHg+mM79FLkOWNI
         4mR58BHVjKgFv1TKAYARakV188mPY/1ccQJb3TdP4PIAJKozZJJ80uVli1e18KP5rN68
         ty6wSj731PBpSLR9EGyZQ1AkjqVHqanNjMHwo5V/cZTkBH8uQA89d0R+reqchBdfSkbT
         nAV0K9PuFsyioln/BtGO6nWGOJvDXIFYXMq5rUad4es2lHZNN4TE/ATbzI06u7RQ+Obp
         Ivf6V4fh8lC5n/vtF3qkpam/aESr4vLiaEho8QfFu5ZtekC/EG6/zEsBUYS5F0DohQy7
         TdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703613652; x=1704218452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQnopqwXCPJwf1o31D0QkbeUw9iOW+EHq9+aREsG9fw=;
        b=c6/8qdKFjfSBlx5R2Z6QItj6PlqYkyNutEt3Y6dDljU86B8m/i0NLdkPMarcwzSfV4
         Bc/Brt7uUc1P9JGpGzyiLiN+uaSU6Z9tU2k+QNTVpp0CVGDWg2sCGDc67GtiR0sP1F3U
         iMLOC9d55RO0Hj8vhwL7xYVZM+DGnW1DsY4DHaga2yt6WOVJbgNuyxg/rjIbbz2L72id
         mdplGjBWjgq5gVjDDdFa0hDuOeoNwWMgbZoJgTQz9HZwO8h1YbzAMi2UVGwBAfI8DYmE
         fTOe2Ex64kUQBT/qdDTHZ5/ltjFJABebzYmDQUr39ihjAfzksKB53glRXOdHl266m7Id
         cjaQ==
X-Gm-Message-State: AOJu0YwmJxwpMX/6IkHuEHKfHgJt0xClq3jr1vMTjBM6mrD/fFzsPZTu
	Y6h0Iw2ezHl6bqls+OalJOkmTj45On2OFQXcs0c=
X-Google-Smtp-Source: AGHT+IFnQX1XkxS5gH/MspqNzbGruimeDM9Y6sSzYazzjx6BG39h+lL/hwfcAIIYMQak4etQSIZs9fP7PwkI
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:1369:b0:db5:4692:3ab7 with SMTP
 id bt9-20020a056902136900b00db546923ab7mr2904081ybb.8.1703613652544; Tue, 26
 Dec 2023 10:00:52 -0800 (PST)
Date: Tue, 26 Dec 2023 18:00:01 +0000
In-Reply-To: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703613647; l=1528;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=kLkju4pFci+nx2b0Vi+mSe3j1L2n+dGn+lmNlbPb2hw=; b=mnCi82pkDQhlhIICzaZ9DKF5LW8Zyzd5r/uBAp0bJK6KM0spwTVgAqlizK/vym/fbXNq9suqF
 X+rsoO7J6/2AhGVmTzCIFtKYKnxLFv7kczzhqPaEYO9mne7MtTmJCDp
X-Mailer: b4 0.12.4
Message-ID: <20231226-libstringheader-v6-2-80aa08c7652c@google.com>
Subject: [PATCH v6 2/2] lib/string: shrink lib/string.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list, changing indirect includes to direct includes. IWYU is
implemented using the IWYUScripts github repository which is a tool that
is currently undergoing development. These changes seek to improve build
times.

This change to lib/string.c resulted in a preprocessed size of
lib/string.i from 26371 lines to 5321 lines (-80%) for the x86
defconfig.

Link: https://github.com/ClangBuiltLinux/IWYUScripts
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 lib/string.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index be26623953d2..06d9b46875ef 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -15,19 +15,20 @@
  */
 
 #define __NO_FORTIFY
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
+#include <linux/bits.h>
 #include <linux/bug.h>
+#include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/linkage.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
+#include <asm/page.h>
+#include <asm/rwonce.h>
 #include <asm/unaligned.h>
-#include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
-#include <asm/page.h>
 
 #ifndef __HAVE_ARCH_STRNCASECMP
 /**

-- 
2.43.0.472.g3155946c3a-goog


