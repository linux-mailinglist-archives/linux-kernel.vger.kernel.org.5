Return-Path: <linux-kernel+bounces-38722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89A83C4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445C7B218F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B97634E0;
	Thu, 25 Jan 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXrrbR/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC563414
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192888; cv=none; b=iul+GMNzhF7uI6uQFV6lZn0p/F0b5LvfBkRixoAQvcZj9JnNu4yuNIo44obswTR/rI8n4eojyagy4ikQLpXEyU38/LoJzfUfR0HXl1h379sRqIpOBBezg7FKS5ySdma0IW3h1TLt9zgBeNB6chcsJrCWko/NTKAS+GdWI9/YNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192888; c=relaxed/simple;
	bh=iPJKR2ahlCuH15QtcPi5dZ2G0gzOR5bBrxcXevu9pFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z1t2TBUDGX2QrCK3J3UTO94vj3GMS6wKO49a29lP3aMC1vdKle9csw8wddzvE5SL27iAgYN5QLvrtccHxmotm9phX1a3uOi5/OsISfDY94UVDY+bhkGzb3X3lBi1AG8Bz9fQVGo+kRy1incQyox6WkRNP579hqv/I3Qio4sVK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXrrbR/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4D6C433F1;
	Thu, 25 Jan 2024 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706192888;
	bh=iPJKR2ahlCuH15QtcPi5dZ2G0gzOR5bBrxcXevu9pFw=;
	h=Date:From:To:Cc:Subject:From;
	b=LXrrbR/JiOy+fzpX/QXPjTYXceRBsokqK+Ul+9fiYWtMjEdZVDtn3kkzIS6/X0Dtm
	 sVGJP1e4I4qXd1ZDn8OVypiORL6M6oIGqvZMuemkdI91puh/XM9L/LQyKJYwwrQsdR
	 tOcbQ5TUU3eneIBXdG621t5kRL1/EQApS0SSJLVkQBjrqGc9dGlEBDUggR3w4JFD/1
	 cOZR/Iri1oapEhYXbxFYlQ0zFOjTGef24GjQSSG7QfhUVE29CyFmb2TC+dAKKmvhOI
	 u3fkChoN1rAwrOUF6D5uAemZM1Is+AkhmBEYHwT2p0H19Kw8s7gRkjp9f+JTtBYRkI
	 9w3O7mYxkoKDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 41A15405B2; Thu, 25 Jan 2024 11:28:05 -0300 (-03)
Date: Thu, 25 Jan 2024 11:28:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync linux/fcntl.h with the
 kernel sources
Message-ID: <ZbJv9fGF_k2xXEdr@kernel.org>
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

To get the changes in:

  8a924db2d7b5eb69 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")

That don't add anything that is handled by existing hard coded tables or
table generation scripts.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fcntl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6c80f96049bd07d1..282e90aeb163c028 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -116,5 +116,8 @@
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+#if defined(__KERNEL__)
+#define AT_GETATTR_NOSEC	0x80000000
+#endif
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.43.0


