Return-Path: <linux-kernel+bounces-74380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA685D33D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955141F237A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7D3D55D;
	Wed, 21 Feb 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AlLDZCrU"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10063D547
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507090; cv=none; b=UKD68O5iZbVwcuVUjE4FNCQmgIPqWDaVpyUo0IWSn4uuvboec+/iUSPRZRXrSa163LBQoMmJVgETEvEw5r6ZhjlYxnJMLJDguIo2GluWuacn+BtjK3vZ/CBYTgWDi8RRjFANNIpFKocGW/jtTKJyCHG6InPIjqQxRaAsaSFBKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507090; c=relaxed/simple;
	bh=5Lxs48T8AxpFP98KzY19UdH25ICYzMJoceSfQD6LMiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7thyCpT7zIjVHsoqvrELFM3GAqdtAikgR6QLMBdDz1XbjRZFipU2mdYdL+Xx7phpyS5IcEKvvEYybBzL1fxglhRZTtlS4LF/K2yb3dKbm0TYp5ISSjKRXPrYDbffHAL4BrGQrUVvI2jhfM4dI3S4/s1moO74yNQHxKZY2FMN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AlLDZCrU; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507086; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hXTbZ/tv0rwC9GbkQStp8PP86sctTo9nhY1TiyFUbq4=;
	b=AlLDZCrUz7ZWNqnrRKr7QhYKZAilz7LWir1dUESAEE95MbLNW9NnDWUK6sYOCvwLIgMEuY/n4ACW/MKvwxfXTlAi248XVmR+If8+AxSvElK1KvfnxH8SoWk3IUKY0B/Hdybbn2vywsFe+f11DZbThouM2GrZQYreRPLarRm+fuQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zPi2h_1708507083;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zPi2h_1708507083)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:18:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 5/8] dm vdo: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:27 +0800
Message-Id: <20240221091731.7007-4-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
References: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/md/dm-vdo/encodings.c:1178: warning: expecting prototype for vdo_decode_component(). Prototype was for decode_vdo_component() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8277
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/encodings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/encodings.c b/drivers/md/dm-vdo/encodings.c
index 42ffd793deeb..f4fee2c1d656 100644
--- a/drivers/md/dm-vdo/encodings.c
+++ b/drivers/md/dm-vdo/encodings.c
@@ -1170,7 +1170,7 @@ static struct vdo_component unpack_vdo_component_41_0(struct packed_vdo_componen
 }
 
 /**
- * vdo_decode_component() - Decode the component data for the vdo itself out of the super block.
+ * decode_vdo_component() - Decode the component data for the vdo itself out of the super block.
  *
  * Return: VDO_SUCCESS or an error.
  */
-- 
2.20.1.7.g153144c


