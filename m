Return-Path: <linux-kernel+bounces-5474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589E818B10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8A41C2459C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E31CA92;
	Tue, 19 Dec 2023 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJHawXb3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC71CA81
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702999203; x=1734535203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WPUC94aeFkxTDRSMtq6zQgY3UiFBP1Ldi/bE9BU6ccY=;
  b=WJHawXb3StAQpWwzW6CgiZQHuHnhLGGuDPRvseV53GBdjyk415gr+iNQ
   61yUx8Ae0gohdngSw1T7WDrPa30zYZMOdm+Y7ExgcK8b/dz3rkii5qdnD
   bPIXp8v7tTuQKfxWV2cd1R5IIU2akamcCdnbyN+tViIsJUZNejgXBUvb7
   L2cUhCb91nB3iXnB/YBPVp7wKn2NneWRj3oD6KkO2qjYkKQ3wbBPOdN4t
   X6Gzad/8/2FKE0OIEzh76fb00sV2ayr4O/J2FF+zjnQRn7KhQvK+9Jh3C
   OolApd9yyEp5Hx8M/QTj7FUlRqQfO15uufoBs77M1js4/A2LYOCIkcMCU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2890856"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2890856"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="810266239"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="810266239"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2023 07:19:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E2C2623A; Tue, 19 Dec 2023 17:19:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/virtio: Spelling fixes
Date: Tue, 19 Dec 2023 17:19:55 +0200
Message-ID: <20231219151955.2477488-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While making a spelling mistake myself for `git grep kvalloc`
I found that the only file has such a typo. Fix it and update
to the standard de facto of how we refer to the functions.
Also spell usr-out as user-out, it seems this driver uses its
own terminology nobody else can decypher, make it more readable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 5c514946bbad..1c7c7f61a222 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -99,8 +99,8 @@ virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
 		return 0;
 
 	/*
-	 * kvalloc at first tries to allocate memory using kmalloc and
-	 * falls back to vmalloc only on failure. It also uses __GFP_NOWARN
+	 * kvmalloc() at first tries to allocate memory using kmalloc() and
+	 * falls back to vmalloc() only on failure. It also uses __GFP_NOWARN
 	 * internally for allocations larger than a page size, preventing
 	 * storm of KMSG warnings.
 	 */
@@ -529,7 +529,7 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_submit(&submit);
 
 	/*
-	 * Set up usr-out data after submitting the job to optimize
+	 * Set up user-out data after submitting the job to optimize
 	 * the job submission path.
 	 */
 	virtio_gpu_install_out_fence_fd(&submit);
-- 
2.43.0.rc1.1.gbec44491f096


