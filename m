Return-Path: <linux-kernel+bounces-142446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608528A2BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD7E2842A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FD52F9B;
	Fri, 12 Apr 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mTABdcWw"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1C4E1D5;
	Fri, 12 Apr 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915874; cv=none; b=q+K9dCfKTvMV87G8g7IlQJZER5960A6EUFuCsQmnSji/p3t5cKT4SZ6kqhUP1owgeETjSTb/Ux9aRCeLU6pZ6En+DgBTTRSmLgb593tKGR5Ua4QGiQkaOx/M0CBK9k/D9xXKRUuhdcalR7qRfomTGJ+1XNKflXrCjD4swemA0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915874; c=relaxed/simple;
	bh=Eomhfdpz11TIl+lDu7WtwjHUKHjwxYWVqWq54Eah4SU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvyFpBUoNIK+G7H9iQyCQzowyhmI/JPLDiN49rEqZ8fFIIm4xr7oA/6lh6bq366svxPxVAPd4PtwbqGWVwsTIFwNz4g2BEutNZCpwDWZComlKg27EAKfv9FBNkkdR7vOanDo2YxpGRGfzpvLDEOLEo5o3ClFRbynqwaQn+jrU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mTABdcWw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1900167af8b311ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GUoxGu/XV4yejGo4HwhwIzs325AikFIy+EyTK0tIl50=;
	b=mTABdcWwzlZXXTNaefgwDATRhpvn5aXW7RxaOJ0cnlJCGAgO/WM+pqnCH+xb+VyndJm17OuSa4xRHxMLPuz7Zlj2QMeMblAoo9y04/bnQhkbqxi2WLWwXv+8ZfUaWpY2egXfmg8oum3sK2TNNVqK7ydTos+LrFg7TYhcNwjBe/s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4b9adb20-e422-468e-8ccb-5df8c34d53ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:efc38091-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1900167af8b311ee935d6952f98a51a9-20240412
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <hao.qin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 119018599; Fri, 12 Apr 2024 17:57:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 17:57:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 17:57:36 +0800
From: Hao Qin <hao.qin@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Hao Qin <hao.qin@mediatek.com>
Subject: [PATCH] Bluetooth: btusb: mediatek: Support auto revert for MT7922
Date: Fri, 12 Apr 2024 17:57:13 +0800
Message-ID: <20240412095713.25641-1-hao.qin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.149400-8.000000
X-TMASE-MatchedRID: uVuWzlu52Rmpk9YSiEd5IibMb0f5D0uqQl/FdRYkUZLfUZT83lbkEN6M
	yUV+2+DZYUXcHav/Rxk/Z/74EQY5HY9oUcx9VMLgFEUknJ/kEl7dB/CxWTRRuzBqYATSOgWjFdf
	36Pz24xgsw6pGLK+fcHBrphPcQbdOhnFBYfr+xvLDBirxwAorpCPx8YLfnf6LTrVhTMP/B9tuxo
	3gc6EQQpFHHnx2aRWzgITnGkK0NFNRskXKHhdfKpij9M86UwHhsKHfMTjCprzAgTvs8QFuaX7cG
	d19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.149400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 14D0662F09C9B987CEC4A61F7B7A086A01D0ABDA3FA2701977748C2005FC8B442000:8

Add support for auto reverting MT7922 during reset process.

Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c0cc13adb47..0ad96ec8d31d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3032,7 +3032,16 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	mediatek = hci_get_priv(hdev);
 
-	if (mediatek->dev_id == 0x7925) {
+	if (mediatek->dev_id == 0x7922) {
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= 0x00002020;
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= BIT(0);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		msleep(100);
+	} else if (mediatek->dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3072,6 +3081,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (err < 0)
 		bt_dev_err(hdev, "Reset timeout");
 
+	if (mediatek->dev_id == 0x7922)
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+
 	btusb_mtk_id_get(data, 0x70010200, &val);
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-- 
2.18.0


