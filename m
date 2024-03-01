Return-Path: <linux-kernel+bounces-88140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA986DDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242FC1C229F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBD6A331;
	Fri,  1 Mar 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F9+qbv0+"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B96A02B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283947; cv=none; b=tNYrHA8vgUlTa/s4o1IPSCnB5oiwjVYT3aSe9oLlq/Wt2TYhkF06vdXVOC310fwLb1ZyOaYvgGCG2Aiym01QuY5Ur+aKNTMPEO/JFd5Jf6c4CDUcQcdKvTFytI+7GjjfPEBiY9d+sh2pF0/NaKX2Cb0K+VK7XAVPsVa8ftdF9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283947; c=relaxed/simple;
	bh=U5iVKh2DqPJumH73ccnWqkHOyEiFbk8YFQuZs+yYvFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DReKWHiOGD2yEom/cm6CxFDqzYOukSHisvaayetxOnktD/xPUG/Lk3URUvWDOT0njIreufX77QITzLtV6kVHPjHKN+CW1d0ylqL84/ouOSbA7XIBtcXf2Zc4rH/d2CVxFvjtVC0ksuFaYFRSivh2TYw3gPti7RKFodUWgI5G6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F9+qbv0+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709283936; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Wnp0K/c2jn/Ld3sdKbW2JbmVvraHQoeDkcCCW9FRwWg=;
	b=F9+qbv0+390vXtt1LfCLMcays+5wxYZO/xRKF+0iX6z3WX1Vvr5a7w8ALbPpFvLjhlRxWfAPG4kbYvfaUa4cMq5UkRVpfaUfJ118cwtTtgUElK8idji/ZoUzhKFd+SqBH9cXIQSqM0viHojdpvYtCQGFCY7xj047XSjUJwrQG+k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1awj9j_1709283935;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W1awj9j_1709283935)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 17:05:36 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/2] drm/dp: Remove unneeded semicolon
Date: Fri,  1 Mar 2024 17:05:34 +0800
Message-Id: <20240301090535.87969-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the unnecessary semicolons at the end of the
for statements which cleans up the code and ensures consistency
with the rest of the kernel coding style.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index 120e0de674c1..479dd004f365 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1125,7 +1125,7 @@ static int allocate_tunnel_bw(struct drm_dp_tunnel *tunnel, int bw)
 		}
 
 		timeout = wait_woken(&wait, TASK_UNINTERRUPTIBLE, timeout);
-	};
+	}
 
 	remove_wait_queue(&mgr->bw_req_queue, &wait);
 
-- 
2.20.1.7.g153144c


