Return-Path: <linux-kernel+bounces-84397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA486A643
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3A01F2EF13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4263B3;
	Wed, 28 Feb 2024 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="se3mPeBI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AB2107;
	Wed, 28 Feb 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085653; cv=none; b=JEU+Ykrk98pUDp4+CyAH/DDl5tqcDooJnRHSLvCa/CRUJQpYiHYyrYXnp/geRkHNkYjUW4xOvOl5Z1Dsa+FjjI+YFc2nioVLdhtdNL8HTcHPhtgb96UK+nKgHkmMF5v9Lw57Oeu35XRwP3dd9Rgq53Xu/3W55YQga6H1toXTTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085653; c=relaxed/simple;
	bh=KxH+FSKqPnen96UL7oC2xIPLR9KE5bLwWqMqNe1vbh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ropg1tOCKwVZ/p+0Ngesf5efHlc7bw1t2eJCZvN0Py0g5yBpHrZOyaqt1kLE44cijDPj7GnVX8i9Tz6IJckYAeXPjyDiQZ/2ME9B7iAs8p6Q/akJ9BYOpozGEs7qlyyAP1rh23kykQMuHmM2e0lltKfXaW9f5/JyZh92vmpDquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=se3mPeBI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f72af6ad5dd11ee935d6952f98a51a9-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ps+ctjgSHlaJ48jdpOUAWUiCS3YICM9/AZhDjh4oT8Q=;
	b=se3mPeBIF+PqBgOAxPuFZkNwfjcE8pqrOpefA1S7oaRR6MrD2V8ghgdm6q36NWfIcH6M1qbuvQ3ihY2SEpCmf8RNdzt/CuKrST/mnsusTngh4tV+Fqf9UgAqrvQI12zPllEghGwV2Nx9h0D2KVGjIz+FaxxYNW2JBdGOWlqb/1I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:bcae47ab-630f-484c-8287-b5ed9edab26c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:95876484-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2f72af6ad5dd11ee935d6952f98a51a9-20240228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <qingliang.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 386241137; Wed, 28 Feb 2024 10:00:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 10:00:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 10:00:43 +0800
From: Qingliang Li <qingliang.li@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len
 Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Johan Hovold
	<johan+linaro@kernel.org>, Tony Lindgren <tony@atomide.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Qingliang Li <qingliang.li@mediatek.com>
Subject: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
Date: Wed, 28 Feb 2024 10:00:40 +0800
Message-ID: <20240228020040.25815-1-qingliang.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When driver registers the wake irq with reverse enable ordering,
the wake irq will be re-enabled when entering system suspend, triggering
an 'Unbalanced enable for IRQ xxx' warning. The wake irq will be
enabled in both dev_pm_enable_wake_irq_complete() and dev_pm_arm_wake_irq()

To fix this issue, complete the setting of WAKE_IRQ_DEDICATED_ENABLED flag
in dev_pm_enable_wake_irq_complete() to avoid redundant irq enablement.

Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>
---
 drivers/base/power/wakeirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 42171f766dcb..5a5a9e978e85 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -313,8 +313,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
 		return;
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
-	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
-- 
2.25.1


