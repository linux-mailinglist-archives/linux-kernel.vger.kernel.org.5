Return-Path: <linux-kernel+bounces-46855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F05B844619
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936EFB2FFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F312C52B;
	Wed, 31 Jan 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsa+OYMe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD612BF3F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720550; cv=none; b=Ee5bL8CKR8Aumqv826LLkZdVrViUyXOUoM39UP0fppw8odIbKH8zvTy8J3AkvsElnmITudMtOt+Eok+TnqhMMNFXCJibl7lIjTBH9CRH9tjBXlktVHUHE0L1HTwpz3Y1kUd98fzHzIwqWdz4MjkD+j65oJgRbBr0MbLw9Cgcz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720550; c=relaxed/simple;
	bh=fJuo9hQkoVtajH6JUANaiNyGUbG5vMkf+ZkVc6SPejU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMCuULqMQzuThlJAmICHQWOTXouhyEQpxV4h/1UQrfKe9WQtlt1Az1D5sjTLuFt0UkkTknBMcbUCp1DAZ4wHtt1OZ+tT88K56Et2+GNoV9ZYNkL4+zgknKUdOfSC+5nXgGH7rGK/m97u5slDQMjbCgIesGMP0n3lvJ1ejOs/Ows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsa+OYMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89984C43394;
	Wed, 31 Jan 2024 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720549;
	bh=fJuo9hQkoVtajH6JUANaiNyGUbG5vMkf+ZkVc6SPejU=;
	h=Date:From:To:Cc:Subject:From;
	b=Xsa+OYMeSWPM/YTaoZNcuIOOibVDINAHkV/QL9ig0+hQ4sUJIpT+jdlFKykbR5k66
	 ZkKczsCyVlZuv3+cfYtd8HnbV6Zez4aiZzsn5vT7aRtIXtepYM3xTBAZRoVkKoKo18
	 SsiUM4wq/U4HzCPu3rxU+9tIJDIrn/PHEvKmCLgWZT+Pwp+Rj0IjO8cfIOhl6H06O6
	 91//w8J5Q4m3iYIcrX3NDnSZKZxKMyjVXJ8UbIfjP4PJWGXi0t61LXPfjXN/RJhp0z
	 Hx235Uz2ZysxHg2QvETcBuLAANi6Jlvs7a+Gbe2p51Ayw2sfwjh3jFQp3Qx65Mgu1K
	 gycBmwPVMJTLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 29D6140441; Wed, 31 Jan 2024 14:02:27 -0300 (-03)
Date: Wed, 31 Jan 2024 14:02:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] perf tools headers: update the
 asm-generic/unaligned.h copy with the kernel sources
Message-ID: <Zbp9I7rmFj1Owhug@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

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

---

To pick up the changes in:

  1ab33c03145d0f6c ("asm-generic: make sparse happy with odd-sized put_unaligned_*()")

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/asm-generic/unaligned.h include/asm-generic/unaligned.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm-generic/unaligned.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index 2fd551915c2025ee..cdd2fd078027afc9 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -105,9 +105,9 @@ static inline u32 get_unaligned_le24(const void *p)
 
 static inline void __put_unaligned_be24(const u32 val, u8 *p)
 {
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be24(const u32 val, void *p)
@@ -117,9 +117,9 @@ static inline void put_unaligned_be24(const u32 val, void *p)
 
 static inline void __put_unaligned_le24(const u32 val, u8 *p)
 {
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
+	*p++ = val & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = (val >> 16) & 0xff;
 }
 
 static inline void put_unaligned_le24(const u32 val, void *p)
@@ -129,12 +129,12 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 
 static inline void __put_unaligned_be48(const u64 val, u8 *p)
 {
-	*p++ = val >> 40;
-	*p++ = val >> 32;
-	*p++ = val >> 24;
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be48(const u64 val, void *p)
-- 
2.43.0


