Return-Path: <linux-kernel+bounces-84613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CF86A907
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ADBB261D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6324B4A;
	Wed, 28 Feb 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hJrndjlc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898C24B2A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105577; cv=none; b=ltcvWFYRzUw4U4hVVhCeWkIdCcrNk/ElHyAYdq1uGS4dcJF4nUPpOb7jTl2esDChP7l72ZFbap7HrgXTs8CoUk4LojeJQ9blNAP76BWL6Eec9vPLNpUyzOkEToaMmUmgFCRYOEfjV6ECLcuQP3th67a8r30gjfw0C9OMCTydT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105577; c=relaxed/simple;
	bh=vl+E2NgRWiD419R8+gukB+VjWzYzUiNLeVzeFg6gGhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pu/MMwFCOKtrjF+Fky/wRhYe9BWEOxNuSABAeS2kgr4BUnn9ajO7AYv48mkhOWLnkq5o/VOdz7OOV1LkMFyjvmf/AIAfLbh2CJOLMfSGJMNBRq2oJaRb+ILn93aPikGvamsHiqUjFCDllJUc6GcvwQvSzQFMBx0N8gTTboDNwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hJrndjlc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9339f2c8d60b11eeb8927bc1f75efef4-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6ieR/zEKf2T/mkPnmZNu342qzL0+86b6tQM2bieJG+w=;
	b=hJrndjlcxOwhSNbn51R2sHlrwXVEWaoDbycUx1xyYTZ7xarHMqjYY+WCG8H2wYLy6lFaLxmw+Pjl7i7p3sT/Xk9rLhb7EWLxn+BKErd8rkdwoyXDBzvjarmQHQywu7qYPp/ydA9Gqj7X/OFk9t9zsS52rJi+HPkrKz6TbMPZxTw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d64a8808-8baa-4943-9d81-4f66098ce44f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6f543d0,CLOUDID:2ba2e680-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9339f2c8d60b11eeb8927bc1f75efef4-20240228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <haibo.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1119168673; Wed, 28 Feb 2024 15:32:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 15:32:49 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 15:32:49 +0800
From: Haibo Li <haibo.li@mediatek.com>
To: Russell King <linux@armlinux.org.uk>, Alexandre Mergnat
	<amergnat@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Haibo Li <haibo.li@mediatek.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>
Subject: [PATCH] ARM: unwind: fix unwind started from IRQ stack in THUMB2 kernel
Date: Wed, 28 Feb 2024 15:32:47 +0800
Message-ID: <20240228073247.13102-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

When unwinds started from IRQ stack,call_with_stack is the only
place to do stack switch.
It need to identify call_with_stack when unwinding.

In thumb2 kernel,it fails to identify call_with_stack.
In practice,(u32)&call_with_stack has bit 0 set.

	prel31_to_addr(&idx->addr_offset) is 0x806ed518,
	while (u32)&call_with_stack is 0x806ed519.
So it is impossible to do stack switch.

dump_stack from IRQ stack gets below result:
..
 call_timer_fn from __run_timers+0x163/0x25c
 __run_timers from run_timer_softirq+0x15/0x24
 run_timer_softirq from __do_softirq+0xe3/0x232
 __do_softirq from __irq_exit_rcu+0x3f/0xac
 __irq_exit_rcu from irq_exit+0x7/0xe
 irq_exit from call_with_stack+0xd/0x10
..
The stacktrace ends with call_with_stack.

Since bit 0 of pc in thumb2 is always 0,skip bit 0 when do compraing.
Then we get expected stacktrace:
..
 call_timer_fn from __run_timers+0x163/0x25c
 __run_timers from run_timer_softirq+0x15/0x24
 run_timer_softirq from __do_softirq+0xe3/0x232
 __do_softirq from __irq_exit_rcu+0x3f/0xac
 __irq_exit_rcu from irq_exit+0x7/0xe
 irq_exit from call_with_stack+0xd/0x10
 call_with_stack from __irq_svc+0x93/0xb6
Exception stack(0xf0875f60 to 0xf0875fa8)
5f60: ****
5f80: ****
5fa0: ****
 __irq_svc from arch_local_irq_enable+0x2/0x4
 arch_local_irq_enable from do_idle+0xad/0x1f6
..

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 arch/arm/kernel/unwind.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9d2192156087..89e1f440082c 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -482,7 +482,8 @@ int unwind_frame(struct stackframe *frame)
 
 	ctrl.check_each_pop = 0;
 
-	if (prel31_to_addr(&idx->addr_offset) == (u32)&call_with_stack) {
+	if (prel31_to_addr(&idx->addr_offset) ==
+		((u32)&call_with_stack & (~0x01))) {
 		/*
 		 * call_with_stack() is the only place where we permit SP to
 		 * jump from one stack to another, and since we know it is
-- 
2.18.0


