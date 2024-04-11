Return-Path: <linux-kernel+bounces-139817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74628A0812
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE41F2323D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748613CA97;
	Thu, 11 Apr 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OJUGkMZ9"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017613C3ED;
	Thu, 11 Apr 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815738; cv=none; b=by3NcM8kolbixA+6h1BRin761RyAOrMIQSTIYwyGzvd99Ct/SA4E80NtFWERDEkbOmvN300mFe0Jy+kHr+rDHf3eeI1RemWaGuIPcw+FgOFe4s2UXnm2KZAdMivYqEUS/V9e8x0yLTsPsSWhSn8XSRaBYgOMW42fW+NHq/th1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815738; c=relaxed/simple;
	bh=QbmXNVIqyQ2ZlJCV8a7l5AZ7J44So64DR4EpC/NGYYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H4yVaeKsNfixnjdOiZqLpMOCvOTEavsugPHZ03uMwrW90Fv9qucC1WlaZgeZQPJfv03LKyNn5L65P09s/FtyhjF4f/rMFOuMg7FQYkWXCwwqwQzSQj4jvgnK0uL/qb10TCfl1HLUOGCi9UwkVccLgMfmadDxa9X0+h2eAbVWyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OJUGkMZ9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f62912eef7c911eeb8927bc1f75efef4-20240411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ga3TmaCR+QbwuVUxYA9HS45MFs41MLMoazo01ttyQrk=;
	b=OJUGkMZ9stUM2lAuyGXZ46Ol3jfZOfor2mxxUNmHu/09GNEl+8nN6de34hU7JGYBTLOUAqGeQ+lQwR/oj5cPehY8NcUjMaSAeUb1/4QAj6ZuIqOCEDZxY8UAJsjEJ005widtNvetY25EhrXTwxgZsZUgUxbi33eAzqJnQU+2oZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4703c14e-b684-41a6-a48d-a5424fd32f4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:5b2ac8fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f62912eef7c911eeb8927bc1f75efef4-20240411
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jiande.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 263997264; Thu, 11 Apr 2024 14:08:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Apr 2024 14:08:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Apr 2024 14:08:42 +0800
From: Jiande Lu <jiande.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, jiande.lu <jiande.lu@mediatek.com>
Subject: [PATCH] Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925. These HWID are used for Windows NB. Enduser may install Ubuntu OS, so need to update.
Date: Thu, 11 Apr 2024 14:08:12 +0800
Message-ID: <20240411060812.16394-1-jiande.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.231300-8.000000
X-TMASE-MatchedRID: Mbsg4tszmKiZK6GTJ6A3n2QNT9IU7RXuDCe/LOiZlC3fUZT83lbkEJJo
	t8xOxyL5xxL5hQ2RIPj97HpZMOKDkZ4JHdxqacCtngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPI0PU
	0TdJoUteFR65PLLYX1dX8O8/xqUzoeQDkAZnDScBgOhdMvNG5PyvHtP1LJe3/K6M1Li+1xrqPvM
	XWFqtVhObT4dA8PYzCwuGYXBn5rdiOh+wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNPavWdc
	lq8lU1q
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.231300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D2BC39D7B8956AF6816C698B88283BEA417DAFAD7D83F7935C41DCEFBB59F6542000:8
X-MTK: N

From: "jiande.lu" <jiande.lu@mediatek.com>

Https://acer.com/tw-zh/support/product-support/SFE16-42/NX.KH5TA.0.01/downloads
---
 drivers/bluetooth/btusb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..67392b6c8f1b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -616,6 +616,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0e8d, 0x0608), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* MediaTek MT7922A Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |
@@ -657,11 +660,32 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3614), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3615), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional MediaTek MT7925 Bluetooth devices */
+	{ USB_DEVICE(0x0489, 0xE113), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.18.0


