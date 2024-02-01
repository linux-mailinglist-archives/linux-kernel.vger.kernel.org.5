Return-Path: <linux-kernel+bounces-47920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905848454AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7B286CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2715A4A1;
	Thu,  1 Feb 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YCiSTW1Y"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41B15A498
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781552; cv=none; b=dl6azFOFVIGFBg85aYo2Ye6msMJH1tQ97xCeqTuqBr6dBPco3a7+uk5lsnRxI5hVzjRXZFM7KIuaR81yJOYP9A4Z7tCfRgLLTKQkv3WFMF1YZXik7AtUBhnBhbDgrUZBmSu7at8ytPZLA+R+UX+JCjmfie6ru6GLupn4jmV5DOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781552; c=relaxed/simple;
	bh=0Py4q+pTOmqEv1tbTXSx6iTRN0wAURlDATZNMO9qr/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUTtHTDsb+sroNKz6PCoQwXpVLWxFeUSFgAgLddpsOSRutNk2rKnvKfyg8S7F4bYiE9C6UoxkgwouE8LnzlR5nuN0o9OoAqhThzOcKn7Rfpdl5GxiFBWWZwYyZO8dWPeZ50uryWpMrFzAKHpRqnE+Cghpn+6yTRn19JIk2CCUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YCiSTW1Y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 853e8c8ec0e811ee9e680517dc993faa-20240201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IV7dhqul9WvXyKJ2ZoYl348suTPEjJTKUrzYhGujRks=;
	b=YCiSTW1YR5WgUfsccaksI0OH8Bg4smHLY1RBb3EkzQVTX+CrdDB7eyIUsXUCfXwibT2/YyXM/zMMUL5UdsCvOT6xcaN5PpYdNHS/vWGv4jEAWIvy+64lWrBJfUZFRyy9h5+cvo/FBi5V0Y8Wz9KIG11casO10Qwvf1ONKgAgpu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:a80a9e6f-1e5a-4ff2-8fec-d4d2eef05944,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:f192e88e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 853e8c8ec0e811ee9e680517dc993faa-20240201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 763909255; Thu, 01 Feb 2024 17:58:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Feb 2024 17:58:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Feb 2024 17:58:57 +0800
From: Pin-Chuan Liu <flash.liu@mediatek.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <cylen.yao@mediatek.com>, Pin-Chuan Liu
	<flash.liu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone on txdone_irq mode
Date: Thu, 1 Feb 2024 17:57:52 +0800
Message-ID: <20240201095754.25374-1-flash.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.422700-8.000000
X-TMASE-MatchedRID: wpfAD6xEq/V3VjVXh/TSj0+4wmL9kCTxsEf8CpnIYtnz+Z+5iD+iRb87
	jWxVKGOh6lVWmieuZwnS1Xndr/786uHxFb2pjr4bsyNb+yeIRApCX8V1FiRRkt9RlPzeVuQQost
	SmZzTxtqmuE8sHNH+0VdTP5dw4GERGN63p9ap1YqTEgTE0DYkgNJ178I1tpklvQmfz7H+YLGjxY
	yRBa/qJcFwgTvxipFa9xS3mVzWUuCMx6OO8+QGvvp6VplSc3s0tpvpvul44/cJ0fmqU3YzVcLTD
	yr2YnVuSsYg+5kG385nseWfOBeyocaMMthp5d9Dfe0egsLORU77IUwzFKThe3mVKZusLp922v9O
	jYWA2uMMswg45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.422700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 35B1F35528FCD59015ED3E5BC9AED8B5A4809366F666BAE20EA5A4EB88B2D1CE2000:8

On txdone_irq mode, tx_tick is done from mbox_chan_txdone.
Calling to mbox_client_txdone could get error message
and return directly, add a check to avoid this.

Signed-off-by: Pin-Chuan Liu <flash.liu@mediatek.com>
---
V1 -> V2:
 - Remove Change-Id
 - Use single line comment
 
 drivers/firmware/arm_scmi/mailbox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index b8d470417e8f..d391463e3208 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -275,7 +276,10 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 	 * Unfortunately, we have to kick the mailbox framework after we have
 	 * received our message.
 	 */
-	mbox_client_txdone(smbox->chan, ret);
+
+	/* With txdone_irq mode, kick can be done by mbox_chan_txdone */
+	if (!(smbox->chan->mbox->txdone_irq))
+		mbox_client_txdone(smbox->chan, ret);
 }
 
 static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
-- 
2.18.0


