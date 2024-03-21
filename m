Return-Path: <linux-kernel+bounces-110649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CE8861C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AED2853BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F4134CD4;
	Thu, 21 Mar 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prvsm2t8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B3132C1C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053717; cv=none; b=t3EGrqHYZsVZcBcN7V9oplDOBFteKR2oPxho2Nm3OIlO0oaJ2TgBN6wqCDH8rwEa+OBEKK0nNWckfeYHCltxmyg1dYWYVMgOmldYn5UuC6W9HKdb1qySrcVifX1n0+igZH5+M8KvxicCnlxdsmNsXFVFgvALG/xOl8heLNjiVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053717; c=relaxed/simple;
	bh=romOeRzE5Le7J+mTmXT8Q+Y/nqRqwZ0Vbk3UPuPptG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IimZYW+gKYwFqK+r3y2UUpXQ0vcrv1V0iaH1gE9ZBSygUVS3ujXvD97c1d5bocRL0JEFtj+FfxPW+0grrmximEMdyrCCftklIuHV9/AD2CwgRguqDkGdrMPCCrYAUomowIrL24HdYsk1llWPg2AUJf8x3IjGFCbcZ2RnkkOKCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prvsm2t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A5BC433C7;
	Thu, 21 Mar 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711053717;
	bh=romOeRzE5Le7J+mTmXT8Q+Y/nqRqwZ0Vbk3UPuPptG0=;
	h=Date:From:To:Cc:Subject:From;
	b=prvsm2t8EMZtFF1+AB3ZYBSWXIeC3teQcIEwZdjXju6bEPD+4CrMtCZ9ABcuhO1nG
	 xzNsP9XK6fBCMSMJcz6snQIs2V9GBCOVh63XDoDV5dnFNi3k8T7QZpJOW3FW93RVMt
	 ZaG3+HCGCSWjyUVmfxhhJy7SiqbwnPGe9znhTNoY32mx8ojfniuIG7ySoS6OnPAvEy
	 Cw39viBFi4aJaoldAp6nwEaScdmgrOaVsZDRDJI06hKgRAbW/jZjj9N3pLU3KYjTkG
	 fxiWE2jC1xqXNljn3CSYIFv15kXzUigk25fwRC1hckBTshsDku557nJ9s2nVplQ1Le
	 vnclLgLcdX5ZA==
Date: Thu, 21 Mar 2024 17:41:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH fyi 1/1] perf trace beauty: Sync linux/vhost.h with the
 kernel sources
Message-ID: <ZfybkuM8DKsdX_yO@x1>
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

To get the changes in:

  1496c47065f9f841 ("vhost-vdpa: uapi to support reporting per vq size")

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/perf/trace/beauty/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2024-03-21 17:33:58.878173388 -0300
  +++ after	2024-03-21 17:34:07.687563333 -0300
  @@ -49,6 +49,7 @@
   	[0x7B] = "VDPA_GET_VRING_GROUP",
   	[0x7F] = "VDPA_GET_VRING_DESC_GROUP",
   	[0x80] = "VDPA_GET_VQS_COUNT",
  +	[0x80] = "VDPA_GET_VRING_SIZE",
   	[0x81] = "VDPA_GET_GROUP_NUM",
   	[0x8] = "NEW_WORKER",
   };
  $

For instance, see how those 'cmd' ioctl arguments get translated, now
VDPA_GET_VRING_SIZE will be as well.

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

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/vhost.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
index 649560c685f13b73..bea6973906134656 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
@@ -227,4 +227,11 @@
  */
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
+
+/* Get the queue size of a specific virtqueue.
+ * userspace set the vring index in vhost_vring_state.index
+ * kernel set the queue size in vhost_vring_state.num
+ */
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+					      struct vhost_vring_state)
 #endif
-- 
2.44.0


