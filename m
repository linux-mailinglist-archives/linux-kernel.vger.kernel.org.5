Return-Path: <linux-kernel+bounces-4911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33C8183BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BFC1F251AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A314A90;
	Tue, 19 Dec 2023 08:45:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB414A98;
	Tue, 19 Dec 2023 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vyq7xj8_1702975548;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vyq7xj8_1702975548)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 16:45:50 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 05/10] net/smc: introduce virtual ISM device support feature
Date: Tue, 19 Dec 2023 16:45:31 +0800
Message-Id: <20231219084536.8158-6-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231219084536.8158-1-guwen@linux.alibaba.com>
References: <20231219084536.8158-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces virtual ISM device support feature to SMCv2.1 as the
first supplemental feature.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 95f56c712b0a..0dc722bf6055 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,9 +58,12 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
-#define SMC_FEATURE_MASK	0	/* bitmask of
-					 * supported supplemental features
-					 */
+enum smc_supplemental_features {
+	SMC_SPF_VIRT_ISM_DEV	= 0,
+};
+
+#define SMC_FEATURE_MASK \
+	(BIT(SMC_SPF_VIRT_ISM_DEV))
 
 struct smc_link_group;
 
-- 
2.32.0.3.g01195cf9f


