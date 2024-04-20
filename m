Return-Path: <linux-kernel+bounces-152378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F98ABD93
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5189DB20C68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208D482EA;
	Sat, 20 Apr 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nF0xEFiL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305110788
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713652759; cv=none; b=LaeC8le4hfIrCCNY4Py3/GX8xI+XiDnlDJygeM+VxS8ZMjG2VW5+1L+HuBSdOsBVyfALHszKJsxWYhY9A6/2yPZRuNwLsbKSdEc6HmQ9d2Azq4v4vN6eGaiU8HNhrpTfDAdTsFV08tnbSE6WvE1rm6BdLm/KeFtu8KnCPdZAsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713652759; c=relaxed/simple;
	bh=4MNiMTzDJScnkrBt3q5ppnoFyu5SPLMZSky3nmASO6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aRCPUJM8b0+N+9fnbVd/OQN0pm1LrAcQBzQqCu+bohk9trDoEJtWp55Aexd5VPrbrVQ4Npx8V4kjxXfaSmCy8Yw4KmgHFz8UOZQiRnzNmUEVH51UU/IBqJ9dCCdonjRrlA2v7G2KJvWOaO97UTcP/9Hrtg/LKEPmAntW5pwzi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nF0xEFiL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso12021675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713652756; x=1714257556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3NHnxjtFu5JpYjacER3Aw2OwLNVGjO/bJseAjeHqiU=;
        b=nF0xEFiLoZIGpuFnTfMWKhUTIgk8dxTZiGfmnBheLHzJi8CI+OpckSq031qJM+nhgb
         kLHGZ9S5ckD8Ff7X31PSHaH489TqHFW0pU8+4v73WKYp9zppARoimpkmChyi0erfT2LK
         ZGR0wQVEIK6ZeBRnCCoSOSuEwfD5s+xSvt6x3XpThJPiKWBjO0BJn3DTPHLcQopwkXok
         8J3GJw7TeU8QQCZxHL6i4pxknrBZjlSHCTte7Ho2Md3Jq3iw4A++Oi7K2opnoipM0GEp
         7aHzUOnZqj+t/llfXuGozbSWG7wBmKfutNbEVeDAA5LKttq1vfFSTvDFzCdLcKU0yD2B
         svjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713652756; x=1714257556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3NHnxjtFu5JpYjacER3Aw2OwLNVGjO/bJseAjeHqiU=;
        b=sFdyFltIQ4cm9DHCZEayKwt8i3HOvo087oK2OLoiuDvDrOYnOrXimISrDcnZeQJWa9
         nHUhsFhVNrLgRN1E4CdVFFtuo2tJAksT5j5SBUb/9CvXlumsZSCK3sPEqzLb/r7kLDxB
         i427ijAzN0huZABHV0NFBVnlRsZ5jMQpm7bVzyeEP53ap7aglpU8JgFge6x4hXAf5lbq
         3dPcO2MZzVAKfskeF4wJZ4iTgszY7i/rkYjaVLXjzIpneH91yeqMEDHz5lkbrjhqX/jo
         HhWTkLTt2goC80je15XbktlovuienJ44u45ElEJhjo667NgetuKRgV5iloxiUBOMeLKF
         +AmA==
X-Forwarded-Encrypted: i=1; AJvYcCXlRbKpG607pt59rDjs+1NGplWOSLMoGM8tboHdOGg7x+OZKNwn27YBZusOQaFVX+DuQbm6sI/wLGL1cfctk4x4PIj2RJFFcCzGD1pZ
X-Gm-Message-State: AOJu0YwIITLNrPz6nvWuDeyeJX3eSdDryq6T8TI7G94IgA4rbg9M4Obr
	WPtLG6b2nGNSyCJ30EjK33ZatamT0ni2UksPJcoVKFmkoNUSPEKa65bvc1u4FtY=
X-Google-Smtp-Source: AGHT+IFvsUuVZ9mU8nFpRzKvyidPlf6VYEG71XzkImijGEkwFIMPgi4xMJD4/sLW/2FjK2c4CzfdsA==
X-Received: by 2002:a05:600c:348a:b0:418:a7a7:98f8 with SMTP id a10-20020a05600c348a00b00418a7a798f8mr3912393wmq.29.1713652756058;
        Sat, 20 Apr 2024 15:39:16 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b0033e9d9f891csm7937550wrb.58.2024.04.20.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 15:39:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Youling Tang <tangyouling@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bitops: Change function return types from long to int
Date: Sun, 21 Apr 2024 00:38:37 +0200
Message-Id: <20240420223836.241472-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return types of bitops functions (ffs, fls, and fns) from
long to int. The expected return values are in the range [0, 64], for
which int is sufficient.

Additionally, int aligns well with the return types of the corresponding
__builtin_* functions, potentially reducing overall type conversions.

Many of the existing bitops functions already return an int and don't
need to be changed. The bitops functions in arch/ should be considered
separately.

Adjust some return variables to match the function return types.

With GCC 13 and defconfig, these changes reduced the size of a test
kernel image by 5,432 bytes on arm64 and by 248 bytes on riscv; there
were no changes in size on x86_64, powerpc, or m68k.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/asm-generic/bitops/__ffs.h         | 4 ++--
 include/asm-generic/bitops/__fls.h         | 4 ++--
 include/asm-generic/bitops/builtin-__ffs.h | 2 +-
 include/asm-generic/bitops/builtin-__fls.h | 2 +-
 include/linux/bitops.h                     | 6 +++---
 tools/include/asm-generic/bitops/__ffs.h   | 4 ++--
 tools/include/asm-generic/bitops/__fls.h   | 4 ++--
 tools/include/linux/bitops.h               | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
index 446fea6dda78..2d08c750c8a7 100644
--- a/include/asm-generic/bitops/__ffs.h
+++ b/include/asm-generic/bitops/__ffs.h
@@ -10,9 +10,9 @@
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long generic___ffs(unsigned long word)
+static __always_inline unsigned int generic___ffs(unsigned long word)
 {
-	int num = 0;
+	unsigned int num = 0;
 
 #if BITS_PER_LONG == 64
 	if ((word & 0xffffffff) == 0) {
diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
index 54ccccf96e21..e974ec932ec1 100644
--- a/include/asm-generic/bitops/__fls.h
+++ b/include/asm-generic/bitops/__fls.h
@@ -10,9 +10,9 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long generic___fls(unsigned long word)
+static __always_inline unsigned int generic___fls(unsigned long word)
 {
-	int num = BITS_PER_LONG - 1;
+	unsigned int num = BITS_PER_LONG - 1;
 
 #if BITS_PER_LONG == 64
 	if (!(word & (~0ul << 32))) {
diff --git a/include/asm-generic/bitops/builtin-__ffs.h b/include/asm-generic/bitops/builtin-__ffs.h
index 87024da44d10..cf4b3d33bf96 100644
--- a/include/asm-generic/bitops/builtin-__ffs.h
+++ b/include/asm-generic/bitops/builtin-__ffs.h
@@ -8,7 +8,7 @@
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned int __ffs(unsigned long word)
 {
 	return __builtin_ctzl(word);
 }
diff --git a/include/asm-generic/bitops/builtin-__fls.h b/include/asm-generic/bitops/builtin-__fls.h
index 43a5aa9afbdb..6d72fc8a5259 100644
--- a/include/asm-generic/bitops/builtin-__fls.h
+++ b/include/asm-generic/bitops/builtin-__fls.h
@@ -8,7 +8,7 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned int __fls(unsigned long word)
 {
 	return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
 }
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f60220f119e2 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -200,7 +200,7 @@ static __always_inline __s64 sign_extend64(__u64 value, int index)
 	return (__s64)(value << shift) >> shift;
 }
 
-static inline unsigned fls_long(unsigned long l)
+static inline unsigned int fls_long(unsigned long l)
 {
 	if (sizeof(l) == 4)
 		return fls(l);
@@ -236,7 +236,7 @@ static inline int get_count_order_long(unsigned long l)
  * The result is not defined if no bits are set, so check that @word
  * is non-zero before calling this.
  */
-static inline unsigned long __ffs64(u64 word)
+static inline unsigned int __ffs64(u64 word)
 {
 #if BITS_PER_LONG == 32
 	if (((u32)word) == 0UL)
@@ -252,7 +252,7 @@ static inline unsigned long __ffs64(u64 word)
  * @word: The word to search
  * @n: Bit to find
  */
-static inline unsigned long fns(unsigned long word, unsigned int n)
+static inline unsigned int fns(unsigned long word, unsigned int n)
 {
 	unsigned int bit;
 
diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..2d94c1e9b2f3 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -11,9 +11,9 @@
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned int __ffs(unsigned long word)
 {
-	int num = 0;
+	unsigned int num = 0;
 
 #if __BITS_PER_LONG == 64
 	if ((word & 0xffffffff) == 0) {
diff --git a/tools/include/asm-generic/bitops/__fls.h b/tools/include/asm-generic/bitops/__fls.h
index 54ccccf96e21..e974ec932ec1 100644
--- a/tools/include/asm-generic/bitops/__fls.h
+++ b/tools/include/asm-generic/bitops/__fls.h
@@ -10,9 +10,9 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long generic___fls(unsigned long word)
+static __always_inline unsigned int generic___fls(unsigned long word)
 {
-	int num = BITS_PER_LONG - 1;
+	unsigned int num = BITS_PER_LONG - 1;
 
 #if BITS_PER_LONG == 64
 	if (!(word & (~0ul << 32))) {
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 7319f6ced108..8e073a111d2a 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -70,7 +70,7 @@ static inline unsigned long hweight_long(unsigned long w)
 	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
 }
 
-static inline unsigned fls_long(unsigned long l)
+static inline unsigned int fls_long(unsigned long l)
 {
 	if (sizeof(l) == 4)
 		return fls(l);
-- 
2.39.2


