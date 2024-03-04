Return-Path: <linux-kernel+bounces-90756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F1870481
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21631C21147
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47245945;
	Mon,  4 Mar 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TQ0Kfnno"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD14BE4C;
	Mon,  4 Mar 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563737; cv=none; b=MP9UCcJvJWGDeLmCTSCPNj9YT83lEt/OFYtlZFsasW04+tg2u1poHr87pneAT4qMlrXetChYObmHZ8rPaCXsgXC6Vh+vTxxeGJxhzviARqBwZO3d65heO1gwqmJ5pxiuTdzieSLuvhPGLp3sMkvOlKddJMAn4W8+OB4TkVtp1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563737; c=relaxed/simple;
	bh=TgxXi/gIeKMpR66/mFlQ4SY+Nb0//zmHj5iPRrxLsSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8lPJTKXGWcMojrFWa96cSbZWUyO5ttCSRlRcpw2glMWeNXberEUV5lRXgkNfLGgvkAKPh/2F8AnORoq8lIc5MryuNBb3nIuE2dV34/axt73bVaM1haCiKlT/0h3pHiyGUKMstFaIz0UN/WKrm+CiVC7ThQlik3PgUbRu8idJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TQ0Kfnno; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5034d9beda3611eeb8927bc1f75efef4-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2ex3URhGJ25sIwQtcELaXnntnV6MtlBieKBk9AFSMU4=;
	b=TQ0KfnnoD/09XKNFRC/lBVhXABRz9vciAjkOOyofpDekXeXThM0DIWx9fk0+oEQ718l6c6lRqZlFfMzcpb11BPi8B6qvcuC8vXkjYZX31fdgkbVuAIXyJ0/3xMa5Hu8CvqLz1vEZ+LqqC5iFPzq6uy0LwwTzRbrdB9AeJeAuw1A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9936d3c0-59f3-4366-b7c5-02658c00a01e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:cd6d9884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5034d9beda3611eeb8927bc1f75efef4-20240304
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <peter.tsao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 887760762; Mon, 04 Mar 2024 22:48:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 22:48:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 22:48:48 +0800
From: Peter Tsao <peter.tsao@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Tsao <peter.tsao@mediatek.com>
Subject: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
Date: Mon, 4 Mar 2024 22:48:44 +0800
Message-ID: <20240304144844.2042-1-peter.tsao@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.048000-8.000000
X-TMASE-MatchedRID: AIneCDrHljXpHzzvfxlA9bCvlllU7Dl1jzwigoyOACR+YesuCgkiXFrN
	q+deGHNNEBd8LlX7xQH+drDB7ysG20fr6WG4Th9ah6L+ZkJhXC5CX8V1FiRRkt9RlPzeVuQQj3Q
	bFpHxze0b2iLBDKNZzdwU8VHXGipCHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWa2+sArfqKRjsrr
	DlOva601p4ExCflAw3kxMpQp+e7bKo+jfN2htJCEMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.048000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3B0F0103528A15B8EFAAF9D0E9492880D9625E15880BF383EDB174C927AE17392000:8
X-MTK: N

This patch is added support Mediatek MT7920
The firmware location of MT7920 will set to
/lib/firmware/mediatek/

The information in /sys/kernel/debug/usb/devices about MT7920U
Bluetooth device is listed as the below

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#= 12 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=7920 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
---
 drivers/bluetooth/btusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..ba6ac853110b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3088,7 +3088,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	int err, status;
 	u32 dev_id = 0;
 	char fw_bin_name[64];
-	u32 fw_version = 0;
+	u32 fw_version = 0, fw_flavor = 0;
 	u8 param;
 	struct btmediatek_data *mediatek;
 
@@ -3111,6 +3111,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
 			return err;
 		}
+		err = btusb_mtk_id_get(data, 0x70010020, &fw_flavor);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
+			return err;
+		}
 	}
 
 	mediatek = hci_get_priv(hdev);
@@ -3135,6 +3140,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 			snprintf(fw_bin_name, sizeof(fw_bin_name),
 				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 				 dev_id & 0xffff, dev_id & 0xffff, (fw_version & 0xff) + 1);
+		else if (dev_id == 0x7961 && fw_flavor)
+			snprintf(fw_bin_name, sizeof(fw_bin_name),
+				 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
+				 dev_id & 0xffff, (fw_version & 0xff) + 1);
 		else
 			snprintf(fw_bin_name, sizeof(fw_bin_name),
 				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-- 
2.18.0


