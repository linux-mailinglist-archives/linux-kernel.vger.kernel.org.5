Return-Path: <linux-kernel+bounces-74383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F885D346
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB38528871D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45D3D97F;
	Wed, 21 Feb 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FnOUId1D"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB563D39A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507106; cv=none; b=EUb0xZy4zIC/0EIrOAaynP8UrtAw85j6BErry96yl2hu1ifCX2+OctzbC18Pr6RAB5Ji9z4vGvluuQVHml6eBYIPPovIIpHNxo8ooM5E9gHJLzamXj8I0whXxBv/Thaj3YsbMvPrA+5hSWmlj+fQdt6wpMJnpOJNkCjFvpcWC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507106; c=relaxed/simple;
	bh=H60LSo+ZBPcO6OqcwW9qvKbRC/ecwKW5PD9SHfJakOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l60jUGeyFMEnlpv8j4QTKzq0Kt/vT1j7VZ8HjWU/8zpm4sFiLeoi1Enc0y9p4q59hXsSJo/bNNhsoTD2C+hMiujp3K9Wsuv4qhKnYUJI2VeKJTp1tY9e9qWTBovYwX+WkJu3GqbFNQG/ue5CzQcqHc2E4a86/XqatyDffht4wOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FnOUId1D; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507097; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jhEIWtVJuyuBjNM1WD3786nYKFFH4yuhOqLm6acwxvk=;
	b=FnOUId1D9ww83/hto0eRtxel3UULUflKpRg42/JWng/6qx7nrQmdT2psSfmHhUHZcQP00q+R1vAdhRnChCK+0+8GEWh7qVjDz7YgWSZZ6RtETFUlZ5Uml+JVLpEw16whwuKudJEFUYxPsOMp2a9fpxcIo1mIyq0yBD5lYTkLQc4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zMlgV_1708507094;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zMlgV_1708507094)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:18:16 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 3/8] dm vdo: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:29 +0800
Message-Id: <20240221091731.7007-6-jiapeng.chong@linux.alibaba.com>
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

drivers/md/dm-vdo/physical-zone.c:268: warning: expecting prototype for vdo_free_pbn_lock_pool(). Prototype was for free_pbn_lock_pool() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8275
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/physical-zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/physical-zone.c b/drivers/md/dm-vdo/physical-zone.c
index b80c4d3a9bde..14d502ea77c9 100644
--- a/drivers/md/dm-vdo/physical-zone.c
+++ b/drivers/md/dm-vdo/physical-zone.c
@@ -258,7 +258,7 @@ static int make_pbn_lock_pool(size_t capacity, struct pbn_lock_pool **pool_ptr)
 }
 
 /**
- * vdo_free_pbn_lock_pool() - Free a PBN lock pool.
+ * free_pbn_lock_pool() - Free a PBN lock pool.
  * @pool: The lock pool to free.
  *
  * This also frees all the PBN locks it allocated, so the caller must ensure that all locks have
-- 
2.20.1.7.g153144c


