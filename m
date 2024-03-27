Return-Path: <linux-kernel+bounces-121136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D388E2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6721C27BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C20175CAD;
	Wed, 27 Mar 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elUUrKMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3E175C9C;
	Wed, 27 Mar 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542172; cv=none; b=pmJhdDcqvPadQfxh3IdUQc8A19wd3UDJpSCBx4uvsO/QhHHJloANajS32lOeQd5KlsGjwmxHlD/Xn77BDfJgBupgLeKEXDhacTUFzbNedpGnKQPOHXF+erFf9W7mxxiugwFfPy3x1XjCnBWJ8+Ol7CHQfes33DOtEhVIxfWnSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542172; c=relaxed/simple;
	bh=RR4sFtmaYHf077Rq0UYLUKWHmiXmerwtSgZ+nhI/z4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiQKHNQ7FJav/GwQcyzf+GcjfSBOnkQ3U85C5WN17g1cx476T8SjmTLEUScJz+/75o05h+l4SXUKE0ymGVmlyL/WOMu6VSbdXj7TzTTPqTckf65rs266ldHd6uqVPgBQOUb5jFzdMImg02un8JKUMxtV7Zc/s7oTm3yWh9u6b5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elUUrKMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC28BC433F1;
	Wed, 27 Mar 2024 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542172;
	bh=RR4sFtmaYHf077Rq0UYLUKWHmiXmerwtSgZ+nhI/z4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=elUUrKMCno96E5J4zXI9N6QlFZhnNmH0cC3XzRP8eSWtc96zeyBApHJuoBzcDEGuN
	 qDqOWHGsgi9Nc7wVyWJNEgZe54z6ktBNYa7gJrcWfhe5xGUAdhgH+6QxoNcD4/I1EH
	 4i4w6QQhaG/Gz9OWYO2BIOLWQwRK9dP8dBe9g561KQZT/tenE68hqZ1Hyf9hHaZhTP
	 Hhgms95vm17D8OCTSwqxoDveK28VMnnr0FolitZ4I+vqSeIm0DHek+BQsmvUMcS9Bb
	 XdFQ8FEZnaSNNPsheF3zBcEyJbp+ddD0l1jXhZBrEUjTpN9z2hD6TDsiXqgJ+76E6n
	 9V7GFLXUjemzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "virtio: reenable config if freezing device failed" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:50 -0400
Message-ID: <20240327122251.2838016-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





