Return-Path: <linux-kernel+bounces-56255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCAE84C7F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8426F289939
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4B25566;
	Wed,  7 Feb 2024 09:51:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11823745;
	Wed,  7 Feb 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299516; cv=none; b=Xq5ml4e+ujkTrJy7F89j2UJoGQrozKUBjBnoO5yi3siocf8tQZwaoBwFn7M6kY3jFZ02E3LtLCoDHWCbHFkUwT3Zj6R8ES4wS8VSiNuUXaVr5S1+wvXB6pMdWBAlCvpUC9DmvnHLH5xr+rQTpmOa64NmoPZI/GOR8DZmGs8Xxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299516; c=relaxed/simple;
	bh=4kcjacRz2KskItIX69UOdtQkTulwWY4O5zrOTTU3cro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIbNu9FIDCxC+8iZuZmXUoBvVhIH3qszmOHHsSGXTm2pdPl8Y6xpcWBlgrewUH1q5y/VY+tR48lgFlWloKfEUygO6Yi+FCzKAvYyzsru9zzNETLlNEOu+69cEqBFwiVhmhqRumPjz7mQROlzE8wNR6htDO/5mMpnVJr09cG/D20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVFhh1zDDz1gydf;
	Wed,  7 Feb 2024 17:49:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id A15331402E1;
	Wed,  7 Feb 2024 17:51:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 17:51:52 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 3/3] crypto: hisilicon/qm - change function type to void
Date: Wed, 7 Feb 2024 17:51:01 +0800
Message-ID: <20240207095101.37280-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240207095101.37280-1-qianweili@huawei.com>
References: <20240207095101.37280-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)

The function qm_stop_qp_nolock() always return zero, so
function type is changed to void.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 38 ++++++++++-------------------------
 include/linux/hisi_acc_qm.h   |  2 +-
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 41dff28326f1..92f0a1d9b4a6 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2124,7 +2124,7 @@ static int qm_drain_qp(struct hisi_qp *qp)
 	return ret;
 }
 
-static int qm_stop_qp_nolock(struct hisi_qp *qp)
+static void qm_stop_qp_nolock(struct hisi_qp *qp)
 {
 	struct hisi_qm *qm = qp->qm;
 	struct device *dev = &qm->pdev->dev;
@@ -2138,7 +2138,7 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 	 */
 	if (atomic_read(&qp->qp_status.flags) != QP_START) {
 		qp->is_resetting = false;
-		return 0;
+		return;
 	}
 
 	atomic_set(&qp->qp_status.flags, QP_STOP);
@@ -2155,25 +2155,19 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 		qp_stop_fail_cb(qp);
 
 	dev_dbg(dev, "stop queue %u!", qp->qp_id);
-
-	return 0;
 }
 
 /**
  * hisi_qm_stop_qp() - Stop a qp in qm.
  * @qp: The qp we want to stop.
  *
- * This function is reverse of hisi_qm_start_qp. Return 0 if successful.
+ * This function is reverse of hisi_qm_start_qp.
  */
-int hisi_qm_stop_qp(struct hisi_qp *qp)
+void hisi_qm_stop_qp(struct hisi_qp *qp)
 {
-	int ret;
-
 	down_write(&qp->qm->qps_lock);
-	ret = qm_stop_qp_nolock(qp);
+	qm_stop_qp_nolock(qp);
 	up_write(&qp->qm->qps_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_stop_qp);
 
@@ -3120,25 +3114,18 @@ static int qm_restart(struct hisi_qm *qm)
 }
 
 /* Stop started qps in reset flow */
-static int qm_stop_started_qp(struct hisi_qm *qm)
+static void qm_stop_started_qp(struct hisi_qm *qm)
 {
-	struct device *dev = &qm->pdev->dev;
 	struct hisi_qp *qp;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < qm->qp_num; i++) {
 		qp = &qm->qp_array[i];
-		if (qp && atomic_read(&qp->qp_status.flags) == QP_START) {
+		if (atomic_read(&qp->qp_status.flags) == QP_START) {
 			qp->is_resetting = true;
-			ret = qm_stop_qp_nolock(qp);
-			if (ret < 0) {
-				dev_err(dev, "Failed to stop qp%d!\n", i);
-				return ret;
-			}
+			qm_stop_qp_nolock(qp);
 		}
 	}
-
-	return 0;
 }
 
 /**
@@ -3201,11 +3188,8 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 			}
 		}
 
-		ret = qm_stop_started_qp(qm);
-		if (ret < 0) {
-			dev_err(dev, "Failed to stop started qp!\n");
-			goto err_unlock;
-		}
+		qm_stop_started_qp(qm);
+
 		hisi_qm_set_hw_reset(qm, QM_RESET_STOP_RX_OFFSET);
 	}
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 2d14742ad729..9d7754ad5e9b 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -531,7 +531,7 @@ void hisi_qm_uninit(struct hisi_qm *qm);
 int hisi_qm_start(struct hisi_qm *qm);
 int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r);
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
-int hisi_qm_stop_qp(struct hisi_qp *qp);
+void hisi_qm_stop_qp(struct hisi_qp *qp);
 int hisi_qp_send(struct hisi_qp *qp, const void *msg);
 void hisi_qm_debug_init(struct hisi_qm *qm);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
-- 
2.33.0


