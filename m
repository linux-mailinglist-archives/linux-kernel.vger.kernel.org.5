Return-Path: <linux-kernel+bounces-129536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E123896C41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF791C21403
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6113667E;
	Wed,  3 Apr 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pfyP8OAC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF648138494;
	Wed,  3 Apr 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139976; cv=none; b=PsiqStTZoZ0gQFT0H9Vzu3PB+Bf1vqli1DLgYgz++GB5kXlJOhlvsTf/+D7jfaP6Z0go/eZBR43JyXl5TqcDQamOmPB5xMdfoqhdsf+Fr9r+Gu4Bfv7y/P0TYxJh6y96ssJvM0dSElpaPWm5TVYH9XCaYa5iQn8IsD2X0epQNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139976; c=relaxed/simple;
	bh=82GFhwetdwipZN/FOshRfsPsMpOh86e7yjW9wYIC5nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1n3q/58VDmLMKaKPGJgngWPrif+SeIIXwRWWXdCgR88AQ+ovw4QK/1PNjOODz5OMVGm/7smgKlsormvTSXDgONO1cOmsBTHL4azfrKhGgTH9CkedioGW+Akpmp+e8CwQTPL5IBq8ZFuKai+Pl/epDXYmqW7WidSAkZgPyCnudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pfyP8OAC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 948afa5af1a411eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+n0zKWsRkc7T3XIMGm9vfDccqDkOhBRSYTsTCO2DhZ0=;
	b=pfyP8OACElASiXg+hT0z5AOgc0aNb8ZMIdrtAf9lgQ8Lb/PHnc1Mxt8qtxgrWF9sMNJw6LMtq0IVbGbkMg3J596zCjbnE1YV7RHBqNYWeL0ocjfEEHiMA4fuDq3fPeLwskocCjD/5omjk/ynUzFgj1Ww6x/xooZ7iyTBuM7z/3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2ec37167-6182-40fd-a0ff-619b041d1861,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:886faa00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 948afa5af1a411eeb8927bc1f75efef4-20240403
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2061376987; Wed, 03 Apr 2024 18:26:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:26:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:26:05 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v5 09/10] mailbox: mediatek: Add secure CMDQ driver support for CMDQ driver
Date: Wed, 3 Apr 2024 18:26:01 +0800
Message-ID: <20240403102602.32155-10-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403102602.32155-1-shawn.sung@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.736600-8.000000
X-TMASE-MatchedRID: 8ytEwWiOUqMlen1U/pCyekKcYi5Qw/RVCt59Uh3p/NVZps+y1VXzqUY/
	auwRJnMLb1ikhugskqP8Qxx3otU4NgS+Xc7cwjX6A9lly13c/gGy4iyjvVWToslgi/vLS272sTA
	lYjdRdV71NEe6iuR2Lqx2oKSmYVP/ydSy/G+xHpKNCVVXBJuPJyhRWQHuJ8memIdt8XFDxCujxY
	yRBa/qJcFwgTvxipFajoczmuoPCq0J4NGAnmRP66kea7KunB1NH+ehIz6y+NgelHsQuY+j1Bk9R
	wcCrPEIrLtrh+vxIRaq0jvdyzToJRb6DSujyvwCS7Uplf7Nx8bBkGBTIlURuXoXDz8+lMxFpW+a
	IDJ4DaRzkxJ+SIkUjlAEm1wpw5h+lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.736600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	996E1AF9F37D4AFBC63BD05F1E171E93FD0C4A6D0E2BE9BF168B2E905F6B74AB2000:8
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

CMDQ driver will probe a secure CMDQ driver when has_sec flag
in platform data is true and its device node in dts has defined a
event id of CMDQ_SYNC_TOKEN_SEC_EOF.

Secure CMDQ driver support on mt8188 and mt8195 currently.
So add a has_secure flag to their driver data to probe it.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 69 +++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index e04302ca6ec03..a51140404d116 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -15,8 +15,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
+#include <linux/mailbox/mtk-cmdq-sec-mailbox.h>
 #include <linux/of.h>
-
 #define CMDQ_MBOX_AUTOSUSPEND_DELAY_MS	100
 
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
@@ -55,11 +55,19 @@
 #define CMDQ_JUMP_BY_OFFSET		0x10000000
 #define CMDQ_JUMP_BY_PA			0x10000001
 
+#define CMDQ_IS_SECURE_THREAD(idx, cmdq) (cmdq->pdata->has_secure && \
+					  idx >= cmdq->pdata->secure_thread_min && \
+					  idx < cmdq->pdata->secure_thread_min + \
+					  cmdq->pdata->secure_thread_nr)
+
 struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
 	bool control_by_sw;
 	bool sw_ddr_en;
+	bool has_secure;
+	u32 secure_thread_nr;
+	u32 secure_thread_min;
 	u32 gce_num;
 };
 
@@ -377,6 +385,13 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	if (ret < 0)
 		return ret;
 
+	if (CMDQ_IS_SECURE_THREAD(thread->idx, cmdq)) {
+		ret = cmdq_sec_mbox.ops->send_data(chan, data);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return ret;
+	}
+
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
 	if (!task) {
 		pm_runtime_put_autosuspend(cmdq->mbox.dev);
@@ -436,6 +451,12 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 
 static int cmdq_mbox_startup(struct mbox_chan *chan)
 {
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+
+	if (CMDQ_IS_SECURE_THREAD(thread->idx, cmdq))
+		cmdq_sec_mbox.ops->startup(chan);
+
 	return 0;
 }
 
@@ -448,6 +469,13 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 
 	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev));
 
+	if (CMDQ_IS_SECURE_THREAD(thread->idx, cmdq)) {
+		cmdq_sec_mbox.ops->shutdown(chan);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return;
+	}
+
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto done;
@@ -494,6 +522,13 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	if (ret < 0)
 		return ret;
 
+	if (CMDQ_IS_SECURE_THREAD(thread->idx, cmdq)) {
+		cmdq_sec_mbox.ops->flush(chan, timeout);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return 0;
+	}
+
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto out;
@@ -569,6 +604,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	int alias_id = 0;
 	static const char * const clk_name = "gce";
 	static const char * const clk_names[] = { "gce0", "gce1" };
+	u32 hwid = 0;
 
 	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
 	if (!cmdq)
@@ -594,6 +630,8 @@ static int cmdq_probe(struct platform_device *pdev)
 		dev, cmdq->base, cmdq->irq);
 
 	if (cmdq->pdata->gce_num > 1) {
+		hwid = of_alias_get_id(dev->of_node, clk_name);
+
 		for_each_child_of_node(phandle->parent, node) {
 			alias_id = of_alias_get_id(node, clk_name);
 			if (alias_id >= 0 && alias_id < cmdq->pdata->gce_num) {
@@ -643,6 +681,29 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
+	if (cmdq->pdata->has_secure) {
+		struct platform_device *cmdq_sec;
+		static struct gce_sec_plat sec_plat = {0};
+
+		if (of_property_read_u32_index(dev->of_node, "mediatek,gce-events", 0,
+					       &sec_plat.cmdq_event) == 0) {
+			sec_plat.mbox = &cmdq->mbox;
+			sec_plat.base = cmdq->base;
+			sec_plat.hwid = hwid;
+			sec_plat.secure_thread_nr = cmdq->pdata->secure_thread_nr;
+			sec_plat.secure_thread_min = cmdq->pdata->secure_thread_min;
+
+			cmdq_sec = platform_device_register_data(dev, "mtk-cmdq-sec",
+								 PLATFORM_DEVID_AUTO,
+								 &sec_plat,
+								 sizeof(sec_plat));
+			if (IS_ERR(cmdq_sec)) {
+				dev_err(dev, "failed to register platform_device mtk-cmdq-sec\n");
+				return PTR_ERR(cmdq_sec);
+			}
+		}
+	}
+
 	err = devm_mbox_controller_register(dev, &cmdq->mbox);
 	if (err < 0) {
 		dev_err(dev, "failed to register mailbox: %d\n", err);
@@ -719,6 +780,9 @@ static const struct gce_plat gce_plat_mt8188 = {
 	.thread_nr = 32,
 	.shift = 3,
 	.control_by_sw = true,
+	.has_secure = true,
+	.secure_thread_nr = 2,
+	.secure_thread_min = 8,
 	.gce_num = 2
 };
 
@@ -733,6 +797,9 @@ static const struct gce_plat gce_plat_mt8195 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = true,
+	.has_secure = true,
+	.secure_thread_nr = 2,
+	.secure_thread_min = 8,
 	.gce_num = 2
 };
 
-- 
2.18.0


