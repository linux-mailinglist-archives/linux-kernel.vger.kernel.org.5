Return-Path: <linux-kernel+bounces-159435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C648B2E97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412D11C22417
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C611876;
	Fri, 26 Apr 2024 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pdcMubts"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865A17EF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097552; cv=none; b=U0CfZvZBn/0s14rb09Ju//eKsCtvnQh5ByiQevycdk7t5Sv3fw36F65luNWMvYPe/TqugaFfEqd5KaHhMzUL9bLvu1+YrsPf6qFE8IF+f+oPtFk7bM5Kt92ewuN0zruR0aIneh3pZ0kk6Mn/4NAyDCId3uNwmEV4Sj8+7qb+MxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097552; c=relaxed/simple;
	bh=/cb+Yx4GDTjN9P4OtzCb600bLMu5/Scwqd+0UNWp8UA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PWV2oSUI2X+E+Dn1t/hyAb8iUNuziC6naZeFTTmhuYi2nl82UkinVP3aAlSSmL7fNEeuwBjWXNruL8zxeNFofMIwS3rQstRyEOdT4Hxuz+C5MJYqG4YZkNhwLrtes0BPVt5t+vz8/Zw6/mRTXrpR3nrK7GfV9hCtg2OZxKwF2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pdcMubts; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6b5206d0037211efa074750273bbc5f9-20240426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=j0QYK3u1tNscMJGC++pFg34wNNSwspyGoedC9JhFCgE=;
	b=pdcMubtsdvdgiL72wYu8ojGJJXagL8txoELFhlwmzYPNwhg82c4BmkHDhKmlpFCvr+0C5x0jzxbXDiFz6ZDD+78Y1LYOdC2SQOwfB62/Zj/42UJKuFBUqJJh06GxfJr8C66XP+rIMPreBmhCSCb3XvsqVGLZb4R/+a0O5eSOJCA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a7567bcf-c4d5-4e92-b3d0-9b799e5c1efc,IP:0,U
	RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:100
X-CID-META: VersionHash:82c5f88,CLOUDID:e19c5dfb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6b5206d0037211efa074750273bbc5f9-20240426
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1619398132; Fri, 26 Apr 2024 10:12:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Apr 2024 10:12:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Apr 2024 10:12:22 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] mailbox: mtk-cmdq: Fix pm_runtime_get_sync() warning in mbox shutdown
Date: Fri, 26 Apr 2024 10:01:21 +0800
Message-ID: <20240426020121.5273-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The return value of pm_runtime_get_sync() in cmdq_mbox_shutdown()
will return 1 when pm runtime state is active, and we don't want to
get the warning message in this case.

So we change the return value < 0 for WARN_ON().

Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ead2200f39ba..033aff11f87c 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -465,7 +465,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 
-	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev));
+	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev) < 0);
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
-- 
2.18.0


