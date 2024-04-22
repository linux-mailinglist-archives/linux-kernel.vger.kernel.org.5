Return-Path: <linux-kernel+bounces-153761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCE8AD2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B75E1F218B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D3153BDC;
	Mon, 22 Apr 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m33xNqrk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F3153BCA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805053; cv=none; b=taMM9ULAX40efOHc9HYz/5WZaBdKJMhAKvNcKcifxzjDuH+km64BDt2wNvvCFYCVsZceOZa5UuMqY2NyTW7lRW2SabnX0dOYF8v/wGgOCB+4BPiy+R3xPra8kX0ZdlVKTYsuocGCkyD3DXI7YNOLXuDbpvla3h8zEV2NNRVKHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805053; c=relaxed/simple;
	bh=ragIkYvpO+6Iglb+0EuocEpNgygN3dAoe6KG1ZdudLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hFF77WJ0m8DYPTG6pzjV8e3oKsRHi3ECkMS/mkrx6i4aUYjL3FRVf1X4GzkYFcnr0BmwAoTdekJl6annlHJAFf74VRqWPWkup3++kwKAifciiNvRAZdkTIRda0dWqXJON6beO8ApMuBPTJZayWH1DiAJfSqri8aqgzsUDqgWd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m33xNqrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABFEC113CC;
	Mon, 22 Apr 2024 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713805052;
	bh=ragIkYvpO+6Iglb+0EuocEpNgygN3dAoe6KG1ZdudLM=;
	h=Date:From:To:Cc:Subject:From;
	b=m33xNqrkri/0G6TN/1tQQtdpQBTyj0gq73TY7FOUV79URLi2ZKNPIAoAEKWcWT+rc
	 enxQ6OZHgNEqRGmbPB2TIQmAgXyTbWj0UucJ/l2u6SEqPN6AF3BOrkw3PHTV+htOeD
	 hD4uUgQSsQRuu9TBl4RPtqRdlCHY9zWU6GgYF/xHF6N6rxRepIwyX15Q0BQh7LZYej
	 yUmPwrFc7XMrEIFV6Ev4kb0T8wNSeMlmQoh2DwXhwPgRK2t52qvXVj6cQorLqU+irL
	 CvFMaSfbHnLuECWEYivSGcnbmeZo8gu/CXBXncadnujc72ttaE8z3lXVw5Y1TPe1/p
	 r2egxHX9VBBkg==
Date: Mon, 22 Apr 2024 13:57:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <ZiaW-csEZLKK48BE@x1>
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
Date: Fri, 14 Jul 2023 10:00:22 -0300
Subject: [PATCH 1/1] tools include UAPI: Sync linux/vhost.h with the kernel
 sources

To get the changes in:

  2855c2a7820bc819 ("vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE")
  1496c47065f9f841 ("vhost-vdpa: uapi to support reporting per vq size")

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/perf/trace/beauty/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2024-04-22 13:39:37.185674799 -0300
  +++ after	2024-04-22 13:39:52.043344784 -0300
  @@ -50,5 +50,6 @@
   	[0x7F] = "VDPA_GET_VRING_DESC_GROUP",
   	[0x80] = "VDPA_GET_VQS_COUNT",
   	[0x81] = "VDPA_GET_GROUP_NUM",
  +	[0x82] = "VDPA_GET_VRING_SIZE",
   	[0x8] = "NEW_WORKER",
   };
  $

For instance, see how those 'cmd' ioctl arguments get translated, now
VDPA_GET_VRING_SIZE will be as well:

  # perf trace -a -e ioctl --max-events=10
       0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
      21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
      25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
      25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
      25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
      25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffe4a22c840)       = 0
      32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffe4a22cf9c)         = 0
      42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
      42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
      42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
  #

This addresses this perf tools build warning:

  diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

But this specific process, usually boring, this time around caught a
problem, namely the addition of VDPA_GET_VRING_SIZE used an ioctl number
already taken, which went on unnoticed and only got caught when the
tools/perf/trace/beauty/vhost_virtio_ioctl.sh script was run as part of
the perf tools process of updating the tools copies of system headers it
uses for creating id->string tables that, well, broke the perf tools
build because there were multiple initializations in the strings table
for the 0x80 entry...

I'm adding here a link to the discussion, that is lacking in the fix for
the reported problem, and a quote from one of the developers involved:

"Thanks a lot for taking care of this! So given the header is actually
buggy pls hang on to this change until I merge the fix for the header
(you were CC'd on the patch).  It's great we have this redundancy which
allowed us to catch the bug in time, and many thanks to Namhyung Kim for
reporting the issue!"

This is here as a hint for anyone thinking about ways to automate
checking these issues in a more automated way... ;-)

Link: https://lore.kernel.org/lkml/ 20240402172151-mutt-send-email-mst@kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../trace/beauty/include/uapi/linux/vhost.h   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
index 649560c685f13b73..b95dd84eef2db231 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
@@ -179,12 +179,6 @@
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
-/* Get the count of all virtqueues */
-#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
-
-/* Get the number of virtqueue groups. */
-#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
-
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 
@@ -227,4 +221,18 @@
  */
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
+
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
+/* Get the queue size of a specific virtqueue.
+ * userspace set the vring index in vhost_vring_state.index
+ * kernel set the queue size in vhost_vring_state.num
+ */
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
+					      struct vhost_vring_state)
 #endif
-- 
2.44.0


