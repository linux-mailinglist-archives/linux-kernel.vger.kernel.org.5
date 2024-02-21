Return-Path: <linux-kernel+bounces-74384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A085D347
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D90CB22AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746D3EA72;
	Wed, 21 Feb 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UGGDDMcT"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FD3D3B7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507109; cv=none; b=E8dECUhFYDejSn939sR59qt99wZUhCqs4w+jJNOEJpXPxpedojTgA5duFKCaxrjFRohvfbzgkuJcXPd5AeOPKgbGNBAXoyxePEdIy7UANC2coixM3BYy9RwDRauez06naP9YusUJeN4Y02LjaTn2hhEkaq38rrgwnWomljTP6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507109; c=relaxed/simple;
	bh=s5Ar4vI5lLQtBQqGzgo6ThJUBQ344s5u3LIjan6VKCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVKRCkPKE9f2Ss7wx4GyEAvxXFnUcmaNm0KJAF0uqHhxdz7YpJDU4kaPNqpSkk1R3zZ6x0tT2xQKF8NP3H2oxJUQaHOed45OvSd8sHLDiXUVwQkgONOhdUUNLia4bFwljfBpI04NbEprz/efKcWYRiG2NnNJf4ck+MMkpxEJ/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UGGDDMcT; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507104; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aWlWYGeIVfNjQJkD0X6fpox0R6hzsKqtP6ziZ2TScy8=;
	b=UGGDDMcTEXf5zNgOecyuPf4oXWbZrE6ci991Q47NiNmhinQwNCsnuzdVYZ/XnFiKX5ZGfGunC2JvPVc0FVC1A11m8a8ot6yQ27K9k2t5Z6ssebnZgE3W/sg3A5FYHQ6gZlWdL1jnZYKyOVoMOq/2zDYP0+fg2H0q7lvI3TpOruY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zUqTx_1708507102;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zUqTx_1708507102)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:18:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/8] dm vdo: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:31 +0800
Message-Id: <20240221091731.7007-8-jiapeng.chong@linux.alibaba.com>
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

drivers/md/dm-vdo/vdo.c:276: warning: expecting prototype for vdo_read_geometry_block(). Prototype was for read_geometry_block() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8273
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/vdo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/vdo.c b/drivers/md/dm-vdo/vdo.c
index 23a4f1d1b6dc..411c58341173 100644
--- a/drivers/md/dm-vdo/vdo.c
+++ b/drivers/md/dm-vdo/vdo.c
@@ -266,7 +266,7 @@ static int __must_check initialize_thread_config(struct thread_count_config coun
 }
 
 /**
- * vdo_read_geometry_block() - Synchronously read the geometry block from a vdo's underlying block
+ * read_geometry_block() - Synchronously read the geometry block from a vdo's underlying block
  *                             device.
  * @vdo: The vdo whose geometry is to be read.
  *
-- 
2.20.1.7.g153144c


