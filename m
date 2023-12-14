Return-Path: <linux-kernel+bounces-112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED82813C59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABE21F22403
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C06ABB0;
	Thu, 14 Dec 2023 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2JW2PSt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662B6D1C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5deda822167so78259507b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702588046; x=1703192846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvHrK2O7Pjqorqre2FxP3aimz1/5eGTahkzwWcaIuP8=;
        b=s2JW2PStbuaGHxZwdN7kl62GZcpsxyROdO7keJRE3sxOq8SaqPfq9J0jSAKcfrVcDC
         x7CFWRJ4j27LPToXuT38OzHO161DH4YTnHPSrASM3T6Th79u4vbZ2vXVufuKPeb/exxl
         mL1R/2AxRckJWSJjKFT8jmlQ24HPby+taws918exeG34A5wjYJMNoPLtAxEc2MkLh++l
         MyYRBlBbLdux9VpY8Rkq4YTbco66fFMFePCMcUX8V+7NV9uRvBDKAuTqAt4IRrWgZcIv
         W5nEyPD1Wp+ROyNcz/032mfL+/RWkWW53aNggOeAnLBwJcbJF9127+h62tq5xybWM7xH
         OsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702588046; x=1703192846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvHrK2O7Pjqorqre2FxP3aimz1/5eGTahkzwWcaIuP8=;
        b=QRSr+A+3s2RlO2MC/JNNxFyVqVebvCEWZs5nS7CfqlZ4QLTDiwGqTN4SBdHaCiSjFJ
         GPFQVWtPOLlc+X/VBhy4lRE/VS1hLSSde4EyRbC1cpcezAh4I2JScBn+LCg2rCGVMFWX
         ELKkQ/g/BUuJSF4Zai4CEruojEvTEfK9kAv4eSKy56+192miHBwmVd23MB6OomZaha/o
         MhuiWJgPJr17sICcGyu3R/O9hdiso0XGFq2n2ukqeEFbxPR36SbNQdpy77vjGWMKnOeq
         z9QLxP02CrdbWF9e2plA4H5YzBnx9U/jKfJ/tIpboKvs9CQpqJuaVhfDMOubb4gs6a/I
         0hdQ==
X-Gm-Message-State: AOJu0YzV6P6764bMt4qu5E/xJmb03rDebuqIRI6GAe1qtw9jUuLQDMur
	x9Yw/nWTKq49qXXHG7rkdiaMMREfzdDy
X-Google-Smtp-Source: AGHT+IFi8YNAQ3xyc8K/sY7hjOazzHdUVZNGzoO2ZJiuSwVCb2AJazUd20DqytBNBjyv2QYzqs6581eY60+q
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:c9c:b0:5e2:1d4d:bb78 with SMTP id
 cm28-20020a05690c0c9c00b005e21d4dbb78mr67840ywb.2.1702588045822; Thu, 14 Dec
 2023 13:07:25 -0800 (PST)
Date: Thu, 14 Dec 2023 21:06:13 +0000
In-Reply-To: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702588040; l=1379;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=91dW9F9BO6/svU0lSPP0Jze6wT7/fMBiGl2CPin/YSo=; b=WmYdOEcw8kfyBDG2Wa2MRk8zfL5fW+W7stfIilOpCB+z9MN2lr2zZu4E1EXEZBuy7UDS85vqO
 7r94wjCSS35DlEuOxcBJPDigqi+vOS0OkFs34Ft/7vEMr23/ERvn2Wk
X-Mailer: b4 0.12.3
Message-ID: <20231214-libstringheader-v2-2-0f195dcff204@google.com>
Subject: [PATCH v2 2/2] lib/string: shrink lib/string.i via IWYU
From: tanzirh@google.com
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list changing indirect includes to direct includes.
IWYU is implemented using the IWYUScripts github repository which is a tool that is
currently undergoing development. These changes seek to improve build times.

This change to lib/string.c resulted in a preprocessed size of
lib/string.i from 26371 lines to 5259 lines (-80%) for the x86
defconfig.

Link: https://github.com/ClangBuiltLinux/IWYUScripts

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 lib/string.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index be26623953d2..7fe1acefb1a1 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,16 +16,16 @@
 
 #define __NO_FORTIFY
 #include <linux/types.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
-#include <linux/slab.h>
-
+#include <asm/rwonce.h>
+#include <linux/linkage.h>
+#include <linux/stddef.h>
+#include <vdso/limits.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
 #include <asm/unaligned.h>
-#include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
 

-- 
2.43.0.472.g3155946c3a-goog


