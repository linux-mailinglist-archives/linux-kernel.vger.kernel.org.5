Return-Path: <linux-kernel+bounces-88127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75D86DDAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A4D284BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913369E18;
	Fri,  1 Mar 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DPiTcMdl"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA36A326
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283288; cv=none; b=JeECYVxoTe0ZaWWWHkuHyx+Iq+N8cydho0U/RFEeJk96ewfAYLzZs3FOL2jUVP62TF0wicaEGR1HTQrQxGvSRZvsaw6ag7GEFPcaqSaq+OCu4JG6POmsT3UceBINIndcbK5tOck9NL4ACzFVkUlkBHtaKfpt8OKK345WO+KAIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283288; c=relaxed/simple;
	bh=78R0hTFd1L1D+1TwAPXwdv5e5//ZSYxzJCbiOleQUrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfnLVSVnHi9/7EcAACpRBLHUCCgdPik4O7C3ogdds16enE37WZZuoYsF6sre4KpmGk7W+TA1vnEshE5x3L4o367RJzSf9zxyANy7iqp4TIlA+SBx4oXAasx3ijXXGzVZo3FFNH+3mPuEIGXj4Gxpmp75xxYQxUwONhG5xnqwEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DPiTcMdl; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709283283; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PMW1G5gR++CtOAeD29pBWv3v1d4NWeli+yzFyyvGrsg=;
	b=DPiTcMdlUctrzIEtRVwJhrqr5PrNyC1E4NZOkjmvnIXKkaEY0Z3IGChOs7Y5b954oKcJXM2ePNbPXa68KyJhvTaZM/+EAagDI0r8haGb4g0+dRlFxOgp83n1xmpwbxmm5QuCaq+mBQb+0bCTU4ZgzymuhX49nFKExXyQQ4Jxg5c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1azfxv_1709283281;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W1azfxv_1709283281)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 16:54:42 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: msakai@redhat.com,
	dm-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] dm vdo: Remove unneeded semicolon
Date: Fri,  1 Mar 2024 16:54:40 +0800
Message-Id: <20240301085440.64541-1-yang.lee@linux.alibaba.com>
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
 drivers/md/dm-vdo/block-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/block-map.c b/drivers/md/dm-vdo/block-map.c
index 42ec3a252e73..4389df8c9271 100644
--- a/drivers/md/dm-vdo/block-map.c
+++ b/drivers/md/dm-vdo/block-map.c
@@ -2707,7 +2707,7 @@ void vdo_traverse_forest(struct block_map *map, vdo_entry_callback_fn callback,
 
 		cursor->waiter.callback = launch_cursor;
 		acquire_vio_from_pool(cursors->pool, &cursor->waiter);
-	};
+	}
 }
 
 /**
-- 
2.20.1.7.g153144c


