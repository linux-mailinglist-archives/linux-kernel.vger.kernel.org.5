Return-Path: <linux-kernel+bounces-109309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329EC881777
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE284284DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E585632;
	Wed, 20 Mar 2024 18:47:48 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4E6A8A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960468; cv=none; b=pC/w6xI4u9zOmUh6L9bba2rRXPUdKVaOiLyHyRl4nTh2DmwFD9SEdoUFxBE0KFHLTmpSqhsx4OP4d9ZZF09M9QD9yhkrzx9s9p7HCVh51MbRrKD5CG35yj2bJ4xhiTK/X4oN/hdDG8wzCNMLmSuitjISRUCxTu6vUJfgi+qppcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960468; c=relaxed/simple;
	bh=3mhzjDEKYr5v5j74va0Zmjj1DohqL1K2cOtcr+XhpeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8hEkEXOcyNVlj2tQVm9vQo0dy7lnrK0b3UDzNRQRe+erInWiqwS/w5Q3iyX3FZ3GJSFWTcxgjxvMo2qKqwTxQ7OD737YhMnhxq/0uC/GLEfZS3BrAMdgucYWcjf2noIhOIfnQeSmjy0b8Yq1AuYcG0HbEtL32xjevJUjHq/Vac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 7BD364251A;
	Wed, 20 Mar 2024 20:39:26 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-0x;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] xz: Fix comments and coding style
Date: Wed, 20 Mar 2024 20:38:38 +0200
Message-ID: <20240320183846.19475-6-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320183846.19475-1-lasse.collin@tukaani.org>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Update the URL of the .xz file format specification.
- Fix comments that were no longer in sync with the code below them.
- Fix language errors.
- Fix coding style.

Reviewed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/decompress_unxz.c | 20 ++++++++++----------
 lib/xz/Kconfig        |  3 ++-
 lib/xz/xz_stream.h    |  2 +-
 scripts/Makefile.lib  | 13 ++++++++-----
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 34bb7efc0412..46aa3be13fc5 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -102,7 +102,7 @@
 #ifdef STATIC
 #	define XZ_PREBOOT
 #else
-#include <linux/decompress/unxz.h>
+#	include <linux/decompress/unxz.h>
 #endif
 #ifdef __KERNEL__
 #	include <linux/decompress/mm.h>
@@ -219,7 +219,7 @@ void *memmove(void *dest, const void *src, size_t size)
 #endif
 
 /*
- * Since we need memmove anyway, would use it as memcpy too.
+ * Since we need memmove anyway, we could use it as memcpy too.
  * Commented out for now to avoid breaking things.
  */
 /*
@@ -389,17 +389,17 @@ STATIC int INIT unxz(unsigned char *in, long in_size,
 }
 
 /*
- * This macro is used by architecture-specific files to decompress
+ * This function is used by architecture-specific files to decompress
  * the kernel image.
  */
 #ifdef XZ_PREBOOT
-STATIC int INIT __decompress(unsigned char *buf, long len,
-			   long (*fill)(void*, unsigned long),
-			   long (*flush)(void*, unsigned long),
-			   unsigned char *out_buf, long olen,
-			   long *pos,
-			   void (*error)(char *x))
+STATIC int INIT __decompress(unsigned char *in, long in_size,
+			     long (*fill)(void *dest, unsigned long size),
+			     long (*flush)(void *src, unsigned long size),
+			     unsigned char *out, long out_size,
+			     long *in_used,
+			     void (*error)(char *x))
 {
-	return unxz(buf, len, fill, flush, out_buf, pos, error);
+	return unxz(in, in_size, fill, flush, out, in_used, error);
 }
 #endif
diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index aef086a6bf2f..6b80453d8f54 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -5,7 +5,8 @@ config XZ_DEC
 	help
 	  LZMA2 compression algorithm and BCJ filters are supported using
 	  the .xz file format as the container. For integrity checking,
-	  CRC32 is supported. See Documentation/staging/xz.rst for more information.
+	  CRC32 is supported. See Documentation/staging/xz.rst for more
+	  information.
 
 if XZ_DEC
 
diff --git a/lib/xz/xz_stream.h b/lib/xz/xz_stream.h
index 55f9f6f94b78..242500bd025d 100644
--- a/lib/xz/xz_stream.h
+++ b/lib/xz/xz_stream.h
@@ -18,7 +18,7 @@
 
 /*
  * See the .xz file format specification at
- * https://tukaani.org/xz/xz-file-format.txt
+ * https://xz.tukaani.org/format/xz-file-format.txt
  * to understand the container format.
  */
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bd59b8db05f..986c79c5af89 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -500,14 +500,17 @@ quiet_cmd_uimage = UIMAGE  $@
 
 # XZ
 # ---------------------------------------------------------------------------
-# Use xzkern to compress the kernel image and xzmisc to compress other things.
+# Use xzkern or xzkern_with_size to compress the kernel image and xzmisc to
+# compress other things.
 #
 # xzkern uses a big LZMA2 dictionary since it doesn't increase memory usage
 # of the kernel decompressor. A BCJ filter is used if it is available for
-# the target architecture. xzkern also appends uncompressed size of the data
-# using size_append. The .xz format has the size information available at
-# the end of the file too, but it's in more complex format and it's good to
-# avoid changing the part of the boot code that reads the uncompressed size.
+# the target architecture.
+#
+# xzkern_with_size also appends uncompressed size of the data using
+# size_append. The .xz format has the size information available at the end
+# of the file too, but it's in more complex format and it's good to avoid
+# changing the part of the boot code that reads the uncompressed size.
 # Note that the bytes added by size_append will make the xz tool think that
 # the file is corrupt. This is expected.
 #
-- 
2.44.0


