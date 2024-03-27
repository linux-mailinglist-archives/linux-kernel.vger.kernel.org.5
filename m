Return-Path: <linux-kernel+bounces-121228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EB88E42B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB51C2B7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE218C9EE;
	Wed, 27 Mar 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlQTrvO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D841411ED;
	Wed, 27 Mar 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542405; cv=none; b=GKI1mlXwDMaBBmdiVu3lAt+q78tglIZakCACJ02oWr/xVMhP2fXye4tXOUy3uj5v0dgdu1x0o043Qgon7mnogQOqODjZlgG9VASSSKkl6Kdl0YT5mE9JQuq5uPxBzMYP7/7nCmr78OkO8Xq9dycJOOXnwT/3hwJr66i75vetmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542405; c=relaxed/simple;
	bh=GmeKlkNLUaS/w5sqHZUfTZPWxqKPVKXvoNIaWRL/jzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLwib6WkO7G2vLfHYp65BlCNnfWmzGG0ICLhD10bCiKaNgnq1rztWCfWD8WXBXUKjXUqwbry7YW8imBniHbZ7ptBV41+eN9qcqOJX2lp58UfDOO3X6P8Uzbnkhc7OLk2XQ4eFr8tqbHS8t15/KBjMyTb0Gv4iMIDFlm6ZbL/oA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlQTrvO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AE3C433C7;
	Wed, 27 Mar 2024 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542404;
	bh=GmeKlkNLUaS/w5sqHZUfTZPWxqKPVKXvoNIaWRL/jzA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZlQTrvO4GtcvMgBW8OMNzp6hJ+pBdJo6iCi9XRAytEOGcsrVK8jReCD37CQ2vgmaJ
	 Io6NyP5vpp+zyNnQb1TyryJzGmhcxVQGIJvsqLmWKj7/2XZKt27YEGjOKvIRm/Js7/
	 aB+ixxFpg40JQhOYI/d3qD8U/R4y97v+MOGEAUMJ/1rL6BW2Ho+zXAFqhdlad8KoDA
	 hFeFkYedQL5kTp0V7wj4OWflJy4TbEpdy07+8GAKAJ8XC9Z6cDsWKkJyvKerxb8Ujz
	 bs0aFmuNDscV7y/TwwhDIviXIZoP4JfkWDRu6B1ieyU70ut+ZQUjYGnCpyG45MbX/l
	 +sCOwV6pHQOKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "virtio: reenable config if freezing device failed" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:42 -0400
Message-ID: <20240327122643.2841302-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





