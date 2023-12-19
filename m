Return-Path: <linux-kernel+bounces-5829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4847818FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF64C1C21747
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A738FB3;
	Tue, 19 Dec 2023 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0ibUbA+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E730381A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e786bb28a4so13919547b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703011685; x=1703616485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbybSsV/bS+3WyIy5bQjflj1d8kB/aeheYO00KzfCc4=;
        b=k0ibUbA+WFfOqLoeNglvZ9mkuddQovKw1lLFXQffRxzqLwRspUl3PHYGWHcF2l9Bi9
         EkQKR9sBFzc9SCk2GRaVWQhBy+3mZNEHkZT/eJ8/kqr8E/4806M6j+yMHUK9Zgxw2jhD
         YkplWMIrE/L+9cYPnNFV+vieEXdTz5kCrQK8893pi1yt40/7KlFHOQ0gqMcOQuP++6SM
         F0cafn7BvXr7JkcwekeHsYkeAY16TfIcaxVM+9JrrLtO8DQ2k5r9UO0rWFUNBRDBfasF
         qFzu2MX0ekz+YDXQ32/sd2j7EZjVePOclgyJzOql19Z1zE/6JLXqnYBgUxT0s+BKER1E
         T36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011685; x=1703616485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbybSsV/bS+3WyIy5bQjflj1d8kB/aeheYO00KzfCc4=;
        b=A9yoOALGvHpz4Ics291lKg/VaYMT+Fk0yK8y4JIvGcHJCQjl+gkOm0cc01eM4JQJDV
         wLynTuomONbOnN/klyXEmnxRIzQnru/0sVe4mfeTShszcL9FVA0uo/j81jBadj3rHajD
         7Q8JQMZY7w7WwuWgqP190vkDCvX5zMIrPL7zfSpXinqndMguq/PbU4NdyrlKIKNCYr2k
         SXs97W57YrLSd/EB1kx2UGm5b8cmHNNsc8F6h+W5VNIOnrC4pwuO2uwK83cq+QZ6pxAe
         6P/hL2r11fNFZfEHdJTynFAliQ8r431msflhHeDGj32vKwF0HSbZ4B33rzjRFugwrimX
         82Ow==
X-Gm-Message-State: AOJu0YyA0Wux5ZV4s/fj3X3THU1YRpSFEwNqWBfGYFqq+sRsTKM4qHDO
	4+n0JKwaBexfW6f7I7TBTyrzXx1/TvpjQMcXQ8s=
X-Google-Smtp-Source: AGHT+IHOG8gufTHHonMi2Xc/wBkaLbrjdmS+i6td2TKm2vZG7Cm8N7oobhSCfLeoBzlJOo2TyvRazqeUhxV0
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:f04:b0:dbc:decd:3c7d with SMTP id
 et4-20020a0569020f0400b00dbcdecd3c7dmr557649ybb.6.1703011685613; Tue, 19 Dec
 2023 10:48:05 -0800 (PST)
Date: Tue, 19 Dec 2023 18:47:53 +0000
In-Reply-To: <20231219-libstringheader-v5-0-206d4afd309a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231219-libstringheader-v5-0-206d4afd309a@google.com>
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703011682; l=6067;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=2//M5tR0AMdNBe14AksDgWdDSCB4lFtXwH0yxJGuKqc=; b=0wmsNcdXgytnPMUQvnsztAk4CPsOO6DiKEvruiUTRlJ1Ec/U96tpLNk6uO1ykcSCazR27+OH1
 V7GtQSZN5kdB9PuFsG3n3TZ5PPGH978S7Q18bokVz9NK9uJm3d82VHu
X-Mailer: b4 0.12.4
Message-ID: <20231219-libstringheader-v5-1-206d4afd309a@google.com>
Subject: [PATCH v5 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
From: Tanzir Hasan <tanzirh@google.com>
To: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This patch creates wordpart.h and includes it in asm/word-at-a-time.h
for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
because of REPEAT_BYTE. Moving this to another header and including it
where necessary allows us to not include the bloated kernel.h. Making
this implicit dependency on REPEAT_BYTE explicit allows for later
improvements in the lib/string.c inclusion list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/arm/include/asm/word-at-a-time.h     |  2 +-
 arch/arm64/include/asm/word-at-a-time.h   |  2 +-
 arch/powerpc/include/asm/word-at-a-time.h |  2 +-
 arch/riscv/include/asm/word-at-a-time.h   |  2 +-
 arch/s390/include/asm/word-at-a-time.h    |  2 +-
 arch/sh/include/asm/word-at-a-time.h      |  1 +
 arch/x86/include/asm/word-at-a-time.h     |  1 +
 fs/namei.c                                |  2 +-
 include/asm-generic/word-at-a-time.h      |  2 +-
 include/linux/kernel.h                    |  7 -------
 include/linux/wordpart.h                  | 14 ++++++++++++++
 11 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 352ab213520d..e08304996121 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -8,7 +8,7 @@
  * Little-endian word-at-a-time zero byte handling.
  * Heavily based on the x86 algorithm.
  */
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index f3b151ed0d7a..bd8cfbc2b9c3 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -9,7 +9,7 @@
 
 #ifndef __AARCH64EB__
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 30a12d208687..26e4f718a674 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,7 +5,7 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
 
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..94bec2f7ba53 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -9,7 +9,7 @@
 #define _ASM_RISCV_WORD_AT_A_TIME_H
 
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 2579f1694b82..55e66d9371d6 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
diff --git a/arch/sh/include/asm/word-at-a-time.h b/arch/sh/include/asm/word-at-a-time.h
index 4aa398455b94..663658cea69a 100644
--- a/arch/sh/include/asm/word-at-a-time.h
+++ b/arch/sh/include/asm/word-at-a-time.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_CPU_BIG_ENDIAN
 # include <asm-generic/word-at-a-time.h>
 #else
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
index 95a1d214108a..6f088b2b0b03 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-#include <linux/kernel.h>
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
index 000000000000..43c1a8ae5152
--- /dev/null
+++ b/include/linux/wordpart.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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


