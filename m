Return-Path: <linux-kernel+bounces-47636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D1845087
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919641C2564F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B83BB4D;
	Thu,  1 Feb 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iiOYb/2Z"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F763BB2D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763184; cv=none; b=ME+Pw+utnEgSbuBkdycnz+IMrx7JoDiEWMeBWj6kxRiFcDsUE+PZOaY/Rf7lDBgkkHleY84ramiS4dXVOmWhwR8fDi7ZWmdv/lY7mSp3oY01Y5tmH2QXXLmLKAtsRH27j8xs7RL6oh/OprM74wrSo6aWEU4G9LPXlWIhgIae/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763184; c=relaxed/simple;
	bh=6Q4hZB342kOUQre0oOMFijkniStNxdrC30MbCD0CfqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9IE4TLuMakt5wPwsLvwtu0az9oJSgaZ7kxWgWmZigwrDECjB97qReH7fGHk38dy0eg3r2uNpy7uISIajTA1R6AxnpqG2mo8PSJBk2GFb/tVftLlWBLzzC1bqfwMFQzkHUCTLZPAmAC605MlksXQ86vOSeDDpulsM2sMFdEc49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iiOYb/2Z; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c4175196c0bd11ee9e680517dc993faa-20240201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bLgCShFq1WIC3Xl1kd4l8YHBBYLHXkqdRbA4uvGyyuA=;
	b=iiOYb/2ZPevhED8wObTiUgUTIi7YTMZcy0iMRL+9cmWRVOnUoT+GeLzDiPmmaGTf264Gbc2EQ6fuXqDQqq0CZlGfxmYgfIvB7HAN8B0Prktb8NX8HlTTN4AzpQMBUwjXdNMjMHJzhH5GatM2xniyuEWC6tKyg0r4kYbtjh0uZ6M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:e54dd109-452c-46b4-9121-1d364d53bb3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:2f027e83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c4175196c0bd11ee9e680517dc993faa-20240201
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 805437301; Thu, 01 Feb 2024 12:52:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Feb 2024 12:52:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Feb 2024 12:52:54 +0800
From: Pin-Chuan Liu <flash.liu@mediatek.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <cylen.yao@mediatek.com>, Pin-Chuan Liu
	<flash.liu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] firmware: arm_scmi: Avoid to call mbox_client_txdone on txdone_irq mode
Date: Thu, 1 Feb 2024 12:52:50 +0800
Message-ID: <20240201045253.14390-1-flash.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.938200-8.000000
X-TMASE-MatchedRID: V0b+0D6KeHB3VjVXh/TSj0+4wmL9kCTxsEf8CpnIYtnz+Z+5iD+iRb87
	jWxVKGOh6lVWmieuZwniU0wvQv0w64JrRWPc34Z+A9lly13c/gGy4iyjvVWTon5h6y4KCSJc3oz
	JRX7b4NnHBJlWHsfjZDhRWiGxovmInVURoFo9SBy5kfgtJfb41X0tCKdnhB589yM15V5aWpj6C0
	ePs7A07fhmFHnZFzVqsuEZvQp0J9pIfsylPBBktLaUERHa8u2NERrrPWZ/TB+IKiZao8KaJQeWS
	4msO1E5EoIaZ0cyok3N8/wCCOEm3aRHRNjz1UNJSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvr
	HlT8euJ0YHKn7N1oOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.938200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6840BBDB642849DB19F6FAED2D4AB1AD13039BD7662C89BC26B20A7DB8D9EFCA2000:8

On txdone_irq mode, tx_tick is done from mbox_chan_txdone.
Calling to mbox_client_txdone could get error message
and return directly, add a check to avoid this.

Signed-off-by: Pin-Chuan Liu <flash.liu@mediatek.com>
Change-Id: Iacbe0d36ef9cc16974c013c3e94c47dc79eae52b
---
 drivers/firmware/arm_scmi/mailbox.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index b8d470417e8f..f6fe801c2e34 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -275,7 +276,12 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 	 * Unfortunately, we have to kick the mailbox framework after we have
 	 * received our message.
 	 */
-	mbox_client_txdone(smbox->chan, ret);
+
+	/*
+	 * With txdone_irq mode, kick can be done by mbox_chan_txdone.
+	 */
+	if (!(smbox->chan->mbox->txdone_irq))
+		mbox_client_txdone(smbox->chan, ret);
 }
 
 static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
-- 
2.18.0


