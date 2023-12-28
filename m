Return-Path: <linux-kernel+bounces-12381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC581F3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40305283F98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D56882D;
	Thu, 28 Dec 2023 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YoxALhq0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BBC8DB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bba50cd318so2958095b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727760; x=1704332560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e+fg9SOqP34XnXL5jU4pEY4/pq3fOIOqFLUTdc21ng=;
        b=YoxALhq02Fmi9ReMVGIwjahtKjVj6kNk3VeVBawkhoMXovbiHRalWXzlXLflUC8Zqn
         JpeusyL00ySE9yvPdsrxVIE1hGjtqCX/llVuL1kzfPw4BESGXG8FqkZvH+2WugiBjRQX
         f3GCQdgPimXgPXAUs2Axo1T0UtEdI3RvHDXUrXZp/uQqVGU6LFeOoLHr7MeYknBP6j5x
         LQXkfpyoS22w/KJoBgKwiBRPH7eYuBRxI1ExsXOvh9OiZzPfbGkIlDifX11sH1ZZM4YR
         TUq1cQSSZ4moblEiXv2rxwxSxysJtBfCpfWCSX46MhP3SJtTl4kn6frXlIqOjxPUgCI9
         tFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727760; x=1704332560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e+fg9SOqP34XnXL5jU4pEY4/pq3fOIOqFLUTdc21ng=;
        b=emxh7Y/vrCMk81dAc+V0duOZME1tsEUvb0d7jJNFTuZbzZfRxWkFQYA8WxlpKnkxw9
         Sh6DFruU2M9Jfe1kCmc/ime6kCKT/59UgmnbbAawULmEVQ9a7UqvdpGmDc1wp4BVsgnR
         vdimO03ulGmRJng7IjNiCJrpXN3QSqf8QgbJjv2V+sTdOPyFbj35UEwQBT2zC6K9SO7V
         lsmOSVEGsyp1xiN3EIsj3P4R3fZwuMdI63MIrBl3Aeefi3ezQaKQgCDJdCxxtGjYMsmo
         ywSKoD0mUnINI33GTjaCABi8osNYQELOYweu50LNmBvZaMGQbA8bde4D7yALfsuBjXHY
         cgKw==
X-Gm-Message-State: AOJu0YyB0++ToiDnPLjHIfF9KFZi2i41jossycAUN+DCq9uZVf4jHmFK
	WUHjMpEpK/1TFxa8zcjKyumNrmUu7ElZJw==
X-Google-Smtp-Source: AGHT+IFlBstkCmb/D17edCTs8sY4vteYMNaBpcxdbvjkI2D4UtEwweJgmB+5F+NfpsSlT4ktPGSvhA==
X-Received: by 2002:a05:6808:159d:b0:3bb:76ca:f143 with SMTP id t29-20020a056808159d00b003bb76caf143mr11199985oiw.54.1703727760626;
        Wed, 27 Dec 2023 17:42:40 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:40 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 14/14] selftests/fpu: Allow building on other architectures
Date: Wed, 27 Dec 2023 17:42:04 -0800
Message-ID: <20231228014220.3562640-15-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ARCH_HAS_KERNEL_FPU_SUPPORT provides a common way to compile
and run floating-point code, this test is no longer x86-specific.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 lib/Kconfig.debug   |  2 +-
 lib/Makefile        | 25 ++-----------------------
 lib/test_fpu_glue.c |  5 ++++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..4596100eeb14 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2918,7 +2918,7 @@ config TEST_FREE_PAGES
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86 && !KCOV_INSTRUMENT_ALL
+	depends on ARCH_HAS_KERNEL_FPU_SUPPORT && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
diff --git a/lib/Makefile b/lib/Makefile
index e7cbd54944a2..b9f28558c9bd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -109,31 +109,10 @@ CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
-#
-# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
-# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
-# get appended last to CFLAGS and thus override those previous compiler options.
-#
-FPU_CFLAGS := -msse -msse2
-ifdef CONFIG_CC_IS_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
-#
-# The "-msse" in the first argument is there so that the
-# -mpreferred-stack-boundary=3 build error:
-#
-#  -mpreferred-stack-boundary=3 is not between 4 and 12
-#
-# can be triggered. Otherwise gcc doesn't complain.
-FPU_CFLAGS += -mhard-float
-FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
-endif
-
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
 test_fpu-y := test_fpu_glue.o test_fpu_impl.o
-CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
+CFLAGS_test_fpu_impl.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index 85963d7be826..eef282a2715f 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
-#include <asm/fpu/api.h>
+#include <linux/fpu.h>
 
 #include "test_fpu.h"
 
@@ -38,6 +38,9 @@ static struct dentry *selftest_dir;
 
 static int __init test_fpu_init(void)
 {
+	if (!kernel_fpu_available())
+		return -EINVAL;
+
 	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
 	if (!selftest_dir)
 		return -ENOMEM;
-- 
2.42.0


