Return-Path: <linux-kernel+bounces-146319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D053B8A6378
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA5F1F223B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFE3C48E;
	Tue, 16 Apr 2024 06:11:42 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632A33998;
	Tue, 16 Apr 2024 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247901; cv=none; b=WneB4G8/arazeHyaPmvFB7VOjct4IVOml34wbHqMic3UcMDTG2tJusGaqileWhc4BIakl8/w8skJsIt3ma4T3227wjECEZVZQ7YnJTRXWm1zeALwN+4N92JgEgAyPtvCnQ987zttKE+rwjE7cY9YV77Jm5fcUTWqNLlfReU5NrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247901; c=relaxed/simple;
	bh=EImL0nCauG/8AWM6/BWahg48StPtp6jMYomfxnNQsjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjLL30vNtpIYcT57e9T0ho/Mc3CJjNvBwnOR87FuYekfXU8NFlWDc17nwzr0a1ycQ5WmRZGR6ec+pUBbLHFz+BaD0L7dJh8RMptngQ6u8VW7TO36R1/do2y9MHaiedjr2BChFAJRTbpGyAJj5F+LBnBi9XLqTNS5lJMcVEGSMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26C45200D21;
	Tue, 16 Apr 2024 08:11:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67CBB200D08;
	Tue, 16 Apr 2024 08:11:37 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3749F183AD16;
	Tue, 16 Apr 2024 14:11:35 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com,
	salim.chebbo@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Enable status prints for firmware download
Date: Tue, 16 Apr 2024 11:41:09 +0530
Message-Id: <20240416061109.894645-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This enables prints for firmware download which can help automation
tests to verify firmware download functionality.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0b93c2ff29e4..eb20a6544470 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -159,6 +159,7 @@ struct btnxpuart_dev {
 	u8 fw_name[MAX_FW_FILE_NAME_LEN];
 	u32 fw_dnld_v1_offset;
 	u32 fw_v1_sent_bytes;
+	u32 fw_dnld_v3_offset;
 	u32 fw_v3_offset_correction;
 	u32 fw_v1_expected_len;
 	u32 boot_reg_offset;
@@ -550,6 +551,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->fw_v1_sent_bytes = 0;
 	nxpdev->fw_v1_expected_len = HDR_LEN;
 	nxpdev->boot_reg_offset = 0;
+	nxpdev->fw_dnld_v3_offset = 0;
 	nxpdev->fw_v3_offset_correction = 0;
 	nxpdev->baudrate_changed = false;
 	nxpdev->timeout_changed = false;
@@ -565,7 +567,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
 	if (err == 0) {
-		bt_dev_err(hdev, "FW Download Timeout.");
+		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
+				nxpdev->fw_dnld_v1_offset ?
+				nxpdev->fw_dnld_v1_offset :
+				nxpdev->fw_dnld_v3_offset);
 		return -ETIMEDOUT;
 	}
 
@@ -693,7 +698,7 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
 	if (!strlen(nxpdev->fw_name)) {
 		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
 
-		bt_dev_dbg(hdev, "Request Firmware: %s", nxpdev->fw_name);
+		bt_dev_info(hdev, "Request Firmware: %s", nxpdev->fw_name);
 		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
 		if (err < 0) {
 			bt_dev_err(hdev, "Firmware file %s not found", nxpdev->fw_name);
@@ -781,7 +786,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!len) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
 			   nxpdev->fw->size);
 		if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
 			nxpdev->helper_downloaded = true;
@@ -934,7 +939,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (req->len == 0) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
 			   nxpdev->fw->size);
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
@@ -954,8 +959,9 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 	}
 
-	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data + offset -
-				nxpdev->fw_v3_offset_correction, len);
+	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
+				nxpdev->fw_dnld_v3_offset, len);
 
 free_skb:
 	kfree_skb(skb);
@@ -1037,7 +1043,7 @@ static int nxp_setup(struct hci_dev *hdev)
 		if (err < 0)
 			return err;
 	} else {
-		bt_dev_dbg(hdev, "FW already running.");
+		bt_dev_info(hdev, "FW already running.");
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
@@ -1253,8 +1259,10 @@ static int btnxpuart_close(struct hci_dev *hdev)
 	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
 	skb_queue_purge(&nxpdev->txq);
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (nxpdev->rx_skb) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
@@ -1269,8 +1277,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
 
 	cancel_work_sync(&nxpdev->tx_work);
 
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (nxpdev->rx_skb) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 
 	return 0;
 }
-- 
2.34.1


