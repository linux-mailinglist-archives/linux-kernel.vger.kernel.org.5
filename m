Return-Path: <linux-kernel+bounces-5787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49799818F79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F2F284EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F43985F;
	Tue, 19 Dec 2023 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azNZ5Vre"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E44B5D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-daee86e2d70so4143184276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703009412; x=1703614212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvAoLESA2zdRbLlcTYxafJURAb6UEYn+4xsK4NwMYJA=;
        b=azNZ5Vre4BZftuHTG8bhLIcMaBSRspFrD04piV9WBPy9SsdVALBz8GCdsKctkSav26
         8kFPn9uwVeSSALmVrd0+yw962rUK8AuHb1KdSoUKVLtsIgFCVnFyGW5eL228qOiyF/mb
         uS/H03em2kKp7lrQXTEo/rWa0m5LY6XVMcvwPMyRWMRUP/VnyZ6SOJfNFDDzoOIJ9xak
         5/OKEsN5HnPrNLkuf8kgJ/hE9BkJ6Ra8Q1cyVQGZo4e/y3aALXF9/EHJ81UlA49IxxBF
         ppAPV7BBEV+tlyhyOqjpXoccdXMkSEt/LkMaZrNOrovr/AyaWRArKCdNCXlW+jv0ieE4
         rVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009412; x=1703614212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvAoLESA2zdRbLlcTYxafJURAb6UEYn+4xsK4NwMYJA=;
        b=u4S/NpWDQxrGp6/FXOGW7chDWqgGO1+SnMTeHqNDgf6SlxgaAecsZIGjkqdCLU0NDV
         W9ORGvoSlBvwTJXZPn+u8nHB4XJkFlI43byQl7PrMWX+OoNXGLzE4FJtZMNPiIHuLJfj
         MmzIIufDxE4aEx18TuHBaKCKbCce8HQPhcSU6X7hJMVdxW8PgI4+TfrMMoe7+zCSFNnG
         2+/qPXyWhgbmdt25fvjelo4xrJJwEEuFlncAxFYmvQTADxhXB92Il7SVbJ2QiRl8Zg14
         +6+hILZI/ZbpBUvZk/svFvYPd9UHPmVtvsEpgPQky5pTS+qoe6anEjoVWkrds9Gj82sP
         XFog==
X-Gm-Message-State: AOJu0YzUUd6UeRfcho+cA8K6QJbpz4wbubRI4qsVESrNAyU4/viQOmzc
	ykBobbehxhuHT13OTmP00PK0unPvDiuc
X-Google-Smtp-Source: AGHT+IE4zRTTvZ21Iv4W2ugE3ZyUtrJKn38heipAOnYsOO9ir0lTwnm6D8XTaTiHvUN0O8ZdMrb4sLpansaP
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:513:0:b0:dbc:c59e:fa7b with SMTP id
 19-20020a250513000000b00dbcc59efa7bmr257444ybf.7.1703009412216; Tue, 19 Dec
 2023 10:10:12 -0800 (PST)
Date: Tue, 19 Dec 2023 18:09:52 +0000
In-Reply-To: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703009406; l=1526;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=oJuDSXDF1SrZGjfYBC3bPo4h0yX2ibdKNK734XPYdhU=; b=BHcmOkZ4yRvMLJW6bIsrL9gXUQbeDMqFADLOIVUAPbJZ+Q+iXQ9nyodfoMCal8KsmwmlkCPfd
 puHiZ3ttK+pDGrk65vN2yG8fqzKwG0XNrmWBYH1G+xQ0jx3y96+Xj6y
X-Mailer: b4 0.12.4
Message-ID: <20231219-libstringheader-v4-2-aaeb26495d2f@google.com>
Subject: [PATCH v4 2/2] lib/string: shrink lib/string.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	llvm@lists.linux.dev, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list changing indirect includes to direct includes.
IWYU is implemented using the IWYUScripts github repository which is a tool that is
currently undergoing development. These changes seek to improve build times.

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


