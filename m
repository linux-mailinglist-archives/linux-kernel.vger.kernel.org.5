Return-Path: <linux-kernel+bounces-134803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B177589B72B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77386281E57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E7F9C1;
	Mon,  8 Apr 2024 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R/viG1f6"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F8847B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554283; cv=none; b=ZYoPp0zk6U7jMDmoCiN7pG2Gjn2ZXqwMwl67CSLbOyesNMeMFC8DXAByQzMatmFaTVhzqH5aJKL9TMV3CDx4dyMI7X2qjISA5rW964+EKuws3wE+sib+wvaValnxr8wH0HzTME2e2Kru2huyP2kS1BjQLfny9Ev5z1ANfswHgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554283; c=relaxed/simple;
	bh=BWKVL6zGIg10wgYYLFeXAKZ6T3J1vL90pE0rXWz6TBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H9i5KTXAisENYz81cMOTk65epJATjPwFLLh7KA37H6AeuXEkv2tDoGh5MwbIz8GTBU7gCxMG1w5pCAgo8Ab27OX6iFA/qscTxWUFIXSVYoRKF+YnPX5OApD/DYL6SGN9nK7/a65X+3mzl3bkNgFZikUFCJqPRCA5RIrYYAxc5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R/viG1f6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712554272; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xIqilud/SwRfW5dU91Smq2PXSnJK7EwpMfyG/QvdBpQ=;
	b=R/viG1f6JymFl5zSGsREst7DF9PVk5yimeZKTFa98yzdo8ev0Ukf6t8JGkIAmUM0O4AxtomOREzWarjjDdhkgHvSUSIhwjMKF0OZbb2X4VKOXVRLWlcolLasNgPxq63OSYHUKNLgE9SFU89SXwOwenhXtXmxHm6daBuVzfOuvTo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W42BNQ0_1712554271;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W42BNQ0_1712554271)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 13:31:11 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rdunlap@infradead.org,
	arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3 v2] powerpc: Fix kernel-doc comments in fsl_gtm.c
Date: Mon,  8 Apr 2024 13:31:08 +0800
Message-Id: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some function names in kernel-doc comments.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/sysdev/fsl_gtm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 39186ad6b3c3..3dabc9621810 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -77,7 +77,7 @@ struct gtm {
 static LIST_HEAD(gtms);
 
 /**
- * gtm_get_timer - request GTM timer to use it with the rest of GTM API
+ * gtm_get_timer16 - request GTM timer to use it with the rest of GTM API
  * Context:	non-IRQ
  *
  * This function reserves GTM timer for later use. It returns gtm_timer
@@ -110,7 +110,7 @@ struct gtm_timer *gtm_get_timer16(void)
 EXPORT_SYMBOL(gtm_get_timer16);
 
 /**
- * gtm_get_specific_timer - request specific GTM timer
+ * gtm_get_specific_timer16 - request specific GTM timer
  * @gtm:	specific GTM, pass here GTM's device_node->data
  * @timer:	specific timer number, Timer1 is 0.
  * Context:	non-IRQ
@@ -260,7 +260,7 @@ int gtm_set_timer16(struct gtm_timer *tmr, unsigned long usec, bool reload)
 EXPORT_SYMBOL(gtm_set_timer16);
 
 /**
- * gtm_set_exact_utimer16 - (re)set 16 bits timer
+ * gtm_set_exact_timer16 - (re)set 16 bits timer
  * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
  * @usec:	timer interval in microseconds
  * @reload:	if set, the timer will reset upon expiry rather than
-- 
2.20.1.7.g153144c


