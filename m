Return-Path: <linux-kernel+bounces-120980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53688E12E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F8296E66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F995155A47;
	Wed, 27 Mar 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJd24pYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F56155A21;
	Wed, 27 Mar 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541752; cv=none; b=b9cCzCsZ4TJk56tDbvmYd/rBaxxq+DRx8pa1sU8svBt6HvRuOOuFNdVC5ipgu8knPAMZhnDAIs1gcMJbD8hp4+GMNcf3QRSKQOWexPoQ3Sx4H7ugjRNw0EY0Yan1DmhhR0BNHZ0JIs/amKAGFDqNJMFdWULWC7YLn+8w0cTDdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541752; c=relaxed/simple;
	bh=3+V2U7muuYuUHbgibQGFaEi7TgqiH0XZ5mLY9AXwdv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxuenpYxmMYjNlulUop7lwIi9ATpDd4J2Dire5ly9ZEiCLa8eMd2NtdlDoGo7HyZNlhmyBtKiODQEnUL8UIu3OsmoOQgPEQ1fqvtbwsI+yHpVyLEqibBkjZs+DORMJE0OKnwF2BYAHoUP+dngyZhCEKz1XavazBHWRDHWLKulr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJd24pYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E7C433F1;
	Wed, 27 Mar 2024 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541752;
	bh=3+V2U7muuYuUHbgibQGFaEi7TgqiH0XZ5mLY9AXwdv8=;
	h=From:To:Cc:Subject:Date:From;
	b=iJd24pYf16qof84a0RKFVR4FZ97cf2iRe2CmfoyHIPA3+JpHp/Xahb+pYvQXKIDe3
	 Zj5pp91mCu+Z/z7DZX+iYwjyUXy/wTd244Pa4UWRkE4+HI1uNK8HUX2UCS5WZr0u9/
	 3w/M2Gp8OOSRTpkuDRLISKBead6f0DMt4VySAfmpOxkVj4z3vAKb4h4Mk3Mqrd5zDS
	 6Ax2cF8IxxeyigI1jrD0KCTupePTGSdyOaD572km7P6XFVYaVP3rrHAHIhYY/AVqcu
	 j9pC8RPaXbuoFAE27yrBzQfw+lQjtxbNjkDwwLKdW0sCTqQywCKc/WW6W+smJmbfVy
	 9SmQPJ/tRqdhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "virtio: reenable config if freezing device failed" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:50 -0400
Message-ID: <20240327121550.2832232-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





