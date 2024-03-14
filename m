Return-Path: <linux-kernel+bounces-102727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6A87B699
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C140A1F21615
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B74A1B;
	Thu, 14 Mar 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ORCgY96V"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9C1362;
	Thu, 14 Mar 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384996; cv=none; b=Hw5ZZcLymqE1U5CM4GrikLituQQCNuuGsD31LDvVYy++SQ9TMoJwZlR0DczzwKnnS86jlQxpBVLmoWBnT78KLWP2H/R5bdedxeNvDKm26+pxY6vCaIDVrzhvhuJPiiL1kDtcQh3+qgnhadQ2joMYqJxWNGLvVrAWhEzQ4yxYbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384996; c=relaxed/simple;
	bh=P4L/R3Z6taJQ4cFhubaO8XQxOL25MaJ3X+jEbvQcZI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6s0F4yY6Ly0ESzncdLQdxCOHEs5Se+ePs7nrmxhfL8UlMHl84ZV02Obyr+jNfvX9HV7unpUys1UABORhy9EBRLizSBQS1xZyHk5eQd7Zf+vvYV68sfR9po+MNF/eEk+ktyIZmySxiGAYS58vtufR7VLJCEVk1FE9NGeptzRK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ORCgY96V; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710384984; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jdBOxt3A/EGAWmN/HaDrvWHJ81z6D/o/C6IFxVNk5vc=;
	b=ORCgY96VNWWMP9+gCpUgTWeehhQ9QAIz4dU0HcVjYxK8f8oP9FF0LrdS8bYnTGvD2F24CTlwH96t9l4HisfcwKabOY+oRXY9O8FTOoxxRtrkI5RlM47jFbBWtAXDiMQEc2cAC/m2fVdqxMl2ChLcNxIXpWb+E8dRHfAltbbk61w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2Qo4a7_1710384976;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W2Qo4a7_1710384976)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 10:56:24 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block: Modify mismatched function name
Date: Thu, 14 Mar 2024 10:56:15 +0800
Message-Id: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

block/blk-settings.c:281: warning: expecting prototype for queue_limits_commit_set(). Prototype was for queue_limits_set() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8539
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index e160d56e8eda..3c7d8d638ab5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -267,7 +267,7 @@ int queue_limits_commit_update(struct request_queue *q,
 EXPORT_SYMBOL_GPL(queue_limits_commit_update);
 
 /**
- * queue_limits_commit_set - apply queue limits to queue
+ * queue_limits_set - apply queue limits to queue
  * @q:		queue to update
  * @lim:	limits to apply
  *
-- 
2.20.1.7.g153144c


