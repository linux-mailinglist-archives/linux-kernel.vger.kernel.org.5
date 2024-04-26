Return-Path: <linux-kernel+bounces-160657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B081D8B40AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87421C21BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783321364;
	Fri, 26 Apr 2024 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGNjlAEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857FBE78
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162100; cv=none; b=Xc+K2aB3xeZ89EiFRGfbaK+u20SxpNdqBCOh4vdXfehL0HRLchrOgAiecnillp29WooYwApbMg7Q2C5YX25XH42BlTgiKTT0dn9EwW33Lq6vfE6RFyVCBKSEAqrriLo8Gc0cjYwM5eS9Xyy0wSPDzaAR2U+DLAGNwDSPTN7fHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162100; c=relaxed/simple;
	bh=xjMNrNPB7kIkZ/sHUTjQzZZhfD7eVZ74uMEluASL71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QJ74740zsh3bOStnxp0g/A2S19EGLtSEJ5NgdaPiTHViUNRbGD4uy8YbgLm2YL4PbshKYVeRKjcAPMD7mJmqc7Ey0WeEvRzEmT/+731BFKLq44Jk7PP1GOhbNrAEci21rk50qeZj0B1hMACoG3onVXwF2UGLqp4AseK66/qml8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGNjlAEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74255C113CD;
	Fri, 26 Apr 2024 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714162099;
	bh=xjMNrNPB7kIkZ/sHUTjQzZZhfD7eVZ74uMEluASL71Y=;
	h=Date:From:To:Cc:Subject:From;
	b=sGNjlAEr70RsCuM/Sh6SSjZ7Y66TES4uVrrda0yY8gab1fQsGWw4Q+RC3/n56i4X9
	 mAmmwqwXIv005VPRaKCbkhRKKDVjrbqZKKTvwkFZeX/4r2tzaWGuRvolMH8s0frSRH
	 a+V4LT2aEq+s6HUoxoNGEV6Y/aRH1EKIwRWVln7h7VxY2x+dDaOIQh/dD/eE09cbEJ
	 TGsxI9BxkdCiETdsg35pbiTmgBwcLpHu06y4k3XDAdV3lOfX/TpiHupLN/e9+mIPjx
	 wDvn/CkfEnqvkCWHwNQfoHPu1dPydNQhl/hmU9jkoDwX1vJcJOHQpWG+GBY2tlBsSU
	 XTTs86hGm/WGA==
Date: Fri, 26 Apr 2024 17:08:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1 fyi] tools headers: Synchronize linux/bits.h with the
 kernel sources
Message-ID: <ZiwJsFOBez0MS4r9@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

To pick up the changes in this cset:

   3c7a8e190bc58081 ("uapi: introduce uapi-friendly macros for GENMASK")

That just causes perf to rebuild. Its just some macros going to an uapi
header that we now have to grab a copy into tools/ as well.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/bits.h include/linux/bits.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h                   |  8 +-------
 tools/include/uapi/asm-generic/bitsperlong.h |  4 ++++
 tools/include/uapi/linux/bits.h              | 15 +++++++++++++++
 tools/perf/check-headers.sh                  |  1 +
 4 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 tools/include/uapi/linux/bits.h

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7c0cf5031abe8796..0eb24d21aac2142c 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <vdso/bits.h>
+#include <uapi/linux/bits.h>
 #include <asm/bitsperlong.h>
 
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
@@ -30,15 +31,8 @@
 #define GENMASK_INPUT_CHECK(h, l) 0
 #endif
 
-#define __GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-
-#define __GENMASK_ULL(h, l) \
-	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
diff --git a/tools/include/uapi/asm-generic/bitsperlong.h b/tools/include/uapi/asm-generic/bitsperlong.h
index 352cb81947b87697..fadb3f857f2855db 100644
--- a/tools/include/uapi/asm-generic/bitsperlong.h
+++ b/tools/include/uapi/asm-generic/bitsperlong.h
@@ -24,4 +24,8 @@
 #endif
 #endif
 
+#ifndef __BITS_PER_LONG_LONG
+#define __BITS_PER_LONG_LONG 64
+#endif
+
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/uapi/linux/bits.h b/tools/include/uapi/linux/bits.h
new file mode 100644
index 0000000000000000..3c2a101986a314f6
--- /dev/null
+++ b/tools/include/uapi/linux/bits.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* bits.h: Macros for dealing with bitmasks.  */
+
+#ifndef _UAPI_LINUX_BITS_H
+#define _UAPI_LINUX_BITS_H
+
+#define __GENMASK(h, l) \
+        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
+         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
+
+#define __GENMASK_ULL(h, l) \
+        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
+         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
+
+#endif /* _UAPI_LINUX_BITS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9c84fd0490707452..672421b858ac1a7f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -9,6 +9,7 @@ FILES=(
   "include/uapi/linux/const.h"
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
+  "include/uapi/linux/bits.h"
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fscrypt.h"
   "include/uapi/linux/kcmp.h"
-- 
2.44.0


