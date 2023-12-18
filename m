Return-Path: <linux-kernel+bounces-4254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43B8179E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D92840E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301871449;
	Mon, 18 Dec 2023 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Blz8jlYg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81B49891
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e31a4a893bso41470127b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702925092; x=1703529892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=otZZ0TbH3O/9uh/WTuAjWwf68II/fAS101L08F2nen4=;
        b=Blz8jlYgNTLbo9ur0a7IHTm7h4SLRi4x25y3LpNDDLTvMo6BE4Wj0cr6YZ6SqKN4WA
         k6zpkpYvio1CNyFeyUIAPQ0d7NPkFj7iDIvXEA4OXyw4RYqcLdBt/S3qeAYEBo3vdTvd
         nKlLJRN75uGvvBJI5UBxRVrhCVi1+tT4I8tg6wAaz7g6INdcbiL5aoI6DMSUjzDdAC9m
         /mB4La1QELzXjLoLC8IYaQfLSa14DvUFCrQ1YPrGlH20W+oBLSF9p9ZiJmXFjLy7OLAP
         HqHWmYwD8k3Rx5cTtVaxAPYygjQe6oRUQkei1Kf7S6lNJXO/kGuwZ7F3YWYtv4io9s4p
         ggPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925092; x=1703529892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otZZ0TbH3O/9uh/WTuAjWwf68II/fAS101L08F2nen4=;
        b=sYziF5OcrNc5d7U68HqhPgx5PjZo//mO9g22AOTTS1FOVj+zKcEzkjjj3eGJqweXp3
         veSW/6nbdsLDFed7XHbKBhmoClQKDe8PjCGMB/29dF6EvuYqwqJ2Sj3bminpiEezhCVz
         nq3LKPHT9A90j2YVewocUkzDrp8BGephPzdzupxl/taRVUtDZkkBH1EpLOLBzsKSfbzo
         7WAWw8Eb4nrO6HEA7piBaJKo9TODYmtDBpZfttyzbufAlZVLJKvhdAxSaqIT2wTnKNF9
         z0fp9jXYXfrzoaM91Qhskcy5LOvti4PZ/mDe1Igc+eUm19Iw6A451UMnpTdi2+vKMGfo
         tu/w==
X-Gm-Message-State: AOJu0Yzvwx2lwq9cfm6pBiuEjJ1hdBpdIf3qokogfYELSglqc1MZNoE6
	HgRSoqfZXwSieNx6wL/uun9dCG0drQFL
X-Google-Smtp-Source: AGHT+IHzdlAv080D0kEhLad8Vbm8sguShMzLkHfNhIcwx0//4rTOgbUFe3INzcxZmfXd3x6uVUlDWwWl6dF5
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:83:b0:5d5:6a4c:b0b3 with SMTP id
 be3-20020a05690c008300b005d56a4cb0b3mr2386137ywb.8.1702925092683; Mon, 18 Dec
 2023 10:44:52 -0800 (PST)
Date: Mon, 18 Dec 2023 18:44:47 +0000
In-Reply-To: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702925089; l=5960;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=1zmqDeKrI4VGJQmHkQfCpOMar1eOZu561uUlu020PMg=; b=aIzg8QQKRJufy3r1aZ1mmlDEDn6a3LTdwAfet0aRj6YMycSQOJRraIUquQXmVDA5JL7zMT29f
 rJ/wSyFr1UNCMHEtmf5jE79LRfjmSb329FbLTMgoDySWVrtjjQPGcsW
X-Mailer: b4 0.12.3
Message-ID: <20231218-libstringheader-v3-1-500bd58f0f75@google.com>
Subject: [PATCH v3 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
From: tanzirh@google.com
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch creates wordpart.h and includes it in asm/word-at-a-time.h
for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
because of REPEAT_BYTE. Moving this to another header and including it
where necessary allows us to not include the bloated kernel.h. Making
this implicit dependancy on REPEAT_BYTE explicit allows for later
improvements in the lib/string.c inclusion list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/arm/include/asm/word-at-a-time.h     |  1 +
 arch/arm64/include/asm/word-at-a-time.h   |  1 +
 arch/powerpc/include/asm/word-at-a-time.h |  1 +
 arch/riscv/include/asm/word-at-a-time.h   |  1 +
 arch/s390/include/asm/word-at-a-time.h    |  1 +
 arch/sh/include/asm/word-at-a-time.h      |  2 ++
 arch/x86/include/asm/word-at-a-time.h     |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  1 +
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 17 +++++++++++++++++
 11 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 352ab213520d..aea6bfe259f5 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -9,6 +9,7 @@
  * Heavily based on the x86 algorithm.
  */
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index f3b151ed0d7a..cf8c28a3bba9 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -10,6 +10,7 @@
 #ifndef __AARCH64EB__
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 30a12d208687..032a77d324e6 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
 
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..9b7ea4c1a616 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -10,6 +10,7 @@
 
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 2579f1694b82..5af1d267b4d7 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
diff --git a/arch/sh/include/asm/word-at-a-time.h b/arch/sh/include/asm/word-at-a-time.h
index 4aa398455b94..3a11158f0143 100644
--- a/arch/sh/include/asm/word-at-a-time.h
+++ b/arch/sh/include/asm/word-at-a-time.h
@@ -5,6 +5,8 @@
 #ifdef CONFIG_CPU_BIG_ENDIAN
 # include <asm-generic/word-at-a-time.h>
 #else
+#include <linux/kernel.h>
+#include <linux/wordpart.h>
 /*
  * Little-endian version cribbed from x86.
  */
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 46b4f1f7f354..c002c864a63e 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 /*
  * This is largely generic for little-endian machines, but the
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..03db8ca3f394 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -17,7 +17,7 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 95a1d214108a..fc007fda0b2e 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/byteorder.h>
 
 #ifdef __BIG_ENDIAN
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ad21058eed..162660af5b7d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -39,13 +39,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/**
- * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
- * @x: value to repeat
- *
- * NOTE: @x is not checked for > 0xff; larger values produce odd results.
- */
-#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
 /* generic data direction definitions */
 #define READ			0
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
new file mode 100644
index 000000000000..6a5ed5d54ba2
--- /dev/null
+++ b/include/linux/wordpart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Google LLC <tanzirh@google.com>
+ */
+
+#ifndef _LINUX_WORDPART_H
+#define _LINUX_WORDPART_H
+/**
+ * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
+ * @x: value to repeat
+ *
+ * NOTE: @x is not checked for > 0xff; larger values produce odd results.
+ */
+#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
+
+#endif // _LINUX_WORDPART_H
+

-- 
2.43.0.472.g3155946c3a-goog


