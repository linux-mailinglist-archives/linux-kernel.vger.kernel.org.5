Return-Path: <linux-kernel+bounces-142274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467A8A29B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2C2836AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A762A02;
	Fri, 12 Apr 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BMi3DoLc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7053378;
	Fri, 12 Apr 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911411; cv=none; b=PsZfiwda4RpZaXGgq+SCZdPUgBJDs/5trAgAWADUrifZXWlV9c9I6BG+xJaxi3vnSJf9fCIBjieCo/aIf+fQoFvvKfzfp28TT8dGSKgOL/EyBLL64JjG5JIHQ7S83bhkxVvbvwHdv2Jj86TVpdTRh3RMdsehE1k6DywdUeo4a/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911411; c=relaxed/simple;
	bh=XLLxwOTa3tQ3ISUxUVT9CbxaZ2yDkfYTv7tVnzSV7YU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDAUD0FPRpOrOVSHbsq1TLMOej2WK0Z3qEfQvwjRxl8Sooa4BaHjMdeTFrroh5OHK/sNCMtu+wZWDt9X4AFuAyJ6WNODzvW0rWeWTIA+aAO5CnIJW66Emdr4PRsMOADmg7RrKWzlr3Td7jH9xthjGWkKfoEPDh54PaQ6zD2PoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BMi3DoLc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7bc68faf8a811eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jHEqw9CX7F4B20BaWp50RaqOd08fKHGUHPcZwH22cL8=;
	b=BMi3DoLcJ/kuscBxIPQw9KOF5egJ8YYAZ8tMNCmJrICpYwdid7AG46Dm8ECrQrdW5mVBVLBb5/ZSiOhY/DJX2fJQa7rdghzUffRE3lKB2iavtw3lBV+awPYV6kRd7NW83bTNk4vgwQQ84VR3E6CNK2ZUDLWG57E06tq1Dm9LB+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2ea2a19c-4d6b-43ca-9b56-dde2376464db,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:c392d5fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b7bc68faf8a811eeb8927bc1f75efef4-20240412
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <hao.qin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 818051881; Fri, 12 Apr 2024 16:43:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 16:43:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 16:43:18 +0800
From: Hao Qin <hao.qin@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Hao Qin <hao.qin@mediatek.com>
Subject: [PATCH] Bluetooth: btusb: mediatek: Add usb reset for firmware setup failure
Date: Fri, 12 Apr 2024 16:41:28 +0800
Message-ID: <20240412084128.24452-1-hao.qin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.461600-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sGpk9YSiEd5IhWCVBr+Ay98DCe/LOiZlC3fUZT83lbkENPi
	u9NSfhOYea+2R4F2ox/m2sRd5hAfQvm9WstcRwZxngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AHCttcwYNipX6hYR7f40RGparKy8U17xnr71TnEQ1lbWMAvK1rVMcxdDBtPVrlqt3BWXG
	vUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.461600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DEEDB11A550F2C3488F2A62C3699A130331335E8C69700B5B9B735E150EFFC022000:8

Add usb reset to recover BT device from a firmware setup failure,
it will restore the device to its original state and attempt setup
firmware again.

Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c0cc13adb47..c5aab361795e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3160,6 +3160,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 						btusb_mtk_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			btusb_stop_traffic(data);
+			usb_kill_anchored_urbs(&data->tx_anchor);
+			usb_queue_reset_device(data->intf);
 			return err;
 		}
 
-- 
2.18.0


