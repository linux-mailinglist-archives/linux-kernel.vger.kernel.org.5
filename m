Return-Path: <linux-kernel+bounces-121053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B088E1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173371C2A1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E5E15EFB6;
	Wed, 27 Mar 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXtuaDvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264D15EFA4;
	Wed, 27 Mar 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541950; cv=none; b=e92quiHEmC2ThqDUKTk1JGmGbxRnKnc/o/VG7RmAU4eR/Zdht2m5/Pu4BwL9tjGeiDJeJ17M9QjbklHfQUEMb5ZahZp8xFlQgv9frTh+gTVe/9ODeRrYuFOwlGNhNnjSndG0eyOcRrwvu2Sv+JoAb2boap6W2o6bbGI9kgPodrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541950; c=relaxed/simple;
	bh=3iIJgjaxz5hyp6GyzwcCDnykSSDbFyfzNNvLW0alz44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gElPpz3gmuUeALNrHAC+rJRmjIOxS/rRjYEQuQM3GN0VnzBesLEBBvUFgcYuVqEViQXeB+uoHBdbmp6ReJGRG/4L5v5jmYawKMaCsKLte1KDGb8ddxUefOU2TBo50NA6pRnP9lwPsLhkFr/bMjNJlVS/NoaI9OXsKwvvLHDKFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXtuaDvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D681C433C7;
	Wed, 27 Mar 2024 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541950;
	bh=3iIJgjaxz5hyp6GyzwcCDnykSSDbFyfzNNvLW0alz44=;
	h=From:To:Cc:Subject:Date:From;
	b=nXtuaDvDCpvjOahKAMAtoLuWoWMSv5FqVKjw+oe0LxmcfeUaijbi5P/SxDrcBesC8
	 riATlAiyieAcov1zXCGFUoOYHuTg69eALwcVZ21NYtuKQwCWmdZlNgg6EjKACSy6r3
	 A6HJVt+ILEKKnSq/8m5fHDWZoEaKXpzZcuWDNe8SCEw/upAGJNVpr2dzYF93gwyMsa
	 MkvgPke32Is+XGTc9Fl7PSHKBQBhv8on9MkSGfOvgzCWZKRkdt5baE6ntQDYTwKtm2
	 qc5HIvBg4jl8eczd8QRQ/LGUP+dHAl4UwyRjhdO6vutnl8CxeOgANiuWAEK/FPJe9V
	 aJJcWGoIonRcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "virtio: reenable config if freezing device failed" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:08 -0400
Message-ID: <20240327121908.2834962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 310227f42882c52356b523e2f4e11690eebcd2ab Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 13 Feb 2024 14:54:25 +0100
Subject: [PATCH] virtio: reenable config if freezing device failed

Currently, we don't reenable the config if freezing the device failed.

For example, virtio-mem currently doesn't support suspend+resume, and
trying to freeze the device will always fail. Afterwards, the device
will no longer respond to resize requests, because it won't get notified
about config changes.

Let's fix this by re-enabling the config if freezing fails.

Fixes: 22b7050a024d ("virtio: defer config changed notifications")
Cc: <stable@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240213135425.795001-1-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b3513..f513ee21b1c18 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -510,8 +510,10 @@ int virtio_device_freeze(struct virtio_device *dev)
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
-		if (ret)
+		if (ret) {
+			virtio_config_enable(dev);
 			return ret;
+		}
 	}
 
 	if (dev->config->destroy_avq)
-- 
2.43.0





