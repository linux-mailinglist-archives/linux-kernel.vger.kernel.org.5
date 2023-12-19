Return-Path: <linux-kernel+bounces-5830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81A818FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF9B229D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF339879;
	Tue, 19 Dec 2023 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RunE1/9+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74049381B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd4db03bd4so1185672276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703011687; x=1703616487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQnopqwXCPJwf1o31D0QkbeUw9iOW+EHq9+aREsG9fw=;
        b=RunE1/9+CTYXmKrJpmkGpJ8E3KqXHpu56BPWX8/0TXWRu2wM8yd88OX0z9GUBWnIf0
         Wwxlc9NEJG6DbWYniUPrDDgiIDyZOA56bmluFz82k58PjOpS7C90ObamA4lprFIj747x
         rCPqLnZ1ExkRsTil4Sjkxs8iGL4JIxtPsy4CVQlM/Yb+lfVbG4B0QS+EU4jhEx+x7qvD
         9QbgoIacH++xBY6I/OOU9mJYIGD00TDpG8j66R80ULtYFE5f31r2qOaDBRqkFlGv/Aom
         sNGlHoZIGXAJKJRj6MMRtR07l77FNK1Jn75hG8ZjMdzAYS6/tM3l9hXScPGNMC6I37lc
         FG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011687; x=1703616487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQnopqwXCPJwf1o31D0QkbeUw9iOW+EHq9+aREsG9fw=;
        b=kbE/BZ5jfFb4YNpUFJ/iwuAGnDpjaDLdPvwgQbbG31UkOH1GshVHMLMWIDuY4nkN4I
         yLuaHg7WIlUHqWTWynmf51GQKZ5WOiwxx0Eq38G9r3QSOmMrqTFjIRd6bHRufy9vVzJu
         JnFg1D4gZAFDQ2DQ8rxLtNmyIXcHzl++5NlbUWB4sGbFUhBToa2ZnU6pw7HcO/GDTJ/e
         2vPQgYm6zS5oOLIMPvtS52n9C8YDZwucFYAPzRXVyzu6N9eoQ7/WQdpMAjQJJxzATc6J
         +y3hvxFd2JmmbXAJ3DAc9wBkQ0BH0HHZVO6/JiDx6UKh6cIzKfAepR/vhCukDlM5g9y7
         tCxQ==
X-Gm-Message-State: AOJu0Yz7ikN24Ye1yScegco5Lr/HODQKNSML+ubIiqf4xg3FX7ppfBWt
	WOtxDG38c0OLFSzKKtT4s434T/2AnUtE
X-Google-Smtp-Source: AGHT+IHBA+KH6ttcAcCFFF4DpkEvaI+VOlFNhCHPim/Q48y/kMnBB99Abloesqsd9Mz74KHJnLFXqzFVhpxC
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:ef0c:0:b0:dbc:d4c9:bbcc with SMTP id
 g12-20020a25ef0c000000b00dbcd4c9bbccmr173651ybd.8.1703011687539; Tue, 19 Dec
 2023 10:48:07 -0800 (PST)
Date: Tue, 19 Dec 2023 18:47:54 +0000
In-Reply-To: <20231219-libstringheader-v5-0-206d4afd309a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231219-libstringheader-v5-0-206d4afd309a@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703011682; l=1528;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=kLkju4pFci+nx2b0Vi+mSe3j1L2n+dGn+lmNlbPb2hw=; b=b0jsU9dP77fa4yf1ZBmjDzAgZG7P8A4zLkwrshRlIytJsSBs6DmwQmw8P9xNcLRozgOVkFZKB
 c9540TlKe4QDsPqQQGaAoMFGfuUGIw9TqLNSGRIYgTfRJd1i6ynudEf
X-Mailer: b4 0.12.4
Message-ID: <20231219-libstringheader-v5-2-206d4afd309a@google.com>
Subject: [PATCH v5 2/2] lib/string: shrink lib/string.i via IWYU
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


