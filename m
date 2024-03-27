Return-Path: <linux-kernel+bounces-120910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5A88E06A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537311C2959E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31314884E;
	Wed, 27 Mar 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaB3Rse6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74C148846;
	Wed, 27 Mar 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541559; cv=none; b=JyVgccYcMrq7qeTS1hX42nwZ4MMgIX1EKZH28tg2bpLeh1NM3OwR8X7VoZcNCwDt/P621JeAwHhrudEmpzQhqwsSAdi3Lmr2HIllquXMF7NoXNFnEbnfAzphETXEODmkZV3zwHUR+qO6O3H91Qx06bU0NqTyZnlH8NRza2gwC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541559; c=relaxed/simple;
	bh=rQqa4gFGje5o0Nx+uf3oSE19vibsgbu5qWy2pv0t+k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+VmngR5D7GPRtBjpQhHTbMsx3MPSS3dXIoq0JWmwCb4IwFlX8cjZ4B5ghm02rHS6kW1skjdMwUGu08054Ea8LiwqaO9mg3SWm4zzSehuUA35Q+6P6MIa6S05KkD4AoxQYc5qPCVuIeY9ljZIcAX+r++RZwywFYh+aH6PWRSCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaB3Rse6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B42C433F1;
	Wed, 27 Mar 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541558;
	bh=rQqa4gFGje5o0Nx+uf3oSE19vibsgbu5qWy2pv0t+k8=;
	h=From:To:Cc:Subject:Date:From;
	b=LaB3Rse6MRs36y0d+oQtVeCQYf2f4/0IVKclD8hNQ2GjIzd1R3on6i5xtFLgcq9h2
	 qIAYQ3Y7I5L/NByVnflSsqjPgIS4Anr1GclZ6/aTTyqQb+bnwSRHyNtHi0g252XzvC
	 naHFWd2fxFfcU7B3SyCqgR9dvAeIjKSSQahyD9FIC7lTuDh9gopuE+4CEOqOPODmXP
	 HwgICyNianTGA/Xa7im6ydjRTXLWjRo4PQ+pq1O9zuMJ9bkfD8yqK9p2J8zp/71b1B
	 AgjMru+ma+LKDGfYYxUCEYN9EsRsJ9TZAfVHZ6RC1xXCpaOYYQd80ehbMNbn95SXHV
	 Wgcgalz2UlZgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "virtio: reenable config if freezing device failed" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:36 -0400
Message-ID: <20240327121237.2829658-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





