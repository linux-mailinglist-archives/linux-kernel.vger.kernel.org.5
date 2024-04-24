Return-Path: <linux-kernel+bounces-157553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1B8B12C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D7F1F254BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24321362;
	Wed, 24 Apr 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcR07Vsz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF181C68F;
	Wed, 24 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984293; cv=none; b=gzwgxqiwAZZdXk95o58Ih4xwsJWe56nq8Hhv7Z7jFqAacu6IrsOATMs2Fo3F+UHP3iypv7dr2yEzV4uKuM3+WYvDVhKxMMZxdu0UJozq0IRX0aNFpcRjtaK4hiYlrGlDMxT57UTmAWF93yh6QBqTFFmj5h2qtMvwx6u3g8MQVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984293; c=relaxed/simple;
	bh=ifDIBEgdDr9EzHZCCEDcsAmGEU5TQ8e/Bt7a5YKRZB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxmqxqVLTp3ZkBkXutiOCPPX1MLgsJFdpiFeuDfhGfGLp4uGdMly7KpUaAC5J50dNw+HkaEIHyL32OcHaRfLiwrQE5hCZlEUydzL7MsYcHh5zeHGktQioxmTc/zp6+kiNNuna6mEOiZPFssr3egY0mkqkt+mVoh0soW2TP96dYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcR07Vsz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713984291; x=1745520291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ifDIBEgdDr9EzHZCCEDcsAmGEU5TQ8e/Bt7a5YKRZB8=;
  b=hcR07Vszyl/aYdvjeUTaPh6+HZlDGjmPwX68xOkq3MGD2Te7J2nMhOP1
   DuVYKsLRUTlwz080/Q0frLJPJ8KrmpWnRS/vNqkK/SuZH7oXr5JKE9sGZ
   lUSfgY7vzwPpQCpnhvvubpFLi4PNM+H++OtT9L6glnVati4JKSfRVwqVp
   pJm4nfPrkYWVDSK0ZZxlnOePwtZSHs9/WyUwbH670tyra7P/Cx71klmzk
   oGrz7R0KVkYrjd92N3XCtxy4Fef48gE87AGZMQmM0XwvA6RvTQ1dAt4I1
   UxW6btGtcY7f32vUBCqCuVlcYJrLycURSdfjeTJ+SM6KTv5Xbb4bLO6N9
   g==;
X-CSE-ConnectionGUID: 9iHwyTi4Qfq03581oijB1Q==
X-CSE-MsgGUID: Vc1qgBwNSDug0NS3r/Jr5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9507797"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9507797"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:44:49 -0700
X-CSE-ConnectionGUID: lLauGusGS3moBupknZ/XhQ==
X-CSE-MsgGUID: jDP4IMS+T1GLIhUWk/uvyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24810442"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 11:44:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CDE8F56; Wed, 24 Apr 2024 21:44:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/2] media: atomisp: Clean up unused macros from math_support.h
Date: Wed, 24 Apr 2024 21:43:31 +0300
Message-ID: <20240424184421.1737776-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
References: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up unused macros from math_support.h and replace rarely
used by generic ones from Linux kernel headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../pci/camera/util/interface/ia_css_util.h   |  11 --
 .../media/atomisp/pci/camera/util/src/util.c  |  25 ++--
 .../pci/hive_isp_css_include/math_support.h   | 110 +-----------------
 drivers/staging/media/atomisp/pci/ia_css_3a.h |   1 +
 .../kernels/xnr/xnr_3.0/ia_css_xnr3.host.c    |   6 +-
 .../atomisp/pci/runtime/binary/src/binary.c   |   2 -
 .../staging/media/atomisp/pci/sh_css_frac.h   |   4 +-
 7 files changed, 20 insertions(+), 139 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/camera/util/interface/ia_css_util.h b/drivers/staging/media/atomisp/pci/camera/util/interface/ia_css_util.h
index 59df44d696a0..d4de1e9293a1 100644
--- a/drivers/staging/media/atomisp/pci/camera/util/interface/ia_css_util.h
+++ b/drivers/staging/media/atomisp/pci/camera/util/interface/ia_css_util.h
@@ -100,17 +100,6 @@ bool ia_css_util_res_leq(
 bool ia_css_util_resolution_is_zero(
     const struct ia_css_resolution resolution);
 
-/* ISP2401 */
-/**
- * @brief Check if resolution is even
- *
- * @param[in] resolution The resolution to check
- *
- * @returns true if resolution is even
- */
-bool ia_css_util_resolution_is_even(
-    const struct ia_css_resolution resolution);
-
 /* @brief check width and height
  *
  * @param[in] stream_format
diff --git a/drivers/staging/media/atomisp/pci/camera/util/src/util.c b/drivers/staging/media/atomisp/pci/camera/util/src/util.c
index 40a71e37cc4e..9d7025a00beb 100644
--- a/drivers/staging/media/atomisp/pci/camera/util/src/util.c
+++ b/drivers/staging/media/atomisp/pci/camera/util/src/util.c
@@ -119,17 +119,6 @@ int ia_css_util_check_vf_out_info(
 	return 0;
 }
 
-int ia_css_util_check_res(unsigned int width, unsigned int height)
-{
-	/* height can be odd number for jpeg/embedded data from ISYS2401 */
-	if (((width  == 0)   ||
-	     (height == 0)   ||
-	     IS_ODD(width))) {
-		return -EINVAL;
-	}
-	return 0;
-}
-
 /* ISP2401 */
 bool ia_css_util_res_leq(struct ia_css_resolution a, struct ia_css_resolution b)
 {
@@ -142,10 +131,18 @@ bool ia_css_util_resolution_is_zero(const struct ia_css_resolution resolution)
 	return (resolution.width == 0) || (resolution.height == 0);
 }
 
-/* ISP2401 */
-bool ia_css_util_resolution_is_even(const struct ia_css_resolution resolution)
+int ia_css_util_check_res(unsigned int width, unsigned int height)
 {
-	return IS_EVEN(resolution.height) && IS_EVEN(resolution.width);
+	const struct ia_css_resolution resolution = { .width = width, .height = height };
+
+	if (ia_css_util_resolution_is_zero(resolution))
+		return -EINVAL;
+
+	/* height can be odd number for jpeg/embedded data from ISYS2401 */
+	if (width & 1)
+		return -EINVAL;
+
+	return 0;
 }
 
 bool ia_css_util_is_input_format_raw(enum atomisp_input_format format)
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
index a444ec14ff9d..7349943bba2b 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
@@ -16,133 +16,27 @@
 #ifndef __MATH_SUPPORT_H
 #define __MATH_SUPPORT_H
 
-#include <linux/kernel.h> /* Override the definition of max/min from linux kernel*/
-
-#define IS_ODD(a)            ((a) & 0x1)
-#define IS_EVEN(a)           (!IS_ODD(a))
+/* Override the definition of max/min from Linux kernel */
+#include <linux/minmax.h>
 
 /* force a value to a lower even value */
 #define EVEN_FLOOR(x)        ((x) & ~1)
 
-/* ISP2401 */
-/* If the number is odd, find the next even number */
-#define EVEN_CEIL(x)         ((IS_ODD(x)) ? ((x) + 1) : (x))
-
-/* A => B */
-#define IMPLIES(a, b)        (!(a) || (b))
-
 /* for preprocessor and array sizing use MIN and MAX
    otherwise use min and max */
 #define MAX(a, b)            (((a) > (b)) ? (a) : (b))
 #define MIN(a, b)            (((a) < (b)) ? (a) : (b))
 
-#define ROUND_DIV(a, b)      (((b) != 0) ? ((a) + ((b) >> 1)) / (b) : 0)
 #define CEIL_DIV(a, b)       (((b) != 0) ? ((a) + (b) - 1) / (b) : 0)
 #define CEIL_MUL(a, b)       (CEIL_DIV(a, b) * (b))
 #define CEIL_MUL2(a, b)      (((a) + (b) - 1) & ~((b) - 1))
 #define CEIL_SHIFT(a, b)     (((a) + (1 << (b)) - 1) >> (b))
 #define CEIL_SHIFT_MUL(a, b) (CEIL_SHIFT(a, b) << (b))
-#define ROUND_HALF_DOWN_DIV(a, b)	(((b) != 0) ? ((a) + (b / 2) - 1) / (b) : 0)
-#define ROUND_HALF_DOWN_MUL(a, b)	(ROUND_HALF_DOWN_DIV(a, b) * (b))
-
-/*To Find next power of 2 number from x */
-#define bit2(x)            ((x)      | ((x) >> 1))
-#define bit4(x)            (bit2(x)  | (bit2(x) >> 2))
-#define bit8(x)            (bit4(x)  | (bit4(x) >> 4))
-#define bit16(x)           (bit8(x)  | (bit8(x) >> 8))
-#define bit32(x)           (bit16(x) | (bit16(x) >> 16))
-#define NEXT_POWER_OF_2(x) (bit32(x - 1) + 1)
-
-/* min and max should not be macros as they will evaluate their arguments twice.
-   if you really need a macro (e.g. for CPP or for initializing an array)
-   use MIN() and MAX(), otherwise use min() and max().
-
-*/
 
 #if !defined(PIPE_GENERATION)
 
-/*
-This macro versions are added back as we are mixing types in usage of inline.
-This causes corner cases of calculations to be incorrect due to conversions
-between signed and unsigned variables or overflows.
-Before the addition of the inline functions, max, min and ceil_div were macros
-and therefore adding them back.
-
-Leaving out the other math utility functions as they are newly added
-*/
-
 #define ceil_div(a, b)		(CEIL_DIV(a, b))
 
-static inline unsigned int ceil_mul(unsigned int a, unsigned int b)
-{
-	return CEIL_MUL(a, b);
-}
-
-static inline unsigned int ceil_mul2(unsigned int a, unsigned int b)
-{
-	return CEIL_MUL2(a, b);
-}
-
-static inline unsigned int ceil_shift(unsigned int a, unsigned int b)
-{
-	return CEIL_SHIFT(a, b);
-}
-
-static inline unsigned int ceil_shift_mul(unsigned int a, unsigned int b)
-{
-	return CEIL_SHIFT_MUL(a, b);
-}
-
-/* ISP2401 */
-static inline unsigned int round_half_down_div(unsigned int a, unsigned int b)
-{
-	return ROUND_HALF_DOWN_DIV(a, b);
-}
-
-/* ISP2401 */
-static inline unsigned int round_half_down_mul(unsigned int a, unsigned int b)
-{
-	return ROUND_HALF_DOWN_MUL(a, b);
-}
-
-/* @brief Next Power of Two
- *
- *  @param[in] unsigned number
- *
- *  @return next power of two
- *
- * This function rounds input to the nearest power of 2 (2^x)
- * towards infinity
- *
- * Input Range: 0 .. 2^(8*sizeof(int)-1)
- *
- * IF input is a power of 2
- *     out = in
- * OTHERWISE
- *     out = 2^(ceil(log2(in))
- *
- */
-
-static inline unsigned int ceil_pow2(unsigned int a)
-{
-	if (a == 0) {
-		return 1;
-	}
-	/* IF input is already a power of two*/
-	else if ((!((a) & ((a) - 1)))) {
-		return a;
-	} else {
-		unsigned int v = a;
-
-		v |= v >> 1;
-		v |= v >> 2;
-		v |= v >> 4;
-		v |= v >> 8;
-		v |= v >> 16;
-		return (v + 1);
-	}
-}
-
 #endif /* !defined(PIPE_GENERATION) */
 
 /*
diff --git a/drivers/staging/media/atomisp/pci/ia_css_3a.h b/drivers/staging/media/atomisp/pci/ia_css_3a.h
index 70cfc915cc56..506910dd5c18 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_3a.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_3a.h
@@ -20,6 +20,7 @@
  * This file contains types used for 3A statistics
  */
 
+#include <math_support.h>
 #include <type_support.h>
 #include "ia_css_types.h"
 #include "ia_css_err.h"
diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
index 9c9d9b9a453e..70132d955e9b 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
@@ -13,6 +13,8 @@
  * more details.
  */
 
+#include <linux/log2.h>
+
 #include "type_support.h"
 #include "math_support.h"
 #include "sh_css_defs.h"
@@ -137,9 +139,7 @@ ia_css_xnr3_encode(
     unsigned int size)
 {
 	int kernel_size = XNR_FILTER_SIZE;
-	/* The adjust factor is the next power of 2
-	   w.r.t. the kernel size*/
-	int adjust_factor = ceil_pow2(kernel_size);
+	int adjust_factor = roundup_pow_of_two(kernel_size);
 	s32 max_diff = (1 << (ISP_VEC_ELEMBITS - 1)) - 1;
 	s32 min_diff = -(1 << (ISP_VEC_ELEMBITS - 1));
 
diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index 130662f8e768..b0f904a5e442 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -43,8 +43,6 @@
 
 #include "assert_support.h"
 
-#define IMPLIES(a, b)           (!(a) || (b))   /* A => B */
-
 static struct ia_css_binary_xinfo *all_binaries; /* ISP binaries only (no SP) */
 static struct ia_css_binary_xinfo
 	*binary_infos[IA_CSS_BINARY_NUM_MODES] = { NULL, };
diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index 8f08df5c88cc..b90b5b330dfa 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -16,7 +16,9 @@
 #ifndef __SH_CSS_FRAC_H
 #define __SH_CSS_FRAC_H
 
-#include <math_support.h>
+#include <linux/minmax.h>
+
+#include "mamoiada_params.h"
 
 #define sISP_REG_BIT		      ISP_VEC_ELEMBITS
 #define uISP_REG_BIT		      ((unsigned int)(sISP_REG_BIT - 1))
-- 
2.43.0.rc1.1336.g36b5255a03ac


