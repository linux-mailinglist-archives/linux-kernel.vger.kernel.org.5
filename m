Return-Path: <linux-kernel+bounces-6222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DB819619
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CCC1F24DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4D5CBB;
	Wed, 20 Dec 2023 01:12:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A853B1;
	Wed, 20 Dec 2023 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VysF4Sy_1703034730;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VysF4Sy_1703034730)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 09:12:11 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: Larry.Finger@lwfinger.net,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH net-next] wifi: b43legacy: clean up some inconsistent indentings
Date: Wed, 20 Dec 2023 09:12:09 +0800
Message-Id: <20231220011209.127586-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/net/wireless/broadcom/b43legacy/dma.c:178 priority_to_txring() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7783
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/wireless/broadcom/b43legacy/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index 60e41de72f29..ea73c594d846 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -174,8 +174,8 @@ static struct b43legacy_dmaring *priority_to_txring(
 {
 	struct b43legacy_dmaring *ring;
 
-/*FIXME: For now we always run on TX-ring-1 */
-return dev->dma.tx_ring1;
+	/*FIXME: For now we always run on TX-ring-1 */
+	return dev->dma.tx_ring1;
 
 	/* 0 = highest priority */
 	switch (queue_priority) {
-- 
2.20.1.7.g153144c


