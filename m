Return-Path: <linux-kernel+bounces-163568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7518B6D39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A74F1F21A17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D265128833;
	Tue, 30 Apr 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sxfTy8XJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB51C6615
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466385; cv=none; b=VMc3npfIV+esDTbsCyT8U8Kd+3B567/rJ97XShpGXJa8ZCGKWIP+xjBRTDwbFaMO5xlvNqdJgrHyvUJCTAWVgoG2ME8zqfbXLmyrMA53rofCBioN3J7jsXXd6QriwKxfAa8TEJ70qg/LCMhCkljyb8mdyvtA169i2oQb7zvH1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466385; c=relaxed/simple;
	bh=WWFnrSc8+9eCmftDNV7T5kPmDsgc2uC6sffBiuC6UVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMqYo9mT2ogwgOiwz6RClddxezoHl0aPLEHMRLvIwuXbCSp8gTAwR6gUADkOU8mTRoDYVqd3HU90NvAxQKL+caj0MXdrcglwkNv4cTcLP/YSG0A+j41knHzzgUcl30SgKXw4cXmb4RMDVvG5IklB2JXfi+UhdXmeOcf2Wj+b4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sxfTy8XJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d3d3e8806cd11ef8065b7b53f7091ad-20240430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LwZIKlQJP95UHeQU2CW1tpdwHn1XGE1fySMMHl57I3A=;
	b=sxfTy8XJ6m1N2aPEeXn/4HG8LP6QH265ngj+9Tz/nc9Anvjf/l3Y3Pfl4+YNIzHQrpQwkZjE0PfGt5ewJzbeIh6Pb0DoGdjGEO0b3oF6yqyRaLel9ZVFzc9ROXpk67MlBkbIlqCAa8rR4TqnCogautjY6J5J8ast7fjx7dqZEIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fc59f32b-2338-41c5-9c3b-2f1377258e9d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:498c4883-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d3d3e8806cd11ef8065b7b53f7091ad-20240430
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2099143406; Tue, 30 Apr 2024 16:39:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Apr 2024 16:39:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Apr 2024 16:39:35 +0800
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
Subject: [PATCH] mailbox: mtk-cmdq: Fix sleeping function called from invalid context
Date: Tue, 30 Apr 2024 16:39:34 +0800
Message-ID: <20240430083934.26980-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

When we run kernel with lockdebug option, we will get the BUG below:
[  106.692124] BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1164
[  106.692190] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3616, name: kworker/u17:3
[  106.692226] preempt_count: 1, expected: 0
[  106.692254] RCU nest depth: 0, expected: 0
[  106.692282] INFO: lockdep is turned off.
[  106.692306] irq event stamp: 0
[  106.692331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  106.692376] hardirqs last disabled at (0): [<ffffffee15d37fa0>] copy_process+0xc90/0x2ac0
[  106.692429] softirqs last  enabled at (0): [<ffffffee15d37fc4>] copy_process+0xcb4/0x2ac0
[  106.692473] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  106.692513] CPU: 1 PID: 3616 Comm: kworker/u17:3 Not tainted 6.1.87-lockdep-14133-g26e933aca785 #1 6839942e1cf34914b0a366137843dd2366f52aa9
[  106.692556] Hardware name: Google Ciri sku0/unprovisioned board (DT)
[  106.692586] Workqueue: imgsys_runner imgsys_runner_func
[  106.692638] Call trace:
[  106.692662]  dump_backtrace+0x100/0x120
[  106.692702]  show_stack+0x20/0x2c
[  106.692737]  dump_stack_lvl+0x84/0xb4
[  106.692775]  dump_stack+0x18/0x48
[  106.692809]  __might_resched+0x354/0x4c0
[  106.692847]  __might_sleep+0x98/0xe4
[  106.692883]  __pm_runtime_resume+0x70/0x124
[  106.692921]  cmdq_mbox_send_data+0xe4/0xb1c
[  106.692964]  msg_submit+0x194/0x2dc
[  106.693003]  mbox_send_message+0x190/0x330
[  106.693043]  imgsys_cmdq_sendtask+0x1618/0x2224
[  106.693082]  imgsys_runner_func+0xac/0x11c
[  106.693118]  process_one_work+0x638/0xf84
[  106.693158]  worker_thread+0x808/0xcd0
[  106.693196]  kthread+0x24c/0x324
[  106.693231]  ret_from_fork+0x10/0x20

We found that there is a spin_lock_irqsave protection in msg_submit()
of mailbox.c.
So when cmdq driver calls pm_runtime_get_sync() in cmdq_mbox_send_data(),
it will get this BUG report.

Add pm_runtime_irq_safe() to let pm_runtime callbacks is safe in atomic
context with interrupts disabled.

Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ead2200f39ba..3b4f19633c83 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -694,6 +694,7 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_irq_safe(dev);
 
 	return 0;
 }
-- 
2.18.0


