Return-Path: <linux-kernel+bounces-145335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B178E8A52F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB13B20F93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C7757F8;
	Mon, 15 Apr 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XXk9K6/F"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4E745D5;
	Mon, 15 Apr 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190775; cv=none; b=E1gcos8eMqY1/oXNNWWQUvwyf4Sh7CuMfFWKxamitwMzAzf0u3dLIBiSPvM+ZNVDCvekefMYRaQuz2jkRVcjIBbgpTWb61c0S3Aa8kpGCJ/u0ZYmt7cBMy4WbiUOIGh8LAT6SeeJoVYNMDgaMZ+KJZviTeKRe817jGZTPAkU2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190775; c=relaxed/simple;
	bh=6BzQB6CLS4ASIraoEBkh/ruYkzabwrZtv5X173YXAt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ev9RtEyHbM2rljf2SXlGuSnBaMzxioCyIRJv2ets07DEBjQYHaeOFK3374wwrMhle7ZRsc2UGMUYik4+O/CtIOY7TP5c4Fh/4+b9uFAUpxubS6Joj1BHK3oKZ91MZZmuvwqWauq2JhVZM3S9CkcMVRIR3vtCyrI8GwBAFNitCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XXk9K6/F; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b85b962fb3311ee935d6952f98a51a9-20240415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Empahh1LA4kKLGwNXsY1+G441qGIr7QQTJKxvE2AOa0=;
	b=XXk9K6/F9TNxWCe5lcF2GvfW3T4IQymZSgM+i0uy8shpwjBE7g/OZkoVymoAo8GHuBBnSLliVOjEj34ugH8qHg2CSkeaGvDSextCNgPeWTu+c1Si3uqnUCA3wWvqM4bggxAHLQCkNovmh+hDdGNC8sHBJlu4WWuHdsMbM1IeY8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:de930b22-dbbd-4732-ac59-0759ceda7941,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:66223386-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2b85b962fb3311ee935d6952f98a51a9-20240415
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <peter.tsao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 819638844; Mon, 15 Apr 2024 22:19:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Apr 2024 22:19:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Apr 2024 22:19:25 +0800
From: Peter Tsao <peter.tsao@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Tsao <peter.tsao@mediatek.com>
Subject: [PATCH] Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
Date: Mon, 15 Apr 2024 22:19:22 +0800
Message-ID: <20240415141922.25055-1-peter.tsao@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.318700-8.000000
X-TMASE-MatchedRID: v7/5pfRSD0mMkVxV9HfBrn49ofOf/kXdfiuvKi9huabXkQ/lfMrtA43q
	EYKsEnZOThbvLLI8RvOlEtDJyVR88h8TzIzimOwP0C1sQRfQzEHEQdG7H66TyND1NE3SaFLXMZb
	Uwr5BAc5L7aBQFdB+zLynh3zZcnrwMqQFpJEodmPzkbDo0dNc/VcswP2Un2zCoFzllQMzIvI5Q8
	yRDdtoFB9acifWZ5LsjofsMjQaxVwyYjbiqIQ3CsykhtyXcigD6rVdgBjDT2r1nXJavJVNag==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.318700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8E8907C081CAA517D0C61E6880FDC5FEA471B3C8955E2CE2DD78F57A438CD6722000:8
X-MTK: N

Because both MT7920 and MT7921 use the same chip ID.
We use the 8th bit of fw_flavor to distingush MT7920.
The original patch made a mistake to check whole fw_flavor,
that makes the condition both true (dev_id == 0x7961 && fw_flavor),
and makes MT7921 flow wrong.

In this patch, we correct the flow to get the 8th bit value for MT7920.
And the patch is verified pass with both MT7920 and MT7921.

Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c0cc13adb47..8bede0a33566 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3123,6 +3123,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
 			return err;
 		}
+		fw_flavor = (fw_flavor & 0x00000080) >> 7;
 	}
 
 	mediatek = hci_get_priv(hdev);
-- 
2.18.0


