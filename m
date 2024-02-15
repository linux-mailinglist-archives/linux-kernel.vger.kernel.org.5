Return-Path: <linux-kernel+bounces-66196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D185586E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4362C1F26137
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD2211C;
	Thu, 15 Feb 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag2V3tuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903315D1;
	Thu, 15 Feb 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958204; cv=none; b=ravJYCQkEK+x9V4zYyVSAMIxlpQgneWgXPTVpHMIgoSypbf5hivSTy6tGoVICwYunlMLRtCvQGTJ1BItA3nCJQyN1l+3C47PB4Tre2EoMXqrihRNs6RBcyx+I/DFYPTgfBt8U+kV8/SYd2pCpIoWXJgwrWLfar1Hc9+kCDZV/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958204; c=relaxed/simple;
	bh=oUOUUVVZ6ZE4H6VaL1Zw1wSnRwLVun/8c8sWOEB2D/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0SUTkOf64dszpqc1WObep/mLRHShfVm7jUG2YHYd3uWXARAhWvd9rnk1mlHw0LPIU8mQSiWQg8bsaHCAK9ceC5dpATUYxYEOvMIimQvYI9/xVua77NGdBs2sxbA4CUaKRo7DYgDP79R86pBNxCCmW+c1PNVzZd95hg2TPzLZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag2V3tuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3283C433C7;
	Thu, 15 Feb 2024 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958203;
	bh=oUOUUVVZ6ZE4H6VaL1Zw1wSnRwLVun/8c8sWOEB2D/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ag2V3tuALPT3VgSFUAo0/klHrjQ1WrIxAcOnBaBzhTzZNXXmzIBi8I57TIRA+X+f6
	 DZ4WhHkUDXfc9y+xKp8iuiAK3VRfZoWcd5vdiBzBlxguWE/Mi1WBf06pLgdFHZXME5
	 fMdHBlzoNgRzeNGcbWJH305rIsF4lhWzo6GUAoT6ZLLZx1QMVxNeXCHSheR/LEieWj
	 qXowmJgTqmuADgl3uczYo9+kOUVGepiC+M2XGGG+ntsuCdgM4FOBy+KK5hHrebpFTE
	 MN1qK1AdRLMQkLsvVVljZAbgOfW8kiPU1MesybPiIgXTwXAqIA0YOZ+RMrrqIsHq1j
	 cpskpba95MXew==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 1/9] soc: mediatek: cmdq: Remove unused helper funciton
Date: Thu, 15 Feb 2024 00:49:23 +0000
Message-Id: <20240215004931.3808-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215004931.3808-1-chunkuang.hu@kernel.org>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmdq_pkt_create(), cmdq_pkt_destroy(), and cmdq_pkt_flush_async()
are not used by all client drivers (MediaTek drm driver and
MediaTek mdp3 driver), so remove them.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 59 --------------------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 40 -----------------
 2 files changed, 99 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..67e17974d1e6 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -105,50 +105,6 @@ void cmdq_mbox_destroy(struct cmdq_client *client)
 }
 EXPORT_SYMBOL(cmdq_mbox_destroy);
 
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
-{
-	struct cmdq_pkt *pkt;
-	struct device *dev;
-	dma_addr_t dma_addr;
-
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return ERR_PTR(-ENOMEM);
-	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-	pkt->buf_size = size;
-	pkt->cl = (void *)client;
-
-	dev = client->chan->mbox->dev;
-	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
-		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
-		kfree(pkt->va_base);
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	pkt->pa_base = dma_addr;
-
-	return pkt;
-}
-EXPORT_SYMBOL(cmdq_pkt_create);
-
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
-{
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
-			 DMA_TO_DEVICE);
-	kfree(pkt->va_base);
-	kfree(pkt);
-}
-EXPORT_SYMBOL(cmdq_pkt_destroy);
-
 static int cmdq_pkt_append_command(struct cmdq_pkt *pkt,
 				   struct cmdq_instruction inst)
 {
@@ -426,19 +382,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
-{
-	int err;
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	err = mbox_send_message(client->chan, pkt);
-	if (err < 0)
-		return err;
-	/* We can send next packet immediately, so just call txdone. */
-	mbox_client_txdone(client->chan, 0);
-
-	return 0;
-}
-EXPORT_SYMBOL(cmdq_pkt_flush_async);
-
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 649955d2cf5c..6c42d817d368 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -59,21 +59,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
  */
 void cmdq_mbox_destroy(struct cmdq_client *client);
 
-/**
- * cmdq_pkt_create() - create a CMDQ packet
- * @client:	the CMDQ mailbox client
- * @size:	required CMDQ buffer size
- *
- * Return: CMDQ packet pointer
- */
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size);
-
-/**
- * cmdq_pkt_destroy() - destroy the CMDQ packet
- * @pkt:	the CMDQ packet
- */
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
-
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
  * @pkt:	the CMDQ packet
@@ -266,19 +251,6 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
  */
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
 
-/**
- * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
- *                          packet and call back at the end of done packet
- * @pkt:	the CMDQ packet
- *
- * Return: 0 for success; else the error code is returned
- *
- * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
- * at the end of done packet. Note that this is an ASYNC function. When the
- * function returned, it may or may not be finished.
- */
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
-
 #else /* IS_ENABLED(CONFIG_MTK_CMDQ) */
 
 static inline int cmdq_dev_get_client_reg(struct device *dev,
@@ -294,13 +266,6 @@ static inline struct cmdq_client *cmdq_mbox_create(struct device *dev, int index
 
 static inline void cmdq_mbox_destroy(struct cmdq_client *client) { }
 
-static inline  struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline void cmdq_pkt_destroy(struct cmdq_pkt *pkt) { }
-
 static inline int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
 	return -ENOENT;
@@ -384,11 +349,6 @@ static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 	return -EINVAL;
 }
 
-static inline int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
-{
-	return -EINVAL;
-}
-
 #endif /* IS_ENABLED(CONFIG_MTK_CMDQ) */
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.34.1


