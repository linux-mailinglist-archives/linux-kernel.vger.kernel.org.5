Return-Path: <linux-kernel+bounces-166162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA808B96F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD64F1C21BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6050A65;
	Thu,  2 May 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u+FsOxmF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A147A7A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640213; cv=none; b=Kk6Ca+yBEr/RefzUnwhOD0BnNQ9MqjmBgQOs5Mt0o3tyJbPoPnDLoIgfQdeLMHFvHx3AHxV3ovKlcqfooZdBmj86XbZ08D9VkYXPD/fZUzwauFTxEmIQBZjoctrdJ26+zwCgnQiS4yTwEqtUqbQAgfLcoSUoj157bqrDVF5UhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640213; c=relaxed/simple;
	bh=KYv593Y9tvOEPRgIJcKYCbyN/TKFJCLBDoXJppF5+3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFAE4Z3LYm2FMbVVkIdRs56/k5kjp+K3KFo3Cyv+b2W8otWc/1ZY+zzMLtEv5Kyj3mHIHctTjJj/Zu5Rpak4spz1aZhWCSpfsi6DfRqBatJIPk0/Uab+G1npdbZVj8pCID5n7Csgx8EJ7uI1ocQ3MaVzIM+YMnfofDrMOx+e//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u+FsOxmF; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e3675d7a086111efb92737409a0e9459-20240502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wa9ZFYyQyLg9Zk5bCCWMW/hFYEEEDVpBvBp/sui5nAM=;
	b=u+FsOxmFXXBL1NszHOPoyAYR0eCxncqHkwH+xgA9cN1rSHJtSoMtrrBAcQiAy5R6El3OcWZrgbM/doPMcV+Hrfi8aB/Z72D33iX/BrwXQpT22zq+I1B9+YLuh2tymn4cEb5hxjXDHx7t7y2ljCyGchrJE/Bd1MDrQAQ7lhktvgU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:472237c0-32d4-4cc4-a17c-777b9dbf11c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:09255d83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e3675d7a086111efb92737409a0e9459-20240502
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1666401368; Thu, 02 May 2024 16:56:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 May 2024 16:56:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 May 2024 16:56:37 +0800
From: gavin.liu <gavin.liu@mediatek.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Gavin Liu <gavin.liu@mediatek.com>
Subject: [PATCH v2] optee: add timeout value to optee_notif_wait() to support timeout
Date: Thu, 2 May 2024 16:56:36 +0800
Message-ID: <20240502085636.4049-1-gavin.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Gavin Liu <gavin.liu@mediatek.com>

Add timeout value to support self waking when timeout to avoid waiting
indefinitely.

Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
---
Change in v2:
Change commit message.
Add description for value[0].c in optee_rpc_cmd.h.
---
---
 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  2 +-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 05212842b0a5..d5e5c0645609 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
 	return false;
 }
 
-int optee_notif_wait(struct optee *optee, u_int key)
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
 {
 	unsigned long flags;
 	struct notif_entry *entry;
@@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
 	 * Unlock temporarily and wait for completion.
 	 */
 	spin_unlock_irqrestore(&optee->notif.lock, flags);
-	wait_for_completion(&entry->c);
+	if (timeout != 0) {
+		if (!wait_for_completion_timeout(&entry->c, timeout))
+			rc = -ETIMEDOUT;
+	} else {
+		wait_for_completion(&entry->c);
+	}
 	spin_lock_irqsave(&optee->notif.lock, flags);
 
 	list_del(&entry->link);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 7a5243c78b55..da990c4016ec 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -252,7 +252,7 @@ struct optee_call_ctx {
 
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
-int optee_notif_wait(struct optee *optee, u_int key);
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
 int optee_notif_send(struct optee *optee, u_int key);
 
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index f3f06e0994a7..99342aa66263 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -41,6 +41,7 @@
  * Waiting on notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_WAIT
  * [in]    value[0].b	    notification value
+ * [in]    value[0].c	    timeout in millisecond or 0 if no timeout
  *
  * Sending a synchronous notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_SEND
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index e69bc6380683..14e6246aaf05 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 static void handle_rpc_func_cmd_wq(struct optee *optee,
 				   struct optee_msg_arg *arg)
 {
+	int rc = 0;
+
 	if (arg->num_params != 1)
 		goto bad;
 
@@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 
 	switch (arg->params[0].u.value.a) {
 	case OPTEE_RPC_NOTIFICATION_WAIT:
-		if (optee_notif_wait(optee, arg->params[0].u.value.b))
+		rc = optee_notif_wait(optee, arg->params[0].u.value.b, arg->params[0].u.value.c);
+		if (rc)
 			goto bad;
 		break;
 	case OPTEE_RPC_NOTIFICATION_SEND:
@@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 	arg->ret = TEEC_SUCCESS;
 	return;
 bad:
-	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+	if (rc == -ETIMEDOUT)
+		arg->ret = TEEC_ERROR_BUSY;
+	else
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
 static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
-- 
2.18.0


