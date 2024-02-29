Return-Path: <linux-kernel+bounces-86693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368386C91B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5B61C22B35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D47D3F5;
	Thu, 29 Feb 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zLuFe7ZB"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511487D09C;
	Thu, 29 Feb 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209292; cv=none; b=nygQZAiRf+1bYbh+GMMLquRP7Xam6ZhExhwMdWfoO8iq00hwbcSkaHtUnmUOCsJIYQ6kAYJeGMQpZMIldXIOwETExn7b9+p3Vkiq1jmK9sdEaYwT+Mdvuf1pMqJHYMMEncUD7pHWfdaajTWgnWE+r4osAW5Ubu8Qi+trZtHYpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209292; c=relaxed/simple;
	bh=MSR7Gohd9L3H1wQbofEpvc+047GL8Hkx47b8e8xjZoY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NzfkbKSTcn4iK5II6bLSb+H6k/fMmy7EvVqAgUVpiK3d4OaGml+/bGFCfxKREkq9wR6V2XMEOzeS1HdRKLJr90E2OlfcFZTu7/kjiCpRUTh2vUB1Mzxcs/G/oHaYL2OS85nL1F8yVvR74qKstnK+quLg/VquC1BfSN3zl6VXBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zLuFe7ZB; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709209285; bh=dU9WJsM0VvFTwAl60XiV2GQzCopZDxedDmkKAu/mywc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zLuFe7ZBwRoc+faIla3ad/ExTAx0Rh69HtFTsevCtxonUZfXKzCraBpULdlD2ZnuM
	 vufO9Zuu8u395UWgYv2KYqOLAQMUc4zXFndLxnxSwvqDenqoDCcCk2b6+161C+1qwP
	 e58Bf2K2/QCi7uT+5IM6VwqPZeJFxWbCbUYpmSj4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5563B03A; Thu, 29 Feb 2024 20:21:22 +0800
X-QQ-mid: xmsmtpt1709209282tqirugosv
Message-ID: <tencent_70C492C20645C99DEEC9EED28C8E27D40606@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWfqDyLt8mHh4sepj+IqaTuKdCoCZQQq7B6VdFKCOOR22OzPvhGd+
	 erMlmfzNiaYFwG6RnrohRlmnnXXJcg2/QGgS5PTEFW73iYyAlwn4wUYK5xTPOK8NVQl85ytkFfmv
	 F2zOcs9pwq5GWnc63lkz6giUBIN8tcPGq3WRiV726ZWh49xWXT0CjNeyQHpUDLjep7cRxB8ll54o
	 vvLJdZ1uHJN+8Ioc8+t7XYacScvMf6pJ8bCwdUlyhJREF3RHJfTC9MnB0YIMS3yALCR3NE2RAn8y
	 QubRbWURu+/tFsCb7P/BigomPU8iJIbVZmsvW5818emUB9D9gyfLz14VyCfjX5zLV7cfj2wVqd9B
	 n/QpIgGAxLXWr0789SU+wPPMmJ8Pip4GyYmN8dcENXFDa4Gn2vZRfpTZzj83ehUaUrF7QdeH6/so
	 JLKConi+EZGAmDF4tiCAPR1eYdFLremb+U5Aa9Q6+hU3uwzMFNshcsriYhOWUp846YFkyck3SaHV
	 MZhjwu0sL5xQJNUK3RGE5wdybGy8hRXZf4bceHCpU95lVTwi8b0+6vKgzU4pLfXPwK9TytZ+U9ap
	 BvxEVlxKJFW6mD6j671tbXs1rRRgafNlQA/7rSDJOaESfAI4zmavVVOcFf4BXwCmDVADtHHe5Xuo
	 DFgdB7C8UET45g+oe5xGr2CW7a4FiSJ9AXHbe/FphXDdIqUaY1Ju1gDEd1yEB1I0oEYuQHQyj7To
	 h+nAalUaqbo3kt6iIX+rveWRprGGReBd0qJJ+BNiW+CrAi/WNIkT2QN7dLrIrg5WFkGaS6TEbyzs
	 fp4HTLQ0SJx9YGhrKrbhVfnfCRzpei1Z2MOTNawRf/tuCKzWX1xIXUZUseZWdhtZmKhZJn9TheHB
	 hqYXXjPpphy29mM3kkceIQCmI7j86WmoTgqlPjyiqo7KpIV30ja5g1J5aSeS9NWQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	syzkaller-bugs@googlegroups.com,
	tfiga@chromium.org
Subject: [PATCH] media: fix task hung in vb2_video_unregister_device
Date: Thu, 29 Feb 2024 20:21:22 +0800
X-OQ-MSGID: <20240229122122.978268-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008faf0a06126a0ffb@google.com>
References: <0000000000008faf0a06126a0ffb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vb2_video_unregister_device() will get vb2q_lock, so usbtv_video_free() does
not need vb2q_lock.

Reported-and-tested-by: syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 62a583040cd4..b55f432b44d4 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -963,7 +963,6 @@ int usbtv_video_init(struct usbtv *usbtv)
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
-	mutex_lock(&usbtv->vb2q_lock);
 	mutex_lock(&usbtv->v4l2_lock);
 
 	usbtv_stop(usbtv);
@@ -971,7 +970,6 @@ void usbtv_video_free(struct usbtv *usbtv)
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
 	mutex_unlock(&usbtv->v4l2_lock);
-	mutex_unlock(&usbtv->vb2q_lock);
 
 	v4l2_device_put(&usbtv->v4l2_dev);
 }
-- 
2.43.0


