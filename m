Return-Path: <linux-kernel+bounces-154577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F708ADDD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53CC1C21483
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D758328DA5;
	Tue, 23 Apr 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FVfjMYUB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DF249F9;
	Tue, 23 Apr 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855145; cv=none; b=Zi910PbCtPThDcDc2wQI48BiFr3av0WWQZyxBuBorXIj/Oc/IT0UIreiXW7jBuTjXE0BdilKa70JljuoAotCMndE1WAmaqGdL4S4ZrDWbMaqfPe+ZfyC+OMLo/XvSmANOhv4y60XqQxk/J1NiSOOnu/SLC+ANLgHtbtG2Bmjyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855145; c=relaxed/simple;
	bh=o579Cxw/sp8xHQYsqy/NKx1Tc0oCDzCuTCkkz0nchBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S10Fsycwxh6s0wWUqHHR3N1+fM0mD12/GVAfBaK7QI7kQ67m62iVKLqQy3QpPOJv0dsKXwTcBc4jNtKfDBpsug65bXPoXf6u05+wE/HV5BnhcyMHSSWywZBz6aSxlbUOVsHWldWqaLnLcyJHkLAvT7KAhzSb/Ax3zyzwXfNKVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FVfjMYUB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 02bd25e0013e11efb8927bc1f75efef4-20240423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zrkWe29rhP94kO3XnHCfkKmTwNiUbSSm6wUwSZJTt9E=;
	b=FVfjMYUBTyVla+tQlqbNBbJXmdMfef9UMIzgP+sb/qhA/PBnSjdKE+NBzDE92r713M6H83mUrqEqLmtpTzS3L5o/5aSwiMf7KXTdRaACZdJxHykxxKCJMp/mR+B0jYzu/2MmYOhnAFFzpp/JUHA4G/NYvAMNwxdzTeUGoKsm29c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c97f03a2-8dc0-432b-b1ef-8b5a43866ca0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:bd498186-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 02bd25e0013e11efb8927bc1f75efef4-20240423
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jiande.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 844493470; Tue, 23 Apr 2024 14:52:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 Apr 2024 14:52:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 Apr 2024 14:52:08 +0800
From: Jiande Lu <jiande.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Jiande Lu <jiande.lu@mediatek.com>
Subject: [PATCH v5 1/2] Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925
Date: Tue, 23 Apr 2024 14:51:56 +0800
Message-ID: <20240423065157.21805-1-jiande.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.442500-8.000000
X-TMASE-MatchedRID: uvmf2XsR/xlys0UAwvp+/H/FQ8ROIWS/YIkZS8ssOk+X5kFNcJkaapKA
	TqwV9P4Dq/c368ICms7IseOXf9MGQ5ZXoz438mm14bl1FkKDELddymZBcuGGRLQ5t3EyiGrY+Vi
	hXqn9xLHBfR/WU+6YOH7qfk4HKEv/ngkd3GppwK2eAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8jHUU
	+U0ACZwNiK7R6PUcrTYdZRUDx7p/+PeHjMajdmf8SPjTpyHgBwnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.442500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CA512642E14D1550A7752DA36D6D478BC37B85D0D34389F3443B025801E6DCEC2000:8
X-MTK: N

Add HW IDs for wireless module specific to Acer/ASUS
notebook models to ensure proper recognition and functionality.
These HW IDs are extracted from Windows driver inf file.
Note some HW IDs without official drivers, still in testing phase.
Thus, we update module HW ID and test ensure consistent boot success.

Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8bede0a33566..550f7c775942 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -618,6 +618,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0e8d, 0x0608), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
@@ -664,11 +667,32 @@ static const struct usb_device_id quirks_table[] = {
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
+	{ USB_DEVICE(0x0489, 0xe113), .driver_info = BTUSB_MEDIATEK |
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


