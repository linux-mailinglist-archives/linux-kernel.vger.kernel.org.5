Return-Path: <linux-kernel+bounces-41194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75783ED39
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500D61C214CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F27C288A7;
	Sat, 27 Jan 2024 13:16:19 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193B2560B;
	Sat, 27 Jan 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361379; cv=none; b=UgzZndixzVq5n+CyAPG31hE0nfkZogVReHuUmX2oYu3xp4eaFVWUaPN6rUBmIF7E6LUo8HR04atlSqvSnEX68QtKUlQq+EjfEoPrOn0h0+D5mh/q++vNj2EQypfiX3mvS1jiuKeKFY3kBieNpfqa6yVbmLH5UlMdAYuS9C9FQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361379; c=relaxed/simple;
	bh=U6lH9CN0Q2WxhjhGTvU7bn7klHxhWsLGuoIwFS2rSUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCEBJ1eNclHEwPz07pPQl5ba1Gngfqbw29KV/HG2YH+65YAg3rFmGt/c7MokcWWVlVAJdhT6bRm2/Bd4yPnlNPHfg1m20uSbSaE3FAu6L+wwcwW9PsOuXnPqu9+ykVKONlw1967ksl9ETEehECk+gWVodDdlPoUXo0nqoqCmFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TMZmJ49SRzXgj9;
	Sat, 27 Jan 2024 21:14:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 8903E140153;
	Sat, 27 Jan 2024 21:16:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 21:16:13 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 3/3] crypto: hisilicon/qm - change function type to void
Date: Sat, 27 Jan 2024 21:15:30 +0800
Message-ID: <20240127131530.64617-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240127131530.64617-1-qianweili@huawei.com>
References: <20240127131530.64617-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)

The function hisi_qm_stop_qp() always returns zero, and no caller
checks the return value. So this function type is changed to void.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 36 ++++++++++-------------------------
 include/linux/hisi_acc_qm.h   |  2 +-
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 75d0b2ea117e..d1fe2de0faa7 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2118,7 +2118,7 @@ static int qm_drain_qp(struct hisi_qp *qp)
 	return ret;
 }
 
-static int qm_stop_qp_nolock(struct hisi_qp *qp)
+static void qm_stop_qp_nolock(struct hisi_qp *qp)
 {
 	struct hisi_qm *qm = qp->qm;
 	struct device *dev = &qm->pdev->dev;
@@ -2132,7 +2132,7 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 	 */
 	if (atomic_read(&qp->qp_status.flags) != QP_START) {
 		qp->is_resetting = false;
-		return 0;
+		return;
 	}
 
 	atomic_set(&qp->qp_status.flags, QP_STOP);
@@ -2149,8 +2149,6 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 		qp_stop_fail_cb(qp);
 
 	dev_dbg(dev, "stop queue %u!", qp->qp_id);
-
-	return 0;
 }
 
 /**
@@ -2159,15 +2157,11 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
  *
  * This function is reverse of hisi_qm_start_qp. Return 0 if successful.
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
 
@@ -3109,25 +3103,18 @@ static int qm_restart(struct hisi_qm *qm)
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
@@ -3190,11 +3177,8 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
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
index ec5a70ade511..3c755626ca54 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -539,7 +539,7 @@ void hisi_qm_uninit(struct hisi_qm *qm);
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


